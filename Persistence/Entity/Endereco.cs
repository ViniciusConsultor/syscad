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
    public class Endereco
    {

        public virtual int idEndereco { get; set; }
        public virtual int idTipoEndereco { get; set; }
        public virtual int idPessoa { get; set; }
        public virtual String logradouro { get; set; }
        public virtual int numero { get; set; }
        public virtual String complemento { get; set; }
        public virtual String CEP { get; set; }
        public virtual String bairro { get; set; }
        public virtual String cidade { get; set; }
        public virtual String uf { get; set; }
        public virtual int tipo { get; set; }
        public virtual Pessoa Pessoa { get; set; }
        public virtual TipoEndereco TipoEndereco { get; set; }

    }
}