﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Curso>>" %>

<%@ Import Namespace="Persistence.Entity" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login SysCad</title>
<link href="../../Content/Login.css" rel="stylesheet" type="text/css" />
<script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
<script src="../../Scripts/funcoes_ready.js" type="text/javascript"></script>
    <script src="../../Scripts/funcoes.js" type="text/javascript"></script>

</head>

<body>

    <div id="syscad_superior_direito">
        sysCAD
    </div>
    <div id="logo_syscad_login">
          <form name="formulario_login" action="" method="post" id="formulario_login" >
            <table cellpadding="10" cellspacing="10">
                <tr>
                    <td rowspan="2"><img src="../../Content/imagens/logo_syscad_3.png" alt="Logo Syscad" /></td>
                    <td class="word_syscad_login" id="retorno_identificacao">Usuário:</td>
                    <td class="word_syscad_login">&nbsp;</td>
                </tr>
                <tr>
                  <td id="txt_identificacao"><input type="text" name="login" class="txt_syscad_login" /></td>
                  <td id="buttton_identificacao"><input type="image" src="../../Content/imagens/seta_vai_3.png" id="enviar_login" /></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td class="word_syscad_login" id="retorno_mensagem">Por favor, entre com seu usuário</td>
                  <td class="word_syscad_login">&nbsp;</td>
                </tr>
            </table>
          </form>
    </div>

        
</body>
</html>

