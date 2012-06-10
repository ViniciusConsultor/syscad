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
        //
        // GET: /Relatorio/

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

    }
}
