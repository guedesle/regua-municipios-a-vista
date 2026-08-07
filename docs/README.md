# Documentação — Régua Editorial SieDOE

Use esta página como índice. Se você chegou ao repositório para instalar ou orientar um usuário, não é necessário ler toda a documentação técnica.

## Escolha o que precisa fazer

| Objetivo | Comece aqui |
|---|---|
| Instalar em estação corporativa | [Instalação corporativa](instalacao/CORPORATIVO.md) |
| Testar fora do domínio | [Homologação local](instalacao/HOMOLOGACAO-LOCAL.md) |
| Implantar em várias estações / GPO | [Distribuição AD/GPO](instalacao/AD-GPO.md) |
| Orientar o operador | [Guia rápido de uso](uso/GUIA-RAPIDO.md) |
| Resolver uma falha | [Suporte e diagnóstico](uso/SUPORTE.md) |
| Entender arquitetura e segurança | [Referência técnica](tecnico/README.md) |
| Consultar as regras do motor editorial | [Especificação do motor de transformação](motor/ESPECIFICACAO.md) |
| Homologar uma instalação ou release | [Qualidade e homologação](qualidade/HOMOLOGACAO.md) |

## Baseline desta distribuição

| Item | Valor |
|---|---|
| Release | `v1.0.1-pilot.1` |
| Setup | `1.0.1` |
| Extensão | `0.7.4` |
| Regras editoriais | `municipios-editorial-rules@1.3.0` |
| Helper | `0.1.4` |
| Contrato Native Messaging | `1.2.0` |
| IndexedDB | schema `3` |
| Extension ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |

## Estrutura da documentação

```text
docs/
├── instalacao/   # instalar e distribuir
├── uso/          # operar e suportar
├── tecnico/      # arquitetura, extensão, segurança e atualização
├── motor/        # regras de transformação editorial
└── qualidade/    # homologação e critérios de aceite
```

A documentação histórica removida da árvore ativa continua disponível no histórico Git. Isso evita que instruções antigas concorram com a baseline atual.