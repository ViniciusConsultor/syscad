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
    public class Perfil
    {
        public int idPerfil { get; set; }
        public string nome { get; set; }
        public IList<Usuario> Usuarios { get; set; }
        
    }
}