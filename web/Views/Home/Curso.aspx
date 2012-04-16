<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Curso>>" MasterPageFile="~/Views/Shared/Site.Master" %>

<%@ Import Namespace="Persistence.Entity" %>

<asp:Content ID="GridCurso" ContentPlaceHolderID="MainContent" runat="server">

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

</asp:Content>

