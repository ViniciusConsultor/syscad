using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Persistence.Entity
{
    public class Turma
    {
        public Turma()
        {
            MatriculaTurmas = new List<MatriculaTurma>();
            NotaFaltas = new List<NotaFalta>();
        }
        public virtual int idTurma { get; set; }
        public virtual int idCurso { get; set; }
        public virtual string descricao { get; set; }
        public virtual int numeroVagas { get; set; }
        public virtual int vagasOcupadas { get; set; }
        public virtual DateTime dataInicio { get; set; }
        public virtual DateTime dataFim { get; set; }
        public virtual DateTime? dataFechamento { get; set; }
        public virtual Curso Curso { get; set; }
        public virtual ICollection<MatriculaTurma> MatriculaTurmas { get; private set; }
        public virtual ICollection<NotaFalta> NotaFaltas { get; private set; }
    }
}
