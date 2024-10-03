/*
FUNÇÕES: 
estrutura de uma função:
CREATE FUNCTION nomeDaFunção (paremetros que ela recebe e seu tipo)
RETURNS tipo-do-retorno
AS
BEGIN
   script com o que deve ser feito 
   RETURN retorno do que deve ser exibido 
END;
para ver a função criada dentro do banco de dados, basta ir em: 
programmability (programação) → functions (funções) → scale-valued function (funções com valor escalar)
*/
--criação de uma função que retorna o valor total de um respectivo número da nota fiscal
CREATE FUNCTION FaturamentoNota (@NUMERO AS INT)
RETURNS FLOAT
AS
BEGIN
   DECLARE @FATURAMENTO FLOAT
   SELECT @FATURAMENTO = SUM(QUANTIDADE * [PREÇO])
   FROM [dbo].[ITENS NOTAS FISCAIS]
   WHERE NUMERO = @NUMERO
   RETURN @FATURAMENTO 
END;
-- chamando a função e executando ela para cada número da nota fiscal
SELECT NUMERO, dbo.FaturamentoNota(NUMERO) AS FATURAMENTO
FROM [dbo].[NOTAS FISCAIS] 

/*
fazer uma procedure que irá criar de forma aleatória uma nova nota fiscal.

Para isso, precisamos pegar:

Um cliente de forma aleatória
Produto de forma aleatória
Vendedor de forma aleatória
Quantidade e preço de forma aleatória
E inserir na tabela de notas fiscais e inserir na tabela de itens de notas fiscais.

RAND vai gerar um número aleatório tipo FLOAT entre 0 e 1.
criar uam visão para a função do sql RAND, já que não é possivel 
utilizar o RAND diretaente nos calculos da função a ser criada
*/
--é possível visualizar a visão criada em 'views'
CREATE VIEW VW_ALEATORIO AS SELECT RAND() AS VALOR_ALEATORIO

-- criando uma função que gera numeros aleatórios
CREATE FUNCTION NumeroAleatorio(@VAL_MIN INT, @VAL_MAX INT)
RETURNS INT
AS
BEGIN
  DECLARE @ALEATORIO INT
  DECLARE @VALOR_ALEATORIO FLOAT
  SELECT @VALOR_ALEATORIO = VALOR_ALEATORIO FROM VW_ALEATORIO
  SET @ALEATORIO = ROUND(((@VAL_MAX - @VAL_MIN - 1) * @VALOR_ALEATORIO + @VAL_MIN), 0)
  RETURN @ALEATORIO
END
-- chamando essa função
SELECT dbo.[NumeroAleatorio](1,10)

/*
EXERCÍCIOS:
1 - Levando isso em consideração, analise o esquema das tabelas do banco de dados SUCOS_VENDAS.
Em seguida, faça uma função UDF que retorne o faturamento total de todas as notas fiscais de um bairro.
Exemplo: Se eu seleciono como parâmetro da função o bairro jardins, o retorno da função será o total de 
faturamento de todas as notas fiscais, para todos os períodos, para este bairro.
----------------------------

2 - os comado abaixo apresenta todos os bairros da cidade do Rio de Janeiro:
SELECT BAIRRO
FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'Rio de Janeiro'
ORDER BY BAIRRO;
Vamos apresentar uma coisa nova relacionada com o SQL SERVER que é o OFFSET e FETCH NEXT.
Estas duas cláusulas permitem que eu possa listar um grupo de linhas no meio da consulta.
Por exemplo: Se eu executo a consulta abaixo:
SELECT BAIRRO
FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'Rio de Janeiro'
ORDER BY BAIRRO
OFFSET 3 ROWS
FETCH NEXT 1 ROWS ONLY;
A consulta acima lista os bairros a partir da linha 3 (OFFSET ) e apenas uma linha (FETCH NEXT).
Sabendo disto, adapte a função criada neste tópico, porém o parâmetro inicial será uma cidade e 
iremos listar todos os bairros desta cidade, um a um, dentro do loop, gravando na tabela de saída 
o nome do bairro (Em vez do número da nota e o status se é nota ou não, como mostrado no vídeo da aula).
Observação: O contador do OFFSETcomeça no zero.
*/

--faz a veificação se é ou não nota fiscal e tras o faturamento
DECLARE @LIMITE_MINIMO INT, @LIMITE_MAXIMO INT
DECLARE @TABELA_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR(200),  [FATURAMENTO] FLOAT)
DECLARE @CONTADOR_NOTAS INT

