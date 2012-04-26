using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Data.Objects;
using System.Data.EntityClient;


namespace Persistence.Entity
{
    public class Curso
    {
        public Curso()
        {
            Modulos = new List<Modulo>();
            Turmas = new List<Turma>();
        }
        public int idCurso { get; set; }
        public ICollection<Modulo> Modulos { get; private set; } // muitos modulos
        public ICollection<Turma> Turmas { get; private set; } // muitas turmas
        public string nome { get; set; }
        public string descricao { get; set; }
        public decimal valor { get; set; }
        public int status { get; set; }
    }
}