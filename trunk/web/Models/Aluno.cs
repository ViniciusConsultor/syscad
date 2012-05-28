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
    public class Aluno : Pessoa
    {
        public Aluno()
        {
            Cobrancas = new List<Cobranca>();
            NotaFaltas = new List<NotaFalta>();
        }

        public int idAluno { get; set; }
        public int? idResponsavel { get; set; }
        public int statusPedagogico { get; set; } 
        public int statusFinanceiro { get; set; }
        public ICollection<Cobranca> Cobrancas { get; set; }
        public Matricula Matricula { get; set; }
        public ICollection<NotaFalta> NotaFaltas { get; set; }
        public Responsavel Responsavel { get; set; }

        
    }
}