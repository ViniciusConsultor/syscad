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

        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult FindAll()
        {
            IRepositorio<Curso> dbCurso = new Repositorio<Curso>();
            IList<Curso> listaCurso = dbCurso.FindAll();

            return Json(new {cursos = listaCurso, totalReg = listaCurso.Count},JsonRequestBehavior.AllowGet);
        }

        public ActionResult Create()
        {
            return View();
        }
    }
}
