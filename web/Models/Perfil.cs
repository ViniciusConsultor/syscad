﻿using System;
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
        public Perfil()
        {
            Usuarios = new List<Usuario>();
        }

        public int idPerfil { get; set; }
        public String nome { get; set; }
        public ICollection<Usuario> Usuarios { get; set; }
        
    }
}