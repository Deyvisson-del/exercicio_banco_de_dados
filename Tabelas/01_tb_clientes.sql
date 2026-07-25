DROP TABLE tb_clientes;


--Criação da tabela clientes 
CREATE TABLE tb_clientes ( 
	id_cliente VARCHAR(10) PRIMARY KEY DEFAULT ('C' || LPAD(NEXTVAL('id_cliente_sequence')::TEXT,3,'0')) REFERENCES tb_clientes(id_cliente),
	nome_cliente VARCHAR(100) NOT NULL,
	cnpj_cliente VARCHAR(18) NOT NULL UNIQUE,
	id_segmento_cliente INTEGER REFERENCES tb_segmentos(id_segmento)
);

--SELECT * FROM tb_clientes;

INSERT INTO tb_clientes (nome_cliente,cnpj_cliente,id_segmento_cliente) 
VALUES ('Empresa Alpha', '12.345.678/0001-90',1);

INSERT INTO tb_clientes (nome_cliente,cnpj_cliente,id_segmento_cliente) 
VALUES ('Empresa Beta', '98.765.432/0001-10',2);

INSERT INTO tb_clientes (nome_cliente,cnpj_cliente, id_segmento_cliente)
VALUES ('Empresa Gama','45.678.901/0001-20',3);

INSERT INTO tb_clientes (nome_cliente,cnpj_cliente,id_segmento_cliente)
VALUES ('Empresa Delta', '67.890.123/0001-30', 4);

--Consulta Cliente por Nome segmento 
--Adicionar View
SELECT c.id_cliente, c.nome_cliente, c.cnpj_cliente, s.nome_segmento FROM tb_clientes c INNER JOIN tb_segmentos s ON c.id_segmento_cliente = s.id_segmento;
