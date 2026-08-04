--Tabelas de Referências (Lookup)
--Tabela de Segmentos Clientes
CREATE TABLE TB_SEGMENTOS (
	ID_SEGMENTO INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	NOME_SEGMENTO VARCHAR(100) NOT NULL UNIQUE
);

-- index garante que o nome_segmento não seja adicionado de outras formas 
-- exemplo : TECNOLOGIA, tecnologia, ...
CREATE UNIQUE INDEX idx_segmentos_nome
ON tb_segmentos(LOWER(TRIM(NOME_SEGMENTO)));

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