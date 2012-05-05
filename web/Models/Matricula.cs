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
    public class Matricula
    {
        public Matricula()
        {
            MatriculaTurmas = new List<MatriculaTurma>();
        }

        public int idMatricula { get; set; }
        public int idAluno { get; set; }
        public int numeroMatricula { get; set; }
        public DateTime dataRegistro { get; set; }
        public DateTime? dataCancelamento { get; set; }
        public String tipo { get; set; }
        public Aluno Aluno { get; set; }
        public ICollection<MatriculaTurma> MatriculaTurmas { get; set; }
        
    }
}