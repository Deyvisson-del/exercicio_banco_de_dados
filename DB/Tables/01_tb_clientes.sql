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


-- insert de dados
CALL PR_CRIAR_CLIENTE('Empresa Beta','98.765.432/0001-10');
CALL PR_CRIAR_CLIENTE('Empresa Gama','45.678.901/0001-20');
CALL PR_CRIAR_CLIENTE('Empresa Delta','67.890.123/0001-30');
CALL PR_CRIAR_CLIENTE('Empresa DElta','69.890.123/0001-30');


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

-- ///////////////////////////////////////////////
-- ================{FUNCTION}====================
--////////////////////////////////////////////////

SELECT * FROM tb_CLIENTES;

SELECT * FROM FN_CONSULTAR_CNPJ('12.345.678/0001-90');

CREATE OR REPLACE FUNCTION FN_consultar_cnpj(P_cnpj VARCHAR) 
RETURNS SETOF TB_CLIENTES
LANGUAGE  plpgsql as $$
	BEGIN 
		RETURN QUERY SELECT * FROM TB_CLIENTES WHERE CNPJ_CLIENTE = P_CNPJ::VARCHAR;
	END;
	$$;
--////////////////////////////////////////////////
-- ================{FIM_FUNCTION}=================
--////////////////////////////////////////////////	

-- ==========={VIEW_SIMPLES_CLIENTES}==========
CREATE OR REPLACE VIEW VW_CLIENTES AS
	SELECT * FROM TB_CLIENTES;

CREATE OR REPLACE VIEW VW_CLIENTE_ORDER_ID AS 
	SELECT * FROM TB_CLIENTES ORDER BY ID_CLIENTE;

CREATE OR REPLACE VIEW VW_CLIENTE_ORDER_ALF AS 
	SELECT * FROM TB_CLIENTES ORDER BY NOME_CLIENTE ASC;

CREATE OR REPLACE VIEW VW_CLIENTE_ORDER_DESC AS  
	SELECT * FROM TB_CLIENTES ORDER BY NOME_CLIENTE DESC;


SELECT * FROM VW_CLIENTES;
SELECT * FROM VW_CLIENTE_ORDER_ID;
SELECT * FROM VW_CLIENTE_ORDER_ALF;
SELECT * FROM VW_CLIENTE_ORDER_DESC;
-- ======================={FIM_Views}=================

