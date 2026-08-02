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

### Aviso do Windows nesta versão piloto

Esta pré-release usa um certificado temporário de laboratório. Na primeira execução, o Windows pode apresentar **Editor desconhecido** antes de o certificado ser instalado na estação.

Prossiga somente quando:

- o SHA-256 tiver sido validado;
- o arquivo tiver sido baixado da Release privada oficial;
- o nome do arquivo for exatamente `ReguaEditorial-Entrega1-Setup-x64.exe`;
- a implantação tiver sido autorizada pela equipe responsável.

Durante a instalação, o certificado público do pacote é adicionado aos repositórios de confiança da estação para validar os componentes locais. Esse mecanismo é exclusivo do piloto e deve ser substituído por assinatura corporativa reconhecida antes da distribuição estável.

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
2. clique no ícone **Régua Editorial SieDOE** na barra do Chrome;
3. confirme que o painel lateral foi aberto;
4. confira se protocolo, cliente e matéria foram identificados;
5. processe um arquivo DOCX de teste;
6. confirme a exibição da prévia, da medição e do valor;
7. salve o cálculo;
8. localize o registro na área de consultas;
9. gere um relatório e exporte um CSV.

Nas estações com Microsoft Word, teste também um arquivo DOC ou RTF.

## 6. Orientar o usuário

Antes de encerrar o atendimento, informe ao operador:

- usar sempre o mesmo perfil do Chrome;
- abrir primeiro a matéria no EGBANET e depois clicar no ícone da Régua Editorial;
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
| O ícone fica desativado | Confirmar que a aba atual é uma página compatível de matéria do EGBANET |
| DOC ou RTF não converte | Confirmar se o Word está instalado, licenciado e aberto ao menos uma vez |
| DOCX funciona, mas DOC/RTF falha | Executar o diagnóstico do programa auxiliar e registrar a mensagem exibida |
| A extensão aparece com outro ID | Interromper o uso e acionar a equipe responsável pela distribuição |
| O cálculo não permanece salvo | Confirmar o mesmo perfil do Chrome e verificar se os dados do navegador foram limpos |
| O Windows bloqueia a execução | Confirmar origem, nome e SHA-256; não contornar o bloqueio quando houver divergência |

## 9. Reparar a instalação

Feche o Chrome e abra o PowerShell **como administrador**. Execute:

```powershell
$InstallRoot = "$env:ProgramFiles\EGBA\ReguaEditorial"

& "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe" `
  -NoProfile `
  -ExecutionPolicy Bypass `
  -File "$InstallRoot\Repair-ReguaEditorial.ps1" `
  -PackageRoot $InstallRoot
```

Depois do reparo:

1. reabra o Chrome;
2. recarregue `chrome://policy`;
3. confirme versão e ID da extensão;
4. execute o diagnóstico do programa auxiliar;
5. confira se os cálculos anteriores permanecem disponíveis.

## 10. Remover a instalação

Em **Configurações > Aplicativos > Aplicativos instalados**, localize **Régua Editorial SieDOE** e execute a desinstalação.

A remoção padrão:

- retira o programa auxiliar;
- preserva a extensão e os cálculos locais;
- pode manter DOCX, consultas e relatórios funcionando;
- deixa a conversão automática de DOC e RTF indisponível.

Antes de remover também a extensão ou limpar o perfil do Chrome:

1. exporte os registros necessários;
2. registre a quantidade de cálculos e os totais;
3. obtenha autorização expressa;
4. siga o [Plano de reversão](04-PLANO-DE-ROLLBACK.md).

Para diagnóstico detalhado, consulte a [Referência técnica](09-REFERENCIA-TECNICA.md).