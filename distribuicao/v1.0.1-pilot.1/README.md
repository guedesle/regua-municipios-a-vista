# Régua Editorial SieDOE — Entrega 1.0.1

Extensão Chrome: **0.7.4**

Extension ID:

`chdfbekdjpecdajbpdelmhpemenoelmd`

## Instaladores

### Ambiente corporativo / Active Directory

`ReguaEditorial-Entrega1-Corporativo-x64.exe`

Usar nas estações corporativas ingressadas no domínio.

### Homologação local

`ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe`

Usar somente em laboratório ou homologação fora do Active Directory.

## Antes de instalar

Sempre valide o arquivo `.sha256` correspondente ao executável.

## Documentação incluída

1. `01-GUIA-DE-INSTALACAO.md`
2. `02-GUIA-DE-HOMOLOGACAO.md`
3. `03-GUIA-DE-USO.md`
4. `04-REFERENCIA-TECNICA.md`
5. `05-ESPECIFICACAO-DA-EXTENSAO.md`
6. `06-DISTRIBUICAO-AD-GPO.md`
7. `07-ATUALIZACAO-E-CONTINUIDADE.md`
8. `08-SEGURANCA.md`

## Implantação automatizada

`.\scripts\Instalar-Corporativo-GPO.ps1`

é destinado à equipe de TI para implantação por Startup Script/GPO ou ferramenta corporativa equivalente.

## Segurança

Nunca distribuir junto com este pacote:

- PEM privada da extensão;
- PFX/P12/KEY;
- senhas ou tokens;
- arquivos de produção;
- banco IndexedDB de usuários.
