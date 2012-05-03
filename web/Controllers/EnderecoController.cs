using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class EnderecoController : Controller
    {

        IRepositorio<Endereco> dbEndereco;
        IRepositorio<Pessoa> dbPessoa;
        IRepositorio<TipoEndereco> dbTipoEndereco;

        public ActionResult Endereco()
        {
            return View();
        }

        public EnderecoController()
        {
            dbPessoa = new Repositorio<Pessoa>();
            dbEndereco = new Repositorio<Endereco>();
            dbTipoEndereco = new Repositorio<TipoEndereco>();

        }

        [HttpGet]
        public JsonResult FindEnderecos(int idPessoa)
        {
            IList<Endereco> listaEndereco = dbEndereco.FindAll().Where(end => end.idPessoa == idPessoa).ToList();

            foreach (Endereco e in listaEndereco)
            {
                e.Pessoa = dbPessoa.FindOne(pes => pes.idPessoa == e.idPessoa);
                e.TipoEndereco = dbTipoEndereco.FindOne(te => te.idTipoEndereco == e.idTipoEndereco);
            }

            return Json(new { enderecos = listaEndereco, totalReg = listaEndereco.Count }, JsonRequestBehavior.AllowGet);
        }

    }
}
