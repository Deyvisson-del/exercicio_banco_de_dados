-- =====================================================
-- ================{TABELA_CLIENTES}====================
-- =====================================================
CREATE TABLE TB_CLIENTES (
	ID SERIAL PRIMARY KEY,
	NOME VARCHAR(100) NOT NULL,
	CNPJ VARCHAR(18) NOT NULL UNIQUE,
	SEGMENTO INT DEFAULT 1,
	DATA_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DATA_MODIFICACAO TIMESTAMP,
	CONSTRAINT FK_SEGMENTO FOREIGN KEY (SEGMENTO) REFERENCES TB_SEGMENTOS (ID_SEGMENTO)
);
-- =====================================================
-- =================={FIM_Tabela}=======================
-- =====================================================

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
	NOME_CLIENTE VARCHAR,
	CNPJ_CLIENTE VARCHAR,
	SEGMENTO_CLIENTE INT DEFAULT NULL
) LANGUAGE PLPGSQL AS $$
	BEGIN
		INSERT INTO TB_CLIENTES(NOME , CNPJ, SEGMENTO ) VALUES (NOME_CLIENTE::TEXT, CNPJ_CLIENTE::TEXT, SEGMENTO_CLIENTE);
	END;
	$$;
--////////////////////////////////////////////////
-- ================{FIM_PROCEDURE}=================
--////////////////////////////////////////////////


-- ==========={VIEW_SIMPLES_CLIENTES}==========
CREATE VIEW VW_CLIENTES AS
	SELECT * FROM TB_CLIENTES;

CREATE VIEW VW_CLIENTE_ORDER_ID AS 
	SELECT * FROM TB_CLIENTES ORDER BY ID;

CREATE VIEW VW_CLIENTE_ORDER_ALF AS 

	SELECT * FROM TB_CLIENTES ORDER NOME;
-- ======================={FIM_Views}=================