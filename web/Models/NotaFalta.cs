using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Data.Objects;
using System.Data.EntityClient;

namespace web.Models
{
    public class NotaFalta
    {

        public int idNotaFalta { get; set; }
        public int idTurma { get; set; }
        public int idModulo { get; set; }
        public int idAluno { get; set; }
        public int qtdFalta { get; set; }
        public decimal nota1 { get; set; }
        public decimal nota2 { get; set; }
        public Aluno Aluno { get; set; }
        public Modulo Modulo { get; set; }
        public Turma Turma { get; set; }
        
    }
}