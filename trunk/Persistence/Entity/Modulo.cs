using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Objects;
using System.Data.EntityClient;

namespace Persistence.Entity
{
    public class Modulo
    {
        public virtual int idModulo { get; set; }
        public virtual int idCurso { get; set; }
        public virtual string nome { get; set; }
        public virtual int tempoDuracao { get; set; }
        public virtual int statusModulo { get; set; }
        public virtual Curso Curso { get; set; }
    }
}