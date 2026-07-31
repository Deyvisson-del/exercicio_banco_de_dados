--Tabelas de Referências (Lookup)
--Tabela de Segmentos Clientes
CREATE TABLE TB_SEGMENTOS (
	ID_SEGMENTO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	NOME_SEGMENTO VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO
	TB_SEGMENTOS (NOME_SEGMENTO)
VALUES
	('Segmento não definido'),
	('Tecnologia'),
	('Varejo'),
	('Saúde'),
	('Indústria'),
	('Logística'),
	('Comercial'),
	('Marketing'),
	('Recursos Humanos'),
	('Financeiro'),
	('Agronegócio'),
	('Jurídico');
SELECT
	*
FROM
	TB_SEGMENTOS;