# Qualidade e homologação

Use este roteiro para aceitar uma instalação ou uma Release.

## Gate de artefatos

Antes de instalar, o build final deve ter concluído:

```text
BOTH_INSTALLERS_READY
BOTH_ARTIFACTS_QA_PASSED
```

A publicação só é encerrada depois de novo download e validação dos hashes.

## Identificação esperada

| Item | Valor |
|---|---|
| Release | `v1.0.1-pilot.1` |
| Setup | `1.0.1` |
| Extensão | `0.7.4` |
| Regras | `municipios-editorial-rules@1.3.0` |
| Helper | `0.1.4` |
| Contrato | `1.2.0` |
| Extension ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |

## Matriz mínima

| ID | Teste | Resultado esperado |
|---|---|---|
| Q-01 | SHA-256 | igual ao `.sha256` publicado |
| Q-02 | instalação adequada ao ambiente | concluída sem erro |
| Q-03 | extensão | nome, versão e ID corretos |
| Q-04 | políticas Chrome | presentes e válidas |
| Q-05 | Helper | probe aprovado |
| Q-06 | DOCX | prévia, medição e cálculo |
| Q-07 | persistência | cálculo salvo e recuperado |
| Q-08 | relatórios | filtros e totais coerentes |
| Q-09 | CSV/JSON | exportações válidas |
| Q-10 | reinício Chrome | extensão e registros preservados |
| Q-11 | DOC/RTF | conversão aprovada quando aplicável |
| Q-12 | motor 1.3.0 | 6/8, canônico 8/8, vazio 8 pt e tarja sem regressão |

## Específico da Instalação corporativa

```powershell
(Get-CimInstance Win32_ComputerSystem).PartOfDomain
```

Deve retornar `True`.

## Específico da Instalação local

O ambiente pode estar fora do domínio, mas o Setup deve manter integridade, assinaturas, Helper, políticas e Extension ID. O estado deve registrar o override técnico usado pela modalidade local.

Nesta Release, o executável da Instalação local mantém o nome técnico `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe` por rastreabilidade.

## Motor editorial

Valide pelo menos:

- canônico iniciado por negrito;
- canônico delimitado por ponto;
- canônico delimitado por vírgula;
- parágrafo sem delimitador;
- negrito secundário;
- sequência de vazios;
- tarja;
- bloqueio de gráfico/objeto;
- política de tabela `Atos cm/cl`;
- geometria/valor explicável pela entrelinha 8 pt.

Referência: [Especificação do motor](../motor/ESPECIFICACAO.md).

## Evidências permitidas

Registre:

- data e responsável;
- estação pseudonimizada;
- versão/ID;
- SHA-256;
- resultado de cada caso;
- códigos de erro quando houver.

Não registre conteúdo de matéria, documento de produção, cookies, tokens ou cópia integral do IndexedDB.

## Critério de aceite

A Release/instalação só é aceita quando todos os testes aplicáveis estão aprovados e não há divergência de identidade, dados, medição ou integridade.

Pendências de assinatura corporativa impedem promoção para `stable`, mas não necessariamente o piloto controlado.