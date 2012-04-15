<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Usuario>" %>

<%@ Import Namespace="Persistence.Entity" %>

<% Usuario usuario = Model; %>

<% if (usuario.login != null)
   { %>
        <%= usuario.login %>
<% }
   else
   { %>
        Não
<% } %>