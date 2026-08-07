# Entrega 1 — Piloto operacional 1.0.1

Distribuição homologada da **Régua Editorial SieDOE — Municípios à Vista**.

## Alteração desta revisão

A extensão passa para a versão `0.7.4`, com regras editoriais `municipios-editorial-rules@1.3.0`.

- conteúdo base: Arial 6 pt / entrelinha 8 pt;
- negrito secundário: Arial Bold 6 pt / entrelinha 8 pt;
- trecho canônico: Arial Bold 8 pt / entrelinha 8 pt / caixa alta;
- vazio interno normalizado: 8 pt;
- tarja: inalterada;
- tarifa e fórmula de cálculo: inalteradas.

A mudança de entrelinha altera a geometria editorial. Altura, cm/cl e valor total podem variar em relação à versão 0.7.3 exclusivamente por esse efeito geométrico.

## Instaladores disponíveis

Esta pré-release publica **dois instaladores explicitamente identificados no nome**.

### 1. Instalação corporativa

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256
```

Use este instalador nas estações corporativas gerenciadas. Ele mantém o gate de gerenciamento e exige que a estação seja reconhecida por um dos mecanismos corporativos aceitos, incluindo Active Directory.

### 2. Homologação local

```text
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256
```

Use este instalador somente para homologação e testes em estação fora do ambiente corporativo gerenciado. Ele ignora exclusivamente o gate de AD/gerenciamento corporativo durante a instalação local.

Continuam obrigatórias neste instalador de homologação:

- integridade por SHA-256;
- assinaturas dos componentes;
- validação de versão;
- instalação e probe do Native Helper;
- aplicação da política da extensão no Chrome;
- validações de arquitetura e payload;
- Extension ID operacional definitivo.

O instalador de homologação local **não substitui** o instalador corporativo para implantação institucional.

## Instalação resumida

1. escolha o instalador adequado ao tipo de estação;
2. baixe o `.exe` e o `.sha256` de mesmo nome;
3. valide o SHA-256;
4. feche completamente o Chrome;
5. execute o instalador como administrador;
6. reabra o Chrome;
7. confirme a extensão e a versão instalada;
8. execute a validação funcional pós-instalação.

## Requisitos comuns

- Windows x64;
- Google Chrome;
- credencial administrativa durante a instalação;
- Microsoft Word desktop somente para conversão automática de DOC e RTF.

DOCX, cálculos, consultas e relatórios não dependem do Word.

O instalador **corporativo** requer ainda ambiente corporativo gerenciado. O instalador de **homologação local** existe justamente para estações de teste que não atendam a esse gate.

## Assinatura do piloto

> [!WARNING]
> Os instaladores desta pré-release utilizam certificado temporário de laboratório. O primeiro aviso do Windows pode apresentar **Editor desconhecido** até o certificado ser confiado na estação. Execute somente depois de validar o SHA-256 e confirmar a origem da Release.

A distribuição estável continua dependente de assinatura corporativa reconhecida.

## Versões

| Componente | Versão |
|---|---|
| Instalador | `1.0.1` |
| Extensão do Chrome | `0.7.4` |
| Regras editoriais | `municipios-editorial-rules@1.3.0` |
| Programa auxiliar do Windows | `0.1.4` |
| Comunicação local | `1.2.0` |
| Estrutura do armazenamento local | `3` |
| Canal | `pilot` |

```text
ID operacional da extensão: chdfbekdjpecdajbpdelmhpemenoelmd
Programa auxiliar: com.egba.regua_editorial.helper
```

## Situação

A mudança editorial da versão 0.7.4 foi homologada em 07/08/2026. Esta Release permanece classificada como **pré-release de piloto interno**.
