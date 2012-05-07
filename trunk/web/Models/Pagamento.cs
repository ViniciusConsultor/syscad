using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace web.Models
{
    public class Pagamento
    {
        public int idPagamento { get; set; }
        public int idCobranca { get; set; }
        public DateTime dataPagamento { get; set; }
        public decimal valor { get; set; }
        public int formaPag { get; set; }
        public Cobranca Cobranca { get; set; }
    }
}
