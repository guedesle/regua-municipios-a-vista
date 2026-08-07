# Especificação do motor de transformação editorial

Esta é a referência de distribuição para a baseline homologada da Entrega 1.

```text
Extensão: 0.7.4
Regras: municipios-editorial-rules@1.3.0
Largura editorial: 120 mm
```

## 1. Princípios

- a mesma entrada + opções + versão de regras deve produzir a mesma composição;
- DOCX é processado localmente;
- DOC/RTF é convertido para DOCX por cópia via Helper/Word antes do motor;
- o original e a matéria no EGBANET não são alterados;
- transformação, advertência e bloqueio devem ser rastreáveis;
- a composição normalizada alimenta a medição sem reinterpretar as regras editoriais.

## 2. Fluxo

```text
entrada DOCX validada
→ inventário estrutural
→ resolução de estilos efetivos
→ validações/bloqueios
→ normalização de parágrafos e runs
→ regra canônica
→ normalização de vazios
→ tarja opcional
→ composição de 120 mm
→ medição e cálculo
```

Se houver bloqueio, a composição não deve ser tratada como pronta para cálculo.

## 3. Matriz tipográfica vigente

| Elemento | Fonte | Peso | Corpo | Entrelinha | Caixa | Alinhamento |
|---|---|---:|---:|---:|---|---|
| texto-base | Arial | Regular | 6 pt | 8 pt | preservada | justificado |
| negrito secundário | Arial | Bold | 6 pt | 8 pt | preservada | justificado |
| trecho canônico | Arial | Bold | 8 pt | 8 pt | CAIXA ALTA | justificado |
| vazio interno normalizado | — | — | — | 8 pt | — | — |
| tarja | Arial | Regular | 12 pt | reflow natural | CAIXA ALTA | justificado |

Para texto e tarja:

- cor `#000000`;
- última linha à esquerda;
- espaço antes do parágrafo = 0 pt;
- espaço depois do parágrafo = 0 pt;
- recuos de primeira linha, suspenso, esquerdo e direito = 0;
- sem compressão/expansão de caracteres;
- sem redução automática de fonte para caber.

## 4. Hifenização

Conteúdo normalizado:

- hifenização automática ativada;
- idioma do documento quando disponível;
- fallback `pt-BR`;
- sem compressão de palavras/caracteres.

Tarja:

- hifenização desativada.

## 5. Trecho canônico

A regra é aplicada a cada parágrafo textual não vazio.

### Prioridade 1 — início em negrito efetivo

Se o primeiro caractere textual estiver em negrito, o canônico é a sequência inicial contínua em negrito.

Resultado:

```text
Arial Bold 8 pt
entrelinha 8 pt
CAIXA ALTA
```

### Prioridade 2 — início regular

Se o início não estiver em negrito, localizar o primeiro delimitador entre:

```text
.  ,
```

O delimitador que ocorrer primeiro encerra o trecho e é incluído no canônico.

Exemplo:

```text
Edital de convocação, ficam os interessados...
```

Canônico:

```text
EDITAL DE CONVOCAÇÃO,
```

### Sem delimitador

Se não houver ponto nem vírgula, o parágrafo inteiro é canônico.

### Negrito secundário

Negrito após o canônico não inicia novo canônico. Ele permanece Arial Bold 6/8 com caixa original.

## 6. Parágrafos vazios

- vazios antes do primeiro conteúdo: remover;
- vazios depois do último conteúdo: remover;
- um vazio interno: preservar como 8 pt;
- dois ou mais vazios internos consecutivos: reduzir a um único vazio de 8 pt;
- parágrafo apenas com espaços/tabs sem efeito visual: classificar como vazio.

As remoções/consolidações devem ser registradas.

## 7. Tarja

Quando habilitada:

- entidade é obrigatória;
- primeiro bloco da composição;
- largura 120 mm;
- Arial Regular 12 pt;
- preto;
- justificada;
- CAIXA ALTA Unicode-safe;
- sem hifenização;
- 0 pt antes;
- 12 pt após.

Quando desabilitada, não reservar espaço ou altura.

## 8. Revisões e texto oculto

A visão final do documento é materializada:

- inserções rastreadas entram no conteúdo;
- exclusões rastreadas são removidas;
- texto oculto é removido da composição;
- a transformação é registrada.

## 9. Tabelas

### Categoria `Atos cm/cl`

Qualquer tabela bloqueia o processamento:

```text
TABLE_NOT_ALLOWED_FOR_ATOS_CM_CL
```

