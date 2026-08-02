# Arquitetura de distribuição — Entrega 1

## 1. Separação de responsabilidades

```text
guedsle/calculadora-editorial
└── código-fonte, testes, build e engenharia

guedsle/regua-municipios-a-vista
└── documentação operacional, Releases e evidências de entrega
```

O repositório de distribuição não deve receber código-fonte, `node_modules`, artefatos intermediários, chave PEM ou material de desenvolvimento.

## 2. Pacote distribuído

```text
ReguaEditorial-Entrega1-Setup-x64.exe
```

O Setup incorpora:

- extensão Chrome `0.7.3` em CRX;
- Helper `0.1.4` publicado como `win-x64 self-contained`;
- scripts de instalação, reparo e remoção;
- manifesto de atualização local;
- manifesto da release e inventário SHA-256;
- certificado público temporário de laboratório;
- componentes necessários à instalação.

## 3. Dependências da estação

A estação de destino precisa somente de:

- Windows x64;
- Google Chrome;
- associação ao Active Directory;
- privilégio administrativo durante a instalação;
- Word desktop para DOC e RTF automáticos.

Não são necessários na estação:

- Node.js ou npm;
- Git;
- NSIS;
- SDK ou Runtime .NET 8 previamente instalado;
- acesso ao repositório de desenvolvimento;
- Chrome Web Store.

## 4. Instalação da extensão

A extensão é instalada de forma gerenciada por políticas locais em HKLM:

```text
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist
HKLM\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionSettings
```

Identidade operacional:

- Extension ID: `chdfbekdjpecdajbpdelmhpemenoelmd`;
- Native host: `com.egba.regua_editorial.helper`.

O bootstrap inicial usa um CRX incorporado e manifesto local dentro de `%ProgramData%`. Atualizações futuras podem migrar para HTTPS corporativo mantendo a mesma PEM e o mesmo ID.

## 5. Diretórios instalados

```text
%ProgramFiles%\EGBA\ReguaEditorial\
%ProgramFiles%\EGBA\ReguaEditorialHelper\
%ProgramData%\EGBA\ReguaEditorial\extension-cache\
%ProgramData%\EGBA\ReguaEditorial\state\
%ProgramData%\EGBA\ReguaEditorial\Logs\
```

## 6. Distribuição pelo GitHub

A árvore Git contém somente documentação. O executável e seu hash são ativos de uma Release privada.

Estrutura recomendada da Release:

```text
Tag: v1.0.0-pilot.1
Título: Entrega 1 — Piloto operacional
Ativos:
├── ReguaEditorial-Entrega1-Setup-x64.exe
└── ReguaEditorial-Entrega1-Setup-x64.exe.sha256
```

## 7. Controles

- Release privada e acesso restrito;
- hash SHA-256 obrigatório;
- mesma PEM em todas as atualizações;
- nenhum segredo no repositório;
- promoção de piloto para estável somente após homologação;
- preservação do pacote anterior para rollback;
- logs sem conteúdo documental.