# Referência técnica — Régua Editorial SieDOE 0.7.4

Use este documento para suporte de segundo nível, diagnóstico, manutenção, atualização e auditoria técnica.

## 1. Identificação

| Componente | Versão / identificação |
|---|---|
| Setup | `1.0.1` |
| Extensão Chrome | `0.7.4` |
| Regras editoriais | `municipios-editorial-rules@1.3.0` |
| Native Helper | `0.1.4` |
| Contrato Native Messaging | `1.2.0` |
| IndexedDB/schema | `3` |
| Manifest | V3 |
| Extension ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Native host | `com.egba.regua_editorial.helper` |
| Canal | `pilot` |

## 2. Instaladores

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
```

O corporativo exige `PartOfDomain = True`. O de homologação local registra override de ambiente e existe apenas para laboratório fora do domínio.

## 3. Manifest V3

A extensão declara:

```text
permissions:
  sidePanel
  activeTab
  tabs
  downloads
  downloads.open
  storage
  nativeMessaging

host_permissions:
  https://egbanet.egba.ba.gov.br/*
```

Content scripts:

```text
https://egbanet.egba.ba.gov.br/admin/materias/edit/*
https://egbanet.egba.ba.gov.br/admin/materias/edicao_restrita/*
```

Arquitetura MV3:

- background service worker em módulo;
- side panel;
- página de relatórios/opções em aba;
- content script somente nas páginas de matéria.

## 4. Diretórios

```text
%ProgramFiles%\EGBA\ReguaEditorial\
%ProgramFiles%\EGBA\ReguaEditorialHelper\
%ProgramData%\EGBA\ReguaEditorial\extension-cache\0.7.4\
%ProgramData%\EGBA\ReguaEditorial\state\
%ProgramData%\EGBA\ReguaEditorial\Logs\
```

## 5. Arquivos de estado

### Instalação

```text
%ProgramData%\EGBA\ReguaEditorial\state\installation.json
```

Registra, entre outros:

- canal;
- update URL;
- modo de bootstrap;
- Extension ID e versão;
- Helper/contrato;
- baseline de build;
- associação ao AD;
- gerenciamento corporativo;
- override de homologação local;
- métodos de gerenciamento detectados;
- diretório de cache;
- Word detectado;
- arquivos validados;
- assinaturas.

### Política Chrome

```text
%ProgramData%\EGBA\ReguaEditorial\state\chrome-policy.json
```

Registra slots usados, valores anteriores, update URL e informações necessárias a reparo/rollback.

## 6. Políticas Chrome

```text
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist
HKLM\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionSettings
```

O instalador:

- procura slot existente pertencente ao Extension ID;
- caso não exista, aloca slot numerado livre;
- preserva valores anteriores;
- grava `installation_mode = force_installed`;
- grava `update_url`;
- habilita override da update URL;
- valida a leitura após a gravação.

Consultar:

```text
chrome://policy
chrome://extensions
```

## 7. Native Messaging

Instalação:

```text
%ProgramFiles%\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe
%ProgramFiles%\EGBA\ReguaEditorialHelper\com.egba.regua_editorial.helper.json
```

Registro:

```text
HKLM\Software\Google\Chrome\NativeMessagingHosts\com.egba.regua_editorial.helper
```

O manifest do host utiliza:

```json
{
  "name": "com.egba.regua_editorial.helper",
  "type": "stdio",
  "allowed_origins": [
    "chrome-extension://chdfbekdjpecdajbpdelmhpemenoelmd/"
  ]
}
```

O registro é criado nas visões 32 e 64 bits.

## 8. Probe do Helper

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe" `
  --probe `
  --workspace "$env:TEMP"
```

Esperado:

```text
helperVersion = 0.1.4
contractVersion = 1.2.0
workspaceWritable = true
available = true
```

`wordDetected` e `wordVersion` dependem da estação.

## 9. Word / DOC / RTF

O Microsoft Word desktop é utilizado somente na conversão automática de DOC e RTF.

Controles esperados:

- instância própria do Word;
- operação invisível;
- documento aberto como somente leitura;
- macros desabilitadas;
- arquivo temporário controlado;
- DOCX resultante validado;
- temporários removidos ao final;
- original não sobrescrito.

DOCX não depende do Word.

## 10. Persistência

Os cálculos ficam no IndexedDB do perfil Chrome associado à extensão.

Características da Entrega 1:

- sem servidor de banco externo;
- armazenamento associado ao perfil e Extension ID;
- dados usados em consultas e relatórios;
- CSV/JSON como exportação;
- conteúdo documental não deve ser persistido pelo banco de cálculos.

Ações de risco:

