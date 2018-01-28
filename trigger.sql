-- EXEMPLO 1

-- Criação da Tabela LogTeste
CREATE TABLE LogTeste
( NrLog Number Primary key,
  DtTrans Date,
  Usuario  varchar2(100),
  Opera  varchar2(1) Check(Opera IN ('I', 'A', 'E')));

-- Criação de Auto Incremento para Tabela LogTeste  
Create Sequence SegLog;


--toda vez que um produto for excluido, gravar um registro na tab logtest

CREATE OR REPLACE TRIGGER Elimina_Prop
BEFORE DELETE ON Produto
FOR EACH ROW

BEGIN
	INSERT INTO LogTeste VALUES(SegLog.nextval, SYSDATE, USER, 'E');
END;

Insert into Produto
values (050, 'Caixa', 'UN' , 10.50, 50);

DELETE FROM Produto
WHERE Cod_Produto = 50;

-- EXEMPLO 2

-- toda vez que um produto for inserido ou desc for alterada, gravar um registro
-- na tabela logteste

CREATE OR REPLACE TRIGGER Elimina_Prop2
BEFORE INSERT OR UPDATE OF Descricao ON Produto
FOR EACH ROW

BEGIN
	IF INSERTING THEN
		INSERT INTO LogTeste VALUES(SegLog.nextval, SYSDATE, USER, 'I');
	ELSE
		INSERT INTO LogTeste VALUES(SegLog.nextval, SYSDATE, USER, 'A');
	END IF;
END;

Insert into Produto
values (050, 'Caixa', 'UN' , 10.50, 50);

UPDATE Produto
SET Descricao = 'Caixa Grande'
WHERE Cod_Produto = 50;

-- EXEMPLO 3

-- toda vez que um produto for inserido ou descricao do produto for alterada ou o 
-- produto for excluido, grave um registro na tab logtest

CREATE OR REPLACE TRIGGER Elimina_Prop3
BEFORE INSERT OR UPDATE OF Descricao ON Produto
FOR EACH ROW

BEGIN
	IF INSERTING THEN
		INSERT INTO LogTeste VALUES(SegLog.nextval, SYSDATE, USER, 'I');
	ELSE
		IF DELETING THEN
			INSERT INTO LogTeste VALUES(SegLog.nextval, SYSDATE, USER, 'E');
		ELSE
			INSERT INTO LogTeste VALUES(SegLog.nextval, SYSDATE, USER, 'A');
		END IF;
	END IF;
END;

-- Meu Usuario
DELETE FROM LogTeste
WHERE USUARIO = 'BD1521022';

Insert into Produto
values (050, 'Caixa', 'UN' , 10.50, 50);

DELETE FROM Produto
WHERE Cod_Produto = 50;

-- Habilitar e Desabilitar Trigger
ALTER TRIGGER Elimina_Prop DISABLE;
ALTER TRIGGER Elimina_Prop ENABLE;

-- EXEMPLO 4

-- exiba um mensagem de erro se o usuário tentar excluir ou alterar um cliente
-- antes das 7:00 e depois das 14:00. Usando o raise_application_error

create or replace trigger verif_hora before update or delete on cliente
for each row
begin
	if to_char(sysdate, 'HH24') not between 7 and 14 then
		if updating then
			raise_application_error(-20001, 'atualizao nao permitida neste horário');
		else
			raise_application_error(-20001,'exclusão nao permitida neste horário');
		end if;
	end if;
end;

-- EXEMPLO 5

-- ao inserir um novo pedido, ubstitua o prazo_entrega informado pela
-- data de hoje + 15 dias.

create or replace trigger ins_pedido before insert on pedido
for each row
begin
	:new.prazo_entrega := sysdate + 15;	
end;

/*
	O comando ':new.' é feito para alterar uma coluna em uma instrução,
	ele acontece em tempo de execução.	
	-- Explicao professora:
		Em um trigger de linha existe uma forma de acessar os campos que
		estão sendo acessados atualmente através dos qualificadores:
		:new e :old.
		
		Tabela de valores das variáveis :new e :old
					:new					:old
		INSERT		Valores que estão		null
					sendo incluídos
		
		UPDATE		Valores já modifica-    valores originais antes
					dos.					da modificação
					
		DELETE		null					valores antes da exclusão.
		
*/

-- EXEMPLO 6

-- ao incluir um novo produto, substitua o vlaor unitario informado 
-- pelo mesmo valor c/ 10% de desconto

create or replace trigger ins_produto 
before insert on produto
for each row
begin
	:new.valor_produto := :new.valor_produto * 0.9;
end;

-- EXEMPLO 7

-- ao alterar um prazo de entrega de um pedido, grave em uma tablea o prazo antigo
-- o prazo novo e o nome do cliente que fez o pedido em questão.

create table execTrigger(
	anterior date,
	nova date,
	nome varchar2(100) );

create or replace trigger update_pedido
before update of prazo_entrega on pedido
for each row
declare	nome varchar(100);
begin

	select nome_cliente into nome
	from cliente
	where cod_cliente = :new.cod_cliente;

	insert into execTrigger 
	values(:old.prazo_entrega, :new.prazo_entrega, nome);
end;