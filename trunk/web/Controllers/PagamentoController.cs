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

        public ActionResult BaixaBoleto()
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

            conn.Open();
            string sql = @"select c.idCobranca, c.idAluno, isnull(c.idTaxa,0) as idTaxa, c.idCurso, 
                            case when GETDATE() > c.dataVencimento then DATEDIFF(d,c.dataVencimento,GETDATE()) * (c.valorTotal * 0.02) ELSE c.juros END AS juros, 
                            c.valorTotal, c.dataVencimento, t.nome as nomeTaxa, t.valor as valorTaxa, cu.nome as nomeCurso,
                            cu.valor as valorCurso, p.nome as nomeAluno, SUM(pag.valor) as valorPago, (c.valorTotal + c.juros) - SUM(pag.valor) as valorFaltante 
                            from aluno a
                            join cobranca c
                            on a.idAluno = c.idAluno
                            join pessoa p
                            on a.idPessoa = p.idPessoa
                            left join curso cu
                            on c.idCurso = cu.idCurso
                            left join taxa t
                            on c.idTaxa = c.idTaxa
                            left join pagamento pag
                            on c.idCobranca = pag.idCobranca
                            WHERE a.idAluno = @idAluno and c.statusPagamento = @status
                            group by c.idCobranca, c.idAluno, c.idTaxa, c.idCurso, c.juros, c.valorTotal, 
                            c.dataVencimento, t.nome, t.valor, cu.nome, cu.valor, p.nome";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            comm.Parameters.Add(new SqlParameter("@idAluno", idAluno));
            comm.Parameters.Add(new SqlParameter("@status", EnumStatus.NaoPago));
            SqlDataReader dr = comm.ExecuteReader();

            List<Models.Cobranca> listaCobranca = new List<Models.Cobranca>();

            while (dr.Read())
            {

                Models.Cobranca cob = new Models.Cobranca();

                cob.idCobranca = dr.GetInt32(0);
                cob.idAluno = dr.GetInt32(1);
                cob.idTaxa = dr.GetInt32(2);
                cob.idCurso = dr.GetInt32(3);
                cob.juros = dr.GetDecimal(4);
                cob.valorTotal = dr.GetDecimal(5);
                cob.dataVencimento = dr.GetDateTime(6);
                cob.Taxa = new Models.Taxa
                {
                    idTaxa = dr.GetInt32(2),
                    nome = dr.IsDBNull(7) ? "" : dr.GetString(7),
                    valor = dr.IsDBNull(8) ? 0 : dr.GetDecimal(8)
                };

                cob.Curso = new Models.Curso
                {
                    nome = dr.GetString(9),
                    valor = dr.GetDecimal(10)
                };

                cob.Aluno = new Models.Aluno
                {
                    nome = dr.GetString(11)
                };

                cob.valorPago = dr.IsDBNull(12) ? (decimal?)null : dr.GetDecimal(12);
                cob.valorFaltante = dr.IsDBNull(13) ? (decimal?)null : dr.GetDecimal(13);

                listaCobranca.Add(cob);
            }

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
                dbPagamento.Adicionar(p);
                dbPagamento.SaveChanges();

                var cob = dbCobranca.FindOne(x => x.idCobranca == idCobranca);
                var juros = DateTime.Now > cob.dataVencimento ? (DateTime.Now.Day - cob.dataVencimento.Day) * (cob.valorTotal * 0.02m) : 0;
                cob.juros = juros;
                dbCobranca.Atualizar(cob);
                dbCobranca.SaveChanges();

                mensagem = "Pagamento realizado com sucesso!";
                return Json(new { success = true, message = mensagem });
            }
            catch(Exception e)
            {
                mensagem = "Erro: " + e.Message;
                return Json(new { success = false, message = mensagem });
            }

        }

        public JsonResult PagarBoleto(int idCobranca, decimal valorPagar, int formaPag_Value)
        {
            string mensagem;
            Pagamento p = new Pagamento();
            p.idCobranca = idCobranca;
            p.valor = valorPagar;
            p.formaPag = formaPag_Value;
            p.dataPagamento = DateTime.Now;

            try
            {
                dbPagamento.Adicionar(p);
                dbPagamento.SaveChanges();

                var cob = dbCobranca.FindOne(x => x.idCobranca == idCobranca);
                var juros = DateTime.Now > cob.dataVencimento ? (DateTime.Now.Day - cob.dataVencimento.Day) * (cob.valorTotal * 0.02m) : 0;
                cob.juros = juros;
                cob.statusPagamento = (int)EnumStatus.Pago;
                dbCobranca.Atualizar(cob);
                dbCobranca.SaveChanges();

                mensagem = "Pagamento realizado com sucesso!";
                return Json(new { success = true, message = mensagem });
            }
            catch (Exception e)
            {
                mensagem = "Erro: " + e.Message;
                return Json(new { success = false, message = mensagem });
            }

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
            string sql = @"select p.nome, p.cpf, p.dataNascimento, bairro, cep, cidade, uf, logradouro, numero, complemento, 
                            (c.valorTotal + (case when GETDATE() > c.dataVencimento then DATEDIFF(d,c.dataVencimento,GETDATE()) * (c.valorTotal * 0.02) ELSE c.juros END)) AS valorTotal, 
                            datavencimento, idCobranca, e.idEndereco, pr.nome, pr.cpf from dbo.aluno a
                            join dbo.pessoa p on a.idPessoa = p.idPessoa
                            join dbo.cobranca c on a.idAluno = c.idAluno
                            left join dbo.endereco e on a.idPessoa = e.idPessoa and e.idTipoEndereco = 1
                            left join dbo.responsavel r on a.idResponsavel = r.idResponsavel
                            left join dbo.pessoa pr on r.idPessoa = pr.idPessoa
                            where idCobranca = @idCobranca";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            comm.Parameters.Add(new SqlParameter("@idCobranca", idCobranca));
            SqlDataReader dr = comm.ExecuteReader();
            Models.Cobranca cobranca = new Models.Cobranca();
            if (dr.Read())
            {                
                cobranca.valorTotal = dr.GetDecimal(10);
                cobranca.dataVencimento = dr.GetDateTime(11);
                cobranca.idCobranca = dr.GetInt32(12);
                Models.Aluno aluno = new Models.Aluno();
                aluno.nome = dr.GetString(0);
                aluno.cpf = dr.GetString(1);
                aluno.dataNascimento = dr.GetDateTime(2);

                TimeSpan data = DateTime.Now - aluno.dataNascimento;

                if (Math.Round(data.TotalDays / 360) < 18)
                {
                    aluno.Responsavel = new Models.Responsavel
                    {
                        nome = dr.GetString(14),
                        cpf = dr.GetString(15)
                    };
                }
                
                if (!dr.IsDBNull(12)){ 
                    aluno.Enderecos.Add(new Models.Endereco
                    {
                        bairro = dr.GetString(3),
                        CEP = dr.GetString(4),
                        cidade = dr.GetString(5),
                        uf = dr.GetString(6),
                        logradouro = dr.GetString(7),
                        numero = dr.GetInt32(8),
                        complemento = dr.GetString(9)
                    });
                }
                cobranca.Aluno = aluno;    
            }

            //HttpContext context = HttpContext.curre
            DateTime vencimento = cobranca.dataVencimento;
            Double valorBoleto = Convert.ToDouble(cobranca.valorTotal);
            string nossoNumero = cobranca.idCobranca.ToString().PadLeft(8, '0');

            //Instrucao_Itau item1 = new Instrucao_Itau(9, 5);
           // Instrucao_Itau item2 = new Instrucao_Itau(81, 10);
            Cedente c = new Cedente("10.668.613/0001-55", "V Mendonsa da Costa Idiomas e Informática", "4406", "22324");
            //Na carteira 198 o código do Cedente é a conta bancária
            c.Codigo = 13000;

            Boleto b = new Boleto(vencimento, valorBoleto, "176", nossoNumero, c, new EspecieDocumento(341, 1));
            b.NumeroDocumento = nossoNumero;

            TimeSpan dt = DateTime.Now - cobranca.Aluno.dataNascimento;
            var idade = Math.Round(dt.TotalDays / 360);
            if (idade < 18)
            {
                b.Sacado = new Sacado(cobranca.Aluno.Responsavel.cpf, cobranca.Aluno.Responsavel.nome);
            }
            else
            {
                b.Sacado = new Sacado(cobranca.Aluno.cpf, cobranca.Aluno.nome);
            }
            if (cobranca.Aluno.Enderecos.Count > 0)
            {
                b.Sacado.Endereco.End = String.Format("{0}, {1} {2}", cobranca.Aluno.Enderecos.FirstOrDefault().logradouro, cobranca.Aluno.Enderecos.FirstOrDefault().numero, cobranca.Aluno.Enderecos.FirstOrDefault().complemento);
                b.Sacado.Endereco.Bairro = cobranca.Aluno.Enderecos.FirstOrDefault().bairro;
                b.Sacado.Endereco.Cidade = cobranca.Aluno.Enderecos.FirstOrDefault().cidade;
                b.Sacado.Endereco.CEP = cobranca.Aluno.Enderecos.FirstOrDefault().CEP;
                b.Sacado.Endereco.UF = cobranca.Aluno.Enderecos.FirstOrDefault().uf;
            }

            //Exemplo de como adicionar mais informações ao sacado
            //b.Sacado.InformacoesSacado.Add(new InfoSacado("TÍTULO: " + "2541245"));

            //item2.Descricao += " " + item2.QuantidadeDias.ToString() + " dias corridos do vencimento.";
           // b.Instrucoes.Add(item1);
           // b.Instrucoes.Add(item2);

            // juros/descontos
            //if (b.ValorDesconto == 0)
            //{
            //    Instrucao_Itau item3 = new Instrucao_Itau(999, 1);
            //    item3.Descricao = ("Aplicar Multa 2% a.d. após o vencimento");
            //    b.Instrucoes.Add(item3);
            //}

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
            string sql = @"select distinct formaPag, p.valor as valorPago, t.nome as descTaxa, valorTotal, juros, t.valor as valorTaxa, pe.nome, 
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
