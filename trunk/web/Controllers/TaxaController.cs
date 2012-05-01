using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.Entity;
using Persistence.DAO;

namespace web.Controllers
{
    public class TaxaController : Controller
    {

        IRepositorio<Taxa> dbTaxa;

        public TaxaController()
        {
            dbTaxa = new Repositorio<Taxa>();
        }

        public ActionResult Taxa()
        {
            return View();
        }

        [HttpGet]
        public JsonResult FindAll()
        {
            IList<Taxa> listaTaxas = dbTaxa.FindAll();
            return Json(new { taxas = listaTaxas, totalReg = listaTaxas.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtDescricao, string txtValor)
        {
            Taxa taxa = new Taxa();
            taxa.nome = txtNome;
            taxa.descricao = txtDescricao;
            taxa.valor = Convert.ToDecimal(txtValor);

            try
            {

                dbTaxa.Adicionar(taxa);
                dbTaxa.SaveChanges();

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

            Taxa taxa = dbTaxa.FindOne(cur => cur.idTaxa == id);

            try
            {
                dbTaxa.Remover(taxa);
                dbTaxa.SaveChanges();

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

            Taxa taxa = dbTaxa.FindOne(cur => cur.idTaxa == id);

            try
            {
                switch (campo)
                {
                    case "descricao":
                        taxa.descricao = valor;
                        break;
                    case "nome":
                        taxa.nome = valor;
                        break;
                    case "valor":
                        taxa.valor = Convert.ToInt32(valor);
                        break;

                }

                dbTaxa.Atualizar(taxa);
                dbTaxa.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

    }
}
