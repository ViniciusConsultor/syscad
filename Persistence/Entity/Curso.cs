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
        }
        public virtual int idCurso { get; set; }
        public virtual ICollection<Modulo> Modulos { get; private set; }
        public virtual string nome { get; set; }
        public virtual string descricao { get; set; }
        public virtual decimal valor { get; set; }
        public virtual int status { get; set; }
    }
}