SET @LIMITE_MINIMO = 1
SET @LIMITE_MAXIMO = 100000

-- não mostra no log as mensagens de 'uma linha afetada' por exemplo
SET NOCOUNT ON
WHILE @LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
    SELECT @CONTADOR_NOTAS = COUNT(*) FROM [dbo].[NOTAS FISCAIS] WHERE NUMERO = @LIMITE_MINIMO
    IF @CONTADOR_NOTAS > 0
        BEGIN
            INSERT INTO @TABELA_NUMEROS (NUMERO, STATUS, FATURAMENTO) 
			-- é possível chamar a função criada dentro de outro script, no caso, foi chamada a [dbo].[FaturamentoNota](@LIMITE_MINIMO)
			VALUES (@LIMITE_MINIMO, 'É NOTA FISCAL', [dbo].[FaturamentoNota](@LIMITE_MINIMO))
        END
    ELSE
        BEGIN
            INSERT INTO @TABELA_NUMEROS (NUMERO, STATUS, FATURAMENTO) 
			VALUES (@LIMITE_MINIMO, 'NÃO É NOTA FISCAL', 0)
        END
    SET @LIMITE_MINIMO = @LIMITE_MINIMO + 1
END
SELECT * FROM @TABELA_NUMEROS ORDER BY NUMERO

--tras o menor valor da nota fiscal e o maior valor da nota fiscal
SELECT MIN(NUMERO), MAX(NUMERO) FROM [dbo].[NOTAS FISCAIS]
---------------------

/*
FUNÇÕES QUE RETORNAM UMA TABELA
a função criada vai está em: 
programmability (programação) → functions (funções) → table-valued function (funções com valor de tabela)
*/
CREATE FUNCTION ListaNotasCliente (@CPF AS VARCHAR(11))
--tipo do retorno é uma tabela
RETURNS TABLE
AS
-- não precisa do BEGIN e END neste caso, já que é só um único comando excutado
RETURN SELECT * FROM [NOTAS FISCAIS] WHERE CPF = @CPF
-- consulta as notas fiscais daquele CPF
SELECT * FROM [dbo].[ListaNotasCliente]('1471156710');
-- mostra a quantidade de notas fiscais daquele CPF
SELECT COUNT(*) FROM [dbo].[ListaNotasCliente]('1471156710');
-------------------------

/*
criar uma função que mostre o enedeço completo do cliente
*/
CREATE FUNCTION EnderecoCompleto
(@ENDERECO VARCHAR(100),
@BAIRRO VARCHAR(50),
@CIDADE VARCHAR(50),
@ESTADO VARCHAR(2),
@CEP VARCHAR(20))
RETURNS VARCHAR(250)
AS
--código omitido
BEGIN
    DECLARE @ENDERECO_COMPLETO VARCHAR(250)
    SET @ENDERECO_COMPLETO = @ENDERECO + '-' + 
    @BAIRRO + '-' + @CIDADE + '-' + @ESTADO + '-' + @CEP
    RETURN @ENDERECO_COMPLETO
END
-- realizando a consulta
SELECT CPF, [dbo].[Enderecocompleto]([ENDERECO 1], BAIRRO, CIDADE, ESTADO, CEP) 
AS ENDERECO_COMPLETO FROM [TABELA DE CLIENTES]

-- alterando a função, para uso utilizando o comando ALTER
ALTER FUNCTION Enderecocompleto
(@ENDERECO VARCHAR(100),
@BAIRRO VARCHAR(50),
@CIDADE VARCHAR(50),
@ESTADO VARCHAR(2),
@CEP VARCHAR(20))
RETURNS VARCHAR(250)
AS
BEGIN

    DECLARE @ENDERECO_COMPLETO VARCHAR(250)
    SET @ENDERECO_COMPLETO = @ENDERECO + ' ' + 
    @BAIRRO + ' ' + @CIDADE + ' ' + @ESTADO + ', CEP ' + @CEP
    RETURN @ENDERECO_COMPLETO
END
-- realizando a consulta da função alterada
SELECT CPF, [dbo].[Enderecocompleto]([ENDERECO 1], BAIRRO, CIDADE, ESTADO, CEP) 
AS ENDERECO_COMPLETO FROM [TABELA DE CLIENTES]

