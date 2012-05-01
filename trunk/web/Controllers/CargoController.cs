using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class CargoController : Controller
    {
        //
        // GET: /Cargo/

        public ActionResult Cargo()
        {
            return View();
        }

        IRepositorio<Cargo> dbCargo;
        public CargoController()
        {
            dbCargo = new Repositorio<Cargo>();
        }

        public JsonResult FindAll()
        {

            IList<Cargo> listaCargo = dbCargo.FindAll();
            return Json(new { cargos = listaCargo, totalReg = listaCargo.Count }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult Search(string limit, string query, string start)
        {

            IList<Cargo> listaCargo = dbCargo.FindAll().Where(x => x.nome.ToLower().Contains(query.ToLower())).ToList();
            return Json(new { cargos = listaCargo, totalReg = listaCargo.Count }, JsonRequestBehavior.AllowGet);

        }

    }
}
