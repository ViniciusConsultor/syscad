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
    public class MatriculaTurma
    {

        public virtual int idMatriculaTurma { get; set; }
        public virtual int idTurma { get; set; }
        public virtual int idMatricula { get; set; }
        public virtual Matricula Matricula { get; set; }
        public virtual Turma Turma { get; set; }
        public virtual int? situacaoAluno { get; set; }
        public virtual decimal? notaFinal { get; set; }
    }
}