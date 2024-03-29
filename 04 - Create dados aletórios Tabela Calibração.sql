USE VIDRARIAS
GO

TRUNCATE TABLE MARCA_VIDRARIA
GO

INSERT INTO MARCA_VIDRARIA VALUES('Dinamica', 'Pipeta Volum�trica',5, 'Antonio')
INSERT INTO MARCA_VIDRARIA VALUES('Fisatom', 'Bal�o Volum�trico', 10, 'Maxuel')
INSERT INTO MARCA_VIDRARIA VALUES('Hanna Instruments', 'Bureta', 25, 'Pedro')
INSERT INTO MARCA_VIDRARIA VALUES('HG', 'Proveta', 50, 'Roberto')
INSERT INTO MARCA_VIDRARIA VALUES('INCOTERM', 'B�quer', 100, 'Maur�cio')
INSERT INTO MARCA_VIDRARIA VALUES('Kasvi', 'C�lice', 250, 'Ana Hurtada')
INSERT INTO MARCA_VIDRARIA VALUES('Macherey-Nagel', 'Pipeta Graduada',500, 'Paula')
INSERT INTO MARCA_VIDRARIA VALUES('Marte', 'Kitassato', 1000, 'Patr�cia')
INSERT INTO MARCA_VIDRARIA VALUES('Labor', 'Erlenmeyer', 2000, 'Larissa')
INSERT INTO MARCA_VIDRARIA VALUES('Vitral', 'Pipeta Volum�trica', 5, 'Roberta')

GO

SELECT * FROM MARCA_VIDRARIA
GO

--TESTANDO FUN��O RAND

TRUNCATE TABLE CALIBRACAO
GO

SELECT NOME FROM MARCA_VIDRARIA
WHERE IDMARCA = FLOOR (1 + RAND() * (11 - 1))
GO

SELECT FLOOR (1000 + RAND() * (9999 - 1000))
GO

TRUNCATE TABLE CALIBRACAO
GO

CREATE PROCEDURE FILL_CALIBRACAO AS
DECLARE

			@RESPONSAVEL VARCHAR(200),
			@DATA_DA_CALIBRACAO DATE,
			@PRAZO_PROX_CALIBRACAO INT,
			@NUMERO_CERTIFICADO VARCHAR(10),
			@ID_VIDRARIA INT = 0

WHILE @ID_VIDRARIA < 1000
BEGIN

			SET @RESPONSAVEL = (SELECT NOME FROM MARCA_VIDRARIA
								WHERE IDMARCA = FLOOR (1 + RAND() * (11 - 1)))
			
					
			SET @DATA_DA_CALIBRACAO = (SELECT  convert(date, convert(varchar(15),'2018-' +
			 convert(varchar(5),(convert(int,rand()*12))+1) + '-' +
			 convert(varchar(5),(convert(int,rand()*27))+1))))

			SET @PRAZO_PROX_CALIBRACAO = (SELECT FLOOR (1 + RAND() * (11 - 1)))


			SET @NUMERO_CERTIFICADO = (SELECT CONVERT(VARCHAR,FLOOR (1000 + RAND() * (9999 - 1000))))

			SET @ID_VIDRARIA = @ID_VIDRARIA + 1
			
			

			INSERT INTO CALIBRACAO(RESPONSAVEL, DATA_DA_CALIBRACAO, 
						PRAZO_PROX_CALIBRACAO, NUMERO_CERTIFICADO, ID_VIDRARIA)
			VALUES(@RESPONSAVEL, @DATA_DA_CALIBRACAO, @PRAZO_PROX_CALIBRACAO, 
				   @NUMERO_CERTIFICADO, @ID_VIDRARIA)
			
END
GO 


EXEC FILL_VIDRARIA
GO 
SELECT * FROM CALIBRACAO
ORDER BY ID_VIDRARIA
GO