/* 
para excluir uma função, pode ser clicando nela (na arvore ao lado) em cima da função com 
botão direito em 'excluir', ou pode usar o comando DROP como no exemplo abaixo:

--o if verifica se a função já foi excluida ou não
IF OBJECT_ID('Enderecocompleto3', 'FN') IS NOT NULL
DROP FUNCTION [dbo].[Enderecoscompleto3]
*/
----------------------------

/*
criação de STORED PROCEDURE
Diferentemente da função, não precisamos de um RETURN, pois a Procedure não precisa retornar nada
a procedure pode ser visualizada em:
programmability (programação) → Stored Procedure (procedimento armazenado)

para excluir ou alterar um procedure, é igual ao que se faz com funções
através do comando DROP ou cliando na procedure na arvore de e excluindo ela
paar alterar  só usar o ALTER
*/
-- criando uma procedure que atualiza a idade de todos os clientes na [TABELA DE CLIENTES]
CREATE PROCEDURE CalculaIdade
AS
BEGIN
 UPDATE [TABELA DE CLIENTES] SET IDADE = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
END

-- inserirndo um novo cliente no db com a idade desatualizada
INSERT INTO [TABELA DE CLIENTES]
(CPF, NOME, [ENDERECO 1], BAIRRO, CIDADE, ESTADO, CEP, [DATA DE NASCIMENTO], IDADE, SEXO, [LIMITE DE CREDITO], [VOLUME DE COMPRA], [PRIMEIRA COMPRA])
VALUES
('123123123', 'JOAO MACHADO', 'RUA PROJETADA A', 'MADUREIRA', 'Rio de Janeiro', 'RJ', '20000', '2000-01-01', 10, 'M', 12000, 12000, 1)

-- executando a Stored Procedure, basta usar o EXEC e no nome da procedure
EXEC [dbo].[CalculaIdade]

SELECT * FROM [TABELA DE CLIENTES]
--------------------------------

/*FORMAS DE CHAMAR UMA PROCEDURE*/
-- criando uma procedure, e  declarando as variáveis e as inicializando já com determinados valores
CREATE PROCEDURE BuscaNotasCliente
@CPF AS VARCHAR(12) = '19290992743',
@DATA_INICIAL AS DATETIME = '20160101',
@DATA_FINAL AS DATETIME = '20161231'
AS
BEGIN
   SELECT * FROM [NOTAS FISCAIS] WHERE CPF = @CPF
   AND DATA >= @DATA_INICIAL AND DATA <= @DATA_FINAL
END;

-- chamando sem passar valores para as variáveis, ela trará o valores padrões DEFAULT
EXEC BuscaNotasCliente

-- pode passar os parâmetros diretamente (os parametros não passados serão os DEFAULT declarados na criação da procedure)
EXEC BuscaNotasCliente '19290992743', '20160501'

-- passando os parâmetros chamando as variáveis criadas na procedure, neste caso, pode inverter as ordens da vairáveis
EXEC BuscaNotasCliente @CPF='19290992743', @DATA_INICIAL='20160501', @DATA_FINAL='20160615'

-- mas neste caso não é possível passar valores fora da ordem declarada na procedure
EXEC BuscaNotasCliente '19290992743', '20160615', '20160501'

-- se quiser utilizar os valores já delcarado nas procedure, só usar o DEFAULT, as duas formas abaixo são a mesma coisa
EXEC BuscaNotasCliente '19290992743', DEFAULT, '20160615'
EXEC BuscaNotasCliente @CPF='19290992743', @DATA_FINAL='20160615'
-----------------

/*
Valores de referêcnia em uma stored procedure:

- Este é um exemplo em que passamos as duas primeiras variáveis (CPF e Ano) para a Stored Procedure 
enquanto valor para, em seguida, passar as variáveis @NUM_NOTAS e @FATURAMENTO enquanto referência;

- Esse valores de referência tem que ter em sua declaração o OUTPUT acomanhando eles;

- O valor é copiado para uma variável local dentro da stored procedure e as operações realizadas 
na variável não afetam o valor original. Já passar por referência significa que a Stored Procedure 
acessa diretamente o valor original do parâmetro. Isso ocorre porque o endereço de memória do parâmetro 
é passado para a Stored Procedure, permitindo que as operações realizadas dentro dela afetem diretamente
o valor original.
*/
--CREATE PROCEDURE retornaValoresFaturamentoQuantidade
ALTER PROCEDURE retornaValoresFaturamentoQuantidade
@CPF AS VARCHAR(12), @ANO AS INT, @NUM_NOTAS AS INT OUTPUT, @FATURAMENTO AS FLOAT OUTPUT
AS
BEGIN
	SELECT @NUM_NOTAS = COUNT(*) FROM [NOTAS FISCAIS]
	WHERE CPF = @CPF AND YEAR([DATA]) = @ANO

	SELECT @FATURAMENTO = SUM(INF.QUANTIDADE * INF.[PREÇO])
	FROM [ITENS NOTAS FISCAIS] INF
	INNER JOIN [NOTAS FISCAIS] NF
	ON INF.NUMERO = NF.NUMERO
	WHERE NF.CPF = @CPF AND YEAR(NF.[DATA]) = @ANO
