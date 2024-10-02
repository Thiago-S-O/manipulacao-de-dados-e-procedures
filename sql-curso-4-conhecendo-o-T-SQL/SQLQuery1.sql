/*declarando vari�veis com o T-SQL
a declara��o de uma vari�vel � feita atrav�s do comando DECLARE @[nome da vari�vel] [tipo e tamanho dela]
*/
DECLARE @MATRICULA VARCHAR(5);
DECLARE @NOME VARCHAR(100);
DECLARE @PERCENTUAL FLOAT;
DECLARE @DATA DATE;
DECLARE @FERIAS BIT;
DECLARE @BAIRRO VARCHAR(50);

--outra forma de declarar v�rias vari�veis de uma vez s�
--DECLARE @MATRICULA VARCHAR(5), @NOME VARCHAR(100),@PERCENTUAL FLOAT, @DATA DATE, @FERIAS BIT, @BAIRRO VARCHAR(50);

/*Atribuindo valores as vari�veis declaradas*/
SET @MATRICULA = '00240';
SET @NOME = 'Cl�udia Rodrigues';
SET @PERCENTUAL = 0.10;
SET @DATA = '2012-03-12';
SET @FERIAS = 1;
SET @BAIRRO = 'Jardins';

/*Mostrando a execu��o do comando na tela de log/mensagens com o comando PRINT*/
PRINT @MATRICULA;
PRINT @NOME;
PRINT @PERCENTUAL;
PRINT @DATA;
PRINT @FERIAS;
PRINT @BAIRRO;

SELECT * FROM [TABELA DE VENDEDORES];

INSERT INTO [TABELA DE VENDEDORES]
(MATRICULA, NOME, [PERCENTUAL COMISS�O], [DATA ADMISS�O], [DE FERIAS], BAIRRO)
VALUES
(@MATRICULA, @NOME, @PERCENTUAL, @DATA, @FERIAS, @BAIRRO)

PRINT 'UM VENDEDOR INCLUIDO.'

SELECT * FROM [TABELA DE VENDEDORES];

/*
--EXERC�CIO: declarar as vari�veis
--Nome: Cliente - Tipo: Caracteres com 10 posi��es.
--Nome: Idade - Tipo: Inteiro.
--Nome: DataNascimento - Tipo: Data.
--Nome: Custo - Tipo: N�mero com casas decimais.

--EXERC�CIO: atribuir valores as vair�veis e chama-las com o comando PRINT
--Nome: Cliente - Tipo: Caracteres com 10 posi��es - Valor: Jo�o
--Nome: Idade - Tipo: Inteiro - Valor: 10
--Nome: DataNascimento - Tipo: Data - Valor: 10/01/2007
--Nome: Custo - Tipo: N�mero com casas decimais - Valor: 10,23

--precisa executar todos os comando de uma vez s�, ou seja, em uma �nica sele��o
*/
DECLARE @CLIENTE VARCHAR(10), @IDADE INT, @DATA_DE_NASCIMENTO DATE, @CUSTO FLOAT;

SET @CLIENTE = 'Jo�o';
SET @IDADE = 10;
SET @DATA_DE_NASCIMENTO = '2007-01-10';
SET @CUSTO = 10.23;

PRINT @CLIENTE;
PRINT @IDADE;
PRINT @DATA_DE_NASCIMENTO;
PRINT @CUSTO;
-----------------
/*
incluindo valores atribuidas as vair�veis dentro da tabela com os campos correspondentes
ao inves de colocar os valores, � chamada a vari�vel no campo da coluna da tabela em quest�o
� necess�rio selecionar e executar todos os comando de uma vez para declara, atribuir valores, chamar e inserir na tabela
*/
SELECT * FROM [TABELA DE VENDEDORES];

INSERT INTO [TABELA DE VENDEDORES]
(MATRICULA, NOME, [PERCENTUAL COMISS�O], [DATA ADMISS�O], [DE FERIAS], BAIRRO)
VALUES
(@MATRICULA, @NOME, @PERCENTUAL, @DATA, @FERIAS, @BAIRRO)

