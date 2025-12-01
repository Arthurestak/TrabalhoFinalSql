/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DAS TABELAS
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



OBS: idGerente na tabela departamento foi criado depois
por causa que a tabela funcionário ainda não tinha sido criada.

Realmente, essa parte do código tá bela! kakakakkaakkakak
*/

CREATE TABLE Fornecedor (
    idFornec SERIAL PRIMARY KEY,
    cnpjFornec VARCHAR(14) UNIQUE,
    nomeFornec VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    emailFornec VARCHAR(100)
);

CREATE TABLE Cliente (
    idCliente SERIAL PRIMARY KEY,
    cpfCliente VARCHAR(11) UNIQUE,
    pNome VARCHAR(50) NOT NULL,
    sNome VARCHAR(50),
    telefoneCliente VARCHAR(20),
    emailCliente VARCHAR(100),
    dataCadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Departamento (
    idDep SERIAL PRIMARY KEY,
    nomeDep VARCHAR(100) NOT NULL
    -- idGerente adicionado após a tabela Funcionario
);

CREATE TABLE Produto (
    idProduto SERIAL PRIMARY KEY,
    nomeProduto VARCHAR(100) NOT NULL,
    qtdEstoque INT DEFAULT 0 CHECK (qtdEstoque >= 0), -- estoque não negativo
    valorUnd NUMERIC(10, 2) NOT NULL,
    idFornecedor INT NOT NULL,
    CONSTRAINT fk_fornecedor FOREIGN KEY (idFornec) REFERENCES Fornecedor (idFornec)
);

CREATE TABLE Funcionario (
    idFunc SERIAL PRIMARY KEY,
    cpfFunc VARCHAR(11) UNIQUE,
    pNome VARCHAR(50) NOT NULL,
    sNome VARCHAR(50),
    emailFunc VARCHAR(100),
    telefoneFunc VARCHAR(20),
    dataAdimissao TIMESTAMP NOT NULL,
    idDep INT NOT NULL,

    CONSTRAINT fk_departamento FOREIGN KEY (idDep) REFERENCES Departamento (idDep)
);

CREATE TABLE Venda (
    idVenda SERIAL PRIMARY KEY,
    dataVenda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    idCliente INT NOT NULL,
    idFunc INT NOT NULL,

    CONSTRAINT fk_cliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
    CONSTRAINT fk_funcionario FOREIGN KEY (idFunc) REFERENCES Funcionario (idFunc)
);

-- Existe por causa da junção N:N entre Venda e Produto
CREATE TABLE itensVenda (
    idVenda INT NOT NULL,
    idProduto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    valor NUMERIC(10, 2) NOT NULL,

    CONSTRAINT pk_itens_venda PRIMARY KEY (idVenda, idProduto),

    CONSTRAINT fk_venda FOREIGN KEY (idVenda) REFERENCES Venda (idVenda),
    CONSTRAINT fk_produto FOREIGN KEY (idProduto) REFERENCES Produto (idProduto)
);

ALTER TABLE Departamento ADD COLUMN idGerente INT,
ADD CONSTRAINT fk_gerente FOREIGN KEY (idGerente) REFERENCES Funcionario (idFunc);


/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DOS INSERTS
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



10 registros em cada tabela,

Realmente, fico inserto se os nomes são bons akkakakakkak
*/

INSERT INTO Fornecedor (cnpjFornec, nomeFornec, categoria, emailFornec) VALUES
('00111222000133', 'Tecidos Premium', 'Tecidos Finos', 'contato@tecidopremium.com'),
('00222333000144', 'Malharia Leve S.A.', 'Malhas e Lãs', 'sac@malharialeve.com.br'),
('00333444000155', 'Acessórios Chic', 'Bijuterias e Cintos', 'vendas@acessorioschic.com'),
('00444555000166', 'Aviamentos Rápido', 'Linhas e Botões', 'comercial@aviamentos.net'),
('00555666000177', 'Confecção Moderna', 'Roupas Prontas Casual', 'contato@modcasual.com'),
('00666777000188', 'Jeans Total Distribuidora', 'Tecidos Denim e Peças', 'vendas@jeanstotal.com.br'),
('00777888000199', 'Moda Íntima S.A.', 'Lingerie', 'faleconosco@modaintima.com'),
('00888999000100', 'Calçados Leves', 'Sapatos e Tênis', 'suporte@calcadosleves.com'),
('00999000000111', 'Embalagens Luxo', 'Sacolas e Etiquetas', 'vendas@embalagensluxo.com'),
('01000111000122', 'Uniformes Profi', 'Roupas Prontas Corporativo', 'contato@uniformesprofi.net');

INSERT INTO Cliente (cpfCliente, pNome, sNome, telefoneCliente, emailCliente, dataCadastro) VALUES
('11122233344', 'Ana', 'Silva', '11987654321', 'ana.silva@email.com', '2023-01-15 10:00:00'),
('22233344455', 'Bruno', 'Santos', '21998765432', 'bruno.santos@email.com', '2023-02-20 11:30:00'),
('33344455566', 'Carla', 'Oliveira', '31976543210', 'carla.oliver@email.com', '2023-03-25 12:45:00'),
('44455566677', 'Daniel', 'Pereira', '41965432109', 'daniel.p@email.com', '2023-04-10 14:00:00'),
('55566677788', 'Eduarda', 'Costa', '51954321098', 'eduarda.c@email.com', '2023-05-05 15:15:00'),
('66677788899', 'Felipe', 'Almeida', '61943210987', 'felipe.a@email.com', '2023-06-12 16:30:00'),
('77788899900', 'Giovana', 'Rocha', '71932109876', 'giovana.r@email.com', '2023-07-18 17:45:00'),
('88899900011', 'Henrique', 'Lima', '81921098765', 'henrique.l@email.com', '2023-08-01 09:00:00'),
('99900011122', 'Isabela', 'Gomes', '91910987654', 'isabela.g@email.com', '2023-09-08 10:30:00'),
('00011122233', 'João', 'Martins', '11909876543', 'joao.m@email.com', '2023-10-02 11:45:00');

INSERT INTO Departamento (nomeDep) VALUES
('Administrativo'),
('Vendas'),
('Financeiro'),
('Logística'),
('Marketing'),
('TI'),
('Recursos Humanos'),
('Comercial'),
('Reparos'),
('Atendimento ao Cliente');

INSERT INTO Produto (nomeProduto, qtdEstoque, valorUnd, idFornecedor) VALUES
('Notebook Gamer X1', 50, 4500.00, 1),
('Arroz Integral 5kg', 200, 25.50, 2),
('Cadeira Ergonômica', 80, 750.90, 3),
('Caneta Gel Azul', 1000, 4.99, 4),
('Camiseta Algodão Pima', 300, 89.90, 5),
('Furadeira de Impacto', 45, 320.00, 6),
('Shampoo Anticaspa', 150, 35.75, 7),
('Licença Office Pro', 90, 599.90, 8),
('Ração para Cães Premium 10kg', 120, 150.00, 9),
('Desinfetante Floral 2L', 500, 12.50, 10);

INSERT INTO Funcionario (cpfFunc, pNome, sNome, emailFunc, telefoneFunc, dataAdimissao, idDep) VALUES
('11111111111', 'Roberto', 'Souza', 'roberto.s@empresa.com', '1188887777', '2020-05-10', 1),
('22222222222', 'Maria', 'Clara', 'maria.clara@empresa.com', '2188886666', '2019-03-01', 2),
('33333333333', 'Carlos', 'Junior', 'carlos.jr@empresa.com', '3188885555', '2021-08-15', 3),
('44444444444', 'Luciana', 'Mendes', 'luciana.m@empresa.com', '4188884444', '2022-01-20', 4),
('55555555555', 'Fernando', 'Neves', 'fernando.n@empresa.com', '5188883333', '2020-11-25', 5),
('66666666666', 'Patricia', 'Ribeiro', 'patricia.r@empresa.com', '6188882222', '2018-07-12', 2),
('77777777777', 'Guilherme', 'Teixeira', 'guilherme.t@empresa.com', '7188881111', '2023-04-05', 6),
('88888888888', 'Renata', 'Castro', 'renata.c@empresa.com', '8188880000', '2019-09-30', 7),
('99999999999', 'Marcelo', 'Dantas', 'marcelo.d@empresa.com', '9188889999', '2021-02-18', 8),
('00000000000', 'Vivian', 'Lopes', 'vivian.l@empresa.com', '1177778888', '2022-10-01', 2);

UPDATE Departamento SET idGerente = 1 WHERE idDep = 1;
UPDATE Departamento SET idGerente = 2 WHERE idDep = 2;
UPDATE Departamento SET idGerente = 3 WHERE idDep = 3;
UPDATE Departamento SET idGerente = 1 WHERE idDep = 4;
UPDATE Departamento SET idGerente = 2 WHERE idDep = 5;
UPDATE Departamento SET idGerente = 3 WHERE idDep = 6;
UPDATE Departamento SET idGerente = 1 WHERE idDep = 7;
UPDATE Departamento SET idGerente = 2 WHERE idDep = 8;
UPDATE Departamento SET idGerente = 3 WHERE idDep = 9;
UPDATE Departamento SET idGerente = 1 WHERE idDep = 10;


INSERT INTO Venda (dataVenda, idCliente, idFunc) VALUES
('2023-11-01 10:30:00', 1, 2),
('2023-11-01 15:45:00', 3, 6),
('2023-11-02 11:00:00', 5, 2),
('2023-11-03 14:00:00', 2, 10),
('2023-11-04 09:15:00', 4, 6),
('2023-11-05 16:30:00', 6, 2),
('2023-11-06 12:00:00', 8, 10),
('2023-11-07 13:45:00', 7, 6),
('2023-11-08 17:00:00', 9, 2),
('2023-11-09 08:30:00', 10, 10);

INSERT INTO itensVenda (idVenda, idProduto, quantidade, valor) VALUES
(1, 1, 1, 4500.00),
(2, 5, 2, 89.90),
(3, 3, 1, 750.90),
(4, 9, 1, 150.00),
(5, 6, 1, 320.00),
(6, 2, 3, 25.50),
(7, 8, 1, 599.90),
(8, 7, 2, 35.75),
(9, 4, 10, 4.99),
(10, 10, 5, 12.50);

/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DOS SELECTS
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


*/

-- Fornecedor (idFornec, cnpjFornec, nomeFornec, categoria, emailFornec)
-- Produto (idProduto, nomeProduto, qtdEstoque, valorUnd, idFornecedor)

-- Info dos fornecedores e seus produtos

SELECT
    f.idFornec,
    f.cnpjFornec,
    f.nomeFornec,
    f.categoria,
    f.emailFornec,
    p.nomeProduto,
    p.qtdEstoque,
    p.valorUnd
FROM Fornecedor AS f
JOIN Produto AS p
ON (f.idFornec = p.idFornec)
ORDER BY idFornec;








/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DAS VIEWS
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



*/

/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DAS FUNCTIONS
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



*/

/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DAS TRIGGERS
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



*/

/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DOS INDICES
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



*/

/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DAS TRANSAÇÕES E CONTROLE DE CONCORRENCIA
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



*/

/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
CRIAÇÃO DA SEGURANÇA E CONTROLE DE ACESSO
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



*/