-- FUNÇÕES

-- Exemplo 1

CREATE FUNCTION calcDobro (P1 NUMBER)
RETURN NUMBER
AS
	P2 NUMBER;
BEGIN
	P2:=P1*2; -- atribuição no ORACLE :=
	RETURN P2;
END;

SELECT CrmMedico, calcDobro(VrConsulta) -- PARA EXECUTAR
FROM Medico;

				-- OU
				
BEGIN  -- PARA EXECUTAR
	DBMS_OUTPUT.PUT_LINE(calcDobro(50));
END;

set SERVEROUTPUT ON -- para exibir resultado do DBMS_OUTPUT.PUT_LINE

-- Exemplo 2

CREATE OR REPLACE FUNCTION Fn_Dev_Descr (PCOD Produto.Cod_Produto % type)
RETURN VARCHAR2
AS
	VDescr Produto.Descricao % type;
BEGIN
	SELECT Descricao INTO VDescr
	FROM Produto
	WHERE Cod_Produto = PCOD;
	
	RETURN VDescr;
END;

SELECT Num_Pedido, Cod_Produto, Fn_Dev_Descr(Cod_Produto) -- PARA EXECUTAR
FROM Item_Pedido;