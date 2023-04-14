/********************************************************************************************
SITUAÇÂO:
	Pode ser utilizada em qualquer situação desde que existam dois valores que atendam os 
	critérios dos parâmetros

OBJETIVO:
    Essa é uma função complementar, utilizada para calcular a variação de tempo entre dois 
	valores do tipo TIME. Muito útil visto que ela realiza o cálculo até o nível de segundos    

HISTÓRICO
    01/01/2023 - Alexsandre Macaulay

*********************************************************************************************/

-- Definindo o banco de dados
USE [NOME_DATABASE];
GO

-- Criando a função, declarando os parâmetros e o seu de retorno
CREATE FUNCTION [dbo].[FUNC_CALCULA_DURACAO] (@DATA_INICIAL TIME, @DATA_FINAL TIME)
RETURNS VARCHAR(250)

-- Início do código
AS BEGIN

	-- Declaração de variáveis
	DECLARE @DURACAO VARCHAR(250)
	DECLARE @HORAS VARCHAR(2)
	DECLARE @MINUTOS VARCHAR(2)
	DECLARE @SEGUNDOS VARCHAR(2)

	-- Calculando e atribuindo a @HORAS a diferença entre os valores informados, lembrando
	-- que o valor de @HORAS será armazenado com VARCHAR(2)
	SET @HORAS = RIGHT(CONCAT('00',DATEDIFF(SECOND,@DATA_INICIAL,@DATA_FINAL)/(3600 * 1)),2)
	
	-- Verificando e atribuindo a @MINUTOS a difença em segundo, restante a subtração das horas
	IF (DATEDIFF(SECOND,@DATA_INICIAL,@DATA_FINAL)/60) - (60*(DATEDIFF(SECOND,@DATA_INICIAL,@DATA_FINAL)/(3600 * 1))) >= 0 
		-- Início do código do IF
		BEGIN
			SET @MINUTOS = RIGHT(CONCAT('00',(DATEDIFF(SECOND,@DATA_INICIAL,@DATA_FINAL)/60) - (60*(DATEDIFF(SECOND,@DATA_INICIAL,@DATA_FINAL)/(3600 * 1)))),2)
		END
	ELSE 
		-- Início do código do ELSE
		BEGIN
			SET @MINUTOS = RIGHT(CONCAT('00',DATEDIFF(SECOND,@DATA_INICIAL,@DATA_FINAL)/60),2)
		END

	-- Verificando e atribuindo a @SEGUNDOS a diferença de segundos resultante após o cálculo
	-- de horas e minutos
	SET @SEGUNDOS = RIGHT(CONCAT('00',(DATEDIFF(SECOND,@DATA_INICIAL,@DATA_FINAL)%60)),2)

	-- Concatenando os valores das variáveis @HORAS, @MINUTOS e @SEGUNDOS e atribuindo a @DURACAO
	SET @DURACAO = CONCAT(@HORAS,':',@MINUTOS,':',@SEGUNDOS)

	-- Definindo que o retorno ao chamar a função será o valor armazenado em @DURACAO
	RETURN @DURACAO

-- Fim do código 
END

-- Fim do bloco T-SQL
GO


