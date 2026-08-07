# Suporte e diagnóstico

Use esta página para triagem inicial. Preserve os dados do perfil Chrome antes de ações destrutivas.

## Verificações rápidas

1. A matéria está em uma URL compatível do EGBANET?
2. O Chrome foi totalmente fechado e reaberto?
3. A extensão aparece em `chrome://extensions` com versão `0.7.4` e ID correto?
4. As políticas aparecem em `chrome://policy`?
5. O Helper existe e responde ao probe?
6. O usuário está no mesmo perfil Chrome em que os cálculos foram salvos?

## Helper

```powershell
$Helper = "$env:ProgramFiles\EGBA\ReguaEditorialHelper\ReguaEditorial.Helper.exe"
Test-Path $Helper
& $Helper --probe --workspace "$env:TEMP"
```

Esperado: Helper `0.1.4`, contrato `1.2.0`, workspace gravável e `available = true`.

## Estado e logs

```text
C:\ProgramData\EGBA\ReguaEditorial\state\installation.json
C:\ProgramData\EGBA\ReguaEditorial\state\chrome-policy.json
C:\ProgramData\EGBA\ReguaEditorial\Logs\install.log
```

Leitura do log:

```powershell
Get-Content "$env:ProgramData\EGBA\ReguaEditorial\Logs\install.log" -Tail 150
```

## Sintomas comuns

| Sintoma | Primeiro diagnóstico |
|---|---|
| extensão não aparece | conferir `chrome://policy`, reiniciar Chrome e validar instalação |
| ícone desabilitado | confirmar URL compatível da matéria |
| DOCX falha | reproduzir com arquivo sintético e registrar código |
| DOC/RTF falha | validar Word + Helper |
| cálculo desapareceu | confirmar perfil Chrome e eventual limpeza de dados |
| relatório diverge | conferir filtros/período e registros individuais |
| ID diferente | interromper uso e distribuição |
| `ACTIVE_DIRECTORY_REQUIRED` | usar instalador corporativo somente em estação ingressada no domínio |
| `EXTENSION_MANAGEMENT_REQUIRED` em laboratório | confirmar uso do instalador `HomologacaoLocal` atual |

## Dados que não devem ser enviados em evidências

- conteúdo da matéria ou documento;
- cookies, tokens ou senhas;
- protocolo/cliente real quando não necessário;
- cópia integral do IndexedDB.

Prefira versão, horário, código de erro, estado do componente e arquivo sintético.

## Antes de reparar ou remover

1. registre a quantidade/período dos cálculos;
2. exporte CSV/JSON quando houver risco de perda;
3. mantenha o mesmo perfil Chrome;
4. não limpe dados do navegador;
5. consulte [Atualização e rollback](../tecnico/ATUALIZACAO-E-ROLLBACK.md).

## Escalonamento

Trate como crítico: perda de cálculos, cálculo incorreto com impacto operacional, documento errado, sobrescrita do original, execução de macro, exposição de dados ou falha generalizada.