using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;
using Models = web.Models;
using System.Data.SqlClient;
using System.Data;

namespace web.Controllers
{
    public class LancarNotaFaltaController : Controller
    {
        const string CONNECTIONSTR = @"Data Source=.\SQLEXPRESS;Initial Catalog=SysCad;Integrated Security=True;MultipleActiveResultSets=True";
        private Repositorio<Modulo> dbModulo;
        private Repositorio<Turma> dbTurma;
        private Repositorio<Aluno> dbAluno;
        private Repositorio<Status> dbStatus;
        private Repositorio<MatriculaTurma> dbMatriculaTurma;
        private Repositorio<Matricula> dbMatricula;
        public LancarNotaFaltaController()
        {
            dbModulo = new Repositorio<Modulo>();
            dbTurma = new Repositorio<Turma>();
            dbAluno = new Repositorio<Aluno>();
            dbStatus = new Repositorio<Status>();
            dbMatricula = new Repositorio<Matricula>();
        }

        [HttpGet]
        public JsonResult FindTurmas()
        {
            IList<Turma> listTurmas = dbTurma.FindAll();
            return Json(new { turmas = listTurmas, totalReg = listTurmas.Count() }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult FindTurmaByProfessor(int codigoTurma)
        {
//            string sql = @"select m.idModulo as IdModulo, t.idTurma as IdTurma, t.descricao as nomeTurma, c.nome as nomeCurso, m.nome as nomeModulo 
//                            from dbo.turma t
//                            join dbo.curso c on t.idCurso = c.idCurso
//                            join dbo.modulo m on m.idCurso = c.idCurso
//                            order by c.nome,t.descricao,m.nome";
//            var listModulos = dbModulo.Context.ExecuteStoreQuery<Models.Modulo>(sql).ToList();

            List<Models.ModuloViewData> listModulos = (from m in dbModulo.Context.Modulo
                                               where m.Curso.Turmas.Where(t => t.idTurma == codigoTurma).Count() > 0
                                               select new Models.ModuloViewData
                                               {
                                                   IdModulo = m.idModulo,
                                                   IdTurma = m.Curso.Turmas.FirstOrDefault().idTurma,
                                                   nomeCurso = m.Curso.nome,
                                                   nomeModulo = m.nome,
                                                   nomeTurma = m.Curso.Turmas.FirstOrDefault().descricao
                                               }).ToList();

            return Json(new { modulos = listModulos },JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult FindAlunos(int codigoTurma, int codigoModulo)
        {
            SqlConnection conn = new SqlConnection(CONNECTIONSTR);
            conn.Open();
            string sql = @"select a.idAluno as IdAluno, t.idTurma as IdTurma, mo.idModulo as IdModulo, p.nome as Nome, nt.nota1 as Nota1, nt.nota2 as Nota2, nt.qtdFalta as Faltas, mt.situacaoAluno as situacaoAluno 
                            from aluno a
                            join pessoa p on a.idPessoa = p.idPessoa
                            join matricula m on a.idAluno = m.idAluno
                            join matriculaTurma mt on m.idMatricula = mt.idMatricula
                            join turma t on mt.idTurma = t.idTurma
                            join curso c on t.idCurso = c.idCurso
                            join modulo mo on mo.idCurso = c.idCurso
                            left join notaFalta nt on nt.idAluno = a.idAluno 
                            and nt.idModulo = mo.idModulo and nt.idTurma = t.idTurma
                            where t.idTurma = @idTurma and mo.idModulo = @idModulo";
            SqlCommand comm = conn.CreateCommand();
            comm.CommandText = sql;
            comm.Parameters.Add(new SqlParameter("@idTurma", codigoTurma));
            comm.Parameters.Add(new SqlParameter("@idModulo", codigoModulo));
            SqlDataReader dr = comm.ExecuteReader();

            List<Models.AlunoViewData> listAlunos = new List<Models.AlunoViewData>();

            while (dr.Read())
            {
                Models.AlunoViewData a = new Models.AlunoViewData();
                a.IdAluno = dr.GetInt32(0);
                a.IdTurma = dr.GetInt32(1);
                a.IdModulo = dr.GetInt32(2);
                a.Nome = dr.GetString(3);
                a.Nota1 = !dr.IsDBNull(4) ? dr.GetDecimal(4) : 0;
                a.Nota2 = !dr.IsDBNull(5) ? dr.GetDecimal(5) : 0;
                a.Faltas = !dr.IsDBNull(6) ? dr.GetInt32(6) : 0;

                listAlunos.Add(a);
            }

            return Json(new { alunos = listAlunos }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EnviarNotaFalta(int idAluno, int idTurma, int idModulo, string campo, string valor)
        {
            try
            {
                Repositorio<NotaFalta> dbNT = new Repositorio<NotaFalta>();
                NotaFalta notaFalta = dbNT.FindOne(x => x.idAluno == idAluno && x.idTurma == idTurma && x.idModulo == idModulo);
                NotaFalta nt;
                if (notaFalta == null)
                {
                    nt = new NotaFalta();
                    nt.idAluno = idAluno;
                    nt.idTurma = idTurma;
                    nt.idModulo = idModulo;
                }
                else
                {
                    nt = notaFalta;
                }

                switch (campo)
                {
                    case "Nota1":
                        nt.nota1 = Convert.ToDecimal(valor.Replace(".",","));
                        atualizaSituacaoAluno(idAluno, idTurma, EnumStatus.Aprovado);
                        break;
                    case "Nota2":
                        nt.nota2 = Convert.ToDecimal(valor.Replace(".", ","));
                        break;
                    case "Faltas":
                        nt.qtdFalta = Convert.ToInt32(valor);
                        break;
                }
                if (notaFalta == null)
                {
                    dbNT.Adicionar(nt);
                }
                else
                {
                    dbNT.Atualizar(nt);
                }
                dbNT.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        public ActionResult LancarNotaFalta()
        {
            return View();
        }

        public JsonResult traduzSituacaoAluno(int idStatus)
        {
            var dscStatus = dbStatus.FindOne(x => x.idStatus == idStatus).descricao;

            return Json(new { descricao = dbStatus });
        }

        private void atualizaSituacaoAluno(int idAluno, int idTurma, EnumStatus status)
        {
            Matricula m = dbMatricula.FindOne(x => x.idAluno == idAluno);
            MatriculaTurma mt = dbMatriculaTurma.FindOne(x => x.idMatricula == m.idMatricula && x.idTurma == idTurma);
            mt.situacaoAluno = (int)status;
            dbMatriculaTurma.Atualizar(mt);
            dbMatriculaTurma.SaveChanges();
        }

    }
}
