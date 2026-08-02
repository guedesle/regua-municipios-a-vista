# Entrega 1 — Piloto operacional

Primeira distribuição da **Régua Editorial SieDOE — Municípios à Vista** para instalação controlada em estações autorizadas da EGBA.

## O que esta entrega permite

- processar matérias DOCX no EGBANET;
- converter DOC e RTF para DOCX quando o programa auxiliar e o Microsoft Word estiverem disponíveis;
- revisar a prévia da publicação;
- medir tarja e conteúdo;
- calcular e salvar o valor;
- consultar cálculos por data, protocolo ou cliente;
- emitir relatórios e exportar CSV e JSON.

## Arquivos para download

Baixe os dois arquivos:

```text
ReguaEditorial-Entrega1-Setup-x64.exe
ReguaEditorial-Entrega1-Setup-x64.exe.sha256
```

O `.sha256` é obrigatório para verificar a integridade do instalador.

## Instalação resumida

1. baixe os dois arquivos;
2. valide o SHA-256 conforme o [guia de instalação](https://github.com/guedesle/regua-municipios-a-vista/blob/main/docs/01-GUIA-DE-INSTALACAO.md);
3. feche completamente o Chrome;
4. execute o instalador como administrador;
5. reabra o Chrome;
6. confirme a extensão e execute os testes de homologação.

## Requisitos

- Windows x64;
- Google Chrome;
- estação vinculada ao domínio corporativo;
- credencial administrativa durante a instalação;
- Microsoft Word desktop somente para conversão automática de DOC e RTF.

DOCX, cálculos, consultas e relatórios não dependem do Word.

## Aviso do piloto

> [!WARNING]
> O instalador usa certificado temporário de laboratório. O primeiro aviso do Windows pode apresentar **Editor desconhecido**. Execute somente depois de validar o SHA-256 e confirmar que o arquivo veio desta Release privada.

O certificado é adequado apenas ao piloto controlado. A distribuição estável depende de assinatura corporativa reconhecida.

## Orientação ao usuário

Depois da instalação:

1. abra uma matéria no EGBANET;
2. clique no ícone **Régua Editorial SieDOE** na barra do Chrome;
3. use o painel lateral para processar e conferir o documento;
4. revise medição e valor antes de salvar;
5. mantenha o mesmo perfil do Chrome para preservar os cálculos.

## Limitações e cuidados

- o painel é habilitado somente em páginas compatíveis de matéria;
- cálculos são armazenados localmente no perfil do Chrome;
- limpar dados, trocar de perfil ou remover a extensão pode tornar os registros indisponíveis;
- sem Word ou sem o programa auxiliar, DOC e RTF podem exigir orientação adicional ou conversão manual para DOCX;
- não sobrescreva o arquivo original;
- não use documentos reais como evidência quando um arquivo sintético for suficiente.

## Versões

| Componente | Versão |
|---|---|
| Instalador | `1.0.0` |
| Extensão do Chrome | `0.7.3` |
| Programa auxiliar do Windows | `0.1.4` |
| Comunicação local | `1.2.0` |
| Estrutura do armazenamento local | `3` |
| Canal | `pilot` |

```text
ID da extensão: chdfbekdjpecdajbpdelmhpemenoelmd
Programa auxiliar: com.egba.regua_editorial.helper
```

## Situação

Esta é uma **pré-release de piloto**. A ampliação depende da homologação funcional pela GERDO, da validação técnica pela TI e do registro das pendências conhecidas.

Consulte o [README](https://github.com/guedesle/regua-municipios-a-vista), o [guia de instalação](https://github.com/guedesle/regua-municipios-a-vista/blob/main/docs/01-GUIA-DE-INSTALACAO.md) e o [guia rápido de uso](https://github.com/guedesle/regua-municipios-a-vista/blob/main/docs/08-GUIA-RAPIDO-DE-USO.md).