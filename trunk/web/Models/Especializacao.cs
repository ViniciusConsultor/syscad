using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace web.Models
{
    public class Especializacao
    {
        public string nome { get; set; }
        public string descricao { get; set; }
        public ICollection<Professor> Professores { get; set; }
    }
}