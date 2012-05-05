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
    public class Funcionario : Pessoa
    {
        public int idFuncionario { get; set; }
        public int idUsuario { get; set; }
        public int idCargo { get; set; }
        public int idPessoa { get; set; }
        public decimal? salario { get; set; }
        public Cargo Cargo { get; set; }
        public Usuario Usuario { get; set; }
        
    }
}