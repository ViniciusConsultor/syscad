﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.Entity;
using Persistence.DAO;

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

        public ActionResult Curso() 
        {
            IRepositorio<Curso> dbCurso = new Repositorio<Curso>();
            IList<Curso> listaCurso = dbCurso.FindAll();
            return View(listaCurso);
        }

    }
}