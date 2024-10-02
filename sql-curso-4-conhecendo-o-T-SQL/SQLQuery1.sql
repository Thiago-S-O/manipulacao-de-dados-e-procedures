/*declarando variáveis com o T-SQL
a declaração de uma variável é feita através do comando DECLARE @[nome da variável] [tipo e tamanho dela]
*/
DECLARE @MATRICULA VARCHAR(5);
DECLARE @NOME VARCHAR(100);
DECLARE @PERCENTUAL FLOAT;
DECLARE @DATA DATE;
DECLARE @FERIAS BIT;
DECLARE @BAIRRO VARCHAR(50);

--outra forma de declarar várias variáveis de uma vez só
--DECLARE @MATRICULA VARCHAR(5), @NOME VARCHAR(100),@PERCENTUAL FLOAT, @DATA DATE, @FERIAS BIT, @BAIRRO VARCHAR(50);

/*Atribuindo valores as variáveis declaradas*/
SET @MATRICULA = '00240';
SET @NOME = 'Cláudia Rodrigues';
SET @PERCENTUAL = 0.10;
SET @DATA = '2012-03-12';
SET @FERIAS = 1;
SET @BAIRRO = 'Jardins';

/*Mostrando a execução do comando na tela de log/mensagens com o comando PRINT*/
PRINT @MATRICULA;
PRINT @NOME;
PRINT @PERCENTUAL;
PRINT @DATA;
PRINT @FERIAS;
PRINT @BAIRRO;

SELECT * FROM [TABELA DE VENDEDORES];

INSERT INTO [TABELA DE VENDEDORES]
(MATRICULA, NOME, [PERCENTUAL COMISSÃO], [DATA ADMISSÃO], [DE FERIAS], BAIRRO)
VALUES
(@MATRICULA, @NOME, @PERCENTUAL, @DATA, @FERIAS, @BAIRRO)

PRINT 'UM VENDEDOR INCLUIDO.'

SELECT * FROM [TABELA DE VENDEDORES];

/*
--EXERCÍCIO: declarar as variáveis
--Nome: Cliente - Tipo: Caracteres com 10 posições.
--Nome: Idade - Tipo: Inteiro.
--Nome: DataNascimento - Tipo: Data.
--Nome: Custo - Tipo: Número com casas decimais.

--EXERCÍCIO: atribuir valores as vairáveis e chama-las com o comando PRINT
--Nome: Cliente - Tipo: Caracteres com 10 posições - Valor: João
--Nome: Idade - Tipo: Inteiro - Valor: 10
--Nome: DataNascimento - Tipo: Data - Valor: 10/01/2007
--Nome: Custo - Tipo: Número com casas decimais - Valor: 10,23

--precisa executar todos os comando de uma vez só, ou seja, em uma única seleção
*/
DECLARE @CLIENTE VARCHAR(10), @IDADE INT, @DATA_DE_NASCIMENTO DATE, @CUSTO FLOAT;

SET @CLIENTE = 'João';
SET @IDADE = 10;
SET @DATA_DE_NASCIMENTO = '2007-01-10';
SET @CUSTO = 10.23;

PRINT @CLIENTE;
PRINT @IDADE;
PRINT @DATA_DE_NASCIMENTO;
PRINT @CUSTO;
-----------------
/*
incluindo valores atribuidas as vairáveis dentro da tabela com os campos correspondentes
ao inves de colocar os valores, é chamada a variável no campo da coluna da tabela em questão
é necessário selecionar e executar todos os comando de uma vez para declara, atribuir valores, chamar e inserir na tabela
*/
SELECT * FROM [TABELA DE VENDEDORES];

INSERT INTO [TABELA DE VENDEDORES]
(MATRICULA, NOME, [PERCENTUAL COMISSÃO], [DATA ADMISSÃO], [DE FERIAS], BAIRRO)
VALUES
(@MATRICULA, @NOME, @PERCENTUAL, @DATA, @FERIAS, @BAIRRO)

PRINT 'UM VENDEDOR INCLUIDO.'