PRINT 'UM VENDEDOR INCLUIDO.'

SELECT * FROM [TABELA DE VENDEDORES];
-----------------------------------
/*atribuindo valores de uma tabela a variaveis declaradas atrav�s de uam correspond�ncia de 
uma coluna (de prefer�ncia uma que tenha uma primary key) como no exemplo abaixo
*/
DECLARE @CPF VARCHAR(50);
DECLARE @NOMEs VARCHAR(100);
DECLARE @DATA_NASCIMENTO DATE; 
DECLARE @IDADEs INT;

SET @CPF = '19290992743';

SELECT @NOMEs = NOME, @DATA_NASCIMENTO = [DATA DE NASCIMENTO], @IDADEs = IDADE FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;

PRINT @NOMEs;
PRINT @DATA_NASCIMENTO;
PRINT @IDADEs;
----------------------------
/*
comandos CHARINDEX([tipo de caractere dentro da string], [vari�vel/coluna]) e o 
SUBSTRING(NOME, posi��o_inicial, posi��o_final)
CHARINDEX - procura um determinado caractere, ou conjunto de caracteres, dentro do caractere maior e retorna sua posi��o.
*/
SELECT NOME FROM [TABELA DE CLIENTES];

SELECT NOME, CHARINDEX(' ', NOME), SUBSTRING(NOME, 1, CHARINDEX(' ', NOME)) FROM [TABELA DE CLIENTES];
-- pode concatenar dentro do PRINT
PRINT 'O primeiro nome do cliente ' + @NOME + ', cujo CPF � ' + @CPF + ', corresponde a ' + SUBSTRING(@NOME, 1, CHARINDEX(' ', @NOME) - 1);

--DECLARE @CPF VARCHAR(50);
--DECLARE @NOME VARCHAR(100);
--DECLARE @DATA_NASCIMENTO DATE; 
--DECLARE @IDADE INT;
DECLARE @SAIDA VARCHAR(500);

SET @CPF = '1471156710';

SELECT @NOME = NOME, @DATA_NASCIMENTO = [DATA DE NASCIMENTO], @IDADE = IDADE FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;

SET @SAIDA = 'O primeiro nome do cliente ' + @NOME + ', cujo CPF � ' + @CPF + ', corresponde a ' + SUBSTRING(@NOME, 1, CHARINDEX(' ', @NOME) - 1);

PRINT @SAIDA;
PRINT @DATA_NASCIMENTO;
PRINT @IDADE;
-----------------------------

/*Controle de fluxo - comando IF e testando ele*/
--exclui a tabela TABELA_TESTE
DROP TABLE TABELA_TESTE;
--cria a tabela TABELA_TESTE
CREATE TABLE TABELA_TESTE (ID VARCHAR(10));
/*
utilizando o IF, ele faz a verifica��o se a tabela existe ou n�o antes de executar o comando de exclus�o dela
sempre que chamr o IF, deve chamar tamb�m o 
OBJECT_ID('par�metro [tabelas, vair�veis, colunas, etc...]', '�ndice [no caso de n�o haver �ndice, usar o U]')
*/
IF OBJECT_ID('TABELA_TESTE', 'U') IS NOT NULL DROP TABLE TABELA_TESTE;
CREATE TABLE TABELA_TESTE (ID VARCHAR(10));
--verifica se existe ou n�o a TABELA_TESTE antes de excluir ou criar-la
IF OBJECT_ID('TABELA_TESTE', 'U') IS NOT NULL DROP TABLE TABELA_TESTE;
IF OBJECT_ID('TABELA_TESTE', 'U') IS NULL CREATE TABLE TABELA_TESTE (ID VARCHAR(10));

