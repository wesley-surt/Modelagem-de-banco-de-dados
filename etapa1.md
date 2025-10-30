# Etapa 1.
## **Aspéctos levantados a serem solucionados - levantamento de requisitos:**

- Produto tem código (chave primária), nome, fornecedor, lote

- Os Fornecedores devem ser registrados
- Fornecedores fornecem Produtos
- Fornecedor tem cnpj (chave primária), razão social, tipo de mercadoria, contato (email, telefone), endereço (logradouro, número, bairro, cidade, Estado)

- Os Clientes devem ser registrados
- Clientes compram Produtos
- Cliente tem identificador pessoal (cpf ou cnpj - chave primária), nome, tipo de pessoa (física ou jurídica), contato (email, telefone), endereço (logradouro, número, bairro, cidade, Estado)
- O papel do Cliente no controle de estoque será meramente para o rastreio do Produto

- Venda tem chave primária (aleatória), chave estrangeira de cliente, data/hora, valor total, forma de pagamento
- Venda (saída/baixa de estoque): relaciona-se com Cliente
- Item Da Venda tem chave estrangeira de Venda, chave estrangeira de Produto, quantidade vendida, valor unitário (no momento da venda)

- Compra tem chave primária, chave estrangeira de Fornecedor, data/hora, valor total, forma de pagamento, nota fiscal
- Compra (entrada/aumento de estoque): relaciona-se com Fornecedor
- Item compra tem chave estrangeira de Compra, chave estrangeira de Produto, quantidade comprada, custo unitário (no momento da compra)

- Um Produto pode ser fornecido por um ou vários Fornecedores
- Um Fornecedor pode fornecer um ou vários Produtos diferentes
- Um Cliente pode adquirir um ou mais Produtos
