CREATE TABLE TB_PROJETOS(
	ID_PROJETO SERIAL PRIMARY KEY,
	CLIENTE_ID INT ,
	RESPONSAVEL_ID INT,
	
	NOME_PROJETO VARCHAR(100) NOT NULL,
	STATUS_PROJETO int DEFAULT 1,
	
	DATA_CRIACAO_PROJETO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DATA_MODIFICACAO_PROJETO TIMESTAMP,
	DATA_ENTREGA_PROJETO TIMESTAMP,
	VALOR_ESTIMADO DECIMAL(15,2)
	
	CONSTRAINT FK_STATUS_PROJETO FOREIGN KEY (STATUS_PROJETO) REFERENCES TB_STATUS_PROJETOS(ID_STATUS),
	CONSTRAINT FK_PROJETO_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES TB_CLIENTES(ID_CLIENTE),
	CONSTRAINT FK_RESPONSAVEL_PROJETO FOREIGN KEY (RESPOSAVEL_ID)REFERENCES TB_FUNCIONARIO(ID_FUNCIONARIO)
);

create or replace view vw_projetos as 
select 
	tp.id_projeto ,
	tc.nome_cliente as "Cliente",
	tf.nome_funcionario as "Responsável",
	nome_projeto as "Nome Projeto",
	tsp.nome_status as "Status",
	data_criacao_projeto as "Data de Criação",
	data_entrega_projeto as "Data de Entrega"
from tb_projetos tp
inner join tb_clientes tc on tc.id_cliente = tp.cliente_id 
inner join tb_funcionarios tf on tf.id_funcionario = tp.responsavel_id 
inner join tb_status_projetos tsp on tsp.id_status = tp.status_projeto 
