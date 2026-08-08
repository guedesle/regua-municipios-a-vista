# Revisão de QA do repositório de distribuição

Data: 07/08/2026

## Resultado

**Arquitetura da informação: APROVADA.**

**Pacote remoto: APROVADO quanto à presença dos dois `.exe` e respectivos `.sha256` em `distribuicao/v1.0.1-pilot.1/` via Git LFS.**

## Rodadas executadas

| Rodada | Perspectiva | Resultado |
|---|---|---|
| 1 | UX / arquitetura da informação | estrutura numerada substituída por pastas orientadas a tarefa |
| 2 | PO | jornadas reduzidas a instalar, usar, suportar, entender tecnicamente e homologar |
| 3 | UI / webwriting | README e guias de primeira linha reduzidos e orientados à ação |
| 4 | arquitetura / motor | especificação consolidada na baseline `0.7.4 / rules@1.3.0` |
| 5 | QA técnico | versões, ID, Helper, AD, MV3 e políticas alinhados |
| 6 | QA de duplicidade | documentos e scripts antigos removidos da árvore ativa |
| 7 | QA de pacote | documentação duplicada retirada da pasta de binários |
| 8 | QA de navegação | raiz, índice e pacote possuem caminhos explícitos por objetivo |
| 9 | QA de veracidade | ausência inicial dos `.exe` identificada e posteriormente corrigida via Git LFS |
| 10 | QA terminológico | modalidade fora do domínio padronizada como **Instalação local** em toda a documentação ativa |

## Estrutura aprovada

```text
README.md
distribuicao/
docs/
├── instalacao/
│   ├── CORPORATIVO.md
│   ├── INSTALACAO-LOCAL.md
│   └── AD-GPO.md
├── uso/
├── tecnico/
├── motor/
└── qualidade/
release/
scripts/
├── implantacao/
└── release/
SECURITY.md
```

## Critérios aprovados

- um único README de entrada;
- um documento canônico por tarefa;
- **Instalação corporativa** e **Instalação local** sem ambiguidade;
- guia de uso separado da infraestrutura;
- suporte separado da operação diária;
- detalhes técnicos em aprofundamento progressivo;
- regras do motor editorial atuais e separadas de documentação histórica;
- scripts organizados por implantação e publicação;
- documentação histórica preservada apenas no Git, não concorrendo com a baseline atual;
- Git LFS configurado para `distribuicao/**/*.exe`;
- dois executáveis presentes na pasta versionada do pacote.

## Nota sobre o nome técnico do artefato local

A modalidade documental é **Instalação local**. O executável da Release `v1.0.1-pilot.1` mantém o nome técnico legado:

```text
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
```

Esse nome é preservado nesta Release para manter rastreabilidade com o build já homologado. Ele não altera a nomenclatura funcional adotada na documentação.

## Reabrir esta revisão quando houver

- nova versão do produto;
- alteração de instalador ou fluxo de distribuição;
- mudança em permissões/hosts do Chrome;
- mudança no Extension ID, Helper ou IndexedDB;
- mudança nas regras de transformação editorial;
- novos públicos ou casos de uso que exijam outra rota documental.