# Segurança da distribuição

## Escopo

Este repositório contém somente documentação de entrega e Releases privadas da Régua Editorial SieDOE — Municípios à Vista.

## Materiais proibidos

Nunca versionar ou anexar:

- chave privada PEM da extensão;
- PFX, P12, KEY ou senha de certificado;
- cookies, tokens ou credenciais;
- documentos DOCX, DOC ou RTF de produção;
- conteúdo textual de matérias;
- exportações contendo dados reais de clientes sem autorização;
- logs com protocolo, cliente, ID de matéria ou caminhos documentais.

## Binários

O instalador deve ser publicado como ativo de uma GitHub Release privada, acompanhado do arquivo `.sha256`. Não manter cópias não rastreadas do executável dentro da árvore Git.

## Identidade operacional

- Extension ID: `chdfbekdjpecdajbpdelmhpemenoelmd`;
- Native host: `com.egba.regua_editorial.helper`;
- a mesma PEM deve ser preservada institucionalmente para futuras atualizações;
- qualquer divergência de ID interrompe a distribuição.

## Incidentes

Em caso de suspeita de comprometimento da PEM, alteração de hash, execução inesperada ou distribuição não autorizada:

1. interromper imediatamente novas instalações;
2. preservar o executável, hash e evidências;
3. restringir a Release afetada;
4. comunicar GERDO, GERINF/TI e Segurança da Informação;
5. avaliar revogação operacional da política da extensão e nova identidade somente mediante plano formal, pois a troca de ID afeta o armazenamento local da extensão.