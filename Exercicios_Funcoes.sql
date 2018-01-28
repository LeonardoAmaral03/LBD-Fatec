-- 1

create or replace function Ver_hora (pdata pedido.prazo_entrega%type)
return varchar2
as
    vhora  varchar2(20);
begin
    vhora := to_char(pdata,'DD-MM-YYYY HH24:MI:SS');
    return vhora;
end;

-- 2

CREATE OR REPLACE FUNCTION Def_Idoso (CODPAC Pacientes.RgPaciente % type)
RETURN VARCHAR2
AS
	VIdade Pacientes.Idade % type;
BEGIN
	SELECT Idade INTO VIdade
	FROM Pacientes
	WHERE RgPaciente = CODPAC;
	
	IF VIdade > 65 THEN
		RETURN 'IDOSO';
	ELSE
		RETURN 'NÃO IDOSO';
	END IF;
END;

SELECT RgPaciente, Idade, Def_Idoso(RgPaciente)
FROM Pacientes;

-- 3

create or replace function Consulta_estoque (pcodprod tb_produto.codprod%type)
return numeric
as
     vqtde numeric(6);
begin
     select qtde_estoque into vqtde
     from tb_produto
     where codprod = pcodprod;

     return vqtde;
end;

-- 4

create or replace function NumTel (pnum numeric)
return varchar2
as
     vresultado varchar2(30);
begin
     vresultado := '(' || substr(pnum, 1,2) || ') ' || substr (pnum, 3, 4) || '-' || substr (pnum, 7,4);
     return vresultado;
end;

-- 5

create or replace function ContaPedidos (pcodcli tb_cliente.codcli%type)
return varchar2
as
     vqtde numeric(6);
     vnome varchar2(50);
begin
     select nomecli into vnome
     from tb_cliente
     where codcli = pcodcli;

     select count(numpedido) into vqtde
     from tb_pedido
     where codcli = pcodcli;

     if vqtde > 3 then
          return 'Cliente Preferencial - cod: ' || pcodcli || ' nome: ' || vnome;
     elsif (vqtde between 1 and 3) then
          return 'Cliente Normal - cod: ' || pcodcli || ' nome: ' || vnome;
     else 
          return 'Cliente Inativo - cod: ' || pcodcli || ' nome: ' || vnome;
     end if;
end;
