--Tabelas de Referências (Lookup)
--Tabela de Segmentos Clientes
CREATE TABLE tb_segmentos (
	ID_SEGMENTO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	NOME_SEGMENTO VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO
	tb_segmentos (NOME_SEGMENTO)
VALUES
	('Tecnologia'),
	('Varejo'),
	('Saúde'),
	('Indústria');

SELECT
	*
FROM
	tb_segmentos;