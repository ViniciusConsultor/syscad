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
    public class RelatorioController : Controller
    {
        const string CONNECTIONSTR = @"Data Source=.\SQLEXPRESS;Initial Catalog=SysCad;Integrated Security=True;MultipleActiveResultSets=True";
        SqlConnection conn;

        private Repositorio<Turma> dbTurma;
        private Repositorio<Aluno> dbAluno;
        private Repositorio<Matricula> dbMatricula;
        private Repositorio<Pessoa> dbPessoa;
        private Repositorio<MatriculaTurma> dbMatriculaTurma;

        public RelatorioController()
        {
            dbAluno = new Repositorio<Aluno>();
            dbMatricula = new Repositorio<Matricula>();
            dbPessoa = new Repositorio<Pessoa>();
            dbTurma = new Repositorio<Turma>();
            dbMatriculaTurma = new Repositorio<MatriculaTurma>();
            conn = new SqlConnection(CONNECTIONSTR);
        }

        public ActionResult ExAlunos()
        {
            return View();
        }

        [HttpPost]
        public string FindExAlunos()
        {
            List<MatriculaTurma> listaMatriculaTurma = dbMatriculaTurma.FindAll();
            List<Aluno> listaAlunosInativos = dbAluno.FindAll();

            foreach (MatriculaTurma m in listaMatriculaTurma)
            {
                m.Matricula = dbMatricula.FindOne(x => x.idMatricula == m.idMatricula);
                m.Matricula.Aluno = dbAluno.FindOne(x => x.idAluno == m.Matricula.idAluno);
                if (m.Matricula.Aluno != null)
                {
                    listaAlunosInativos.Remove(m.Matricula.Aluno);
                }
            }

            foreach (Aluno a in listaAlunosInativos)
            {
                a.Pessoa = dbPessoa.FindOne(x => x.idPessoa == a.idPessoa);
            }


            return "{alunos:" + JSON.Serialize(listaAlunosInativos) + ", totalReg:" + listaAlunosInativos.Count() + "}";
        }

        public ActionResult CursosMaisCursados()
        {
            return View();
        }

        public JsonResult FindCursoMaisCursado()
        {
            conn.Open();
            string sql = @"SELECT c.nome, COUNT(mt.idMatricula) as QtdAlunos 
                            FROM matriculaTurma mt
                            JOIN turma t
                            ON mt.idTurma = t.idTurma
                            JOIN curso c
                            ON t.idCurso = c.idCurso
                            GROUP BY c.nome";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            SqlDataReader dr = comm.ExecuteReader();
            List<object> lista = new List<object>();
            while (dr.Read())
            {
                var c = new
                {
                    Curso = dr.GetString(0),
                    QtdAluno = dr.GetInt32(1)
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
            List<Aluno> listaAlunos = dbAluno.FindAll(x => x.statusFinanceiro == (int)EnumStatus.Inadimplente);
            foreach (Aluno a in listaAlunos)
            {

                a.Pessoa = new Repositorio<Pessoa>().FindOne(x => x.idPessoa == a.idPessoa);

            }
            return "{alunos:" + JSON.Serialize(listaAlunos) + ", totalReg:" + listaAlunos.Count() + "}";
        }
    }

}
