using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using Models = web.Models;
using Ext.Net;

namespace web.Controllers
{
    public class PagamentoController : Controller
    {
        private Repositorio<Aluno> dbAluno;
        private Repositorio<Matricula> dbMatricula;
        private Repositorio<Pessoa> dbPessoa;
        private Repositorio<Cobranca> dbCobranca;
        private Repositorio<Pagamento> dbPagamento;
        public PagamentoController()
        {
            dbAluno = new Repositorio<Aluno>();
            dbMatricula = new Repositorio<Matricula>();
            dbPessoa = new Repositorio<Pessoa>();
            dbCobranca = new Repositorio<Cobranca>();
            dbPagamento = new Repositorio<Pagamento>();
        }
        public ActionResult RealizarPagamento()
        {
            return View();
        }

        public JsonResult Search(string limit, string query, string start)
        {
            int matricula;
            int.TryParse(query, out matricula);

            List<Models.Aluno> listaAluno = (from a in dbAluno.Context.Aluno
                                             where a.Pessoa.nome.ToLower().Contains(query.ToLower()) || a.Matriculas.FirstOrDefault().numeroMatricula == matricula
                                             select new Models.Aluno
                                             {
                                                 nome = a.Pessoa.nome,
                                                 cpf = a.Pessoa.cpf,
                                                 email = a.Pessoa.email,
                                                 idAluno = a.idAluno,
                                                 //Matriculas = a.Matriculas.Select(x => new Models.Matricula { 
                                                 //   idMatricula = x.idMatricula
                                                 //}).ToList()

                                             }).ToList();

            return Json(new { alunos = listaAluno, totalReg = listaAluno.Count() }, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public string FindAllCobrancas(int idAluno)
        {

            List<Models.Cobranca> listaCobranca = (from c in dbCobranca.Context.Cobranca
                                                   where c.idAluno == idAluno
                                                   select new Models.Cobranca
                                                   {
                                                       idCobranca = c.idCobranca,
                                                       idAluno = c.idAluno,
                                                       idTaxa = c.idTaxa,
                                                       juros = c.juros,
                                                       valorTotal = c.valorTotal,
                                                       dataVencimento = c.dataVencimento,
                                                       Taxa = new Models.Taxa
                                                       {
                                                           idTaxa = c.Taxa.idTaxa,
                                                           nome = c.Taxa.nome,
                                                           valor = c.Taxa.valor
                                                       },
                                                       Aluno = new Models.Aluno
                                                       {
                                                           nome = c.Aluno.Pessoa.nome
                                                       },
                                                       valorPago = c.Pagamentos.Sum(x => x.valor),
                                                       valorFaltante = c.valorTotal - c.Pagamentos.Sum(x => x.valor)
                                                   }).ToList();
            string jsonResult = JSON.Serialize(listaCobranca);
            return "{cobrancas:" + jsonResult + ", totalReg:" + listaCobranca.Count() + " }";
        }

        public JsonResult Pagar(int idCobranca, decimal valorPagar, int formaPag_Value)
        {
            string mensagem;
            try
            {
                string sql = "INSERT INTO Pagamento (idCobranca,valor,formaPag) VALUES ({0},{1},{2})";
                Object[] parameters = { idCobranca, valorPagar, formaPag_Value };
                dbPagamento.Context.ExecuteStoreCommand(sql, parameters);

                mensagem = "Pagamento realizado com sucesso!";
            }
            catch(Exception e)
            {
                mensagem = "Erro: " + e.Message; 
            }

            return Json(new { success= true, message = mensagem });
        }

        public JsonResult MudarStatus(int idCobranca, int status)
        {
            Cobranca c = dbCobranca.FindOne(x => x.idCobranca == idCobranca);
            c.statusPagamento = status;
            dbCobranca.Atualizar(c);
            dbCobranca.SaveChanges();

            return Json(new { success = true });
        }
    }
}
