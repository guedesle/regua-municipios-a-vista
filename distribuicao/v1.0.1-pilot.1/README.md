# Pacote v1.0.1-pilot.1

Esta é a pasta versionada dos artefatos da Entrega 1.0.1. Os executáveis são rastreados por Git LFS e cada um deve estar acompanhado de seu `.sha256`.

## Conteúdo obrigatório

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256
```

Se algum `.exe` não aparecer nesta pasta, o pacote remoto está incompleto e não deve ser usado como fonte de instalação.

## Qual instalador usar

| Ambiente | Instalador |
|---|---|
| estação corporativa ingressada no Active Directory | `ReguaEditorial-Entrega1-Corporativo-x64.exe` |
| laboratório fora do domínio | `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe` |

Sempre valide o `.sha256` de mesmo nome antes de executar.

> `HomologacaoLocal` é somente para laboratório. Não o utilize para rollout institucional.

## Documentação oficial

- [Instalação corporativa](../../docs/instalacao/CORPORATIVO.md)
- [Homologação local](../../docs/instalacao/HOMOLOGACAO-LOCAL.md)
- [Distribuição AD/GPO](../../docs/instalacao/AD-GPO.md)
- [Guia rápido de uso](../../docs/uso/GUIA-RAPIDO.md)
- [Suporte](../../docs/uso/SUPORTE.md)
- [Referência técnica](../../docs/tecnico/README.md)
- [Motor editorial](../../docs/motor/ESPECIFICACAO.md)
- [Qualidade/homologação](../../docs/qualidade/HOMOLOGACAO.md)

Não duplique a documentação nesta pasta: os links acima são a fonte canônica.

## Segurança

Não coloque aqui PEM/PFX/chaves privadas, credenciais, documentos de produção ou cópia do IndexedDB.