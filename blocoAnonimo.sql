CREATE TABLE Tab_Erro
( Data_hj DATE,
  Msg VARCHAR2(150));
  
INSERT INTO Produto
VALUES (020, 'Monitor', 'UN', NULL);

DECLARE
	V_Preco NUMBER(5);
	BEGIN
		SELECT Valor_Unitario into V_Preco
		FROM Produto
		WHERE Cod_Produto = 20;
		
		IF V_Preco IS NULL THEN
			UPDATE Produto
			SET Valor_Unitario = 100
			WHERE Cod_Produto = 20;
		END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			INSERT INTO Tab_Erro VALUES (SYSDATE, 'Produto não Encontrado!');
END;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Atualiza_Preco (P_Cod_P NUMBER) -- P_Cod_P RECEBERA UM VALOR PASSADO POR PARAMETRO
AS
	V_Preco NUMBER(5);
	BEGIN
		SELECT Valor_Unitario into V_Preco
		FROM Produto
		WHERE Cod_Produto = P_Cod_P;
		
		IF V_Preco IS NULL THEN
			UPDATE Produto
			SET Valor_Unitario = 100
			WHERE Cod_Produto = P_Cod_P;
		END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			INSERT INTO Tab_Erro VALUES (SYSDATE, 'Produto não Encontrado!' || P_Cod_P); -- || CONCATENA
END;

EXEC Atualiza_Preco(20); -- VERSOES MAIS ANTIGAS

BEGIN
	Atualiza_Preco(20);
END;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- EXERCÍCIO 1

CREATE OR REPLACE PROCEDURE Inserir_Reg (Num_Pedido_P NUMBER, Cod_Produto_P NUMBER, Quantidade_P NUMBER)
AS
	--V_Preco NUMBER(6,2);
	V_Preco Produto.Valor_Unitario % type; --A variavel V_Preco sera do mesmo tipo do campo Valor_Unitario da tabela Produto
	BEGIN
		SELECT Valor_Unitario INTO V_Preco
		FROM Produto
		WHERE Cod_Produto = Cod_Produto_P;
		
		INSERT INTO Item_Pedido
		VALUES (Num_Pedido_P, Cod_Produto_P, Quantidade_P, V_Preco);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			INSERT INTO Tab_Erro VALUES (SYSDATE, 'Produto não Encontrado!');
END;

BEGIN
	Inserir_Reg(1, 3, 90);
END;
-- EXCEPTION so funciona com SELECT

-- EXERCÍCIO 2

CREATE OR REPLACE PROCEDURE Excluir_Cliente (Cod_Cliente_P NUMBER)
AS
	BEGIN
		DELETE FROM Cliente
		WHERE  Cod_Cliente = Cod_Cliente_P;
		IF SQL%ROWCOUNT = 0 THEN
			INSERT INTO Tab_Erro VALUES (SYSDATE, 'Cliente inválido!');
		ELSE
			INSERT INTO Tab_Erro VALUES (SYSDATE, 'Cliente Excluído com sucesso!');
		END IF;
		COMMIT;
END;

BEGIN
	Excluir_Cliente(10);
END;

---------- OUTRA FORMA - Com RAISE_APPLICATION_ERROR -----------------------------

CREATE OR REPLACE PROCEDURE Excluir_Cliente (Cod_Cliente_P NUMBER)
AS
	BEGIN
		DELETE FROM Cliente
		WHERE  Cod_Cliente = Cod_Cliente_P;
		IF SQL%ROWCOUNT = 0 THEN
			RAISE_APPLICATION_ERROR(-20001, 'Cliente inválido!');
		ELSE
			INSERT INTO Tab_Erro VALUES (SYSDATE, 'Cliente Excluído com sucesso!');
		END IF;
		COMMIT;
END;

BEGIN
	Excluir_Cliente(10);
END;


---------- Exercício 20/04/2017 -----------------------------------------------------

CREATE TABLE Tab_Mensagem
( DtMsg DATE,
  Msg VARCHAR2(200));

CREATE OR REPLACE PROCEDURE Verif_Cliente (Cod_Cliente_P NUMBER)
AS
	CodCli Pedido.Cod_Cliente % type;
	NomeCli Cliente.Nome_Cliente % type;
	BEGIN
		SELECT Nome_Cliente INTO NomeCli
		FROM Cliente
		WHERE Cod_Cliente = Cod_Cliente_P;
		
		SELECT COUNT(*) INTO CodCli
		FROM Pedido
		WHERE Cod_Cliente = Cod_Cliente_P AND Prazo_Entrega BETWEEN '01-03-2012' AND '31-03-2012'
		GROUP BY Cod_Cliente
		HAVING COUNT(*) > 3;
		
		IF SQL%ROWCOUNT <> 0 THEN
			INSERT INTO Tab_Mensagem VALUES (SYSDATE, 'Cliente Especial - Enviar Brinde ' || NomeCli || ' ' || CodCli);
		END IF;
		
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RAISE_APPLICATION_ERROR(-20001, 'Cliente não existe');
	END;

BEGIN
	Verif_Cliente(1);
END;








