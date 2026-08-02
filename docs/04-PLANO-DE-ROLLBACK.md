# Plano de rollback — Entrega 1

## 1. Princípio

O rollback deve preservar o Extension ID, o perfil do Chrome e o IndexedDB. A extensão não deve ser desinstalada como mecanismo normal de reversão.

## 2. Baseline de retorno

- extensão: `0.7.3`;
- Helper: `0.1.4`;
- contrato: `1.2.0`;
- Extension ID: `chdfbekdjpecdajbpdelmhpemenoelmd`.

## 3. Gatilhos

Executar contenção ou rollback quando houver:

- perda ou alteração indevida do IndexedDB;
- divergência de medição ou preço;
- troca do Extension ID;
- incompatibilidade entre extensão e Helper;
- execução de macro;
- sobrescrita do original;
- assinatura ou hash inválido;
- incidente de privacidade;
- falha generalizada de instalação ou atualização.

## 4. Níveis de resposta

### Nível 1 — congelar distribuição

1. restringir a Release afetada;
2. interromper novas instalações;
3. preservar executável, hash e logs;
4. registrar estações e versões afetadas;
5. decidir entre correção e rollback.

### Nível 2 — reparar ou remover o Helper

Aplicável quando extensão e dados permanecem íntegros.

1. fechar o Chrome;
2. executar diagnóstico sanitizado;
3. executar reparo do Setup ou remoção padrão;
4. confirmar o Native Messaging Host;
5. executar probe;
6. reabrir o Chrome;
7. confirmar DOCX e relatórios.

A remoção padrão do Helper deve preservar extensão, política e IndexedDB.

### Nível 3 — rollback progressivo da extensão

O Chrome não deve depender de downgrade para número de versão inferior. Deve ser produzida uma nova versão numericamente superior contendo o código da última baseline aprovada, assinada com a mesma PEM.

Exemplo:

```text
versão com incidente: 0.8.0
rollback progressivo: 0.8.1 com código funcional da 0.7.3
```

### Nível 4 — remoção integral

Último recurso. Antes de retirar a política da extensão:

1. exportar JSON e CSV quando possível;
2. registrar contagem e totais dos registros;
3. obter autorização expressa;
4. confirmar a disposição dos dados;
5. usar a confirmação literal `EXPORTED_OR_DISCARD_AUTHORIZED`.

A retirada da política pode fazer o Chrome desinstalar a extensão e eliminar seu armazenamento local.

## 5. Verificação dos dados

Antes e depois de qualquer rollback:

- registrar contagem de cálculos;
- registrar datas mínima e máxima;
- comparar totais agregados;
- manter o mesmo perfil do Chrome;
- manter o mesmo Extension ID;
- proibir limpeza de dados do navegador.

Qualquer divergência transforma o caso em incidente de dados e bloqueia a retomada.

## 6. Encerramento

O rollback é concluído quando:

- a baseline aprovada está operante;
- o Helper responde com contrato compatível ou foi removido de forma controlada;
- os dados foram conferidos;
- os casos críticos funcionam;
- a causa raiz e a decisão de retomada foram registradas.