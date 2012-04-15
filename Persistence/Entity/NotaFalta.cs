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
    public class NotaFalta
    {

        public virtual int idNotaFalta { get; set; }
        public virtual int idTurma { get; set; }
        public virtual int idModulo { get; set; }
        public virtual int idAluno { get; set; }
        public virtual int qtdFalta { get; set; }
        public virtual Single nota1 { get; set; }
        public virtual Single nota2 { get; set; }
        public virtual Aluno Aluno { get; set; }
        public virtual Modulo Modulo { get; set; }
        public virtual Turma Turma { get; set; }
        
    }
}