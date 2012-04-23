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
    public class CursoController : Controller
    {
        IRepositorio<Curso> dbCurso;
        public CursoController()
        {
            dbCurso = new Repositorio<Curso>();
        }

        [HttpGet]
        public JsonResult FindAll()
        {

            IList<Curso> listaCurso = dbCurso.FindAll();

            return Json(new { cursos = listaCurso, totalReg = listaCurso.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtDescricao, string txtValor)
        {
            Curso curso = new Curso();
            curso.nome = txtNome;
            curso.descricao = txtDescricao;
            curso.valor = Convert.ToDecimal(txtValor);
            curso.status = 1;

            try
            {

                dbCurso.Adicionar(curso);
                dbCurso.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Editar(int idCurso, string Nome, string Descricao, string Valor)
        {

            Curso curso = dbCurso.FindOne(cur => cur.idCurso == idCurso);

            try
            {
                curso.nome = Nome;
                curso.descricao = Descricao;
                curso.valor = Convert.ToDecimal(Valor);
                dbCurso.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Excluir(int idCurso)
        {

            Curso curso = dbCurso.FindOne(cur => cur.idCurso == idCurso);

            try
            {
                dbCurso.Remover(curso);
                dbCurso.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

       
        public ActionResult Curso()
        {
            return View();
        }

        /*public ActionResult SubmitCurso(object sender, StoreSubmitDataEventArgs e, string formatType)
        {
            string format = formatType.ToString();

            XmlNode xml = e.Xml;

            this.Response.Clear();

            switch (format)
            {
                case "xml":
                    string strXml = xml.OuterXml;
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xml");
                    this.Response.AddHeader("Content-Length", strXml.Length.ToString());
                    this.Response.ContentType = "application/xml";
                    this.Response.Write(strXml);

                    break;
                case "xls":
                    this.Response.ContentType = "application/vnd.ms-excel";
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.xls");
                    XslCompiledTransform xtExcel = new XslCompiledTransform();
                    xtExcel.Load(Server.MapPath("Excel.xsl"));
                    xtExcel.Transform(xml, null, Response.OutputStream);

                    break;
                case "csv":
                    this.Response.ContentType = "application/octet-stream";
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=submittedData.csv");
                    XslCompiledTransform xtCsv = new XslCompiledTransform();
                    xtCsv.Load(Server.MapPath("Csv.xsl"));
                    xtCsv.Transform(xml, null, Response.OutputStream);

                    break;
            }

            this.Response.End();

            return View("Curso");
        }*/
    }
}
