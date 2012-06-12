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
    public class Especializacao
    {
        public Especializacao()
        {
            FuncionarioEspecializacoes = new List<FuncionarioEspecializacao>();
        }

        public virtual int idEspecializacao { get; set; }
        public virtual string nome { get; set; }
        public virtual ICollection<FuncionarioEspecializacao> FuncionarioEspecializacoes { get; set; }
        
    }
}