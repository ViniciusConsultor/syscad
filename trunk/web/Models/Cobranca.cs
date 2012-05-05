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
    public class Cobranca
    {
        public int idCobranca { get; set; }
        public int idAluno { get; set; }
        public int idTaxa { get; set; }
        public int statusPagamento { get; set; }
        public Decimal valorTotal { get; set; }
        public Decimal juros { get; set; }
        public Aluno Aluno { get; set; }
        public Taxa Taxa { get; set; }
    }
}