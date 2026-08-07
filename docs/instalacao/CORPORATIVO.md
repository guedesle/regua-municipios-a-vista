# Instalação corporativa

Use este procedimento em estação Windows x64 ingressada no Active Directory.

## Arquivos

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256
```

Os arquivos podem estar na pasta versionada `distribuicao/v1.0.1-pilot.1/` e na Release `v1.0.1-pilot.1`.

## Pré-requisitos

- Windows x64;
- Google Chrome;
- privilégio administrativo durante a instalação;
- `PartOfDomain = True`;
- Microsoft Word desktop somente para conversão automática de DOC/RTF.

Verifique o domínio:

```powershell
Get-CimInstance Win32_ComputerSystem |
  Select-Object PartOfDomain, Domain
```

## 1. Validar o SHA-256

Na pasta do instalador:

```powershell
$Setup = '.\ReguaEditorial-Entrega1-Corporativo-x64.exe'
$HashFile = "$Setup.sha256"
$Actual = (Get-FileHash $Setup -Algorithm SHA256).Hash.ToLowerInvariant()
$Expected = ((Get-Content $HashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
if ($Actual -ne $Expected) { throw "HASH_DIVERGENTE: $Actual" }
"SHA-256 validado: $Actual"
```

Não execute se houver divergência.

## 2. Instalar

1. Feche completamente o Chrome.
2. Execute o instalador como administrador.
3. Aguarde a conclusão do Setup.
4. Reabra o Chrome.
5. Em `chrome://policy`, clique em **Recarregar políticas**.
6. Em `chrome://extensions`, confirme a extensão.

PowerShell:

```powershell
Start-Process '.\ReguaEditorial-Entrega1-Corporativo-x64.exe' -Verb RunAs -Wait
```

## 3. Resultado esperado

Em `chrome://extensions`:

| Campo | Esperado |
|---|---|
| Nome | Régua Editorial SieDOE |
| Versão | `0.7.4` |
| ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Estado | gerenciada pela organização |

No Windows:

```powershell
Test-Path "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\state\installation.json"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\state\chrome-policy.json"
```

Os três resultados devem ser `True`.

## 4. Validar o Helper

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe" `
  --probe --workspace "$env:TEMP"
```

Esperado: Helper `0.1.4`, contrato `1.2.0`, `workspaceWritable = true` e `available = true`.

## 5. Teste funcional mínimo

1. Abra uma matéria compatível no EGBANET.
2. Abra a Régua pelo ícone do Chrome.
3. Processe um DOCX sintético/controlado.
4. Confira prévia, medição e valor.
5. Salve o cálculo.
6. Localize o registro em consultas/relatórios.
7. Feche e reabra o Chrome e confirme a persistência.
8. Se a estação usa DOC/RTF, teste também a conversão com Word.

## Implantação em lote

Para Startup Script/GPO, consulte [AD-GPO.md](AD-GPO.md). O script pronto está em `scripts/implantacao/Instalar-Corporativo-GPO.ps1`.

## Em caso de falha

Consulte [Suporte e diagnóstico](../uso/SUPORTE.md). Log principal:

```text
C:\ProgramData\EGBA\ReguaEditorial\Logs\install.log
```

> O piloto usa certificado temporário de laboratório. Valide sempre o SHA-256 e a origem do pacote. O canal estável exige assinatura corporativa reconhecida.