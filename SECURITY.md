# Segurança da distribuição — Régua Editorial SieDOE

Esta política define os controles mínimos para publicar, implantar e suportar a Régua Editorial no ambiente interno da EGBA.

## Identidade operacional

```text
Extension ID: chdfbekdjpecdajbpdelmhpemenoelmd
Native host:  com.egba.regua_editorial.helper
```

A PEM privada que mantém o Extension ID nunca deve ser versionada, anexada à Release ou distribuída com o Setup.

## Materiais permitidos

- instaladores `.exe`;
- `.sha256` correspondente;
- documentação de distribuição;
- scripts administrativos sem segredos;
- notas e evidências sanitizadas de homologação.

## Materiais proibidos

- PEM/PFX/P12/KEY ou senha de certificado;
- cookies, tokens, senhas ou outras credenciais;
- documentos ou conteúdo de matérias de produção;
- dumps de IndexedDB/perfil Chrome;
- staging, `node_modules` ou material de build desnecessário.

## Integridade

Antes de executar qualquer Setup:

1. confirme a origem oficial;
2. valide o SHA-256;
3. confirme o nome/tipo do instalador;
4. interrompa diante de divergência.

O piloto utiliza certificado temporário de laboratório. O canal `stable` exige assinatura corporativa reconhecida e nova homologação.

## Superfície da extensão

- Manifest V3;
- host permission restrita a `https://egbanet.egba.ba.gov.br/*`;
- content scripts restritos às rotas de matéria;
- Native Messaging limitado ao host `com.egba.regua_editorial.helper` e à origem do Extension ID operacional;
- dados de cálculo no IndexedDB local ao perfil.

Qualquer ampliação dessa superfície exige nova revisão de segurança.

## Dados e suporte

Não use limpeza de perfil Chrome ou remoção da extensão como troubleshooting rotineiro. Antes de ação destrutiva, preserve/exporte os cálculos e confirme o mesmo perfil e Extension ID.

Logs podem conter versões, horários, códigos e estados técnicos necessários, mas não devem conter conteúdo documental, credenciais ou dumps integrais de dados.

## DOC/RTF

A conversão via Word/Helper deve trabalhar sobre cópia/temporário, manter o original, desabilitar macros e remover temporários ao final. Sobrescrita do original ou execução de macro é incidente crítico.

## Resposta a incidente

Diante de suspeita de chave comprometida, instalador alterado, perda de dados ou distribuição indevida:

1. suspenda novas instalações;
2. preserve binários, hashes, manifesto, logs e estado;
3. identifique o lote afetado;
4. não apague evidências;
5. envolva TI e Segurança da Informação;
6. só retome após validação e autorização.

## Referências

- [Segurança e identidade](docs/tecnico/SEGURANCA-E-IDENTIDADE.md)
- [Extensão MV3](docs/tecnico/EXTENSAO-MV3.md)
- [Atualização e rollback](docs/tecnico/ATUALIZACAO-E-ROLLBACK.md)
- [Distribuição AD/GPO](docs/instalacao/AD-GPO.md)
