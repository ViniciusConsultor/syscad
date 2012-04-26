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
    public class Funcionario
    {
        public virtual int idFuncionario { get; set; }
        public virtual int idUsuario { get; set; }
        public virtual int idCargo { get; set; }
        public virtual int idPessoa { get; set; }
        public virtual decimal? salario { get; set; }
        public virtual Cargo Cargo { get; set; }
        public virtual Pessoa Pessoa { get; set; }
        public virtual Usuario Usuario { get; set; }
        
    }
}