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
    public class Perfil
    {
        public Perfil()
        {
            Usuarios = new List<Usuario>();
        }

        public virtual int idPerfil { get; set; }
        public virtual String nome { get; set; }
        public virtual ICollection<Usuario> Usuarios { get; private set; }        
    }
}