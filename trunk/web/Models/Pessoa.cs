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
            Enderecos = new List<Endereco>();
        }

        public int idPessoa { get; set; }
        public String nome { get; set; }
        public String cpf { get; set; }
        public String email { get; set; }
        public String telefone { get; set; }
        public String celular { get; set; }
        public DateTime dataNascimento { get; set; }
        public int sexo { get; set; }
        public Aluno Aluno { get; set; }
        public ICollection<Endereco> Enderecos { get; set; }
        public Funcionario Funcionario { get; set; }
        public Responsavel Responsavel { get; set; }
        
    }
}