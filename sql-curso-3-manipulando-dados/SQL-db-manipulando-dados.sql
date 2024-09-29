/*cria um novo banco de dados, é possível passar parâmetros na sua criação
pode ser criado clicando com o botão direito em	'Database', lá tem as mesma especificações/parâmetros*/
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
/*criação das chaves estrangeiras:
ALTER TABLES - alterar a tabela [nome da tabela]
ADD CONSTRAINT - adicionar uma restrição [dar um nome a essa restrição]
FOREIGN KEY - chave estrangeira [colocar entre () o campo que recebe essa chave estrangeira]
REFERENCES - a referência da chave estrangeira [vai nome da tabela e a coluna de onde vem essa chave]
*/
ALTER TABLE TABELA_DE_VENDAS 
ADD CONSTRAINT FK_CLIENTES 
FOREIGN KEY (CPF) REFERENCES CLIENTES (CPF);
/*
esse comando abaixo da erro, pois é preciso que a primary key tenha os mesmo tipoe  tamanho do foreign kay
no caso, a TABELA_DE_VENDAS tem a MATRICULA VARCHAR(11), enquanto na tabela VENDEDORES tem a MATRICULA VARCHAR(5)
*/
ALTER TABLE TABELA_DE_VENDAS 
ADD CONSTRAINT FK_VENDEDORES 
FOREIGN KEY (MATRICULA) REFERENCES VENDEDORES (MATRICULA);
/*
para alterar o tipo de uma tabela, é possível através do 
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
/*cria uma chave primária composta, ou seja, duas chaves primárias*/
ALTER TABLE TABELA_DE_ITENS_VENDIDOS
ADD PRIMARY KEY (NUMERO, CODIGO);

--DROP TABLE TABELA_DE_ITENS_VENDIDOS;
/*inserindo os valores na tabela*/
INSERT INTO PRODUTOS (CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA) 
VALUES 
	('1040107', 'Light - 350 ml - Melancia', 'Melancia', '350 ml', 'Lata', 4.56),
	('1040108', 'Light - 350 ml - Graviola' , 'Graviola', '350 ml', 'Lata', 4.00),
	('1040109', 'Light - 350 ml - Açai' , 'Açai', '350 ml', 'Lata', 5.60),
	('1040110', 'Light - 350 ml - Jaca' , 'Jaca', '350 ml', 'Lata', 3.50),
	('1040111', 'Light - 350 ml - Manga' , 'Manga', '350 ml', 'Lata', 3.20), 
    ('1040112', 'Light - 350 ml - Maça' , 'Maça', '350 ml', 'Lata', 4.20);

SELECT * FROM PRODUTOS;
/*exercício para inserir dados em uma tabela*/
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
	('1471156710', 'Érica Carvalho', 'R. Iriquitia', 'Jardins', 'São Paulo', 'SP', '80012212', '01/09/1990', 27, 'F', 170000, 24500, 0),
	('19290992743', 'Fernando Cavalcante', 'R. Dois de Fevereiro', 'Água Santa', 'Rio de Janeiro', 'RJ', '22000000', '12/02/2000', 18, 'M', 100000, 20000, 1),
	('2600586709', 'César Teixeira', 'Rua Conde de Bonfim', 'Tijuca', 'Rio de Janeiro', 'RJ', '22020001', '12/03/2000', 18, 'M', 120000, 22000, 0);
/*se nesseário, depois excluir esses dados para não atrapalhar as próximas aulas */
SELECT * FROM CLIENTES;

/*acessando outro banco de dados de um banco de dados diferente*/
SELECT * FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS;

/*passadonos dados da tabela TABELA_DE_PRODUTOS que vem de outra base de dados, para a tabela PRODUTOS, 
exclundo os itens repetidos da tabela que vem os dados para a que vai, ou seja, os que tem a mesma chave primária*/
INSERT INTO PRODUTOS 
    SELECT CODIGO_DO_PRODUTO AS CODIGO, NOME_DO_PRODUTO AS DESCRITOR, 
    SABOR, TAMANHO, EMBALAGEM, PRECO_DE_LISTA AS PRECO_LISTA 
FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS 
WHERE CODIGO_DO_PRODUTO <> '1040107';

