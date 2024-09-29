/*cria um novo banco de dados, � poss�vel passar par�metros na sua cria��o
pode ser criado clicando com o bot�o direito em	'Database', l� tem as mesma especifica��es/par�metros*/
CREATE DATABASE [VENDAS SUCOS];
/*deleta um banco de dados*/
--DROP DATABASE [VENDAS SUCOS];

/*criando as tabelas do banco de dados criado*/
CREATE TABLE PRODUTOS (
    CODIGO VARCHAR(10) NOT NULL, 
    DESCRITOR VARCHAR(100) NULL, 
    SABOR VARCHAR(50) NULL, 
    TAMANHO VARCHAR(50) NULL, 
    EMBALAGEM VARCHAR(50) NULL, 
    PRECO_LISTA FLOAT NULL, 
    PRIMARY KEY (CODIGO)
);

CREATE TABLE VENDEDORES (
    MATRICULA VARCHAR(5) NOT NULL, 
    NOME VARCHAR(100) NULL, 
    BAIRRO VARCHAR(50) NULL, 
    COMISSAO FLOAT NULL, 
    DATA_ADMISSAO DATE NULL, 
    FERIAS BIT NULL, 
    PRIMARY KEY (MATRICULA)
);

CREATE TABLE CLIENTES (
	CPF VARCHAR(11) NOT NULL,
	NOME VARCHAR(100) NULL,
	ENDERECO VARCHAR(150) NULL,
	BAIRRO VARCHAR(50) NULL,
	CIDADE VARCHAR(50) NULL,
	ESTADO VARCHAR(50) NULL,
	CEP VARCHAR(8) NULL,
	DATA_NASCIMENTO DATE,
	IDADE INT,
	GENERO VARCHAR(1) NULL,
	LIMITE_DE_CREDITO FLOAT NULL,
	VOLUME_COMPRA FLOAT NULL,
	PRIMEIRA_COMPRA BIT NULL,
	PRIMARY KEY (CPF)
);

CREATE TABLE TABELA_DE_VENDAS (
    NUMERO VARCHAR(5) NOT NULL, 
    DATA_VENDA DATE NULL, 
    CPF VARCHAR(11) NOT NULL, 
    MATRICULA VARCHAR(11) NOT NULL, 
    IMPOSTO FLOAT NULL, 
    PRIMARY KEY (NUMERO)
);
/*cria��o das chaves estrangeiras:
ALTER TABLES - alterar a tabela [nome da tabela]
ADD CONSTRAINT - adicionar uma restri��o [dar um nome a essa restri��o]
FOREIGN KEY - chave estrangeira [colocar entre () o campo que recebe essa chave estrangeira]
REFERENCES - a refer�ncia da chave estrangeira [vai nome da tabela e a coluna de onde vem essa chave]
*/
ALTER TABLE TABELA_DE_VENDAS 
ADD CONSTRAINT FK_CLIENTES 
FOREIGN KEY (CPF) REFERENCES CLIENTES (CPF);
/*
esse comando abaixo da erro, pois � preciso que a primary key tenha os mesmo tipoe  tamanho do foreign kay
no caso, a TABELA_DE_VENDAS tem a MATRICULA VARCHAR(11), enquanto na tabela VENDEDORES tem a MATRICULA VARCHAR(5)
*/
ALTER TABLE TABELA_DE_VENDAS 
ADD CONSTRAINT FK_VENDEDORES 
FOREIGN KEY (MATRICULA) REFERENCES VENDEDORES (MATRICULA);
/*
para alterar o tipo de uma tabela, � poss�vel atrav�s do 
ALTER TABLE [nome da tabela] ALTER COLUMN [nome da coluna] e o tipo que ela precisa ter
*/
ALTER TABLE TABELA_DE_VENDAS 
ALTER COLUMN MATRICULA VARCHAR(5) NOT NULL;
/*
executando o mesmo comando para cadastrar uma foreign key, agora da certo
*/
ALTER TABLE TABELA_DE_VENDAS 
ADD CONSTRAINT FK_VENDEDORES 
FOREIGN KEY (MATRICULA) REFERENCES VENDEDORES (MATRICULA);
/*
criar a TABELA_DE_ITENS_VENDIDOS com as colunas:
Numero (PK) e (FK - Tabela de Vendas) - Varchar(5)
Codigo (PK) e (FK - Tabela de Produtos) - Varchar(10)
Quantidade - Int32
Preco - Float
*/
CREATE TABLE TABELA_DE_ITENS_VENDIDOS (
	NUMERO VARCHAR(5) NOT NULL,
	CODIGO VARCHAR(10) NOT NULL,
	QUANTIDADE INT,
	PRECO FLOAT
);