- limpeza de dados do navegador;
- troca de perfil;
- remoção da extensão;
- troca do Extension ID.

## 11. Verificar AD

```powershell
Get-CimInstance Win32_ComputerSystem |
  Select-Object PartOfDomain, Domain
```

O instalador corporativo atual exige:

```text
PartOfDomain : True
```

O detector também registra Entra ID e Chrome Enterprise Core para diagnóstico, mas esses sinais não substituem o requisito explícito de AD do artefato corporativo desta Release.

## 12. Verificar Chrome

```powershell
$candidates = @(
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
  "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)

$candidates | Where-Object { $_ -and (Test-Path $_ -PathType Leaf) }
```

## 13. Verificar arquivos

```powershell
Test-Path "$env:ProgramFiles\EGBA\ReguaEditorial\release-manifest.json"
Test-Path "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\state\installation.json"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\state\chrome-policy.json"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\Logs\install.log"
```

## 14. Logs

```text
%ProgramData%\EGBA\ReguaEditorial\Logs\install.log
%ProgramData%\EGBA\ReguaEditorial\Logs\uninstall.log
```

Últimas linhas:

```powershell
Get-Content 'C:\ProgramData\EGBA\ReguaEditorial\Logs\install.log' -Tail 150
```

Os scripts runtime são empacotados em UTF-8 com BOM para compatibilidade de acentuação com Windows PowerShell 5.1.

## 15. Manifesto de Release instalado

```powershell
$Manifest = Get-Content `
  "$env:ProgramFiles\EGBA\ReguaEditorial\release-manifest.json" `
  -Raw | ConvertFrom-Json

$Manifest | Format-List
```

Use o manifesto para confirmar:

- setupVersion;
- extensionVersion;
- extensionId;
- baselineCommit;
- bootstrapMode;
- localHomologationArtifact;
- signer;
- certificateThumbprint;
- certificateNotAfter;
- signingMode.

## 16. Certificado do piloto

Repositórios:

```text
Cert:\LocalMachine\Root
Cert:\LocalMachine\TrustedPublisher
```

Confirme sempre pelo thumbprint registrado no manifesto final, nunca apenas pelo Subject.

```powershell
Get-ChildItem Cert:\LocalMachine\Root, Cert:\LocalMachine\TrustedPublisher |
  Where-Object { $_.Thumbprint -eq $Manifest.certificateThumbprint } |
  Select-Object Subject, Thumbprint, NotAfter, PSParentPath
```

## 17. Bootstrap local

O piloto standalone mantém CRX e `update.xml` em:

```text
%ProgramData%\EGBA\ReguaEditorial\extension-cache\0.7.4\
```

A política aponta para manifesto `file://` gerado a partir desse cache.

A atualização futura poderá migrar para HTTPS corporativo preservando a mesma identidade.

## 18. Diagnóstico por código

| Código / sintoma | Hipótese inicial |
|---|---|
| `ACTIVE_DIRECTORY_REQUIRED` | pacote corporativo em máquina fora do domínio |
| `EXTENSION_MANAGEMENT_REQUIRED` | probe de gerenciamento não aceitou o ambiente |
| `EXTENSION_ID_DIVERGENCE` | pacote/identidade divergente |
| `INVALID_AUTHENTICODE_SIGNATURE` | assinatura ausente/inválida ou confiança inadequada |
| `HELPER_INSTALLATION_FAILED` | falha na instalação do Helper |
| `HELPER_PROBE_FAILED` | Helper instalado mas incapaz de responder ao probe |
| `CHROME_POLICY_APPLICATION_FAILED` | política não gravada/validada |
| extensão não aparece | Chrome não reiniciado, política/cache incorreto |
| registros ausentes | perfil diferente, limpeza de dados ou ID alterado |
| DOCX funciona e DOC/RTF falha | problema concentrado em Word/Helper |

## 19. Reparo

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorial\Repair-ReguaEditorial.ps1" `
  -PackageRoot "$env:ProgramFiles\EGBA\ReguaEditorial"
```

O reparo não deve trocar Extension ID nem limpar IndexedDB.

## 20. Remoção

### Padrão

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorial\Uninstall.exe"
```

A remoção padrão deve evitar a exclusão destrutiva do armazenamento do Chrome.

### Integral

Somente após exportar registros ou autorizar descarte. Consulte [04 — Plano de rollback](04-PLANO-DE-ROLLBACK.md).

## 21. Atualização

Preservar obrigatoriamente:

- PEM institucional da extensão;
- Extension ID;
- compatibilidade Native Messaging;
- migrações de IndexedDB;
- dados locais;
- pacote anterior para rollback.

Consulte [13 — Atualização e continuidade](13-ATUALIZACAO-E-CONTINUIDADE.md).
