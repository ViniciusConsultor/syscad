using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace web.Models
{
    public class AlunoViewData
    {
        public int IdAluno { get; set; }
        public int IdTurma { get; set; }
        public int IdModulo { get; set; }
        public string Nome { get; set; }
        public decimal? Nota1 { get; set; }
        public decimal? Nota2 { get; set; }
        public int? Faltas { get; set; }
        public int? situacaoAluno { get; set; }
    }
}