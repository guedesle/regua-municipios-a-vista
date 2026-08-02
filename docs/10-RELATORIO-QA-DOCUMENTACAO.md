# Relatório de QA da documentação

## Status

**APROVADA para implantação e homologação do piloto.**

Data da revisão: **1º de agosto de 2026**.

A aprovação cobre clareza, navegação, consistência técnica, segurança das instruções e capacidade de onboarding da equipe de TI e dos operadores.

## Escopo revisado

- `README.md`;
- guia de instalação;
- guia de homologação;
- operação e suporte;
- plano de reversão;
- arquitetura de distribuição;
- checklist de entrega;
- inventário da Release;
- guia rápido de uso;
- referência técnica;
- política de segurança;
- notas da Release;
- script de publicação e sincronização da Release.

## Ciclos executados

### Ciclo 1 — QA inicial

Foram identificados:

- instalação pouco prioritária no README;
- excesso de termos técnicos sem contexto;
- ausência de guia específico para operadores;
- falta de referência técnica consolidada;
- abertura do painel descrita de forma vaga;
- certificado temporário insuficientemente documentado;
- reparo e remoção com instruções ambíguas;
- risco de perda de cálculos pouco destacado;
- inventário com campos pendentes sem orientação de preenchimento;
- notas da Release não sincronizadas automaticamente;
- substituição desnecessária de ativos ao atualizar somente a documentação.

### Ciclo 2 — UX e webwriting

As informações foram reorganizadas por tarefa e público:

- instalação imediata no início do README;
- primeiro uso logo após a instalação;
- navegação por necessidade;
- linguagem operacional para a TI da ponta;
- guia rápido por casos de uso;
- termos técnicos explicados pelo papel que desempenham;
- detalhes de arquitetura deslocados para documentos próprios;
- alertas posicionados antes de ações de risco;
- comandos apresentados junto ao objetivo e ao resultado esperado.

### Ciclo 3 — QA técnico e de segurança

A documentação foi confrontada com:

- versões declaradas no projeto;
- ID operacional da extensão;
- endereços compatíveis do EGBANET;
- comportamento do painel lateral do Chrome;
- estrutura do instalador;
- diretórios instalados;
- políticas do Chrome;
- diagnóstico do programa auxiliar;
- comportamento da remoção padrão e integral;
- certificado temporário do piloto;
- opções oficiais do GitHub CLI usadas na publicação.

## Resultado por critério

| Critério | Resultado | Observação |
|---|---|---|
| Instalação localizada rapidamente | Aprovado | caminho principal visível no início do README |
| Primeiro uso compreensível | Aprovado | abertura pelo ícone e painel lateral explicitada |
| Separação por público | Aprovado | TI, operador, homologação e suporte possuem rotas próprias |
| Linguagem e legibilidade | Aprovado | jargão reduzido e contextualizado |
| Consistência de versões | Aprovado | `1.0.0`, `0.7.3`, `0.1.4`, `1.2.0` e schema `3` |
| Identidade da extensão | Aprovado | ID operacional consistente em todos os documentos |
| Conversão DOC/RTF | Aprovado | fluxo automático descrito com tratamento de indisponibilidade e orientação manual |
| Preservação de dados | Aprovado | riscos por perfil, limpeza e remoção destacados |
| Reparo e remoção | Aprovado | comportamento e comandos documentados |
| Certificado do piloto | Aprovado | aviso, inventário, riscos e retirada controlada descritos |
| Segurança das evidências | Aprovado | dados proibidos e sanitização definidos |
| Navegação interna | Aprovado | arquivos de destino existentes e links relativos consistentes |
| Notas da Release | Aprovado | links absolutos e sincronização pelo script |
| Publicação de ativos | Aprovado | substituição exige `-ReplaceAssets`; atualização comum preserva binários |

## Pendências operacionais não bloqueantes

As pendências abaixo não são falhas da documentação:

1. preencher no inventário o SHA-256, o tamanho, o responsável, o thumbprint e os aceites reais;
2. sincronizar as notas já publicadas na página da Release executando novamente o script;
3. concluir a homologação em estações representativas;
4. substituir a assinatura temporária de laboratório por assinatura corporativa reconhecida antes do canal estável;
5. registrar qualquer diferença entre o comportamento observado e o fluxo descrito durante o piloto.

## Critérios para revisões futuras

Reabrir o QA documental quando houver alteração em:

- versão da extensão ou do programa auxiliar;
- ID da extensão;
- páginas compatíveis do EGBANET;
- fluxo de DOC, RTF ou DOCX;
- localização dos cálculos;
- telas, nomes de botões ou navegação;
- políticas do Chrome;
- processo de instalação, atualização ou remoção;
- formato dos relatórios;
- requisitos de segurança ou assinatura.

## Conclusão

A documentação oferece um caminho contínuo entre:

1. entender a solução;
2. baixar e validar o instalador;
3. instalar e testar a estação;
4. orientar o operador;
5. executar os casos de uso;
6. registrar e diagnosticar falhas;
7. reparar, remover ou reverter com preservação de dados;
8. auditar a composição da Release.

Não foram identificadas falhas documentais bloqueantes na passagem final.