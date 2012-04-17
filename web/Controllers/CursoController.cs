using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class CursoController : Controller
    {
        IRepositorio<Curso> dbCurso;
        public CursoController()
        {
            dbCurso = new Repositorio<Curso>();
        }

        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult FindAll()
        {

            IList<Curso> listaCurso = dbCurso.FindAll();

            return Json(new { cursos = listaCurso, totalReg = listaCurso.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtDescricao, string txtValor, string action)
        {
            Curso curso = new Curso();
            curso.nome = txtNome;
            curso.descricao = txtDescricao;
            curso.valor = Convert.ToDecimal(txtValor);
            curso.status = 1;
            try
            {
                if (action.Equals("insert"))
                {
                    dbCurso.Adicionar(curso);
                    dbCurso.SaveChanges();
                }

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);
            }

        }
    }
}
