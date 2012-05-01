using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class PerfilController : Controller
    {
        //
        // GET: /Perfil/

        public ActionResult Index()
        {
            return View();
        }

        IRepositorio<Perfil> dbPerfil;
        public PerfilController()
        {
            dbPerfil = new Repositorio<Perfil>();
        }

        public JsonResult FindAll()
        {

            IList<Perfil> listaPerfil = dbPerfil.FindAll();
            return Json(new { perfis = listaPerfil, totalReg = listaPerfil.Count }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult Search(string limit, string query, string start)
        {

            IList<Perfil> listaPerfil = dbPerfil.FindAll().Where(x => x.nome.ToLower().Contains(query.ToLower())).ToList();
            return Json(new { perfis = listaPerfil, totalReg = listaPerfil.Count }, JsonRequestBehavior.AllowGet);

        }


    }
}
