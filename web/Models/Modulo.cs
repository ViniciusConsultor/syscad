using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Data.Objects;
using System.Data.EntityClient;
using Persistence.DAO;

namespace web.Models
{
    public class Modulo
    {
        public Modulo()
        {
            NotaFaltas = new List<NotaFalta>();
        }
        public int idModulo { get; set; }
        public int idCurso { get; set; }
        public string nome { get; set; }
        public int tempoDuracao { get; set; }
        public int statusModulo { get; set; }
        public Curso Curso { get; set; } //um cara só
        public ICollection<NotaFalta> NotaFaltas { get; set; }
    }
}