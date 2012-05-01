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
        public JsonResult Save(string txtNome, int txtTempoDuracao, int txtStatusModulo, int cmbCurso_Value)
        {
            Modulo modulo = new Modulo();
            modulo.nome = txtNome;
            modulo.tempoDuracao = txtTempoDuracao;
            modulo.statusModulo = txtStatusModulo;
            modulo.idCurso = cmbCurso_Value;

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
        public JsonResult Editar(int id, string campo, string valor)
        {

            Modulo modulo = dbModulo.FindOne(mod => mod.idModulo == id);

            try
            {

                switch (campo)
                {
                    case "nome":

                        modulo.nome = valor;
                        break;

                    case "tempoDuracao":

                        modulo.tempoDuracao = Convert.ToInt32(valor);
                        break;

                    case "statusModulo":
                        modulo.statusModulo = Convert.ToInt32(valor);
                        break;

                    case "Curso.nome":
                        modulo.idCurso = Convert.ToInt32(valor);
                        break;

                }

                dbModulo.Atualizar(modulo);
                dbModulo.SaveChanges();

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

            Modulo modulo = dbModulo.FindOne(x => x.idModulo == id);

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
