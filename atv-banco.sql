CREATE DATABASE bd_CD;
USE bd_CD;


CREATE TABLE tbArtista (
	codArtista INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    nomeArtista VARCHAR (100) NOT NULL
);

SELECT * FROM tbArtista;
DESCRIBE tbArtista;
DROP TABLE tbArtista;
/*INSERT INTO tbArtista (nomeArtista) 
VALUES ("");*/

CREATE TABLE tbGravadora (
	codGravadora INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    nomeGravadora VARCHAR (50) NOT NULL
);

SELECT * FROM tbGravadora;
DESCRIBE tbGravadora;
DROP TABLE tbGravadora;
/*INSERT INTO tbGravadora (nomeGravadora) 
VALUES ("");*/

CREATE TABLE tbCategoria (
	codCategoria INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    nomeCategoria VARCHAR (50) NOT NULL
);

SELECT * FROM tbCategoria;
DESCRIBE tbCategoria;
DROP TABLE tbCategoria;
/*INSERT INTO tbCategoria (nomeCategoria) 
VALUES ("");*/

CREATE TABLE tbEstado (
    siglaEstado CHAR (2) PRIMARY KEY NOT NULL,
    nomeEstado CHAR(50) NOT NULL
);

SELECT * FROM tbEstado;
DESCRIBE tbEstado;
DROP TABLE tbEstado;
/*INSERT INTO tbEstado (siglaEstado, nomeEstado) 
VALUES ("", "");*/



CREATE TABLE tbCidade (
	codCidade INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    siglaEstado CHAR (2) NOT NULL ,
    nomeCidade VARCHAR(100) NOT NULL,
    FOREIGN KEY (siglaEstado) REFERENCES tbEstado (siglaEstado)
);

SELECT * FROM tbCidade;
DESCRIBE tbCidade;
DROP TABLE tbCidade;
/*INSERT INTO tbCidade (siglaEstado, nomeCidade) 
VALUES ("", "");*/

CREATE TABLE tbCliente (
	codCliente INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
    codCidade INT NOT NULL ,
    nomeCliente VARCHAR(100) NOT NULL,
    enderecoCliente VARCHAR(200) NOT NULL,
    rendaCliente DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK(rendaCliente>=0),
    sexoCliente ENUM ('F', 'M') DEFAULT 'F',
    FOREIGN KEY (codCidade) REFERENCES tbCidade (codCidade)
);

SELECT * FROM tbCliente;
DESCRIBE tbCliente;
DROP TABLE tbCliente;
/*INSERT INTO tbCliente (codCidade, nomeCliente, enderecoCliente, rendaCliente, sexoCliente) 
VALUES ("", "", "", "", "");*/

CREATE TABLE tbConjuge (
	codConjuge INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL,
	codCliente INT ,
    nomeConjuge VARCHAR(100) NOT NULL,
    rendaConjuge DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK(rendaConjuge>=0),
    sexoConjuge ENUM ('F', 'M') DEFAULT 'F',
    FOREIGN KEY (codCliente) REFERENCES tbCliente (codCliente)
);

SELECT * FROM tbConjuge;
DESCRIBE tbConjuge;
DROP TABLE tbConjuge;
/*INSERT INTO tbConjuge (codCliente, nomeConjuge, rendaConjuge, sexoConjuge) 
VALUES ("", "", "", "");*/

CREATE TABLE tbFuncionario (
	codFuncionario INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    nomeFuncionario VARCHAR (100) NOT NULL,
    enderecoFuncionario VARCHAR (200) NOT NULL, 
    salarioFuncionario DECIMAL (10,2) DEFAULT 0 CHECK (salarioFuncionario >= 0),
    sexoFuncionario  ENUM ('F', 'M') DEFAULT 'F'
);

SELECT * FROM tbFuncionario;
DESCRIBE tbFuncionario;
DROP TABLE tbFuncionario;
/*INSERT INTO tbFuncionario (nomeFuncionario, enderecoFuncionario, salarioFuncionario, sexoFuncionario) 
VALUES ("", "", "", "");*/

CREATE TABLE tbDependente (
	codDependente INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    codFuncionario INT NOT NULL,
    nomeDependente VARCHAR (100) NOT NULL,
    sexoDependente ENUM ('F', 'M') DEFAULT 'F',
    FOREIGN KEY (codFuncionario) REFERENCES tbFuncionario (codFuncionario)
);

SELECT * FROM tbDependente;
DESCRIBE tbDependente;
DROP TABLE tbDependente;
/*INSERT INTO tbDependente (codFuncionario, nomeDependente, sexoDependente) 
VALUES ("", "", "");*/

CREATE TABLE tbObra (
	codTitulo INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    codCategoria INT NOT NULL,
    codGravadora INT NOT NULL,
    nomeObra VARCHAR (100) NOT NULL,
    valorObra DECIMAL (10,2) DEFAULT 0 CHECK (valorObra >= 0),
    qtdEstoqueObra INT NOT NULL,
    FOREIGN KEY (codCategoria) REFERENCES tbCategoria (codCategoria),
    FOREIGN KEY (codGravadora) REFERENCES tbGravadora (codGravadora)
);

SELECT * FROM tbObra;
DESCRIBE tbObra;
DROP TABLE tbObra;
/*INSERT INTO tbObra (codCategoria, codGravadora, nomeObra, valorObra, qtdEstoqueObra) 
VALUES ("", "", "", "", "");*/

CREATE TABLE tbPedido (
	codPedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    codCliente INT NOT NULL,
    codFuncionario INT NOT NULL,
    dataPedido DATETIME NOT NULL,
    valorPedido DECIMAL (10,2) DEFAULT 0 CHECK (valorPedido >= 0),
	FOREIGN KEY (codCliente) REFERENCES tbCliente (codCliente),
    FOREIGN KEY (codFuncionario) REFERENCES tbFuncionario (codFuncionario)
);

SELECT * FROM tbPedido;
DESCRIBE tbPedido;
DROP TABLE tbPedido;
/*INSERT INTO tbPedido (codCliente, codFuncionario, dataPedido, valorPedido) 
VALUES ("", "", "", "");*/

CREATE TABLE tbObra_Pedido(
	codObraPedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    codObra INT NOT NULL,
    codPedido INT NOT NULL, 
	qtdObrasVendidas INT NOT NULL CHECK (qtdObrasVendidas>=1),
    valorObraPedido DECIMAL (10,2) DEFAULT 0 CHECK (valorObraPedido > 0),
    FOREIGN KEY (codObra) REFERENCES tbObra (codTitulo),
    FOREIGN KEY (codPedido) REFERENCES tbPedido (codPedido)
);

SELECT * FROM tbObra_Pedido;
DESCRIBE tbObra_Pedido;
DROP TABLE tbObra_Pedido;
/*INSERT INTO tbObra_Pedido (codObra, codPedido, qtdObrasVendidas, valorObraPedido) 
VALUES ("", "", "", "");*/

CREATE TABLE tbTitulo_Artista (
	codTitulo_Artista INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    codTitulo INT NOT NULL,
    codArtista INT NOT NULL,
    FOREIGN KEY (codTitulo) REFERENCES tbObra (codTitulo),
    FOREIGN KEY (codArtista) REFERENCES tbArtista (codArtista)
);

SELECT * FROM tbTitulo_Artista;
DESCRIBE tbTitulo_Artista;
DROP TABLE tbTitulo_Artista;
/*INSERT INTO tbTitulo_Artista (codTitulo, codArtista) 
VALUES ("", "");*/

