using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.Entity;
using Persistence.DAO;
using Ext.Net;

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
            SiteMapNode siteNode = SiteMap.RootNode;
            TreeNode root = CreateNode(siteNode);
            root.Draggable = false;
            root.Expanded = true;
            return View(root);
        }

        //static node creation with children
        private Ext.Net.TreeNode CreateNode(SiteMapNode siteMapNode)
        {
            TreeNode treeNode = new TreeNode();

            treeNode.NodeID = siteMapNode.Key;
            treeNode.Text = siteMapNode.Title;
            treeNode.Qtip = siteMapNode.Description;
            treeNode.Listeners.Click.Handler = "addTab(#{TabPanel1},'idAba" + siteMapNode.Key + "','" + siteMapNode.Url + "','" + siteMapNode.Title + "')";


            SiteMapNodeCollection children = siteMapNode.ChildNodes;

            if (children != null && children.Count > 0)
            {
                foreach (SiteMapNode mapNode in siteMapNode.ChildNodes)
                {
                    treeNode.Nodes.Add(this.CreateNode(mapNode));
                }
            }

            return treeNode;
        }

    }
}
