# Instalação local

Use esta modalidade em laboratório ou estação de teste fora do Active Directory.

> O artefato desta Release mantém o nome técnico legado `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe` por rastreabilidade. Na documentação e na orientação ao usuário, a modalidade é denominada **Instalação local**.

## Arquivos

```text
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe
ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256
```

## O que muda em relação ao instalador corporativo

A Instalação local ignora apenas o gate de ingresso no AD/gerenciamento corporativo. Permanecem obrigatórios:

- Windows x64;
- execução administrativa;
- SHA-256 e integridade interna;
- assinaturas dos componentes;
- versões e Extension ID;
- Native Helper e Native Messaging;
- aplicação das políticas do Chrome;
- validação pós-instalação.

> Não use a Instalação local como alternativa ao pacote Corporativo em rollout institucional.

## 1. Validar o SHA-256

```powershell
$Setup = '.\ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe'
$HashFile = "$Setup.sha256"
$Actual = (Get-FileHash $Setup -Algorithm SHA256).Hash.ToLowerInvariant()
$Expected = ((Get-Content $HashFile -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
if ($Actual -ne $Expected) { throw "HASH_DIVERGENTE: $Actual" }
"SHA-256 validado: $Actual"
```

## 2. Instalar

Feche completamente o Chrome e execute:

```powershell
Start-Process '.\ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe' -Verb RunAs -Wait
```

Reabra o Chrome ao final.

## 3. Validar

```powershell
Test-Path "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\state\installation.json"
Test-Path "$env:ProgramData\EGBA\ReguaEditorial\state\chrome-policy.json"
```

Os três resultados devem ser `True`.

Confira o estado:

```powershell
Get-Content "$env:ProgramData\EGBA\ReguaEditorial\state\installation.json" -Raw
```

Em `chrome://extensions`, confirme:

```text
Régua Editorial SieDOE
versão 0.7.4
ID chdfbekdjpecdajbpdelmhpemenoelmd
```

## 4. Teste funcional

Execute o mesmo roteiro funcional da instalação corporativa: DOCX, prévia, medição, cálculo, persistência, consulta/relatório e reinício do Chrome. Se Word estiver disponível, inclua DOC/RTF.

Para registrar o resultado, use [Qualidade e homologação](../qualidade/HOMOLOGACAO.md).