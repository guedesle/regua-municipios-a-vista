# Guia de instalação para a equipe de TI

Este guia orienta a instalação, a validação inicial e a entrega da **Régua Editorial SieDOE 0.7.4** em Windows x64.

## 1. Escolher o instalador correto

A Release `v1.0.1-pilot.1` publica dois instaladores.

### Corporativo

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256
```

Use em estação corporativa vinculada ao Active Directory. Nesta entrega o requisito é explícito:

```powershell
(Get-CimInstance Win32_ComputerSystem).PartOfDomain
```

Resultado obrigatório:

```text
True
```

### Homologação local

```text
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256
```

Use somente para laboratório fora do domínio. Ele ignora o gate de gerenciamento/AD, mas continua validando integridade, assinaturas, versão, arquitetura, Helper e políticas Chrome.

> [!WARNING]
> Não use o instalador de homologação local como pacote institucional de produção.

## 2. Pré-requisitos

| Requisito | Corporativo | Homologação local |
|---|---:|---:|
| Windows x64 | obrigatório | obrigatório |
| Google Chrome | obrigatório | obrigatório |
| privilégio administrativo | obrigatório na instalação | obrigatório na instalação |
| Active Directory | obrigatório | não obrigatório |
| Microsoft Word desktop | somente para DOC/RTF | somente para DOC/RTF |
| .NET Runtime separado | não | não |

O Native Helper `0.1.4` é self-contained. DOCX, cálculos, consultas e relatórios não dependem do Word.

## 3. Validar a integridade

Baixe o `.exe` e o `.sha256` de mesmo nome. Exemplo para o instalador corporativo:

```powershell
$Setup = '.\ReguaEditorial-Entrega1-Corporativo-x64.exe'
$HashFile = "$Setup.sha256"

