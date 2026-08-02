# Guia de instalação para a equipe de TI

Este guia orienta a instalação, a validação inicial e a entrega da Régua Editorial ao usuário da estação.

## Resultado esperado

Ao final do procedimento:

- a extensão **Régua Editorial SieDOE** estará disponível no Google Chrome;
- o usuário poderá processar matérias abertas no EGBANET;
- arquivos DOCX serão processados diretamente;
- arquivos DOC e RTF poderão ser convertidos automaticamente quando o Microsoft Word estiver instalado;
- cálculos e relatórios ficarão disponíveis no perfil do Chrome usado pelo operador.

## 1. Preparar a estação

Confirme os requisitos:

| Requisito | Como verificar |
|---|---|
| Windows x64 | **Configurações > Sistema > Sobre** |
| Google Chrome | Abrir o navegador normalmente |
| Estação no domínio corporativo | Executar o comando abaixo |
| Credencial administrativa | Necessária apenas durante a instalação |
| Microsoft Word desktop | Necessário somente para conversão automática de DOC e RTF |

Verifique o vínculo com o domínio:

```powershell
Get-CimInstance Win32_ComputerSystem |
  Select-Object PartOfDomain, Domain
```

O campo `PartOfDomain` deve apresentar `True`.

> [!NOTE]
> Sem Microsoft Word, o usuário ainda poderá processar DOCX, calcular, salvar registros e emitir relatórios.

## 2. Baixar o pacote

Acesse a [Release `v1.0.0-pilot.1`](https://github.com/guedesle/regua-municipios-a-vista/releases/tag/v1.0.0-pilot.1) e baixe apenas:

```text
ReguaEditorial-Entrega1-Setup-x64.exe
ReguaEditorial-Entrega1-Setup-x64.exe.sha256
```

Não é necessário copiar a pasta de desenvolvimento nem outros arquivos de build.

## 3. Verificar o instalador

O arquivo `.sha256` confirma que o instalador não foi alterado durante o download ou a transferência.

Abra o PowerShell na pasta dos arquivos e execute:

```powershell
$Setup = '.\ReguaEditorial-Entrega1-Setup-x64.exe'
$HashFile = '.\ReguaEditorial-Entrega1-Setup-x64.exe.sha256'

$Actual = (Get-FileHash $Setup -Algorithm SHA256).Hash.ToLowerInvariant()
$Expected = ((Get-Content $HashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()

if ($Actual -ne $Expected) {
    throw "HASH_DIVERGENTE: esperado=$Expected obtido=$Actual"
}

Write-Host "Integridade confirmada: $Actual"
```

> [!WARNING]
> Não execute o instalador quando os valores forem diferentes. Baixe novamente os arquivos na Release oficial.

## 4. Instalar

1. Copie os dois arquivos para uma pasta local da estação.
2. Feche todas as janelas do Google Chrome.
3. Confirme no Gerenciador de Tarefas que não há processo `chrome.exe` em execução.
4. Clique com o botão direito em `ReguaEditorial-Entrega1-Setup-x64.exe`.
5. Escolha **Executar como administrador**.
6. Conclua o assistente de instalação.
7. Reabra o Chrome.
8. Acesse `chrome://policy` e clique em **Recarregar políticas**.
9. Acesse `chrome://extensions` e confirme a presença da extensão.

## 5. Validar a instalação

Em `chrome://extensions`, confirme:

| Campo | Valor esperado |
|---|---|
| Nome | Régua Editorial SieDOE |
| Versão | `0.7.3` |
| ID | `chdfbekdjpecdajbpdelmhpemenoelmd` |
| Forma de instalação | Gerenciada pela organização |

Depois execute o teste funcional mínimo:

1. abra uma matéria compatível no EGBANET;
2. abra a Régua Editorial;
3. confira se protocolo, cliente e matéria foram identificados;
4. processe um arquivo DOCX de teste;
5. confirme a exibição da prévia, da medição e do valor;
6. salve o cálculo;
7. localize o registro na área de consultas;
8. gere um relatório e exporte um CSV.

Nas estações com Microsoft Word, teste também um arquivo DOC ou RTF.

## 6. Orientar o usuário

Antes de encerrar o atendimento, informe ao operador:

- usar sempre o mesmo perfil do Chrome;
- abrir primeiro a matéria no EGBANET e depois a Régua Editorial;
- revisar a prévia e o valor antes de salvar;
- não limpar os dados do navegador sem orientação;
- não ativar o modo desenvolvedor do Chrome;
- registrar a mensagem exata quando ocorrer uma falha;
- consultar o [Guia rápido de uso](08-GUIA-RAPIDO-DE-USO.md).

## 7. Diagnóstico do programa auxiliar

A extensão usa um programa instalado no Windows para realizar operações que o navegador não executa sozinho, especialmente a conversão de DOC e RTF com o Microsoft Word.

Execute:

```powershell
& "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe" `
  --probe `
  --workspace "$env:TEMP"
```

Confirme no resultado:

- versão do programa auxiliar: `0.1.4`;
- versão da comunicação com a extensão: `1.2.0`;
- pasta temporária disponível para gravação;
- Word detectado, quando instalado.

## 8. Problemas comuns

| Situação | Ação recomendada |
|---|---|
| A estação não está no domínio | Interromper a instalação e regularizar o vínculo com a TI |
| A extensão não aparece | Fechar todos os processos do Chrome, reabrir e recarregar `chrome://policy` |
| DOC ou RTF não converte | Confirmar se o Word está instalado, licenciado e aberto ao menos uma vez |
| DOCX funciona, mas DOC/RTF falha | Executar o diagnóstico do programa auxiliar e registrar a mensagem exibida |
| A extensão aparece com outro ID | Interromper o uso e acionar a equipe responsável pela distribuição |
| O cálculo não permanece salvo | Confirmar o mesmo perfil do Chrome e verificar se os dados do navegador foram limpos |

## 9. Reparar ou remover

Use **Aplicativos instalados** no Windows para reparar ou remover a Régua Editorial.

Antes de uma remoção completa, confirme se existem cálculos que precisam ser exportados. A remoção da extensão ou a limpeza do perfil do Chrome pode eliminar os registros locais.

Para diagnóstico detalhado, consulte a [Referência técnica](09-REFERENCIA-TECNICA.md).