END

DECLARE @NUM_NOTAS INT
DECLARE @FATURAMENTO FLOAT
-- declarar sem inicializar com um valor ou inicializar com 0 (zero) é a mesma coisa
SET @NUM_NOTAS = 0
SET @FATURAMENTO = 0

--valores antes de passar na procedure
SELECT @NUM_NOTAS, @FATURAMENTO

--valores de referência, inicializados como 0 e podem mudar dentro da procedure (tem que receber o OUTPUT nessa variáveis de referência)
EXEC retornaValoresFaturamentoQuantidade @CPF='19290992743', 
@ANO=2017, @NUM_NOTAS=@NUM_NOTAS OUTPUT, @FATURAMENTO=@FATURAMENTO OUTPUT

-- valores depois de passar na procedure
SELECT @NUM_NOTAS, @FATURAMENTO
--------------------------------
--excluindo uma procedure 
--DROP PROCEDURE dbo[nome da procedure]

/*
OBSERVAÇÕES SOBRE PROCEDURE

Procedures de sistema são um conjunto de rotinas predefinidas e fornecidas pelo Microsoft SQL Server para realizar 
operações específicas do sistema. Essas rotinas são armazenadas no banco de dados mestre do SQL Server e são 
executadas em um contexto de sistema, o que significa que elas têm acesso a informações do sistema que não estão 
disponíveis para os usuários comuns.

As procedures de sistema do SQL Server são usadas para várias finalidades, como gerenciamento de segurança, 
gerenciamento de bancos de dados, gerenciamento de servidores e gerenciamento de objetos de banco de dados. 
Essas procedures são essenciais para a administração de um sistema de banco de dados e podem ser acessadas 
por administradores do sistema e desenvolvedores com privilégios elevados.

Algumas das procedures de sistema mais comuns incluem:
- sp_helpdb: Essa procedure exibe informações sobre o banco de dados atual, como nome, proprietário, data de 
criação e status. 
- sp_who: Essa procedure exibe informações sobre as conexões ativas no servidor, incluindo o ID da sessão, 
nome de login e informações sobre a consulta em execução. 
- sp_configure: Essa procedure é 
usada para exibir ou alterar as configurações do servidor, como o nível de isolamento de transação e as 
opções de segurança. 
- sp_addlogin: Essa procedure é usada para criar novas contas de login no servidor. 
- sp_adduser: Essa procedure é usada para adicionar usuários a bancos de dados específicos.

Essas procedures de sistema são executadas usando a sintaxe EXECUTE (ou simplesmente EXEC) seguida pelo 
nome da procedure e quaisquer parâmetros necessários. É importante observar que algumas procedures de 
sistema requerem privilégios elevados para serem executadas e podem causar danos ao sistema se não forem
usadas corretamente.

Os procedures de sistema são uma ferramenta poderosa para administradores de banco de dados, pois 
permitem que eles realizem tarefas de gerenciamento de sistema de maneira eficiente e segura. 
No entanto, é importante lembrar que esses procedures podem ter impacto significativo no desempenho 
do servidor se forem usados de forma inadequada ou excessiva. Portanto, é importante entender 
completamente os procedures de sistema antes de usá-los e sempre tomar precauções adequadas ao executá-los.
*/
------------------------------
/*
EXERCÍCIO

Na base de dados SUCOS_VENDAS temos, na tabela de produtos, o campo sabor.
Obtemos a lista de sabores através da consulta abaixo:
SELECT DISTINCT SABOR FROM [TABELA DE PRODUTOS]
Houve, por parte da empresa, uma reestruturação dividindo a organização de compras 
de matérias primas, em dois departamentos: FRUTAS CÍTRICAS e FRUTAS NÃO CÍTRICAS.

Deste modo, ficou assim a distribuição:
SABOR	DEPARTAMENTO
Açaí	FRUTAS NÃO CÍTRICAS
Cereja	FRUTAS NÃO CÍTRICAS
Cereja/Maça	FRUTAS NÃO CÍTRICAS
Laranja	FRUTAS CÍTRICAS
Lima/Limão	FRUTAS CÍTRICAS
Maça	FRUTAS NÃO CÍTRICAS
Manga	FRUTAS NÃO CÍTRICAS
Maracujá	FRUTAS NÃO CÍTRICAS
Melancia	FRUTAS NÃO CÍTRICAS
Morango	FRUTAS CÍTRICAS
Morango/Limão	FRUTAS CÍTRICAS
Uva	FRUTAS CÍTRICAS

Mas a pessoa responsável pelo banco de dados da empresa não pode, neste momento, 
criar uma nova tabela no banco de dados e associar esta nova classificação ao 
sistema ERP porque isso acarretaria numa mudança muito drástica na estrutura de TI.

Mas, por outro lado, a presidência quer um relatório com dados de vendas, por datas,
olhando pela perspectiva destes novos departamentos.

E de tal maneira que seja simples executar este relatório sempre que necessário, 
passando como parâmetros a data inicial e final para determinar o período analisado.

Portanto, tente você mesmo usar SP (Stored Procedure) para isso e conseguir realizar essa demanda.
*/
-------------------------------------

