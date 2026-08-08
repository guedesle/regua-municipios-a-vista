# Distribuição versionada

Cada subpasta corresponde a uma versão da entrega e deve conter os dois instaladores e seus respectivos `.sha256`.

## Versão atual

[`v1.0.1-pilot.1`](v1.0.1-pilot.1/)

O pacote só é considerado completo quando os quatro ativos estiverem presentes:

```text
Instalação corporativa
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256

Instalação local
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256
```

O nome técnico `HomologacaoLocal` permanece no executável desta Release apenas por rastreabilidade do artefato gerado. A modalidade funcional e documental é **Instalação local**.

Os `.exe` são rastreados por Git LFS. A documentação operacional fica em [`../docs/`](../docs/) e não deve ser duplicada dentro de cada versão.