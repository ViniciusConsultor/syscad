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

            foreach (Modulo m in listaModulo)
            {
                m.Curso = new Repositorio<Curso>().FindOne(x => x.idCurso == m.idCurso);
            }

            return Json(new { modulos = listaModulo, totalReg = listaModulo.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(string txtNome, int txtTempoDuracao, int txtStatusModulo, int txtIdCurso_Value)
        {
            Modulo modulo = new Modulo();
            modulo.nome = txtNome;
            modulo.tempoDuracao = txtTempoDuracao;
            modulo.statusModulo = txtStatusModulo;
           //modulo.Curso = new Repositorio<Curso>().FindOne(x => x.idCurso == txtIdCurso_Value);
            modulo.idCurso = txtIdCurso_Value;

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


        [HttpPost]
        public JsonResult Editar(int idModulo, string Nome, int tempoDuracao, int statusModulo, int idCurso)
        {

            Modulo modulo = dbModulo.FindOne(x => x.idModulo == idModulo);

            try
            {
                modulo.idModulo = idModulo;
                modulo.nome = Nome;
                modulo.tempoDuracao = tempoDuracao;
                modulo.statusModulo = statusModulo;
                modulo.idCurso = idCurso;
                dbModulo.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Excluir(int idModulo)
        {

            Modulo modulo = dbModulo.FindOne(x => x.idModulo == idModulo);

            try
            {
                dbModulo.Remover(modulo);
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
            ViewData["teste"] = "leonardo";
            return View();
        }

    }
}
