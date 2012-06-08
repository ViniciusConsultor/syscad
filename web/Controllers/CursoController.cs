using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

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

            IList<Curso> listaCurso = dbCurso.FindAll(x => x.status == 4); //Somente os cursos Ativos
            return Json(new { cursos = listaCurso, totalReg = listaCurso.Count }, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtDescricao, string txtValor)
        {
            Curso curso = new Curso();
            curso.nome = txtNome;
            curso.descricao = txtDescricao;
            curso.valor = Convert.ToDecimal(txtValor);
            curso.status = 4; //Status Ativo

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
        public JsonResult Editar(int id, string campo, string valor)
        {

            Curso curso = dbCurso.FindOne(cur => cur.idCurso == id);

            try
            {
                switch (campo)
                {
                    case "descricao":
                        curso.descricao = valor;
                        break;
                    case "nome":
                        curso.nome = valor;
                        break;
                    case "status":
                        curso.status = Convert.ToInt32(valor);
                        break;
                    case "valor":
                        curso.valor = Convert.ToDecimal(valor);
                        break;
                }

                dbCurso.Atualizar(curso);
                dbCurso.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Excluir(int id)
        {

            Curso curso = dbCurso.FindOne(cur => cur.idCurso == id);

            try
            {
                curso.status = 5; //Status Inativo
                dbCurso.Atualizar(curso);
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

        [HttpPost]
        public JsonResult Search(string limit, string query, string start)
        {

            IList<Curso> listaCurso = dbCurso.FindAll().Where(x => x.nome.ToLower().Contains(query.ToLower())).ToList();
            return Json(new { cursos = listaCurso, totalReg = listaCurso.Count }, JsonRequestBehavior.AllowGet);

        }

    }
}
