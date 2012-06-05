using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Ext.Net;
using System.Web.Services;
using Entity = Persistence.Entity;

namespace web.Controllers
{
    public class HomeController : Controller
    {

        private Repositorio<Entity.Menu> dbMenu;

        public HomeController()
        {
            dbMenu = new Repositorio<Entity.Menu>();
        }

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

        public ActionResult LayoutTeste()
        {
            return View();
        }

        [HttpPost]
        public string CarregaMenu(int idPerfil)
        {
            var listMenu = dbMenu.FindAll();
            var listGrupoMenu = listMenu.Where(x => x.perfis.Contains(idPerfil.ToString())).GroupBy(x => x.grupo);

            TreeNodeCollection nodes = new TreeNodeCollection(false);
            int i = 0;
            foreach (var m in listGrupoMenu)
            {
                i++;
                TreeNode nodex = new TreeNode();
                nodex.NodeID = i.ToString();
                nodex.Text = m.Key;
                nodex.Icon = Icon.Folder;
                var subMenus = listMenu.Where(x => x.grupo == m.Key);
                foreach(Entity.Menu me in subMenus)
                {
                    if (me.perfis.Contains(idPerfil.ToString()))
                    {
                        i++;
                        TreeNode subNode = new TreeNode();
                        subNode.NodeID = i.ToString();
                        subNode.Text = me.titulo;
                        subNode.Listeners.Click.Handler = String.Format("addTab('{0}','{1}','{2}');", me.nomeTab, me.url, me.titulo);
                        subNode.Icon = (Icon)Enum.Parse(typeof(Icon),me.icon);
                        subNode.Leaf = true;
                        nodex.Nodes.Add(subNode);
                    }
                }
                nodes.Add(nodex);
            }

            return nodes.ToJson();
        }


    }
}
