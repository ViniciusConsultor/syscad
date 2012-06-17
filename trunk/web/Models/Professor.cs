using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace web.Models
{
    public class Professor : Funcionario
    {
        public ICollection<Especializacao> Especializacoes { get; set; }
        public ICollection<Turma> Turmas { get; set; }
    }
}