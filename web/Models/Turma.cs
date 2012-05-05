using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace web.Models
{
    public class Turma
    {
        public Turma()
        {
            MatriculaTurmas = new List<MatriculaTurma>();
            NotaFaltas = new List<NotaFalta>();
        }
        public int idTurma { get; set; }
        public int idCurso { get; set; }
        public string descricao { get; set; }
        public int numeroVagas { get; set; }
        public int vagasOcupadas { get; set; }
        public DateTime dataInicio { get; set; }
        public DateTime dataFim { get; set; }
        public DateTime? dataFechamento { get; set; }
        public Curso Curso { get; set; }
        public ICollection<MatriculaTurma> MatriculaTurmas { get; set; }
        public ICollection<NotaFalta> NotaFaltas { get; set; }
    }
}
