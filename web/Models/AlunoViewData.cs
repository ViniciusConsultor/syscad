using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace web.Models
{
    public class AlunoViewData
    {
        public int IdAluno { get; set; }
        public string Nome { get; set; }
        public int Status { get; set; }
        public string Turma { get; set; }
        public int Nota { get; set; }
        public int Faltas { get; set; }
    }
}