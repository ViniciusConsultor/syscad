﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Persistence.Entity;
using Persistence.DAO;

namespace web.Controllers
{
    public class UsuarioController : Controller
    {
        //
        // GET: /Usuario/

        public ActionResult Index()
        {
            return View();
        } // Index

        public ActionResult BuscarUsuario(string login)
        {
            string resposta = "";
            IRepositorio<Usuario> dbUsuario = new Repositorio<Usuario>();
            Usuario usuario = dbUsuario.FindOne(usu => usu.login == login);

            if (usuario != null)
            {
                resposta = usuario.login;

                Session["login_usuario"] = usuario.login;
                Session["id_usuario"] = usuario.idUsuario;
                //Session["nome_perfil"] = usuario.Perfil.nome;
                //Session["id_perfil"] = usuario.Perfil.idPerfil;
            }
            else
            {
                resposta = "Não";
            } //if

            return Json(resposta);
        } // BuscarUsuario

        public ActionResult BuscarSenha(string login, string senha)
        {

            string resposta = "";
            IRepositorio<Usuario> dbUsuario = new Repositorio<Usuario>();
            Usuario usuario = dbUsuario.FindOne(usu => usu.login == login && usu.senha == senha);

            if (usuario != null)
            {
                resposta = usuario.login;
            }
            else
            {
                resposta = "Não";
            } //if

            return Json(resposta);

        } // BuscarSenha

    } // class

} // namespace
