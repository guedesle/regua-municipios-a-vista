# Entrega 1 — Piloto operacional 1.0.1

Pré-release interna da **Régua Editorial SieDOE — Municípios à Vista** para implantação controlada.

## Versões

| Componente | Versão |
|---|---|
| Setup | `1.0.1` |
| Extensão Chrome | `0.7.4` |
| Regras editoriais | `municipios-editorial-rules@1.3.0` |
| Native Helper | `0.1.4` |
| Contrato Native Messaging | `1.2.0` |
| IndexedDB/schema | `3` |
| Canal | `pilot` |

```text
Extension ID: chdfbekdjpecdajbpdelmhpemenoelmd
Native host:  com.egba.regua_editorial.helper
```

## Alteração editorial da 0.7.4

- conteúdo base: Arial 6 pt / entrelinha 8 pt;
- negrito secundário: Arial Bold 6 pt / entrelinha 8 pt;
- trecho canônico: Arial Bold 8 pt / entrelinha 8 pt / caixa alta;
- vazio interno normalizado: 8 pt;
- tarja: regra preservada;
- tarifa e fórmula de cálculo: inalteradas.

A mudança de entrelinha pode alterar a geometria do documento e, consequentemente, altura/cm-cl e valor quando a ocupação final se modificar.

## Ativos da Release

### Instalação corporativa

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256
```

Uso: estações corporativas do Active Directory.

Requisito desta entrega:

```text
Win32_ComputerSystem.PartOfDomain = True
```

### Homologação local

```text
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256
```

Uso: laboratório fora do domínio.

Esse instalador ignora exclusivamente o gate de gerenciamento/AD. Continuam obrigatórios:

- SHA-256;
- validação de assinatura dos componentes;
- versão e identidade;
- arquitetura x64;
- Native Helper;
- políticas Chrome;
- Extension ID operacional.

> [!WARNING]
> O artefato de homologação local não substitui o instalador corporativo para rollout institucional.

## Correções da cadeia de instalação

A linha 1.0.1 inclui correções no empacotamento e no fluxo de instalação identificadas durante a homologação do Setup:

- sincronização dos metadados internos com extensão `0.7.4`;
- correção da chamada NSIS → Windows PowerShell para parâmetros booleanos;
- tratamento correto do modo de homologação local em todos os gates de política;
- normalização de scripts runtime para UTF-8 com BOM, evitando mojibake no Windows PowerShell 5.1;
- separação física dos builds corporativo e de homologação local;
- QA conjunto dos dois artefatos;
- validação de que os dois instaladores são distintos.

## Instalação resumida

1. escolha o instalador correto;
2. baixe `.exe` e `.sha256` de mesmo nome;
3. valide o SHA-256;
4. feche completamente o Chrome;
5. execute como administrador;
6. reabra o Chrome;
7. recarregue `chrome://policy`;
8. confirme a extensão em `chrome://extensions`;
9. execute a homologação funcional.

## Requisitos comuns

- Windows x64;
- Google Chrome;
- privilégio administrativo durante a instalação;
- Word desktop somente para DOC/RTF.

O Helper é self-contained; não é necessário instalar .NET Runtime separadamente.

## Assinatura do piloto

> [!WARNING]
> A pré-release utiliza certificado temporário de laboratório. O primeiro UAC pode apresentar **Editor desconhecido** antes que o certificado público do pacote seja confiado. Execute somente após validar SHA-256 e origem.

O canal `stable` depende de assinatura corporativa reconhecida.

## Gate de publicação

Os binários finais só devem ser anexados depois de:

```text
BOTH_INSTALLERS_READY
BOTH_ARTIFACTS_QA_PASSED
```

Após o upload, faça novo download dos quatro ativos e confira novamente os hashes antes de registrar o inventário como encerrado.

## Documentação corporativa

- [Guia de instalação](docs/01-GUIA-DE-INSTALACAO.md)
- [Guia de homologação](docs/02-GUIA-DE-HOMOLOGACAO.md)
- [Arquitetura de distribuição](docs/05-ARQUITETURA-DE-DISTRIBUICAO.md)
- [Referência técnica](docs/09-REFERENCIA-TECNICA.md)
- [Especificação técnica da extensão](docs/11-ESPECIFICACAO-TECNICA-EXTENSAO.md)
- [Distribuição corporativa AD/GPO](docs/12-DISTRIBUICAO-CORPORATIVA-AD-GPO.md)
- [Atualização e continuidade](docs/13-ATUALIZACAO-E-CONTINUIDADE.md)
- [Política de segurança](SECURITY.md)

## Situação

A mudança editorial 0.7.4 foi homologada em 07/08/2026. A publicação dos Setups permanece classificada como **pré-release de piloto interno**, sujeita ao gate de artefatos e à homologação técnica do pacote final.
