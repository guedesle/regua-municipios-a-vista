# Assinatura e custódia de chaves

Este documento separa as duas identidades criptográficas usadas na distribuição da Régua Editorial e define controles mínimos de custódia.

## 1. Duas chaves com funções diferentes

A solução utiliza dois mecanismos independentes:

### A. Chave da extensão Chrome

Função:

- assinar/identificar o CRX;
- manter o mesmo Extension ID entre versões.

Resultado operacional:

```text
Extension ID: chdfbekdjpecdajbpdelmhpemenoelmd
```

A chave privada é uma PEM institucional e **não deve ser distribuída**.

### B. Certificado Authenticode

Função:

- assinar Setup e componentes Windows;
- permitir validação de publisher/integridade pelo Windows e ferramentas corporativas.

No piloto é usado certificado temporário de laboratório. Para `stable` deve ser usado certificado corporativo reconhecido.

## 2. A PEM da extensão

A PEM é a raiz da continuidade da identidade Chrome.

Perda da PEM:

- impede gerar atualização com a mesma identidade;
- pode obrigar criação de novo Extension ID;
- afeta políticas e Native Messaging;
- pode exigir estratégia de migração do IndexedDB.

Comprometimento da PEM:

- é incidente de supply chain;
- exige suspensão de publicações;
- exige avaliação de rotação/migração de identidade.

## 3. Requisitos de custódia da PEM

Recomendado:

- armazenar em cofre corporativo de segredos;
- acesso por grupo restrito;
- cópia de recuperação criptografada e auditada;
- proibir envio por e-mail/chat;
- proibir armazenamento em repositório Git;
- proibir presença em artefatos de build/release;
- registrar responsáveis e procedimento de recuperação;
- testar recuperação sem expor a chave em logs.

## 4. Uso em CI/CD

Quando o build ocorrer no GitHub Actions ou outra CI:

- injetar a PEM como secret protegido;
- materializar somente no runner temporário;
- restringir workflow/branch que pode usar o secret;
- remover o arquivo ao final;
- evitar echo/base64 em logs;
- exigir revisão/aprovação para canal stable;
- impedir uso do secret em PRs não confiáveis.

## 5. Chave pública no Manifest

A chave pública pode estar incorporada ao Manifest porque não permite assinar novas versões.

Ela é usada para manter a identidade determinística do CRX.

## 6. Validação do Extension ID

Todo build deve calcular/verificar que a PEM gera:

```text
chdfbekdjpecdajbpdelmhpemenoelmd
```

Se divergir:

```text
ABORTAR BUILD
NÃO PUBLICAR CRX
NÃO ALTERAR POLÍTICAS
```

## 7. Certificado Authenticode do piloto

O piloto utiliza certificado temporário/autossinado.

Consequências:

- primeiro UAC pode mostrar publisher não reconhecido;
- o certificado público é instalado na estação para validar componentes;
- SHA-256 e origem da Release são controles obrigatórios;
- o thumbprint deve ser lido do manifesto do artefato final.

Não hardcode o thumbprint na documentação antes do build definitivo, porque uma nova assinatura pode produzir outro certificado/identificador.

## 8. Certificado corporativo para stable

Requisitos desejáveis:

- certificado de Code Signing emitido para a EGBA por cadeia reconhecida;
- chave privada protegida por HSM/token/cofre corporativo conforme política interna;
- timestamping confiável, quando a infraestrutura permitir;
- subject/publisher institucional coerente;
- processo formal de renovação;
- inventário de expiração;
- EDR/SmartScreen considerados no rollout.

## 9. O que muda ao trocar Authenticode

Trocar o certificado Authenticode **não precisa mudar** o Extension ID.

A atualização pode manter:

- mesma PEM da extensão;
- mesmo CRX identity;
- mesmo Native Messaging allowed origin;
- mesmo IndexedDB.

Entretanto o novo signer deve ser homologado pela TI/EDR.

## 10. O que muda ao trocar a PEM

Trocar a PEM tende a produzir novo Extension ID.

Impactos:

- novas políticas Chrome;
- novo allowed origin no Native Messaging;
- potencial novo espaço de dados;
- necessidade de migração e coexistência temporária;
- necessidade de comunicação e rollout específicos.

Não realizar como simples renovação.

## 11. Segredos proibidos no repositório de distribuição

- PEM privada;
- PFX/P12;
- password de certificado;
- token de GitHub;
- secret de CI;
- chave privada do certificado de laboratório;
- material exportável de HSM/token.

## 12. Auditoria de uma Release

O `release-manifest.json` instalado deve permitir consultar:

```text
signer
certificateThumbprint
certificateNotAfter
signingMode
extensionId
baselineCommit
```

Exemplo:

```powershell
$Manifest = Get-Content `
  "$env:ProgramFiles\EGBA\ReguaEditorial\release-manifest.json" `
  -Raw | ConvertFrom-Json

$Manifest | Select-Object `
  extensionId,
  baselineCommit,
  signer,
  certificateThumbprint,
  certificateNotAfter,
  signingMode
```

## 13. Validação Authenticode

```powershell
Get-AuthenticodeSignature `
  '.\ReguaEditorial-Entrega1-Corporativo-x64.exe' |
  Format-List Status, StatusMessage, SignerCertificate
```

Faça a mesma validação no instalador de homologação local.

## 14. Renovação programada

A TI deve manter alerta de expiração do certificado de código antes do vencimento.

Fluxo:

1. obter novo certificado;
2. validar cadeia e chave privada;
3. assinar build piloto;
4. validar EDR/UAC;
5. homologar atualização;
6. promover para stable;
7. manter registro do certificado anterior.

## 15. Incidente de chave

### Suspeita sobre certificado Authenticode

- suspender novos Setups;
- revogar/substituir conforme processo corporativo;
- preservar PEM da extensão se não comprometida;
- gerar nova Release assinada.

### Suspeita sobre PEM da extensão

- tratar como incidente de identidade;
- suspender CRX/updates;
- envolver Segurança da Informação;
- avaliar revogação operacional e migração;
- não publicar com nova chave sem plano de dados/políticas.
