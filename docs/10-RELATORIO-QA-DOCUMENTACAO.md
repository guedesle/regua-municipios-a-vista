# Relatório de QA da documentação — Entrega 1.0.1

## Status

**APROVADA como documentação técnica e operacional da pré-release 1.0.1.**

Revisão consolidada: **7 de agosto de 2026**.

A aprovação documental não substitui o QA dos binários nem a homologação das estações. Os hashes finais permanecem deliberadamente fora deste relatório até a publicação dos artefatos definitivos.

## Escopo revisado

- `README.md`;
- guia de instalação;
- guia de homologação;
- operação e suporte;
- plano de rollback;
- arquitetura de distribuição;
- checklist de entrega;
- inventário da Release;
- guia rápido de uso;
- referência técnica;
- especificação técnica da extensão MV3;
- distribuição corporativa AD/GPO;
- atualização e continuidade;
- `SECURITY.md`;
- notas da Release `v1.0.1-pilot.1`;
- script de publicação da Release.

## 1. Principais mudanças desde a revisão anterior

A documentação anterior estava centrada em:

```text
Setup 1.0.0
Extensão 0.7.3
Release v1.0.0-pilot.1
um único instalador
```

A revisão atual consolida:

```text
Setup 1.0.1
Extensão 0.7.4
Regras 1.3.0
Release v1.0.1-pilot.1
dois instaladores
```

## 2. Segregação dos instaladores

A documentação diferencia explicitamente:

### Corporativo

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
```

- exige estação no Active Directory;
- destinado ao rollout institucional.

### Homologação local

```text
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
```

- destinado a laboratório fora do AD;
- bypass limitado ao gate de ambiente;
- não deve ser usado como substituto institucional.

## 3. Consistência técnica confrontada

A revisão documental foi alinhada com os elementos atuais da implementação:

- Chrome Manifest V3;
- Extension ID `chdfbekdjpecdajbpdelmhpemenoelmd`;
- permissões Chrome declaradas;
- host permission restrita ao EGBANET;
- content scripts restritos às páginas de matéria;
- Native Messaging `com.egba.regua_editorial.helper`;
- Helper `0.1.4`;
- contrato `1.2.0`;
- instalação por máquina;
- políticas Chrome em HKLM;
- cache local de CRX/update.xml;
- estado `installation.json` e `chrome-policy.json`;
- logs em ProgramData;
- IndexedDB/schema `3`;
- regra explícita `PartOfDomain = True` no instalador corporativo;
- modo de homologação local;
- compatibilidade dos scripts runtime com Windows PowerShell 5.1/UTF-8.

## 4. Resultado por critério

| Critério | Resultado | Observação |
|---|---|---|
| versão e identidade | Aprovado | 1.0.1 / 0.7.4 / ID operacional consistente |
| separação dos artefatos | Aprovado | nomes, finalidade e riscos documentados |
| Manifest V3 | Aprovado | permissões, hosts e superfícies descritos |
| Active Directory | Aprovado | requisito corporativo explicitado sem ambiguidade |
| GPO/rollout | Aprovado | instalação silenciosa, grupos/ondas e validação descritos |
| Native Messaging | Aprovado | host, registro, allowed origin e probe documentados |
| Word COM | Aprovado | dependência limitada a DOC/RTF e controles descritos |
| IndexedDB | Aprovado | riscos de perfil/limpeza/ID destacados |
| políticas Chrome | Aprovado | chaves, finalidade e preservação de terceiros descritas |
| assinatura e hash | Aprovado | piloto, SHA-256 e transição para stable documentados |
| atualização | Aprovado | identidade, HTTPS futuro e rollback documentados |
| segurança | Aprovado | materiais proibidos, evidências e resposta a incidente definidos |
| suporte | Aprovado | caminhos, logs, probe e códigos de erro disponíveis |
| QA de publicação | Aprovado | gate duplo e download pós-publicação descritos |

## 5. Pontos deliberadamente não preenchidos

Não foram inventados:

- SHA-256 final dos Setups;
- tamanho final dos Setups;
- thumbprint final do build publicado;
- estações efetivamente homologadas;
- aceite técnico/funcional final.

Esses valores devem ser copiados dos **artefatos definitivos**, do `release-manifest.json` e das evidências pós-publicação.

## 6. Riscos documentais controlados

### Risco: confundir HomologacaoLocal com Corporativo

Controle: nome explícito, aviso no README, release notes, instalação, arquitetura, segurança e checklist.

### Risco: afirmar suporte Entra-only no corporativo

Controle: documentação registra que esta Release exige `PartOfDomain = True`. Outros sinais de gerenciamento são diagnósticos, não substitutos desse gate.

### Risco: publicar hash de build descartado

Controle: inventário proíbe reutilizar hash intermediário e exige novo download da Release.

### Risco: remoção destrutiva

Controle: rollback e referência técnica destacam preservação do IndexedDB e proíbem limpeza indiscriminada de políticas/perfil.

## 7. Gate para encerramento da Release

A documentação está pronta, mas o inventário somente pode ser fechado após:

```text
BOTH_INSTALLERS_READY
BOTH_ARTIFACTS_QA_PASSED
```

seguido de:

1. upload dos quatro ativos;
2. novo download;
3. validação dos dois hashes;
4. registro de tamanhos e thumbprints;
5. homologação técnica;
6. aceite funcional/técnico.

## 8. Critérios para reabrir o QA documental

Reabrir esta revisão quando houver mudança em:

- versão da extensão/Helper/Setup;
- Extension ID ou PEM;
- permissões Chrome;
- host permissions;
- páginas compatíveis;
- Native Messaging;
- schema IndexedDB;
- regras editoriais;
- fluxo DOC/RTF;
- políticas Chrome;
- modelo AD/GPO;
- URLs de atualização;
- assinatura/certificado;
- comportamento de reparo/remoção;
- formato de relatórios.

## Conclusão

A documentação da Entrega 1.0.1 fornece uma trilha contínua para:

1. identificar o artefato correto;
2. validar integridade;
3. instalar em domínio ou laboratório;
4. entender a extensão e suas permissões;
5. implantar por AD/GPO;
6. diagnosticar políticas/Helper/Chrome;
7. preservar dados locais;
8. atualizar sem trocar identidade;
9. executar rollback;
10. auditar e fechar a Release.
