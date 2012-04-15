<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Curso>>" %>

<%@ Import Namespace="Persistence.Entity" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login SysCad</title>
<link href="../../Content/Login.css" rel="stylesheet" type="text/css" />
</head>

<body>

    <div id="syscad_superior_direito">
        sysCAD
    </div>
    <div id="logo_syscad_login">
          <form name="login" action="#" method="post" >
            <table cellpadding="10" cellspacing="10">
                <tr>
                    <td rowspan="2"><img src="../../Content/imagens/logo_syscad.png" alt="Logo Syscad" /></td>
                    <td class="word_syscad_login">Usuário:</td>
                    <td class="word_syscad_login">&nbsp;</td>
                </tr>
                <tr>
                  <td><input type="text" name="login2" class="txt_syscad_login" /></td>
                  <td><input type="image" src="../../Content/imagens/seta_vai.png" /></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td class="word_syscad_login">Por favor, entre com seu usuário</td>
                  <td class="word_syscad_login">&nbsp;</td>
                </tr>
            </table>
          </form>
    </div>
    <div id="syscad_rodape_login">
    	<table cellspacing="10">
        	<tr>
            	<td><a href="" onclick="window.close()">Fechar Janela</a></td>
                <td><img src="../../Content/imagens/separador_login.png" width="1" height="56" alt="Separador" /></td>
            	<td><a href="#">Esqueci a Senha</a></td>
                <td><img src="../../Content/imagens/separador_login.png" width="1" height="56" alt="Separador" /></td>
            	<td><a href="#">Contate o Administrador</a></td>
            </tr>
        </table>
    </div>
        
</body>
</html>

