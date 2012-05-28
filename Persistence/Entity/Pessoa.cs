﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Data.Objects;
using System.Data.EntityClient;

namespace Persistence.Entity
{
    public class Pessoa
    {
       

        public virtual int idPessoa { get; set; }
        public virtual String nome { get; set; }
        public virtual String cpf { get; set; }
        public virtual String email { get; set; }
        public virtual String telefone { get; set; }
        public virtual String celular { get; set; }
        public virtual DateTime dataNascimento { get; set; }
        public virtual int sexo { get; set; }
        public virtual ICollection<Aluno> Alunos { get; set; }
        public virtual ICollection<Endereco> Enderecos { get; set; }
        public virtual ICollection<Funcionario> Funcionarios { get; set; }
        public virtual ICollection<Responsavel> Responsaveis { get; set; }
        
    }
}