# Atualização e rollback

## Invariantes

Toda atualização deve preservar:

```text
Extension ID: chdfbekdjpecdajbpdelmhpemenoelmd
Native host:  com.egba.regua_editorial.helper
```

Também devem ser preservados:

- a PEM institucional da extensão;
- compatibilidade do Native Messaging;
- dados/migração do IndexedDB;
- políticas Chrome próprias sem apagar entradas de terceiros;
- versão anterior para recuperação.

## Atualização

Fluxo recomendado:

```text
nova versão
→ testes automatizados
→ CRX com a mesma PEM
→ validar Extension ID
→ gerar Setup(s)
→ QA dos artefatos
→ piloto
→ validar dados e uso
→ publicar
→ expandir
```

A versão da extensão deve crescer monotonicamente. Não dependa de downgrade direto do Chrome.

## Piloto atual

O bootstrap standalone usa cache local:

```text
%ProgramData%\EGBA\ReguaEditorial\extension-cache\<versão>\
```

O modelo futuro pode migrar para `update.xml`/CRX em HTTPS corporativo, mantendo a mesma PEM e o mesmo Extension ID.

## IndexedDB

Antes e depois de atualização relevante, valide em amostra:

- quantidade de cálculos;
- período dos registros;
- totais agregados;
- consultas representativas;
- exportação CSV/JSON.

Nunca use limpeza do IndexedDB como procedimento normal de atualização.

## Rollback

Ordem de preferência:

1. suspender novas instalações;
2. reparar a estação;
3. conter apenas o fluxo afetado;
4. publicar versão numericamente superior com o comportamento anteriormente aprovado;
5. remover integralmente somente como último recurso.

Antes de ação destrutiva:

- exporte os dados quando possível;
- registre quantidade/período/totais;
- preserve o perfil Chrome;
- confirme o Extension ID;
- obtenha autorização quando houver descarte.

## Remoção integral

Remover a extensão/políticas ou limpar o perfil pode afetar o IndexedDB. A confirmação técnica para descarte controlado é:

```text
EXPORTED_OR_DISCARD_AUTHORIZED
```

## Pilot → stable

Requisitos mínimos:

- assinatura corporativa reconhecida;
- QA dos binários;
- piloto representativo;
- EDR/antivírus validado;
- atualização corporativa definida;
- rollback testado;
- documentação e inventário fechados;
- aceite funcional e técnico.

## Regra de rastreabilidade

Depois que um binário for homologado, não o reconstrua silenciosamente para publicação. O SHA-256 publicado deve corresponder exatamente ao binário testado.