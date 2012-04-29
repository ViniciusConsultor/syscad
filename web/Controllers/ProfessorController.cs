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
        private IRepositorio<Modulo> dbModulo;
        private IRepositorio<Turma> dbTurma;
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
        public JsonResult FindModulosByTurma(int codigoTurma)
        {
            Turma turma = dbTurma.FindOne(t => t.idTurma == codigoTurma);
            IList<Modulo> listModulos = dbModulo.FindAll(x => x.idCurso == turma.idCurso);
            return Json(new { modulos = listModulos },JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult FindAlunos(int codigoTurma)
        {
           //IList<MatriculaTurma> listAlunos = dbAluno.Context.MatriculaTurma.Include("Matricula").Where(x => x.idTurma == codigoTurma).ToList();
            string sql = @"select a.idAluno as IdAluno, p.nome as Nome, a.statusPedagogico as Status, t.descricao as Turma
                            from matriculaTurma mt
                            join turma t on mt.idTurma = t.idTurma
                            join matricula m on mt.idMatricula = m.idMatricula
                            join aluno a on m.idAluno = a.idAluno
                            join pessoa p on a.idPessoa = p.idPessoa
                            where mt.idTurma = {0}";
            Object[] parameters = { codigoTurma };
            var listAlunos = dbAluno.Context.ExecuteStoreQuery<AlunoViewData>(sql, parameters).ToList();
            //IList<Modulo> listModulos = dbModulo.FindAll(x => x.idCurso == turma.idCurso);
            return Json(new { alunos = listAlunos }, JsonRequestBehavior.AllowGet);
        }


        public ActionResult LancarNotaFalta()
        {
            return View();
        }

    }
}
