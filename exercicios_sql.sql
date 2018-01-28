-- Exercício 2.1

-- 1
CREATE TABLE Cliente
( Cod_cliente number(5, 0) PRIMARY KEY,
  Nome_cliente varchar2(30),
  Endereco varchar2(25),
  Cidade varchar2(20),
  Cep varchar2(2),
  UF varchar2(2));
  
CREATE TABLE Vendedor
( Cod_Vendedor number(5, 0) PRIMARY KEY,
  Nomevendedor varchar2(30),
  Faixa_Comissao number(2, 2),
  Salario_Fixo number(5, 2));

CREATE TABLE Produto
( Cod_Produto number(3, 0) PRIMARY KEY,
  Descricao varchar2(20),
  Unidade varchar2(2),
  Valor_unitario number(6, 2));
  
CREATE TABLE Pedido
( Num_Pedido number(5, 0) PRIMARY KEY,
  Prazo_Entrega DATE);
  
CREATE TABLE Item_Pedido
( Num_Pedido number(5, 0) NOT NULL REFERENCES Pedido,
  Cod_Produto Number(3, 0) NOT NULL REFERENCES Produto,
  Quantidade number(5, 0));

ALTER TABLE Pedido ADD (Cod_Cliente number(5, 0) NOT NULL REFERENCES Cliente);
ALTER TABLE Pedido ADD (Cod_vendedor number(5, 0) NOT NULL REFERENCES Vendedor);

-- Correções das Tabelas
ALTER TABLE Vendedor MODIFY (Faixa_Comissao number(4, 2));
ALTER TABLE Vendedor MODIFY (Salario_Fixo number(7, 2));
ALTER TABLE Produto MODIFY (Valor_unitario number(8, 2));
Alter TABLE Cliente MODIFY (Cep varchar2(10));


-- 2

-- Tabela Cliente
Insert into Cliente
values (00001, 'João da Silva', 'Rua Rolando, 30' , 'Sorocaba', '18077-460', 'SP');

Insert into Cliente
values (00002, 'Predo Alves', 'Rua Ladeira, 120' , 'Itu', '18124-456', 'SP');

Insert into Cliente
values (00003, 'Gilso Soares', 'Rua Voadora, 19' , 'Sorocaba', '12356-863', 'SP');

Insert into Cliente
values (00004, 'Carlao Pedro Joao', 'Avenida Itapanema, 1325' , 'Votorantim', '17456-760', 'SP');

Insert into Cliente
values (00005, 'Roberto Arnaldo', 'Rua das Flores' , 'Jundia', '13458-457', 'SP');

Insert into Cliente
values (00006, 'Rivaldo Pereira', null , 'Jundia', '13458-457', 'SP');

-- Tabela Vendedor
Insert into Vendedor
values (00001, 'Arnaldo C. Coelho', 50.00 , 1300.50);

Insert into Vendedor
values (00002, 'José da Obra', 25.70 , 1500.90);

Insert into Vendedor
values (00003, 'Wellington Silva', 15.30 , 1800.00);

Insert into Vendedor
values (00004, 'Vitão de Moraes', 10.90 , 1200.34);

Insert into Vendedor
values (00005, 'Ana Valentina', 33.47 , 1950.95);

Insert into Vendedor
values (00006, 'Gioconda Henrique', 5.86 , 300.95);

Insert into Vendedor
values (00007, 'José Sinistro', 20.40 , 350.90);

-- Tabela Produto
Insert into Produto
values (001, 'Lápis', 'UN' , 1.50);

Insert into Produto
values (002, 'Caderno', 'UN' , 30.50);

Insert into Produto
values (003, 'Mouse', 'UN' , 15.90);

Insert into Produto
values (004, 'Teclado', 'UN' , 20.90);

Insert into Produto
values (005, 'Arroz', 'KG' , 10.90);

INSERT into Produto
values (006, 'Folha Sulfite', 'CX' , 100.00);

INSERT into Produto
values (007, 'Cadeira', 'CX' , 300.00);

INSERT into Produto
values (008, 'Mesa', 'CX' , 30.00);

INSERT into Produto
values (009, 'Açucar', 'KG' , 10.00);

