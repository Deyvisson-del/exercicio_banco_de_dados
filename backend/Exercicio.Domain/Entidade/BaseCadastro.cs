using Exercicio.Domain.Entity;

namespace Exercicio.Domain.Entidade
{
    public class BaseCadastro : EntidadeBase
    {
        public string nome { get; set; }
        public string email { get; set; }


        public BaseCadastro()
        {
            nome = string.Empty;
            email = string.Empty;
        }
    }
}