SELECT * FROM [TABELA DE VENDEDORES];
-----------------------------------
/*atribuindo valores de uma tabela a variaveis declaradas através de uam correspondência de 
uma coluna (de preferência uma que tenha uma primary key) como no exemplo abaixo
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
comandos CHARINDEX([tipo de caractere dentro da string], [variável/coluna]) e o 
SUBSTRING(NOME, posição_inicial, posição_final)
CHARINDEX - procura um determinado caractere, ou conjunto de caracteres, dentro do caractere maior e retorna sua posição.
*/
SELECT NOME FROM [TABELA DE CLIENTES];

SELECT NOME, CHARINDEX(' ', NOME), SUBSTRING(NOME, 1, CHARINDEX(' ', NOME)) FROM [TABELA DE CLIENTES];
-- pode concatenar dentro do PRINT
PRINT 'O primeiro nome do cliente ' + @NOME + ', cujo CPF é ' + @CPF + ', corresponde a ' + SUBSTRING(@NOME, 1, CHARINDEX(' ', @NOME) - 1);

--DECLARE @CPF VARCHAR(50);
--DECLARE @NOME VARCHAR(100);
--DECLARE @DATA_NASCIMENTO DATE; 
--DECLARE @IDADE INT;
DECLARE @SAIDA VARCHAR(500);

SET @CPF = '1471156710';

SELECT @NOME = NOME, @DATA_NASCIMENTO = [DATA DE NASCIMENTO], @IDADE = IDADE FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;

SET @SAIDA = 'O primeiro nome do cliente ' + @NOME + ', cujo CPF é ' + @CPF + ', corresponde a ' + SUBSTRING(@NOME, 1, CHARINDEX(' ', @NOME) - 1);

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
utilizando o IF, ele faz a verificação se a tabela existe ou não antes de executar o comando de exclusão dela
sempre que chamr o IF, deve chamar também o 
OBJECT_ID('parâmetro [tabelas, vairáveis, colunas, etc...]', 'índice [no caso de não haver índice, usar o U]')
*/
IF OBJECT_ID('TABELA_TESTE', 'U') IS NOT NULL DROP TABLE TABELA_TESTE;
CREATE TABLE TABELA_TESTE (ID VARCHAR(10));
--verifica se existe ou não a TABELA_TESTE antes de excluir ou criar-la
IF OBJECT_ID('TABELA_TESTE', 'U') IS NOT NULL DROP TABLE TABELA_TESTE;
IF OBJECT_ID('TABELA_TESTE', 'U') IS NULL CREATE TABLE TABELA_TESTE (ID VARCHAR(10));

-- Exercíco e testes
DECLARE @IDADE_ALUNO INT;
DECLARE @FORMADO_INGLES BIT;
DECLARE @FORMADO_ALEMAO BIT;
--pra fazer os teste, pode mudar os valores das variáveis
SET @IDADE_ALUNO = 17;
SET @FORMADO_INGLES = 1;
SET @FORMADO_ALEMAO = 0;
--verifica se algumas das condições ou combinação delas é veirdadeira
IF ((@IDADE_ALUNO >= 18 OR @FORMADO_INGLES = 1) OR (@IDADE_ALUNO < 18 AND @FORMADO_ALEMAO = 1))
  PRINT 'EXPRESSAO VERDADEIRA';
ELSE
  PRINT 'EXPRESSAO FALSA';
--------------
--pega o dia de hoje
SELECT GETDATE();
--pega o nome do dia da semana de hoje, ex.: terça-feira
SELECT DATENAME (WEEKDAY, GETDATE());
--pega o dia daqui a 5 dias da data de hoje
SELECT DATEADD(DAY, 5, GETDATE());
--pega o nome do dia da semana daqui 5 dias
SELECT DATENAME (WEEKDAY, DATEADD(DAY, 5, GETDATE()));

--declaraçaõ das variáveis
DECLARE @DIA_SEMANA VARCHAR(20);
DECLARE @NUMERO_DIAS INT;
--aderir valores a essas veiráveis
SET @NUMERO_DIAS = 15;
SET @DIA_SEMANA = DATENAME (WEEKDAY, DATEADD(DAY, @NUMERO_DIAS, GETDATE()));
--print do dia da semana daqui a x dias, conforme o valor colocado na variável @NUMERO_DIAS
PRINT @DIA_SEMANA;
--verificar se o dia da semana é um fim de semana ou dia de semana
IF @DIA_SEMANA = 'Domingo ' OR @DIA_SEMANA = 'Sábado'
    PRINT 'Este dia é fim de semana';
