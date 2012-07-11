﻿using System;
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

        public string Search(string limit, string query, string start)
        {

            IList<Turma> listaTurma = dbTurma.FindAll(x => x.status == (int)EnumStatus.TurmaAberta).Where(x => x.descricao.ToLower().Contains(query.ToLower())).ToList();

            foreach (Turma t in listaTurma)
            {
                t.Curso = new Repositorio<Curso>().FindOne(x => x.idCurso == t.idCurso);
            }

            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";

            //return Json(new { turmas = listaTurma, totalReg = listaTurma.Count }, JsonRequestBehavior.AllowGet);

        }

        public string GetTurmasAtivas(string limit, string query, string start)
        {

            IList<Turma> listaTurma = dbTurma.FindAll(x => (x.numeroVagas - x.vagasOcupadas) > 0 && x.status == (int)EnumStatus.TurmaAberta).Where(x => x.descricao.ToLower().Contains(query.ToLower())).ToList();

            foreach (Turma t in listaTurma)
            {
                t.Curso = new Repositorio<Curso>().FindOne(x => x.idCurso == t.idCurso);
            }

            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";

            //return Json(new { turmas = listaTurma, totalReg = listaTurma.Count }, JsonRequestBehavior.AllowGet);

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
                                  dataFim = t.dataFim,
                                  idCurso = t.idCurso,
                                  vagasOcupadas = t.vagasOcupadas,
                                  numeroVagas = t.numeroVagas,
                                  Curso = new Models.Curso
                                  {
                                      nome = t.Curso.nome
                                  },
                                  Professor = new Models.Professor
                                  {
                                      nome = t.Funcionario.Pessoa.nome
                                  }
                              }).ToList();
            //List<Turma> listaTurma = dbTurma.FindAll();
            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";
        }

        public string FindAllAbertas(int codigoCurso)
        {
            var listaTurma = (from t in dbTurma.Context.Turma
                              where t.Curso.idCurso == codigoCurso && t.status == (int)EnumStatus.TurmaAberta
                              select new Models.Turma
                              {
                                  descricao = t.descricao,
                                  idTurma = t.idTurma,
                                  dataInicio = t.dataInicio,
                                  dataFim = t.dataFim,
                                  idCurso = t.idCurso,
                                  vagasOcupadas = t.vagasOcupadas,
                                  numeroVagas = t.numeroVagas,
                                  Curso = new Models.Curso
                                  {
                                      nome = t.Curso.nome
                                  },
                                  Professor = new Models.Professor
                                  {
                                      nome = t.Funcionario.Pessoa.nome
                                  }
                              }).ToList();
            //List<Turma> listaTurma = dbTurma.FindAll();
            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";
        }

        public string FindAllTurmas()
        {
            //List<Turma> listaTurma = dbTurma.FindAll(x => x.status == (int)EnumStatus.TurmaSolicitada);
            var listaTurma = (from t in dbTurma.Context.Turma
                              where t.status == (int)EnumStatus.TurmaSolicitada
                              select new Models.Turma
                              {
                                  descricao = t.descricao,
                                  idTurma = t.idTurma,
                                  dataInicio = t.dataInicio,
                                  dataFim = t.dataFim,
                                  idCurso = t.idCurso,
                                  vagasOcupadas = t.vagasOcupadas,
                                  numeroVagas = t.numeroVagas,
                                  Curso = new Models.Curso
                                  {
                                      nome = t.Curso.nome
                                  },
                                  Professor = new Models.Professor
                                  {
                                      nome = t.Funcionario.Pessoa.nome
                                  }
                              }).ToList();
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

        public string Rejeitar(int idTurma)
        {
            Turma turma = dbTurma.FindOne(x => x.idTurma == idTurma);

            turma.status = (int)EnumStatus.TurmaRejeitada;

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

        public JsonResult Save(int cmbCurso_Value, string dtInicio, string dtFim, string txtDescricao, int txtNumeroVagas, int cmbProfessor_Value)
        {

            Turma turma = new Turma();
            turma.idCurso = cmbCurso_Value;
            turma.dataInicio = Convert.ToDateTime(dtInicio);
            turma.dataFim = Convert.ToDateTime(dtFim);
            turma.descricao = txtDescricao;
            turma.numeroVagas = txtNumeroVagas;
            turma.status = (int)EnumStatus.TurmaSolicitada;
            turma.idFuncionario = cmbProfessor_Value;

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
            List<Turma> listaTurma = dbTurma.FindAll(x => (x.numeroVagas - x.vagasOcupadas) > 0 && x.status == (int)EnumStatus.TurmaAberta);
            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";
        }

        public string FindTurmasDisponibilidade(int idCurso)
        {
            //List<Turma> listaTurma = dbTurma.FindAll(x => (x.numeroVagas - x.vagasOcupadas) > 0 && x.status == (int)EnumStatus.TurmaAberta && x.idCurso == idCurso && x.dataInicio < DateTime.Now);
            var listaTurma = (from t in dbTurma.Context.Turma
                              where (t.numeroVagas - t.vagasOcupadas) > 0 && t.status == (int)EnumStatus.TurmaAberta && t.idCurso == idCurso && t.dataInicio < DateTime.Now
                              select new Models.Turma
                              {
                                  descricao = t.descricao,
                                  idTurma = t.idTurma,
                                  dataInicio = t.dataInicio,
                                  dataFim = t.dataFim,
                                  idCurso = t.idCurso,
                                  vagasOcupadas = t.vagasOcupadas,
                                  numeroVagas = t.numeroVagas,
                                  Curso = new Models.Curso
                                  {
                                      nome = t.Curso.nome
                                  },
                                  Professor = new Models.Professor
                                  {
                                      nome = t.Funcionario.Pessoa.nome
                                  }
                              }).ToList();
            
            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";
        }

        public JsonResult FechamentoTurma(int codigoTurma, string justificativa = "")
        {
            try
            {
                Turma t = dbTurma.FindOne(x => x.idTurma == codigoTurma);
                t.dataFechamento = DateTime.Now;
                t.status = (int)EnumStatus.TurmaFechada;

                //Fechamento antes da data de término
                if (t.dataFim > DateTime.Now)
                {
                    t.status = (int)EnumStatus.TurmaFechadaAntes;
                    t.justificativa = justificativa;
                    List<MatriculaTurma> listMT = dbMatriculaTurma.FindAll(x => x.idTurma == codigoTurma);
                    foreach (MatriculaTurma mt in listMT)
                    {
                        mt.situacaoAluno = (int)EnumStatus.TurmaFechadaAntes;
                        dbMatriculaTurma.Atualizar(mt);

                        Matricula mat = dbMatricula.FindOne(x => x.idMatricula == mt.idMatricula);
                        List<Cobranca> cob = dbCobranca.FindAll(x => x.idAluno == mat.idAluno);
                        foreach(var c in cob){
                            c.statusPagamento = 5;
                            dbCobranca.Atualizar(c);
                            dbCobranca.SaveChanges();
                        }

                    }

                    dbMatriculaTurma.SaveChanges();
                }

                dbTurma.Atualizar(t);
                dbTurma.SaveChanges();

                return Json(new { success = true });
            }
            catch(Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
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
            cobranca.idCurso = turma.idCurso;

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

        public JsonResult Excluir(int id)
        {
            Turma turma = dbTurma.FindOne(tur => tur.idTurma == id);

            try
            {
                dbTurma.Remover(turma);
                dbTurma.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }
        }
    }
}