ALTER TABLE TABELA_DE_ITENS_VENDIDOS
ADD CONSTRAINT FK_TABELA_DE_VENDAS
FOREIGN KEY (NUMERO) REFERENCES TABELA_DE_VENDAS (NUMERO);

ALTER TABLE TABELA_DE_ITENS_VENDIDOS
ADD CONSTRAINT FK_PRODUTOS
FOREIGN KEY (CODIGO) REFERENCES PRODUTOS (CODIGO);

SELECT * FROM TABELA_DE_ITENS_VENDIDOS;
/*cria uma chave prim�ria composta, ou seja, duas chaves prim�rias*/
ALTER TABLE TABELA_DE_ITENS_VENDIDOS
ADD PRIMARY KEY (NUMERO, CODIGO);

--DROP TABLE TABELA_DE_ITENS_VENDIDOS;
/*inserindo os valores na tabela*/
INSERT INTO PRODUTOS (CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA) 
VALUES 
	('1040107', 'Light - 350 ml - Melancia', 'Melancia', '350 ml', 'Lata', 4.56),
	('1040108', 'Light - 350 ml - Graviola' , 'Graviola', '350 ml', 'Lata', 4.00),
	('1040109', 'Light - 350 ml - A�ai' , 'A�ai', '350 ml', 'Lata', 5.60),
	('1040110', 'Light - 350 ml - Jaca' , 'Jaca', '350 ml', 'Lata', 3.50),
	('1040111', 'Light - 350 ml - Manga' , 'Manga', '350 ml', 'Lata', 3.20), 
    ('1040112', 'Light - 350 ml - Ma�a' , 'Ma�a', '350 ml', 'Lata', 4.20);

SELECT * FROM PRODUTOS;
/*exerc�cio para inserir dados em uma tabela*/
INSERT INTO CLIENTES (
	CPF, 
	NOME, 
	ENDERECO, 
	BAIRRO, 
	CIDADE, 
	ESTADO, 
	CEP, 
	DATA_NASCIMENTO, 
	IDADE, 
	GENERO, 
	LIMITE_DE_CREDITO, 
	VOLUME_COMPRA, 
	PRIMEIRA_COMPRA
) VALUES
	('1471156710', '�rica Carvalho', 'R. Iriquitia', 'Jardins', 'S�o Paulo', 'SP', '80012212', '01/09/1990', 27, 'F', 170000, 24500, 0),
	('19290992743', 'Fernando Cavalcante', 'R. Dois de Fevereiro', '�gua Santa', 'Rio de Janeiro', 'RJ', '22000000', '12/02/2000', 18, 'M', 100000, 20000, 1),
	('2600586709', 'C�sar Teixeira', 'Rua Conde de Bonfim', 'Tijuca', 'Rio de Janeiro', 'RJ', '22020001', '12/03/2000', 18, 'M', 120000, 22000, 0);
/*se nesse�rio, depois excluir esses dados para n�o atrapalhar as pr�ximas aulas */
SELECT * FROM CLIENTES;

/*acessando outro banco de dados de um banco de dados diferente*/
SELECT * FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS;

/*passadonos dados da tabela TABELA_DE_PRODUTOS que vem de outra base de dados, para a tabela PRODUTOS, 
exclundo os itens repetidos da tabela que vem os dados para a que vai, ou seja, os que tem a mesma chave prim�ria*/
INSERT INTO PRODUTOS 
    SELECT CODIGO_DO_PRODUTO AS CODIGO, NOME_DO_PRODUTO AS DESCRITOR, 
    SABOR, TAMANHO, EMBALAGEM, PRECO_DE_LISTA AS PRECO_LISTA 
FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS 
WHERE CODIGO_DO_PRODUTO <> '1040107';

SELECT * FROM PRODUTOS;

SELECT * FROM VENDEDORES;
/*deletar algum dado espec�fico*/
--DELETE FROM VENDEDORES WHERE MATRICULA = '235';
/*deletar tudo da tabela espec�ficada*/
--DELETE FROM VENDEDORES;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Vendedores';
/*
DROP TABLE [dbo].[VENDEDORES]
CREATE TABLE [dbo].[VENDEDORES] (
    MATRICULA VARCHAR(5) NOT NULL, 
    NOME VARCHAR(100) NULL, 
    BAIRRO VARCHAR(50) NULL, 
    COMISSAO FLOAT NULL, 
    DATA_ADMISSAO DATE NULL, 
    FERIAS BIT NULL, 
    PRIMARY KEY (MATRICULA)
);
*/

