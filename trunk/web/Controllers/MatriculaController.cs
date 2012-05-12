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
        IRepositorio<Matricula> dbMatricula;
        IRepositorio<Aluno> dbAluno;
        IRepositorio<Pessoa> dbPessoa;

        public MatriculaController()
        {
            dbMatricula = new Repositorio<Matricula>();
            dbAluno = new Repositorio<Aluno>();
            dbPessoa = new Repositorio<Pessoa>();
        }
        
        public ActionResult Matricula()
        {
            return View();
        }

        [HttpGet]
        public JsonResult FindAll()
        {

            IList<Matricula> listaMatricula = dbMatricula.FindAll();

            foreach (Matricula m in listaMatricula){
                m.Aluno = new Repositorio<Aluno>().FindOne(x => x.idAluno == m.idAluno);
                m.Aluno.Pessoa = new Repositorio<Pessoa>().FindOne(x => x.idPessoa == m.Aluno.idPessoa);
            }

            return Json(new { matriculas = listaMatricula, totalReg = listaMatricula.Count }, JsonRequestBehavior.AllowGet);
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
            //matricula.dataCancelamento = String.IsNullOrEmpty(dataCancelamento) ? Convert.ToDateTime(dataCancelamento) : null;
            matricula.tipo = txtTipo;

            //funcionario.Usuario = usuario;

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

        [HttpPost]
        public JsonResult Editar(int id, string campo, string valor)
        {

            Matricula matricula = dbMatricula.FindOne(mat => mat.idMatricula == id);

            try
            {

                switch (campo)
                {
                    case "Aluno.nome":

                        matricula.idAluno = Convert.ToInt32(valor);
                        break;

                    case "Matricula":

                        matricula.numeroMatricula = Convert.ToInt32(valor);
                        break;

                    case "DataRegistro":

                        matricula.dataRegistro = Convert.ToDateTime(valor);
                        break;

                    case "DataCancelamento":

                        matricula.dataCancelamento = Convert.ToDateTime(valor);
                        break;
                
                    case "Tipo":

                        matricula.tipo = valor;
                        break;

                }

                dbMatricula.Atualizar(matricula);
                dbMatricula.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

    }
}