-- Exerc�co e testes
DECLARE @IDADE_ALUNO INT;
DECLARE @FORMADO_INGLES BIT;
DECLARE @FORMADO_ALEMAO BIT;
--pra fazer os teste, pode mudar os valores das vari�veis
SET @IDADE_ALUNO = 17;
SET @FORMADO_INGLES = 1;
SET @FORMADO_ALEMAO = 0;
--verifica se algumas das condi��es ou combina��o delas � veirdadeira
IF ((@IDADE_ALUNO >= 18 OR @FORMADO_INGLES = 1) OR (@IDADE_ALUNO < 18 AND @FORMADO_ALEMAO = 1))
  PRINT 'EXPRESSAO VERDADEIRA';
ELSE
  PRINT 'EXPRESSAO FALSA';
--------------
--pega o dia de hoje
SELECT GETDATE();
--pega o nome do dia da semana de hoje, ex.: ter�a-feira
SELECT DATENAME (WEEKDAY, GETDATE());
--pega o dia daqui a 5 dias da data de hoje
SELECT DATEADD(DAY, 5, GETDATE());
--pega o nome do dia da semana daqui 5 dias
SELECT DATENAME (WEEKDAY, DATEADD(DAY, 5, GETDATE()));

--declara�a� das vari�veis
DECLARE @DIA_SEMANA VARCHAR(20);
DECLARE @NUMERO_DIAS INT;
--aderir valores a essas veir�veis
SET @NUMERO_DIAS = 15;
SET @DIA_SEMANA = DATENAME (WEEKDAY, DATEADD(DAY, @NUMERO_DIAS, GETDATE()));
--print do dia da semana daqui a x dias, conforme o valor colocado na vari�vel @NUMERO_DIAS
PRINT @DIA_SEMANA;
--verificar se o dia da semana � um fim de semana ou dia de semana
IF @DIA_SEMANA = 'Domingo ' OR @DIA_SEMANA = 'S�bado'
    PRINT 'Este dia � fim de semana';
ELSE
    PRINT 'Este dia � dia de semana';
----------------
/*Duas formas de fazer uma declara��o*/
DECLARE @LIMITE_MAXIMO FLOAT;
DECLARE @LIMITE_ATUAL FLOAT;
DECLARE @BAIRRO VARCHAR(20);
-- uma � atrbuindo os valores as vaei�veis
SET @LIMITE_MAXIMO = 50000;
SET @BAIRRO = '�gua Santa';
SELECT @LIMITE_ATUAL = SUM([LIMITE DE CREDITO]) FROM [TABELA DE CLIENTES] WHERE BAIRRO = @BAIRRO;
IF @LIMITE_MAXIMO <= @LIMITE_ATUAL
    PRINT 'VALOR ESTOUROU';
ELSE
    PRINT 'VALOR N�O ESTOUROU';

--outra � jogando a condi�a� diretamente no if
DECLARE @LIMITE_MAXIMO FLOAT;
DECLARE @BAIRRO VARCHAR(20);

SET @LIMITE_MAXIMO = 50000;
SET @BAIRRO = '�gua Santa';
IF @LIMITE_MAXIMO <= (SELECT SUM([LIMITE DE CREDITO]) FROM [TABELA DE CLIENTES] WHERE BAIRRO = @BAIRRO)
    PRINT 'VALOR ESTOUROU';
ELSE
    PRINT 'VALOR N�O ESTOUROU';