ELSE
    PRINT 'Este dia é dia de semana';
----------------
/*Duas formas de fazer uma declaração*/
DECLARE @LIMITE_MAXIMO FLOAT;
DECLARE @LIMITE_ATUAL FLOAT;
DECLARE @BAIRRO VARCHAR(20);
-- uma é atrbuindo os valores as vaeiáveis
SET @LIMITE_MAXIMO = 50000;
SET @BAIRRO = 'Água Santa';
SELECT @LIMITE_ATUAL = SUM([LIMITE DE CREDITO]) FROM [TABELA DE CLIENTES] WHERE BAIRRO = @BAIRRO;
IF @LIMITE_MAXIMO <= @LIMITE_ATUAL
    PRINT 'VALOR ESTOUROU';
ELSE
    PRINT 'VALOR NÃO ESTOUROU';

--outra é jogando a condiçaõ diretamente no if
DECLARE @LIMITE_MAXIMO FLOAT;
DECLARE @BAIRRO VARCHAR(20);

SET @LIMITE_MAXIMO = 50000;
SET @BAIRRO = 'Água Santa';
IF @LIMITE_MAXIMO <= (SELECT SUM([LIMITE DE CREDITO]) FROM [TABELA DE CLIENTES] WHERE BAIRRO = @BAIRRO)
    PRINT 'VALOR ESTOUROU';
ELSE
    PRINT 'VALOR NÃO ESTOUROU';
---------------------------
/*
EXERCÍCIO: atualizar a data do cliente na tabela de clientes

DECLARE @CPF VARCHAR(15);
DECLARE @DATA_NASCIMENTO DATE;
DECLARE @IDADE INT;

SET @CPF = '1471156710';
--atribuindo a variável o valor da tabela
SELECT @DATA_NASCIMENTO = [DATA DE NASCIMENTO] FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;
SELECT @IDADE = IDADE FROM [TABELA DE CLIENTES] WHERE CPF = @CPF;

--verifica se a idade do cliente está atualizada, 
--fazendo a subtração da data atual com a data de nascimento e retornando um inteiro
IF @IDADE = DATEDIFF(YEAR, @DATA_NASCIMENTO, GETDATE())
	BEGIN
	PRINT 'Não houve atualização no DB'
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

/*Controle de fluxo - comando WHILE: funciona da mesma forma que nas linguagens de programação*/
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
EXERCÍCIO
Sabendo que a função abaixo soma um dia a uma data:
SELECT DATEADD(DAY, 1, @DATA)

Como podemos fazer um script que, a partir do dia 01/01/2017, conte o número de notas fiscais até o dia 10/01/2017 e, 
além disso, imprima a data e o número de notas fiscais?

Dicas:

Declare variáveis do tipo DATE: DATAINICIAL e DATAFINAL;
Faça um loop testando se a data inicial é menor que a data final;
Imprima a data e o número de notas na saída do Management Studio. Não esqueça de converter as variáveis para VARCHAR;
Acrescente um dia à data.
*/

--utilização do BREAK 
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
exercício: De forma bem resumida, a sequência de FIBONACCI é uma sequência que começa com o 
número 0 e depois o número 1 e os números seguintes sempre serão a soma dos dois números anteriores.

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
PRINT 'POSIÇÃO 1 --> 0';
PRINT 'POSIÇÃO 2 --> 1';
WHILE @CONTADOR_SEQUENCIA <= @SEQUENCIA
BEGIN
   SET @NUMERO_ATUAL = @NUMERO_ANTERIOR2 + @NUMERO_ANTERIOR1;
   PRINT 'POSIÇÃO ' + TRIM(STR(@CONTADOR_SEQUENCIA,10,0)) + ' --> ' + TRIM(STR(@NUMERO_ATUAL, 10,0));
   IF @NUMERO_ATUAL > @LIMITE_MAXIMO BREAK; 
   SET  @NUMERO_ANTERIOR2 = @NUMERO_ANTERIOR1;
   SET @NUMERO_ANTERIOR1 = @NUMERO_ATUAL;
   SET @CONTADOR_SEQUENCIA = @CONTADOR_SEQUENCIA + 1;
END;

Vai escrever a sequência de FIBONACCI e irá parar quando duas condições ocorrerem (o que vier primeiro).

