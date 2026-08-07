# Matriz de permissões e controles — Extensão Régua Editorial

Este documento apoia revisão de segurança, governança de navegador e aprovação de implantação corporativa.

## 1. Identidade

```text
Extensão:     Régua Editorial SieDOE
Versão:       0.7.4
Manifest:     V3
Extension ID: chdfbekdjpecdajbpdelmhpemenoelmd
Native host:  com.egba.regua_editorial.helper
```

## 2. Permissões Chrome

| Permissão | Necessidade funcional | Superfície de risco | Controle aplicado |
|---|---|---|---|
| `sidePanel` | abrir a interface principal no painel lateral | UI persistente no navegador | habilitação ligada ao fluxo da extensão |
| `activeTab` | operar sobre a aba ativa compatível | acesso temporário à aba | host/content script restritos ao EGBANET |
| `tabs` | detectar/navegar contexto de abas | metadados de abas | uso limitado ao fluxo funcional |
| `downloads` | suportar operações de arquivos autorizadas | criação/gestão de downloads | conteúdo documental não deve ser persistido em logs |
| `downloads.open` | abrir download quando necessário | interação com arquivo local | somente fluxo iniciado pela aplicação/usuário |
| `storage` | preferências/estado | persistência local | sem credenciais; dados funcionais separados |
| `nativeMessaging` | comunicação com Helper Windows | execução de componente nativo | host específico + allowed origin específico |

## 3. Host permission

```text
https://egbanet.egba.ba.gov.br/*
```

Controle: não há wildcard global `http://*/*` ou `https://*/*`.

## 4. Content scripts

```text
https://egbanet.egba.ba.gov.br/admin/materias/edit/*
https://egbanet.egba.ba.gov.br/admin/materias/edicao_restrita/*
```

Controle: o script de integração não é injetado em páginas arbitrárias da web.

## 5. Native Messaging

| Controle | Valor |
|---|---|
| host | `com.egba.regua_editorial.helper` |
| tipo | `stdio` |
| instalação | por máquina |
| allowed origin | `chrome-extension://chdfbekdjpecdajbpdelmhpemenoelmd/` |
| executável | `%ProgramFiles%\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe` |

O manifesto do host não autoriza outras extensões por wildcard.

## 6. Políticas Chrome

| Política | Uso | Controle de coexistência |
|---|---|---|
| `ExtensionInstallForcelist` | manter extensão instalada | procura slot da própria extensão ou aloca slot livre |
| `NativeMessagingAllowlist` | autorizar host nativo | procura valor existente ou aloca slot livre |
| `ExtensionSettings` | `force_installed` + update URL | altera apenas entrada do Extension ID |

Estado anterior é registrado para suporte e rollback.

## 7. Registro Native Messaging

```text
HKLM\Software\Google\Chrome\NativeMessagingHosts\com.egba.regua_editorial.helper
```

Criado nas visões 32 e 64 bits.

## 8. Armazenamento

| Dado | Local | Observação |
|---|---|---|
| cálculos | IndexedDB do perfil Chrome | associado à origem da extensão |
| preferências/estado de extensão | storage do Chrome | local ao perfil |
| estado administrativo | `%ProgramData%\EGBA\ReguaEditorial\state` | instalação/políticas |
| logs | `%ProgramData%\EGBA\ReguaEditorial\Logs` | diagnóstico sanitizado |
| CRX/update.xml | `%ProgramData%\EGBA\ReguaEditorial\extension-cache` | bootstrap local |

## 9. Dados que não devem ser persistidos

- conteúdo integral de DOCX/DOC/RTF;
- DOCX temporário convertido;
- HTML completo da matéria;
- cookie/token de sessão;
- senha/credencial;
- chave privada da extensão;
- chave privada de assinatura.

## 10. Conversão DOC/RTF

Risco: automação de aplicativo Office e processamento de formato legado.

Controles previstos:

- Word desktop local;
- documento em cópia/temporário;
- somente leitura;
- macros desabilitadas;
- validação de formato;
- limpeza de temporários;
- Helper controlado e assinado.

## 11. Identidade da extensão

A chave pública incorporada ao Manifest define a identidade estável.

Controle de supply chain:

- build exige PEM correspondente;
- ID calculado deve coincidir com `chdfbekdjpecdajbpdelmhpemenoelmd`;
- divergência deve interromper o build/instalação.

## 12. Integridade do pacote

Camadas:

```text
SHA-256 externo do Setup
→ Authenticode do Setup
→ SHA256SUMS interno
→ Authenticode dos componentes
→ release-manifest.json
→ validação de versão/ID
```

## 13. Diferença entre os instaladores

| Controle | Corporativo | Homologação local |
|---|---:|---:|
| Windows x64 | obrigatório | obrigatório |
| administrador | obrigatório | obrigatório |
| SHA-256 | obrigatório | obrigatório |
| assinaturas | obrigatório | obrigatório |
| Helper | obrigatório | obrigatório |
| políticas Chrome | obrigatório | obrigatório |
| Extension ID | obrigatório | obrigatório |
| Active Directory | obrigatório | dispensado para laboratório |

## 14. Revisão obrigatória

Nova análise de segurança é necessária se houver mudança em:

- permissões Chrome;
- host permission;
- content script matches;
- native host/allowed origins;
- dados persistidos;
- Word COM;
- política de atualização;
- Extension ID;
- chaves/certificados;
- instalação silenciosa/GPO;
- schema IndexedDB.
