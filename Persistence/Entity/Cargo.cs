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
    public class Cargo
    {
        public Cargo()
        {
            Funcionarios = new List<Funcionario>();
        }

        public virtual int idCargo { get; set; }
        public virtual String nome { get; set; }
        public virtual String descricao { get; set; }
        public virtual ICollection<Funcionario> Funcionarios { get; private set; }

        
    }
}