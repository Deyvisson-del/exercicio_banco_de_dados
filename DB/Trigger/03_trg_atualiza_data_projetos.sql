CREATE TRIGGER trg_atualiza_data_projetos
BEFORE UPDATE ON tb_projetos
FOR EACH ROW
EXECUTE FUNCTION atualizar_data_modificacao_projeto();