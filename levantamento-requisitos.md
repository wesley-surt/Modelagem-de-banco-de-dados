# 🏁 Etapa 1: Levantamento de Requisitos

> O objetivo desta etapa é definir as entidades, atributos e regras de negócio essenciais para a modelagem de um sistema simples de controle de estoque.

---

## 🏛️ Entidades e Atributos

Aqui estão as principais entidades de dados identificadas para o sistema:

### 📦 Produto
* **PK:** Chave Primária
* `Código`
* `Nome`

### 🚚 Fornecedor
* **PK:** Chave Primária
* `CNPJ`
* `Razão Social`
* `Tipo de Mercadoria`
* `Contato` (Email, Telefone)
* `Endereço` (FK)

### 🙋 Cliente
* **PK:** Chave Primária
* `Identificador Pessoal` (CPF ou CNPJ)
* `Nome`
* `Tipo de Pessoa` (Física ou Jurídica)
* `Contato` (Email, Telefone)
* `Endereço` (FK)

### 📍 Endereço
* **PK:** Chave Primária
* `Logradouro`
* `Número`
* `Bairro`
* `Cidade`
* `Estado`

### 📈 Venda (Saída de Estoque)
* **PK:** Chave Primária
* `Cliente` (FK)
* `Data/Hora`
* `Valor Total`
* `Forma de Pagamento`

### 🛒 Item da Venda
* **PK:** Chave Primária
* `Venda` (FK)
* `Produto` (FK)
* `Quantidade Vendida`
* `Valor Unitário` (Valor no momento da venda)

### 📉 Compra (Entrada de Estoque)
* **PK:** Chave Primária
* `Fornecedor` (FK)
* `Data/Hora`
* `Valor Total`
* `Forma de Pagamento`
* `Nota Fiscal`

### 🧾 Item da Compra
* **PK:** Chave Primária
* `Compra` (FK)
* `Produto` (FK)
* `Quantidade Comprada`
* `Custo Unitário` (Custo no momento da compra)

---

## ⚙️ Regras de Negócio e Relacionamentos

### Fluxo de Processos
* **Gestão de Clientes:** Clientes devem ser registrados no sistema.
* **Gestão de Fornecedores:** Fornecedores devem ser registrados no sistema.
* **Entrada de Estoque (Compra):** Está diretamente relacionada a um **Fornecedor**.
* **Saída de Estoque (Venda):** Está diretamente relacionada a um **Cliente**.

### Cardinalidade (Relacionamentos)
* **Fornecedor ↔ Produto (N:N)**
    * Um **Produto** pode ser fornecido por um ou vários **Fornecedores**.
    * Um **Fornecedor** pode fornecer um ou vários **Produtos**.
* **Cliente ↔ Produto (N:N, via Venda)**
    * Um **Cliente** pode adquirir um ou mais **Produtos** (através de múltiplas vendas).
* **Compra ↔ Nota Fiscal (1:1)**
    * Uma **Compra** tem uma **Nota Fiscal**.
    * Uma **Nota Fiscal** pertence a uma **Compra**.
