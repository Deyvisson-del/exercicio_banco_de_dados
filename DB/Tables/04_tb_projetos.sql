--Sequence responsável por autoincrementar o contador de IDs de (ID_projeto)
CREATE SEQUENCE ID_PROJETO_SEQUENCE START 1;

--==========={Criando_tabela_de_projetos}===============
CREATE TABLE TB_PROJETOS (
	ID_PROJETO VARCHAR(10) PRIMARY KEY DEFAULT (
		'P' || LPAD(NEXTVAL('id_projeto_sequence')::TEXT, 3, '0')
	),
	CLIENTE_PROJETO VARCHAR(10) REFERENCES TB_CLIENTES (ID_CLIENTE),
	NOME_PROJETO VARCHAR(50) NOT NULL,
	STATUS_PROJETO INT REFERENCES tb_status_projetos(id_status) DEFAULT 1,
	TAREFAS_projeto INT REFERENCES TB_TAREFAS(),
	DATA_CRIACAO_PROJETO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DATA_MODIFICACAO_PROJETO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DATA_PREVISAO_PROJETO TIMESTAMP DEFAULT (CURRENT_TIMESTAMP + INTERVAL '45 days'),
	DATA_ENTREGA_PROJETO TIMESTAMP 
)
-- ==============={Fim_Criação de Tabela}==================

--========={INSERINDO_OS_DADOS_NA_TABELA_DE_PROJETOS}===========
INSERT INTO TB_PROJETOS (CLIENTE_PROJETO, NOME_PROJETO,Status_projeto)
VALUES ('C001','ERP Financeiro', 3);

INSERT INTO TB_PROJETOS (CLIENTE_PROJETO, NOME_PROJETO,Status_projeto)
VALUES ('C002','APP MOBILE', 9);

INSERT INTO TB_PROJETOS (CLIENTE_PROJETO, NOME_PROJETO, STATUS_PROJETO)
VALUES ('C004','Data Warehouse',3);

INSERT INTO TB_PROJETOS (CLIENTE_PROJETO, NOME_PROJETO, STATUS_PROJETO)
VALUES ('C001','Portal E-commerce',3);

INSERT INTO TB_PROJETOS (CLIENTE_PROJETO, NOME_PROJETO,STATUS_PROJETO)
VALUES ('C003','Sistema IoT', 11);
--======={Fim_inserção_dos_dados_de_clientes_e_projetos}=======

--================={VIEWS}===================

--==============={FIM_VIEWS}===================
UPDATE TB_PROJETOS 
SET 
DATA_CRIACAO_PROJETO= '2026-01-05 09:00:00', 
DATA_ENTREGA_PROJETO= '2026-01-30 17:00:00' 
WHERE ID_PROJETO = 'P002'




--================={CONSULTA_DE_TRUGGER}==========
--COMANDO PARA CONSULTAR SE A ALGUMA TRUGGER ATIVA NA TABELA
SELECT 
TGNAME,
TGENABLED,
TGTYPE
FROM
PG_TRIGGER
WHERE TGRELID = 'TB_PROJETOS'::REGCLASS
--================={FIM_CONSULTA_DE_TRUGGER}=======

--===={Criando_Function_Atualizar_Data_Modificacao}========
CREATE OR REPLACE FUNCTION function_atualizar_data_modificacao_projeto()
RETURNS TRIGGER AS $$
BEGIN 
	NEW.data_modificacao_projeto = NOW();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--======================={Fim_Function}===================

--==={Criando_Trigger_Para_Atualizar_Data_Modificação}======
CREATE TRIGGER trg_atualiza_data_projetos
BEFORE UPDATE ON tb_projetos
FOR EACH ROW
EXECUTE FUNCTION function_atualizar_data_modificacao_projeto();
--======================{Fim_Trigger}======================

-- ==========={Criando_Function_Validacao_Data_Previsão}=====
CREATE OR REPLACE FUNCTION function_validacao_data_previsao()
RETURN TRIGGER AS $$
BEGIN
	IF NEW.DATA_PREVISAO_PROJETO < NEW.DATA_CRIACAO_PROJETO, NEW.DATA_ENTREGA_PROJETO < NEW.DATA_CRIACAO_PROJETO THEN
		RAISE EXCEPTION 'A DATA DE PREVISÃO NÃO PODE SER ANTERIOR À DATA DE CRIAÇÃO DO PROJETO';
	END IF;
END;
$$ LANGUAGE plpgsql;
-- ========{FIM_Function_Validacao_Data_Criacão)}==========

--==={Criando_Trigger_Para_Atualizar_Data_Modificação}======
CREATE TRIGGER TRG_VALIDA_DATAS_PROJETO
BEFORE INSERT OR UPDATE ON TB_PROJETOS
FOR EACH ROW
EXECUTE FUNCTION FN_VALIDA_DATAS_PROJETO();