INSERT into Produto
values (010, 'Telefone', 'UN' , 50.00);

-- Tabela Pedido
Insert into Pedido
values (00001, '10/02/1990', 00001 , 00002);

Insert into Pedido
values (00002, '19/05/1991', 00004 , 00001);

Insert into Pedido
values (00003, '25/09/2002', 00003 , 00003);

Insert into Pedido
values (00004, '15/07/2003', 00001 , 00004);

Insert into Pedido
values (00005, '19/01/2006', 00002 , 00004);

-- Tabela Item_Pedido
Insert into Item_Pedido
values (00001, 002 , 00050);

Insert into Item_Pedido
values (00002, 003 , 00020);

Insert into Item_Pedido
values (00003, 001 , 00200);

Insert into Item_Pedido
values (00004, 004 , 00030);

Insert into Item_Pedido
values (00005, 005 , 00020);

-- 3

ALTER TABLE Cliente MODIFY (Endereco varchar2(30));

-- 4

ALTER TABLE Item_Pedido ADD (Pco_Unit number(6, 2));

-- 5

Update Cliente
set Cep = '18035-400'
Where Cidade = 'Sorocaba';

-- 6

Update Pedido
set Prazo_Entrega = Prazo_Entrega + 10
Where Cod_Cliente = 1;

-- 7

UPDATE Produto
SET Valor_unitario = Valor_unitario * 1.10
WHERE Unidade = 'KG';

-- 8

DELETE FROM Produto
WHERE Unidade = 'CX' AND Valor_unitario > 50.00;

-- Exercício 2.2

-- 1
SELECT Num_Pedido
FROM Pedido;

-- 2
SELECT Descricao, Valor_unitario
FROM Produto;

-- 3
SELECT Nome_cliente, Endereco
FROM Cliente;

-- 4
SELECT Nomevendedor
FROM Vendedor;

-- 5
SELECT *
FROM Cliente;

-- 6
SELECT *
FROM Produto;

-- 7
SELECT Nomevendedor "Nome"
FROM Vendedor;

-- 8
Select Valor_unitario * 1.10
FROM Produto;

-- 9
SELECT Salario_Fixo * 1.05
FROM Vendedor;

-- 10
SELECT Nome_cliente
FROM Cliente
WHERE Cidade = 'Sorocaba';

-- 11
SELECT *
FROM Vendedor
WHERE Salario_Fixo < 400.00;

-- 12
SELECT Cod_Produto, Descricao
FROM Produto
WHERE Unidade = 'KG';

-- 13
SELECT Num_Pedido
FROM Pedido
WHERE Prazo_Entrega >= '01/05/1990' AND Prazo_Entrega <= '01/06/2003';

-- 14
SELECT Num_Pedido, Prazo_Entrega
FROM Pedido
WHERE Prazo_Entrega like '%03';

-- 15
SELECT *
FROM Produto
WHERE Valor_unitario > 15.00 AND Valor_unitario < 30.10;

-- 16
SELECT Num_Pedido, Cod_Produto
FROM Item_Pedido
WHERE Quantidade >= 30 AND Quantidade <= 300;

-- 17
SELECT Nomevendedor
FROM Vendedor
WHERE Nomevendedor like 'José%';

-- 18
SELECT Nome_cliente
FROM Cliente
WHERE Nome_cliente like '%Silva';

-- 19
SELECT Descricao, Cod_Produto
FROM Produto
WHERE Descricao like '%Te%';

-- 20
SELECT Nome_cliente
FROM Cliente
WHERE Endereco IS NULL;

-- 21
SELECT distinct Cidade
FROM Cliente;

-- 22
SELECT *
FROM Cliente
ORDER BY Nome_cliente ASC;

-- 23
SELECT *
FROM Cliente
ORDER BY Cidade DESC;

-- 24
SELECT *
FROM Cliente
ORDER BY Cidade ASC, Nome_cliente ASC;

-- 25
SELECT Cod_Produto, Descricao
FROM Produto
WHERE Unidade = 'KG'
ORDER BY Descricao ASC;

-- Exercício 2.3

