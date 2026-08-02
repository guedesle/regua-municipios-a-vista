# Guia de homologação — Entrega 1

## 1. Objetivo

Comprovar que o instalador implanta e opera a Régua Editorial SieDOE em estação Windows associada ao Active Directory, preservando a baseline funcional homologada.

## 2. Baseline

- Setup: `1.0.0`;
- extensão: `0.7.3`;
- Helper: `0.1.4`;
- contrato: `1.2.0`;
- IndexedDB/schema: `3`;
- Extension ID: `chdfbekdjpecdajbpdelmhpemenoelmd`;
- native host: `com.egba.regua_editorial.helper`.

## 3. Critérios de entrada

- hash do Setup validado;
- estação Windows x64;
- `PartOfDomain = true`;
- Chrome instalado;
- operador e técnico identificados;
- corpus sintético disponível;
- nenhuma extensão descompactada concorrente no perfil operacional.

## 4. Matriz mínima

| ID | Verificação | Resultado esperado |
|---|---|---|
| H-01 | instalação como administrador | conclusão sem erro |
| H-02 | estação associada ao AD | `PartOfDomain = true` |
| H-03 | extensão no Chrome | versão `0.7.3`, ID correto e gerenciada |
| H-04 | Helper instalado | versão `0.1.4` |
| H-05 | contrato nativo | versão `1.2.0` |
| H-06 | matéria DOCX | prévia, medição e cálculo corretos |
| H-07 | matéria DOC | conversão automática quando Word disponível |
| H-08 | matéria RTF | conversão automática quando Word disponível |
| H-09 | relatório por data | registros e totais corretos |
| H-10 | relatório por intervalo | filtros e agregações corretos |
| H-11 | exportação JSON | arquivo válido e completo |
| H-12 | exportação CSV | abertura correta em planilha |
| H-13 | reinício do Chrome | extensão e registros preservados |
| H-14 | reparo | componentes restaurados sem duplicação |
| H-15 | remoção padrão | Helper removido e extensão/dados preservados |

## 5. Homologação funcional

Executar com dados sintéticos ou autorizados:

1. abrir uma matéria compatível no Egbanet;
2. processar um DOCX;
3. validar tarja, conteúdo, medição e preço;
4. salvar o cálculo;
5. consultar o registro salvo;
6. gerar relatório diário;
7. exportar JSON e CSV;
8. reiniciar completamente o Chrome;
9. confirmar a persistência dos registros;
10. testar DOC e RTF quando houver Word disponível.

## 6. Evidências permitidas

Registrar:

- data e executor;
- identificador pseudonimizado da estação;
- versões dos componentes;
- Extension ID;
- estado do Active Directory;
- SHA-256 do Setup;
- resultado do probe;
- casos aprovados ou reprovados;
- códigos técnicos de erro.

Não registrar conteúdo documental, credenciais, cookies, tokens, cliente, protocolo real ou texto de matéria.

## 7. Critérios de suspensão

Interromper a homologação diante de:

- Extension ID divergente;
- perda ou alteração indevida de registros;
- cálculo divergente da baseline;
- associação de documento à matéria errada;
- sobrescrita do original;
- execução de macro;
- assinatura ou hash divergente;
- falha sistêmica em mais de uma estação;
- incidente de privacidade.

## 8. Critério de aceite

A entrega é considerada homologada quando:

- todos os casos críticos forem aprovados;
- não houver perda de dados locais;
- instalação, reparo e remoção padrão estiverem comprovados;
- DOCX estiver funcional;
- DOC/RTF estiverem funcionais nas estações com Word;
- relatórios e exportações estiverem corretos;
- evidências estiverem registradas sem dados sensíveis.