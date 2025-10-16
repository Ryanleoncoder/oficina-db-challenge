-- 1️⃣ Recuperação simples com SELECT
SELECT nome, email 
FROM cliente;

-- 2️ Filtros com WHERE
SELECT * 
FROM ordem_servico 
WHERE status = 'Concluída';

-- 3️⃣ Atributo derivado (idade do veículo)
SELECT modelo, ano, YEAR(CURDATE()) - ano AS idade_veiculo
FROM veiculo;

-- 4️ Ordenação dos dados (ORDER BY)
SELECT descricao, valor_unitario 
FROM peca
ORDER BY valor_unitario DESC;

-- 5️ Agrupamento e filtros em grupos (HAVING)
SELECT idMecanico, COUNT(*) AS total_servicos
FROM servico_os
GROUP BY idMecanico
HAVING COUNT(*) > 1;

-- 6️ Junções complexas (JOINs) para visão completa
SELECT 
    c.nome AS cliente, 
    v.modelo AS veiculo, 
    o.status AS os_status, 
    s.descricao AS servico, 
    m.nome AS mecanico
FROM ordem_servico o
JOIN veiculo v ON o.idVeiculo = v.idVeiculo
JOIN cliente c ON v.idCliente = c.idCliente
JOIN servico_os so ON o.idOS = so.idOS
JOIN servico s ON so.idServico = s.idServico
JOIN mecanico m ON so.idMecanico = m.idMecanico;

-- 7️ Relação de peças utilizadas por ordem
SELECT 
    o.idOS, 
    c.nome AS cliente, 
    p.descricao AS peca, 
    po.quantidade, 
    po.valor_total
FROM peca_os po
JOIN ordem_servico o ON po.idOS = o.idOS
JOIN cliente c ON o.idVeiculo = (SELECT idVeiculo FROM veiculo WHERE idVeiculo = o.idVeiculo)
JOIN peca p ON po.idPeca = p.idPeca;
