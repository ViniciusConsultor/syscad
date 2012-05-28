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
    public class Aluno
    {

        public virtual int idAluno { get; set; }
        public virtual int idPessoa { get; set; }
        public virtual int? idResponsavel { get; set; }
        public virtual int statusPedagogico { get; set; } 
        public virtual int statusFinanceiro { get; set; }
        public virtual Pessoa Pessoa { get; set; }
        public virtual ICollection<Cobranca> Cobrancas { get; private set; }
        public virtual ICollection<Matricula> Matriculas { get; private set; }
        public virtual ICollection<NotaFalta> NotaFaltas { get; private set; }
        public virtual Responsavel Responsavel { get; set; }

        
    }
}