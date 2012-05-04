using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Persistence.Entity
{
    public class Responsavel
    {
        
        public Responsavel()
        {
            Alunos = new List<Aluno>();
            Pessoa = new Pessoa();
        }

        public virtual int idResponsavel { get; set; }
        public virtual int idPessoa { get; set; }
        public virtual string grauParentesco { get; set; }
        public virtual ICollection<Aluno> Alunos { get; set; }
        public virtual Pessoa Pessoa { get; set; }
    }
}
