using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using System.Data;
using Ext.Net;
using System.Web.Services;

namespace web.Controllers
{
    public class PessoaController : Controller
    {
        //
        // GET: /Pessoa/

        public ActionResult Pessoa()
        {
            return View();
        }

        Repositorio<Pessoa> dbPessoa;

        public PessoaController()
        {
            dbPessoa = new Repositorio<Pessoa>();
        }

        public JsonResult Search(string limit, string query, string start)
        {

            IList<Pessoa> listaPessoa = dbPessoa.FindAll().Where(x => x.nome.ToLower().Contains(query.ToLower())).ToList();
            return Json(new { pessoas = listaPessoa, totalReg = listaPessoa.Count }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult PessoaAluno(string limit, string query, string start)
        {

            var listaPessoa = (from p in dbPessoa.Context.Pessoa where (p.nome.ToLower().Contains(query.ToLower()) || query.ToLower() == "") && p.Funcionarios.Count() == 0 select p).ToList();
            return Json(new { pessoas = listaPessoa, totalReg = listaPessoa.Count }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult PessoaResponsavel(string limit, string query, string start)
        {

            var listaPessoa = (from p in dbPessoa.Context.Pessoa where (p.nome.ToLower().Contains(query.ToLower()) || query.ToLower() == "") && p.Funcionarios.Count() == 0 && p.Alunos.Count() == 0 select p).ToList();
            return Json(new { pessoas = listaPessoa, totalReg = listaPessoa.Count }, JsonRequestBehavior.AllowGet);

        }


        public string FindAll()
        {
           
            List<Pessoa> listaPessoa = dbPessoa.FindAll();
            return "{pessoas:"+ JSON.Serialize(listaPessoa) +", totalReg:"+ listaPessoa.Count() +"}";
            //return Json(new { pessoas = lstPessoa, totalReg = listaPessoa.Count }, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult Excluir(int id)
        {

            Pessoa pessoa = dbPessoa.FindOne(pes => pes.idPessoa == id);

            try
            {
                dbPessoa.Remover(pessoa);
                dbPessoa.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Save(string txtNome, string txtCpf, string txtEmail, string txtTelefone, string txtCelular, string dtnascimento, int txtSexo_Value)
        {
            Pessoa pessoa = new Pessoa();
            pessoa.nome = txtNome;
            pessoa.cpf = txtCpf;
            pessoa.email = txtEmail;
            pessoa.telefone = txtTelefone;
            pessoa.celular = txtCelular;
            pessoa.dataNascimento = Convert.ToDateTime(dtnascimento);
            pessoa.sexo = txtSexo_Value;

            try
            {

                dbPessoa.Adicionar(pessoa);
                dbPessoa.SaveChanges();

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

            Pessoa pessoa = dbPessoa.FindOne(pes => pes.idPessoa == id);

            try
            {
                switch (campo)
                {
                    case "nome":
                        pessoa.nome = valor;
                        break;
                    case "cpf":
                        pessoa.cpf = valor;
                        break;
                    case "email":
                        pessoa.email = valor;
                        break;
                    case "telefone":
                        pessoa.telefone = valor;
                        break;
                    case "celular":
                        pessoa.celular = valor;
                        break;
                    case "dataNascimento":
                        pessoa.dataNascimento = Convert.ToDateTime(valor);
                        break;
                    case "sexo":
                        pessoa.sexo = Convert.ToInt32(valor);
                        break;
                }

                dbPessoa.Atualizar(pessoa);
                dbPessoa.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

    }
}
