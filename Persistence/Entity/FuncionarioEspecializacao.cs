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
    public class FuncionarioEspecializacao
    {
        public virtual int idFuncionarioEspecializacao { get; set; }
        public virtual int idFuncionario { get; set; }
        public virtual int idEspecializacao { get; set; }
        public virtual Funcionario Funcionario { get; set; }
        public virtual Especializacao Especializacao { get; set; }
        
    }
}