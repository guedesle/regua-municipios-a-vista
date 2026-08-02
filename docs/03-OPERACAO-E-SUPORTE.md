# Operação e suporte — Entrega 1

## 1. Papéis

### GERDO

- aprovar o escopo e a baseline funcional;
- selecionar operadores e casos de validação;
- autorizar início, expansão, suspensão e encerramento do piloto;
- validar cálculos, relatórios e exportações;
- priorizar correções funcionais.

### GERINF/TI

- disponibilizar o pacote aos usuários autorizados;
- executar instalação elevada nas estações;
- validar Active Directory, Chrome, Word e políticas;
- manter inventário de estações e versões;
- executar reparo, atualização e rollback técnico;
- coletar somente logs sanitizados.

### Operador

- usar apenas estação e perfil autorizados;
- não ativar modo desenvolvedor;
- não alterar políticas do Chrome;
- registrar horário, ação e mensagem da falha;
- não compartilhar documentos ou dados sensíveis em canais inadequados.

### Desenvolvimento

- manter a baseline e o código no repositório de desenvolvimento;
- produzir builds reproduzíveis;
- preservar o Extension ID e a compatibilidade do Helper;
- corrigir defeitos aprovados;
- publicar documentação e Release neste repositório de distribuição.

## 2. Suporte de primeiro nível

Verificações iniciais:

1. confirmar que a página do Egbanet é compatível;
2. confirmar versão `0.7.3` e ID operacional;
3. fechar e reabrir completamente o Chrome;
4. confirmar se o arquivo é DOCX, DOC ou RTF;
5. verificar se o Word está disponível para DOC/RTF;
6. registrar a mensagem exata sem incluir conteúdo da matéria.

## 3. Suporte de segundo nível

- verificar `chrome://policy`;
- verificar `chrome://extensions`;
- executar probe do Helper;
- conferir arquivos em `%ProgramFiles%` e `%ProgramData%`;
- conferir versão do Helper e contrato;
- verificar logs administrativos;
- reproduzir com corpus sintético;
- executar reparo ou rollback autorizado.

## 4. Classificação de severidade

### Crítica

- perda de registros;
- cálculo incorreto com impacto operacional;
- documento associado à matéria errada;
- sobrescrita do original;
- execução de macro;
- incidente de privacidade;
- indisponibilidade generalizada sem contorno.

Ação: suspender imediatamente a coorte e avaliar rollback.

### Alta

- DOC/RTF indisponível em várias estações;
- Helper incompatível;
- extensão não instalada em uma classe inteira de estação;
- relatórios indisponíveis sem perda de dados.

Ação: congelar expansão e corrigir ou reverter.

### Média

- falha isolada com contorno;
- erro de instalação em uma estação;
- degradação de desempenho.

### Baixa

- texto de orientação;
- melhoria documental;
- ajuste visual sem impacto funcional.

## 5. Logs

Local padrão:

```text
%ProgramData%\EGBA\ReguaEditorial\Logs\
```

Logs podem conter versões, hashes, códigos de erro, duração, estado do AD e resultado do probe.

Logs não podem conter:

- conteúdo de documento;
- protocolo ou cliente;
- ID de matéria;
- cookie, token ou senha;
- caminho de arquivo de produção;
- conteúdo do IndexedDB.

## 6. Encerramento de incidente

Um incidente é encerrado quando:

- causa e impacto foram registrados;
- integridade dos dados foi conferida;
- versões e estação foram verificadas;
- correção ou rollback foi aplicado;
- operador confirmou o resultado;
- ação preventiva possui responsável.