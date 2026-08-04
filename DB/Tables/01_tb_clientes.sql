-- =====================================================
-- ================{TABELA_CLIENTES}====================
-- =====================================================
CREATE TABLE TB_CLIENTES (
	ID_Cliente SERIAL PRIMARY KEY,
	NOME_CLIENTE VARCHAR(100) NOT NULL,
	CNPJ_CLIENTE VARCHAR(18) NOT NULL UNIQUE,
	DATA_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DATA_MODIFICACAO TIMESTAMP
);
-- =====================================================
-- =================={FIM_Tabela}=======================
-- =====================================================
-- Garantindo a unicidade do cnpj, atráves de um indexador
CREATE UNIQUE INDEX idx_clientes_cnpj
ON tb_clientes(LOWER(TRIM(CNPJ_CLIENTE)));

-- //////////////////////////////////////////////////////
-- ================{TRIGGER_FUNCTION}====================
--///////////////////////////////////////////////////////

--================{Trigger_Data_Modificacao}=================
CREATE OR REPLACE FUNCTION FN_UPDATE_DT_MODIFICACAO_CLIENTE () RETURNS TRIGGER AS $$
BEGIN
	NEW.DATA_MODIFICACAO = NOW();
	RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER TRG_UP_DT_MODIFICACAO_CLIENTE BEFORE
UPDATE ON TB_CLIENTES FOR EACH ROW
EXECUTE FUNCTION FN_UPDATE_DT_MODIFICACAO_CLIENTE ();

-- //////////////////////////////////////////////////////
-- ================{FIM_TRIGGER_FUNCTION}=================
-- ///////////////////////////////////////////////////////

-- ///////////////////////////////////////////////
-- ================{PROCEDURE}====================
--////////////////////////////////////////////////
CREATE OR REPLACE PROCEDURE PR_CRIAR_CLIENTE (
	NOME VARCHAR,
	CNPJ VARCHAR
) LANGUAGE PLPGSQL AS $$
	BEGIN
		INSERT INTO TB_CLIENTES(NOME_CLIENTE , CNPJ_CLIENTE ) VALUES (NOME::TEXT, CNPJ::TEXT);
	END;
	$$;
--////////////////////////////////////////////////
-- ================{FIM_PROCEDURE}=================
--////////////////////////////////////////////////

SELECT * FROM VW_CLIENTES;
SELECT * FROM FN_CONSULTAR_CNPJ('29.819.583/0001-69');

SELECT * FROM TB_CLIENTE_SEGMENTO;

CREATE OR REPLACE FUNCTION FN_consultar_cnpj(P_cnpj VARCHAR) 
RETURNS SETOF TB_CLIENTES
LANGUAGE  plpgsql as $$
	BEGIN 
		RETURN QUERY SELECT * FROM TB_CLIENTES WHERE CNPJ = P_CNPJ;
	END;
	$$;

-- ==========={VIEW_SIMPLES_CLIENTES}==========
CREATE VIEW VW_CLIENTES AS
	SELECT * FROM TB_CLIENTES;

CREATE VIEW VW_CLIENTE_ORDER_ID AS 
	SELECT * FROM TB_CLIENTES ORDER BY ID;

CREATE VIEW VW_CLIENTE_ORDER_ALF AS 
	SELECT * FROM TB_CLIENTES ORDER NOME;

CREATE VIEW VW_CLI_SEG AS 
	SELECT C.ID, C.NOME, S.NOME_SEGMENTO FROM TB_CLIENTES C
		INNER JOIN	TB_SEGMENTOS S ON  C.SEGMENTO = S.ID_SEGMENTO;
SELECT * FROM VW_CLI_SEG;
-- ======================={FIM_Views}=================

ALTER TABLE TB_CLIENTES RENAME COLUMN ID TO ID_CLIENTE