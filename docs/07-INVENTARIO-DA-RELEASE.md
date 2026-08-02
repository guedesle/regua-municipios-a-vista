# Inventário da Release — Entrega 1

## Identificação

| Campo | Valor |
|---|---|
| Produto | Régua Editorial SieDOE — Municípios à Vista |
| Tag recomendada | `v1.0.0-pilot.1` |
| Canal | `pilot` |
| Setup | `1.0.0` |
| Extensão | `0.7.3` |
| Helper | `0.1.4` |
| Contrato Native Messaging | `1.2.0` |
| IndexedDB/schema | `3` |
| Extension ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Native host | `com.egba.regua_editorial.helper` |
| Baseline funcional | `38d68dc6aa16c23cd03d33f40ce2b806f531cc62` |

## Ativos esperados

| Arquivo | Finalidade |
|---|---|
| `ReguaEditorial-Entrega1-Setup-x64.exe` | instalação completa em Windows x64 |
| `ReguaEditorial-Entrega1-Setup-x64.exe.sha256` | verificação de integridade |

## Dados a preencher após a publicação

| Campo | Valor |
|---|---|
| Data da Release | `PREENCHER` |
| Commit deste repositório | `PREENCHER` |
| Tamanho do Setup | `PREENCHER` |
| SHA-256 do Setup | `PREENCHER` |
| Responsável pelo upload | `PREENCHER` |
| Resultado da conferência pós-upload | `PREENCHER` |
| Estações homologadas | `PREENCHER` |
| Aceite GERDO | `PREENCHER` |
| Aceite GERINF/TI | `PREENCHER` |

## Restrições

A Release não pode conter:

- PEM privada;
- PFX, P12, KEY ou senha de certificado;
- diretórios `artifacts`, `staging`, `helper-build`, `extension-build` ou `crx-test`;
- código-fonte;
- documentos ou dados de produção;
- credenciais, cookies ou tokens.

## Conferência pós-upload

Depois de baixar novamente os dois ativos da Release em uma pasta temporária:

```powershell
$Setup = '.\ReguaEditorial-Entrega1-Setup-x64.exe'
$HashFile = '.\ReguaEditorial-Entrega1-Setup-x64.exe.sha256'

$Actual = (Get-FileHash $Setup -Algorithm SHA256).Hash.ToLowerInvariant()
$Expected = ((Get-Content $HashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()

if ($Actual -ne $Expected) {
    throw "RELEASE_HASH_DIVERGENTE"
}

Write-Host "Release validada: $Actual"
```

A Release somente deve ser comunicada à equipe após essa conferência.