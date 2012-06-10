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

        public string FindExAlunos()
        {
            List<Matricula> listaMatricula = dbMatricula.FindAll();

            foreach (Matricula m in listaMatricula)
            {
                m.Aluno = dbAluno.FindOne(x => x.idAluno == m.idAluno);
                m.Aluno.Pessoa = new Repositorio<Pessoa>().FindOne(x => x.idPessoa == m.Aluno.idPessoa);
                m.MatriculaTurmas = dbMatriculaTurma.FindAll(x => x.idMatricula == m.idMatricula);
            }

            return "{matriculas:" + JSON.Serialize(listaMatricula) + ", totalReg:" + listaMatricula.Count() + "}";
        }

    }
}
