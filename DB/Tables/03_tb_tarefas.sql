CREATE TABLE TB_TAREFAS (
	ID_TAREFAS SERIAL PRIMARY KEY,
	ID_PROJETO INT NOT NULL,
	NOME_TAREFAS VARCHAR(100) NOT NULL,
	DESCRICAO_TAREFAS TEXT NOT NULL,
	REQUERENTE_ID INT NOT NULL, 
	FUNCIONARIO_ID INT NOT NULL,
	PRIORIDADE_ID INT DEFAULT 2, --'2 = MÉDIA'
	DATA_CRIACAO_TAREFAS TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DATA_MODIFICACAO_TAREFAS TIMESTAMP,
	DATA_FINALIZACAO TIMESTAMP,

	CONSTRAINT FK_ID_PROJETOS FOREIGN KEY (ID_PROJETOS) REFERENCES TB_PROJETOS(ID_PROJETO),
	CONSTRAINT FK_ID_REQUERENTE FOREIGN KEY (REQUERENTE_ID) REFERENCES TB_FUNCIONARIOS(ID_FUNCIONARIO),
	CONSTRAINT FK_ID_FUNCIONARIO FOREIGN KEY (FUNCIONARIO_ID) REFERENCES TB_FUNCIONARIOS(ID_FUNCIONARIO),
	CONSTRAINT FK_ID_PRIORIDADE FOREIGN KEY (PRIORIDADE_ID) REFERENCES TB_PRIORIDADE_TAREFAS(ID_PRIORIDADE)
);

create or replace view vw_Tarefas as 
select 
	tt.id_tarefas as "ID tarefa",
	tp.nome_projeto as "Nome Projeto",
	tt.nome_tarefas as "Nome Tarefas",
	tt.descricao_tarefas as "Descrição Tarefa",
	tf.nome_funcionario as "Criador da tarefa",
	tff.nome_funcionario as "Técnico",
	tpt.nome_prioridade as "Prioridade",
	tst.nome_status as "Status",
	tt.data_criacao_tarefas as "Início Tarefa",
	tt.data_finalizacao as "Fim Tarefa"
from tb_tarefas tt  
inner join tb_projetos tp on tt.projeto_id = tp.id_projeto
inner join tb_funcionarios tf on requerente_id = tf.id_funcionario 
inner join tb_funcionarios tff on funcionario_id = tff.id_funcionario
inner join tb_prioridade_tarefas tpt on tt.prioridade_id = tpt.id_prioridade
inner join tb_status_tarefas tst on tt.status_id = tst.id_status


select * from vw_tarefas vt 
 