### Categoria indisponível

Se houver tabela e a categoria não puder ser confirmada, bloquear:

```text
TABLE_CATEGORY_UNAVAILABLE
```

### Outras categorias

- tabela aninhada: bloqueio;
- largura > 12 cm: bloqueio;
- largura desconhecida: advertência;
- células mescladas: advertência/revisão;
- tabelas compatíveis podem ser preservadas;
- fundo = nenhum;
- padding interno = 0;
- espaçamento entre células = 0;
- texto das células recebe a mesma normalização tipográfica.

Não reduzir fonte nem comprimir tabela para fazê-la caber.

## 10. Imagens, gráficos e objetos

Na Entrega 1 atual, a presença de elemento gráfico, imagem ou objeto bloqueia a composição:

```text
GRAPHIC_CONTENT_NOT_SUPPORTED
```

Não descarte ou redimensione silenciosamente esses elementos.

## 11. Outros bloqueios

| Situação | Resultado |
|---|---|
| documento protegido para edição | bloqueio |
| documento sem conteúdo editorial processável | bloqueio |
| tarja solicitada sem entidade | bloqueio |
| tabela aninhada | bloqueio |
| tabela acima de 12 cm | bloqueio |

Uma quantidade alta de parágrafos vazios gera advertência para conferência após normalização.

## 12. Códigos principais de transformação

```text
BASE_TYPOGRAPHY_NORMALIZED
PARAGRAPH_JUSTIFIED
PARAGRAPH_INDENTS_REMOVED
AUTOMATIC_HYPHENATION_ENABLED
CANONICAL_FROM_INITIAL_BOLD
CANONICAL_TO_FIRST_FULL_STOP
CANONICAL_TO_FIRST_COMMA
CANONICAL_WHOLE_PARAGRAPH
EMPTY_PARAGRAPHS_NORMALIZED
ENTITY_BANNER_INCLUDED
ENTITY_BANNER_OMITTED
TRACKED_CHANGES_MATERIALIZED
HIDDEN_TEXT_REMOVED
TABLES_PRESERVED_FOR_LAYOUT
TABLE_PRESENTATION_NORMALIZED
```

Cada transformação deve estar associada à versão `municipios-editorial-rules@1.3.0`.

## 13. Códigos principais de bloqueio/advertência

```text
DOCUMENT_PROTECTED
DOCUMENT_CONTENT_EMPTY
GRAPHIC_CONTENT_NOT_SUPPORTED
ENTITY_REQUIRED_FOR_BANNER
HIGH_EMPTY_PARAGRAPH_COUNT
TABLE_CATEGORY_UNAVAILABLE
TABLE_NOT_ALLOWED_FOR_ATOS_CM_CL
NESTED_TABLE_UNSUPPORTED
TABLE_WIDTH_EXCEEDS_LIMIT
TABLE_WIDTH_UNKNOWN
MERGED_CELLS_REQUIRE_REVIEW
```

## 14. Medição e cálculo

A alteração para entrelinha 8 pt mudou a geometria da composição. Portanto, em relação à 0.7.3, altura, cm/cl e valor final podem mudar quando a ocupação muda.

A tarifa e a fórmula financeira não foram alteradas pela `rules@1.3.0`.

Tarja e conteúdo são medidos separadamente e compõem o resultado final conforme o motor de layout vigente.

## 15. Critérios de aceite

Uma composição apta deve comprovar:

- largura 120 mm;
- texto-base 6/8;
- negrito secundário 6/8;
- canônico 8/8 em caixa alta;
- delimitador canônico por negrito inicial, ponto ou vírgula;
- vazio interno de 8 pt;
- tarja 12 pt, sem hifenização, com 12 pt após;
- justificação e recuos zerados;
- hifenização do conteúdo;
- bloqueios de tabela/gráfico/proteção aplicados;
- rastreabilidade da `rulesVersion`;
- nenhuma alteração do arquivo original.

## 16. Governança

Mudança em fonte, corpo, entrelinha, caixa, hifenização, recuos, canônico, vazios, tarja, largura, tabelas, objetos ou resultado geométrico exige:

1. nova versão de regras quando houver mudança observável;
2. testes de regressão;
3. homologação funcional;
4. atualização deste documento;
5. registro na Release correspondente.

Esta especificação consolida a baseline distribuída `0.7.4 / rules@1.3.0`. Documentos históricos do repositório de desenvolvimento continuam úteis para rastreabilidade, mas não devem ser usados como instrução operacional quando divergirem desta baseline.