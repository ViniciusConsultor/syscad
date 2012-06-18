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
    public class MatriculaController : Controller
    {
        Repositorio<Matricula> dbMatricula;
        IRepositorio<Aluno> dbAluno;
        IRepositorio<Pessoa> dbPessoa;
        IRepositorio<Responsavel> dbResponsavel;
        IRepositorio<MatriculaTurma> dbMatriculaTurma;
        IRepositorio<Taxa> dbTaxa;
        IRepositorio<Cobranca> dbCobranca;

        public MatriculaController()
        {
            dbMatricula = new Repositorio<Matricula>();
            dbAluno = new Repositorio<Aluno>();
            dbPessoa = new Repositorio<Pessoa>();
            dbResponsavel = new Repositorio<Responsavel>();
            dbMatriculaTurma = new Repositorio<MatriculaTurma>();
            dbTaxa = new Repositorio<Taxa>();
            dbCobranca = new Repositorio<Cobranca>();
        }
        
        public ActionResult Matricula()
        {
            return View();
        }

        public ActionResult Prematricula()
        {
            return View();
        }

        [HttpGet]
        public string FindAll()
        {
            var listaMatricula = (from m in dbMatricula.Context.Matricula
                                  select new Models.Matricula
                                  {
                                      idMatricula = m.idMatricula,
                                      idAluno = m.idAluno,
                                      numeroMatricula = m.numeroMatricula,
                                      tipo = m.tipo,
                                      dataRegistro = m.dataRegistro,
                                      dataCancelamento = m.dataCancelamento != null ? m.dataCancelamento.Value : m.dataRegistro,
                                      Aluno = new Models.Aluno
                                      {
                                          idAluno = m.Aluno.idAluno,
                                          nome = m.Aluno.Pessoa.nome,
                                          Responsavel = new Models.Responsavel
                                          {
                                              idResponsavel = m.Aluno.Responsavel != null ? m.Aluno.Responsavel.idResponsavel : 0,
                                              nome = m.Aluno.Responsavel.Pessoa.nome
                                          }
                                      }
                                  }).ToList();


            string jsonResult = JSON.Serialize(listaMatricula);
            return "{matriculas:" + jsonResult + ", totalReg:" + listaMatricula.Count() + " }";
            //return Json(new { matriculas = listaMatricula, totalReg = listaMatricula.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public string FindAllPreMatricula()
        {
            var listaMatricula = (from m in dbMatricula.Context.Matricula where m.tipo == "prematricula"
                                  select new Models.Matricula
                                  {
                                      idMatricula = m.idMatricula,
                                      idAluno = m.idAluno,
                                      numeroMatricula = m.numeroMatricula,
                                      tipo = m.tipo,
                                      dataRegistro = m.dataRegistro,
                                      dataCancelamento = m.dataCancelamento != null ? m.dataCancelamento.Value : m.dataRegistro,
                                      Aluno = new Models.Aluno
                                      {
                                          idAluno = m.Aluno.idAluno,
                                          nome = m.Aluno.Pessoa.nome,
                                          Responsavel = new Models.Responsavel
                                          {
                                              idResponsavel = m.Aluno.Responsavel != null ? m.Aluno.Responsavel.idResponsavel : 0,
                                              nome = m.Aluno.Responsavel.Pessoa.nome
                                          }
                                      }
                                  }).ToList();


            string jsonResult = JSON.Serialize(listaMatricula);
            return "{matriculas:" + jsonResult + ", totalReg:" + listaMatricula.Count() + " }";
            //return Json(new { matriculas = listaMatricula, totalReg = listaMatricula.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Excluir(int id)
        {

            Matricula matricula = dbMatricula.FindOne(cur => cur.idMatricula == id);
            Aluno aluno = dbAluno.FindOne(x => x.idAluno == matricula.idAluno);
            MatriculaTurma matriculaTurma = dbMatriculaTurma.FindOne(x => x.idMatricula == matricula.idMatricula);
            Cobranca cobranca = dbCobranca.FindOne(x => x.idAluno == aluno.idAluno && x.idTaxa == 1);

            try
            {
                dbCobranca.Remover(cobranca);
                dbCobranca.SaveChanges();
                
                dbMatriculaTurma.Remover(matriculaTurma);
                dbMatriculaTurma.SaveChanges();

                dbMatricula.Remover(matricula);
                dbMatricula.SaveChanges();
                
                dbAluno.Remover(aluno);
                dbAluno.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {
                
                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult ExcluirPreMatricula(int id)
        {

            Matricula matricula = dbMatricula.FindOne(cur => cur.idMatricula == id);
            Aluno aluno = dbAluno.FindOne(x => x.idAluno == matricula.idAluno);
            MatriculaTurma matriculaTurma = dbMatriculaTurma.FindOne(x => x.idMatricula == matricula.idMatricula);

            try
            {

                dbMatriculaTurma.Remover(matriculaTurma);
                dbMatriculaTurma.SaveChanges();

                dbMatricula.Remover(matricula);
                dbMatricula.SaveChanges();

                dbAluno.Remover(aluno);
                dbAluno.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Save(int cmbPessoa_Value, string cmbResponsavel_Value, string txtGrauParentesco, string txtDataCancelamento, int cmbTurma_Value)
        {           

            Matricula matricula = new Matricula();
            Aluno aluno = new Aluno();
            Responsavel responsavel = new Responsavel();
            Cobranca cobranca = new Cobranca();

            Aluno alunoExistente = dbAluno.FindOne(x => x.idPessoa == cmbPessoa_Value);

            Taxa taxa = dbTaxa.FindOne(x => x.idTaxa == 1);            

            if (!String.IsNullOrEmpty(txtDataCancelamento))
            {
                matricula.dataCancelamento = Convert.ToDateTime(txtDataCancelamento);
            }

            if (!String.IsNullOrEmpty(cmbResponsavel_Value) && !String.IsNullOrEmpty(txtGrauParentesco))
            {
                responsavel.idPessoa = Convert.ToInt32(cmbResponsavel_Value);
                responsavel.grauParentesco = txtGrauParentesco;
                aluno.Responsavel = responsavel;
            }
            
            aluno.idPessoa = cmbPessoa_Value;            
            aluno.statusFinanceiro = 0;
            aluno.statusPedagogico = 0;
            
            matricula.numeroMatricula = 0;
            if (alunoExistente != null)
            {
                matricula.idAluno = alunoExistente.idAluno;
            }
            else
            {
                matricula.Aluno = aluno;
            }
            matricula.dataRegistro = DateTime.Now;
            matricula.tipo = "matricula";

            try
            {
                dbMatricula.Adicionar(matricula);
                dbMatricula.SaveChanges();

                cobranca.idTaxa = 1;
                cobranca.idAluno = matricula.idAluno;
                cobranca.statusPagamento = (int)EnumStatus.NaoPago;
                cobranca.valorTotal = taxa.valor;
                cobranca.juros = 0;
                cobranca.dataVencimento = DateTime.Now.AddDays(5);

                Matricula matriculaExistente = dbMatricula.FindOne(x => x.idAluno == matricula.idAluno && x.numeroMatricula != 0);

                Matricula numMatricula = dbMatricula.FindOne(idM => idM.idMatricula == matricula.idMatricula);
                numMatricula.numeroMatricula = matriculaExistente != null ? matriculaExistente.numeroMatricula : numMatricula.idMatricula;
                
                dbMatricula.Atualizar(numMatricula);
                dbMatricula.SaveChanges();

                dbCobranca.Adicionar(cobranca);
                dbCobranca.SaveChanges();

                MatriculaTurma matriculaTurma = new MatriculaTurma();
                matriculaTurma.idMatricula = numMatricula.idMatricula;
                matriculaTurma.idTurma = cmbTurma_Value;

                dbMatriculaTurma.Adicionar(matriculaTurma);
                dbMatriculaTurma.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                
            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }                

        }

        [HttpPost]
        public JsonResult SavePreMatricula(int cmbPessoa_Value, string cmbResponsavel_Value, string txtGrauParentesco, string txtDataCancelamento, int cmbTurma_Value)
        {

            Matricula matricula = new Matricula();
            Aluno aluno = new Aluno();
            Responsavel responsavel = new Responsavel();

            Aluno alunoExistente = dbAluno.FindOne(x => x.idPessoa == cmbPessoa_Value);

            if (!String.IsNullOrEmpty(txtDataCancelamento))
            {
                matricula.dataCancelamento = Convert.ToDateTime(txtDataCancelamento);
            }

            if (!String.IsNullOrEmpty(cmbResponsavel_Value) && !String.IsNullOrEmpty(txtGrauParentesco))
            {
                responsavel.idPessoa = Convert.ToInt32(cmbResponsavel_Value);
                responsavel.grauParentesco = txtGrauParentesco;
                aluno.Responsavel = responsavel;
            }

            aluno.idPessoa = cmbPessoa_Value;
            aluno.statusFinanceiro = 0;
            aluno.statusPedagogico = 0;

            matricula.numeroMatricula = 0;
            if (alunoExistente != null)
            {
                matricula.idAluno = alunoExistente.idAluno;
            }
            else
            {
                matricula.Aluno = aluno;
            }
            matricula.dataRegistro = DateTime.Now;
            matricula.tipo = "prematricula";

            try
            {
                dbMatricula.Adicionar(matricula);
                dbMatricula.SaveChanges();

                Matricula matriculaExistente = dbMatricula.FindOne(x => x.idAluno == matricula.idAluno && x.numeroMatricula != 0);

                Matricula numMatricula = dbMatricula.FindOne(idM => idM.idMatricula == matricula.idMatricula);
                numMatricula.numeroMatricula = matriculaExistente != null ? matriculaExistente.numeroMatricula : numMatricula.idMatricula;

                dbMatricula.Atualizar(numMatricula);
                dbMatricula.SaveChanges();

                MatriculaTurma matriculaTurma = new MatriculaTurma();
                matriculaTurma.idMatricula = numMatricula.idMatricula;
                matriculaTurma.idTurma = cmbTurma_Value;

                dbMatriculaTurma.Adicionar(matriculaTurma);
                dbMatriculaTurma.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpGet]
        public string FindPreMatriculas(int idTurma)
        {
            List<MatriculaTurma> listaMatriculaTurma = dbMatriculaTurma.FindAll(x => x.idTurma == idTurma && x.Matricula.tipo == "prematricula" && (x.Turma.numeroVagas - x.Turma.vagasOcupadas) != 0);

            foreach (MatriculaTurma m in listaMatriculaTurma)
            {
                m.Matricula = new Repositorio<Matricula>().FindOne(x => x.idMatricula == m.idMatricula);
                m.Matricula.Aluno = new Repositorio<Aluno>().FindOne(x => x.idAluno == m.Matricula.idAluno);
                m.Matricula.Aluno.Pessoa = new Repositorio<Pessoa>().FindOne(x => x.idPessoa == m.Matricula.Aluno.idPessoa);
            }

            return "{matriculas:" + JSON.Serialize(listaMatriculaTurma) + ", totalReg:" + listaMatriculaTurma.Count() + "}";

        }

        [HttpGet]
        public int Idade(int idPessoa)
        {
            Pessoa pessoa = dbPessoa.FindOne(x => x.idPessoa == idPessoa);
            TimeSpan data = DateTime.Now - pessoa.dataNascimento;
            int anos = (int)data.TotalDays / 360;

            return anos;
        }

    }
}