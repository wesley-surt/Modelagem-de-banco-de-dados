# Etapa 2.
## Modelagem Conceitual
Nesta etapa é produzido o modelo conceitual do banco de dados, usando os modelos MER (Modelo Entidade Relacionamento) e DER (Diagrama Entidade Relacionamento).

<br>

### **Entidades e seus atributos:**
- Fornecedor:
  - CNPJ (PK)
  - Razão social
  - Contato
<br>
  
- Cliente:
  - CPF / CNPJ (PK)
  - Nome
  - Contato
 <br>
    
- Produto:
  - Código (PK)
  - Nome
  - Quantidade
  - Fornecedor (FK)
<br>

### **Relacionamentos:**
- Movimentação entrada
- Movimentação saída

![Modelagem Conceitual](https://github.com/user-attachments/assets/abed2e96-5079-497e-a8ab-ccc8e66b4146)

