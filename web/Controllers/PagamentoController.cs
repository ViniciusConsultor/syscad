using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using Models = web.Models;
using Ext.Net;
using BoletoNet;
using System.Data.SqlClient;
using System.Data;

namespace web.Controllers
{
    public class PagamentoController : Controller
    {
        const string CONNECTIONSTR = @"Data Source=.\SQLEXPRESS;Initial Catalog=SysCad;Integrated Security=True;MultipleActiveResultSets=True";
        SqlConnection conn;
        private Repositorio<Aluno> dbAluno;
        private Repositorio<Matricula> dbMatricula;
        private Repositorio<Pessoa> dbPessoa;
        private Repositorio<Cobranca> dbCobranca;
        private IRepositorio<Pagamento> dbPagamento;

        public PagamentoController()
        {
            dbAluno = new Repositorio<Aluno>();
            dbMatricula = new Repositorio<Matricula>();
            dbPessoa = new Repositorio<Pessoa>();
            dbCobranca = new Repositorio<Cobranca>();
            dbPagamento = new Repositorio<Pagamento>();
            conn = new SqlConnection(CONNECTIONSTR);
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
                                                   where c.idAluno == idAluno && c.statusPagamento == 7
                                                   select new Models.Cobranca
                                                   {
                                                       idCobranca = c.idCobranca,
                                                       idAluno = c.idAluno,
                                                       idTaxa = c.idTaxa,
                                                       idCurso = c.idCurso,
                                                       juros = c.juros,
                                                       valorTotal = c.valorTotal,
                                                       dataVencimento = c.dataVencimento,
                                                       Taxa = new Models.Taxa
                                                       {
                                                           idTaxa = c.Taxa.idTaxa,
                                                           nome = c.Taxa.nome,
                                                           valor = c.Taxa.valor
                                                       },
                                                       Curso = new Models.Curso{
                                                           nome = c.Curso.nome,
                                                           valor = c.Curso.valor
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
            Pagamento p = new Pagamento();
            p.idCobranca = idCobranca;
            p.valor = valorPagar;
            p.formaPag = formaPag_Value;
            p.dataPagamento = DateTime.Now;

            try
            {
                //string sql = "INSERT INTO Pagamento (idCobranca,valor,formaPag) VALUES ({0},{1},{2})";
                //Object[] parameters = { idCobranca, valorPagar, formaPag_Value };
                //dbPagamento.Context.ExecuteStoreCommand(sql, parameters);

                dbPagamento.Adicionar(p);
                dbPagamento.SaveChanges();

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

        public ActionResult GerarBoleto(int idCobranca)
        {

            conn.Open();
            string sql = @"select nome, cpf, bairro, cep, cidade, uf, logradouro, numero, complemento, valorTotal, datavencimento, idCobranca, e.idEndereco from dbo.aluno a
                        join dbo.pessoa p on a.idPessoa = p.idPessoa
                        join dbo.cobranca c on a.idAluno = c.idAluno
                        left join dbo.endereco e on a.idPessoa = e.idPessoa and e.idTipoEndereco = 1
                        where idCobranca = @idCobranca";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            comm.Parameters.Add(new SqlParameter("@idCobranca", idCobranca));
            SqlDataReader dr = comm.ExecuteReader();
            Models.Cobranca cobranca = new Models.Cobranca();
            if (dr.Read())
            {                
                cobranca.valorTotal = dr.GetDecimal(9);
                cobranca.dataVencimento = dr.GetDateTime(10);
                cobranca.idCobranca = dr.GetInt32(11);
                Models.Aluno aluno = new Models.Aluno();
                aluno.nome = dr.GetString(0);
                aluno.cpf = dr.GetString(1);
                
                if (!dr.IsDBNull(12)){ 
                    aluno.Enderecos.Add(new Models.Endereco
                    {
                        bairro = dr.GetString(2),
                        CEP = dr.GetString(3),
                        cidade = dr.GetString(4),
                        uf = dr.GetString(5),
                        logradouro = dr.GetString(6),
                        numero = dr.GetInt32(7),
                        complemento = dr.GetString(8)
                    });
                }
                cobranca.Aluno = aluno;    
            }

            //HttpContext context = HttpContext.curre
            DateTime vencimento = cobranca.dataVencimento;
            Double valorBoleto = Convert.ToDouble(cobranca.valorTotal);
            string nossoNumero = cobranca.idCobranca.ToString().PadLeft(8, '0');

            Instrucao_Itau item1 = new Instrucao_Itau(9, 5);
            Instrucao_Itau item2 = new Instrucao_Itau(81, 10);
            Cedente c = new Cedente("10.668.613/0001-55", "V Mendonsa da Costa Idiomas e Informática", "4406", "22324");
            //Na carteira 198 o código do Cedente é a conta bancária
            c.Codigo = 13000;

            Boleto b = new Boleto(vencimento, valorBoleto, "176", nossoNumero, c, new EspecieDocumento(341, 1));
            b.NumeroDocumento = nossoNumero;

            b.Sacado = new Sacado(cobranca.Aluno.cpf, cobranca.Aluno.nome);
            if (cobranca.Aluno.Enderecos.Count > 0)
            {
                b.Sacado.Endereco.End = String.Format("{0}, {1} {2}", cobranca.Aluno.Enderecos.FirstOrDefault().logradouro, cobranca.Aluno.Enderecos.FirstOrDefault().numero, cobranca.Aluno.Enderecos.FirstOrDefault().complemento);
                b.Sacado.Endereco.Bairro = cobranca.Aluno.Enderecos.FirstOrDefault().bairro;
                b.Sacado.Endereco.Cidade = cobranca.Aluno.Enderecos.FirstOrDefault().cidade;
                b.Sacado.Endereco.CEP = cobranca.Aluno.Enderecos.FirstOrDefault().CEP;
                b.Sacado.Endereco.UF = cobranca.Aluno.Enderecos.FirstOrDefault().uf;
            }

            // Exemplo de como adicionar mais informações ao sacado
            //b.Sacado.InformacoesSacado.Add(new InfoSacado("TÍTULO: " + "2541245"));

            item2.Descricao += " " + item2.QuantidadeDias.ToString() + " dias corridos do vencimento.";
            b.Instrucoes.Add(item1);
            b.Instrucoes.Add(item2);

            // juros/descontos
            if (b.ValorDesconto == 0)
            {
                Instrucao_Itau item3 = new Instrucao_Itau(999, 1);
                item3.Descricao += ("1,00 por dia de antecipação.");
                b.Instrucoes.Add(item3);
            }

            BoletoBancario boletoBancario = new BoletoBancario();
            boletoBancario.CodigoBanco = 341;
            boletoBancario.OcultarEnderecoSacado = false;
            boletoBancario.OcultarReciboSacado = false;
            boletoBancario.OcultarInstrucoes = false;
            boletoBancario.Boleto = b;
            boletoBancario.Boleto.Valida();

            boletoBancario.MostrarComprovanteEntrega = false;
            boletoBancario.FormatoCarne = false;

            conn.Close();
            return View("Boleto",boletoBancario);
        }

        public ActionResult Recibo(int idCobranca)
        {
            conn.Open();
            string sql = @"select formaPag, p.valor as valorPago, t.nome as descTaxa, valorTotal, juros, t.valor as valorTaxa, pe.nome, 
                            m.numeroMatricula, cu.nome, cu.valor as valorCurso 
                            from dbo.pagamento p
                            join dbo.cobranca c on p.idCobranca = c.idCobranca
                            join dbo.aluno a on c.idAluno = a.idAluno
                            join dbo.pessoa pe on a.idPessoa = pe.idPessoa
                            join dbo.matricula m on m.idAluno = a.idAluno
                            left join dbo.curso cu on c.idCurso = cu.idCurso
                            left join dbo.taxa t on c.idTaxa = t.idTaxa
                            where c.idCobranca = @idCobranca";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            comm.Parameters.Add(new SqlParameter("@idCobranca", idCobranca));
            SqlDataReader dr = comm.ExecuteReader();
            List<Models.Pagamento> lstPagamento = new List<Models.Pagamento>();
            while (dr.Read())
            {
                Models.Pagamento p = new Models.Pagamento();
                p.formaPag = dr.GetInt32(0);
                p.valor = dr.GetDecimal(1);
                p.Cobranca = new Models.Cobranca
                {
                    valorTotal = dr.GetDecimal(3),
                    juros = dr.GetDecimal(4),
                    Taxa = new Models.Taxa
                    {
                        nome = !dr.IsDBNull(2) ? dr.GetString(2) : "",
                        valor = !dr.IsDBNull(5) ? dr.GetDecimal(5) : 0
                    },
                    Curso = new Models.Curso
                    {
                        valor = !dr.IsDBNull(9) ? dr.GetDecimal(9) : 0,
                        nome = !dr.IsDBNull(8) ? dr.GetString(8) : ""
                    },
                    Aluno = new Models.Aluno
                    {
                        nome = dr.GetString(6),
                        Matricula = new Models.Matricula
                        {
                            numeroMatricula = dr.GetInt32(7)
                        }
                    }
                };                
                lstPagamento.Add(p);
            }

            return View(lstPagamento);
        }

        public ActionResult ProcessarCobranca()
        {
            return View();
        }

        public JsonResult GeraCobranca(int idAluno, int mes)
        {
            conn.Open();
            try
            {
                var dataVencimento = new DateTime(DateTime.Now.Year, mes, 10); //Vencimento para todo dia 10
                string sql = @"INSERT INTO cobranca
                            SELECT null as idTaxa, a.idAluno, 7 as statusPagamento, c.valor, 0 as juros, @dataVencimento as dataVencimento, c.idCurso 
                            from aluno a
                            JOIN matricula m
                            ON a.idAluno = m.idAluno
                            JOIN matriculaTurma mt
                            ON m.idMatricula = mt.idMatricula
                            JOIN turma t
                            ON mt.idTurma = t.idTurma
                            JOIN curso c
                            on t.idCurso = c.idCurso and c.status = 4
                            WHERE a.idAluno = @idAluno AND NOT EXISTS(SELECT 1 FROM cobranca co
                            WHERE c.idCurso = co.idCurso 
                            and a.idAluno = co.idAluno
                            and MONTH(co.dataVencimento) = MONTH(@dataVencimento) 
                            and YEAR(co.dataVencimento) = YEAR(@dataVencimento))";
                SqlCommand comm = conn.CreateCommand();
                comm.CommandText = sql;
                comm.Parameters.Add(new SqlParameter("@dataVencimento", dataVencimento));
                comm.Parameters.Add(new SqlParameter("@idAluno", idAluno));
                comm.ExecuteNonQuery();

                return Json(new { success = true });

            }
            catch (Exception e)
            {
                return Json(new { success = false });
            }
            finally
            {
                conn.Close();
            }
        }

        public string CarregaAlunos(int mes)
        {
            conn.Open();
            string sql = @"SELECT a.idAluno, p.Nome, c.nome, c.valor
                            from aluno a
                            JOIN matricula m
                            ON a.idAluno = m.idAluno
                            JOIN matriculaTurma mt
                            ON m.idMatricula = mt.idMatricula
                            JOIN turma t
                            ON mt.idTurma = t.idTurma
                            JOIN curso c
                            on t.idCurso = c.idCurso and c.status = 4
                            JOIN pessoa p
                            on a.idPessoa = p.idPessoa
                            WHERE NOT EXISTS(SELECT 1 FROM cobranca co
                            WHERE c.idCurso = co.idCurso 
                            and a.idAluno = co.idAluno
                            and MONTH(co.dataVencimento) = @Mes 
                            and YEAR(co.dataVencimento) = YEAR(GetDate()))";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            comm.Parameters.Add(new SqlParameter("@Mes", mes));
            SqlDataReader dr = comm.ExecuteReader();
            IList<object> list = new List<object>();

            while (dr.Read())
            {
                var r = new
                {
                    idAluno = dr.GetInt32(0),
                    aluno = dr.GetString(1),
                    curso = dr.GetString(2),
                    valor = dr.GetDecimal(3),
                    situacao = "teste"
                };
                list.Add(r);
            }

            conn.Close();
            return "{ cobrancas:" + JSON.Serialize(list) +"}";
        }


    }
}
