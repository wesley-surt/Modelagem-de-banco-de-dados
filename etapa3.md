# 🚀 Projeto de Portfólio: Modelagem de Banco de Dados para Sistema de Estoque

## I. Visão Geral

Este documento detalha o processo de Modelagem de Dados para um sistema de controle de estoque simples

---

## IV. Etapa 3. Modelo Lógico (Estrutura Tabular)

O Modelo Lógico formaliza a estrutura relacional, definindo as tabelas, chaves e tipos de dados lógicos.

**Tipo de Modelo:** Relacional (Normalizado).

### 1. Entidades de Cadastro (Maestro)

| Tabela | Coluna | Tipo de Dado Lógico | Restrições | Observações |
| :--- | :--- | :--- | :--- | :--- |
| **PRODUTO** | id_produto (PK) | INTEIRO | Chave Primária, Não Nulo, Único | Chave interna. |
| | código | TEXTO | Único, Não Nulo | Código de catálogo. |
| | nome | TEXTO | Não Nulo | - |
| | lote | TEXTO | Não Nulo | - |
| **FORNECEDOR** | id_fornecedor (PK) | INTEIRO | Chave Primária, Não Nulo | Chave interna. |
| | cnpj | TEXTO | Único, Não Nulo | - |
| | razao\_social | TEXTO | Não Nulo | - |
| | email | TEXTO | Único | - |
| | id_endereco (FK) | INTEIRO | Chave Estrangeira | Liga ao ENDERECO (1:1). |
| **CLIENTE** | id_cliente (PK) | INTEIRO | Chave Primária, Não Nulo | Chave interna. |
| | identificador_pessoal | TEXTO | Único, Não Nulo | CPF/CNPJ. |
| | nome | TEXTO | Não Nulo | Nome ou razão social. |
| | id_endereco (FK) | INTEIRO | Chave Estrangeira | Liga ao ENDERECO (1:1). |
| **ENDERECO** | id_endereco (PK) | INTEIRO | Chave Primária, Não Nulo | - |
| | logradouro | TEXTO | Não Nulo | - |
| | numero | INTEIRO | Não Nulo | - |
| | cidade | TEXTO | Não Nulo | - |
| | estado | TEXTO (2 caracteres) | Não Nulo | UF. |

### 2. Tabela Associativa (Fornecedor x Produto)

| Tabela | Coluna | Tipo de Dado Lógico | Restrições | Observações |
| :--- | :--- | :--- | :--- | :--- |
| **FORNECEDOR\_PRODUTO** | id_fornecedor (FK) + id_produto (FK) | INTEIRO | Chave Primária | Chave primária baseada na soma dos 2 identificadores. |
| | id_fornecedor (FK) | INTEIRO | Chave Estrangeira | Liga ao Fornecedor. |
| | id_produto (FK) | INTEIRO | Chave Estrangeira | Liga ao Produto. |
| | custo_unitario_padrao | DECIMAL | Não Nulo | Condição de preço do fornecedor para o produto. |
| | prazo_entrega | INTEIRO | Não Nulo | Prazo em dias. |

### 3. Entidades de Transação (Compra e Venda)

| Tabela | Coluna | Tipo de Dado Lógico | Restrições | Transação |
| :--- | :--- | :--- | :--- | :--- |
| **COMPRA** | id_compra (PK) | INTEIRO | Chave Primária, Não Nulo | - |
| | id_fornecedor (FK) | INTEIRO | Chave Estrangeira, Não Nulo | - |
| | data_hora | DATA e HORA | Não Nulo | - |
| | nota_fiscal | TEXTO | Único, Não Nulo | Entrada |
| **ITEM_COMPRA** | id_item_compra (PK) | INTEIRO | Chave Primária, Não Nulo | - |
| | id_compra (FK) | INTEIRO | Chave Estrangeira, Não Nulo | - |
| | id_produto (FK) | INTEIRO | Chave Estrangeira, Não Nulo | - |
| | quantidade | INTEIRO | Não Nulo | Quantidade que entrou no sistema |
| | custo_unitario | DECIMAL | Não Nulo | - |
| **VENDA** | id_venda (PK) | INTEIRO | Chave Primária, Não Nulo | - |
| | id_cliente (FK) | INTEIRO | Chave Estrangeira, Não Nulo | - |
| | data_hora | DATA e HORA | Não Nulo | - |
| **ITEM\_VENDA** | id_item_venda (PK) | INTEIRO | Chave Primária, Não Nulo | - |
| | id_venda (FK) | INTEIRO | Chave Estrangeira, Não Nulo | - |
| | id_produto (FK) | INTEIRO | Chave Estrangeira, Não Nulo | - |
| | quantidade | INTEIRO | Não Nulo | - |
| | valor_unitario | DECIMAL | Não Nulo | - |
