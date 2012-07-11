using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using Ext.Net;
using System.Data.SqlClient;
using System.IO;
using System;


namespace web.Controllers
{
    public class RelatorioController : Controller
    {
        const string CONNECTIONSTR = @"Data Source=.\SQLEXPRESS;Initial Catalog=SysCad;Integrated Security=True;MultipleActiveResultSets=True";
        SqlConnection conn;

        private Repositorio<Turma> dbTurma;
        private Repositorio<Aluno> dbAluno;
        private Repositorio<Matricula> dbMatricula;
        private Repositorio<Pessoa> dbPessoa;
        private Repositorio<MatriculaTurma> dbMatriculaTurma;
        private Repositorio<FuncionarioEspecializacao> dbFuncionarioEspecializacao;
        private Repositorio<Cobranca> dbCobranca;

        public RelatorioController()
        {
            dbAluno = new Repositorio<Aluno>();
            dbMatricula = new Repositorio<Matricula>();
            dbPessoa = new Repositorio<Pessoa>();
            dbTurma = new Repositorio<Turma>();
            dbMatriculaTurma = new Repositorio<MatriculaTurma>();
            dbFuncionarioEspecializacao = new Repositorio<FuncionarioEspecializacao>();
            dbCobranca = new Repositorio<Cobranca>();
            conn = new SqlConnection(CONNECTIONSTR);
        }

        public ActionResult ExAlunos()
        {
            return View();
        }

        public ActionResult Especializacao()
        {
            return View();
        }

        [HttpPost]
        public string FindExAlunos(string dtInicio, string dtFim)
        {
            var dataInicio = Convert.ToDateTime(dtInicio);
            var dataFim = Convert.ToDateTime(dtFim);

            conn.Open();
            string sql = @"select a.idAluno, p.nome, p.email, p.telefone, p.celular, c.nome as nomeCurso, MAX(m.dataRegistro) as data from matriculaTurma mt
                            join turma t
                            on mt.idTurma = t.idTurma
                            join matricula m
                            on mt.idMatricula = m.idMatricula
                            join aluno a
                            on m.idAluno = a.idAluno
                            join pessoa p
                            on a.idPessoa = p.idPessoa
                            join curso c
                            on t.idCurso = c.idCurso
                            where t.dataFechamento is not null 
                            and t.dataInicio between @dtInicio and @dtFim
                            or t.dataFim between @dtInicio and @dtFim
                            group by a.idAluno, p.nome, p.email, p.telefone, p.celular, c.nome
                            order by p.nome";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            comm.Parameters.Add(new SqlParameter("@dtInicio", dataInicio));
            comm.Parameters.Add(new SqlParameter("@dtFim", dataFim));
            SqlDataReader dr = comm.ExecuteReader();
            List<object> listAluno = new List<object>();
            while (dr.Read())
            {
                object a = new
                {
                    idAluno = dr.GetInt32(0),
                    nome = dr.GetString(1),
                    email = dr.GetString(2),
                    telefone = dr.GetString(3),
                    celular = dr.GetString(4),
                    nomeCurso = dr.GetString(5)

                };

                listAluno.Add(a);                
            }

            //return Json(new { cursos = lista, totalReg = lista.Count });

            return "{alunos:" + JSON.Serialize(listAluno) + ", totalReg:" + listAluno.Count() + "}";
        }

        [HttpPost]
        public string FindEspecializacao()
        {
            List<FuncionarioEspecializacao> listaFuncionarioEspecializacoes = dbFuncionarioEspecializacao.FindAll();
            foreach (FuncionarioEspecializacao fe in listaFuncionarioEspecializacoes)
            {
                fe.Especializacao = new Repositorio<Especializacao>().FindOne(x => x.idEspecializacao == fe.idEspecializacao);
                fe.Funcionario = new Repositorio<Funcionario>().FindOne(x => x.idFuncionario == fe.idFuncionario);
                fe.Funcionario.Pessoa = new Repositorio<Pessoa>().FindOne(x => x.idPessoa == fe.Funcionario.idPessoa);
            }

            return "{funcionarioEspecializacoes:" + JSON.Serialize(listaFuncionarioEspecializacoes.OrderBy(x => x.Funcionario.Pessoa.nome)) + ", totalReg:" + listaFuncionarioEspecializacoes.Count() + "}";
        }

        public ActionResult CursosMaisCursados()
        {
            return View();
        }

        public JsonResult FindCursoMaisCursado(string dtInicio, string dtFim)
        {
            var dataInicio = Convert.ToDateTime(dtInicio);
            var dataFim = Convert.ToDateTime(dtFim);

            conn.Open();
            string sql = @"SELECT c.nome, COUNT(mt.idMatricula) as QtdAlunos 
                            FROM matriculaTurma mt
                            JOIN turma t
                            ON mt.idTurma = t.idTurma
                            JOIN curso c
                            ON t.idCurso = c.idCurso
                            where t.dataInicio between @dtInicio and @dtFim or t.dataFim between @dtInicio and @dtFim
                            GROUP BY c.nome
                            order by COUNT(mt.idMatricula) desc";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            comm.Parameters.Add(new SqlParameter("@dtInicio", dataInicio));
            comm.Parameters.Add(new SqlParameter("@dtFim", dataFim));
            SqlDataReader dr = comm.ExecuteReader();
            List<object> lista = new List<object>();
            while (dr.Read())
            {
                var c = new
                {
                    Curso = dr.GetString(0),
                    QtdAluno = dr.GetInt32(1),
                    DataInicio = dataInicio,
                    DataFim = dataFim

                };

                lista.Add(c);                
            }

            return Json(new { cursos = lista, totalReg = lista.Count });
        }

        public ActionResult Inadimplentes()
        {
            return View();
        }

        public string FindInadimplentes()
        {
             conn.Open();
             string sql = @"select a.idAluno, p.nome, p.telefone, p.celular, p.email, MIN(c.dataVencimento) as dataVencimento, SUM(valorTotal) as valorTotal,
                            SUM(case when GETDATE() > c.dataVencimento then DATEDIFF(d,c.dataVencimento,GETDATE()) * (c.valorTotal * 0.02) ELSE c.juros END) AS juros
                            from aluno a
                            join cobranca c
                            on a.idAluno = c.idAluno
                            join pessoa p
                            on p.idPessoa = a.idPessoa
                            where c.dataVencimento < GETDATE() and c.statusPagamento = 7
                            group by p.nome, p.telefone, p.celular, p.email, a.idAluno
                            order by dataVencimento, SUM(valorTotal) desc, SUM(c.juros)";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            SqlDataReader dr = comm.ExecuteReader();
            List<object> listaAlunos = new List<object>();
            while (dr.Read())
            {
                var a = new
                {
                    idAluno = dr.GetInt32(0),
                    nome = dr.GetString(1),
                    telefone = dr.GetString(2),
                    celular = dr.GetString(3),
                    email = dr.GetString(4),
                    dataVencimento = dr.GetDateTime(5),
                    valorTotal = dr.GetDecimal(6) + dr.GetDecimal(7)
                };

                listaAlunos.Add(a);
            }
           
            return "{alunos:" + JSON.Serialize(listaAlunos) + ", totalReg:" + listaAlunos.Count() + "}";
        }
    }


}
