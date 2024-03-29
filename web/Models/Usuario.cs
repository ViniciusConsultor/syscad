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
    public class Usuario
    {
        public Usuario()
        {
            Funcionarios = new List<Funcionario>();
        }

        public int idUsuario { get; set; }
        public int idPerfil { get; set; }
        public String login { get; set; }
        public String senha { get; set; }
        public ICollection<Funcionario> Funcionarios { get; set; }
        public Perfil Perfil { get; set; }
        
    }
}