SELECT * FROM VENDEDORES;

SELECT * FROM TABELA_DE_VENDAS;

SELECT * FROM CLIENTES;
--SELECT * FROM SUCOS_FRUTAS.DBO.TABELA_DE_CLIENTES
/*inserindo dados de outro banco de dados no banco de dados VENDAS SUCOS excluindo os CPFs que j� tinha na tabela CLIENTES*/
INSERT INTO CLIENTES
    SELECT CPF, NOME, ENDERECO_1 AS ENDERECO, BAIRRO AS BAIRRO, CIDADE AS CIDADE, ESTADO AS ESTADO, CEP AS CEP, 
	DATA_DE_NASCIMENTO AS DATA_NASCIMENTO, IDADE AS IDADE, GENERO AS GENERO, LIMITE_DE_CREDITO AS LIMITE_DE_CREDITO, 
	VOLUME_DE_COMPRA AS VOLUME_COMPRA, PRIMEIRA_COMPRA AS PRIMEIRA_COMPRA
FROM SUCOS_FRUTAS.DBO.TABELA_DE_CLIENTES
WHERE CPF NOT IN ('1471156710', '19290992743', '2600586709');

/*alterando os valores de uma tebela*/
SELECT * FROM PRODUTOS;
/*mudando o pre�o de um produto:
UPDATE - atualiza algo na tabela selecionada,
SET - em que coluna vai ocorrer essa altera��o, a coluna igual ao novo valor,
WHERE - onde vai ocorrer, qual linha*/
UPDATE PRODUTOS SET PRECO_LISTA = 5 WHERE CODIGO = '1040107';

/*atualizando os pre�o de todos os produtos do sabor manga em 10%*/
UPDATE PRODUTOS SET PRECO_LISTA = PRECO_LISTA * 1.10 
WHERE SABOR = 'Manga';

/*REPLACE - realiza uma consulta de como ficaria a substitui��o de antigo valor em rela��o ao novo valor,
mas ele n�o substitui o valor neste caso, s� mostra a compara��o*/
SELECT DESCRITOR, REPLACE (DESCRITOR, '350 ml', '550 ml') FROM PRODUTOS WHERE TAMANHO = '350 ml';

/*realiza uma substitui��o somente no texto selecionado 
(independente do tamanho do texto, desde que ele contenha aquele valor a ser substituido)*/
UPDATE PRODUTOS SET 
    DESCRITOR = replace(DESCRITOR, '350 ml', '550 ml'), 
    TAMANHO = '550 ml' 
WHERE TAMANHO = '350 ml';

SELECT DESCRITOR, TAMANHO, EMBALAGEM FROM PRODUTOS 
WHERE TAMANHO = '550 ml';

/*
EXERC�CIOS:
- Modifique o endere�o do cliente 19290992743 para R. Jorge Emilio 23, em Santo Amaro, S�o Paulo, SP, CEP 8833223.
- Altere o volume de compra em 20%, dos clientes do estado do Rio de Janeiro.
*/

/*consultando outros banco de dados e igualando os valores entre eles conforme a sele��o feita*/
SELECT * FROM PRODUTOS ORDER BY CODIGO;

SELECT * FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS 
ORDER BY CODIGO_DO_PRODUTO;
/*altera o pre�o da tabela TABELA_DE_PRODUTOS da db SUCOS_FRUTAS em +20%*/
UPDATE SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS SET 
PRECO_DE_LISTA = PRECO_DE_LISTA * 1.20;

/*para essa consulta, � preciso que ambas as tabelas tenha os mesmos c�digos e a mesma quantidade de linha*/
SELECT 
A.CODIGO AS CODIGO_MINHA_TABELA, A.PRECO_LISTA AS PRECO_MINHA_TABELA, 
B.CODIGO_DO_PRODUTO AS CODIGO_TABELA_APOIO, B.PRECO_DE_LISTA AS PRECO_TABELA_APOIO 
FROM PRODUTOS A 
INNER JOIN SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS B 
ON A.CODIGO = B.CODIGO_DO_PRODUTO;

