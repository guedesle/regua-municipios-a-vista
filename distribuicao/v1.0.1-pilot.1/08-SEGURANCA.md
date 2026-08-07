# Segurança da distribuição — Régua Editorial SieDOE

Esta política orienta publicação, implantação, suporte e resposta a incidentes da Régua Editorial em ambiente interno da EGBA.

## 1. Escopo

Este repositório contém somente materiais de distribuição:

- instaladores como ativos de Releases privadas;
- arquivos `.sha256`;
- notas e inventários de entrega;
- documentação operacional/técnica;
- scripts administrativos de publicação.

Código-fonte, chaves e ferramentas de build permanecem no repositório de desenvolvimento ou em cofres apropriados.

## 2. Identidade operacional

```text
Extension ID: chdfbekdjpecdajbpdelmhpemenoelmd
Native host:  com.egba.regua_editorial.helper
```

A mesma chave privada institucional da extensão deve ser preservada em todas as atualizações desta identidade. Ela **nunca** deve ser versionada ou anexada à Release.

A troca do Extension ID é ação excepcional porque afeta:

- atualização da extensão;
- autorização Native Messaging;
- origem associada ao IndexedDB;
- continuidade dos cálculos existentes.

## 3. Artefatos permitidos na Release

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256
```

O instalador de homologação local deve ser explicitamente identificado e não pode ser usado como pacote institucional de produção.

## 4. Materiais proibidos

Nunca versione, anexe ou publique em issues:

- PEM/PFX/P12/KEY ou outra chave privada;
- senha de certificado;
- cookies, tokens, senhas ou credenciais;
- documentos DOCX/DOC/RTF de produção;
- conteúdo textual de matérias;
- dumps de IndexedDB/perfil Chrome;
- exportações reais sem autorização;
- logs com dados operacionais desnecessários;
- `node_modules`, staging ou pastas de build.

Use dados sintéticos e evidências sanitizadas.

## 5. Integridade dos instaladores

Cada `.exe` deve possuir `.sha256` próprio. Antes de executar:

1. confirme origem na Release privada oficial;
2. valide o SHA-256;
3. confirme o nome do artefato;
4. confirme o tipo de estação;
5. interrompa diante de divergência.

Os dois instaladores devem ter hashes diferentes.

## 6. Assinatura do piloto

A linha `pilot` utiliza certificado temporário de laboratório.

Controles:

- componentes internos assinados;
- Setup assinado;
- certificado público incorporado ao pacote;
- parte pública adicionada a Root/TrustedPublisher durante a instalação;
- thumbprint registrado no manifesto;
- chave privada nunca distribuída;
- SHA-256 obrigatório.

O primeiro UAC pode mostrar **Editor desconhecido** antes da confiança do certificado.

A promoção a `stable` exige assinatura corporativa reconhecida e nova homologação da cadeia completa.

## 7. Permissões da extensão

Manifest V3 declara:

```text
sidePanel
activeTab
tabs
downloads
downloads.open
storage
nativeMessaging
```

Host permission restrita a:

```text
https://egbanet.egba.ba.gov.br/*
```

Content scripts restritos às páginas de matéria:

```text
/admin/materias/edit/*
/admin/materias/edicao_restrita/*
```

Qualquer ampliação de host permissions ou permissões Chrome deve passar por revisão de segurança e nova documentação.

## 8. Native Messaging

O native host aceita somente:

```text
chrome-extension://chdfbekdjpecdajbpdelmhpemenoelmd/
```

O manifesto fica sob Program Files e o registro é por máquina.

Alterações em `allowed_origins`, nome do host, protocolo ou escopo de instalação exigem revisão de segurança.

## 9. Políticas Chrome

A Régua utiliza:

```text
ExtensionInstallForcelist
NativeMessagingAllowlist
ExtensionSettings
```

O script deve preservar entradas de outras aplicações. Não use limpeza indiscriminada das chaves `HKLM\SOFTWARE\Policies\Google\Chrome` como procedimento de suporte.

Para rollback, use o estado registrado em:

```text
%ProgramData%\EGBA\ReguaEditorial\state\chrome-policy.json
```

## 10. Proteção dos cálculos

Os cálculos ficam no IndexedDB do perfil Chrome.

Controles:

- usar o mesmo perfil operacional;
- não limpar dados do navegador sem procedimento;
- não remover a extensão como troubleshooting rotineiro;
- exportar CSV/JSON conforme rotina definida;
- registrar quantidade/totais antes de ações invasivas;
- preservar Extension ID em atualizações.

A remoção integral exige exportação prévia ou autorização expressa de descarte.

## 11. Conversão de documentos

DOC/RTF utilizam Microsoft Word por meio do Native Helper.

Requisitos de segurança do fluxo:

- trabalhar sobre material temporário/cópia;
- preservar o original;
- abrir como somente leitura;
- desabilitar macros;
- validar o DOCX produzido;
- remover temporários ao final;
- não registrar conteúdo documental nos logs.

Sobrescrita do original ou execução de macro é incidente crítico.

## 12. Logs e evidências

Local:

```text
%ProgramData%\EGBA\ReguaEditorial\Logs\
```

Podem conter:

- versões;
- horários;
- códigos de erro;
- resultado do probe;
- estado de instalação;
- hashes e informações técnicas necessárias.

Não devem conter:

- conteúdo de matéria;
- documento de produção;
- cookie/token/senha;
- dump integral de cálculo;
- dados pessoais ou operacionais desnecessários.

## 13. Segregação dos dois instaladores

### Corporativo

- exige estação no Active Directory;
- destinado a implantação institucional;
- não deve possuir override de ambiente local.

### Homologação local

- destinado apenas a laboratório;
- pode operar fora do AD;
- mantém assinatura, integridade, Helper e políticas;
- deve ser mantido explicitamente identificado no nome e nas notas da Release.

## 14. Distribuição em AD/GPO

Para implantação em massa:

- usar grupo/OU piloto;
- restringir acesso ao compartilhamento de distribuição;
- validar hash antes da execução;
- executar como SYSTEM/administrador;
- expandir em ondas;
- manter pacote anterior disponível;
- não armazenar chaves privadas em SYSVOL ou compartilhamento de software.

Consulte [Distribuição corporativa AD/GPO](docs/12-DISTRIBUICAO-CORPORATIVA-AD-GPO.md).

## 15. Resposta a incidentes

Em suspeita de comprometimento de chave, alteração do instalador, execução inesperada, perda de dados ou distribuição indevida:

1. interrompa novas instalações;
2. suspenda a Release afetada para novos usos;
3. preserve `.exe`, `.sha256`, manifesto, logs e estado;
4. identifique lote/estações afetadas;
5. não apague evidências;
6. comunique GERDO, TI e Segurança da Informação;
7. avalie reparo, reversão ou rotação de credenciais/chaves;
8. retome somente após nova validação.

## 16. Rotação da chave da extensão

Rotacionar a PEM muda a identidade calculada da extensão. Portanto não é uma atualização normal.

Em caso de comprometimento da PEM:

- suspenda a distribuição;
- preserve evidências;
- trate como incidente de identidade;
- avalie estratégia de migração de dados;
- não gere uma nova chave e publique silenciosamente como se fosse atualização comum.
