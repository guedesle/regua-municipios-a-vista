# Entrega 1 — Piloto operacional

Primeira distribuição operacional da **Régua Editorial SieDOE — Municípios à Vista**, destinada a um grupo restrito de estações Windows da empresa.

## Componentes

- Setup Windows: `1.0.0`;
- extensão Chrome: `0.7.3`;
- Native Helper: `0.1.4`;
- contrato Native Messaging: `1.2.0`;
- IndexedDB/schema: `3`;
- canal: `pilot`.

## Identidade operacional

- Extension ID: `chdfbekdjpecdajbpdelmhpemenoelmd`;
- Native host: `com.egba.regua_editorial.helper`.

## Conteúdo da Release

```text
ReguaEditorial-Entrega1-Setup-x64.exe
ReguaEditorial-Entrega1-Setup-x64.exe.sha256
```

O Setup incorpora a extensão CRX, o Helper autocontido, scripts administrativos, manifesto local, hashes e os componentes necessários à instalação.

## Requisitos

- Windows x64;
- Google Chrome;
- estação associada ao Active Directory;
- instalação executada com privilégio administrativo;
- Microsoft Word desktop para conversão automática de DOC e RTF.

O Word não é obrigatório para DOCX, medição, cálculo e relatórios.

## Instalação

1. baixar os dois arquivos da Release;
2. conferir o SHA-256 conforme o guia de instalação;
3. fechar completamente o Chrome;
4. executar o Setup como administrador;
5. reabrir o Chrome;
6. conferir políticas, versão e Extension ID;
7. executar a matriz de homologação.

## Situação

Esta é uma **pré-release de piloto**. A promoção para canal estável depende da homologação funcional e técnica registrada pela GERDO e pela GERINF/TI.

## Segurança

Não distribuir a chave PEM da extensão. Não anexar documentos, conteúdo de matérias, credenciais, cookies, tokens ou dados reais de clientes às evidências de homologação.