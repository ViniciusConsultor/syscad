using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace web.Models
{
    public class Responsavel : Pessoa
    {

        public int idResponsavel { get; set; }
        public string grauParentesco { get; set; }
        public Aluno Aluno { get; set; }
    }
}
