using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class PagamentoController : Controller
    {
        private Repositorio<Aluno> dbAluno;
        private Repositorio<Matricula> dbMatricula;
        private Repositorio<Pessoa> dbPessoa;
        public PagamentoController()
        {
            dbAluno = new Repositorio<Aluno>();
            dbMatricula = new Repositorio<Matricula>();
            dbPessoa = new Repositorio<Pessoa>();
        }
        public ActionResult RealizarPagamento()
        {
            return View();
        }

        public JsonResult Search(string limit, string query, string start)
        {
            int matricula;
            Matricula mat = new Matricula();
            Pessoa p = new Pessoa();
            if (int.TryParse(query, out matricula))
            {
                mat = dbMatricula.FindOne(x => x.idMatricula == matricula);
            }

            List<Pessoa> listaAluno = (from a in dbAluno.Context.Aluno where a.Pessoa.nome.ToLower().Contains(query.ToLower()) select a.Pessoa).ToList();
                //dbAluno.Context.Pessoa.Include("Alunos").Where(x => x.nome.ToLower().Contains(query.ToLower())).ToList();
            //dbAluno.FindAll().Where(x => x.Pessoa.Equals(p) || x.Matriculas.Contains(mat)).ToList();
            return Json(new { alunos = listaAluno, totalReg = listaAluno.Count() }, JsonRequestBehavior.AllowGet);

        }
    }
}
