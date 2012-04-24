using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using System.Data;
using Ext.Net;
using System.Xml;
using System.Xml.Xsl;

namespace web.Controllers
{
    public class FuncionarioController : Controller
    {
        IRepositorio<Funcionario> dbFuncionario;
        public FuncionarioController()
        {
            dbFuncionario = new Repositorio<Funcionario>();
        }
        
        public ActionResult Funcionario()
        {
            return View();
        }

        [HttpGet]
        public JsonResult FindAll()
        {

            IList<Funcionario> listaFuncionario = dbFuncionario.FindAll();
            Funcionario funcionario = new Funcionario();
            listaFuncionario.Add(funcionario);

            return Json(new { funcionarios = listaFuncionario, totalReg = listaFuncionario.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Excluir(int idFuncionario)
        {

            Funcionario funcionario = dbFuncionario.FindOne(cur => cur.idFuncionario == idFuncionario);

            try
            {
                dbFuncionario.Remover(funcionario);
                dbFuncionario.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

    }
}
