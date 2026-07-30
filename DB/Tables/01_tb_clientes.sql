-- =====================================================
-- ================{TABELA_CLIENTES}====================
-- =====================================================
CREATE TABLE TB_CLIENTES (
	ID SERIAL PRIMARY KEY,
	NOME_CLIENTE VARCHAR(100) NOT NULL,
	CNPJ_CLIENTE VARCHAR(18) NOT NULL UNIQUE,
	SEGMENTO_CLIENTE INT DEFAULT 1,
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
SELECT * FROM tb_clientes;
-- ======================={FIM_Views}=================


-- ======================{INSERT_Dados}=====================
INSERT INTO TB_CLIENTES (NOME_CLIENTE, CNPJ_CLIENTE, SEGMENTO_CLIENTE) VALUES
('Empresa Alpha', '12.345.678/0001-90', 2),
('Empresa Beta', '98.765.432/0001-10',3),
('Empresa Gama', '45.678.901/0001-20', 4),
('Empresa Delta', '67.890.123/0001-30', 4),
('TechSolutions Ltda', '12.345.678/0001-89', 2),
('Inovação & Logística S.A.', '98.865.432/0001-10', 3),
('Vanguard Varejo Brasil', '45.121.789/0001-55', 2),
('Alimentos Horizonte Ltda', '33.388.999/0001-22', 4),
('Nexus Consultoria Empresarial', '97.444.111/0001-88', 3),
('Alfa Soluções Industriais S.A.', '11.222.333/0001-01', 2),
('Global Transportes & Logística', '22.333.444/0001-12', 2),
('Verde Vida Produtos Naturais', '33.444.555/0001-23', 3),
('Apex Tecnologia e Inovação', '44.555.666/0001-34', 2),
('Sinergia Consultoria Financeira', '55.666.777/0001-45', 2),
('Mega Atacado & Varejo Ltda', '66.777.888/0001-56', 3),
('Prisma Comunicação e Marketing', '77.888.999/0001-67', 8), 
('Horizonte Saúde & Bem-Estar', '88.999.000/0001-78', 2),
('Titan Construções e Projetos', '99.000.111/0001-89', 3),
('Vanguarda Energia Renovável', '10.111.222/0001-90', 5),
('Atlas Logística e Distribuição Ltda', '15.234.567/0001-01', 6),
('Biolab Diagnósticos Médicos S.A.', '26.345.678/0001-12', 2),
('Conecta Telecomunicações Ltda', '37.456.789/0001-23', 3),
('Delta Engenharia e Infraestrutura', '48.567.890/0001-34', 3),
('EcoServ Viabilidade Ambiental S.A.', '59.678.901/0001-45', 2),
('Forte Alimentos S.A.', '60.789.012/0001-56', 3),
('Gráfica e Editora Expressa Ltda', '71.890.123/0001-67', 1),
('Hyperion Corretora de Seguros', '82.901.234/0001-78', 2),
('InovaTech Soluções em Nuvem Ltda', '93.012.345/0001-89', 3),
('Jardim & Cia Paisagismo Ltda', '14.123.456/0001-90', 8),
('Kroma Sistemas Eletrônicos', '25.234.567/0001-02', 2),
('Lumina Iluminação Inteligente S.A.', '36.345.678/0001-13', 3),
('Metrópole Empreendimentos Imobiliários', '47.456.789/0001-24', 2),
('Nova Era Cosméticos Ltda', '58.567.890/0001-35', 2),
('Omni Segurança Patrimonial Ltda', '69.678.901/0001-46', 12),
('Pinnacle Capital Gestão de Ativos', '70.789.012/0001-57', 2),
('Quantum Processamento de Dados Ltda', '81.890.123/0001-68', 2),
('Rede Sul Comercial de Alimentos', '92.901.234/0001-79', 7),
('Solaris Energia Fotovoltaica S.A.', '13.012.345/0001-80', 5),
('Terra Viva Agronegócios Ltda', '24.123.456/0001-91', 11),
('União Farma Distribuidora S.A.', '35.234.567/0001-03', 4),
('Veloce Transportes Rápidos Ltda', '46.345.678/0001-14', 6),
('Wave Mídia e Entretenimento', '57.456.789/0001-25', 2),
('Xtreme Equipamentos Industriais Ltda', '68.567.890/0001-36', 3),
('Ypsilon Assessoria Jurídica e Fiscal', '79.678.901/0001-47', 4),
('Zênite Soluções Ambientais S.A.', '80.789.012/0001-58', 2),
('Aura Moda e Vestuário Ltda', '91.890.123/0001-69', 3),
('BlueSky Linhas Aéreas e Cargas', '12.901.234/0001-70', 2),
('Cortex Inteligência de Mercado Ltda', '23.012.345/0001-81', 2),
('DynaTech Motores e Peças S.A.', '34.123.456/0001-92', 3);
