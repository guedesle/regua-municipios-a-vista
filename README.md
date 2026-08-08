<div align="center">

# Régua Editorial SieDOE

**Distribuição corporativa — Caderno Municípios / EGBANET**

</div>

> **Piloto interno da EGBA.** Este repositório contém os materiais de distribuição, documentação e scripts. O código-fonte permanece no repositório de desenvolvimento.

## Comece aqui

| Você precisa… | Abra |
|---|---|
| instalar em estação corporativa | [Instalação corporativa](docs/instalacao/CORPORATIVO.md) |
| instalar em estação local fora do domínio | [Instalação local](docs/instalacao/INSTALACAO-LOCAL.md) |
| distribuir por AD/GPO | [Distribuição AD/GPO](docs/instalacao/AD-GPO.md) |
| orientar o usuário | [Guia rápido de uso](docs/uso/GUIA-RAPIDO.md) |
| resolver uma falha | [Suporte e diagnóstico](docs/uso/SUPORTE.md) |
| consultar arquitetura/segurança | [Referência técnica](docs/tecnico/README.md) |
| consultar regras editoriais | [Motor de transformação](docs/motor/ESPECIFICACAO.md) |
| homologar | [Qualidade e homologação](docs/qualidade/HOMOLOGACAO.md) |

[Índice completo da documentação](docs/README.md)

## Qual instalador usar?

| Modalidade | Ambiente | Arquivo |
|---|---|---|
| Instalação corporativa | estação ingressada no Active Directory | `ReguaEditorial-Entrega1-Corporativo-x64.exe` |
| Instalação local | estação/laboratório fora do domínio | `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe` |

O pacote versionado fica em [`distribuicao/v1.0.1-pilot.1/`](distribuicao/v1.0.1-pilot.1/). Ele só deve ser usado como fonte de instalação quando os dois `.exe` e seus dois `.sha256` estiverem presentes.

> Sempre valide o `.sha256` de mesmo nome. A **Instalação local** não deve ser usada em rollout institucional. O nome técnico do executável local permanece `HomologacaoLocal` nesta Release por rastreabilidade do artefato já gerado.

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

## O produto

A extensão abre um painel no EGBANET, prepara o documento segundo as regras editoriais, mede e calcula a publicação, salva o resultado localmente e oferece consultas/relatórios. DOC/RTF usam o Helper Windows + Microsoft Word; DOCX é processado diretamente.

## Estrutura do repositório

```text
README.md          # entrada única
distribuicao/      # pacotes versionados e hashes
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