---------------------------
/*
EXERC�CIO: atualizar a data do cliente na tabela de clientes

DECLARE @CPF VARCHAR(15);
DECLARE @DATA_NASCIMENTO DATE;
DECLARE @IDADE INT;

SET @CPF = '1471156710';
--atribuindo a vari�vel o valor da tabela
SELECT @DATA_NASCIMENTO = [DATA DE NASCIMENTO] FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;
SELECT @IDADE = IDADE FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;

--verifica se a idade do cliente est� atualizada, 
--fazendo a subtra��o da data atual com a data de nascimento e retornando um inteiro
IF @IDADE = DATEDIFF(YEAR, @DATA_NASCIMENTO, GETDATE())
	BEGIN
	PRINT 'N�o houve atualiza��o no DB'
	END
ELSE
	BEGIN
	--atribuindo o valor atualizado apartir da data de hoje da idade do cliente
	SET @IDADE = DATEDIFF(YEAR, @DATA_NASCIMENTO, GETDATE());
	--atualiza a tabela com a idade atual do cliente
	UPDATE [TABELA DE CLIENTES] SET IDADE = @IDADE WHERE CPF = @CPF;
	PRINT 'Data atualizada'
	END

SELECT * FROM [TABELA DE CLIENTES] WHERE CPF = '1471156710';
*/
---------------------------

/*Controle de fluxo - comando WHILE: funciona da mesma forma que nas linguagens de programa��o*/
DECLARE @LIMITE_MINIMO INT;
DECLARE @LIMITE_MAXIMO INT;

SET @LIMITE_MINIMO = 3;
SET @LIMITE_MAXIMO = 30;

PRINT 'ENTREI NO LOOPING';
WHILE @LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
    PRINT @LIMITE_MINIMO;
    SET @LIMITE_MINIMO = @LIMITE_MINIMO + 1;
END;
PRINT 'SAI DO LOOPING';

/*
EXERC�CIO
Sabendo que a fun��o abaixo soma um dia a uma data:
SELECT DATEADD(DAY, 1, @DATA)

Como podemos fazer um script que, a partir do dia 01/01/2017, conte o n�mero de notas fiscais at� o dia 10/01/2017 e, 
al�m disso, imprima a data e o n�mero de notas fiscais?

Dicas:

Declare vari�veis do tipo DATE: DATAINICIAL e DATAFINAL;
Fa�a um loop testando se a data inicial � menor que a data final;
Imprima a data e o n�mero de notas na sa�da do Management Studio. N�o esque�a de converter as vari�veis para VARCHAR;
Acrescente um dia � data.
*/

--utiliza��o do BREAK 
DECLARE @LIMITE_MINIMO INT;
DECLARE @LIMITE_MAXIMO INT;
DECLARE @NUM_LINHAS_MAX INT;
DECLARE @NUM_LINHAS_ESCRITAS INT;

SET @LIMITE_MINIMO = 3;
SET @LIMITE_MAXIMO = 30;
SET @NUM_LINHAS_MAX = 10;
SET @NUM_LINHAS_ESCRITAS = 0;

PRINT 'ENTREI NO LOOPING';
WHILE @LIMITE_MINIMO <= @LIMITE_MAXIMO
BEGIN
    PRINT @LIMITE_MINIMO;
        SET @NUM_LINHAS_ESCRITAS = @NUM_LINHAS_ESCRITAS +1;
        IF @NUM_LINHAS_ESCRITAS = @NUM_LINHAS_MAX
        BEGIN
            PRINT 'SAI DO LOOPING POR CAUSA DO BREAK';
            BREAK;
        END;
    SET @LIMITE_MINIMO = @LIMITE_MINIMO + 1;
