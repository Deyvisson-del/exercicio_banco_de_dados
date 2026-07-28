-- ======={Criação_do_Contador_de_Ids_Tabela_Tarefas}=========
CREATE SEQUENCE ID_TAREFAS_SEQUENCE START 1;

-- ================{Criação_Tabela_Tarefas}==============================
CREATE TABLE TB_TAREFAS (
	ID_TAREFA VARCHAR(10) PRIMARY KEY DEFAULT (
	'T' || LAPD(NEXTVAL('id_tarefas_sequence')::TEXT 3, '0')
	),
	NOME_TAREFA VARCHAR(100) NOT NULL,
	DESCRICAO_TAREFA VARCHAR(150) NOT NULL,
	ID_RESPONSAVEL INT REFERENCES TB_FUNCIONARIOS(ID_FUNCIONARIO),
	ID_RECURSO INT REFERENCES TB_RECURSOS(ID_RECURSO),
	STATUS_TAREFA INT  REFERENCES TB_STATUS_TAREFA (ID_STATUS),
	PRIORIDADE_TAREFA INT REFERENCES TB_PRIORIDADE_TAREFAS (ID_PRIORIDADE) DEFAULT 2,
	DATA_CRIACAO_TAREFA TIMESTAMP DEFAULT CURRENT_TIME,
	DATA_MODIFICACAO_TAREFA TIMESTAMP DEFAULT CURRENT_TIME ,
	DATA_ENTREGA_TAREFA TIMESTAMP ,
	ESTIMATIVA_DE_HORAS TIMESTAMP 
)

-- ===================={Fim_da_Tabela}=================================
-- ===================={Criando_Function_Calcular_Estimativa}==========
CREATE FUNCTION OR REPLACE function_calcular_estimativa_horas
RETURN  TIMESTAMP AS $$
BEGIN 
	NEW.ESTIMATIVA_DE_HORAS = 
END;
$$ LANGUAGE plpgsql;
-- ====================={Fim function}==============================

-- ===================={Criação_Tabela_Status_Tarefas}=================
CREATE TABLE TB_STATUS_TAREFAS (
	ID_STATUS INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	NOME_STATUS VARCHAR(50) NOT NULL UNIQUE
)
-- ====================={Fim_da_Tabela}======================
-- ========={Inserindo_Dados_Na_Tabela_de_Status_das_Tarefas}========
INSERT INTO
	TB_STATUS_TAREFAS (NOME_STATUS)
VALUES
	('Concluída'),
	('Em andamento'),
	('Pendente'),
	('Cancelada')
	-- ======================{Fim_Inserção}=========================
	-- ============{Criação_Tabela_Prioridade_Tarefas}==============
CREATE TABLE TB_PRIORIDADE_TAREFAS (
	ID_PRIORIDADE INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	NOME_PRIORIDADE VARCHAR(50) NOT NULL UNIQUE
)
-- ====================={Fim_da_Tabela}======================
-- ========={Inserindo_Dados_Na_Tabela_de_Status_das_Tarefas}========
INSERT INTO
	TB_PRIORIDADE_TAREFAS (NOME_PRIORIDADE)
VALUES
	('Alta'),
	('Média'),
	('Baixa')
	-- ======================{Fim_Inserção}=========================
SELECT
	*
FROM
	TB_TAREFAS;