<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BoletoBancario>" %>
<%@ Import Namespace="BoletoNet" %>
<script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("img[alt='Código de Barras']").attr("src", "/ImagemCodigoBarra.ashx?code=<%= Model.Boleto.CodigoBarra.Codigo %>");
        //no caso só vou usar boletos do banco do brasil, tiver que baixar a logo
        $("td.imgLogo img").attr("src", "/Content/Imagens/logo-itau.jpg");
    });
</script>
<%=Model.MontaHtml() %>
