-- -----------------------------------------------------------------
-- ARQUIVO DE CONSULTAS (QUERIES) PARA O SISTEMA DE ESTOQUE
-- Baseado no modelo de dados com PRODUTO, FORNECEDOR, CLIENTE,
-- COMPRA, VENDA e tabelas associativas.
-- -----------------------------------------------------------------

-- -----------------------------------------------------------------
-- Seção 1: Consultas de Cadastro (Listagens e JUNÇÕES Simples)
-- -----------------------------------------------------------------

-- 1.1: Listar todos os produtos (código, nome e lote)
SELECT
    codigo,
    nome,
    lote
FROM
    PRODUTO
ORDER BY
    nome ASC;


-- 1.2: Listar todos os fornecedores e seus endereços
-- (Exemplo de JOIN 1:1)
SELECT
    f.razao_social,
    f.cnpj,
    f.email,
    e.logradouro,
    e.numero,
    e.cidade,
    e.estado
FROM
    FORNECEDOR f
JOIN -- Usamos INNER JOIN pois todo fornecedor DEVE ter um endereço
    ENDERECO e ON f.id_endereco = e.id_endereco;


-- 1.3: Listar todos os clientes e seus endereços
SELECT
    c.nome,
    c.identificador_pessoal,
    e.logradouro,
    e.cidade,
    e.estado
FROM
    CLIENTE c
LEFT JOIN -- Usamos LEFT JOIN caso um cliente possa ser cadastrado sem endereço
    ENDERECO e ON c.id_endereco = e.id_endereco;


-- -----------------------------------------------------------------
-- Seção 2: Consultas da Tabela Associativa (N:M)
-- -----------------------------------------------------------------

-- 2.1: Quais produtos o "Fornecedor X" (ID 1) fornece?
-- (Junta Fornecedor -> Fornecedor_Produto -> Produto)
SELECT
    f.razao_social,
    p.nome AS produto_nome,
    p.codigo AS produto_codigo,
    fp.custo_unitario_padrao,
    fp.prazo_entrega
FROM
    FORNECEDOR_PRODUTO fp
JOIN
    FORNECEDOR f ON fp.id_fornecedor = f.id_fornecedor
JOIN
    PRODUTO p ON fp.id_produto = p.id_produto
WHERE
    f.id_fornecedor = 1; -- Substitua '1' pelo ID do fornecedor desejado


-- 2.2: Quem são os fornecedores do "Produto Y" (ID 5)?
-- (Junta Produto -> Fornecedor_Produto -> Fornecedor)
SELECT
    p.nome AS produto_nome,
    f.razao_social,
    f.email AS contato_fornecedor,
    fp.custo_unitario_padrao
FROM
    FORNECEDOR_PRODUTO fp
JOIN
    PRODUTO p ON fp.id_produto = p.id_produto
JOIN
    FORNECEDOR f ON fp.id_fornecedor = f.id_fornecedor
WHERE
    p.id_produto = 5; -- Substitua '5' pelo ID do produto desejado


-- -----------------------------------------------------------------
-- Seção 3: Consultas de Transações (Compras e Vendas)
-- -----------------------------------------------------------------

-- 3.1: Calcular o valor total de uma COMPRA específica (pela Nota Fiscal)
-- (Agregação com SUM)
SELECT
    c.nota_fiscal,
    c.data_hora,
    f.razao_social,
    SUM(ic.quantidade * ic.custo_unitario) AS valor_total_compra
FROM
    COMPRA c
JOIN
    ITEM_COMPRA ic ON c.id_compra = ic.id_compra
JOIN
    FORNECEDOR f ON c.id_fornecedor = f.id_fornecedor
WHERE
    c.nota_fiscal = 'NF-001234' -- Substitua pelo número da NF
GROUP BY
    c.id_compra; -- Agrupamos pela PK da Compra para garantir unicidade


