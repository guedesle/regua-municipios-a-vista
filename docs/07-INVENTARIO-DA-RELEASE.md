# Inventário da Release — Entrega 1

Este documento registra a composição da entrega e os dados necessários para auditoria e suporte.

## 1. Identificação

| Campo | Valor |
|---|---|
| Produto | Régua Editorial SieDOE — Municípios à Vista |
| Release | `v1.0.0-pilot.1` |
| Canal | `pilot` |
| Data inicial da publicação | 1º de agosto de 2026 |
| Instalador | `1.0.0` |
| Extensão | `0.7.3` |
| Programa auxiliar do Windows | `0.1.4` |
| Comunicação local | `1.2.0` |
| Estrutura do armazenamento local | `3` |
| ID da extensão | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Identificador do programa auxiliar | `com.egba.regua_editorial.helper` |
| Repositório de distribuição | `guedesle/regua-municipios-a-vista` |
| Repositório de desenvolvimento | `guedesle/calculadora-editorial` |

## 2. Arquivos publicados

| Arquivo | Finalidade | Situação |
|---|---|---|
| `ReguaEditorial-Entrega1-Setup-x64.exe` | instalação completa em Windows x64 | publicado na Release |
| `ReguaEditorial-Entrega1-Setup-x64.exe.sha256` | verificação da integridade do instalador | publicado na Release |

## 3. Registro pós-publicação

Os campos abaixo devem ser completados pela equipe que publicou e validou os ativos. Enquanto algum campo permanecer pendente, o inventário documental não está encerrado.

| Campo | Situação atual |
|---|---|
| SHA-256 do instalador | **Pendente de transcrição do arquivo `.sha256`** |
| Tamanho do instalador | **Pendente de registro** |
| Responsável pelo upload | **Pendente de registro** |
| Resultado da conferência após novo download | **Pendente de registro** |
| Thumbprint do certificado temporário | **Pendente de registro** |
| Estações homologadas | **Pendente após homologação** |
| Aceite funcional da GERDO | **Pendente após homologação** |
| Aceite técnico da TI | **Pendente após homologação** |

> [!IMPORTANT]
> Esses itens são pendências documentais, não devem ser substituídos por estimativas. Copie os valores diretamente dos arquivos e das evidências da homologação.

## 4. Obter tamanho e SHA-256

Depois de baixar novamente os ativos da Release:

```powershell
$Setup = '.\ReguaEditorial-Entrega1-Setup-x64.exe'
$HashFile = '.\ReguaEditorial-Entrega1-Setup-x64.exe.sha256'

$Actual = (Get-FileHash $Setup -Algorithm SHA256).Hash.ToLowerInvariant()
$Expected = ((Get-Content $HashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
$SizeBytes = (Get-Item $Setup).Length
$SizeMB = [math]::Round($SizeBytes / 1MB, 2)

if ($Actual -ne $Expected) {
    throw "RELEASE_HASH_DIVERGENTE"
}

[pscustomobject]@{
    Sha256 = $Actual
    SizeBytes = $SizeBytes
    SizeMB = $SizeMB
}
```

Transcreva o resultado na seção anterior e registre o responsável pela conferência.

## 5. Identificar o certificado do piloto

O instalador usa certificado temporário de laboratório. Para listar certificados relacionados, sem removê-los:

```powershell
Get-ChildItem Cert:\LocalMachine\Root, Cert:\LocalMachine\TrustedPublisher |
  Where-Object { $_.Subject -eq 'CN=Empresa Grafica da Bahia' } |
  Select-Object Subject, Thumbprint, NotAfter, PSParentPath
```

Compare o thumbprint com o manifesto da Release instalada antes de registrar ou remover qualquer certificado.

## 6. Materiais proibidos

A Release e este repositório não podem conter:

- chave privada PEM;
- PFX, P12, KEY ou senha de certificado;
- pastas intermediárias como `artifacts`, `staging`, `helper-build`, `extension-build` ou `crx-test`;
- código-fonte da aplicação;
- documentos ou dados de produção;
- credenciais, cookies ou tokens.

## 7. Encerramento do inventário

O inventário é considerado completo quando:

- tamanho e SHA-256 estiverem registrados;
- novo download da Release tiver sido validado;
- thumbprint do certificado estiver registrado;
- estações homologadas estiverem relacionadas;
- aceites funcional e técnico estiverem registrados.