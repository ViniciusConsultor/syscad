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

        IRepositorio<Cargo> dbCargo;

        public ActionResult Cargo()
        {
            return View();
        }

        public CargoController()
        {
            dbCargo = new Repositorio<Cargo>();
        }

        [HttpGet]
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

        [HttpPost]
        public JsonResult Excluir(int id)
        {

            Cargo cargo = dbCargo.FindOne(car => car.idCargo == id);

            try
            {
                dbCargo.Remover(cargo);
                dbCargo.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtDescricao)
        {
            Cargo cargo = new Cargo();
            cargo.nome = txtNome;
            cargo.descricao = txtDescricao;

            try
            {

                dbCargo.Adicionar(cargo);
                dbCargo.SaveChanges();

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

            Cargo cargo = dbCargo.FindOne(car => car.idCargo == id);

            try
            {
                switch (campo)
                {
                    
                    case "descricao":
                        cargo.descricao = valor;
                        break;
                    case "nome":
                        cargo.nome = valor;
                        break;

                }

                dbCargo.Atualizar(cargo);
                dbCargo.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

    }
}
