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
    public class Cargo
    {
        public Cargo()
        {
            Funcionarios = new List<Funcionario>();
        }

        public int idCargo { get; set; }
        public String nome { get; set; }
        public String descricao { get; set; }
        public ICollection<Funcionario> Funcionarios { get; set; }

        
    }
}