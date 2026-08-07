# Guia rápido de uso

## Começar

1. Entre normalmente no EGBANET.
2. Abra a matéria.
3. Clique no ícone **Régua Editorial SieDOE** no Chrome.
4. Confira protocolo, cliente e identificação da matéria.
5. Processe o documento.
6. Revise a prévia, a medição e o valor.
7. Salve o cálculo.

A extensão atua nas páginas de matéria:

```text
/admin/materias/edit/{id_materia}
/admin/materias/edicao_restrita/{id_materia}
```

## DOCX

DOCX é processado diretamente pela extensão.

Antes de salvar o cálculo, confira:

- matéria correta;
- protocolo e cliente;
- prévia sem cortes;
- tarja e conteúdo;
- medida e preço;
- ausência de bloqueio pendente.

## DOC e RTF

Quando Microsoft Word e o Helper estão disponíveis, a ferramenta converte uma **cópia** para DOCX e continua o fluxo.

O original não deve ser sobrescrito.

Se a conversão automática era esperada e não ocorrer, registre a mensagem e acione a TI.

## Consultar cálculos

Na área de consultas/relatórios:

- filtre por data ou período;
- pesquise protocolo ou cliente;
- confira medidas e valores;
- retorne à matéria no EGBANET quando houver vínculo;
- exporte CSV ou JSON quando necessário.

## Preservar os registros

Os cálculos ficam no IndexedDB do perfil do Chrome.

- use sempre o mesmo perfil;
- não limpe os dados do navegador sem orientação;
- não remova a extensão sem avaliar os dados;
- exporte relatórios conforme a rotina operacional.

## Quando não prosseguir

Não salve o cálculo quando houver:

- prévia incompleta;
- medição ou preço sem explicação;
- matéria/documento incorreto;
- bloqueio editorial;
- erro de conversão ainda não resolvido.

Consulte [Suporte e diagnóstico](SUPORTE.md) para tratamento de falhas.