using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class TipoEnderecoController : Controller
    {
        IRepositorio<TipoEndereco> dbTipoEndereco;

        public TipoEnderecoController()
        {
            dbTipoEndereco = new Repositorio<TipoEndereco>();
        }
        
        public ActionResult TipoEndereco()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Search(string limit, string query, string start)
        {

            IList<TipoEndereco> listaTipoEndereco = dbTipoEndereco.FindAll().Where(x => x.nome.ToLower().Contains(query.ToLower())).ToList();
            return Json(new { tipoEnderecos = listaTipoEndereco, totalReg = listaTipoEndereco.Count }, JsonRequestBehavior.AllowGet);

        }
    }
}