/*atualiza a tabela PRODUTOS de modo a ficar igual a tabela TABELA_DE_PRODUTOS do outro banco de dados*/
UPDATE A SET A.PRECO_LISTA = B.PRECO_DE_LISTA 
FROM PRODUTOS A 
INNER JOIN SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS B 
ON A.CODIGO = B.CODIGO_DO_PRODUTO;
/*outra forma de atualizar a tabela de um db de modo a ficar igual ao outro db selecionado, mesma ideio do comando de cima*/
MERGE INTO PRODUTOS A 
USING SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS B 
ON A.CODIGO = B.CODIGO_DO_PRODUTO 
WHEN MATCHED THEN 
UPDATE SET A.PRECO_LISTA = B.PRECO_DE_LISTA;

/*consulta essas altera��es feitas, ambas as tabelas precisam ter a mesma quantidade 
de linha e colunas com os mesmo valores das chave primaria*/
SELECT 
A.CODIGO AS CODIGO_MINHA_TABELA, A.PRECO_LISTA AS PRECO_MINHA_TABELA, 
B.CODIGO_DO_PRODUTO AS CODIGO_TABELA_APOIO, B.PRECO_DE_LISTA AS PRECO_TABELA_APOIO 
FROM PRODUTOS A 
INNER JOIN SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS B 
ON A.CODIGO = B.CODIGO_DO_PRODUTO;

/*
EXERC�CIOS:
- Aumentar em 30% o volume de compra dos clientes que possuem, em seus endere�os, 
bairros onde os vendedores possuam escrit�rios.
- usando o comando MERGE agora: Podemos observar que os vendedores possuem bairros associados a eles. 
Vamos aumentar em 30% o volume de compra dos clientes que possuem, em seus endere�os, 
bairros onde os vendedores possuam escrit�rios.
*/
SELECT A.CPF FROM [dbo].[CLIENTES] A
INNER JOIN [dbo].[VENDEDORES] B
ON A.[BAIRRO] = B.[BAIRRO];

/*comando DELETE*/
/*inserirndo novos produtos*/
INSERT INTO PRODUTOS (CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA)
VALUES 
	 ('1001001','Sabor dos Alpes 700 ml - Manga','Manga','700 ml','Garrafa',7.50),
	 ('1001000','Sabor dos Alpes 700 ml - Mel�o','Mel�o','700 ml','Garrafa',7.50),
	 ('1001002','Sabor dos Alpes 700 ml - Graviola','Graviola','700 ml','Garrafa',7.50),
	 ('1001003','Sabor dos Alpes 700 ml - Tangerina','Tangerina','700 ml','Garrafa',7.50),
	 ('1001004','Sabor dos Alpes 700 ml - Abacate','Abacate','700 ml','Garrafa',7.50),
	 ('1001005','Sabor dos Alpes 700 ml - A�ai','A�ai','700 ml','Garrafa',7.50),
	 ('1001006','Sabor dos Alpes 1 Litro - Manga','Manga','1 Litro','Garrafa',7.50),
	 ('1001007','Sabor dos Alpes 1 Litro - Mel�o','Mel�o','1 Litro','Garrafa',7.50),
	 ('1001008','Sabor dos Alpes 1 Litro - Graviola','Graviola','1 Litro','Garrafa',7.50),
	 ('1001009','Sabor dos Alpes 1 Litro - Tangerina','Tangerina','1 Litro','Garrafa',7.50),
	 ('1001010','Sabor dos Alpes 1 Litro - Abacate','Abacate','1 Litro','Garrafa',7.50),
	 ('1001011','Sabor dos Alpes 1 Litro - A�ai','A�ai','1 Litro','Garrafa',7.50);

/*consultando os novos produtos inseridos*/
SELECT * from [PRODUTOS] WHERE SUBSTRING([DESCRITOR],1,15) = 'Sabor dos Alpes';

/*deletando um produto espec�fico*/
DELETE FROM PRODUTOS WHERE CODIGO = '1001000';

/*consultando produtos com certas caracter�sticas*/
SELECT * FROM [PRODUTOS] WHERE 
SUBSTRING([DESCRITOR], 1, 15) = 'Sabor dos Alpes' 
AND TAMANHO = '1 Litro';

/*deletando produtos com certas caracter�sticas*/
DELETE FROM PRODUTOS WHERE 
    SUBSTRING([DESCRITOR], 1, 15) = 'Sabor dos Alpes' 
    AND TAMANHO = '1 Litro';

/*contando a quantidade de linhas nas tabelas de produtos de cada db*/
SELECT COUNT(*) FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS; 
SELECT COUNT(*) FROM PRODUTOS;