END;
PRINT 'SAI DO LOOPING';
-------------------
/*
exerc�cio: De forma bem resumida, a sequ�ncia de FIBONACCI � uma sequ�ncia que come�a com o 
n�mero 0 e depois o n�mero 1 e os n�meros seguintes sempre ser�o a soma dos dois n�meros anteriores.

DECLARE @NUMERO_ANTERIOR2 INT;
DECLARE @NUMERO_ANTERIOR1 INT;
DECLARE @NUMERO_ATUAL INT;
DECLARE @SEQUENCIA INT;
DECLARE @LIMITE_MAXIMO INT;
DECLARE @CONTADOR_SEQUENCIA INT;

SET @LIMITE_MAXIMO = 100;
SET @SEQUENCIA = 20;
SET @CONTADOR_SEQUENCIA = 3;

SET @NUMERO_ANTERIOR2 = 0;
SET @NUMERO_ANTERIOR1 = 1;
PRINT 'POSI��O 1 --> 0';
PRINT 'POSI��O 2 --> 1';
WHILE @CONTADOR_SEQUENCIA <= @SEQUENCIA
BEGIN
   SET @NUMERO_ATUAL = @NUMERO_ANTERIOR2 + @NUMERO_ANTERIOR1;
   PRINT 'POSI��O ' + TRIM(STR(@CONTADOR_SEQUENCIA,10,0)) + ' --> ' + TRIM(STR(@NUMERO_ATUAL, 10,0));
   IF @NUMERO_ATUAL > @LIMITE_MAXIMO BREAK; 
   SET  @NUMERO_ANTERIOR2 = @NUMERO_ANTERIOR1;
   SET @NUMERO_ANTERIOR1 = @NUMERO_ATUAL;
   SET @CONTADOR_SEQUENCIA = @CONTADOR_SEQUENCIA + 1;
END;

Vai escrever a sequ�ncia de FIBONACCI e ir� parar quando duas condi��es ocorrerem (o que vier primeiro).

Se o valor do �ltimo n�mero da sequ�ncia for maior que @LIMITE_MAXIMO o SCRIPT encerra.
Se a posi��o do �ltimo n�mero da sequ�ncia for maior que @SEQUENCIA o SCRIPT encerra.
Levando em considera��o o que fizemos at� o momento, como podemos modificar o SCRIPT para que ele somente 
pare quando a posi��o do �ltimo n�mero da sequ�ncia for maior que @SEQUENCIA?

Al�m disso, qual seria o n�mero FIBONACCI da posi��o 44?
*/
----------------------

/*verifica e coloca em uma nova tabela os n�meros que s�o e os que n�o s�o notas fiscais*/
--verifica se a tabela existe,caso exista, vai excluir ela
IF OBJECT_ID('TABELA DE NUMEROS', 'u') IS NOT NULL DROP TABLE [TABELA DE NUMEROS];
CREATE TABLE [TABELA DE NUMEROS] ([NUMERO] INT, [STATUS] VARCHAR(20));

--declara��o das vari�vis
DECLARE @NUMERO_INICIAL_SEQUENCIA INT, @NUMERO_FINAL_SEQUENCIA INT;
DECLARE @TESTE_NOTA_FISCAL INT;

--atribuindo valores 
SET @NUMERO_INICIAL_SEQUENCIA = 1;
SET @NUMERO_FINAL_SEQUENCIA = 200;

--impede de aparecer aquele monte de 'uma linha afetada' na aba de mensagem/resultados
SET NOCOUNT ON;
--entra em looping at� varrer os n�meros descrito nas vair�veis
WHILE @NUMERO_INICIAL_SEQUENCIA <= @NUMERO_FINAL_SEQUENCIA
	BEGIN
        SELECT @TESTE_NOTA_FISCAL = COUNT(*) FROM [NOTAS FISCAIS] WHERE 
        NUMERO = @NUMERO_INICIAL_SEQUENCIA;
        IF @TESTE_NOTA_FISCAL = 1
             INSERT INTO [TABELA DE NUMEROS] ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, '� NOTA FISCAL');
        ELSE
             INSERT INTO [TABELA DE NUMEROS] ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, 'N�O � NOTA FISCAL');
        SET @NUMERO_INICIAL_SEQUENCIA = @NUMERO_INICIAL_SEQUENCIA + 1;
	END;
