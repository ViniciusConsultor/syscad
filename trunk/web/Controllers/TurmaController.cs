using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using System.Data;
using Ext.Net;
using System.Web.Services;

namespace web.Controllers
{
    public class TurmaController : Controller
    {
        //
        // GET: /Turma/

        IRepositorio<Turma> dbTurma;

        public TurmaController()
        {
            dbTurma = new Repositorio<Turma>();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult FecharTurma()
        {
            return View();
        }

        public string FindAll()
        {
            List<Turma> listaTurma = dbTurma.FindAll();
            return "{turmas:" + JSON.Serialize(listaTurma) + ", totalReg:" + listaTurma.Count() + "}";
            //return Json(new { pessoas = lstPessoa, totalReg = listaPessoa.Count }, JsonRequestBehavior.AllowGet);
        }

    }
}
