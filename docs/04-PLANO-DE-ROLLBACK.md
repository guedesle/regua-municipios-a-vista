# Plano de reversão (rollback) — Entrega 1.0.1

Este plano orienta contenção, reparo, substituição ou retirada controlada da Régua Editorial quando uma versão apresenta falha relevante.

## 1. Princípio de segurança

Os cálculos ficam armazenados no perfil do Chrome. A reversão deve preservar:

- o mesmo perfil do usuário;
- o Extension ID `chdfbekdjpecdajbpdelmhpemenoelmd`;
- o IndexedDB e registros locais;
- arquivos exportados;
- evidências técnicas necessárias.

> [!WARNING]
> Remover a política da extensão, excluir a extensão ou limpar o perfil do Chrome pode tornar os cálculos inacessíveis. Essas ações exigem exportação prévia ou autorização expressa de descarte.

## 2. Artefatos envolvidos

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
```

O instalador de homologação local não deve ser promovido como substituto do corporativo. Em incidente de rollout institucional, trabalhe sobre o artefato corporativo e sobre a Release publicada.

## 3. Quando iniciar contenção ou reversão

Avalie rollback diante de:

- perda/alteração de cálculos;
- medição ou preço incorreto;
- Extension ID divergente;
- incompatibilidade extensão/Helper;
- execução de macro;
- sobrescrita de original;
- hash ou assinatura divergente;
- política Chrome aplicada incorretamente;
- exposição de dados;
- falha generalizada de instalação/atualização;
- regressão funcional em múltiplas estações.

## 4. Nível 1 — suspender novas instalações

1. interrompa o rollout no grupo/OU seguinte;
2. preserve a Release e os quatro ativos;
3. registre hashes, versões e lote afetado;
4. preserve logs e `state` das estações representativas;
5. não remova a extensão nem limpe o perfil;
6. defina correção, reparo ou substituição.

## 5. Nível 2 — reparar a estação

Use quando a versão é considerada válida e a falha está concentrada em instalação/política/Helper.

1. registre a quantidade de cálculos;
2. feche o Chrome;
3. execute o reparo;
4. valide Helper e políticas;
5. reabra o Chrome;
6. confirme DOCX, cálculo, consulta e relatórios;
7. confirme que os registros anteriores permanecem disponíveis.

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorial\Repair-ReguaEditorial.ps1" `
  -PackageRoot "$env:ProgramFiles\EGBA\ReguaEditorial"
```

## 6. Nível 3 — conter falha do Helper

Se o problema estiver restrito a DOC/RTF:

- suspenda esses formatos;
- mantenha DOCX, consultas e relatórios quando validados;
- diagnostique o Helper/Word;
- evite remover a extensão como ação inicial.

A remoção padrão do Setup pode retirar o Helper sem necessariamente exigir descarte do IndexedDB.

## 7. Nível 4 — substituir a extensão por versão de reversão

Chrome não garante downgrade simples para número inferior. A estratégia recomendada é publicar uma **versão numericamente superior** contendo o comportamento da última versão aprovada, preservando a mesma identidade.

Exemplo:

```text
versão com incidente: 0.8.0
versão de reversão:   0.8.1 contendo o comportamento aprovado da 0.7.4
```

Obrigatório:

- mesma PEM;
- mesmo Extension ID;
- compatibilidade com o schema local;
- novo QA e nova homologação;
- documentação explícita de que se trata de reversão funcional.

## 8. Nível 5 — remoção integral

Use somente como último recurso.

Antes de remover também a extensão:

1. exporte CSV/JSON quando possível;
2. registre quantidade e período dos cálculos;
3. confirme o perfil Chrome;
4. obtenha autorização expressa GERDO/TI;
5. registre decisão de preservar ou descartar;
6. execute o procedimento administrativo controlado.

Confirmação técnica exigida pelo fluxo de remoção integral:

```text
EXPORTED_OR_DISCARD_AUTHORIZED
```

## 9. Conferência antes/depois

Registre:

- Extension ID;
- versão instalada;
- quantidade de registros;
- período coberto;
- totais agregados;
- resultado de consulta após reinício do Chrome.

Qualquer divergência de dados impede a retomada do rollout.

## 10. Políticas Chrome

Antes de alterar manualmente o Registro, consulte:

```text
%ProgramData%\EGBA\ReguaEditorial\state\chrome-policy.json
```

O instalador registra os slots e valores anteriores usados pela Régua. Não apague `ExtensionInstallForcelist`, `NativeMessagingAllowlist` ou `ExtensionSettings` integralmente: podem existir políticas de outras aplicações.

## 11. Certificado temporário do piloto

A remoção padrão não implica retirada automática do certificado.

Antes de removê-lo:

1. leia o thumbprint em `release-manifest.json`;
2. confirme que nenhuma instalação ativa depende dele;
3. confirme os repositórios Root e TrustedPublisher;
4. obtenha autorização da TI;
5. remova pelo thumbprint exato.

Nunca remova certificado apenas pelo Subject.

## 12. Retomada

O rollout pode ser retomado quando:

- a causa estiver compreendida ou mitigada;
- a versão aprovada estiver em operação;
- dados locais tiverem sido conferidos;
- testes críticos forem aprovados;
- QA/release estiverem rastreáveis;
- GERDO e TI autorizarem a próxima onda.

Consulte também [09 — Referência técnica](09-REFERENCIA-TECNICA.md) e [13 — Atualização e continuidade](13-ATUALIZACAO-E-CONTINUIDADE.md).
