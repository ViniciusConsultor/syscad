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
    public class TipoEndereco
    {
        public TipoEndereco()
        {
            Enderecos = new List<Endereco>();
        }

        public int idTipoEndereco { get; set; }
        public String nome { get; set; }
        public ICollection<Endereco> Enderecos { get; set; }

        
    }
}