/*
EXERC�CIO:
Vamos continuar evoluindo o script da resposta do primeiro exerc�cio desta aula? 
Para isso, inclua o dia e o n�mero de notas em uma tabela.

Segue o script do exerc�cio anterior:
DECLARE @DATAINICIAL DATE
DECLARE @DATAFINAL DATE
DECLARE @NUMNOTAS INT
SET @DATAINICIAL = '2017-01-01'
SET @DATAFINAL = '2017-01-10'
WHILE @DATAINICIAL <= @DATAFINAL
BEGIN
    SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS] 
        WHERE DATA = @DATAINICIAL
    PRINT CONVERT(VARCHAR(10), @DATAINICIAL) + ' --> ' 
        + CONVERT(VARCHAR(10), @NUMNOTAS)
    SELECT @DATAINICIAL = DATEADD(DAY, 1, @DATAINICIAL)
END
*/
-----------------
/*
Controle de fluxo - comando FOR
o FOR de verdade n�o existe no T-SQL, mas � poss�vel simular atraves do WHILE
exmplo: 

DECLARE @I INT;

SET @I =1;

WHILE @I <= 100
BEGIN
    PRINT @I;
    SET @I = @I +1;
END;
*/
------------------------------------------
/*
TABELAS TEMPOR�RIAS

As tabelas tempor�rias, s�o tabelas existentes somente durante determinado tempo e que somem ap�s este per�odo.
As caracter�sticas v�o depender de como se inicia o nome da tabela, portanto temos 3 tipos de tabelas tempor�rias:

nomes que come�am com #;
nomes que come�am com ##;
nomes que come�am com @.
Vamos entender a diferen�a entre elas.

Nomes que come�am com #
Quando temos uma tabela que come�a com um jogo da velha #, significa que fica dispon�vel somente para a conex�o vigente, 
ou seja, a inst�ncia em que estamos trabalhando. Sendo assim, ao abrirmos outra �rea de script no Manegement Studio 
(quando clicamos em New Query) � como se estiv�ssemos em outra conex�o e por isso a tabela n�o ficar� dispon�vel nela.

Nomes que come�am com ##
J� a tabela cujo nome inicia com dois jogos da velha ##, aparece em todas as conex�es e s� deve desaparecer quando derrubarmos o 
servi�o do SQL Server (por exemplo, indo em Service e desconectando de l�).

Nomes que come�am com @
As tabelas em que os nomes iniciam com um arroba @ s� ficam dispon�veis durante a execu��o de um conjunto de comandos de T-SQL.
Ou seja, se estivermos rodando 10 comandos T-SQL de uma s� vez e no meio da execu��o tivermos a cria��o de uma tabela de nome
iniciado com @, esta s� existir� enquanto os comandos ainda s�o executados. Ao parar a execu��o, a tabela deve sumir.

Uma caracter�stica incomum destes 3 tipos de tabela � que s�o criadas em mem�ria, e n�o fisicamente no disco. Sendo assim, 
elas somem desta mem�ria dependendo da caracter�stica de cada uma.
*/
--exemplo de cria��o de tabela tempor�ria com #
CREATE TABLE #TABELA01 (ID VARCHAR(10), NOME VARCHAR(30));
INSERT INTO #TABELA01 VALUES ('1', 'JO�O');

--exemplo de cria��o de tabela tempor�ria com ##
CREATE TABLE ##TABELA02 (ID VARCHAR(10), NOME VARCHAR(30));
INSERT INTO ##TABELA02 VALUES ('1', 'JO�O');
INSERT INTO ##TABELA02 ('2', 'KATIA');

--exemplo de cria��o de tabela tempor�ria com @
/*
a cria��o de tabela tempor�ria com @ � declarada como se fosse uma vari�vel,
e s� vaia aprececer quando selecionar todos os coamandos referente a sua cria��o
no caso, ela � alimentada atrav�s do script com o WHILE abaixo
*/
DECLARE @NUMERO_INICIAL_SEQUENCIA INT, @NUMERO_FINAL_SEQUENCIA INT;
DECLARE @TESTE_NOTA_FISCAL INT;
--tabela tempor�ria aqui
DECLARE @TABELA_DE_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR(20));

SET @NUMERO_INICIAL_SEQUENCIA = 1;
SET @NUMERO_FINAL_SEQUENCIA = 200;

