using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using System.Data;
using Ext.Net;
using System.Xml;
using System.Xml.Xsl;

namespace web.Controllers
{
    public class CursoController : Controller
    {
        IRepositorio<Curso> dbCurso;
        public CursoController()
        {
            dbCurso = new Repositorio<Curso>();
        }

        [HttpGet]
        public JsonResult FindAll()
        {

            IList<Curso> listaCurso = dbCurso.FindAll();
            Curso curso = new Curso();
            listaCurso.Add(curso);

            return Json(new { cursos = listaCurso, totalReg = listaCurso.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtDescricao, string txtValor)
        {
            Curso curso = new Curso();
            curso.nome = txtNome;
            curso.descricao = txtDescricao;
            curso.valor = Convert.ToDecimal(txtValor);
            curso.status = 1;

            try
            {

                dbCurso.Adicionar(curso);
                dbCurso.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Editar(int idCurso, string Nome, string Descricao, string Valor)
        {

            Curso curso = dbCurso.FindOne(cur => cur.idCurso == idCurso);

            try
            {
                curso.nome = Nome;
                curso.descricao = Descricao;
                curso.valor = Convert.ToDecimal(Valor);
                dbCurso.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Excluir(int idCurso)
        {

            Curso curso = dbCurso.FindOne(cur => cur.idCurso == idCurso);

            try
            {
                dbCurso.Remover(curso);
                dbCurso.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

       
        public ActionResult Curso()
        {
            return View();
        }

    }
}
