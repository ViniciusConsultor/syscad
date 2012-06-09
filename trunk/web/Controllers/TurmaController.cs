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
        Repositorio<Matricula> dbMatricula;
        Repositorio<Taxa> dbTaxa;
        Repositorio<Cobranca> dbCobranca;

        public TurmaController()
        {
            dbTurma = new Repositorio<Turma>();
            dbMatriculaTurma = new Repositorio<MatriculaTurma>();
            dbMatricula = new Repositorio<Matricula>();
            dbTaxa = new Repositorio<Taxa>();
            dbCobranca = new Repositorio<Cobranca>();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult FecharTurma()
        {
            return View();
        }

        public ActionResult AbrirTurma()
        {
            return View();
        }

        public ActionResult VincularAluno()
        {
            return View();
        }

        public ActionResult AutorizarTurma()
        {
            return View();
        }

        public ActionResult ConsultarDisponibilidade()
        {
            return View();
        }

        public string FindAll(int codigoCurso)
        {
            var listaTurma = (from t in dbTurma.Context.Turma
                              where t.Curso.idCurso == codigoCurso && t.status == (int)EnumStatus.TurmaAberta && t.dataFechamento == null && (t.dataInicio <= DateTime.Now && t.dataFim >= DateTime.Now)
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

        public string FindAllTurmas()
        {
            List<Turma> listaTurma = dbTurma.FindAll(x => x.status == (int)EnumStatus.TurmaSolicitada);
            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";
        }

        public string Autorizar(int idTurma)
        {
            Turma turma = dbTurma.FindOne(x => x.idTurma == idTurma);

            turma.status = (int)EnumStatus.TurmaAberta;

            try
            {

                dbTurma.Atualizar(turma);
                dbTurma.SaveChanges();

                return "Sim";
            }
            catch
            {
                return "Não";
            }
            
        }

        public JsonResult Save(int cmbCurso_Value, string dtInicio, string dtFim, string txtDescricao, int txtNumeroVagas)
        {

            Turma turma = new Turma();
            turma.idCurso = cmbCurso_Value;
            turma.dataInicio = Convert.ToDateTime(dtInicio);
            turma.dataFim = Convert.ToDateTime(dtFim);
            turma.descricao = txtDescricao;
            turma.numeroVagas = txtNumeroVagas;
            turma.status = (int)EnumStatus.TurmaSolicitada;

            try
            {

                dbTurma.Adicionar(turma);
                dbTurma.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        public string FindTurmas()
        {
            List<Turma> listaTurma = dbTurma.FindAll(x => (x.numeroVagas - x.vagasOcupadas) != 0 && x.status == (int)EnumStatus.TurmaAberta);
            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";
        }

        public string FindTurmasDisponibilidade(int idCurso)
        {
            List<Turma> listaTurma = dbTurma.FindAll(x => (x.numeroVagas - x.vagasOcupadas) != 0 && x.status == (int)EnumStatus.TurmaAberta && x.idCurso == idCurso);
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

        [HttpPost]
        public string VincularAluno(int idMatriculaTurma)
        {
            MatriculaTurma matriculaTurma = dbMatriculaTurma.FindOne(x => x.idMatriculaTurma == idMatriculaTurma);
            Matricula matricula = dbMatricula.FindOne(x => x.idMatricula == matriculaTurma.idMatricula);
            Turma turma = dbTurma.FindOne(x => x.idTurma == matriculaTurma.idTurma);

            Taxa taxa = dbTaxa.FindOne(x => x.idTaxa == 1);

            Cobranca cobranca = new Cobranca();
            cobranca.idTaxa = 1;
            cobranca.idAluno = matricula.idAluno;
            cobranca.statusPagamento = (int)EnumStatus.NaoPago;
            cobranca.valorTotal = taxa.valor;
            cobranca.juros = 0;
            cobranca.dataVencimento = DateTime.Now.AddDays(5);

            matricula.tipo = "matricula";
            turma.vagasOcupadas ++;

            try
            {
                dbCobranca.Adicionar(cobranca);
                dbCobranca.SaveChanges();

                dbMatricula.Atualizar(matricula);
                dbMatricula.SaveChanges();

                dbTurma.Atualizar(turma);
                dbTurma.SaveChanges();

                return "Sim";
            }
            catch
            {
                return "Não";
            }

        }
    }
}