-- 1
SELECT MAX(Quantidade)
FROM Item_Pedido;

SELECT *
FROM Item_Pedido
WHERE Quantidade = (SELECT MAX(Quantidade) FROM Item_Pedido);

-- 2
SELECT MIN(Valor_unitario)
FROM Produto;

SELECT *
FROM Produto
WHERE Valor_unitario = (SELECT MIN(Valor_unitario) FROM Produto);

-- 3
SELECT SUM(Salario_fixo)
FROM Vendedor;

-- 4
SELECT COUNT(Cod_Produto)
FROM Produto
WHERE Unidade = 'LT';

-- 5
SELECT Cidade, COUNT(Cod_cliente)
FROM Cliente
GROUP BY Cidade;

-- 6
SELECT Cod_vendedor, COUNT(Num_pedido)
FROM Pedido
GROUP BY Cod_vendedor;

-- 7
SELECT Unidade, MAX(Valor_unitario), MIN(Valor_unitario)
FROM Produto
GROUP BY Unidade;

-- 8
SELECT Cidade, COUNT(Cod_cliente)
FROM Cliente
GROUP BY Cidade
HAVING COUNT(Cidade) > 1;

-- Exercício 2.4

-- 1
SELECT Vendedor.Cod_vendedor, Vendedor.Nomevendedor
FROM Vendedor, Pedido
WHERE Vendedor.Cod_vendedor = Pedido.Cod_Vendedor AND Pedido.Cod_Cliente = 1;

-- 2
SELECT Pedido.Num_Pedido, Pedido.Prazo_Entrega, Item_Pedido.Quantidade, Produto.Descricao
FROM Pedido, Item_Pedido, Produto
WHERE Produto.Cod_Produto = 2 AND Produto.Cod_Produto = Item_Pedido.Cod_Produto AND Item_Pedido.Num_Pedido = Pedido.Num_Pedido;

-- 3
SELECT Vendedor.Cod_Vendedor, Vendedor.Nomevendedor
FROM Vendedor, Pedido, Cliente
WHERE Cliente.Nome_cliente = 'João da Silva' AND Cliente.Cod_cliente = Pedido.Cod_cliente AND Pedido.Cod_vendedor = Vendedor.Cod_vendedor;

-- 4
SELECT Pedido.Num_Pedido, Produto.Cod_Produto, Produto.Descricao, Vendedor.Cod_Vendedor, Vendedor.Nomevendedor, Cliente.Nome_cliente
FROM Pedido, Produto, Vendedor, Cliente, Item_Pedido
WHERE Cliente.Cidade = 'Sorocaba' AND Cliente.Cod_Cliente = Pedido.Cod_Cliente AND Vendedor.Cod_Vendedor = Pedido.Cod_Vendedor AND Pedido.Num_Pedido = Item_Pedido.Num_Pedido AND Item_Pedido.Cod_Produto = Produto.Cod_Produto;

-- 5
SELECT Produto.Cod_Produto, Produto.Descricao, Item_Pedido.Quantidade, Pedido.Prazo_Entrega
FROM Pedido, Produto, Item_Pedido
WHERE Pedido.Num_Pedido = 1 AND Pedido.Num_Pedido = Item_Pedido.Num_Pedido AND Item_Pedido.Cod_Produto = Produto.Cod_Produto;

-- 6
SELECT Cliente.Nome_cliente, Cliente.Endereco
FROM Cliente, Vendedor, Pedido
WHERE (Cliente.Cidade = 'Sorocaba' OR Cliente.Cidade = 'Itu') AND Vendedor.Cod_Vendedor = 2 AND Cliente.Cod_Cliente = Pedido.Cod_Cliente AND Pedido.Cod_Vendedor = Vendedor.Cod_Vendedor;

-- Exercício 2.5

-- 1
CREATE OR REPLACE VIEW Ped_Cli
	AS
		SELECT Pedido.Num_Pedido, Cliente.Cod_Cliente, Pedido.Prazo_Entrega
		FROM Cliente, Pedido;

SELECT * FROM Ped_Cli;

-- 2
CREATE OR REPLACE VIEW Prod_KG
	AS
		SELECT *
		FROM Produto
		WHERE Produto.Unidade = 'KG';
		
