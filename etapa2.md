# 🚀 Etapa 2. Modelagem Conceitual

Nesta etapa, é produzido o modelo conceitual do banco de dados, usando os princípios de Entidade-Relacionamento (MER/DER) para definir as estruturas de dados.

---

### 🧱 Entidades e Atributos Principais

| Entidade | Chave Primária (PK) | Atributos | Observações |
| :--- | :--- | :--- | :--- |
| **Fornecedor** | `ID` | * CNPJ, Razão Social, Tipo de Mercadoria, Contato (Telefone, Email), Endereço (`FK`) | O CNPJ garante a unicidade do Fornecedor. |
| **Cliente** | `ID` | * Identificador Pessoal, Nome, Contato (Telefone, Email), Endereço (`FK`) |  |
| **Produto** | `ID` | * Código, Nome |  |
| **Endereço** | `ID` | * Logradouro, Número, Bairro, Cidade, Estado |  |

---

### 🔄 Entidades de Transação (Movimentação de Estoque)

| Entidade | Chave Primária (PK) | Chaves Estrangeiras (FK) | Atributos | Finalidade |
| :--- | :--- | :--- | :--- | :--- |
| **Compra** | `ID` | `ID Fornecedor` | * Data/Hora, Valor Total, Forma de Pagamento, Nota Fiscal | Cabeçalho das transações de entrada de estoque. |
| **Item_Compra** | `ID` | `ID Compra`, `ID Produto` | * Quantidade Comprada, Valor Unitário (no momento da compra) | Detalhe da Compra: Vincula o produto à transação e registra o custo exato. |
| **Venda** | `ID` | `ID Cliente` | * Data/Hora, Valor Total, Forma de Pagamento | Cabeçalho das transações de saída de estoque. |
| **Item_Venda** | `ID` | `ID Venda`, `ID Produto` | * Quantidade Vendida, Valor Unitário (no momento da venda) | Detalhe da Venda: Vincula o produto à transação e registra o preço exato. |

---

### 🤝 Tabela Associativa (Relacionamento N:N)

| Entidade | Chave Primária (PK) | Chaves Estrangeiras (FK) | Atributos | Finalidade |
| :--- | :--- | :--- | :--- | :--- |
| **fornecedor_produto** | **Composta**: `ID` | `ID Fornecedor`, `ID Produto` | * Valor Unitário Padrão pelo Fornecedor, Prazo de Entrega | Resolve o relacionamento Muitos-para-Muitos e armazena condições específicas do Fornecedor para o Produto. |

***

### 📌 Observação sobre o Estoque (`Quantidade`):

> O atributo **Quantidade em Estoque** não está na tabela `Produto`. Ele será **sempre calculado** (Soma das entradas em `Item_Compra` - Soma das saídas em `Item_Venda`) pela aplicação (Back-end) ou pelo SGBD (View/Stored Procedure) para garantir a integridade total dos dados.

---
### ✔️ Diagrama Entidade-Relacionamento (DER):

<img width="1294" height="792" alt="modelagem_de_estoque drawio - draw io e mais 3 páginas - Pessoal — Microsoft​ Edge 07_11_2025 22_53_00" src="https://github.com/user-attachments/assets/9d10f5d8-a850-4786-be80-4d584ca75123" />

