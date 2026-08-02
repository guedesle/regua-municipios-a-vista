# Segurança da distribuição

Esta política orienta a publicação, a instalação e o suporte da Régua Editorial no ambiente interno da EGBA.

## 1. Escopo

O repositório contém:

- documentação operacional e técnica;
- notas e inventários de entrega;
- instaladores publicados em Releases privadas;
- scripts administrativos de publicação da Release.

O código-fonte da aplicação permanece no repositório de desenvolvimento.

## 2. Materiais proibidos

Nunca versione, anexe a uma Release ou publique em issues:

- chave privada PEM da extensão;
- PFX, P12, KEY ou senha de certificado;
- cookies, tokens, senhas ou outras credenciais;
- documentos DOCX, DOC ou RTF de produção;
- conteúdo textual de matérias;
- exportações com dados reais sem autorização;
- logs com protocolo, cliente, ID de matéria ou caminho documental identificável;
- cópia integral do armazenamento local do Chrome.

Use arquivos sintéticos e evidências sanitizadas sempre que possível.

## 3. Instalador e integridade

O instalador deve ser publicado somente como ativo de uma Release privada, acompanhado do arquivo `.sha256`.

Antes de instalar:

1. baixe os dois arquivos da Release oficial;
2. recalcule o SHA-256;
3. compare com o valor publicado;
4. interrompa a instalação diante de qualquer divergência.

Não mantenha o executável na árvore Git.

## 4. Certificado temporário do piloto

A pré-release atual usa certificado autossinado de laboratório. Durante a instalação, a parte pública é adicionada aos repositórios de confiança do computador para validar os componentes locais.

Riscos e controles:

- o primeiro UAC pode mostrar **Editor desconhecido**;
- somente o SHA-256 validado e a origem oficial autorizam a execução;
- o certificado deve ser identificado e inventariado pelo thumbprint;
- a remoção padrão da aplicação não implica retirada automática do certificado;
- a retirada exige confirmação de que nenhuma instalação ativa depende dele;
- o canal estável exige assinatura corporativa reconhecida, sem depender deste mecanismo temporário.

A chave privada do certificado de laboratório não deve ser distribuída junto com o instalador.

## 5. Identidade da extensão

```text
ID da extensão: chdfbekdjpecdajbpdelmhpemenoelmd
Programa auxiliar: com.egba.regua_editorial.helper
```

A mesma chave institucional da extensão deve ser preservada em atualizações. Qualquer divergência de ID interrompe a distribuição, porque o Chrome passa a tratar o pacote como outra extensão e outro espaço de dados.

## 6. Proteção dos cálculos

Os cálculos ficam no perfil do Chrome do operador.

Para reduzir risco de perda:

- não limpar dados do navegador;
- não trocar de perfil durante a operação;
- não remover a extensão sem avaliação prévia;
- exportar relatórios conforme a rotina definida pela gestão;
- registrar quantidade e totais antes de reparos ou reversões invasivas.

A remoção integral exige exportação prévia ou autorização expressa para descarte.

## 7. Conversão de documentos

A conversão de DOC e RTF deve:

- operar sobre cópia do arquivo;
- preservar o original;
- abrir o documento como somente leitura;
- desabilitar macros;
- usar pasta de trabalho controlada;
- não registrar conteúdo documental em logs.

Qualquer sobrescrita do original ou execução de macro deve ser tratada como incidente crítico.

## 8. Evidências e logs

Antes de compartilhar evidências:

- remova nomes de clientes e protocolos reais;
- não inclua conteúdo do documento;
- não inclua credenciais ou identificadores de sessão;
- limite o material a versões, horários, códigos de erro e resultados técnicos necessários.

## 9. Resposta a incidentes

Em caso de suspeita de comprometimento da chave, alteração do instalador, execução inesperada, perda de dados ou distribuição não autorizada:

1. interrompa novas instalações;
2. restrinja a Release afetada;
3. preserve instalador, `.sha256`, logs e identificação das estações;
4. não apague dados ou evidências antes da análise;
5. comunique GERDO, TI e Segurança da Informação;
6. avalie reparo, reversão ou retirada controlada;
7. só retome após nova validação e autorização.

A troca de identidade da extensão é medida excepcional, pois afeta o acesso aos cálculos armazenados localmente.