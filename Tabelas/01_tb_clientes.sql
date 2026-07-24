--Criação da tabela clientes 

CREATE TABLE tb_clientes ( 
	cliente_id VARCHAR(10) PRIMARY KEY DEFAULT ('C' || LPAD(NEXTVAL('id_cliente_sequence')::TEXT,3,'0')) REFERENCES tb_clientes(cliente_id),
	cliente_nome VARCHAR(100) NOT NULL,
	cliente_cnpj VARCHAR(18) NOT NULL UNIQUE,
	cliente_segmento_id INTEGER REFERENCES tb_segmentos(id_segmento)
)

SELECT * FROM tb_clientes;

INSERT INTO tb_clientes (cliente_nome,cliente_cnpj,cliente_segmento_id) 
VALUES ('Empresa Alpha', '12.345.678/0001-90',1);