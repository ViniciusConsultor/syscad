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
            if (int.TryParse(query, out matricula))
            {
                mat = dbMatricula.FindOne(x => x.idMatricula == matricula);
            }

            List<Aluno> listaAluno = (from a in dbAluno.Context.Aluno where a.Pessoa.nome.ToLower().Contains(query.ToLower()) || a.Matriculas.FirstOrDefault().idMatricula == matricula select a).ToList();
            foreach(Aluno a in listaAluno)
            {
                a.Pessoa = (from p in dbPessoa.Context.Pessoa where p.Alunos.FirstOrDefault().idAluno == a.idAluno select p).FirstOrDefault();
            }
            return Json(new { alunos = listaAluno, totalReg = listaAluno.Count() }, JsonRequestBehavior.AllowGet);

        }
    }
}