-- 3.2: Calcular o valor total de uma VENDA específica (pelo ID da Venda)
SELECT
    v.id_venda,
    v.data_hora,
    c.nome AS nome_cliente,
    SUM(iv.quantidade * iv.valor_unitario) AS valor_total_venda
FROM
    VENDA v
JOIN
    ITEM_VENDA iv ON v.id_venda = iv.id_venda
JOIN
    CLIENTE c ON v.id_cliente = c.id_cliente
WHERE
    v.id_venda = 101 -- Substitua pelo ID da Venda
GROUP BY
    v.id_venda;


-- 3.3: Relatório de Vendas de um Cliente específico
-- (Quais produtos o "Cliente Z" (ID 3) comprou?)
SELECT
    v.data_hora,
    v.id_venda,
    p.nome AS produto,
    iv.quantidade,
    iv.valor_unitario,
    (iv.quantidade * iv.valor_unitario) AS subtotal
FROM
    VENDA v
JOIN
    ITEM_VENDA iv ON v.id_venda = iv.id_venda
JOIN
    PRODUTO p ON iv.id_produto = p.id_produto
WHERE
    v.id_cliente = 3 -- Substitua pelo ID do Cliente
ORDER BY
    v.data_hora DESC;


-- -----------------------------------------------------------------
-- Seção 4: Consultas de Análise e BI (Business Intelligence)
-- -----------------------------------------------------------------

-- 4.1: [IMPORTANTE] Cálculo de ESTOQUE ATUAL de todos os produtos
-- (O estoque é a SOMA de todas as COMPRAS menos a SOMA de todas as VENDAS)
-- Usamos CTEs (Common Table Expressions) para organizar
WITH TotalCompras AS (
    SELECT
        id_produto,
        SUM(quantidade) AS total_comprado
    FROM
        ITEM_COMPRA
    GROUP BY
        id_produto
),
TotalVendas AS (
    SELECT
        id_produto,
        SUM(quantidade) AS total_vendido
    FROM
        ITEM_VENDA
    GROUP BY
        id_produto
)
SELECT
    p.codigo,
    p.nome,
    p.lote,
    COALESCE(tc.total_comprado, 0) AS total_comprado,
    COALESCE(tv.total_vendido, 0) AS total_vendido,
    (COALESCE(tc.total_comprado, 0) - COALESCE(tv.total_vendido, 0)) AS estoque_atual
FROM
    PRODUTO p
LEFT JOIN
    TotalCompras tc ON p.id_produto = tc.id_produto
LEFT JOIN
    TotalVendas tv ON p.id_produto = tv.id_produto
ORDER BY
    p.nome;


-- 4.2: Total de Vendas (Faturamento) por Produto em um período
SELECT
    p.nome,
    p.codigo,
    SUM(iv.quantidade) AS unidades_vendidas,
    SUM(iv.quantidade * iv.valor_unitario) AS faturamento_total
FROM
    ITEM_VENDA iv
JOIN
    VENDA v ON iv.id_venda = v.id_venda
JOIN
    PRODUTO p ON iv.id_produto = p.id_produto
WHERE
    v.data_hora BETWEEN '2025-01-01 00:00:00' AND '2025-01-31 23:59:59' -- Ex: Vendas de Janeiro/2025
GROUP BY
    p.id_produto, p.nome, p.codigo
ORDER BY
    faturamento_total DESC;


-- 4.3: Ranking TOP 5 Clientes (Maiores Compradores)
SELECT
    c.nome,
    c.identificador_pessoal,
    COUNT(DISTINCT v.id_venda) AS total_pedidos,
    SUM(iv.quantidade * iv.valor_unitario) AS valor_total_gasto
FROM
    CLIENTE c
JOIN
    VENDA v ON c.id_cliente = v.id_cliente
JOIN
    ITEM_VENDA iv ON v.id_venda = iv.id_venda
GROUP BY
    c.id_cliente, c.nome, c.identificador_pessoal
ORDER BY
    valor_total_gasto DESC
LIMIT 5;
