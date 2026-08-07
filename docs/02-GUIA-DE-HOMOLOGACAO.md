# Guia de homologação — Entrega 1.0.1

Este guia comprova que a Régua Editorial foi instalada corretamente e atende aos fluxos previstos antes da liberação ao usuário ou da ampliação do piloto.

## 1. Responsáveis

| Papel | Responsabilidade |
|---|---|
| TI da ponta | instalar, validar Windows, Chrome, AD, políticas, Helper e Word |
| Operador / representante da GERDO | validar prévia, medição, cálculo, consultas e relatórios |
| Responsável pela entrega | consolidar evidências e registrar aceite ou reprovação |

## 2. Artefatos sob teste

### Corporativo

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256
```

### Homologação local

```text
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256
```

Os artefatos devem possuir hashes diferentes entre si, porque implementam gates ambientais diferentes.

## 3. Identificação da versão

| Item | Valor esperado |
|---|---|
| Release | `v1.0.1-pilot.1` |
| Instalador | `1.0.1` |
| Extensão | `0.7.4` |
| Regras editoriais | `municipios-editorial-rules@1.3.0` |
| Native Helper | `0.1.4` |
| Contrato Native Messaging | `1.2.0` |
| IndexedDB/schema | `3` |
| Extension ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Native host | `com.egba.regua_editorial.helper` |

## 4. Pré-condições

Confirme:

- `.exe` e `.sha256` baixados da Release privada oficial;
- SHA-256 validado;
- Windows x64;
- Google Chrome instalado;
- perfil do Chrome identificado;
- arquivos de teste sintéticos ou autorizados;
- ausência da extensão carregada descompactada no perfil de homologação;
- Word instalado quando DOC/RTF fizerem parte do escopo.

Para o instalador **Corporativo**, confirme também:

```powershell
Get-CimInstance Win32_ComputerSystem |
  Select-Object PartOfDomain, Domain
```

`PartOfDomain` deve ser `True`.

## 5. Testes do pacote e instalação

| ID | Artefato | Teste | Resultado esperado |
|---|---|---|---|
| H-01 | ambos | validar SHA-256 | hash calculado igual ao `.sha256` |
| H-02 | ambos | validar assinatura do Setup | assinatura presente; confiança conforme política do piloto |
| H-03 | corporativo | instalar fora do AD | instalação recusada pelo gate corporativo |
| H-04 | corporativo | instalar em estação do AD | instalação concluída |
| H-05 | homologação local | instalar fora do AD | instalação concluída com override local registrado |
| H-06 | ambos | conferir arquivos e estado | Helper, `installation.json` e `chrome-policy.json` presentes |
| H-07 | ambos | conferir Chrome | extensão `0.7.4`, ID correto, gerenciada |
| H-08 | ambos | probe do Helper | `0.1.4`, contrato `1.2.0`, workspace gravável |
| H-09 | ambos | fechar/reabrir Chrome | extensão permanece disponível |

## 6. Testes funcionais

| ID | Responsável | Teste | Resultado esperado |
|---|---|---|---|
| F-01 | Operação | abrir painel em página compatível | painel lateral disponível |
| F-02 | Operação | processar DOCX | prévia, medição e cálculo apresentados |
| F-03 | Operação | salvar cálculo | registro persistido |
| F-04 | Operação | consultar por data/protocolo/cliente | registro recuperado |
| F-05 | Operação | relatório diário | quantidade e totais coerentes |
| F-06 | Operação | relatório por intervalo | filtros e totais coerentes |
| F-07 | Operação | exportar CSV | arquivo válido e utilizável em planilha |
| F-08 | Operação | exportar JSON | JSON válido com registros esperados |
| F-09 | TI/Operação | processar DOC com Word | conversão automática sem alterar original |
| F-10 | TI/Operação | processar RTF com Word | conversão automática sem alterar original |
| F-11 | TI/Operação | reiniciar Chrome | cálculos continuam acessíveis |

F-09 e F-10 são aplicáveis apenas a estações que utilizam DOC/RTF.

## 7. Testes editoriais específicos da 0.7.4

A homologação da versão deve confirmar que a geometria editorial reflete `municipios-editorial-rules@1.3.0`:

- conteúdo base: Arial 6 pt / entrelinha 8 pt;
- negrito secundário: Arial Bold 6 pt / entrelinha 8 pt;
- trecho canônico: Arial Bold 8 pt / entrelinha 8 pt / caixa alta;
- vazio interno normalizado: 8 pt;
- tarja: regra tipográfica preservada;
- tarifa e fórmula de cálculo: sem alteração funcional.

Como a entrelinha mudou em relação à 0.7.3, altura, cm/cl e preço podem variar quando a geometria do documento variar.

## 8. Testes de manutenção

| ID | Teste | Resultado esperado |
|---|---|---|
| M-01 | reparo | componentes restaurados sem trocar Extension ID |
| M-02 | reparo | IndexedDB preservado |
| M-03 | remoção padrão | Helper removido conforme projeto; dados locais preservados |
| M-04 | reinstalação | mesma identidade e registros preservados quando aplicável |
| M-05 | política existente | instalação não sobrescreve entradas Chrome não pertencentes à Régua |

## 9. Evidências mínimas

Registre:

- data e responsável;
- estação pseudonimizada;
- tipo de instalador;
- SHA-256 do `.exe`;
- versão do Setup, extensão e Helper;
- Extension ID;
- resultado do gate AD quando aplicável;
- resultado do probe;
- casos aprovados, reprovados e não aplicáveis;
- mensagens/códigos de erro sanitizados.

Não registre conteúdo de matéria, documento de produção, cookie, token, senha ou dump integral do IndexedDB.

## 10. Critérios de interrupção

Suspenda a homologação diante de:

- Extension ID divergente;
- hash divergente;
- falha de assinatura inesperada;
- perda/alteração de cálculos;
- documento original sobrescrito;
- execução de macro;
- cálculo incorreto sem explicação;
- política Chrome aplicada a entrada alheia;
- exposição de dados;
- falha repetida em múltiplas estações.

## 11. Critério de aceite

A entrega pode ser liberada para piloto quando:

- o QA automatizado dos dois artefatos estiver aprovado;
- o instalador corporativo passar em estação do domínio;
- o instalador de homologação local passar fora do domínio;
- DOCX, cálculo, persistência, consulta e relatórios forem aprovados;
- DOC/RTF forem aprovados nas estações que dependem desses formatos;
- Chrome e IndexedDB permanecerem consistentes após reinício;
- reparo e rollback estiverem documentados;
- as evidências estiverem sanitizadas;
- GERDO e TI registrarem o aceite.

Use também o [Checklist de entrega](06-CHECKLIST-DE-ENTREGA.md).
