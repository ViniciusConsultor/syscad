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
    public class TipoEndereco
    {
        public TipoEndereco()
        {
            Enderecos = new List<Endereco>();
        }

        public virtual int idTipoEndereco { get; set; }
        public virtual String nome { get; set; }
        public virtual ICollection<Endereco> Enderecos { get; set; }

        
    }
}