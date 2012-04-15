<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Usuario>" %>

<%@ Import Namespace="Persistence.Entity" %>

<% Usuario usuario = Model; %>

<% if (usuario != null)
   { %>
        <%= usuario.login %>
<% }
   else
   { %>
        Não
<% } %>