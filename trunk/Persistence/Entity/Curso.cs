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
        public virtual int idCurso { get; set; }
        public virtual ICollection<Modulo> Modulos { get; private set; } // muitos modulos
        public virtual ICollection<Turma> Turmas { get; private set; } // muitas turmas
        public virtual string nome { get; set; }
        public virtual string descricao { get; set; }
        public virtual decimal valor { get; set; }
        public virtual int status { get; set; }
    }
}