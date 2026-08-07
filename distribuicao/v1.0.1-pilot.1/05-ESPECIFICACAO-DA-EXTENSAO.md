# Especificação técnica da extensão — Régua Editorial SieDOE 0.7.4

Este documento descreve a extensão Chrome distribuída na Entrega 1.0.1. O objetivo é permitir avaliação técnica, segurança, suporte e implantação corporativa sem depender do repositório de desenvolvimento.

## 1. Identificação

| Campo | Valor |
|---|---|
| Nome | Régua Editorial SieDOE |
| Nome curto | Régua SieDOE |
| Versão | `0.7.4` |
| Manifest | V3 |
| Extension ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Canal de distribuição | `pilot` |
| Regras editoriais | `municipios-editorial-rules@1.3.0` |
| Native host | `com.egba.regua_editorial.helper` |

Descrição funcional do manifesto:

> Prepara, mede, calcula e registra localmente matérias do Caderno Municípios no Egbanet.

## 2. Identidade criptográfica

A extensão possui chave pública operacional incorporada ao Manifest. O Chrome deriva a identidade estável da extensão dessa chave.

A chave privada correspondente:

- não faz parte deste repositório;
- não é incluída no CRX;
- não é incluída no Setup;
- deve permanecer sob custódia institucional;
- deve ser reutilizada em todas as atualizações desta identidade.

Trocar a chave privada gera outro Extension ID e deve ser tratado como migração de produto, não como atualização comum.

## 3. Manifest V3

A extensão utiliza:

- background `service_worker`;
- `type: module`;
- `side_panel`;
- `options_ui` aberta em aba;
- content scripts específicos;
- Native Messaging.

Estrutura lógica:

```text
Chrome
├── Action / ícone
├── Side Panel
├── Background Service Worker
├── Content Script no EGBANET
├── Página de relatórios/opções
├── Storage / IndexedDB
└── Native Messaging
        └── ReguaEditorial.Helper.exe
```

## 4. Permissões Chrome

Permissões declaradas:

```text
sidePanel
activeTab
tabs
downloads
downloads.open
storage
nativeMessaging
```

### `sidePanel`

Permite a interface principal no painel lateral do Chrome.

### `activeTab` e `tabs`

Permitem identificar a aba ativa e coordenar a ativação da Régua nas páginas compatíveis.

### `downloads` e `downloads.open`

Suportam fluxos autorizados relacionados a arquivos quando necessários pela aplicação. A conversão automática DOC/RTF da linha atual utiliza o Native Helper e não deve depender de persistência permanente do conteúdo convertido.

### `storage`

Usado para preferências/estado da extensão. Os cálculos operacionais são mantidos no armazenamento local do navegador conforme a arquitetura da aplicação.

### `nativeMessaging`

Permite comunicação com o Helper Windows registrado como `com.egba.regua_editorial.helper`.

## 5. Host permissions

O Manifest restringe acesso de host a:

```text
https://egbanet.egba.ba.gov.br/*
```

Não há host permission genérica para toda a web.

Qualquer ampliação desse domínio deve ser tratada como mudança de superfície de segurança.

## 6. Content scripts

O content script é carregado somente em:

```text
https://egbanet.egba.ba.gov.br/admin/materias/edit/*
https://egbanet.egba.ba.gov.br/admin/materias/edicao_restrita/*
```

Execução:

```text
run_at = document_idle
```

Em outras páginas a extensão não deve executar o mesmo fluxo de leitura/integração da matéria.

## 7. Side Panel

A ação do ícone abre o painel lateral da Régua Editorial nas páginas compatíveis.

O painel concentra:

- identificação da matéria;
- preparação/processamento do documento;
- prévia;
- medição;
- cálculo;
- persistência do resultado;
- acesso aos fluxos relacionados.

## 8. Página de relatórios

A extensão possui `options_ui` aberta em aba para consultas e relatórios locais.

Funções previstas na Entrega 1:

- consulta por data;
- intervalo de datas;
- protocolo;
- cliente;
- recuperação de cálculos persistidos;
- exportação CSV;
- exportação JSON;
- retorno à matéria no EGBANET quando houver vínculo disponível.

## 9. Persistência local

O armazenamento funcional utiliza IndexedDB, schema `3`.

Características:

- armazenamento local ao perfil Chrome;
- sem banco de dados externo nesta entrega;
- registros associados à origem da extensão;
- exportação CSV/JSON;
- persistência de dados do cálculo, não do conteúdo documental.

Impactos operacionais:

- outro perfil Chrome não enxerga automaticamente os mesmos registros;
- limpeza de dados do navegador pode remover os cálculos;
- remoção da extensão pode afetar o armazenamento;
- troca de Extension ID cria outra origem de dados.

