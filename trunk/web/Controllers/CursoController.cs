using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using System.Data;

namespace web.Controllers
{
    public class CursoController : Controller
    {
        IRepositorio<Curso> dbCurso;
        public CursoController()
        {
            dbCurso = new Repositorio<Curso>();
        }

        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult FindAll()
        {

            IList<Curso> listaCurso = dbCurso.FindAll();

            return Json(new { cursos = listaCurso, totalReg = listaCurso.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtDescricao, string txtValor, string action)
        {
            Curso curso = new Curso();
            curso.nome = txtNome;
            curso.descricao = txtDescricao;
            curso.valor = Convert.ToDecimal(txtValor);
            curso.status = 1;
            try
            {
                if (action.Equals("insert"))
                {
                    dbCurso.Adicionar(curso);
                    dbCurso.SaveChanges();
                }

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);
            }

        }

        [HttpGet]
        public JsonResult Curso()
        {
        
            DataTable table = new DataTable();

            table.Columns.AddRange(new DataColumn[] {
            new DataColumn("Company")   { ColumnName = "Company",    DataType = typeof(string) },
            new DataColumn("Price")     { ColumnName = "Price",      DataType = typeof(double) },
            new DataColumn("Change")    { ColumnName = "Change",     DataType = typeof(double) },
            new DataColumn("PctChange") { ColumnName = "PctChange",  DataType = typeof(double) },
            new DataColumn("PctChange") { ColumnName = "LastChange", DataType = typeof(DateTime) }
            });

            foreach (object[] obj in this.Data)
            {
                table.Rows.Add(obj);
            }

            //return table;

            return Json(new { dados = table }, JsonRequestBehavior.AllowGet);
        }

        private object[] Data
        {
            get
            {
                DateTime now = DateTime.Now;

                return new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, now },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, now },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, now },
                new object[] { "American Express Company", 52.55, 0.01, 0.02, now },
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, now },
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, now },
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71, now },
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, now },
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, now },
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, now },
                new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, now },
                new object[] { "General Electric Company", 34.14, -0.08, -0.23, now },
                new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, now },
                new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, now },
                new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, now },
                new object[] { "Intel Corporation", 19.88, 0.31, 1.58, now },
                new object[] { "International Business Machines", 81.41, 0.44, 0.54, now },
                new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, now },
                new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, now },
                new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, now },
                new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, now },
                new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, now },
                new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, now },
                new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, now },
                new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, now },
                new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, now },
                new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, now },
                new object[] { "Verizon Communications", 35.57, 0.39, 1.11, now },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, now }
            };
            }
        }
    }
}
