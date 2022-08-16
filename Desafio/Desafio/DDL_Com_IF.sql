/*DDL - Data Definition Language*/

USE Master;
GO

/* Confere se o banco de dados já existe no sistema */
IF EXISTS (SELECT * FROM sys.databases WHERE NAME = N'Forum_Games')
BEGIN
    PRINT 'Banco de Dados Forum_Games já foi criado anteriormente'
END
ELSE BEGIN
	CREATE DATABASE Forum_Games;
	PRINT 'Banco de Dados Forum_Games foi criado com sucesso'
END
GO

USE Forum_Games;
GO


/* Confere se a tabela já foi criada anteriormente e exibe uma mensagem no console de resultado.
Caso não tenha sido criada, entra no ELSE e cria a tabela exibindo uma mensagem ao final*/

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'TB_Jogadores')
BEGIN
    PRINT 'Tabela TB_Jogadores já foi criada anteriormente'
END
ELSE BEGIN
	CREATE TABLE TB_Jogadores(
	Id INT IDENTITY(1,1) NOT NULL,
	Usuario NVARCHAR(200) NOT NULL,
	Senha NVARCHAR(200) NOT NULL,
	Nome NVARCHAR(200) NOT NULL,
	Email NVARCHAR(250) NOT NULL,

	CONSTRAINT [PK_Jogador] PRIMARY KEY (Id)
);
	PRINT 'A tabela TB_Jogadores foi criada com sucesso'
END
GO

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'TB_Categorias_Grupos')
BEGIN
    PRINT 'Tabela TB_Categorias_Grupos já foi criada anteriormente'
END
ELSE BEGIN
	CREATE TABLE TB_Categorias_Grupos(
	Id INT IDENTITY(1,1) NOT NULL,
	Categoria NVARCHAR(200) NOT NULL,

	CONSTRAINT [PK_Categoria_Grupo] PRIMARY KEY (Id)
);
	PRINT 'A tabela TB_Categorias_Grupos foi criada com sucesso'
END
GO

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'TB_Categorias_Postagens')
BEGIN
    PRINT 'Tabela TB_Categorias_Postagens já foi criada anteriormente'
END
ELSE BEGIN
	CREATE TABLE TB_Categorias_Postagens(
	Id INT IDENTITY(1,1) NOT NULL,
	Categoria NVARCHAR(200) NOT NULL,

	CONSTRAINT [PK_Categoria_Postagem] PRIMARY KEY (Id)
);
	PRINT 'A tabela TB_Categorias_Postagens foi criada com sucesso'
END
GO

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'TB_Grupos')
BEGIN
    PRINT 'Tabela TB_Grupos já foi criada anteriormente'
END
ELSE BEGIN
	CREATE TABLE TB_Grupos(
	Id INT IDENTITY(1,1) NOT NULL,

	Estilo NVARCHAR(200) NOT NULL,
	Descricao NVARCHAR(500) NOT NULL,
	CategoriaId INT NOT NULL,

	CONSTRAINT [PK_Grupo] PRIMARY KEY (Id),
	CONSTRAINT [FK_TB_Categoria_TB_Grupo] FOREIGN KEY (CategoriaId) REFERENCES TB_Categorias_Grupos(Id)
);
	PRINT 'A tabela TB_Grupos foi criada com sucesso'
END
GO

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'TB_Postagens')
BEGIN
    PRINT 'Tabela TB_Postagens já foi criada anteriormente'
END
ELSE BEGIN
	CREATE TABLE TB_Postagens(
	Id INT IDENTITY(1,1) NOT NULL,

	Titulo NVARCHAR(200) NOT NULL,
	Texto NVARCHAR(500),
	Imagem NVARCHAR(500),
	DataHora DATETIME NOT NULL,
	GrupoId INT NOT NULL,
	CategoriaPostagemId INT NOT NULL,
	JogadorId INT NOT NULL,

	CONSTRAINT [PK_Postagem] PRIMARY KEY (Id),
	CONSTRAINT [FK_TB_Grupos_TB_Postagem] FOREIGN KEY (GrupoId) REFERENCES TB_Grupos(Id),
	CONSTRAINT [FK_TB_Categorias_Postagens_TB_Postagem] FOREIGN KEY (CategoriaPostagemId) REFERENCES TB_Categorias_Postagens(Id),
	CONSTRAINT [FK_TB_Jogador_TB_Postagem] FOREIGN KEY (JogadorId) REFERENCES TB_jogadores(Id),
);
	PRINT 'A tabela TB_Postagens foi criada com sucesso'
END
GO

IF EXISTS (SELECT * FROM sys.tables WHERE NAME = N'RL_Jogadores_Grupos')
BEGIN
    PRINT 'Tabela RL_Jogadores_Grupos já foi criada anteriormente'
END
ELSE BEGIN
	CREATE TABLE RL_Jogadores_Grupos(
	Id INT IDENTITY(1,1) NOT NULL,

	GrupoId INT NOT NULL,
	JogadorId INT NOT NULL,

	CONSTRAINT [PK_Jogadores_Grupos] PRIMARY KEY (Id),
	CONSTRAINT [FK_TB_Grupos] FOREIGN KEY (GrupoId) REFERENCES TB_Grupos(Id),
	CONSTRAINT [FK_TB_Jogadores] FOREIGN KEY (JogadorId) REFERENCES TB_Jogadores(Id),
);
	PRINT 'A tabela RL_Jogadores_Grupos foi criada com sucesso'
END
GO
