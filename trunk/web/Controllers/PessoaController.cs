using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class PessoaController : Controller
    {
        //
        // GET: /Pessoa/

        public ActionResult Pessoa()
        {
            return View();
        }

        IRepositorio<Pessoa> dbPessoa;
        public PessoaController()
        {
            dbPessoa = new Repositorio<Pessoa>();
        }

        public JsonResult Search(string limit, string query, string start)
        {

            IList<Pessoa> listaPessoa = dbPessoa.FindAll().Where(x => x.nome.ToLower().Contains(query.ToLower())).ToList();
            return Json(new { pessoas = listaPessoa, totalReg = listaPessoa.Count }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult FindAll()
        {

            IList<Pessoa> listaPessoa = dbPessoa.FindAll();
            return Json(new { pessoas = listaPessoa, totalReg = listaPessoa.Count }, JsonRequestBehavior.AllowGet);

        }

    }
}
