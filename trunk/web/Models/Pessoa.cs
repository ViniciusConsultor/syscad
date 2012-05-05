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
    public class Pessoa
    {
        public Pessoa()
        {
            Alunos = new List<Aluno>();
            Enderecos = new List<Endereco>();
            Funcionarios = new List<Funcionario>();
            Responsaveis = new List<Responsavel>();
        }

        public int idPessoa { get; set; }
        public String nome { get; set; }
        public String cpf { get; set; }
        public String email { get; set; }
        public String telefone { get; set; }
        public String celular { get; set; }
        public DateTime dataNascimento { get; set; }
        public int sexo { get; set; }
        public ICollection<Aluno> Alunos { get; set; }
        public ICollection<Endereco> Enderecos { get; set; }
        public ICollection<Funcionario> Funcionarios { get; set; }
        public ICollection<Responsavel> Responsaveis { get; set; }
        
    }
}