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
        SqlConnection conn;
        private Repositorio<Modulo> dbModulo;
        private Repositorio<Turma> dbTurma;
        private Repositorio<Aluno> dbAluno;
        private IRepositorio<Status> dbStatus;
        private Repositorio<Matricula> dbMatricula;
        private Repositorio<NotaFalta> dbNotaFalta;
        private Repositorio<Curso> dbCurso;
        public LancarNotaFaltaController()
        {
            dbModulo = new Repositorio<Modulo>();
            dbTurma = new Repositorio<Turma>();
            dbAluno = new Repositorio<Aluno>();
            dbStatus = new Repositorio<Status>();
            dbMatricula = new Repositorio<Matricula>();
            dbNotaFalta = new Repositorio<NotaFalta>();
            dbCurso = new Repositorio<Curso>();
            conn = new SqlConnection(CONNECTIONSTR);
        }

        [HttpGet]
        public JsonResult FindTurmas()
        {
            IList<Turma> listTurmas = dbTurma.FindAll();
            return Json(new { turmas = listTurmas, totalReg = listTurmas.Count() }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult FindTurmaByProfessor()
        {
            if (Session["id_usuario"] != null)
            {
                var idProfessor = (int)Session["id_usuario"];

                conn.Open();
                string sql = @"select idModulo, idTurma , m.nome as modulo, c.nome as curso, t.descricao as turma from modulo m
                            join curso c
                            on m.idCurso = c.idCurso
                            join turma t
                            on t.idCurso = c.idCurso
                            join funcionario f
                            on f.idFuncionario = t.idFuncionario
                            where f.idUsuario = @usuario and t.status = @status";
                SqlCommand comm = conn.CreateCommand();
                comm.CommandText = sql;
                comm.Parameters.Add(new SqlParameter("@usuario", idProfessor));
                comm.Parameters.Add(new SqlParameter("@status", (int)EnumStatus.TurmaAberta));
                SqlDataReader dr = comm.ExecuteReader();

                List<Models.ModuloViewData> listModulos = new List<Models.ModuloViewData>();

                while (dr.Read())
                {
                    Models.ModuloViewData a = new Models.ModuloViewData();
                    a.IdModulo = dr.GetInt32(0);
                    a.IdTurma = dr.GetInt32(1);
                    a.nomeModulo = dr.GetString(2);
                    a.nomeCurso = dr.GetString(3);
                    a.nomeTurma = dr.GetString(4);

                    listModulos.Add(a);
                }

                conn.Close();

                return Json(new { modulos = listModulos }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                List<Models.ModuloViewData> listModulos = new List<Models.ModuloViewData>();
                return Json(new { modulos = listModulos }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult FindAlunos(int codigoTurma, int codigoModulo)
        {
            
            conn.Open();
            string sql = @"select a.idAluno, t.idTurma, mo.idModulo, p.nome, nt.nota1, nt.nota2, nt.qtdFalta, nt.situacaoAluno, nt.notaFinal, m.idMatricula 
                            from aluno a
                            join pessoa p on a.idPessoa = p.idPessoa
                            join matricula m on a.idAluno = m.idAluno
                            join matriculaTurma mt on m.idMatricula = mt.idMatricula
                            join turma t on mt.idTurma = t.idTurma
                            join curso c on t.idCurso = c.idCurso
                            join modulo mo on mo.idCurso = c.idCurso
                            left join notaFalta nt on nt.idAluno = a.idAluno 
                            and nt.idModulo = mo.idModulo and nt.idTurma = t.idTurma
                            where t.idTurma = @idTurma and mo.idModulo = @idModulo and m.tipo = 'matricula'";
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
                a.Nota1 = !dr.IsDBNull(4) ? dr.GetDecimal(4) : (decimal?)null;
                a.Nota2 = !dr.IsDBNull(5) ? dr.GetDecimal(5) : (decimal?)null;
                a.Faltas = !dr.IsDBNull(6) ? dr.GetInt32(6) : 0;
                a.situacaoAluno = !dr.IsDBNull(7) ? dr.GetInt32(7) : 0;
                a.notaFinal = !dr.IsDBNull(8) ? dr.GetDecimal(8) : (decimal?)null;
                a.IdMatricula = dr.GetInt32(9);

                listAlunos.Add(a);
            }

            conn.Close();

            return Json(new { alunos = listAlunos }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult EnviarNotaFalta(int idMatricula, int idAluno, int idTurma, int idModulo, string campo, string valor)
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
                    nt.nota1 = null;
                    nt.nota2 = null;
                    nt.qtdFalta = 0;
                    nt.notaFinal = null;
                }
                else
                {
                    nt = notaFalta;
                }

                switch (campo)
                {
                    case "Nota1":
                        nt.nota1 = !string.IsNullOrEmpty(valor) ?  Convert.ToDecimal(valor.Replace(".",",")) : (decimal?)null;
                        nt.notaFinal = nt.nota1;
                        break;
                    case "Nota2":
                        nt.nota2 = !string.IsNullOrEmpty(valor) ?  Convert.ToDecimal(valor.Replace(".",",")) : (decimal?)null;
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

                //Verifica a situação do aluno
                var ntFalta = verificaSituacao(idMatricula, idAluno, idTurma, idModulo);

                return Json(new { notaFalta = ntFalta, success = true }, JsonRequestBehavior.AllowGet);

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

            return Json(new { descricao = dscStatus });
        }

        //Implementação das regras de negocio
        private NotaFalta verificaSituacao(int idMatricula, int idAluno, int idTurma, int idModulo)
        {
            NotaFalta nt = dbNotaFalta.FindOne(x => x.idAluno == idAluno && x.idTurma == idTurma && x.idModulo == idModulo);
            if (nt.nota1 != null && nt.qtdFalta != null)
            {
                Turma t = dbTurma.FindOne(x => x.idTurma == idTurma);
                Modulo m = dbModulo.FindOne(x => x.idModulo == idModulo);
                decimal percFaltas = (decimal)((nt.qtdFalta * 100) / m.tempoDuracao);
                if (nt.nota1 >= 7 && percFaltas <= 25)
                {
                    //Aprovado
                    atualizaSituacaoAluno(idAluno, idTurma, idModulo, EnumStatus.Aprovado);
                    nt.situacaoAluno = (int)EnumStatus.Aprovado;
                }
                else if (nt.nota1 >= 2 && nt.nota1 < 7 && percFaltas <= 25)
                {
                    if (((nt.nota2 / 2) + nt.nota1) >= 7)
                    {
                        //Aprovado após recuperação
                        atualizaSituacaoAluno(idAluno, idTurma, idModulo, EnumStatus.Aprovado);
                        nt.situacaoAluno = (int)EnumStatus.Aprovado;
                        if (nt.nota2 > 0)
                        {
                            nt.notaFinal = 7;
                            dbNotaFalta.Atualizar(nt);
                            dbNotaFalta.SaveChanges();
                        }
                    }
                    else if (nt.nota2 != null && ((nt.nota2 / 2) + nt.nota1) < 7)
                    {
                        //Aprovado após recuperação
                        atualizaSituacaoAluno(idAluno, idTurma, idModulo, EnumStatus.Reprovado);
                        nt.situacaoAluno = (int)EnumStatus.Reprovado;  
                    }
                    else
                    {
                        //Recuperacao
                        atualizaSituacaoAluno(idAluno, idTurma, idModulo, EnumStatus.Recuperacao);
                        nt.situacaoAluno = (int)EnumStatus.Recuperacao;
                    }
                }
                else if (nt.nota1 < 2 || percFaltas > 25)
                {
                    //Reprovado
                    atualizaSituacaoAluno(idAluno, idTurma, idModulo, EnumStatus.Reprovado);
                    nt.situacaoAluno = (int)EnumStatus.Reprovado;
                }
                
                //Calcula média final
                int qtdModulos = dbModulo.FindAll(x => x.idCurso == t.idCurso).Count;
                int qtdModulosCursados = dbNotaFalta.FindAll(x => x.idTurma == idTurma && x.idAluno == idAluno && x.nota1 != null).Count;
                if (qtdModulos == qtdModulosCursados)
                {
                    List<NotaFalta> lstNotaFalta = dbNotaFalta.FindAll(x => x.idTurma == idTurma && x.idAluno == idAluno);
                    int modulosAprovados = lstNotaFalta.Where(x => x.situacaoAluno == (int)EnumStatus.Aprovado).Count();
                    var notaFinal = lstNotaFalta.Average(x => x.notaFinal);
                    if (modulosAprovados == qtdModulosCursados)
                    {    
                        //Aprovado no curso
                        atualizaSituacaoFinalAluno(idMatricula, idTurma, EnumStatus.Aprovado, notaFinal.Value);
                    }
                    else
                    {
                        //Reprovado no curso
                        atualizaSituacaoFinalAluno(idMatricula, idTurma, EnumStatus.Reprovado, notaFinal.Value);
                    }
                }
            }
            
            return nt;
        }

        private void atualizaSituacaoAluno(int idAluno, int idTurma, int idModulo, EnumStatus status)
        {
            try
            {
                var sql = @"UPDATE nt
                            SET situacaoAluno = @situacaoAluno
                            FROM dbo.notaFalta nt
                            WHERE idAluno = @idAluno AND idTurma = @idTurma AND idModulo = @idModulo";
                conn.Open();
                SqlCommand comm = conn.CreateCommand();
                comm.CommandText = sql;
                comm.Parameters.Add(new SqlParameter("@situacaoAluno", status));
                comm.Parameters.Add(new SqlParameter("@idAluno", idAluno));
                comm.Parameters.Add(new SqlParameter("@idTurma", idTurma));
                comm.Parameters.Add(new SqlParameter("@idModulo", idModulo));
                comm.ExecuteNonQuery();                
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        private void atualizaSituacaoFinalAluno(int idMatricula, int idTurma, EnumStatus status, decimal notaFinal)
        {
            try
            {
                var sql = @"UPDATE mt
                            SET situacaoAluno = @situacaoAluno, notaFinal = @notaFinal
                            FROM dbo.matriculaTurma mt
                            WHERE idMatricula = @idMatricula AND idTurma = @idTurma";
                conn.Open();
                SqlCommand comm = conn.CreateCommand();
                comm.CommandText = sql;
                comm.Parameters.Add(new SqlParameter("@situacaoAluno", status));
                comm.Parameters.Add(new SqlParameter("@idMatricula", idMatricula));
                comm.Parameters.Add(new SqlParameter("@idTurma", idTurma));
                comm.Parameters.Add(new SqlParameter("@notaFinal", notaFinal));
                comm.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
            finally
            {
                conn.Close();
            }
        }


    }
}
