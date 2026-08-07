# Segurança e identidade da distribuição

## Duas identidades criptográficas

### PEM da extensão

Define a identidade do CRX e mantém o Extension ID:

```text
chdfbekdjpecdajbpdelmhpemenoelmd
```

A PEM privada:

- não entra no Git;
- não entra no Setup;
- não entra na Release;
- deve permanecer em cofre institucional;
- deve ser reutilizada para atualizar a mesma extensão.

### Certificado Authenticode

Assina Setup e componentes Windows. No piloto é temporário/de laboratório; o canal `stable` exige certificado corporativo reconhecido.

Trocar Authenticode não exige trocar o Extension ID. Trocar a PEM da extensão é uma migração de identidade.

## Matriz de controles

| Superfície | Controle |
|---|---|
| acesso web | host limitado ao EGBANET |
| content script | apenas duas rotas de matéria |
| Native Messaging | host específico + allowed origin específico |
| CRX | ID validado contra a PEM operacional |
| Setup | SHA-256 externo + Authenticode |
| payload interno | `SHA256SUMS.txt` + manifesto + assinaturas |
| políticas Chrome | alteração somente das entradas necessárias |
| dados | IndexedDB local ao perfil; sem conteúdo documental persistido pelo fluxo funcional |
| DOC/RTF | cópia temporária + Word local + preservação do original |

## Políticas administradas

```text
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist
HKLM\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionSettings
```

O instalador registra estado anterior/próprio para suporte e rollback. Não remova a árvore inteira de políticas para desinstalar a Régua.

## Dados proibidos no repositório e nas evidências

- PEM privada;
- PFX/P12/KEY e senhas;
- tokens e credenciais;
- documentos de produção;
- conteúdo de matérias;
- cookies de sessão;
- cópia integral do IndexedDB.

## Piloto x stable

O piloto pode apresentar publisher não reconhecido antes da confiança do certificado temporário. Por isso, SHA-256 e origem oficial são obrigatórios.

Para `stable`:

- certificado de Code Signing corporativo reconhecido;
- processo formal de custódia/renovação;
- validação EDR/SmartScreen;
- nova homologação da cadeia de distribuição.

## Quando reabrir revisão de segurança

- nova permissão Chrome;
- novo host ou rota de content script;
- mudança em Native Messaging;
- mudança no Word COM;
- novo tipo de dado persistido;
- mudança de schema IndexedDB;
- nova política de distribuição/atualização;
- troca de chave/Extension ID.

Consulte também [`SECURITY.md`](../../SECURITY.md).