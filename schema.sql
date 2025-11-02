CREATE DATABASE IF NOT EXISTS estoque_db;
USE estoque_db;

CREATE TABLE ENDERECO (
    id_endereco INT NOT NULL AUTO_INCREMENT,
    logradouro VARCHAR(255) NOT NULL,
    numero INT NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    
    PRIMARY KEY (id_endereco)
);

CREATE TABLE FORNECEDOR (
    id_fornecedor INT NOT NULL AUTO_INCREMENT,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    razao_social VARCHAR(255) NOT NULL,
    tipo_mercadoria VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    id_endereco INT NOT NULL,
    
    PRIMARY KEY (id_fornecedor),
    
    FOREIGN KEY (id_endereco) 
        REFERENCES ENDERECO (id_endereco)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE CLIENTE (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    identificador_pessoal VARCHAR(18) NOT NULL UNIQUE,
    nome_razao_social VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    id_endereco INT NOT NULL,
    
    PRIMARY KEY (id_cliente),
    
    FOREIGN KEY (id_endereco) 
        REFERENCES ENDERECO (id_endereco)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE PRODUTO (
    id_produto INT NOT NULL AUTO_INCREMENT,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (id_produto)
);

CREATE TABLE FORNECEDOR_PRODUTO (
    id_fornecedor INT NOT NULL,
    id_produto INT NOT NULL,
    custo_unitario_padrao DECIMAL(10, 2) NOT NULL,
    prazo_entrega INT NOT NULL,
    
    PRIMARY KEY (id_fornecedor, id_produto),
    
    FOREIGN KEY (id_fornecedor) 
        REFERENCES FORNECEDOR (id_fornecedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    FOREIGN KEY (id_produto) 
        REFERENCES PRODUTO (id_produto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE COMPRA (
    id_compra INT NOT NULL AUTO_INCREMENT,
    id_fornecedor INT NOT NULL,
    data_hora DATETIME NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    nota_fiscal VARCHAR(100) NOT NULL UNIQUE,
    
    PRIMARY KEY (id_compra),
    
    FOREIGN KEY (id_fornecedor) 
        REFERENCES FORNECEDOR (id_fornecedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE ITEM_COMPRA (
    id_item_compra INT NOT NULL AUTO_INCREMENT,
    id_compra INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    custo_unitario DECIMAL(10, 2) NOT NULL,
    
    PRIMARY KEY (id_item_compra),
    
    FOREIGN KEY (id_compra) 
        REFERENCES COMPRA (id_compra)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    FOREIGN KEY (id_produto) 
        REFERENCES PRODUTO (id_produto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    UNIQUE KEY uk_compra_produto (id_compra, id_produto)
);

CREATE TABLE VENDA (
    id_venda INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_hora DATETIME NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (id_venda),
    
    FOREIGN KEY (id_cliente) 
        REFERENCES CLIENTE (id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE ITEM_VENDA (
    id_item_venda INT NOT NULL AUTO_INCREMENT,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    
    PRIMARY KEY (id_item_venda),
    
    FOREIGN KEY (id_venda) 
        REFERENCES VENDA (id_venda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    FOREIGN KEY (id_produto) 
        REFERENCES PRODUTO (id_produto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    UNIQUE KEY uk_venda_produto (id_venda, id_produto)
);
