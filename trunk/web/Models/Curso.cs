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
    public class Curso
    {
        public Curso()
        {
            Modulos = new List<Modulo>();
            Turmas = new List<Turma>();
        }
        public int idCurso { get; set; }
        public List<Modulo> Modulos { get; set; } // muitos modulos
        public ICollection<Turma> Turmas { get; set; } // muitas turmas
        public string nome { get; set; }
        public string descricao { get; set; }
        public decimal valor { get; set; }
        public int status { get; set; }
    }
}