SELECT * FROM Prod_KG;

-- 3
CREATE OR REPLACE VIEW Prod_Val
	AS
		SELECT *
		FROM Produto
		WHERE Produto.Valor_unitario < (SELECT AVG(Produto.Valor_unitario) FROM Produto);
		
SELECT * FROM Prod_Val;

-- 4
CREATE OR REPLACE VIEW Total_Ped_Vend
	AS
		SELECT Pedido.Cod_vendedor, Vendedor.Nomevendedor, COUNT(Pedido.Num_Pedido) Qtd_Pedido
		FROM Pedido, Vendedor
		WHERE Pedido.Cod_Vendedor = Vendedor.Cod_Vendedor
		GROUP BY Pedido.Cod_Vendedor, Vendedor.Nomevendedor;
		
SELECT * FROM Total_Ped_Vend;

-- Exercício 2.6

-- 1
SELECT *
FROM Cliente
WHERE Cidade = (SELECT Cidade FROM Cliente WHERE Nome_cliente = 'João da Silva');

-- 2
SELECT *
FROM Produto
WHERE Valor_unitario > (SELECT AVG(Valor_unitario) FROM Produto);

-- 3
SELECT DISTINCT Cod_Cliente, Nome_cliente
FROM Cliente
WHERE Cod_Cliente IN ((SELECT Cod_Cliente FROM Pedido WHERE Cod_Vendedor = 4)
					   MINUS
					  (SELECT Cod_Cliente FROM Pedido WHERE Cod_Vendedor <> 4));

-- 4
SELECT Nomevendedor
FROM Vendedor
WHERE Cod_Vendedor = (SELECT Vendedor.Cod_Vendedor
					  FROM Pedido, Vendedor
					  WHERE Pedido.Cod_Vendedor = Vendedor.Cod_Vendedor
					  GROUP BY Vendedor.Cod_Vendedor
					  HAVING COUNT(Pedido.Num_Pedido) < 5);
		   
-- 5
SELECT Nomevendedor
FROM Vendedor
WHERE Cod_Vendedor NOT IN (SELECT Vendedor.Cod_Vendedor
					   FROM Pedido, Vendedor
					   WHERE Pedido.Cod_Vendedor = Vendedor.Cod_Vendedor AND Prazo_Entrega LIKE '%05/91'
					   GROUP BY Vendedor.Cod_Vendedor);

-- 6
SELECT Nomevendedor
FROM Vendedor
WHERE Vendedor.Cod_Vendedor = (SELECT Cod_Vendedor FROM Pedido GROUP BY Cod_Vendedor 
      HAVING COUNT (Cod_Vendedor) >= ALL (SELECT COUNT(COd_vendedor) FROM Pedido GROUP BY Cod_Vendedor));			   
					   
-- 7
SELECT NOME_CLIENTE, COUNT (*) AS QTDE 
FROM CLIENTE C, PEDIDO P
WHERE C.COD_CLIENTE = P.COD_CLIENTE
GROUP BY NOME_CLIENTE
HAVING COUNT (*) IN (SELECT COUNT (*) 
                                   FROM PEDIDO 
                                   GROUP BY COD_CLIENTE)
ORDER BY QTDE DESC

-- 8				   
DELETE FROM ITEM_PEDIDO
WHERE NUM_PEDIDO IN (SELECT NUM_PEDIDO FROM PEDIDO
		WHERE COD_CLIENTE = 2);

-- 9
UPDATE PRODUTO
SET VALOR_UNITARIO = VALOR_UNITARIO * 0.8
WHERE COD_PRODUTO NOT IN (SELECT ITEM_PEDIDO.COD_PRODUTO FROM PEDIDO, ITEM_PEDIDO, PRODUTO 
		WHERE PEDIDO.NUM_PEDIDO = ITEM_PEDIDO.NUM_PEDIDO
		AND ITEM_PEDIDO.COD_PRODUTO = PRODUTO.COD:_PRODUTO
		AND TO_CHAR(PRAZO_ENTREGA, ‘YYYY’) = ‘2007’);
