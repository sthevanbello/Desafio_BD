BULK INSERT TB_Jogadores 
	FROM 'D:/TB_Jogadores.csv'
	WITH(
		FIELDTERMINATOR = ';',
		ROWTERMINATOR = '\n',
		CODEPAGE = 'acp'
	);
select * from TB_Jogadores;