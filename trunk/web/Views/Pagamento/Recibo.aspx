<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Pagamento>>" %>
<%@ Import Namespace="web.Models" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Recibo</title>
    <style type="text/css">
        body
        {
            font:"Times New Roman" 11px;
        }
        .Center
        {
            text-align:center;
        }
        
        .Left
        {
            text-align:left;
        }
        
        .Right
        {
            text-align:right;
        }
        
        table
        {
            width:300px
        }
    </style>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var formataDinheiro = function (num) {
            num = num.toString().replace(/\R$|\,/g, '');
            if (isNaN(num)) num = "0";
            sign = (num == (num = Math.abs(num)));
            num = Math.floor(num * 100 + 0.50000000001);
            cents = num % 100;
            num = Math.floor(num / 100).toString();
            if (cents < 10) cents = "0" + cents;
            for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
                num = num.substring(0, num.length - (4 * i + 3)) + '.' + num.substring(num.length - (4 * i + 3));
            return (((sign) ? '' : '-') + 'R$ ' + num + ',' + cents);
        }

        var formaPag = function (fpag) {
            switch (fpag) {
                case "1":
                    return "Dinheiro";
                    break;
                case "2":
                    return "Crédito";
                    break;
            }
        }

        $(document).ready(function () {
            $(".valor").each(function () {
                $(this).text(formataDinheiro($(this).text()));
            });
            $(".formaPag").each(function () {
                $(this).text(formaPag($(this).text()));
            });
            var dataAtual = new Date();
            var dia = ('0' + dataAtual.getDate()).substr(-2, 2);
            var mes = ('0' + (parseInt(dataAtual.getMonth()) + 1)).substr(-2, 2);
            var ano = dataAtual.getFullYear();
            var hora = ('0' + dataAtual.getHours()).substr(-2, 2) + ':' + ('0' + dataAtual.getMinutes()).substr(-2, 2) + ':' + ('0' + dataAtual.getSeconds()).substr(-2, 2);
            var dataFormatada = dia + "/" + mes + "/" + ano +" "+ hora
            $("#data").html(dataFormatada);

        });
    </script>
</head>
<body>
    <table>
        <tr>
            <td class="Center" colspan="3">
                V Mendonsa da Costa Idiomas e Informática
            </td>
        </tr>
        <tr>
            <td class="Center" colspan="3">
                010.668.613/0001-55
            </td>
        </tr>
        <tr>
            <td class="Center" colspan="3">
                Rua Aurélio de Figueiredo, nº 113
            </td>
        </tr>
        <tr>
            <td class="Center" colspan="3">
                Campo Grande – Rio de Janeiro – RJ
            </td>
        </tr>
        <tr>
            <td class="Center" colspan="3">
               -------------------------------------------------
            </td>
        </tr>
        <tr>
            <td class="Left" colspan="2">
                Matricula:
            </td>
            <td class="Right">
                <%=Model.First().Cobranca.Aluno.Matricula.numeroMatricula %>
            </td>
        </tr>
        <tr>
            <td class="Left" colspan="2">
                Aluno:
            </td>
            <td class="Right">
                <%=Model.First().Cobranca.Aluno.nome %>
            </td>
        </tr>
        <% if (Model.First().Cobranca.Curso.nome != "")
           { %>
        <tr>
            <td class="Left" colspan="2">
                Curso:
            </td>
            <td class="Right">
                <%=Model.First().Cobranca.Curso.nome%>
            </td>
        </tr>
        <%} %>
        <tr>
            <td class="Center" colspan="3">
               -------------------------------------------------
            </td>
        </tr>
        <tr>
            <td class="Left" colspan="2">
                Cobrança:
            </td>
            <td class="Right">
                <%=Model.First().Cobranca.Taxa.nome == "" ? "Mensalidade" : Model.First().Cobranca.Taxa.nome %>
            </td>
        </tr>
        <tr>
            <td class="Left" colspan="2">
                Valor:
            </td>
            <td class="Right">
              <span class="valor"><%=Model.First().Cobranca.Taxa.valor == 0 ? Model.First().Cobranca.Curso.valor : Model.First().Cobranca.Taxa.valor%></span>
            </td>
        </tr>
        <tr>
            <td class="Left" colspan="2">
                Juros:
            </td>
            <td class="Right">
                <span class="valor"><%=Model.First().Cobranca.juros %></span>
            </td>
        </tr>
        <tr>
            <td class="Left" colspan="2">
                Valor Total:
            </td>
            <td class="Right">
               <span class="valor"><%=Model.First().Cobranca.valorTotal %></span>
            </td>
        </tr>
        <tr>
            <td class="Center" colspan="3">
                -------------------------------------------------
            </td>
        </tr>
        <tr>
            <td class="Left">
                Pagamentos
            </td>
        </tr>
        <% foreach (Pagamento p in Model)
           { %>
            <tr>
                <td class="Left">
                    Valor:
                </td>
                <td class="Center">
                    <span class="formaPag"><%=p.formaPag %></span>
                </td>
                <td class="Right">
                    <span class="valor"><%=p.valor %></span>
                </td>
            </tr>
        <% } %>
        <tr>
            <td class="Left">
                Total Pago:
            </td>
            <td colspan="2" class="Right">
               <span class="valor"><%=Model.First().Cobranca.valorTotal %></span>
            </td>
        </tr>
        <tr>
            <td colspan="3">
             &nbsp;
            </td>
        </tr>
        <tr>
            <td class="Left">
               Dt.Pagamento:
            </td>
            <td colspan="2" class="Right">
                <div id="data"></div>
            </td>
        </tr>
    </table>
</body>
</html>
