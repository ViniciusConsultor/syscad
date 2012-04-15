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
    public class Cobranca
    {
        public virtual int idCobranca { get; set; }
        public virtual int idAluno { get; set; }
        public virtual int idTaxa { get; set; }
        public virtual int statusPagamento { get; set; }
        public virtual Decimal valorTotal { get; set; }
        public virtual Decimal juros { get; set; }
        public virtual Aluno Aluno { get; set; }
        public virtual Taxa Taxa { get; set; }
    }
}