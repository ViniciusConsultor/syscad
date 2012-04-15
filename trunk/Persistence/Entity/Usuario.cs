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
    public class Usuario
    {
        public Usuario()
        {
            Funcionarios = new List<Funcionario>();
        }

        public virtual int idUsuario { get; set; }
        public virtual int idPerfil { get; set; }
        public virtual String login { get; set; }
        public virtual String senha { get; set; }
        public virtual ICollection<Funcionario> Funcionarios { get; private set; }
        public virtual Perfil Perfil { get; set; }
        
    }
}