/*CRIAÇÃO DE UM CURSOR*/
DECLARE @NOME VARCHAR(200)
-- o trecho de seleção "SELECT TOP 4 NOME FROM [TABELA DE CLIENTES]" será carregado para dentro de CURSOR1 e ficará em memória.
DECLARE CURSOR1 CURSOR FOR SELECT TOP 4 NOME FROM [TABELA DE CLIENTES]
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @NOME
-- o @@FETCH_STATUS é um status que ao varrer toda a tabela, o status muda para diferente de 0, e ai o comando é encerrado
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @NOME
	-- o FETCH faz essa varredura na lista armazenada dentro do CURSOR
    FETCH NEXT FROM CURSOR1 INTO @NOME
END
/*
EXERCÍCIO:

Um cursor no SQL Server é um objeto que permite que um conjunto de resultados seja processado linha por linha. 
Basicamente, um cursor permite que você defina uma consulta que retorna várias linhas e, em seguida, percorra
essas linhas para realizar uma ou mais operações com cada uma delas.

Pensando nisso, escreva um programa em T-SQL que use um cursor para percorrer todas as linhas de uma tabela 
e imprima o nome dos funcionários.

O nome da tabela é funcionarios e os campos desta tabela são nome e salario.

A seguinte query:
SELECT nome, salario
    FROM funcionarios
Retorna o nome dos funcionários apenas.
*/

/*cursor com mais de uma variável*/
DECLARE @NOME VARCHAR(200)
DECLARE @ENDERECO VARCHAR(MAX)

-- o NOME e o ENDCOMPLETO são armazenados dentro do cursor com uma uma tabela de duas colunas
DECLARE CURSOR1 CURSOR FOR
SELECT NOME, ([ENDERECO 1], + ' ' + BAIRRO + ' ' + CIDADE + ' ' + ESTADO + ', CEP: ' + CEP) ENDCOMPLETO
FROM [TABELA DE CLIENTES]
-- para a modufucação dessas informações dentro do cursor, tem que usar o OPEN [nome do cursor]
OPEN CURSOR1
--em seguida usar o FETCH NEXT FROM [nome do cursor] INTO [nome das vairaveis declaradas em que vão ser armazenado os dados a ser printado]
FETCH NEXT FROM CURSOR1 INTO @NOME, @ENDERECO
--enquanto o status de @@FETCH_STATUS for igual a zero, ele vai percorrendo as linhas da tabela
WHILE @@FETCH_STATUS = 0
BEGIN
	--print de cada linha, até percurrer toda a tabela armazenada no cursor selecionado
    PRINT @NOME + ', Endereço: ' + @ENDERECO
    FETCH NEXT FROM CURSOR1 INTO @NOME, @ENDERECO
END
--é recomendável sempre fechar o cursor inicializado e fazer um deallocate do mesmo
CLOSE CURSOR1
DEALLOCATE CURSOR1

