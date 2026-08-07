<div align="center">

# Régua Editorial SieDOE

**Distribuição corporativa — Caderno Municípios / EGBANET**

</div>

> **Piloto interno da EGBA.** Este repositório contém instaladores, documentação e scripts de distribuição. O código-fonte permanece no repositório de desenvolvimento.

## Comece aqui

| Você precisa… | Abra |
|---|---|
| instalar em estação corporativa | [Instalação corporativa](docs/instalacao/CORPORATIVO.md) |
| testar fora do domínio | [Homologação local](docs/instalacao/HOMOLOGACAO-LOCAL.md) |
| distribuir por AD/GPO | [Distribuição AD/GPO](docs/instalacao/AD-GPO.md) |
| orientar o usuário | [Guia rápido de uso](docs/uso/GUIA-RAPIDO.md) |
| resolver uma falha | [Suporte e diagnóstico](docs/uso/SUPORTE.md) |
| consultar arquitetura/segurança | [Referência técnica](docs/tecnico/README.md) |
| consultar regras editoriais | [Motor de transformação](docs/motor/ESPECIFICACAO.md) |
| homologar | [Qualidade e homologação](docs/qualidade/HOMOLOGACAO.md) |

[Índice completo da documentação](docs/README.md)

## Qual instalador usar?

| Ambiente | Arquivo |
|---|---|
| estação corporativa ingressada no Active Directory | `ReguaEditorial-Entrega1-Corporativo-x64.exe` |
| laboratório fora do domínio | `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe` |

Os binários versionados ficam em [`distribuicao/v1.0.1-pilot.1/`](distribuicao/v1.0.1-pilot.1/). A Release correspondente continua sendo o canal formal de publicação.

> Sempre valide o `.sha256` de mesmo nome. O instalador `HomologacaoLocal` não deve ser usado em rollout institucional.

## Baseline atual

| Item | Valor |
|---|---|
| Release | `v1.0.1-pilot.1` |
| Setup | `1.0.1` |
| Extensão | `0.7.4` |
| Regras editoriais | `municipios-editorial-rules@1.3.0` |
| Helper | `0.1.4` |
| Native Messaging | `1.2.0` |
| IndexedDB | schema `3` |
| Extension ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |

## Em uma frase

A extensão abre um painel no EGBANET, prepara o documento segundo as regras editoriais, mede e calcula a publicação, salva o resultado localmente e oferece consultas/relatórios. DOC/RTF usam o Helper Windows + Microsoft Word; DOCX é processado diretamente.

## Estrutura do repositório

```text
README.md          # entrada única
distribuicao/      # binários versionados + hashes
docs/              # documentação por tarefa
release/           # notas de release
scripts/           # implantação e publicação
SECURITY.md        # política de segurança
```

## Segurança essencial

Nunca versione ou distribua junto com o pacote:

- PEM/PFX/chaves privadas;
- senhas, tokens ou cookies;
- documentos de produção;
- cópia do IndexedDB de usuários.

O canal `stable` depende de assinatura corporativa reconhecida e nova homologação da cadeia de distribuição.