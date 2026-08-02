# Operação e suporte

Este documento orienta o atendimento ao usuário e o diagnóstico inicial da Régua Editorial.

## 1. Fluxo normal de uso

O operador deve:

1. abrir a matéria no EGBANET;
2. abrir a Régua Editorial no Chrome;
3. conferir os dados identificados;
4. processar o documento;
5. revisar prévia, medição e valor;
6. salvar o cálculo;
7. consultar registros ou emitir relatórios quando necessário.

Para instruções detalhadas, consulte o [Guia rápido de uso](08-GUIA-RAPIDO-DE-USO.md).

## 2. Orientação ao usuário

A equipe de TI ou suporte deve reforçar:

- usar sempre o mesmo perfil do Chrome;
- não limpar os dados do navegador;
- não ativar o modo desenvolvedor;
- não substituir o documento original;
- revisar os dados da matéria antes de salvar;
- informar a mensagem exata quando houver falha;
- não compartilhar documentos ou dados sensíveis em canais inadequados.

## 3. Atendimento de primeiro nível

Antes de encaminhar a ocorrência, verifique:

1. a matéria está em uma página compatível do EGBANET?
2. a extensão abre normalmente?
3. o Chrome foi fechado e reaberto completamente?
4. o arquivo é DOCX, DOC ou RTF?
5. o Word está disponível quando o arquivo é DOC ou RTF?
6. o usuário está no mesmo perfil do Chrome em que os cálculos foram salvos?
7. há uma mensagem ou código de erro?

Registre:

- data e horário;
- ação executada;
- formato do arquivo;
- versão da extensão;
- mensagem exibida;
- resultado após reiniciar o Chrome.

## 4. Diagnóstico pela TI

Quando o atendimento inicial não resolver:

- confira `chrome://policy`;
- confira `chrome://extensions`;
- valide versão e ID da extensão;
- execute o diagnóstico do programa auxiliar;
- verifique os diretórios instalados;
- consulte os logs administrativos;
- reproduza com documento sintético;
- use reparo somente depois de registrar o estado atual.

A [Referência técnica](09-REFERENCIA-TECNICA.md) contém os comandos e caminhos necessários.

## 5. Sintomas comuns

| Sintoma | Verificação inicial | Encaminhamento |
|---|---|---|
| Extensão não aparece | fechar Chrome e recarregar políticas | TI da ponta |
| Página não reconhecida | confirmar endereço da matéria no EGBANET | suporte funcional |
| DOCX não processa | repetir com arquivo sintético e registrar erro | desenvolvimento, se persistir |
| DOC ou RTF não converte | verificar Word e programa auxiliar | TI da ponta |
| Prévia incompleta | confirmar arquivo e regras de bloqueio | suporte funcional |
| Medição ou preço divergente | não salvar; registrar valores esperados e obtidos | GERDO/desenvolvimento |
| Cálculo salvo não aparece | confirmar perfil do Chrome e limpeza de dados | TI da ponta |
| Relatório divergente | comparar filtros, período e registros individuais | suporte funcional |
| ID da extensão divergente | interromper o uso | responsável pela distribuição |

## 6. Classificação de impacto

### Crítico

- perda de cálculos;
- valor incorreto com impacto operacional;
- documento associado à matéria errada;
- sobrescrita do original;
- execução de macro;
- exposição de dados;
- indisponibilidade em várias estações sem alternativa.

**Ação:** suspender o uso nas estações afetadas e avaliar reversão.

### Alto

- conversão DOC/RTF indisponível em várias estações;
- programa auxiliar incompatível;
- extensão ausente em um conjunto de estações;
- relatórios indisponíveis sem perda de dados.

**Ação:** interromper novas instalações e priorizar correção.

### Médio

- falha isolada com alternativa de trabalho;
- erro de instalação em uma estação;
- lentidão relevante;
- problema de uso que exige orientação.

### Baixo

- melhoria de texto;
- ajuste visual sem impacto funcional;
- dúvida de operação resolvida por orientação.

## 7. Logs e privacidade

Local padrão dos logs:

```text
%ProgramData%\EGBA\ReguaEditorial\Logs\
```

Os logs podem conter versões, horários, códigos de erro, resultado do diagnóstico e estado da instalação.

Não devem conter:

- conteúdo do documento;
- protocolo ou cliente real;
- ID real da matéria;
- senha, cookie ou token;
- arquivo de produção;
- conteúdo completo dos cálculos armazenados.

Antes de compartilhar um log, revise e remova dados que identifiquem matérias ou usuários quando não forem necessários ao diagnóstico.

## 8. Modelo de registro da ocorrência

```text
Data e horário:
Estação:
Usuário ou setor:
Versão da extensão:
Página ou fluxo utilizado:
Formato do arquivo:
Ação realizada:
Mensagem apresentada:
O problema se repetiu após reiniciar o Chrome?:
Impacto observado:
Evidências sanitizadas anexadas:
```

## 9. Encerramento

A ocorrência pode ser encerrada quando:

- causa e impacto estiverem registrados;
- integridade dos cálculos tiver sido conferida;
- correção, orientação ou reversão tiver sido aplicada;
- o usuário confirmar o funcionamento;
- houver responsável definido para qualquer ação preventiva pendente.