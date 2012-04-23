$(document).ready(function () {

    //----------------------------------------------------------------------------------------------------------------------------

    $("#formulario_login").submit(function () {

        return false;

    }); // formulario_login

    //----------------------------------------------------------------------------------------------------------------------------

    $("#enviar_login").live("click", function () {

        $.post("/Usuario/BuscarUsuario", $("#formulario_login").serialize(), function (valor) {

            if (valor != "Não") {

                $("#retorno_identificacao").html("Senha: <a href=\"\">Trocar Usuário<a>");
                $("#txt_identificacao").html("<input type=\"hidden\" id=\"login\" name=\"login\" value=\"" + valor + "\"/> <input type=\"password\" name=\"senha\" class=\"txt_syscad_login\" />");
                $("#buttton_identificacao").html("<input type=\"image\" src=\"../../Content/imagens/seta_vai.png\" id=\"enviar_login_2\" />");
                $("#retorno_mensagem").html("Digite a senha para o usuário <br /><strong>" + valor + "</strong>");

            } else {

                $("#retorno_identificacao").html("Usuário:");
                $("#retorno_mensagem").html("Usuário não encontrado, tente novamente!");

            } //if

        }); //post



    }); // enviar_login

    //----------------------------------------------------------------------------------------------------------------------------

    $("#enviar_login_2").live("click", function () {

        $.post("/Usuario/BuscarSenha", $("#formulario_login").serialize(), function (valor) {

            if (valor != "Não") {

                $("#retorno_mensagem").html("Autenticação efetuada com sucesso para o usuário <strong>" + valor + "</strong>");
                location.href = "/Home/Layout";

            } else {

                $("#retorno_mensagem").html("Senha inexistente para o usuário <br /><strong>" + $("#login").val() + "</strong>");

            } // if

        }); // post

    }); // enviar_login_2

    //----------------------------------------------------------------------------------------------------------------------------

});  // document ready