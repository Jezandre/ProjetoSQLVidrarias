CREATE TABLE AUXILIAR(
	ID INT PRIMARY KEY IDENTITY,
	PRAZO INT,
	NOME_DO_PRAZO VARCHAR (30)

)


INSERT AUXILIAR VALUES (2, 'BIMESTRAL')
INSERT AUXILIAR VALUES (3, 'TRIMESTRAL')
INSERT AUXILIAR VALUES (6, 'SEMESTRAL')
INSERT AUXILIAR VALUES (12, 'ANUAL')



CREATE PROCEDURE FILL_CALIBRACAO AS
DECLARE

--DEFININDO VARIAVEIS
@ID_VER INT,
@ID_MAXIMO INT,
@DATA_VALIDADE DATE,
@DATA_VERIFICACAO DATE,
@PRAZO INT,
@HOJE DATE,
@ID_VIDRARIA INT,
@RESPONSAVEL VARCHAR (30),
@ID_AUX INT,
@TIPO VARCHAR (30)

--ATRIBUINDO VALORES AS VARIAVEIS
SET @ID_VER = 1
SET @ID_MAXIMO = (SELECT MAX(IDENTIFICACAO) FROM vwREALATORIO_COMPLETO)
SET @HOJE = GETDATE()


--UTILIZANDO O LA�O WHILE PARA INSERIR OS VALORES
WHILE @ID_VER <= @ID_MAXIMO
BEGIN
			SET @ID_AUX = FLOOR (1 + RAND() * (5 - 1))--VARI�VEL AUXILIAR PARA CRIAR UM PRAZO ALEAT�RIO

			SET @PRAZO = (SELECT PRAZO FROM AUXILIAR
								WHERE ID = @ID_AUX)

			SET @TIPO = (SELECT NOME_DO_PRAZO FROM AUXILIAR
								WHERE ID = @ID_AUX)

			SET @ID_VIDRARIA = (SELECT IDVIDRARIA 
								FROM VIDRARIA 
								WHERE @ID_VER = IDVIDRARIA)

			SET @DATA_VERIFICACAO = (SELECT DATA_DE_CALIBRACAO FROM vwREALATORIO_COMPLETO
									WHERE IDENTIFICACAO = @ID_VER)
			SET @DATA_VALIDADE = (SELECT DATA_DE_VALIDADE FROM vwREALATORIO_COMPLETO
								  WHERE IDENTIFICACAO = @ID_VER)
			

			WHILE @DATA_VERIFICACAO < @DATA_VALIDADE --INSERINDO DATAS DE VERIFICA��O CONFORME A VALIDADE E A DATA ATUAL
					BEGIN
					SET @RESPONSAVEL = (SELECT NOME FROM MARCA_VIDRARIA
								WHERE IDMARCA = FLOOR (1 + RAND() * (11 - 1)))
					INSERT INTO VERIFICACAO(RESPONSAVEL, DATA_DA_VERIFICACAO, PRAZO_PROX_VERIFICACAO, TIPO_DE_VERIFICACAO, ID_VIDRARIA) 
								VALUES (@RESPONSAVEL,@DATA_VERIFICACAO, @PRAZO, @TIPO, @ID_VIDRARIA)

					SET @DATA_VERIFICACAO = DATEADD(MONTH, @PRAZO,@DATA_VERIFICACAO)

					IF @DATA_VERIFICACAO > @DATA_VALIDADE BREAK --DEFININDO LIMITE DE DATA SE A VIDRARIA ESTIVER VENCIDA

					IF @DATA_VERIFICACAO < @HOJE --DEFININDO LIMITE SE A VIDRARIA AINDA N�O VENCEU
					
					SET @RESPONSAVEL = (SELECT NOME FROM MARCA_VIDRARIA
								WHERE IDMARCA = FLOOR (1 + RAND() * (11 - 1)))
					INSERT INTO VERIFICACAO(RESPONSAVEL, DATA_DA_VERIFICACAO, PRAZO_PROX_VERIFICACAO, TIPO_DE_VERIFICACAO, ID_VIDRARIA) 
								VALUES (@RESPONSAVEL,@DATA_VERIFICACAO, @PRAZO, @TIPO, @ID_VIDRARIA)

					SET @DATA_VERIFICACAO = DATEADD(MONTH, @PRAZO,@DATA_VERIFICACAO)

					IF @DATA_VERIFICACAO > @HOJE BREAK --LIMITE PARA HOJE POIS A VIDRARIA N�O TERA REGISTROS DE VERIFICA��O SE ELA AINDA N�O VENCEU

					END



			SET @ID_VER = @ID_VER + 1 
				 

END
GO 

EXEC FILL_CALIBRACAO
GO


SELECT * FROM  VERIFICACAO
GO


SELECT VI.TIPO_DE_VIDRARIA as 'Tipo', 
VI.MARCA as 'Marca', 
VI.VOLUME_REAL as 'Volume real', 
VI.VOLUME_NOMINAL 'Volume nominal', 
VE.RESPONSAVEL as 'Respons�vel pela Verifica��o',
VE.DATA_DA_VERIFICACAO as 'Data de Verifica��o',
vw.RESPONSAVEL_CALIBRACAO as 'Respons�vel Pela Calibra��o',  
vw.DATA_DE_VALIDADE as 'Data de Calibra��o',
vw.INFORMACAO as 'Situa��o da Calibra��o' 
FROM VIDRARIA VI
INNER JOIN VERIFICACAO VE
ON IDVIDRARIA = ID_VIDRARIA
INNER JOIN vwREALATORIO_COMPLETO vw
ON IDVIDRARIA = IDENTIFICACAO
GO
