# Plano de reversão (rollback)

Este plano orienta a interrupção, o reparo ou a retirada controlada da Régua Editorial quando uma versão apresenta falha relevante.

## 1. Princípio de segurança

Os cálculos ficam armazenados no perfil do Chrome. Por isso, a reversão deve preservar:

- o mesmo perfil do usuário;
- o ID da extensão `chdfbekdjpecdajbpdelmhpemenoelmd`;
- os registros locais;
- os arquivos exportados e as evidências necessárias.

> [!WARNING]
> Remover a política da extensão, excluir a extensão ou limpar o perfil do Chrome pode eliminar os cálculos locais. Essas ações exigem exportação prévia ou autorização expressa de descarte.

## 2. Quando iniciar a reversão

Avalie contenção ou reversão diante de:

- perda ou alteração de cálculos;
- medição ou preço incorreto;
- ID da extensão diferente do previsto;
- incompatibilidade entre a extensão e o programa auxiliar;
- execução de macro;
- sobrescrita do documento original;
- hash ou assinatura divergente;
- exposição de dados;
- falha generalizada de instalação ou atualização.

## 3. Resposta por nível

### Nível 1 — Suspender novas instalações

Use quando a causa ainda está em análise.

1. interrompa a distribuição da Release afetada;
2. não instale em novas estações;
3. preserve o instalador, o `.sha256` e os logs;
4. registre versões e estações afetadas;
5. defina se haverá correção, reparo ou reversão.

### Nível 2 — Reparar a instalação

Use quando a versão é considerada válida, mas uma estação está incompleta ou corrompida.

1. confirme a quantidade de cálculos existentes;
2. feche o Chrome;
3. execute o reparo pelo Windows;
4. valide a extensão e o programa auxiliar;
5. reabra o Chrome;
6. confirme DOCX, salvamento e relatórios;
7. confirme que os registros anteriores permanecem disponíveis.

### Nível 3 — Remover somente o programa auxiliar

Use quando o problema está concentrado na conversão de DOC e RTF.

A remoção padrão do instalador:

- retira o programa auxiliar e sua autorização de comunicação;
- preserva a extensão, a política de instalação e os cálculos;
- mantém potencialmente DOCX, consultas e relatórios;
- deixa a conversão automática de DOC e RTF indisponível.

Depois da remoção, feche e reabra o Chrome e valide os fluxos que permanecerão em uso.

### Nível 4 — Substituir a versão da extensão

O Chrome pode impedir retorno direto para um número de versão inferior. Nessa situação, publique uma versão numericamente superior contendo o código da última versão aprovada e usando a mesma identidade da extensão.

Exemplo:

```text
versão com incidente: 0.8.0
versão de reversão:   0.8.1 com o comportamento aprovado da 0.7.3
```

A nova versão deve passar pela homologação antes da ampliação.

### Nível 5 — Remoção integral

Use somente como último recurso.

Antes de remover também a extensão:

1. exporte JSON e CSV, quando possível;
2. registre a quantidade de cálculos e os totais;
3. confirme o perfil do Chrome utilizado;
4. obtenha autorização expressa da GERDO e da TI;
5. registre a decisão de preservar ou descartar os dados;
6. execute a remoção técnica controlada.

A confirmação técnica exigida pelo script é:

```text
EXPORTED_OR_DISCARD_AUTHORIZED
```

## 4. Conferência dos dados

Antes e depois da ação:

- registre a quantidade de cálculos;
- registre o período coberto pelos registros;
- compare os totais agregados;
- mantenha o mesmo perfil do Chrome;
- confirme o mesmo ID da extensão;
- não use limpeza de dados do navegador.

Qualquer divergência deve ser tratada como incidente de dados e impede a retomada.

## 5. Certificado temporário do piloto

O instalador piloto adiciona um certificado público temporário aos repositórios de confiança do Windows. A remoção padrão não deve ser presumida como remoção desse certificado.

Antes de retirar o certificado:

1. identifique o thumbprint usado pela Release;
2. confirme que ele pertence somente à Régua Editorial;
3. confirme que nenhuma instalação ativa depende dele;
4. registre a autorização da TI;
5. remova-o de forma controlada dos repositórios **Trusted Root** e **Trusted Publishers**.

Não remova certificados apenas pelo nome do emissor, pois pode haver mais de um certificado com identificação semelhante.

## 6. Retomada

O uso pode ser retomado quando:

- a versão aprovada estiver operando;
- os cálculos tiverem sido conferidos;
- os testes críticos forem aprovados;
- o impacto e a causa estiverem registrados;
- GERDO e TI autorizarem a retomada.

Consulte a [Referência técnica](09-REFERENCIA-TECNICA.md) para comandos e locais de diagnóstico.