Se o valor do último número da sequência for maior que @LIMITE_MAXIMO o SCRIPT encerra.
Se a posição do último número da sequência for maior que @SEQUENCIA o SCRIPT encerra.
Levando em consideração o que fizemos até o momento, como podemos modificar o SCRIPT para que ele somente 
pare quando a posição do último número da sequência for maior que @SEQUENCIA?

Além disso, qual seria o número FIBONACCI da posição 44?
*/
----------------------

/*verifica e coloca em uma nova tabela os números que são e os que não são notas fiscais*/
--verifica se a tabela existe,caso exista, vai excluir ela
IF OBJECT_ID('TABELA DE NUMEROS', 'u') IS NOT NULL DROP TABLE [TABELA DE NUMEROS];
CREATE TABLE [TABELA DE NUMEROS] ([NUMERO] INT, [STATUS] VARCHAR(20));

--declaração das variávis
DECLARE @NUMERO_INICIAL_SEQUENCIA INT, @NUMERO_FINAL_SEQUENCIA INT;
DECLARE @TESTE_NOTA_FISCAL INT;

--atribuindo valores 
SET @NUMERO_INICIAL_SEQUENCIA = 1;
SET @NUMERO_FINAL_SEQUENCIA = 200;

--impede de aparecer aquele monte de 'uma linha afetada' na aba de mensagem/resultados
SET NOCOUNT ON;
--entra em looping até varrer os números descrito nas vairáveis
WHILE @NUMERO_INICIAL_SEQUENCIA <= @NUMERO_FINAL_SEQUENCIA
	BEGIN
        SELECT @TESTE_NOTA_FISCAL = COUNT(*) FROM [NOTAS FISCAIS] WHERE 
        NUMERO = @NUMERO_INICIAL_SEQUENCIA;
        IF @TESTE_NOTA_FISCAL = 1
             INSERT INTO [TABELA DE NUMEROS] ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, 'É NOTA FISCAL');
        ELSE
             INSERT INTO [TABELA DE NUMEROS] ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, 'NÃO É NOTA FISCAL');
        SET @NUMERO_INICIAL_SEQUENCIA = @NUMERO_INICIAL_SEQUENCIA + 1;
	END;
/*
EXERCÍCIO:
Vamos continuar evoluindo o script da resposta do primeiro exercício desta aula? 
Para isso, inclua o dia e o número de notas em uma tabela.

Segue o script do exercício anterior:
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
o FOR de verdade não existe no T-SQL, mas é possível simular atraves do WHILE
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
TABELAS TEMPORÁRIAS

As tabelas temporárias, são tabelas existentes somente durante determinado tempo e que somem após este período.
As características vão depender de como se inicia o nome da tabela, portanto temos 3 tipos de tabelas temporárias:

nomes que começam com #;
nomes que começam com ##;
nomes que começam com @.
Vamos entender a diferença entre elas.

Nomes que começam com #
Quando temos uma tabela que começa com um jogo da velha #, significa que fica disponível somente para a conexão vigente, 
ou seja, a instância em que estamos trabalhando. Sendo assim, ao abrirmos outra área de script no Manegement Studio 
(quando clicamos em New Query) é como se estivéssemos em outra conexão e por isso a tabela não ficará disponível nela.

Nomes que começam com ##
Já a tabela cujo nome inicia com dois jogos da velha ##, aparece em todas as conexões e só deve desaparecer quando derrubarmos o 
serviço do SQL Server (por exemplo, indo em Service e desconectando de lá).

Nomes que começam com @
As tabelas em que os nomes iniciam com um arroba @ só ficam disponíveis durante a execução de um conjunto de comandos de T-SQL.
Ou seja, se estivermos rodando 10 comandos T-SQL de uma só vez e no meio da execução tivermos a criação de uma tabela de nome
iniciado com @, esta só existirá enquanto os comandos ainda são executados. Ao parar a execução, a tabela deve sumir.

Uma característica incomum destes 3 tipos de tabela é que são criadas em memória, e não fisicamente no disco. Sendo assim, 
elas somem desta memória dependendo da característica de cada uma.
*/
--exemplo de criação de tabela temporária com #
CREATE TABLE #TABELA01 (ID VARCHAR(10), NOME VARCHAR(30));
INSERT INTO #TABELA01 VALUES ('1', 'JOÃO');

