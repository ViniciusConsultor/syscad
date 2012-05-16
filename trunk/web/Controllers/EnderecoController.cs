using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.DAO;
using Persistence.Entity;

namespace web.Controllers
{
    public class EnderecoController : Controller
    {

        IRepositorio<Endereco> dbEndereco;
        IRepositorio<Pessoa> dbPessoa;
        IRepositorio<TipoEndereco> dbTipoEndereco;

        public ActionResult Endereco()
        {
            return View();
        }

        public EnderecoController()
        {
            dbPessoa = new Repositorio<Pessoa>();
            dbEndereco = new Repositorio<Endereco>();
            dbTipoEndereco = new Repositorio<TipoEndereco>();

        }

        [HttpGet]
        public JsonResult FindEnderecos(int idPessoa)
        {
            IList<Endereco> listaEndereco = dbEndereco.FindAll().Where(end => end.idPessoa == idPessoa).ToList();

            foreach (Endereco e in listaEndereco)
            {
                e.Pessoa = dbPessoa.FindOne(pes => pes.idPessoa == e.idPessoa);
                e.TipoEndereco = dbTipoEndereco.FindOne(te => te.idTipoEndereco == e.idTipoEndereco);
            }

            return Json(new { enderecos = listaEndereco, totalReg = listaEndereco.Count }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Save(int cmbTipoEndereco_Value, int idPessoa_Value, string txtLogradouro, int txtNumero, string txtComplemento, string txtCep, string txtBairro, string txtCidade, string txtUf)
        {

            Endereco endereco = new Endereco();
            endereco.idTipoEndereco = cmbTipoEndereco_Value;
            endereco.idPessoa = idPessoa_Value;
            endereco.logradouro = txtLogradouro;
            endereco.numero = txtNumero;
            endereco.complemento = txtComplemento;
            endereco.CEP = txtCep;
            endereco.bairro = txtBairro;
            endereco.cidade = txtCidade;
            endereco.uf = txtUf;

            try
            {

                dbEndereco.Adicionar(endereco);
                dbEndereco.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

        [HttpPost]
        public JsonResult Excluir(int id)
        {

            Endereco endereco = dbEndereco.FindOne(end => end.idEndereco == id);

            try
            {
                dbEndereco.Remover(endereco);
                dbEndereco.SaveChanges();

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

            Endereco endereco = dbEndereco.FindOne(end => end.idEndereco == id);

            try
            {
                switch (campo)
                {
                    case "TipoEndereco.nome":
                        endereco.idTipoEndereco = Convert.ToInt32(valor);
                        break;
                    case "logradouro":
                        endereco.logradouro = valor;
                        break;
                    case "numero":
                        endereco.numero = Convert.ToInt32(valor);
                        break;
                    case "complemento":
                        endereco.complemento = valor;
                        break;
                    case "CEP":
                        endereco.CEP = valor;
                        break;
                    case "bairro":
                        endereco.bairro = valor;
                        break;
                    case "cidade":
                        endereco.cidade = valor;
                        break;
                    case "uf":
                        endereco.uf = valor;
                        break;
                }

                dbEndereco.Atualizar(endereco);
                dbEndereco.SaveChanges();

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {

                return Json(new { success = false, message = e.Message }, JsonRequestBehavior.AllowGet);

            }

        }

    }
}
