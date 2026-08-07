# Checklist de entrega — Entrega 1.0.1

Use este checklist para registrar build, QA, publicação, implantação, homologação e orientação ao usuário.

## 1. Gate de build e QA

- [ ] build gerou os dois instaladores;
- [ ] `BOTH_INSTALLERS_READY` registrado;
- [ ] QA conjunto executado;
- [ ] `BOTH_ARTIFACTS_QA_PASSED` registrado;
- [ ] instaladores têm SHA-256 diferentes;
- [ ] runtime scripts do pacote estão compatíveis com Windows PowerShell 5.1/UTF-8;
- [ ] artefato de homologação local contém override de gerenciamento;
- [ ] artefato corporativo não contém bypass do gate AD;
- [ ] Extension ID validado como `chdfbekdjpecdajbpdelmhpemenoelmd`.

## 2. Publicação da Release

- [ ] Release privada `v1.0.1-pilot.1` criada/atualizada;
- [ ] `ReguaEditorial-Entrega1-Corporativo-x64.exe` anexado;
- [ ] `ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256` anexado;
- [ ] `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe` anexado;
- [ ] `ReguaEditorial-Entrega1-HomologacaoLocal-x64.exe.sha256` anexado;
- [ ] hashes conferidos após novo download;
- [ ] tamanho dos dois executáveis registrado;
- [ ] código-fonte e staging não foram anexados;
- [ ] PEM/PFX/chaves privadas ausentes;
- [ ] pacote anterior preservado;
- [ ] responsável e data da publicação registrados.

## 3. Identificação da versão

- [ ] Setup `1.0.1`;
- [ ] extensão `0.7.4`;
- [ ] regras `municipios-editorial-rules@1.3.0`;
- [ ] Helper `0.1.4`;
- [ ] Native Messaging `1.2.0`;
- [ ] IndexedDB/schema `3`;
- [ ] ID `chdfbekdjpecdajbpdelmhpemenoelmd`;
- [ ] native host `com.egba.regua_editorial.helper`;
- [ ] canal `pilot`.

## 4. Preparação da estação corporativa

- [ ] Windows x64;
- [ ] Chrome instalado;
- [ ] `PartOfDomain = True`;
- [ ] credencial administrativa ou execução como SYSTEM;
- [ ] perfil Chrome operacional identificado;
- [ ] Word instalado quando DOC/RTF forem necessários;
- [ ] dados anteriores avaliados antes da atualização;
- [ ] extensão descompactada de desenvolvimento removida/desativada no perfil de teste.

## 5. Instalação corporativa

- [ ] SHA-256 validado;
- [ ] Chrome fechado;
- [ ] instalador **Corporativo** executado como administrador;
- [ ] instalação concluída sem erro;
- [ ] `installation.json` criado;
- [ ] `chrome-policy.json` criado;
- [ ] Helper presente em Program Files;
- [ ] `chrome://policy` recarregado;
- [ ] extensão visível em `chrome://extensions`;
- [ ] nome, versão e ID conferidos;
- [ ] extensão indicada como gerenciada;
- [ ] probe do Helper aprovado.

## 6. Homologação local fora do domínio

- [ ] estação deliberadamente fora do AD;
- [ ] instalador **HomologacaoLocal** utilizado;
- [ ] override local registrado no estado;
- [ ] políticas Chrome aplicadas;
- [ ] extensão instalada com o mesmo ID operacional;
- [ ] Helper e fluxo funcional aprovados;
- [ ] artefato local não foi confundido com o corporativo.

## 7. Teste funcional

- [ ] página compatível reconhecida;
- [ ] side panel abre;
- [ ] DOCX processado;
- [ ] prévia conferida;
- [ ] regras editoriais 1.3.0 verificadas;
- [ ] medição conferida;
- [ ] preço conferido;
- [ ] cálculo salvo;
- [ ] registro localizado por consulta;
- [ ] relatório por data gerado;
- [ ] relatório por intervalo gerado;
- [ ] CSV exportado;
- [ ] JSON exportado;
- [ ] registros preservados após reinício do Chrome;
- [ ] DOC testado quando aplicável;
- [ ] RTF testado quando aplicável.

## 8. Manutenção e rollback

- [ ] reparo testado sem trocar Extension ID;
- [ ] reparo preservou IndexedDB;
- [ ] remoção padrão validada;
- [ ] remoção integral documentada e protegida por confirmação;
- [ ] versão anterior disponível;
- [ ] plano de rollback disponível;
- [ ] logs e estados conhecidos pela TI;
- [ ] processo de migração futura para HTTPS documentado.

## 9. Segurança

- [ ] repositório e Release privados;
- [ ] nenhum segredo versionado;
- [ ] nenhuma chave privada anexada;
- [ ] nenhum documento de produção anexado;
- [ ] evidências sanitizadas;
- [ ] hashes arquivados;
- [ ] certificado temporário identificado pelo manifesto/thumbprint;
- [ ] plano de assinatura corporativa registrado para `stable`;
- [ ] Native Messaging restrito ao Extension ID operacional;
- [ ] host permission da extensão restrito ao EGBANET.

## 10. Orientação ao usuário

- [ ] usuário recebeu o [Guia rápido de uso](08-GUIA-RAPIDO-DE-USO.md);
- [ ] usuário sabe abrir a matéria antes da extensão;
- [ ] usuário conhece os fluxos DOCX/DOC/RTF;
- [ ] usuário revisa prévia, medição e preço;
- [ ] usuário sabe consultar/exportar registros;
- [ ] usuário foi orientado a usar o mesmo perfil Chrome;
- [ ] usuário foi orientado a não limpar dados do navegador sem procedimento;
- [ ] usuário sabe registrar mensagens de erro sem enviar conteúdo de produção.

## 11. Aceite

- [ ] testes obrigatórios aprovados;
- [ ] pendências e limitações registradas;
- [ ] aceite funcional GERDO;
- [ ] aceite técnico TI;
- [ ] grupo/OU de piloto registrado;
- [ ] decisão de ampliar, corrigir ou suspender registrada;
- [ ] inventário da Release atualizado.
