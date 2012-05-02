using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using web.Models;

namespace web.Controllers
{
    public class ProfessorController : Controller
    {
        private Repositorio<Modulo> dbModulo;
        private Repositorio<Turma> dbTurma;
        private Repositorio<Aluno> dbAluno;
        public ProfessorController()
        {
            dbModulo = new Repositorio<Modulo>();
            dbTurma = new Repositorio<Turma>();
            dbAluno = new Repositorio<Aluno>();
        }

        [HttpGet]
        public JsonResult FindTurmas()
        {
            IList<Turma> listTurmas = dbTurma.FindAll();
            return Json(new { turmas = listTurmas, totalReg = listTurmas.Count() }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult FindTurmaByProfessor(int codigoTurma)
        {
            string sql = @"select m.idModulo as IdModulo, t.idTurma as IdTurma, t.descricao as nomeTurma, c.nome as nomeCurso, m.nome as nomeModulo from turma t
                            join curso c on t.idCurso = c.idCurso
                            join modulo m on m.idCurso = c.idCurso
                            order by c.nome,t.descricao,m.nome";
            var listModulos = dbModulo.Context.ExecuteStoreQuery<ModuloViewData>(sql).ToList();
            return Json(new { modulos = listModulos },JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult FindAlunos(int codigoTurma, int codigoModulo)
        {
            string sql = @"select a.idAluno as IdAluno, t.idTurma as IdTurma, mo.idModulo as IdModulo, p.nome as Nome, nt.nota1 as Nota1, nt.nota2 as Nota2, nt.qtdFalta as Faltas 
                            from aluno a
                            join pessoa p on a.idPessoa = p.idPessoa
                            join matricula m on a.idAluno = m.idAluno
                            join matriculaTurma mt on m.idMatricula = mt.idMatricula
                            join turma t on mt.idTurma = t.idTurma
                            join curso c on t.idCurso = c.idCurso
                            join modulo mo on mo.idCurso = c.idCurso
                            left join notaFalta nt on nt.idAluno = a.idAluno 
                            and nt.idModulo = mo.idModulo and nt.idTurma = t.idTurma
                            where t.idTurma = {0} and mo.idModulo = {1}";
            Object[] parameters = { codigoTurma, codigoModulo };
            var listAlunos = dbAluno.Context.ExecuteStoreQuery<AlunoViewData>(sql, parameters).ToList();
            return Json(new { alunos = listAlunos }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EnviarNotaFalta(int idAluno, int idTurma, int idModulo, string campo, int valor)
        {
            try
            {
                Repositorio<NotaFalta> dbNT = new Repositorio<NotaFalta>();
                NotaFalta notaFalta = dbNT.FindOne(x => x.idAluno == idAluno && x.idTurma == idTurma && x.idModulo == idModulo);
                NotaFalta nt;
                if (notaFalta == null)
                {
                    nt = new NotaFalta();
                    nt.idAluno = idAluno;
                    nt.idTurma = idTurma;
                    nt.idModulo = idModulo;
                }
                else
                {
                    nt = notaFalta;
                }

                switch (campo)
                {
                    case "Nota1":
                        nt.nota1 = valor;
                        break;
                    case "Nota2":
                        nt.nota2 = valor;
                        break;
                    case "Faltas":
                        nt.qtdFalta = valor;
                        break;
                }
                if (notaFalta == null)
                {
                    dbNT.Adicionar(nt);
                }
                else
                {
                    dbNT.Atualizar(nt);
                }
                dbNT.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        public ActionResult LancarNotaFalta()
        {
            return View();
        }

    }
}
