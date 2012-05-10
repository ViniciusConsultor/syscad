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
        public JsonResult Save(int cmbTipoEndereco, int cmbPessoa, string txtLogradouro, int txtNumero, string txtComplemento, string txtCep, string txtBairro, string txtCidade, string txtUf)
        {

            Endereco endereco = new Endereco();
            endereco.idTipoEndereco = cmbTipoEndereco;
            endereco.idPessoa = cmbPessoa;
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

    }
}
