<div align="center">

# Régua Editorial SieDOE

### Municípios à Vista

**Ferramenta de apoio à preparação, medição, cálculo e consulta de publicações do Caderno Municípios no EGBANET.**

[Baixar instalador](https://github.com/guedesle/regua-municipios-a-vista/releases/tag/v1.0.0-pilot.1) · [Guia de instalação](docs/01-GUIA-DE-INSTALACAO.md) · [Guia de homologação](docs/02-GUIA-DE-HOMOLOGACAO.md) · [Suporte](docs/03-OPERACAO-E-SUPORTE.md)

</div>

---

A Régua Editorial funciona no Google Chrome e acompanha o usuário durante o tratamento de uma matéria no EGBANET. Ela permite processar o arquivo da publicação, aplicar as regras editoriais homologadas, conferir a prévia, medir o conteúdo, calcular o valor e guardar o resultado para consultas e relatórios.

> [!IMPORTANT]
> Esta versão é destinada ao piloto interno da EGBA e deve ser instalada somente em estações autorizadas.

## Instalação em 5 passos

1. Acesse a [Release `v1.0.0-pilot.1`](https://github.com/guedesle/regua-municipios-a-vista/releases/tag/v1.0.0-pilot.1).
2. Baixe os dois arquivos:
   - `ReguaEditorial-Entrega1-Setup-x64.exe`
   - `ReguaEditorial-Entrega1-Setup-x64.exe.sha256`
3. Feche completamente o Google Chrome.
4. Execute o instalador `.exe` como administrador.
5. Reabra o Chrome e acesse uma matéria no EGBANET.

Antes de instalar, confirme que a estação possui:

- Windows x64;
- Google Chrome;
- vínculo com o domínio corporativo da empresa;
- credencial administrativa para a instalação;
- Microsoft Word desktop, quando for necessário converter arquivos DOC ou RTF.

O Word não é necessário para processar DOCX, realizar cálculos ou consultar relatórios.

Para conferir a integridade do arquivo antes da instalação, siga a seção [Verificar o instalador](docs/01-GUIA-DE-INSTALACAO.md#verificar-o-instalador).

## Primeiro uso

1. Abra no EGBANET a página de edição ou consulta da matéria.
2. Abra a Régua Editorial no Chrome.
3. Confira os dados identificados na página, como protocolo, cliente e matéria.
4. Processe o arquivo original:
   - **DOCX:** processamento direto;
   - **DOC ou RTF:** conversão automática quando o Word estiver instalado;
   - caso a conversão automática não esteja disponível, converta o arquivo para DOCX e adicione-o manualmente.
5. Revise a prévia e as medidas apresentadas.
6. Confira o valor calculado e salve o registro.
7. Use a área de consultas para localizar cálculos anteriores e emitir relatórios.

> [!NOTE]
> Os cálculos ficam armazenados localmente no perfil do Chrome utilizado na estação. Não limpe os dados do navegador e não troque de perfil sem orientação da equipe de suporte.

## O que a ferramenta permite fazer

| Atividade | Resultado |
|---|---|
| Processar a matéria | Prepara o documento conforme as regras editoriais aprovadas |
| Conferir a publicação | Exibe uma prévia para validação antes do cálculo |
| Medir e calcular | Separa tarja e conteúdo, calcula a centimetragem e o preço |
| Salvar o cálculo | Mantém o registro disponível para consulta posterior |
| Localizar matérias | Permite pesquisa por data, protocolo e cliente |
| Abrir a matéria no EGBANET | Usa o identificador da matéria para retornar à página correspondente |
| Emitir relatórios | Consolida os cálculos por dia ou intervalo de datas |
| Exportar dados | Gera arquivos JSON e CSV para uso em planilhas ou outras ferramentas |

## Como a solução funciona

A instalação reúne quatro partes que trabalham em conjunto:

- **Extensão do Chrome:** apresenta a interface da Régua Editorial e lê as informações exibidas na página da matéria;
- **programa auxiliar do Windows:** realiza operações locais que o navegador não executa sozinho, principalmente a conversão de DOC e RTF com o Microsoft Word;
- **armazenamento local:** guarda os cálculos no perfil do Chrome da estação, sem exigir um banco de dados externo;
- **instalador:** copia os componentes necessários e configura o Chrome para disponibilizar a extensão aos usuários autorizados.

Não é necessário instalar Node.js, Git, ferramentas de desenvolvimento ou o .NET Runtime separadamente.

## Depois da instalação

A equipe responsável pela implantação deve confirmar:

- presença da extensão **Régua Editorial SieDOE** no Chrome;
- versão `0.7.3`;
- funcionamento do processamento de DOCX;
- conversão de DOC e RTF nas estações com Word;
- salvamento e recuperação de cálculos;
- geração de relatório e exportação CSV.

O roteiro completo está no [Guia de homologação](docs/02-GUIA-DE-HOMOLOGACAO.md).

## Documentação por necessidade

| Preciso de... | Consulte |
|---|---|
| instalar ou reparar a aplicação | [Guia de instalação](docs/01-GUIA-DE-INSTALACAO.md) |
| validar a entrega em uma estação | [Guia de homologação](docs/02-GUIA-DE-HOMOLOGACAO.md) |
| usar a ferramenta ou registrar uma falha | [Operação e suporte](docs/03-OPERACAO-E-SUPORTE.md) |
| interromper ou reverter uma implantação | [Plano de rollback](docs/04-PLANO-DE-ROLLBACK.md) |
| entender os componentes instalados | [Como a distribuição funciona](docs/05-ARQUITETURA-DE-DISTRIBUICAO.md) |
| conferir a prontidão da entrega | [Checklist de entrega](docs/06-CHECKLIST-DE-ENTREGA.md) |
| consultar versões e arquivos da Release | [Inventário da Release](docs/07-INVENTARIO-DA-RELEASE.md) |

## Suporte rápido

Antes de abrir uma ocorrência:

1. feche e reabra completamente o Chrome;
2. confirme se a matéria está em uma página compatível do EGBANET;
3. identifique o formato do arquivo: DOCX, DOC ou RTF;
4. copie a mensagem de erro exibida, sem anexar o conteúdo da matéria;
5. informe data, horário, ação realizada e versão da extensão.

Não compartilhe senhas, cookies, tokens, documentos de produção ou dados reais de clientes em issues ou evidências técnicas. Consulte [Operação e suporte](docs/03-OPERACAO-E-SUPORTE.md) e a [Política de segurança](SECURITY.md).

<details>
<summary><strong>Identificação técnica da entrega</strong></summary>

| Item | Versão ou identificação |
|---|---|
| Release | `v1.0.0-pilot.1` |
| Canal | `pilot` |
| Instalador | `1.0.0` |
| Extensão Chrome | `0.7.3` |
| Programa auxiliar do Windows | `0.1.4` |
| Comunicação entre extensão e programa auxiliar | `1.2.0` |
| Estrutura do armazenamento local | `3` |
| ID da extensão | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Identificador do programa auxiliar | `com.egba.regua_editorial.helper` |

</details>

## Sobre este repositório

Este repositório privado contém os instaladores oficiais, as notas de entrega e a documentação necessária para implantação e uso. O código-fonte, os testes e o processo de geração do instalador permanecem separados no repositório de desenvolvimento.

---

<div align="center">

**Empresa Gráfica da Bahia — EGBA**  
Distribuição interna da Régua Editorial SieDOE

</div>
