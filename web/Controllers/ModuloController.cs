using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.Entity;
using Persistence.DAO;

namespace web.Controllers
{
    public class ModuloController : Controller
    {
        IRepositorio<Modulo> dbModulo;
        public ModuloController()
        {
            dbModulo = new Repositorio<Modulo>();
        }

        [HttpGet]
        public JsonResult FindAll()
        {

            IList<Modulo> listaModulo = dbModulo.FindAll();

            return Json(new { modulos = listaModulo, totalReg = listaModulo.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtTempoDuracao, string txtStatusModulo, string txtCurso)
        {
            Modulo modulo = new Modulo();
            modulo.nome = txtNome;
            modulo.tempoDuracao = Convert.ToInt32(txtTempoDuracao);
            modulo.statusModulo = Convert.ToInt32(txtStatusModulo);
            modulo.Curso = new Repositorio<Curso>().FindOne(x => x.idCurso == Convert.ToInt32(txtCurso));

            try
            {

                dbModulo.Adicionar(modulo);
                dbModulo.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }


       
        public ActionResult Modulo()
        {
            return View();
        }

    }
}
