<div align="center">

# Régua Editorial SieDOE

### Municípios à Vista

**Ferramenta de apoio à preparação, medição, cálculo e consulta de publicações do Caderno Municípios no EGBANET.**

[Baixar instalador](https://github.com/guedesle/regua-municipios-a-vista/releases/tag/v1.0.0-pilot.1) · [Instalar](docs/01-GUIA-DE-INSTALACAO.md) · [Usar](docs/08-GUIA-RAPIDO-DE-USO.md) · [Homologar](docs/02-GUIA-DE-HOMOLOGACAO.md) · [Suporte](docs/03-OPERACAO-E-SUPORTE.md)

</div>

---

A Régua Editorial acompanha o usuário durante o tratamento de uma matéria no EGBANET. Ela permite preparar o arquivo conforme as regras editoriais aprovadas, revisar a prévia, medir o conteúdo, calcular o valor da publicação e guardar o resultado para consultas e relatórios.

> [!IMPORTANT]
> Esta é uma versão de **piloto interno**, destinada somente a estações autorizadas da EGBA. Não deve ser distribuída como software público ou de uso geral.

## Instalar agora

1. Acesse a [Release `v1.0.0-pilot.1`](https://github.com/guedesle/regua-municipios-a-vista/releases/tag/v1.0.0-pilot.1).
2. Baixe:
   - `ReguaEditorial-Entrega1-Setup-x64.exe`
   - `ReguaEditorial-Entrega1-Setup-x64.exe.sha256`
3. [Confirme o SHA-256](docs/01-GUIA-DE-INSTALACAO.md#3-verificar-o-instalador).
4. Feche completamente o Google Chrome.
5. Execute o instalador como administrador.
6. Reabra o Chrome e acesse uma matéria no EGBANET.

A estação deve possuir Windows x64, Google Chrome e vínculo com o domínio corporativo. O Microsoft Word desktop é necessário somente para converter automaticamente arquivos DOC e RTF.

> [!WARNING]
> O instalador desta pré-release usa um certificado temporário de laboratório. O primeiro aviso do Windows pode apresentar **Editor desconhecido**. Prossiga somente depois de validar o SHA-256 e confirmar que o arquivo veio da Release privada oficial.

O procedimento completo está no [Guia de instalação para a equipe de TI](docs/01-GUIA-DE-INSTALACAO.md).

## Primeiro uso

1. Abra a página da matéria no EGBANET.
2. Abra a Régua Editorial no Chrome.
3. Confira protocolo, cliente e identificação da matéria.
4. Processe o arquivo:
   - **DOCX:** processamento direto;
   - **DOC ou RTF:** conversão automática quando o Word estiver disponível;
   - sem conversão automática: salve uma cópia em DOCX e adicione-a manualmente.
5. Revise a prévia, a medição e o valor.
6. Salve o cálculo.
7. Consulte registros anteriores ou emita um relatório quando necessário.

Consulte o [Guia rápido de uso](docs/08-GUIA-RAPIDO-DE-USO.md) para os fluxos completos.

> [!NOTE]
> Os cálculos são guardados localmente no perfil do Chrome usado pelo operador. Não limpe os dados do navegador, não troque de perfil e não remova a extensão sem orientação da TI.

## Principais casos de uso

| Necessidade | O que a ferramenta faz |
|---|---|
| Preparar uma matéria | Aplica as regras editoriais homologadas ao documento |
| Conferir antes do cálculo | Exibe uma prévia para revisão |
| Medir e calcular | Mede tarja e conteúdo e calcula o preço |
| Guardar o resultado | Salva o cálculo para consulta posterior |
| Localizar um registro | Pesquisa por data, protocolo ou cliente |
| Retornar ao EGBANET | Abre a página correspondente à matéria |
| Consolidar o trabalho | Emite relatórios por dia ou intervalo |
| Usar os dados em outra ferramenta | Exporta JSON e CSV |

## Como a solução funciona

A instalação reúne quatro partes:

- **extensão do Chrome:** mostra a interface e identifica os dados da matéria aberta no EGBANET;
- **programa auxiliar do Windows:** permite converter DOC e RTF com o Microsoft Word;
- **armazenamento local do Chrome:** guarda os cálculos no perfil do operador, sem banco externo;
- **instalador:** copia os componentes e configura a extensão na estação autorizada.

A estação não precisa de Node.js, Git, ferramentas de desenvolvimento ou instalação separada do .NET Runtime.

## Validação após a instalação

A equipe de TI deve confirmar:

- extensão **Régua Editorial SieDOE** presente no Chrome;
- versão `0.7.3` e ID `chdfbekdjpecdajbpdelmhpemenoelmd`;
- processamento de DOCX;
- conversão de DOC e RTF nas estações com Word;
- salvamento e recuperação de cálculos;
- geração de relatório e exportação CSV.

Use o [Guia de homologação](docs/02-GUIA-DE-HOMOLOGACAO.md) para registrar o aceite.

## Documentação por necessidade

| Necessidade | Documento |
|---|---|
| instalar, validar ou reparar uma estação | [Guia de instalação para TI](docs/01-GUIA-DE-INSTALACAO.md) |
| aprender os fluxos de operação | [Guia rápido de uso](docs/08-GUIA-RAPIDO-DE-USO.md) |
| homologar a entrega | [Guia de homologação](docs/02-GUIA-DE-HOMOLOGACAO.md) |
| registrar e tratar falhas | [Operação e suporte](docs/03-OPERACAO-E-SUPORTE.md) |
| interromper ou reverter a implantação | [Plano de reversão](docs/04-PLANO-DE-ROLLBACK.md) |
| diagnosticar componentes e políticas | [Referência técnica](docs/09-REFERENCIA-TECNICA.md) |
| entender a distribuição | [Arquitetura de distribuição](docs/05-ARQUITETURA-DE-DISTRIBUICAO.md) |
| conferir a prontidão | [Checklist de entrega](docs/06-CHECKLIST-DE-ENTREGA.md) |
| consultar versões e ativos | [Inventário da Release](docs/07-INVENTARIO-DA-RELEASE.md) |
| consultar o resultado da revisão documental | [Relatório de QA](docs/10-RELATORIO-QA-DOCUMENTACAO.md) |

## Suporte rápido

Antes de abrir uma ocorrência:

1. feche e reabra completamente o Chrome;
2. confirme que a matéria está em uma página compatível do EGBANET;
3. identifique o formato do arquivo;
4. copie a mensagem de erro, sem anexar o conteúdo da matéria;
5. informe data, horário, ação realizada e versão da extensão.

Não compartilhe documentos de produção, senhas, cookies, tokens ou dados reais de clientes em issues ou evidências técnicas. Consulte [Operação e suporte](docs/03-OPERACAO-E-SUPORTE.md) e a [Política de segurança](SECURITY.md).

<details>
<summary><strong>Identificação técnica da entrega</strong></summary>

| Item | Versão ou identificação |
|---|---|
| Release | `v1.0.0-pilot.1` |
| Canal | `pilot` |
| Instalador | `1.0.0` |
| Extensão Chrome | `0.7.3` |
| Programa auxiliar do Windows | `0.1.4` |
| Comunicação local | `1.2.0` |
| Estrutura do armazenamento local | `3` |
| ID da extensão | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Identificador do programa auxiliar | `com.egba.regua_editorial.helper` |

</details>

## Sobre este repositório

Este repositório privado contém os instaladores oficiais, as notas de entrega e a documentação para implantação, uso e suporte. O código-fonte, os testes e o processo de geração do instalador permanecem separados no repositório de desenvolvimento.

---

<div align="center">

**Empresa Gráfica da Bahia — EGBA**  
Distribuição interna da Régua Editorial SieDOE

</div>
