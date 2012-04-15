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
    public class Taxa
    {
        public Taxa()
        {
            Cobrancas = new List<Cobranca>();
        }

        public virtual int idTaxa { get; set; }
        public virtual String nome { get; set; }
        public virtual String descricao { get; set; }
        public virtual Decimal valor { get; set; }
        public virtual ICollection<Cobranca> Cobrancas { get; private set; }
        
    }
}