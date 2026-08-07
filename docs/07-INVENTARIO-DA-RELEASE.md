# Inventário da Release — Entrega 1.0.1

Este documento registra a composição da entrega e os dados necessários para auditoria, suporte e rastreabilidade.

## 1. Identificação

| Campo | Valor |
|---|---|
| Produto | Régua Editorial SieDOE — Municípios à Vista |
| Release | `v1.0.1-pilot.1` |
| Canal | `pilot` |
| Data da revisão | 7 de agosto de 2026 |
| Instalador | `1.0.1` |
| Extensão | `0.7.4` |
| Regras editoriais | `municipios-editorial-rules@1.3.0` |
| Native Helper | `0.1.4` |
| Contrato Native Messaging | `1.2.0` |
| IndexedDB/schema | `3` |
| Extension ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Native host | `com.egba.regua_editorial.helper` |
| Repositório de distribuição | `guedesle/regua-municipios-a-vista` |
| Repositório de desenvolvimento | `guedesle/calculadora-editorial` |

## 2. Ativos da Release

| Arquivo | Finalidade | Requisito ambiental |
|---|---|---|
| `ReguaEditorial-Entrega1-Corporativo-x64.exe` | implantação institucional | estação no Active Directory |
| `ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256` | integridade do instalador corporativo | — |
| `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe` | laboratório fora do domínio | Windows x64 + Chrome |
| `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256` | integridade do instalador local | — |

Os dois executáveis devem possuir SHA-256 diferentes.

## 3. Estado de publicação

Preencha esta seção somente com dados obtidos dos artefatos finais que passaram pelo QA e foram efetivamente publicados.

| Campo | Corporativo | Homologação local |
|---|---|---|
| SHA-256 | **preencher após publicação** | **preencher após publicação** |
| Tamanho em bytes | **preencher** | **preencher** |
| Tamanho em MiB | **preencher** | **preencher** |
| Assinatura | **preencher** | **preencher** |
| Thumbprint | **preencher do manifesto final** | **preencher do manifesto final** |
| Download pós-publicação validado | **pendente** | **pendente** |

Não copie hashes de builds descartados ou intermediários.

## 4. Gate técnico anterior à publicação

A publicação exige evidência de:

```text
BOTH_INSTALLERS_READY
BOTH_ARTIFACTS_QA_PASSED
```

O QA deve confirmar, no mínimo:

- Setup `1.0.1`;
- extensão `0.7.4`;
- regras `1.3.0`;
- Extension ID operacional;
- hashes coerentes;
- assinaturas aceitáveis no contexto do piloto;
- dois instaladores distintos;
- modo de homologação local presente somente no artefato correspondente;
- scripts runtime compatíveis com Windows PowerShell 5.1/UTF-8.

## 5. Registrar tamanho e SHA-256 depois do download

```powershell
$Files = @(
  '.\ReguaEditorial-Entrega1-Corporativo-x64.exe',
  '.\ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe'
)

$Files | ForEach-Object {
  $Setup = $_
  $HashFile = "$Setup.sha256"
  $Actual = (Get-FileHash $Setup -Algorithm SHA256).Hash.ToLowerInvariant()
  $Expected = ((Get-Content $HashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
  if ($Actual -ne $Expected) { throw "HASH_DIVERGENTE:$Setup" }

  $Item = Get-Item $Setup
  [pscustomobject]@{
    File = $Item.Name
    Sha256 = $Actual
    SizeBytes = $Item.Length
    SizeMiB = [math]::Round($Item.Length / 1MB, 2)
  }
}
```

## 6. Manifesto instalado

Cada instalação contém:

```text
%ProgramFiles%\EGBA\ReguaEditorial\release-manifest.json
```

O manifesto é a fonte técnica para:

- versão;
- Extension ID;
- baseline de build;
- assinatura;
- thumbprint;
- validade do certificado;
- modo de bootstrap;
- indicação de artefato de homologação local.

Exemplo:

```powershell
$ManifestPath = "$env:ProgramFiles\EGBA\ReguaEditorial\release-manifest.json"
$Manifest = Get-Content $ManifestPath -Raw | ConvertFrom-Json

$Manifest | Select-Object `
  setupVersion,
  extensionVersion,
  extensionId,
  baselineCommit,
  signer,
  certificateThumbprint,
  certificateNotAfter,
  signingMode,
  localHomologationArtifact
```

## 7. Certificado do piloto

Não documente o thumbprint por estimativa. Leia-o do `release-manifest.json` do artefato final e confirme nos repositórios:

```powershell
Get-ChildItem Cert:\LocalMachine\Root, Cert:\LocalMachine\TrustedPublisher |
  Where-Object { $_.Thumbprint -eq $Manifest.certificateThumbprint } |
  Select-Object Subject, Thumbprint, NotAfter, PSParentPath
```

## 8. Materiais proibidos

Não versionar nem anexar à Release:

- PEM/PFX/P12/KEY ou outras chaves privadas;
- senha ou token;
- `artifacts`, `staging`, `helper-build`, `extension-build` ou `node_modules`;
- código-fonte da aplicação;
- documentos de produção;
- dumps de perfil Chrome/IndexedDB;
- logs com dados operacionais desnecessários.

## 9. Evidências da implantação

Registrar separadamente:

- responsável pelo upload;
- data/hora;
- estação ou lote de homologação;
- resultado do download de conferência;
- aceite técnico;
- aceite funcional;
- lote/OU/grupo liberado para implantação;
- incidentes ou ressalvas.

## 10. Encerramento

O inventário é considerado encerrado quando:

- os quatro ativos estiverem publicados;
- hashes e tamanhos forem transcritos dos arquivos finais;
- download pós-publicação tiver sido validado;
- assinatura/thumbprint forem registrados;
- homologação técnica e funcional estiverem aprovadas;
- a decisão de ampliar o piloto estiver registrada.