$Actual = (Get-FileHash $Setup -Algorithm SHA256).Hash.ToLowerInvariant()
$Expected = ((Get-Content $HashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()

if ($Actual -ne $Expected) {
    throw "HASH_DIVERGENTE: esperado=$Expected obtido=$Actual"
}

"Integridade confirmada: $Actual"
```

Para homologação local, troque apenas o nome do arquivo.

> [!CAUTION]
> Não execute o pacote se o hash divergir. Baixe novamente da Release privada oficial e investigue qualquer repetição da divergência.

## 4. Assinatura do piloto

A pré-release utiliza certificado temporário de laboratório. O primeiro UAC pode mostrar **Editor desconhecido** antes que o certificado público incorporado seja adicionado aos repositórios da estação.

Prossiga somente quando:

- o SHA-256 estiver correto;
- a origem for a Release privada oficial;
- o nome do arquivo corresponder ao tipo de estação;
- a implantação estiver autorizada.

O canal `stable` deverá usar assinatura corporativa reconhecida.

## 5. Instalar interativamente

1. copie o `.exe` e o `.sha256` para disco local;
2. valide o hash;
3. feche todas as janelas do Chrome;
4. confirme que não há `chrome.exe` em execução;
5. execute o instalador como administrador;
6. aguarde a validação dos componentes;
7. conclua o assistente;
8. reabra o Chrome;
9. acesse `chrome://policy` e clique em **Recarregar políticas**;
10. acesse `chrome://extensions` e confirme a extensão.

Comando opcional:

```powershell
Get-Process chrome -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Process '.\ReguaEditorial-Entrega1-Corporativo-x64.exe' -Verb RunAs -Wait
```

## 6. Resultado técnico esperado

### Extensão

```text
Nome: Régua Editorial SieDOE
Versão: 0.7.4
ID: chdfbekdjpecdajbpdelmhpemenoelmd
Manifest: V3
```

### Helper

```text
%ProgramFiles%\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe
```

### Pacote administrativo

```text
%ProgramFiles%\EGBA\ReguaEditorial\
```

### Cache, estado e logs

```text
%ProgramData%\EGBA\ReguaEditorial\extension-cache\0.7.4\
%ProgramData%\EGBA\ReguaEditorial\state\
%ProgramData%\EGBA\ReguaEditorial\Logs\
```

### Políticas Chrome

```text
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist
HKLM\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionSettings
```

### Native Messaging

```text
HKLM\Software\Google\Chrome\NativeMessagingHosts\com.egba.regua_editorial.helper
```

O registro é instalado por máquina nas visões de Registro 32 e 64 bits.

## 7. Validar arquivos e estado

```powershell
Test-Path "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\state\installation.json"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\state\chrome-policy.json"
```

Depois de uma instalação concluída, os três resultados devem ser `True`.

Leia o estado:

```powershell
Get-Content "$env:ProgramData\EGBA\ReguaEditorial\state\installation.json" -Raw
```

## 8. Validar o Helper

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe" `
  --probe `
  --workspace "$env:TEMP"
```

Esperado:

```text
helperVersion: 0.1.4
contractVersion: 1.2.0
workspaceWritable: true
available: true
```

`wordDetected` pode ser `false` em estações que não utilizam DOC/RTF.

## 9. Validar o Chrome

Em `chrome://policy`, confirme a existência e o valor esperado de:

- `ExtensionInstallForcelist`;
- `NativeMessagingAllowlist`;
- `ExtensionSettings`.

Em `chrome://extensions`, confirme:

| Campo | Valor esperado |
|---|---|
| Nome | Régua Editorial SieDOE |
| Versão | `0.7.4` |
| ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Instalação | gerenciada |

O artefato de homologação local também aplica políticas HKLM para reproduzir o comportamento da extensão instalada de forma gerenciada.

## 10. Teste funcional mínimo

1. abra uma matéria compatível no EGBANET;
2. abra a Régua Editorial pelo ícone da extensão;
3. confirme protocolo, cliente e identificação da matéria;
4. processe um DOCX de teste;
5. confirme prévia, medição e cálculo;
6. salve o cálculo;
7. recupere o registro na consulta;
8. gere relatório;
9. exporte CSV;
10. feche e reabra completamente o Chrome e confirme persistência.

Com Word instalado, teste também DOC e RTF.

## 11. Instalação silenciosa / distribuição centralizada

O Setup é NSIS e pode ser executado silenciosamente com `/S`. Antes de implantação em massa, valide o comportamento silencioso na OU/grupo piloto.

Exemplo:

```powershell
Start-Process `
  '.\ReguaEditorial-Entrega1-Corporativo-x64.exe' `
  -ArgumentList '/S' `
  -Wait
```

Para AD/GPO, prefira copiar o instalador para disco local antes de executar e use grupo de segurança/OU piloto. Consulte [12 — Distribuição corporativa AD/GPO](12-DISTRIBUICAO-CORPORATIVA-AD-GPO.md).

## 12. Logs e diagnóstico

Log principal:

```text
C:\ProgramData\EGBA\ReguaEditorial\Logs\install.log
```

Últimas linhas:

```powershell
Get-Content 'C:\ProgramData\EGBA\ReguaEditorial\Logs\install.log' -Tail 150
```

Códigos relevantes incluem:

| Código | Significado inicial |
|---|---|
| `ACTIVE_DIRECTORY_REQUIRED` | instalador corporativo executado fora do domínio |
| `EXTENSION_MANAGEMENT_REQUIRED` | probe de gerenciamento não aceitou o ambiente |
| `EXTENSION_ID_DIVERGENCE` | identidade do pacote divergente |
| `INVALID_AUTHENTICODE_SIGNATURE` | componente sem assinatura válida ou confiança inadequada |
| `HELPER_INSTALLATION_FAILED` | falha ao instalar o Native Helper |
| `CHROME_POLICY_APPLICATION_FAILED` | falha ao gravar/validar políticas |

## 13. Reparar

Feche o Chrome e execute PowerShell elevado:

```powershell
$InstallRoot = "$env:ProgramFiles\EGBA\ReguaEditorial"

& "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe" `
  -NoProfile `
  -ExecutionPolicy Bypass `
  -File "$InstallRoot\Repair-ReguaEditorial.ps1" `
  -PackageRoot $InstallRoot
```

Depois confirme Helper, políticas, extensão e persistência dos cálculos.

## 14. Remover

Use **Configurações > Aplicativos** ou:

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorial\Uninstall.exe"
```

A remoção padrão deve preservar a extensão e seu armazenamento local. A remoção integral exige procedimento específico e confirmação de preservação/descarte de dados. Consulte [04 — Plano de rollback](04-PLANO-DE-ROLLBACK.md).

## 15. Orientação ao usuário

Antes de encerrar a implantação:

- fixar a extensão no Chrome, se necessário;
- usar sempre o mesmo perfil;
- não limpar dados do navegador sem orientação;
- não ativar modo desenvolvedor;
- revisar prévia, medição e valor antes de salvar;
- registrar a mensagem exata em caso de falha;
- consultar o [Guia rápido de uso](08-GUIA-RAPIDO-DE-USO.md).
