using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using System.Data;
using Ext.Net;
using System.Web.Services;

namespace web.Controllers
{
    public class TurmaController : Controller
    {
        //
        // GET: /Turma/

        Repositorio<Turma> dbTurma;
        Repositorio<MatriculaTurma> dbMatriculaTurma;

        public TurmaController()
        {
            dbTurma = new Repositorio<Turma>();
            dbMatriculaTurma = new Repositorio<MatriculaTurma>();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult FecharTurma()
        {
            return View();
        }

        public string FindAll(int codigoCurso)
        {
            var listaTurma = (from t in dbTurma.Context.Turma
                              where t.Curso.idCurso == codigoCurso && t.dataFechamento == null && (t.dataInicio <= DateTime.Now && t.dataFim >= DateTime.Now)
                              select new Models.Turma
                              {
                                  descricao = t.descricao,
                                  idTurma = t.idTurma,
                                  dataInicio = t.dataInicio,
                                  idCurso = t.idCurso,
                                  vagasOcupadas = t.vagasOcupadas,
                                  numeroVagas = t.numeroVagas
                              }).ToList();
            //List<Turma> listaTurma = dbTurma.FindAll();
            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";
        }

        public JsonResult FechamentoTurma(int codigoTurma)
        {
            Turma t = dbTurma.FindOne(x => x.idTurma == codigoTurma);
            t.dataFechamento = DateTime.Now;
            dbTurma.Atualizar(t);
            dbTurma.SaveChanges();

            List<MatriculaTurma> listMT = dbMatriculaTurma.FindAll(x => x.idTurma == codigoTurma);
            foreach (MatriculaTurma mt in listMT)
            {
                mt.situacaoAluno = (int)EnumStatus.TurmaFechada;
                dbMatriculaTurma.Atualizar(mt);
            }

            dbMatriculaTurma.SaveChanges();

            return Json(new { success = true});
        }
    }
}