/* realizando uma consulta atrav�s de uma subQuery, verificando os produrtos que existem uma uma tabela de um db, 
mas que n�o exetam na outra tabela do outro db (banco de dados)*/
SELECT * FROM PRODUTOS 
WHERE CODIGO NOT IN (
    SELECT CODIGO_DO_PRODUTO 
    FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS
);

/*excluindo as linhas da tabela de PRODUTOS que n�o tem na tabela TABELA_DE_PRODUTOS do outro db*/
DELETE FROM PRODUTOS 
WHERE CODIGO NOT IN (
    SELECT CODIGO_DO_PRODUTO 
    FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS
);

/*
EXERC�CIOS:
- Exclua as notas fiscais (apenas o cabe�alho) cujos clientes tenham menos que 18 anos.
SELECT A.N�MERO FROM NOTAS A
INNER JOIN [CLIENTES] B ON A.CPF = B.CPF
WHERE B.IDADE < 18
*/

/*comandos BEGIN TRANSACTION, COMMIT e ROLLBACK*/
/*ao utilizar o comando BEGIN TRANSACTION, ele 'salva' tudo que foi feito at� essse ponto*/
BEGIN TRANSACTION
/*o Comando COMMIT salva todas as mudan�as que foram feitas depois da execu��o do comando BEGIN TRANSACTION*/
COMMIT
/*o comando ROLLBACK n�o salva as altera��es feitas depois da execu��o do comando BEGIN TRANSACTION*/
ROLLBACK

/* campo especial chamado auto incremento*/
/*cria uma tabela com o auto incremento atrav�s do comando: 
[nome da coluna] INT IDENTITY([valor inicial], [de quanto em quanto � o incremento])*/
CREATE TABLE TAB_IDENTITY (
    ID INT IDENTITY(1,1) NOT NULL, 
    DESCRITOR VARCHAR (20) NULL
);
/*inserindo alguns valores na tabela criada acima*/
INSERT INTO TAB_IDENTITY (DESCRITOR) 
VALUES ('CLIENTE X');

INSERT INTO TAB_IDENTITY (DESCRITOR) 
VALUES ('CLIENTE Y');

INSERT INTO TAB_IDENTITY (DESCRITOR) 
VALUES ('CLIENTE Z');

INSERT INTO TAB_IDENTITY (DESCRITOR) 
VALUES ('CLIENTE W');

INSERT INTO TAB_IDENTITY (DESCRITOR) 
VALUES ('CLIENTE A');

SELECT * FROM TAB_IDENTITY;
/*deletando o a linha com o ID = 1*/
DELETE FROM TAB_IDENTITY WHERE ID = 1;
/*quando � incluido um novo valor na tabela, o incremento conta apartir do �ltimo n�mero que parou,
ou seja, n�o inclui o n�mero deletado*/
INSERT INTO TAB_IDENTITY (DESCRITOR) 
VALUES ('CLIENTE B');

SELECT * FROM TAB_IDENTITY;
------------------------------------
/*cria��o de campos padr�es para caso o usu�rio �o inserir dados naquele campo*/
/*para isso � utilizado o comando DEFAULT [e o que seria o padr�o]
� interessante notar que o NULL tamb�m � um padr�o adotado caso o usu�rio n�o coloque nada naquele campo*/
--cria��o da tabela para exemplo--
/*no caso, foi definido como padr�o a data de hoje e a cidade do Rio de Janeiro*/
CREATE TABLE TB_PADRAO (
    ID INT IDENTITY(1,1) NOT NULL, 
    DESCRITOR VARCHAR(20) NULL, 
    ENDERECO VARCHAR(20) NULL, 
    CIDADE VARCHAR(20) DEFAULT 'Rio de Janeiro', 
    DATA_CRIACAO DATE DEFAULT GETDATE()
);
/*inserindo alguns dados*/
INSERT INTO TB_PADRAO 
    (DESCRITOR, ENDERECO, CIDADE, DATA_CRIACAO) 
VALUES
    ('CLIENTE X', 'RUA PROJETADA A', 'S�O PAULO', '2018-04-30');

SELECT * FROM TB_PADRAO;
-- inserirndo mais uma linha de dados, mas utilizando alguns valores padr�es definidos na tabela TB_PADRAO
INSERT INTO TB_PADRAO (DESCRITOR) 
VALUES ('CLIENTE Y');

