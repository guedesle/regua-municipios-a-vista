# Scripts de distribuição

```text
scripts/
├── implantacao/
│   └── Instalar-Corporativo-GPO.ps1
└── release/
    ├── Publicar-Release.ps1
    └── Validar-Release-Publicada.ps1
```

## Implantação

`implantacao/Instalar-Corporativo-GPO.ps1` instala o Setup Corporativo em estação ingressada no AD, valida hash, executa em modo silencioso e verifica o estado final.

## Release

`release/Publicar-Release.ps1` publica os dois instaladores e seus `.sha256` e baixa os ativos novamente para validar os hashes.

`release/Validar-Release-Publicada.ps1` audita independentemente os ativos já publicados.

Os scripts não contêm nem devem receber a PEM privada da extensão ou outra credencial.