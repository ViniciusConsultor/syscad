<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Curso>>" %>

<%@ Import Namespace="Persistence.Entity" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Curso</title>
</head>
<body>
    <table border="1">
        <tr>
            <th></th>
            <th>
                IdCurso
            </th>
            <th>
                Nome
            </th>
            <th>
                Descricao
            </th>
            <th>
                Valor
            </th>
            <th>
                Status
            </th>
        </tr>

    <% foreach (Curso item in Model) { %>
    
        <tr>
            <td>
                <%: Html.ActionLink("Edit", "Edit", new { /* id=item.PrimaryKey */ }) %> |
                <%: Html.ActionLink("Details", "Details", new { /* id=item.PrimaryKey */ })%> |
                <%: Html.ActionLink("Delete", "Delete", new { /* id=item.PrimaryKey */ })%>
            </td>
            <td>
                <%: item.idCurso %>
            </td>
            <td>
                <%: item.nome %>
            </td>
            <td>
                <%: item.descricao %>
            </td>
            <td>
                <%: String.Format("{0:F}", item.valor) %>
            </td>
            <td>
                <%: item.status %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%: Html.ActionLink("Create New", "Create") %>
    </p>

</body>
</html>