SELECT * FROM PRODUTOS;

SELECT * FROM VENDEDORES;
/*deletar algum dado específico*/
--DELETE FROM VENDEDORES WHERE MATRICULA = '235';
/*deletar tudo da tabela específicada*/
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
/*inserindo dados de outro banco de dados no banco de dados VENDAS SUCOS excluindo os CPFs que já tinha na tabela CLIENTES*/
INSERT INTO CLIENTES
    SELECT CPF, NOME, ENDERECO_1 AS ENDERECO, BAIRRO AS BAIRRO, CIDADE AS CIDADE, ESTADO AS ESTADO, CEP AS CEP, 
	DATA_DE_NASCIMENTO AS DATA_NASCIMENTO, IDADE AS IDADE, GENERO AS GENERO, LIMITE_DE_CREDITO AS LIMITE_DE_CREDITO, 
	VOLUME_DE_COMPRA AS VOLUME_COMPRA, PRIMEIRA_COMPRA AS PRIMEIRA_COMPRA
FROM SUCOS_FRUTAS.DBO.TABELA_DE_CLIENTES
WHERE CPF NOT IN ('1471156710', '19290992743', '2600586709');

/*alterando os valores de uma tebela*/
SELECT * FROM PRODUTOS;
/*mudando o preço de um produto:
UPDATE - atualiza algo na tabela selecionada,
SET - em que coluna vai ocorrer essa alteração, a coluna igual ao novo valor,
WHERE - onde vai ocorrer, qual linha*/
UPDATE PRODUTOS SET PRECO_LISTA = 5 WHERE CODIGO = '1040107';

/*atualizando os preço de todos os produtos do sabor manga em 10%*/
UPDATE PRODUTOS SET PRECO_LISTA = PRECO_LISTA * 1.10 
WHERE SABOR = 'Manga';

/*REPLACE - realiza uma consulta de como ficaria a substituição de antigo valor em relação ao novo valor,
mas ele não substitui o valor neste caso, só mostra a comparação*/
SELECT DESCRITOR, REPLACE (DESCRITOR, '350 ml', '550 ml') FROM PRODUTOS WHERE TAMANHO = '350 ml';

/*realiza uma substituição somente no texto selecionado 
(independente do tamanho do texto, desde que ele contenha aquele valor a ser substituido)*/
UPDATE PRODUTOS SET 
    DESCRITOR = replace(DESCRITOR, '350 ml', '550 ml'), 
    TAMANHO = '550 ml' 
WHERE TAMANHO = '350 ml';

SELECT DESCRITOR, TAMANHO, EMBALAGEM FROM PRODUTOS 
WHERE TAMANHO = '550 ml';

/*
EXERCÍCIOS:
- Modifique o endereço do cliente 19290992743 para R. Jorge Emilio 23, em Santo Amaro, São Paulo, SP, CEP 8833223.
- Altere o volume de compra em 20%, dos clientes do estado do Rio de Janeiro.
*/

/*consultando outros banco de dados e igualando os valores entre eles conforme a seleção feita*/
SELECT * FROM PRODUTOS ORDER BY CODIGO;

SELECT * FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS 
ORDER BY CODIGO_DO_PRODUTO;
/*altera o preço da tabela TABELA_DE_PRODUTOS da db SUCOS_FRUTAS em +20%*/
UPDATE SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS SET 
PRECO_DE_LISTA = PRECO_DE_LISTA * 1.20;

/*para essa consulta, é preciso que ambas as tabelas tenha os mesmos códigos e a mesma quantidade de linha*/
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

/*consulta essas alterações feitas, ambas as tabelas precisam ter a mesma quantidade 
de linha e colunas com os mesmo valores das chave primaria*/
SELECT 
A.CODIGO AS CODIGO_MINHA_TABELA, A.PRECO_LISTA AS PRECO_MINHA_TABELA, 
B.CODIGO_DO_PRODUTO AS CODIGO_TABELA_APOIO, B.PRECO_DE_LISTA AS PRECO_TABELA_APOIO 
FROM PRODUTOS A 
INNER JOIN SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS B 
ON A.CODIGO = B.CODIGO_DO_PRODUTO;