## 10. Processamento de documentos

### DOCX

Processado diretamente pela extensão/motor editorial.

### DOC e RTF

Fluxo automático:

```text
Extensão
→ Native Messaging
→ ReguaEditorial.Helper.exe
→ Microsoft Word COM
→ DOCX temporário validado
→ retorno para a extensão
```

O Helper é necessário somente para operações que não podem ser executadas diretamente pelo navegador, especialmente DOC/RTF.

## 11. Native Messaging

Host:

```text
com.egba.regua_editorial.helper
```

Manifesto instalado:

```text
%ProgramFiles%\EGBA\ReguaEditorialHelper\com.egba.regua_editorial.helper.json
```

Origem permitida:

```text
chrome-extension://chdfbekdjpecdajbpdelmhpemenoelmd/
```

Registro:

```text
HKLM\Software\Google\Chrome\NativeMessagingHosts\com.egba.regua_editorial.helper
```

A instalação por máquina grava o registro nas visões 32 e 64 bits.

## 12. Helper Windows

| Campo | Valor |
|---|---|
| Nome | `ReguaEditorial.Helper.exe` |
| Versão | `0.1.4` |
| Contrato | `1.2.0` |
| Runtime | .NET 8 self-contained |
| Escopo | Machine |
| Diretório | `%ProgramFiles%\EGBA\ReguaEditorialHelper` |

O usuário final não precisa instalar separadamente o .NET Runtime.

Probe:

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe" `
  --probe `
  --workspace "$env:TEMP"
```

## 13. Segurança do Word COM

O fluxo DOC/RTF deve observar:

- instância controlada do Word;
- operação não interativa quando possível;
- somente leitura;
- macros desabilitadas;
- arquivo temporário;
- validação do DOCX resultante;
- exclusão de temporários;
- preservação do original.

## 14. Regras editoriais da versão 0.7.4

A linha 0.7.4 utiliza `municipios-editorial-rules@1.3.0`.

Resumo:

| Elemento | Fonte | Corpo | Entrelinha |
|---|---|---:|---:|
| conteúdo base | Arial | 6 pt | 8 pt |
| negrito secundário | Arial Bold | 6 pt | 8 pt |
| trecho canônico | Arial Bold, caixa alta | 8 pt | 8 pt |
| vazio interno normalizado | — | — | 8 pt |

A tarja permanece com sua regra específica. Tarifa e fórmula de cálculo não foram alteradas pela revisão de entrelinha.

## 15. Bloqueios editoriais relevantes

A aplicação possui validações de compatibilidade do documento. Entre os bloqueios definidos na linha homologada estão ocorrências incompatíveis com o fluxo editorial, como tabelas e objetos/containers fora da política aceita.

Quando houver bloqueio, a aplicação deve interromper o processamento e orientar correção do documento em cópia apropriada.

## 16. Dados lidos do EGBANET

Nas páginas compatíveis a extensão coleta os dados necessários ao fluxo, incluindo identificadores funcionais e informações comerciais usadas no cálculo/registro.

A integração é restrita ao host `egbanet.egba.ba.gov.br` pelo Manifest.

## 17. Política de privacidade técnica

A solução não deve persistir:

- conteúdo integral de DOCX/DOC/RTF;
- arquivo convertido temporário;
- HTML integral da página;
- cookie ou token de autenticação;
- credenciais.

Logs administrativos devem ser sanitizados e limitados ao necessário para suporte.

## 18. Empacotamento CRX

A extensão é distribuída como CRX assinado com a PEM institucional.

O pipeline valida que a chave fornecida gera exatamente:

```text
chdfbekdjpecdajbpdelmhpemenoelmd
```

Qualquer divergência deve interromper o build.

## 19. Atualização

A atualização da extensão requer:

1. versão superior;
2. mesma PEM;
3. mesmo Extension ID;
4. CRX assinado;
5. `update.xml` coerente;
6. política Chrome apontando para a origem autorizada;
7. testes de compatibilidade com Helper/IndexedDB;
8. homologação antes da ampliação.

## 20. Interfaces administrativas relevantes

```text
chrome://extensions
chrome://policy
```

Verifique nessas páginas:

- versão;
- ID;
- estado gerenciado;
- políticas aplicadas;
- erros do service worker quando houver diagnóstico avançado.

## 21. Critérios para revisão de segurança

Reabrir revisão técnica e de segurança quando houver mudança em:

- permissões Chrome;
- host permissions;
- páginas compatíveis;
- Extension ID ou chave;
- Native Messaging;
- protocolo do Helper;
- comportamento do Word COM;
- schema do IndexedDB;
- dados persistidos;
- política de atualização;
- assinatura do pacote.
