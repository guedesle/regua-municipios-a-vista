# Extensão Chrome — Manifest V3

## Identificação

```text
Nome:         Régua Editorial SieDOE
Versão:       0.7.4
Manifest:     V3
Extension ID: chdfbekdjpecdajbpdelmhpemenoelmd
Native host:  com.egba.regua_editorial.helper
```

## Superfície de acesso

Host permission:

```text
https://egbanet.egba.ba.gov.br/*
```

Content scripts somente em:

```text
https://egbanet.egba.ba.gov.br/admin/materias/edit/*
https://egbanet.egba.ba.gov.br/admin/materias/edicao_restrita/*
```

Não há host permission global para toda a web.

## Permissões

| Permissão | Uso |
|---|---|
| `sidePanel` | interface principal |
| `activeTab` | contexto da aba ativa |
| `tabs` | coordenação de abas e ativação |
| `downloads` | operações autorizadas com arquivos |
| `downloads.open` | abertura de download quando necessário |
| `storage` | preferências/estado local |
| `nativeMessaging` | comunicação com o Helper Windows |

Qualquer ampliação de permissões ou host deve reabrir revisão de segurança.

## Estrutura lógica

```text
Action/ícone
├── Side Panel
├── Background service worker (module)
├── Content script EGBANET
├── Página de consultas/relatórios
├── armazenamento local / IndexedDB
└── Native Messaging
    └── ReguaEditorial.Helper.exe
```

## Native Messaging

Manifesto instalado:

```text
%ProgramFiles%\EGBA\ReguaEditorialHelper\com.egba.regua_editorial.helper.json
```

Origem autorizada:

```text
chrome-extension://chdfbekdjpecdajbpdelmhpemenoelmd/
```

Registro:

```text
HKLM\Software\Google\Chrome\NativeMessagingHosts\com.egba.regua_editorial.helper
```

O host não usa wildcard de origem.

## Documentos

- DOCX: processado diretamente pela extensão/motor.
- DOC/RTF: convertido por cópia via Helper + Microsoft Word COM e retornado como DOCX temporário validado.
- O original não deve ser sobrescrito.

## Persistência

Os cálculos operacionais ficam no IndexedDB, schema `3`, associado ao perfil Chrome e à origem da extensão.

Não devem ser persistidos como dado funcional:

- conteúdo integral do documento;
- DOCX temporário de conversão;
- HTML integral da matéria;
- cookies/tokens/credenciais.

## Interfaces administrativas

```text
chrome://extensions
chrome://policy
```

Use-as para conferir versão, ID, instalação gerenciada e políticas efetivas.

## Continuidade de identidade

A mesma PEM da extensão deve ser usada em todas as atualizações dessa identidade. Trocar a PEM tende a gerar outro Extension ID e afeta políticas, Native Messaging e origem do IndexedDB.