/*
EXERCÍCIOS:
- Aumentar em 30% o volume de compra dos clientes que possuem, em seus endereços, 
bairros onde os vendedores possuam escritórios.
- usando o comando MERGE agora: Podemos observar que os vendedores possuem bairros associados a eles. 
Vamos aumentar em 30% o volume de compra dos clientes que possuem, em seus endereços, 
bairros onde os vendedores possuam escritórios.
*/
SELECT A.CPF FROM [dbo].[CLIENTES] A
INNER JOIN [dbo].[VENDEDORES] B
ON A.[BAIRRO] = B.[BAIRRO];

/*comando DELETE*/
/*inserirndo novos produtos*/
INSERT INTO PRODUTOS (CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA)
VALUES 
	 ('1001001','Sabor dos Alpes 700 ml - Manga','Manga','700 ml','Garrafa',7.50),
	 ('1001000','Sabor dos Alpes 700 ml - Melão','Melão','700 ml','Garrafa',7.50),
	 ('1001002','Sabor dos Alpes 700 ml - Graviola','Graviola','700 ml','Garrafa',7.50),
	 ('1001003','Sabor dos Alpes 700 ml - Tangerina','Tangerina','700 ml','Garrafa',7.50),
	 ('1001004','Sabor dos Alpes 700 ml - Abacate','Abacate','700 ml','Garrafa',7.50),
	 ('1001005','Sabor dos Alpes 700 ml - Açai','Açai','700 ml','Garrafa',7.50),
	 ('1001006','Sabor dos Alpes 1 Litro - Manga','Manga','1 Litro','Garrafa',7.50),
	 ('1001007','Sabor dos Alpes 1 Litro - Melão','Melão','1 Litro','Garrafa',7.50),
	 ('1001008','Sabor dos Alpes 1 Litro - Graviola','Graviola','1 Litro','Garrafa',7.50),
	 ('1001009','Sabor dos Alpes 1 Litro - Tangerina','Tangerina','1 Litro','Garrafa',7.50),
	 ('1001010','Sabor dos Alpes 1 Litro - Abacate','Abacate','1 Litro','Garrafa',7.50),
	 ('1001011','Sabor dos Alpes 1 Litro - Açai','Açai','1 Litro','Garrafa',7.50);

/*consultando os novos produtos inseridos*/
SELECT * from [PRODUTOS] WHERE SUBSTRING([DESCRITOR],1,15) = 'Sabor dos Alpes';

/*deletando um produto específico*/
DELETE FROM PRODUTOS WHERE CODIGO = '1001000';

/*consultando produtos com certas características*/
SELECT * FROM [PRODUTOS] WHERE 
SUBSTRING([DESCRITOR], 1, 15) = 'Sabor dos Alpes' 
AND TAMANHO = '1 Litro';

/*deletando produtos com certas características*/
DELETE FROM PRODUTOS WHERE 
    SUBSTRING([DESCRITOR], 1, 15) = 'Sabor dos Alpes' 
    AND TAMANHO = '1 Litro';

/*contando a quantidade de linhas nas tabelas de produtos de cada db*/
SELECT COUNT(*) FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS; 
SELECT COUNT(*) FROM PRODUTOS;

/* realizando uma consulta através de uma subQuery, verificando os produrtos que existem uma uma tabela de um db, 
mas que não exetam na outra tabela do outro db (banco de dados)*/
SELECT * FROM PRODUTOS 
WHERE CODIGO NOT IN (
    SELECT CODIGO_DO_PRODUTO 
    FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS
);

/*excluindo as linhas da tabela de PRODUTOS que não tem na tabela TABELA_DE_PRODUTOS do outro db*/
DELETE FROM PRODUTOS 
WHERE CODIGO NOT IN (
    SELECT CODIGO_DO_PRODUTO 
    FROM SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS
);

/*
EXERCÍCIOS:
- Exclua as notas fiscais (apenas o cabeçalho) cujos clientes tenham menos que 18 anos.
SELECT A.NÚMERO FROM NOTAS A
INNER JOIN [CLIENTES] B ON A.CPF = B.CPF
WHERE B.IDADE < 18
*/

