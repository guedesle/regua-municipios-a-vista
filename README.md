# Régua Editorial SieDOE — Municípios à Vista

Repositório privado de **distribuição, documentação operacional e homologação** da Régua Editorial SieDOE destinada ao fluxo do Caderno Municípios.

Este repositório não contém o código-fonte de desenvolvimento. O código, testes e pipeline de build permanecem no repositório privado `guedesle/calculadora-editorial`.

## Entrega disponível

| Componente | Versão |
|---|---:|
| Setup Windows | `1.0.0` |
| Extensão Chrome | `0.7.3` |
| Native Helper | `0.1.4` |
| Contrato Native Messaging | `1.2.0` |
| IndexedDB/schema | `3` |
| Canal | `pilot` |

**Extension ID operacional:** `chdfbekdjpecdajbpdelmhpemenoelmd`  
**Native host:** `com.egba.regua_editorial.helper`

## Download do instalador

O instalador deve ser obtido na área **Releases** deste repositório:

```text
ReguaEditorial-Entrega1-Setup-x64.exe
```

O arquivo de verificação correspondente deve acompanhar a entrega:

```text
ReguaEditorial-Entrega1-Setup-x64.exe.sha256
```

Não usar executáveis recebidos fora da Release oficial ou sem conferência do SHA-256.

## Requisitos da estação

- Windows x64;
- Google Chrome;
- estação associada ao Active Directory da empresa;
- privilégio administrativo apenas durante a instalação;
- Microsoft Word desktop para conversão automática de DOC e RTF.

O Helper é autocontido. A estação não precisa possuir Node.js, Git, NSIS ou .NET 8 previamente instalado.

## Documentação

1. [Guia de instalação](docs/01-GUIA-DE-INSTALACAO.md)
2. [Guia de homologação](docs/02-GUIA-DE-HOMOLOGACAO.md)
3. [Operação e suporte](docs/03-OPERACAO-E-SUPORTE.md)
4. [Plano de rollback](docs/04-PLANO-DE-ROLLBACK.md)
5. [Arquitetura de distribuição](docs/05-ARQUITETURA-DE-DISTRIBUICAO.md)
6. [Checklist de entrega](docs/06-CHECKLIST-DE-ENTREGA.md)
7. [Inventário da release](docs/07-INVENTARIO-DA-RELEASE.md)

## Segurança

- a chave PEM da extensão não pertence a este repositório;
- não anexar documentos de produção, credenciais, cookies, tokens ou conteúdo de matérias;
- logs e evidências devem ser sanitizados;
- o executável deve ser distribuído somente por Release privada e para a equipe autorizada.

Consulte também [SECURITY.md](SECURITY.md).