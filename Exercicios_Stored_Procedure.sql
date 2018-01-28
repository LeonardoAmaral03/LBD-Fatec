-- 1

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

-- 2

CREATE OR REPLACE PROCEDURE Calc_Perc_Comissao (Cod_Vendedor_P NUMBER)
AS
	CodVend Vendedor.Cod_Vendedor % type;
	TotPed NUMBER(8,2);
	BEGIN
		SELECT Cod_Vendedor INTO CodVend
		FROM Vendedor
		WHERE Cod_Vendedor = Cod_Vendedor_P;
		
		SELECT SUM(ip.Quantidade * ip.Pco_Unit) INTO TotPed
		FROM Pedido p, Item_Pedido ip
		WHERE p.Cod_Vendedor = Cod_Vendedor_P AND p.Num_Pedido = ip.Num_Pedido
		GROUP BY p.Cod_Vendedor;
		
		
		
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				INSERT INTO Tab_Erro VALUES(SYSDATE, 'Vendedor não existe!');
	END;
	
-- 3

Create or replace procedure P_ProdPed ( Pcod number) as

E_pedido exception;
vproduto produto.cod_produto%type;
vpedido itempedido.num_pedido%type;

begin
  select cod_produto into vproduto from produto 
  where cod_produto = pcod;

 if vproduto IN (select ip.cod_produto from item_pedido ip, produto p where p.cod_produto = ip.cod_produto and p.cod_produto = Pcod) then
       raise E_pedido;
  end if;

  commit;
  
  exception
     when no_data_found then
        insert into tab_erro values( sysdate, 'não existe o produto'||pcod);

     when E_pedido then 
        insert into tab_erro values (sysdate,' produto não tem pedido -  '|| pcod);
        delete produto where cod_produto = pcod;
        rollback;
end;

-- 4

Create or replace procedure Insere_Ped (pcodprod produto.cod_produto%type, pnumped pedido.num_pedido%type, pcodcli cliente.cod_cliente%type, pcodven vendedor.cod_vendedor%type)
as
    vcod produto.cod_produto%type;
    vdata pedido.prazo_entrega%type;
       
begin
    select cod_produto into vcod
    from produto
    where cod_produto = pcodprod;
    
    if pcodprod between 1 and 10 then
        vdata := sysdate + 15;
    end if;
    
    if pcodprod between 11 and 20 then
        vdata := sysdate + 30;
    end if;
    
    insert into pedido values (pnumped, vdata, pcodcli, pcodven);
    
exception
    when no_data_found
        raise_application_error (-20001, 'Produto nao existe !!!');
end;

-- 5

create or replace procedure Insere_itens (pcodprod produto.cod_produto%type, pnumped pedido.num_pedido%type, pqtde item_pedido.quantidade%type)
as
    vcod produto.cod_produto%type;
    vpreco produto.valor_unitario%type;
    vqtde item_pedido.quantidade%type;
       
begin
    select cod_produto into vcod
    from produto
    where cod_produto = pcodprod;
   
    select valor_unitario into vpreco
    from produto
    where cod_produto = pcodprod;
    
    select qtde_estoque into vqtde
    from produto
    where cod_produto = pcodprod;
    
    if vqtde < 0 then
          raise_application_error (-20001, 'Quantidade incorreta!');
    elsif
          vqtde < pqtde then
                raise_application_error (-20001, 'Quantidade em estoque insuficiente do produto desejado!');
          else
                insert into item_pedido values (pnumped, pcodprod, pqtde, vpreco);
    end if;
    
exception
    when no_data_found
        raise_application_error (-20001, 'Produto nao existe !!!');
end;
