CREATE TABLE TB_FUNCIONARIOS (
	ID_FUNCIONARIO SERIAL PRIMARY KEY,
	NOME_FUNCIONARIO VARCHAR(100) NOT NULL,
	EMAIL_FUNCIONARIO VARCHAR(75) UNIQUE NOT NULL,
	CARGO_ID INT NOT NULL,
	CATEGORIA_ID INT NOT NULL,
	STATUS_ID INT NOT NULL,
	SALARIO_FUNCIONARIO DECIMAL(15, 2) NOT NULL, 
	DATA_CRIACAO_FUNCIONARIO TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DATA_MODIFICACAO_FUNCIONARIO TIMESTAMP,

	CONSTRAINT FK_FUNCIONARIO_STATUS FOREIGN KEY (STATUS_ID) REFERENCES TB_STATUS_FUNCIONARIOS (ID_STATUS),
	CONSTRAINT FK_FUNCIONARIO_CATEGORIA FOREIGN KEY (CATEGORIA_ID) REFERENCES TB_CATEGORIA(ID_CATEGORIA),
	CONSTRAINT FK_FUNCIONARIO_CARGO FOREIGN KEY (CARGO_ID) REFERENCES TB_CARGOS (ID_CARGO)
)

INSERT INTO TB_FUNCIONARIOS(NOME_FUNCIONARIO,EMAIL_FUNCIONARIO,CARGO_ID,CATEGORIA_ID,STATUS_ID,SALARIO_FUNCIONARIO) VALUES
('João Silva','joao@tech.com',2,3 ,1, 1600),
('Pedro Costa', 'pedro@tech.com',2,1,1, 12000),
('Carla Mendes', 'carla@tech.com',3,1,1, 9000),
('Mariana Silva', 'mariana@tech.com',4,1,1, 16500),
('Carlos Souza', 'carlos@tech.com',6,1,1, 6000),
('Fernando Lima', 'fernando@tech.com',5,1,1, 18000)

SELECT * FROM VW_FUNCIONARIOS

-- ======================{Views}============================
create or replace view vw_funcionarios as 
select 
tf.id_funcionario as "ID"  ,
tf.nome_funcionario AS "Funcionário", 
tf.email_funcionario as "E-mail",
tc.nome_cargo as "Cargo",
tc2.nome_categoria as "Categoria",
tsf.nome_status as "Status",
tf.salario_funcionario as "Salário",
tf.data_criacao_funcionario as "Data Ingresso"
from tb_funcionarios tf 
inner join tb_cargos tc on tf.cargo_id = tc.id_cargo  
inner join tb_categoria tc2 on tf.categoria_id = tc2.id_categoria 
inner join tb_status_funcionarios tsf  on tf.status_id = tsf.id_status 
-- ======================{Fim}==============================

