CREATE OR REPLACE FUNCTION function_atualizar_data_modificacao_projeto()
RETURNS TRIGGER AS $$
BEGIN 
	NEW.data_modificacao_projeto = NOW();
	RETURN NEW;
END;

$$ LANGUAGE plpgsql;