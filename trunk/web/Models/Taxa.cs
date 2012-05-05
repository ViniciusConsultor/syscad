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
    public class Taxa
    {
        public Taxa()
        {
            Cobrancas = new List<Cobranca>();
        }

        public int idTaxa { get; set; }
        public String nome { get; set; }
        public String descricao { get; set; }
        public Decimal valor { get; set; }
        public ICollection<Cobranca> Cobrancas { get; set; }
        
    }
}