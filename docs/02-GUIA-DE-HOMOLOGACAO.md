# Guia de homologação — Entrega 1

Este guia comprova que a Régua Editorial foi instalada corretamente e atende aos fluxos previstos antes da liberação ao usuário.

## 1. Responsáveis

| Papel | Responsabilidade |
|---|---|
| TI da ponta | instalar, validar Chrome, domínio, programa auxiliar e Word |
| Operador ou representante da GERDO | validar prévia, medição, cálculo, consultas e relatórios |
| Responsável pela entrega | consolidar evidências e registrar o aceite ou a reprovação |

## 2. Antes dos testes

Confirme:

- instalador e arquivo `.sha256` baixados da Release oficial;
- SHA-256 validado;
- estação Windows x64 vinculada ao domínio corporativo;
- Google Chrome instalado;
- usuário e perfil do Chrome identificados;
- arquivos de teste sintéticos ou expressamente autorizados;
- ausência de outra versão descompactada da extensão no perfil usado para homologação.

> [!WARNING]
> Não use documentos reais de clientes quando um arquivo sintético for suficiente. Não registre conteúdo de matéria nas evidências.

## 3. Identificação da versão

| Item | Valor esperado |
|---|---|
| Release | `v1.0.0-pilot.1` |
| Instalador | `1.0.0` |
| Extensão | `0.7.3` |
| Programa auxiliar do Windows | `0.1.4` |
| Comunicação local | `1.2.0` |
| ID da extensão | `chdfbekdjpecdajbpdelmhpemenoelmd` |

## 4. Testes obrigatórios

| ID | Responsável | Teste | Resultado esperado |
|---|---|---|---|
| H-01 | TI | validar o SHA-256 | código igual ao arquivo publicado |
| H-02 | TI | executar o instalador como administrador | instalação concluída sem erro |
| H-03 | TI | verificar vínculo com o domínio | `PartOfDomain = True` |
| H-04 | TI | conferir a extensão no Chrome | nome, versão e ID corretos; instalação gerenciada |
| H-05 | TI | executar diagnóstico do programa auxiliar | versão, comunicação e pasta temporária válidas |
| H-06 | Operação | processar DOCX | prévia, medição e cálculo apresentados |
| H-07 | Operação | salvar e consultar o cálculo | registro localizado com os mesmos valores |
| H-08 | Operação | emitir relatório por data | quantidade e totais coerentes |
| H-09 | Operação | exportar CSV | arquivo abre corretamente em planilha |
| H-10 | Operação | exportar JSON | arquivo válido e com os registros esperados |
| H-11 | TI/Operação | fechar e reabrir o Chrome | extensão e cálculos permanecem disponíveis |
| H-12 | TI/Operação | processar DOC ou RTF com Word | conversão concluída sem alterar o original |
| H-13 | TI | executar reparo | componentes restaurados sem trocar o ID ou apagar cálculos |
| H-14 | TI | executar remoção padrão em estação de teste | programa auxiliar removido; extensão e cálculos preservados |

O teste H-12 é obrigatório somente nas estações em que DOC e RTF façam parte do uso previsto.

## 5. Roteiro funcional

Use uma matéria e um documento de teste controlados:

1. abra a matéria no EGBANET;
2. abra a Régua Editorial;
3. confira protocolo, cliente e identificação da matéria;
4. processe o documento;
5. revise a prévia;
6. compare a medição e o preço com o resultado esperado;
7. salve o cálculo;
8. pesquise o registro salvo;
9. gere relatório diário e por intervalo;
10. exporte CSV e JSON;
11. feche completamente o Chrome;
12. reabra e confirme que o registro permanece disponível.

## 6. Evidências

Registre apenas o necessário:

- data e responsável pelo teste;
- identificação interna ou pseudonimizada da estação;
- versões do instalador, extensão e programa auxiliar;
- ID da extensão;
- resultado da verificação do domínio;
- SHA-256 do instalador;
- resultado de cada caso: aprovado, reprovado ou não aplicável;
- mensagem ou código de erro, quando houver.

Não registre:

- texto da matéria;
- documento de produção;
- senha, cookie ou token;
- protocolo, cliente ou ID real da matéria;
- conteúdo integral do armazenamento local.

## 7. Interromper a homologação

Suspenda os testes e comunique os responsáveis quando ocorrer:

- ID da extensão diferente do previsto;
- perda ou alteração de cálculos já salvos;
- matéria ou documento associado ao registro errado;
- cálculo divergente sem explicação;
- arquivo original sobrescrito;
- execução de macro;
- SHA-256 divergente;
- falha repetida em mais de uma estação;
- exposição de dados ou outro incidente de segurança.

## 8. Critério de aceite

A entrega pode ser liberada para o piloto quando:

- todos os testes aplicáveis forem aprovados;
- DOCX, cálculo, salvamento, consulta e relatórios funcionarem;
- DOC e RTF funcionarem nas estações que dependem desses formatos;
- fechamento e reabertura do Chrome não causarem perda de registros;
- reparo e remoção padrão tiverem o comportamento previsto;
- as evidências estiverem registradas sem dados sensíveis;
- GERDO e TI registrarem o aceite.

Use o [Checklist de entrega](06-CHECKLIST-DE-ENTREGA.md) para consolidar o resultado.