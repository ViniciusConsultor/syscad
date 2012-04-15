using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.Entity;
using Persistence.DAO;

namespace web.Controllers
{
    public class UsuarioController : Controller
    {
        //
        // GET: /Usuario/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult BuscarUsuario(int id)
        {
            IRepositorio<Usuario> dbUsuario = new Repositorio<Usuario>();
            Usuario usuario = dbUsuario.FindOne(x => x.idUsuario == id);
            return View(usuario);
        }

    }
}
