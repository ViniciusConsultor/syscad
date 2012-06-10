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
    public class Matricula
    {
       
        public virtual int idMatricula { get; set; }
        public virtual int idAluno { get; set; }
        public virtual int numeroMatricula { get; set; }
        public virtual DateTime dataRegistro { get; set; }
        public virtual DateTime? dataCancelamento { get; set; }
        public virtual String tipo { get; set; }
        public virtual Aluno Aluno { get; set; }
        public virtual ICollection<MatriculaTurma> MatriculaTurmas { get; set; }
        
    }
}