---------------------------------
/*coamando TRIGGER*/
-- criando uma nova tabela 
CREATE TABLE TAB_FATURAMENTO (
    DATA_VENDA DATE NULL, 
    TOTAL_VENDA FLOAT
);

/*fazendo uma consulta da jun��o das duas tabelas,
essa jun��o mostra uma nova tabela que cont�m as vendas totais por dia,
que resulta na tabela TAB_FATURAMENTO*/
SELECT 
    TV.DATA_VENDA, 
    SUM (TIV.QUANTIDADE * TIV.PRECO) AS TOTAL_VENDA 
FROM TABELA_DE_VENDAS TV 
INNER JOIN TABELA_DE_ITENS_VENDIDOS TIV 
ON TV.NUMERO = TIV.NUMERO 
GROUP BY TV.DATA_VENDA;

--inserindo novos dados nessas tabelas
INSERT INTO TABELA_DE_VENDAS 
VALUES (
    '0100', '2018-05-15', '1471156710', '235', 0.18
);
-- inseridno um dado na tabela TABELA_DE_ITENS_VENDIDOS, ela estava vazia
INSERT INTO TABELA_DE_ITENS_VENDIDOS 
VALUES (
    '0100', '1000889', 100, 10
);

SELECT * FROM TABELA_DE_VENDAS;
SELECT * FROM TABELA_DE_ITENS_VENDIDOS;

/*
EXERC�CIO:
O SQL abaixo calcula a idade em anos baseado na data atual:
SELECT [CPF], [IDADE], [DATA NASCIMENTO], 
    DATEDIFF(YEAR, [DATA NASCIMENTO], GETDATE()) 
FROM CLIENTES;
Levando em considera��o a situa��o posta acima: construa uma TRIGGER, 
de nome TG_CLIENTES_IDADE, que atualize as idades dos clientes, na tabela de clientes, 
toda vez que a tabela sofrer uma inclus�o, altera��o ou exclus�o.
*/

SELECT * FROM TAB_FATURAMENTO;

/*SIMPLIFICA��O TILIZANDO O COMANDO TRIGGER
este comando sempre executar� o que tiver entre BEGIN e END, sempre que houver uma atualiza��o, 
exclus�o ou inser��o de dados na tabela TABELA_DE_ITENS_VENDIDOS, assim o usu�rio n�o precisa 
ficar realizando os memso comando sempre.
No caso, esse comando est� pegando o que for atualizado nas tabelas TABELA_DE_ITENS_VENDIDOS e
TABELA_DE_VENDAS, e colocando na tabela TAB_FATURAMENTO. Assim sempre que houver atuzlai��es nessa duas tabelas,
ser� execultado o trigger*/
CREATE TRIGGER TG_ITENS_VENDIDOS 
ON [dbo].[TABELA_DE_ITENS_VENDIDOS] 
AFTER INSERT, UPDATE, DELETE 
AS 
BEGIN 
DELETE FROM TAB_FATURAMENTO;

INSERT INTO TAB_FATURAMENTO 
SELECT 
    TV.DATA_VENDA, 
    SUM (TIV.QUANTIDADE * TIV.PRECO) AS TOTAL_VENDA 
FROM TABELA_DE_VENDAS TV 
INNER JOIN TABELA_DE_ITENS_VENDIDOS TIV 
ON TV.NUMERO = TIV.NUMERO 
GROUP BY TV.DATA_VENDA;

END;

INSERT INTO TABELA_DE_VENDAS 
VALUES (
    '0104', '2018-05-16', '1471156710', '235', 0.18
);

INSERT INTO TABELA_DE_ITENS_VENDIDOS 
VALUES (
    '0104', '1000889', 100, 10
);

/*com o trigger, sempre que for inseridos valores na tabela, 
basta s� executar o conando para vizualisar a tabela TAB_FATURAMENTO*/
SELECT * FROM TAB_FATURAMENTO;

