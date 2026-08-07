# Entrega 1 — Piloto operacional 1.0.1

Distribuição homologada da **Régua Editorial SieDOE — Municípios à Vista** para instalação controlada em estações autorizadas da EGBA.

## Alteração desta revisão

A extensão passa para a versão `0.7.4`, com regras editoriais `municipios-editorial-rules@1.3.0`.

- conteúdo base: Arial 6 pt / entrelinha 8 pt;
- negrito secundário: Arial Bold 6 pt / entrelinha 8 pt;
- trecho canônico: Arial Bold 8 pt / entrelinha 8 pt / caixa alta;
- vazio interno normalizado: 8 pt;
- tarja: inalterada;
- tarifa e fórmula de cálculo: inalteradas.

A mudança de entrelinha altera a geometria editorial. Altura, cm/cl e valor total podem variar em relação à versão 0.7.3 exclusivamente por esse efeito geométrico.

## Arquivos para instalação

Baixe os dois arquivos da Release:

```text
ReguaEditorial-Entrega1-Setup-x64.exe
ReguaEditorial-Entrega1-Setup-x64.exe.sha256
```

O arquivo `.sha256` deve ser usado para validar a integridade do instalador antes da execução.

## Instalação resumida

1. baixe o instalador e o arquivo SHA-256;
2. valide o hash;
3. feche completamente o Chrome;
4. execute o instalador como administrador;
5. reabra o Chrome;
6. confirme a extensão e a versão instalada;
7. execute a validação funcional pós-instalação.

## Requisitos

- Windows x64;
- Google Chrome;
- estação vinculada ao domínio corporativo;
- credencial administrativa durante a instalação;
- Microsoft Word desktop somente para conversão automática de DOC e RTF.

DOCX, cálculos, consultas e relatórios não dependem do Word.

## Assinatura do piloto

> [!WARNING]
> O instalador utiliza certificado temporário de laboratório. O primeiro aviso do Windows pode apresentar **Editor desconhecido**. Execute somente depois de validar o SHA-256 e confirmar a origem desta Release privada.

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
ID da extensão: kinmhabaogefkaoefhponolanmjpcikp
Programa auxiliar: com.egba.regua_editorial.helper
```

## Situação

A mudança editorial da versão 0.7.4 foi homologada em 07/08/2026. Esta Release permanece classificada como **pré-release de piloto interno** para implantação controlada.