/*comandos BEGIN TRANSACTION, COMMIT e ROLLBACK*/
/*ao utilizar o comando BEGIN TRANSACTION, ele 'salva' tudo que foi feito até essse ponto*/
BEGIN TRANSACTION
/*o Comando COMMIT salva todas as mudanças que foram feitas depois da execução do comando BEGIN TRANSACTION*/
COMMIT
/*o comando ROLLBACK não salva as alterações feitas depois da execução do comando BEGIN TRANSACTION*/
ROLLBACK

/* campo especial chamado auto incremento*/
/*cria uma tabela com o auto incremento através do comando: 
[nome da coluna] INT IDENTITY([valor inicial], [de quanto em quanto é o incremento])*/
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
/*quando é incluido um novo valor na tabela, o incremento conta apartir do último número que parou,
ou seja, não inclui o número deletado*/
INSERT INTO TAB_IDENTITY (DESCRITOR) 
VALUES ('CLIENTE B');

SELECT * FROM TAB_IDENTITY;
------------------------------------
/*criação de campos padrões para caso o usuário ão inserir dados naquele campo*/
/*para isso é utilizado o comando DEFAULT [e o que seria o padrão]
é interessante notar que o NULL também é um padrão adotado caso o usuário não coloque nada naquele campo*/
--criação da tabela para exemplo--
/*no caso, foi definido como padrão a data de hoje e a cidade do Rio de Janeiro*/
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
    ('CLIENTE X', 'RUA PROJETADA A', 'SÃO PAULO', '2018-04-30');

SELECT * FROM TB_PADRAO;
-- inserirndo mais uma linha de dados, mas utilizando alguns valores padrões definidos na tabela TB_PADRAO
INSERT INTO TB_PADRAO (DESCRITOR) 
VALUES ('CLIENTE Y');

---------------------------------
/*coamando TRIGGER*/
-- criando uma nova tabela 
CREATE TABLE TAB_FATURAMENTO (
    DATA_VENDA DATE NULL, 
    TOTAL_VENDA FLOAT
);

/*fazendo uma consulta da junção das duas tabelas,
essa junção mostra uma nova tabela que contém as vendas totais por dia,
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
EXERCÍCIO:
O SQL abaixo calcula a idade em anos baseado na data atual:
SELECT [CPF], [IDADE], [DATA NASCIMENTO], 
    DATEDIFF(YEAR, [DATA NASCIMENTO], GETDATE()) 
FROM CLIENTES;
Levando em consideração a situação posta acima: construa uma TRIGGER, 
de nome TG_CLIENTES_IDADE, que atualize as idades dos clientes, na tabela de clientes, 
toda vez que a tabela sofrer uma inclusão, alteração ou exclusão.
*/

SELECT * FROM TAB_FATURAMENTO;

/*SIMPLIFICAÇÃO TILIZANDO O COMANDO TRIGGER
este comando sempre executará o que tiver entre BEGIN e END, sempre que houver uma atualização, 
exclusão ou inserção de dados na tabela TABELA_DE_ITENS_VENDIDOS, assim o usuário não precisa 
ficar realizando os memso comando sempre.
No caso, esse comando está pegando o que for atualizado nas tabelas TABELA_DE_ITENS_VENDIDOS e
TABELA_DE_VENDAS, e colocando na tabela TAB_FATURAMENTO. Assim sempre que houver atuzlaições nessa duas tabelas,
será execultado o trigger*/
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
basta só executar o conando para vizualisar a tabela TAB_FATURAMENTO*/
SELECT * FROM TAB_FATURAMENTO;

