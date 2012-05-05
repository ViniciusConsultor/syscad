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
    public class Endereco
    {

        public int idEndereco { get; set; }
        public int idTipoEndereco { get; set; }
        public int idPessoa { get; set; }
        public String logradouro { get; set; }
        public int numero { get; set; }
        public String complemento { get; set; }
        public String CEP { get; set; }
        public String bairro { get; set; }
        public String cidade { get; set; }
        public String uf { get; set; }
        public int tipo { get; set; }
        public Pessoa Pessoa { get; set; }
        public TipoEndereco TipoEndereco { get; set; }

    }
}