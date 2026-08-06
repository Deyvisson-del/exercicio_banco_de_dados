using Exercicio.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Text;

namespace Exercicio.Domain.Entidade
{
    public class Funcionario : EntidadeBase
    {
        public string Nome { get; set; }

        public Funcionario()
        {
            Nome = string.Empty;
        }
    }
}
