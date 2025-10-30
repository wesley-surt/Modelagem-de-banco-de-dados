# 🚀 Sistema de Controle de Estoque - Modelagem de Dados

## Etapa 2. Modelagem Conceitual

Nesta etapa, é produzido o modelo conceitual do banco de dados, usando os princípios de Entidade-Relacionamento (MER/DER) para definir as estruturas de dados.

---

### 🧱 Entidades e Atributos Principais

| Entidade | Chave Primária (PK) | Atributos | Observações |
| :--- | :--- | :--- | :--- |
| **Fornecedor** | `CNPJ` | * Razão Social, Tipo de Mercadoria, Contato (Telefone, Email), Endereço (`FK`) | O CNPJ garante a unicidade do Fornecedor. |
| **Cliente** | `Identificador Pessoal` | * Nome, Contato (Telefone, Email), Endereço (`FK`) | O identificador pessoal (CPF/CNPJ) atende ao requisito de rastreio. |
| **Produto** | `Código` | * Nome, Fornecedor (`FK`), Lote | Representa o item de estoque. O `Fornecedor (FK)` pode ser removido e a dependência totalmente transferida para `fornecedor_produto` para evitar redundância na 1FN/2FN, mas a mantemos aqui como referência principal. |
| **Endereço** | `ID (PK - Sugerido)` | * Logradouro, Número, Bairro, Cidade, Estado | Entidade opcional para normalização de dados de localização. |

---

### 🔄 Entidades de Transação (Movimentação de Estoque)

| Entidade | Chave Primária (PK) | Chaves Estrangeiras (FK) | Atributos | Finalidade |
| :--- | :--- | :--- | :--- | :--- |
| **Compra** | `ID Compra` | `ID Fornecedor` | * Data/Hora, Valor Total, Forma de Pagamento, Nota Fiscal | Cabeçalho das transações de entrada de estoque. |
| **Item_Compra** | `ID (PK - Sugerido)` | `ID Compra`, `ID Produto` | * Quantidade Comprada, Valor Unitário (no momento da compra) | Detalhe da Compra: Vincula o produto à transação e registra o custo exato. |
| **Venda** | `ID Venda` | `ID Cliente` | * Data/Hora, Valor Total, Forma de Pagamento | Cabeçalho das transações de saída de estoque. |
| **Item_Venda** | `ID (PK - Sugerido)` | `ID Venda`, `ID Produto` | * Quantidade Vendida, Valor Unitário (no momento da venda) | Detalhe da Venda: Vincula o produto à transação e registra o preço exato. |

---

### 🤝 Tabela Associativa (Relacionamento N:N)

| Entidade | Chave Primária (PK) | Chaves Estrangeiras (FK) | Atributos | Finalidade |
| :--- | :--- | :--- | :--- | :--- |
| **fornecedor_produto** | **Composta**: `ID Fornecedor` + `ID Produto` | `ID Fornecedor`, `ID Produto` | * Valor Unitário Padrão pelo Fornecedor, Prazo de Entrega | Resolve o relacionamento Muitos-para-Muitos e armazena condições específicas do Fornecedor para o Produto. |

***

### 📌 Observação sobre o Estoque (`Quantidade`):

> O atributo **Quantidade em Estoque** não está na tabela `Produto`. Ele será **sempre calculado** (Soma das entradas em `Item_Compra` - Soma das saídas em `Item_Venda`) pela aplicação (Back-end) ou pelo SGBD (View/Stored Procedure) para garantir a integridade total dos dados.

---
### ✔️ Diagrama Entidade-Relacionamento (DER):

<img width="1295" height="792" alt="modelagem_estoque_DER" src="https://github.com/user-attachments/assets/89bad332-caa0-499a-b0b5-b021163c5c20" />