-------------------------
/*comando CHECK:
ele permite a cria��o de regras para inserir certos dados,
por exemplo na cria��o da tabela abaixo, � feita uma restri��o da idade ter que ser maior 18 anos */
CREATE TABLE TAB_CHECK (
    ID INT NOT NULL, 
    NOME VARCHAR(50) NULL, 
    IDADE INT NULL, 
    CIDADE VARCHAR(50) NULL, 
    CONSTRAINT CHK_IDADE CHECK (IDADE >= 18)
);
--esse dado pode ser inserido
INSERT INTO TAB_CHECK VALUES (
    1, 'JO�O', 19, 'RIO DE JANEIRO'
);
-- esse dado n�o pode ser inserido, pois idade < 18 anos
INSERT INTO TAB_CHECK VALUES (
    2, 'PEDRO', 16, 'RIO DE JANEIRO'
);
/*no check pode haver mais de uma condi��o ou condi��es mais complexa,
como por exemplo na tabela abaixo*/
CREATE TABLE TAB_CHECK2 (
    ID INT NOT NULL, 
    NOME VARCHAR(50) NULL, 
    IDADE INT NULL, 
    CIDADE VARCHAR(50) NULL, 
    CONSTRAINT CHK_IDADE2 CHECK (
        (IDADE >= 18 AND CIDADE = 'RIO DE JANEIRO') 
        OR 
        (IDADE >= 16 AND CIDADE = 'S�O PAULO')
    )
);
--esse dado pode ser inserido
INSERT INTO TAB_CHECK2 VALUES (
    1, 'JO�O', 19, 'RIO DE JANEIRO'
);
--esse dado pode ser inserido, pois tem menos de 18 anos na cidade de rj
INSERT INTO TAB_CHECK2 VALUES (
    2, 'PEDRO', 17, 'RIO DE JANEIRO'
);
--esse dado pode ser inserido, pois apesar de ter menos de 18 anos, ele � da cidade de sp
INSERT INTO TAB_CHECK2 VALUES (
    2, 'PEDRO', 17, 'S�O PAULO'
);
----------------------------
-- RESUMO DO CURSO-3 - manipulando dados
/*
Se voc� chegou at� aqui, parab�ns, voc� completou conosco mais um treinamento, 
dessa vez Manipula��o de Dados com Microsoft SQL Server, esse � mais um treinamento da nossa forma��o de SQL Server. 
No slide, n�s temos as cinco aulas desse treinamento: Modelagem do banco de dados, Criando a estrutura do banco de dados,
Incluindo dados nas tabelas, Alterando e excluindo dados existentes nas tabelas e Auto incremento, padr�es e triggers,
vamos fazer um pequeno resumo do que vimos nessas aulas.

Come�amos falando sobre modelagem de banco de dados. Eu comentei que iria falar tudo em uma �nica aula de uma forma 
bem superficial, porque modelagem de banco de dados � um assunto que tem muito detalhamento. Mas para n�o deixar 
voc�s muito sem conhecimento, eu comecei a explicar quais s�o os passos b�sicos para voc� transformar o seu minimundo, 
que � a sua empresa, o seu processo operacional, em um banco de dados. E o nosso primeiro passo � fazer uma 
entrevista com o usu�rio.

Baseado nessa entrevista, temos um texto em que identificamos os substantivos e os verbos, os substantivos 
ser�o as entidades e os verbos os relacionamentos. E em cima desse levantamento, constru�mos o nosso diagrama
de entidades e relacionamentos. Ele tem uma regra de como voc� vai desenhar isso, normalmente as entidades s�o
ret�ngulos e os relacionamentos s�o losangos, e voc� liga esse diagrama.

Em cima do diagrama de entidades e relacionamentos, voc� vai discutir a cardinalidade, que � a forma com que 
essas entidades realmente se relacionam. Ent�o, temos as cardinalidades de 1:1, 1:N, N:N, e em cima da 
cardinalidade voc� pode fazer uma an�lise, e dependendo da forma de normaliza��o das tabelas que voc� vai 
construir no seu banco de dados, voc� pode resumir as entidades e transformar algumas em atributos e voc� vai 
ter seu diagrama de entidades e relacionamentos j� com as cardinalidades mais simplificados, e em cima desse 
diagrama mais simplificado que voc� j� constr�i as tabelas e os relacionamentos que v�o ser as futuras chaves estrangeiras.

Lembrando que esse esquema final ainda n�o est� ligado a um banco de dados, � um modelo relacional gen�rico. 
Passamos para a segunda aula da cria��o da estrutura do banco de dados, ent�o � nesse momento que eu vou analisar 
o modelo relacional e determinar qual vai ser o tipo de cada campo, e isso vai estar baseado no levantamento feito 
pelo analista que transformou o minimundo no modelo relacional, para saber o tamanho de cada campo, se um campo 
vai ter 30, 50 caracteres, se os n�meros ser�o inteiros ou decimais, que tipo de arredondamento eu vou usar nos
meus n�meros, e dependendo dessa conclus�o, eu vou associar cada campo desse a um tipo de dado existente no SQL Server.

E assim tenho o meu modelo relacional com a cara do SQL Server, e o pr�ximo passo � criar uma base de dados. 
Vimos nesse curso como criamos essa base de dados atrav�s de comandos, ou ent�o, atrav�s de caixas de di�logo mais
amig�veis no Management Studio, para facilitar o seu trabalho.

Depois que eu tenho o meu banco de dados criado, eu vou criar as minhas tabelas. E vimos a sintaxe de cria��o da tabela, 
e vamos transportar o comando SQL de cria��o da tabela, justamente aquele levantamento final que foi feito no modelo
relacional, j� associando os tipos de campo para os tipos que existem no SQL Server.

[04:08] Vimos tamb�m que podemos criar as chaves prim�rias e as chaves estrangeiras, que s�o os relacionamentos entre as tabelas, atrav�s do comando ALTER TABLE.

[04:21] Depois passamos a trabalhar com a inclus�o de dados, eu tenho o meu banco de dados vazio, mas eu preciso colocar coisa nesse banco. Ent�o, vimos o comando INSERT, as diversas formas com que podemos executar o comando INSERT, vimos que eu posso inserir dados baseado no conte�do de uma outra tabela, que pode estar no mesmo ou em um outro banco diferente, e vimos tamb�m que atrav�s de um assistente, dentro do Management Studio, podemos ler dados de arquivos externos.

[04:55] Passamos para a pr�xima aula, cujo tema foi alterar a excluir aquilo que est� dentro do banco de dados. Ent�o, vimos basicamente o comando UPDATE, como ele funciona, vimos que podemos associar ao comando fun��es para poder fazer mudan�as em cima de determinadas regras. Vimos que podemos fazer update de dados baseado no conte�do de outras tabelas, para poder fazer uma sincroniza��o entre tabelas. E vimos tamb�m a forma de excluir dados do meu banco de dados, que tamb�m posso fazer o comando DELETE direto na tabela, ou associando ele ao conte�do de uma outra tabela.

[05:42] Tamb�m vimos uma coisa muito importante, que � a transa��o no SQL Server. E vimos que dentro de uma transa��o vamos guardando o estado do nosso banco, e depois quando executamos um comando COMMIT, realmente salvamos o conte�do desse banco dentro das tabelas, ou o ROLLBACK, que trazemos para a tabela, o estado dela inicial antes de ter iniciado a transa��o.

[06:11] Passamos a ver algumas caracter�sticas especiais do SQL Server, como por exemplo, os campos de auto incremento, que cria um campo, uma sequ�ncia de n�meros inteiros, sequenciais, na medida que vamos incluindo dados dentro da tabela. A caracter�stica importante do auto incremento, � que eu n�o preciso declarar o valor dele quando eu executo um comando de inclus�o da tabela.

[06:40] Vimos tamb�m um pouco sobre padr�es, ou seja, valores defaults que os meus campos v�o ter, e isso simplifica muito a inclus�o de dados, porque se eu omitir o valor de um determinado campo no momento em que eu estou incluindo o dado, ele sempre vai usar o default que foi definido quando eu criei a tabela.

[07:04] Falamos sobre trilhas, que basicamente s�o comandos que s�o disparados no momento em que eu fa�o uma inclus�o, ou uma altera��o, ou uma exclus�o do dado, inclusive posso rodar esse TRIGGER depois do comando de inclus�o, altera��o e exclus�o, ao mesmo tempo ou em substitui��o. Vimos um exemplo de como isso funciona e criamos uma TRIGGER, e no nosso exemplo t�nhamos uma tabela de pr�-consolida��o do faturamento, e toda vez que eu inclu�a dados nas notas fiscais, essa tabela de pr�-consolida��o era atualizada de forma autom�tica.

[07:48] Finalmente vimos a parte de CHECK, que s�o restri��es me que eu especifico determinados limites para os valores que ser�o inclu�dos dentro do campo. Finalmente, falamos um pouco sobre como na pr�tica vamos utilizar os comandos de inclus�o, update, exclus�o de dados, sempre associados � uma ferramenta de ETL, uma ferramenta de transporte de dados, ou por exemplo, junto com uma linguagem de programa��o.

[08:18] Ent�o, foi isso que vimos nesse treinamento. Eu espero muito que voc�s tenham gostado, e vamos nos ver em outros treinamentos aqui na Alura. Um abra�o e at� o pr�ximo curso.
*/
