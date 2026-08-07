# Distribuição por Active Directory / GPO

Este procedimento é destinado à TI para implantação do instalador **Corporativo** em lote.

## Artefato institucional

```text
ReguaEditorial-Entrega1-Corporativo-x64.exe
ReguaEditorial-Entrega1-Corporativo-x64.exe.sha256
```

O instalador `HomologacaoLocal` não deve ser distribuído por GPO.

## Modelo recomendado

```text
Release privada
→ validar SHA-256
→ compartilhamento corporativo restrito
→ grupo/OU piloto
→ instalação silenciosa
→ validação técnica
→ homologação funcional
→ expansão em ondas
```

Mantenha cada versão em pasta própria. Não sobrescreva a versão anterior.

## Script pronto

Use:

```text
scripts/implantacao/Instalar-Corporativo-GPO.ps1
```

Exemplo:

```powershell
.\Instalar-Corporativo-GPO.ps1 `
  -SourceDirectory '\\servidor\software$\ReguaEditorial\v1.0.1-pilot.1'
```

O script:

- exige execução administrativa/SYSTEM;
- confirma `PartOfDomain = True`;
- valida `.sha256` antes e depois da cópia local;
- evita reinstalação quando a versão está saudável;
- executa o Setup em modo `/S`;
- valida Helper, `installation.json` e `chrome-policy.json`;
- executa probe do Helper;
- grava log de implantação.

## GPO Startup Script

O ponto de implantação recomendado para esta entrega é um Startup Script em **Computer Configuration**, executado como máquina. Isso normalmente ocorre antes de o usuário abrir o Chrome.

Fluxo esperado:

```text
SYSTEM
→ validar domínio
→ validar versão instalada
→ copiar pacote para ProgramData
→ validar hash
→ Setup /S
→ health check
→ log
```

## Staging local

Padrão do script:

```text
C:\ProgramData\EGBA\ReguaEditorial\deploy\1.0.1\
```

Logs:

```text
C:\ProgramData\EGBA\ReguaEditorial\Logs\install.log
C:\ProgramData\EGBA\ReguaEditorial\Logs\gpo-deploy.log
```

## Políticas Chrome

O Setup atual grava as entradas próprias em:

```text
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist
HKLM\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionSettings
```

Se a organização passar a gerir essas políticas centralmente por GPO/Chrome Enterprise, defina uma única fonte de autoridade e valide a precedência em lote piloto antes da expansão.

## Atualizações

Para uma nova versão:

1. publique nova Release;
2. valide assinatura e hash;
3. preserve o mesmo Extension ID;
4. crie nova pasta no compartilhamento;
5. altere o alvo do grupo piloto;
6. valide IndexedDB e fluxos funcionais;
7. amplie por ondas.

Não use limpeza do perfil Chrome como mecanismo de atualização.

## Critério de expansão

Só ampliar quando o grupo piloto comprovar:

- Setup concluído;
- versão/ID corretos;
- Helper saudável;
- extensão gerenciada;
- DOCX funcional;
- DOC/RTF funcional onde aplicável;
- cálculos persistidos após reiniciar o Chrome;
- ausência de bloqueio por EDR/antivírus.

Consulte também [Atualização e rollback](../tecnico/ATUALIZACAO-E-ROLLBACK.md).