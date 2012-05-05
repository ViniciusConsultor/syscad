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
    public class MatriculaTurma
    {
        public int idMatriculaTurma { get; set; }
        public int idTurma { get; set; }
        public int idMatricula { get; set; }
        public Matricula Matricula { get; set; }
        public Turma Turma { get; set; }
    }
}