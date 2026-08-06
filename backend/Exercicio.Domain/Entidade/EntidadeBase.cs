using System.Runtime.CompilerServices;

namespace Exercicio.Domain.Entity
{
    public abstract class EntidadeBase
    {
        
        public int Id { get; set; }
        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public DateTime? DataAtualizacao { get; set; }


        protected EntidadeBase()
        {
            Id = default;
            DataCriacao = DateTime.Now;
            DataAtualizacao = null;
        }


    }
}