/*
EXERCÍCIO

Temos uma tabela chamada vendas cujos campos são data_vendae valor_venda.
O comando de seleção de todas as linhas desta tabela podem ser visualizados abaixo:

 SELECT data_venda, valor_venda
    FROM vendas

Declarei e inicializei, antes, as seguintes variáveis:
DECLARE @janeiro MONEY, @fevereiro MONEY, @marco MONEY, @abril MONEY, @maio MONEY, @junho MONEY,
        @julho MONEY, @agosto MONEY, @setembro MONEY, @outubro MONEY, @novembro MONEY, @dezembro MONEY

SET @janeiro = 0
SET @fevereiro = 0
SET @marco = 0
SET @abril = 0
SET @maio = 0
SET @junho = 0
SET @julho = 0
SET @agosto = 0
SET @setembro = 0
SET @outubro = 0
SET @novembro = 0
SET @dezembro = 0

Seu objetivo é o de criar um Cursor que vai carregar os dados da tabela e, ao percorrer linha a linha, 
verificar o mês correspondente à data e incrementar o valor na variável correspondente ao mês.
*/

/*
obtendo um cliente aleatório baseado na função de número aleatório.
*/
--declarando as variáveis
DECLARE @CLIENTE_ALEATORIO VARCHAR(12)
DECLARE @VAL_INICIAL INT
DECLARE @VAL_FINAL INT
DECLARE @ALEATORIO INT
DECLARE @CONTADOR INT

--atribuindo valores a vairáveis
SET @CONTADOR = 1 
SET @VAL_INICIAL = 1
SELECT @VAL_FINAL = COUNT(*) FROM [TABELA DE CLIENTES]
SET @ALEATORIO = dbo.[NumeroAleatorio](@VAL_INICIAL,@VAL_FINAL)

-- declarando o cursor, armazenando uma tabela com uma coluna de cpf de clientes
DECLARE CURSOR1 CURSOR FOR SELECT CPF FROM [TABELA DE CLIENTES]

-- abrindo a tabela armazenada no cursor
OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @CLIENTE_ALEATORIO
-- a lógica mostra o último cliente selecionado antes de entrar no while, obedecendo a condição do while
WHILE @CONTADOR < @ALEATORIO
BEGIN
    FETCH NEXT FROM CURSOR1 INTO @CLIENTE_ALEATORIO
    SET @CONTADOR = @CONTADOR + 1
END
CLOSE CURSOR1
DEALLOCATE CURSOR1

SELECT @CLIENTE_ALEATORIO, @ALEATORIO
SELECT * FROM [TABELA DE CLIENTES]

/*
EXERCÍCIO
No vídeo anterior, criamos um processo para obter o código do cliente de forma aleatória.
Sendo assim, crie um programa T-SQL que possa obter um Vendedor de forma aleatória.
*/

/*
RESUMO DO CURSO

No decorrer do curso, vimos o conceito de função e aprendemos a criar uma função UDF. Lembre-se que é importante respeitar 
a estrutura da função, declarando seu nome, parâmetros de entrada, tipo de saída e o código interno que deve especificar 
o valor da variável de retorno.

Vimos como usar a função dentro de um loop e em um comando de SELECT envolvendo JOIN, além de abordar a forma para alterar 
e excluir uma função.

Assim como as funções, possuímos procedures prontas, que normalmente mostram a estrutura interna dos bancos de dados do 
SQL Server. Mas aprendemos a desenhar nossas próprias procedures que possuem uma estrutura de declaração partindo do 
comando CREATE PROCEDURE, em que declaramos seu nome, especificamos os parâmetros de entrada e, entre BEGIN e END, 
seu código em comandos TSQL.

A respeito dos parâmetros definidos nas procedures, vimos que podemos passá-los por valor ou referência. Quando declaramos 
por valor, a mudança desse mesmo valor dentro da procedure não será refletida no código do programa que chama a própria 
procedure. Já ao passarmos como referência, incluindo a cláusula output após a declaração do parâmetro, toda a mudança 
da variável dentro da procedure é refletida fora dela.

Abordamos, ainda, como passar uma tabela para uma procedure, além de alterar ou excluir uma procedure.

Por fim, entendemos o conceito de CURSOR, uma estrutura de memória que armazena uma consulta SQL. Através dele, podemos 
fazer operações de manipulações de dados linha a linha.

Quando percorremos os dados do CURSOR, vemos o valor que está na linha e podemos manipulá-la. Além disso, é possível 
trabalhar com linhas que retornam uma ou mais colunas.
*/
