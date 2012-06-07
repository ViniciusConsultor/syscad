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
    public class MatriculaController : Controller
    {
        Repositorio<Matricula> dbMatricula;
        IRepositorio<Aluno> dbAluno;
        IRepositorio<Pessoa> dbPessoa;
        IRepositorio<Responsavel> dbResponsavel;

        public MatriculaController()
        {
            dbMatricula = new Repositorio<Matricula>();
            dbAluno = new Repositorio<Aluno>();
            dbPessoa = new Repositorio<Pessoa>();
            dbResponsavel = new Repositorio<Responsavel>();
        }
        
        public ActionResult Matricula()
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
                                      dataCancelamento = m.dataCancelamento,
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

            try
            {
                dbMatricula.Remover(matricula);
                dbMatricula.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {
                
                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Save(int numeroMatricula, int cmbPessoa_Value, int cmbResponsavel_Value, string txtGrauParentesco, string txtDataRegistro, string txtDataCancelamento, string txtTipo)
        {           

            Matricula matricula = new Matricula();
            Aluno aluno = new Aluno();
            Responsavel responsavel = new Responsavel();

            if (!String.IsNullOrEmpty(txtDataCancelamento))
            {
                matricula.dataCancelamento = Convert.ToDateTime(txtDataCancelamento);
            }            
            
            responsavel.idPessoa = cmbResponsavel_Value;
            responsavel.grauParentesco = txtGrauParentesco;
            
            aluno.idPessoa = cmbPessoa_Value;
            aluno.Responsavel = responsavel;
            aluno.statusFinanceiro = 0;
            aluno.statusPedagogico = 0;
            
            matricula.numeroMatricula = numeroMatricula;
            matricula.Aluno = aluno;
            matricula.dataRegistro = Convert.ToDateTime(txtDataRegistro);
            matricula.tipo = txtTipo;

            try
            {
                dbMatricula.Adicionar(matricula);
                dbMatricula.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                
            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }                

        }

        public string FindPreMatriculas()
        {
            List<Matricula> listaMatricula = dbMatricula.FindAll(x => x.tipo == "PreMatricula");

            foreach (Matricula m in listaMatricula)
            {
                m.Aluno = new Repositorio<Aluno>().FindOne(x => x.idAluno == m.idAluno);
                m.Aluno.Responsavel = new Repositorio<Responsavel>().FindOne(x => x.idResponsavel == m.Aluno.idResponsavel);
                m.Aluno.Pessoa = new Repositorio<Pessoa>().FindOne(x => x.idPessoa == m.Aluno.idPessoa);
                m.Aluno.Responsavel.Pessoa = new Repositorio<Pessoa>().FindOne(x => x.idPessoa == m.Aluno.Responsavel.idPessoa);
            }

            return "{matriculas:" + JSON.Serialize(listaMatricula) + ", totalReg:" + listaMatricula.Count() + "}";

        }

    }
}
