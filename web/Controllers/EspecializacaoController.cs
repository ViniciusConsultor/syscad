using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class EspecializacaoController : Controller
    {
        //
        // GET: /Especializacao/

        IRepositorio<Especializacao> dbEspecializacao;
        IRepositorio<FuncionarioEspecializacao> dbFuncionarioEspecializacao;
        IRepositorio<Funcionario> dbFuncionario;

        public ActionResult Especializacao()
        {
            return View();
        }

        public EspecializacaoController()
        {
            dbEspecializacao = new Repositorio<Especializacao>();
            dbFuncionario = new Repositorio<Funcionario>();
            dbFuncionarioEspecializacao = new Repositorio<FuncionarioEspecializacao>();
        }

        [HttpGet]
        public JsonResult FindAllFuncionario(int idFuncionario)
        {
            Funcionario funcionario = dbFuncionario.FindOne(x => x.idFuncionario == idFuncionario);
            List<FuncionarioEspecializacao> listaFuncionarioEspecializacao = new List<FuncionarioEspecializacao>();
            if (funcionario != null)
            {
                listaFuncionarioEspecializacao = dbFuncionarioEspecializacao.FindAll(x => x.idFuncionario == funcionario.idFuncionario);

                foreach (FuncionarioEspecializacao fe in listaFuncionarioEspecializacao)
                {
                    fe.Funcionario = dbFuncionario.FindOne(x => x.idFuncionario == fe.idFuncionario);
                    fe.Especializacao = dbEspecializacao.FindOne(x => x.idEspecializacao == fe.idEspecializacao);
                }
            }

            return Json(new { especializacoes = listaFuncionarioEspecializacao, totalReg = listaFuncionarioEspecializacao.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult FindAll()
        {
            List<Especializacao> listaEspecializacao = dbEspecializacao.FindAll();
            return Json(new { especializacoes = listaEspecializacao, totalReg = listaEspecializacao.Count }, JsonRequestBehavior.AllowGet);
        }

        
        [HttpPost]
        public JsonResult Save(string txtNome)
        {
            Especializacao especializacao = new Especializacao();
            especializacao.nome = txtNome;

            try
            {
                dbEspecializacao.Adicionar(especializacao);
                dbEspecializacao.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);
            }
            
        }

        [HttpPost]
        public JsonResult SaveProfessorEspecializacao(int idEspecializacao, int cmbProfessor_value)
        {
            FuncionarioEspecializacao especializacao = new FuncionarioEspecializacao();
            especializacao.idEspecializacao = idEspecializacao;
            especializacao.idFuncionario = cmbProfessor_value;

            try
            {
                dbFuncionarioEspecializacao.Adicionar(especializacao);
                dbFuncionarioEspecializacao.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);
            }

        }
                        
        [HttpPost]
        public JsonResult ExcluirProfessorEspecializacao(int id)
        {
            FuncionarioEspecializacao funcionarioEspecializacao = dbFuncionarioEspecializacao.FindOne(f => f.idFuncionarioEspecializacao == id);

            try
            {
                dbFuncionarioEspecializacao.Remover(funcionarioEspecializacao);
                dbFuncionarioEspecializacao.SaveChanges();

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
            Especializacao especializacao = dbEspecializacao.FindOne(f => f.idEspecializacao == id);
            List<FuncionarioEspecializacao> funEsp = dbFuncionarioEspecializacao.FindAll(x => x.idEspecializacao == id);
            try
            {
                dbEspecializacao.Remover(especializacao);
                dbEspecializacao.SaveChanges();

                foreach(FuncionarioEspecializacao fe in funEsp){
                    dbFuncionarioEspecializacao.Remover(fe);
                    dbFuncionarioEspecializacao.SaveChanges();
                }

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

            Especializacao especialicao = dbEspecializacao.FindOne(fun => fun.idEspecializacao == id);

            try
            {

                switch (campo)
                {
                    case "nome":
                        especialicao.nome = valor;
                        break;
                }

                dbEspecializacao.Atualizar(especialicao);
                dbEspecializacao.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }



    }
}
