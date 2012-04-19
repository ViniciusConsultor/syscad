using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.Entity;
using Persistence.DAO;
using Ext.Net;
using System.Web.Services;

namespace web.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
           return View();
        }

        public ActionResult Inicial()
        {
            return View();
        }

        public ActionResult Layout()
        {
            return View();
        }

    }
}
