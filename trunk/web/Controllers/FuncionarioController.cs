using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;


namespace web.Controllers
{
    public class FuncionarioController : Controller
    {
        IRepositorio<Funcionario> dbFuncionario;
        IRepositorio<Usuario> dbUsuario;
        IRepositorio<Cargo> dbCargo;
        IRepositorio<Pessoa> dbPessoa;

        public FuncionarioController()
        {
            dbFuncionario = new Repositorio<Funcionario>();
            dbUsuario = new Repositorio<Usuario>();
            dbCargo = new Repositorio<Cargo>();
            dbPessoa = new Repositorio<Pessoa>();
        }
        
        public ActionResult Funcionario()
        {
            return View();
        }

        [HttpGet]
        public JsonResult FindAll()
        {

            IList<Funcionario> listaFuncionario = dbFuncionario.FindAll();

            foreach (Funcionario f in listaFuncionario)
            {
                f.Usuario = new Repositorio<Usuario>().FindOne(x => x.idUsuario == f.idUsuario);
                f.Cargo = new Repositorio<Cargo>().FindOne(x => x.idCargo == f.idCargo);
                f.Pessoa = new Repositorio<Pessoa>().FindOne(x => x.idPessoa == f.idPessoa);
            }

            return Json(new { funcionarios = listaFuncionario, totalReg = listaFuncionario.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Excluir(int id)
        {

            Funcionario funcionario = dbFuncionario.FindOne(cur => cur.idFuncionario == id);

            try
            {
                dbFuncionario.Remover(funcionario);
                dbFuncionario.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Save(string cmbPessoa_Value, string cmbCargo_Value, string txtSalario, string txtLogin, string txtSenha, string cmbPerfil_Value)
        {           

            Funcionario funcionario = new Funcionario();
            funcionario.idCargo = Convert.ToInt32(cmbCargo_Value);
            funcionario.idPessoa = Convert.ToInt32(cmbPessoa_Value);
            funcionario.salario = Convert.ToDecimal(txtSalario);

            Usuario usuario = new Usuario();
            usuario.login = txtLogin;
            usuario.senha = txtSenha;
            usuario.idPerfil = Convert.ToInt32(cmbPerfil_Value);

            funcionario.Usuario = usuario;

            try
            {
                dbFuncionario.Adicionar(funcionario);
                dbFuncionario.SaveChanges();

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

            Funcionario funcionario = dbFuncionario.FindOne(fun => fun.idFuncionario == id);

            try
            {

                switch (campo)
                {
                    case "Cargo.nome":

                        funcionario.idCargo = Convert.ToInt32(valor);
                        break;

                    case "Pessoa.nome":

                        funcionario.idPessoa = Convert.ToInt32(valor);
                        break;

                    case "Usuario.login":

                        Usuario usuario = dbUsuario.FindOne(usu => usu.idUsuario == funcionario.idUsuario);
                        usuario.login = valor;
                        funcionario.Usuario = usuario;
                        break;

                    case "salario":

                        funcionario.salario = Convert.ToInt32(valor);
                        break;

                }

                dbFuncionario.Atualizar(funcionario);
                dbFuncionario.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

    }
}
