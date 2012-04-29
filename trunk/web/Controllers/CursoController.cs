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
        public JsonResult Editar(int idCurso, string campo, string valor)
        {

            Curso curso = dbCurso.FindOne(cur => cur.idCurso == idCurso);

            try
            {
                switch (campo)
                {
                    case "descricao":
                        curso.descricao = valor;
                        break;
                    case "nome":
                        curso.nome = valor;
                        break;
                    case "status":
                        curso.status = Convert.ToInt32(valor);
                        break;

                }

                dbCurso.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Excluir(int id)
        {

            Curso curso = dbCurso.FindOne(cur => cur.idCurso == id);

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
