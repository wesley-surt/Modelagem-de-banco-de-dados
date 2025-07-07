# Etapa 3.
## Modelagem Lógica

Nesta etapa é produzido as tabelas das entidades e definido os tipos de cada atributo, além de definir se o banco de dados será relacional ou não relacional.

## Tabelas relacionais

<br>

| **Fornecedor** |
|----------------|
| cnpj: VARCHAR(100) NOT NULL |
| razaoSocial: VARCHAR(100) NOT NULL |
| contato: VARCHAR(100) NOT NULL |

<br>

| **Cliente** |
|----------------|
| cpf: VARCHAR(100) NOT NULL |
| nome: VARCHAR(100) NOT NULL |
| contato: VARCHAR(100) NOT NULL |

<br>

| **Produto** |
|----------------|
| codigo: INTEGER NOT NULL |
| nome: VARCHAR(100) NOT NULL |
| quantidade: INTEGER NOT NULL |
| fornecedor (FK): NOT NULL |

<br>

| **Movimentação (entrada / saída)** |
|----------------|
| id: NOT NULL |
| tipoMovimentacao: VARCHAR(100) NOT NULL|
| origem: VARCHAR(100) |
| destino: VARCHAR(100) |
| data: VARCHAR(100) NOT NULL |
