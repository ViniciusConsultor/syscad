using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlTypes;

namespace Persistence.Entity
{
    public class Pagamento
    {
        public Pagamento()
        {
            Cobranca = new Cobranca();
        }
        public virtual int idPagamento { get; set; }
        public virtual int idCobranca { get; set; }
        public virtual string dataPagamento { get; set; }
        public virtual decimal valor { get; set; }
        public virtual int formaPag { get; set; }
        public virtual Cobranca Cobranca { get; set; }
    }
}
