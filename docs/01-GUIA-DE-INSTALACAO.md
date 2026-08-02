# Guia de instalação — Entrega 1

## 1. Pacote

Utilizar exclusivamente os arquivos da Release privada aprovada:

```text
ReguaEditorial-Entrega1-Setup-x64.exe
ReguaEditorial-Entrega1-Setup-x64.exe.sha256
```

Versões da entrega:

- Setup: `1.0.0`;
- extensão: `0.7.3`;
- Helper: `0.1.4`;
- contrato Native Messaging: `1.2.0`;
- Extension ID: `chdfbekdjpecdajbpdelmhpemenoelmd`.

## 2. Pré-requisitos

- Windows x64;
- Google Chrome instalado;
- estação associada ao Active Directory da empresa;
- credencial administrativa para implantação;
- Microsoft Word desktop para DOC e RTF automáticos.

A ausência do Word não impede o uso de DOCX, cálculos e relatórios.

## 3. Conferência do hash

No PowerShell, na pasta onde os dois arquivos foram baixados:

```powershell
$Setup = '.\ReguaEditorial-Entrega1-Setup-x64.exe'
$HashFile = '.\ReguaEditorial-Entrega1-Setup-x64.exe.sha256'

$Actual = (Get-FileHash $Setup -Algorithm SHA256).Hash.ToLowerInvariant()
$Expected = ((Get-Content $HashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()

if ($Actual -ne $Expected) {
    throw "HASH_DIVERGENTE: esperado $Expected; obtido $Actual"
}

Write-Host "SHA-256 validado: $Actual"
```

Não executar o instalador se os valores divergirem.

## 4. Instalação assistida

1. copiar o Setup para disco local;
2. fechar completamente o Chrome;
3. executar o `.exe` como administrador;
4. acompanhar o log de instalação;
5. concluir o assistente;
6. reabrir o Chrome;
7. acessar `chrome://policy` e recarregar as políticas;
8. acessar `chrome://extensions` e confirmar a extensão gerenciada.

## 5. Resultado esperado

### Helper

```text
%ProgramFiles%\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe
```

### Aplicação e scripts administrativos

```text
%ProgramFiles%\EGBA\ReguaEditorial\
```

### Cache da extensão

```text
%ProgramData%\EGBA\ReguaEditorial\extension-cache\0.7.3\
```

### Estado e logs

```text
%ProgramData%\EGBA\ReguaEditorial\state\
%ProgramData%\EGBA\ReguaEditorial\Logs\
```

## 6. Conferência técnica

### Active Directory

```powershell
Get-CimInstance Win32_ComputerSystem |
  Select-Object PartOfDomain, Domain
```

Resultado obrigatório:

```text
PartOfDomain : True
```

### Helper

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe" `
  --probe `
  --workspace "$env:TEMP"
```

Confirmar:

- `helperVersion` igual a `0.1.4`;
- `contractVersion` igual a `1.2.0`;
- workspace gravável;
- detecção do Word, quando instalado.

### Chrome

Em `chrome://extensions`, confirmar:

- nome `Régua Editorial SieDOE`;
- versão `0.7.3`;
- ID `chdfbekdjpecdajbpdelmhpemenoelmd`;
- instalação gerenciada;
- ausência de modo desenvolvedor.

## 7. Falhas principais

### `ACTIVE_DIRECTORY_REQUIRED`

A estação não está reconhecida como associada ao domínio. Interromper e solicitar regularização à TI.

### Extensão não aparece

- fechar todos os processos do Chrome;
- reabrir o navegador;
- recarregar `chrome://policy`;
- verificar o cache em `%ProgramData%`;
- verificar se as políticas contêm o ID operacional.

### Helper não localizado

Executar reparo pelo item instalado em Aplicativos ou pelo script administrativo dentro de `%ProgramFiles%\EGBA\ReguaEditorial`.

### Word ausente

DOCX e relatórios continuam disponíveis. DOC e RTF automáticos dependem do Word desktop instalado, licenciado e inicializado.