-------------------------
/*comando CHECK:
ele permite a criação de regras para inserir certos dados,
por exemplo na criação da tabela abaixo, é feita uma restrição da idade ter que ser maior 18 anos */
CREATE TABLE TAB_CHECK (
    ID INT NOT NULL, 
    NOME VARCHAR(50) NULL, 
    IDADE INT NULL, 
    CIDADE VARCHAR(50) NULL, 
    CONSTRAINT CHK_IDADE CHECK (IDADE >= 18)
);
--esse dado pode ser inserido
INSERT INTO TAB_CHECK VALUES (
    1, 'JOÃO', 19, 'RIO DE JANEIRO'
);
-- esse dado não pode ser inserido, pois idade < 18 anos
INSERT INTO TAB_CHECK VALUES (
    2, 'PEDRO', 16, 'RIO DE JANEIRO'
);
/*no check pode haver mais de uma condição ou condições mais complexa,
como por exemplo na tabela abaixo*/
CREATE TABLE TAB_CHECK2 (
    ID INT NOT NULL, 
    NOME VARCHAR(50) NULL, 
    IDADE INT NULL, 
    CIDADE VARCHAR(50) NULL, 
    CONSTRAINT CHK_IDADE2 CHECK (
        (IDADE >= 18 AND CIDADE = 'RIO DE JANEIRO') 
        OR 
        (IDADE >= 16 AND CIDADE = 'SÃO PAULO')
    )
);
--esse dado pode ser inserido
INSERT INTO TAB_CHECK2 VALUES (
    1, 'JOÃO', 19, 'RIO DE JANEIRO'
);
--esse dado pode ser inserido, pois tem menos de 18 anos na cidade de rj
INSERT INTO TAB_CHECK2 VALUES (
    2, 'PEDRO', 17, 'RIO DE JANEIRO'
);
--esse dado pode ser inserido, pois apesar de ter menos de 18 anos, ele é da cidade de sp
INSERT INTO TAB_CHECK2 VALUES (
    2, 'PEDRO', 17, 'SÃO PAULO'
);
----------------------------
-- RESUMO DO CURSO-3 - manipulando dados
/*
Se você chegou até aqui, parabéns, você completou conosco mais um treinamento, 
dessa vez Manipulação de Dados com Microsoft SQL Server, esse é mais um treinamento da nossa formação de SQL Server. 
No slide, nós temos as cinco aulas desse treinamento: Modelagem do banco de dados, Criando a estrutura do banco de dados,
Incluindo dados nas tabelas, Alterando e excluindo dados existentes nas tabelas e Auto incremento, padrões e triggers,
vamos fazer um pequeno resumo do que vimos nessas aulas.

Começamos falando sobre modelagem de banco de dados. Eu comentei que iria falar tudo em uma única aula de uma forma 
bem superficial, porque modelagem de banco de dados é um assunto que tem muito detalhamento. Mas para não deixar 
vocês muito sem conhecimento, eu comecei a explicar quais são os passos básicos para você transformar o seu minimundo, 
que é a sua empresa, o seu processo operacional, em um banco de dados. E o nosso primeiro passo é fazer uma 
entrevista com o usuário.

Baseado nessa entrevista, temos um texto em que identificamos os substantivos e os verbos, os substantivos 
serão as entidades e os verbos os relacionamentos. E em cima desse levantamento, construímos o nosso diagrama
de entidades e relacionamentos. Ele tem uma regra de como você vai desenhar isso, normalmente as entidades são
retângulos e os relacionamentos são losangos, e você liga esse diagrama.

Em cima do diagrama de entidades e relacionamentos, você vai discutir a cardinalidade, que é a forma com que 
essas entidades realmente se relacionam. Então, temos as cardinalidades de 1:1, 1:N, N:N, e em cima da 
cardinalidade você pode fazer uma análise, e dependendo da forma de normalização das tabelas que você vai 
construir no seu banco de dados, você pode resumir as entidades e transformar algumas em atributos e você vai 
ter seu diagrama de entidades e relacionamentos já com as cardinalidades mais simplificados, e em cima desse 
diagrama mais simplificado que você já constrói as tabelas e os relacionamentos que vão ser as futuras chaves estrangeiras.

Lembrando que esse esquema final ainda não está ligado a um banco de dados, é um modelo relacional genérico. 
Passamos para a segunda aula da criação da estrutura do banco de dados, então é nesse momento que eu vou analisar 
o modelo relacional e determinar qual vai ser o tipo de cada campo, e isso vai estar baseado no levantamento feito 
pelo analista que transformou o minimundo no modelo relacional, para saber o tamanho de cada campo, se um campo 
vai ter 30, 50 caracteres, se os números serão inteiros ou decimais, que tipo de arredondamento eu vou usar nos
meus números, e dependendo dessa conclusão, eu vou associar cada campo desse a um tipo de dado existente no SQL Server.

E assim tenho o meu modelo relacional com a cara do SQL Server, e o próximo passo é criar uma base de dados. 
Vimos nesse curso como criamos essa base de dados através de comandos, ou então, através de caixas de diálogo mais
amigáveis no Management Studio, para facilitar o seu trabalho.

Depois que eu tenho o meu banco de dados criado, eu vou criar as minhas tabelas. E vimos a sintaxe de criação da tabela, 
e vamos transportar o comando SQL de criação da tabela, justamente aquele levantamento final que foi feito no modelo
relacional, já associando os tipos de campo para os tipos que existem no SQL Server.

[04:08] Vimos também que podemos criar as chaves primárias e as chaves estrangeiras, que são os relacionamentos entre as tabelas, através do comando ALTER TABLE.

[04:21] Depois passamos a trabalhar com a inclusão de dados, eu tenho o meu banco de dados vazio, mas eu preciso colocar coisa nesse banco. Então, vimos o comando INSERT, as diversas formas com que podemos executar o comando INSERT, vimos que eu posso inserir dados baseado no conteúdo de uma outra tabela, que pode estar no mesmo ou em um outro banco diferente, e vimos também que através de um assistente, dentro do Management Studio, podemos ler dados de arquivos externos.

[04:55] Passamos para a próxima aula, cujo tema foi alterar a excluir aquilo que está dentro do banco de dados. Então, vimos basicamente o comando UPDATE, como ele funciona, vimos que podemos associar ao comando funções para poder fazer mudanças em cima de determinadas regras. Vimos que podemos fazer update de dados baseado no conteúdo de outras tabelas, para poder fazer uma sincronização entre tabelas. E vimos também a forma de excluir dados do meu banco de dados, que também posso fazer o comando DELETE direto na tabela, ou associando ele ao conteúdo de uma outra tabela.

[05:42] Também vimos uma coisa muito importante, que é a transação no SQL Server. E vimos que dentro de uma transação vamos guardando o estado do nosso banco, e depois quando executamos um comando COMMIT, realmente salvamos o conteúdo desse banco dentro das tabelas, ou o ROLLBACK, que trazemos para a tabela, o estado dela inicial antes de ter iniciado a transação.

[06:11] Passamos a ver algumas características especiais do SQL Server, como por exemplo, os campos de auto incremento, que cria um campo, uma sequência de números inteiros, sequenciais, na medida que vamos incluindo dados dentro da tabela. A característica importante do auto incremento, é que eu não preciso declarar o valor dele quando eu executo um comando de inclusão da tabela.

[06:40] Vimos também um pouco sobre padrões, ou seja, valores defaults que os meus campos vão ter, e isso simplifica muito a inclusão de dados, porque se eu omitir o valor de um determinado campo no momento em que eu estou incluindo o dado, ele sempre vai usar o default que foi definido quando eu criei a tabela.

[07:04] Falamos sobre trilhas, que basicamente são comandos que são disparados no momento em que eu faço uma inclusão, ou uma alteração, ou uma exclusão do dado, inclusive posso rodar esse TRIGGER depois do comando de inclusão, alteração e exclusão, ao mesmo tempo ou em substituição. Vimos um exemplo de como isso funciona e criamos uma TRIGGER, e no nosso exemplo tínhamos uma tabela de pré-consolidação do faturamento, e toda vez que eu incluía dados nas notas fiscais, essa tabela de pré-consolidação era atualizada de forma automática.

[07:48] Finalmente vimos a parte de CHECK, que são restrições me que eu especifico determinados limites para os valores que serão incluídos dentro do campo. Finalmente, falamos um pouco sobre como na prática vamos utilizar os comandos de inclusão, update, exclusão de dados, sempre associados à uma ferramenta de ETL, uma ferramenta de transporte de dados, ou por exemplo, junto com uma linguagem de programação.

[08:18] Então, foi isso que vimos nesse treinamento. Eu espero muito que vocês tenham gostado, e vamos nos ver em outros treinamentos aqui na Alura. Um abraço e até o próximo curso.
*/