--exemplo de criação de tabela temporária com ##
CREATE TABLE ##TABELA02 (ID VARCHAR(10), NOME VARCHAR(30));
INSERT INTO ##TABELA02 VALUES ('1', 'JOÃO');
INSERT INTO ##TABELA02 ('2', 'KATIA');

--exemplo de criação de tabela temporária com @
/*
a criação de tabela temporária com @ é declarada como se fosse uma variável,
e só vaia aprececer quando selecionar todos os coamandos referente a sua criação
no caso, ela é alimentada através do script com o WHILE abaixo
*/
DECLARE @NUMERO_INICIAL_SEQUENCIA INT, @NUMERO_FINAL_SEQUENCIA INT;
DECLARE @TESTE_NOTA_FISCAL INT;
--tabela temporária aqui
DECLARE @TABELA_DE_NUMEROS TABLE ([NUMERO] INT, [STATUS] VARCHAR(20));

SET @NUMERO_INICIAL_SEQUENCIA = 1;
SET @NUMERO_FINAL_SEQUENCIA = 200;

WHILE @NUMERO_INICIAL_SEQUENCIA <= @NUMERO_FINAL_SEQUENCIA
BEGIN
        SELECT @TESTE_NOTA_FISCAL = COUNT(*) FROM [NOTAS FISCAIS] WHERE 
        NUMERO = @NUMERO_INICIAL_SEQUENCIA;
        IF @TESTE_NOTA_FISCAL = 1
             INSERT INTO @TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, 'É NOTA FISCAL');
        ELSE
             INSERT INTO @TABELA_DE_NUMEROS ([NUMERO], [STATUS]) 
             VALUES (@NUMERO_INICIAL_SEQUENCIA, 'NÃO É NOTA FISCAL');
        SET @NUMERO_INICIAL_SEQUENCIA = @NUMERO_INICIAL_SEQUENCIA + 1;
END;
-- o comando SELECT * FROM @TABELA_DE_NUMEROS só vai mostrar a tabela quando selecionada com o scrip acima
--apartir da declaração dela 
SELECT * FROM @TABELA_DE_NUMEROS;
-------------------------------------
/*
EXERCÍCIO: montar um relatório mostrando o nome dos clientes, com seus respectivos CPFs e o valor total, 
em volume financeiro, das compras desses clientes em um determinado mês.
*/
--retorna o nome, cpf e o valor de venda do cliente em um determinado mês e ano em uma mesma linha
DECLARE @CPF VARCHAR(11);
DECLARE @NOME VARCHAR(100);
DECLARE @NUMERO_CLIENTES INT;
DECLARE @I INT;
DECLARE @MES INT, @ANO INT;
DECLARE @TOTAL_VENDAS FLOAT;
-- delcaração da tabela temporária
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
        @TOTAL_VENDAS = SUM([ITENS NOTAS FISCAIS].QUANTIDADE * [ITENS NOTAS FISCAIS].[PREÇO])
        FROM [NOTAS FISCAIS] 
        INNER JOIN [ITENS NOTAS FISCAIS]
        ON [NOTAS FISCAIS].NUMERO = [ITENS NOTAS FISCAIS].NUMERO
        WHERE [NOTAS FISCAIS].CPF = @CPF
        AND YEAR([NOTAS FISCAIS].DATA) = @ANO AND MONTH([NOTAS FISCAIS].DATA) = @MES;
		--inserindo as variáveis dentro da tabela temporária
        INSERT INTO @TABELA_FINAL VALUES (@CPF, @NOME, @MES, @ANO, @TOTAL_VENDAS);

        PRINT 'Vendas para ' + @CPF + ' - ' + @NOME + ' NO MÊS ' + CONVERT(VARCHAR(2), @MES) + ' E ANO ' + CONVERT(VARCHAR(4),@ANO) + ' FOI DE ' + TRIM(STR(@TOTAL_VENDAS, 15, 2));
        SET @I = @I + 1;

END;
-- mostrando o resultado dentro da tabela temporária (tem que rodar o script todo relacionado a ela)
SELECT * FROM @TABELA_FINAL;
/*
Exercício para práticar: Aplicando o conhecimento desenvolvido durante a aula, 
aplique o mesmo SCRIPT, porém, para listar o código e nome do produto.
Verifique o nome dos campos na [TABELA DE PRODUTOS].
*/