WHILE @NUMERO_INICIAL_SEQUENCIA <= @NUMERO_FINAL_SEQUENCIA
BEGIN
        SELECT @TESTE_NOTA_FISCAL = COUNT(*) FROM [NOTAS FISCAIS] WHERE 
        NUMERO = @NUMERO_INICIAL_SEQUENCIA;
        IF @TESTE_NOTA_FISCAL = 1
             INSERT INTO @TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, '� NOTA FISCAL');
        ELSE
             INSERT INTO @TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, 'N�O � NOTA FISCAL');
        SET @NUMERO_INICIAL_SEQUENCIA = @NUMERO_INICIAL_SEQUENCIA + 1;
END;
-- o comando SELECT * FROM @TABELA_DE_NUMEROS s� vai mostrar a tabela quando selecionada com o scrip acima
--apartir da declara��o dela 
SELECT * FROM @TABELA_DE_NUMEROS;
-------------------------------------
/*
EXERC�CIO: montar um relat�rio mostrando o nome dos clientes, com seus respectivos CPFs e o valor total, 
em volume financeiro, das compras desses clientes em um determinado m�s.
*/
--retorna o nome, cpf e o valor de venda do cliente em um determinado m�s e ano em uma mesma linha
DECLARE @CPF VARCHAR(11);
DECLARE @NOME VARCHAR(100);
DECLARE @NUMERO_CLIENTES INT;
DECLARE @I INT;
DECLARE @MES INT, @ANO INT;
DECLARE @TOTAL_VENDAS FLOAT;
-- delcara��o da tabela tempor�ria
DECLARE @TABELA_FINAL TABLE (CPF VARCHAR(11), NOME VARCHAR(100), MES INT, ANO INT, VALOR_TOTAL FLOAT);

SET @MES = 2;
SET @ANO = 2015;
SELECT @NUMERO_CLIENTES = COUNT(*) FROM [TABELA DE CLIENTES];
SET @I = 1;
WHILE @I <= @NUMERO_CLIENTES
BEGIN
        SELECT @CPF = X.CPF, @NOME = X.NOME
        FROM ( SELECT Row_Number() Over (Order By CPF) as RowNum, * FROM [TABELA DE CLIENTES]) X
        WHERE X.RowNum = @I;

        SELECT 
        @TOTAL_VENDAS = SUM([ITENS NOTAS FISCAIS].QUANTIDADE * [ITENS NOTAS FISCAIS].[PRE�O])
        FROM [NOTAS FISCAIS] 
        INNER JOIN [ITENS NOTAS FISCAIS]
        ON [NOTAS FISCAIS].NUMERO = [ITENS NOTAS FISCAIS].NUMERO
        WHERE [NOTAS FISCAIS].CPF = @CPF
        AND YEAR([NOTAS FISCAIS].DATA) = @ANO AND MONTH([NOTAS FISCAIS].DATA) = @MES;
		--inserindo as vari�veis dentro da tabela tempor�ria
        INSERT INTO @TABELA_FINAL VALUES (@CPF, @NOME, @MES, @ANO, @TOTAL_VENDAS);

        PRINT 'Vendas para ' + @CPF + ' - ' + @NOME + ' NO M�S ' + CONVERT(VARCHAR(2), @MES) + ' E ANO ' + CONVERT(VARCHAR(4),@ANO) + ' FOI DE ' + TRIM(STR(@TOTAL_VENDAS, 15, 2));
        SET @I = @I + 1;

END;
-- mostrando o resultado dentro da tabela tempor�ria (tem que rodar o script todo relacionado a ela)
SELECT * FROM @TABELA_FINAL;
/*
Exerc�cio para pr�ticar: Aplicando o conhecimento desenvolvido durante a aula, 
aplique o mesmo SCRIPT, por�m, para listar o c�digo e nome do produto.
Verifique o nome dos campos na [TABELA DE PRODUTOS].
*/
