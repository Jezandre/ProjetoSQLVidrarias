CREATE DATABASE VIDRARIAS
GO

USE VIDRARIAS 
GO

DROP TABLE VIDRARIA
GO

CREATE TABLE VIDRARIA(
	IDVIDRARIA INT PRIMARY KEY IDENTITY,
	TIPO_DE_VIDRARIA VARCHAR(30) NOT NULL,
	MARCA VARCHAR (30) NOT NULL,
	VOLUME_REAL NUMERIC(10,4)NOT NULL,
	VOLUME_NOMINAL NUMERIC(10,4) NOT NULL
)
GO

DROP TABLE CALIBRACAO
GO

CREATE TABLE CALIBRACAO(
	IDCALIBRACAO INT PRIMARY KEY IDENTITY,
	RESPONSAVEL VARCHAR(200) NOT NULL,
	DATA_DA_CALIBRACAO DATE NOT NULL,
	PRAZO_PROX_CALIBRACAO INT NOT NULL,
	NUMERO_CERTIFICADO VARCHAR(50) NOT NULL,
	ID_VIDRARIA INT UNIQUE
)
GO


CREATE TABLE VERIFICACAO(
	IDCALIBRACAO INT PRIMARY KEY IDENTITY,
	RESPONSAVEL VARCHAR(200),
	DATA_DA_VERIFICACAO DATE,
	PRAZO_PROX_VERIFICACAO INT,
	TIPO_DE_VERIFICACAO VARCHAR(50),
	ID_VIDRARIA INT
)
GO

ALTER TABLE CALIBRACAO ADD CONSTRAINT FK_CALIBRACAO
FOREIGN KEY(ID_VIDRARIA) REFERENCES VIDRARIA(IDVIDRARIA)
GO

ALTER TABLE VERIFICACAO ADD CONSTRAINT FK_VIDRARIA
FOREIGN KEY(ID_VIDRARIA) REFERENCES VIDRARIA(IDVIDRARIA)
GO

