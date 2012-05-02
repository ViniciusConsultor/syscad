﻿<%@ Page Language="C#" %>
<%@ Import Namespace="TreeNode=Ext.Net.TreeNode" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<% if (Session["login_usuario"]  != null)
   { %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SysCad - Seja bem vindo <%= Session["login_usuario"] %></title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script src="../../Scripts/funcoes_ready.js" type="text/javascript"></script>
    <link href="../../Content/MasterPage.css" rel="stylesheet" type="text/css" />

     <script type="text/javascript">

         var filterTree = function (el, e) {
             var tree = TreePanel1,
                text = this.getRawValue();

             tree.clearFilter();

             if (Ext.isEmpty(text, false)) {
                 return;
             }

             if (e.getKey() === Ext.EventObject.ESC) {
                 clearFilter();
             } else {
                 var re = new RegExp(".*" + text + ".*", "i");

                 tree.filterBy(function (node) {
                     return re.test(node.text);
                 });
             }
         };

         var clearFilter = function () {
             var field = TriggerField1,
                tree = TreePanel1;

             field.setValue("");
             tree.clearFilter();
             tree.getRootNode().collapseChildNodes(true);
             tree.getRootNode().ensureVisible();
         };

        var addTab = function (tabPanel, id, url, title) {
            var tab = TabPanel1.getComponent(id);

            if (!tab) {
                tab = tabPanel.add({
                    id: id,
                    title: title,
                    closable: true,
                    autoLoad: {
                        showMask: true,
                        url: url,
                        mode: "iframe",
                        maskMsg: "Carregando " + title + "..."
                    }
                });

                tab.on("activate", function () {
                    var item = TreePanel1.items.get(id + "_item");

                    if (item) {
                        TreePanel1.setSelection(item);
                    }
                }, this);
            }

            tabPanel.setActiveTab(tab);
        }

        for (i in document.body) {
            alert(i);
        }
    </script>
</head>

<body>

    <div id="bar_login">
        <div id="left_inside_bar_login">
            <ul>
                <li><img src="../../Content/imagens/logo_syscad_peq.png" alt="SysCad" /></li>
                <li>SysCad</li>
                <li><img src="../../Content/imagens/msg_user.png" alt="Mensagem" /></li>
            </ul>
        </div>
        <div id="right_inside_bar_login">
            <ul>
                <li id="user_perfil_bar" exibindo="false">Olá, <%= Session["login_usuario"]%> <img src="../../Content/imagens/user_perfil.jpg" alt="Usuario" /></li>
            </ul>
        </div>
    </div>

    <ext:ResourceManager ID="ResourceManager1" runat="server" />

    <ext:Panel ID="Panel2" runat="server" Height="600">
        <Items>
            <ext:BorderLayout ID="BorderLayout1" runat="server">
                <West Collapsible="true" MinWidth="175" Split="true">
                       <ext:TreePanel 
                            ID="TreePanel1"
                            runat="server" 
                            Height="300" 
                            Width="250"
                            UseArrows="true"
                            AutoScroll="true"
                            Animate="true"
                            EnableDD="true"
                            ContainerScroll="true"
                            RootVisible="true"
                            >       
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:ToolbarTextItem runat="server" Text="Filter:" />
                                        <ext:ToolbarSpacer />
                                        <ext:TriggerField ID="TriggerField1" runat="server" EnableKeyEvents="true">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" />
                                            </Triggers>
                            
                                            <Listeners>
                                                <KeyUp Fn="filterTree" Buffer="250" />
                                                <TriggerClick Handler="clearFilter();" />
                                            </Listeners>
                                        </ext:TriggerField>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Root>
                                <ext:TreeNode Text="SysCad" Expanded="true" Icon="Application">
                                    <Nodes>
                                        <ext:TreeNode Icon="Folder" Expanded="true" Text="Cadastro">
                                            <Nodes>
                                                <ext:TreeNode Icon="UserSuitBlack" Expanded="true" Text="Cargo">
                                                    <Listeners>
                                                        <Click Handler="addTab(#{TabPanel1},'idAbaCargo','/Cargo/Cargo','Cargo')" />
                                                    </Listeners>
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="ApplicationFormAdd" Expanded="true" Text="Curso">
                                                    <Listeners>
                                                        <Click Handler="addTab(#{TabPanel1},'idAbaCurso','/Curso/Curso','Curso')" />
                                                    </Listeners>
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="UserAlert" Expanded="true" Text="Funcionario">
                                                    <Listeners>
                                                        <Click Handler="addTab(#{TabPanel1},'idAbaFuncionario','/Funcionario/Funcionario','Funcionario')" />
                                                    </Listeners>
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="ApplicationDouble" Expanded="true" Text="Modulo">
                                                    <Listeners>
                                                        <Click Handler="addTab(#{TabPanel1},'idAbaModulo','/Modulo/Modulo','Modulo')" />
                                                    </Listeners>
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="User" Expanded="true" Text="Pessoa">
                                                    <Listeners>
                                                        <Click Handler="addTab(#{TabPanel1},'idAbaPessoa','/Pessoa/Pessoa','Pessoa')" />
                                                    </Listeners>
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="MoneyAdd" Expanded="true" Text="Taxas">
                                                    <Listeners>
                                                        <Click Handler="addTab(#{TabPanel1},'idAbaTaxas','/Taxa/Taxa','Taxas')" />
                                                    </Listeners>
                                                </ext:TreeNode>
                                            </Nodes>
                                        </ext:TreeNode>
                                        <ext:TreeNode Icon="Folder" Expanded="true" Text="Coodenação">
                                            <Nodes>
                                                <ext:TreeNode Icon="ApplicationAdd" Expanded="true" Text="Abertura de Turma">                               
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="MoneyDollar" Expanded="true" Text="Processar cobrança de mensalidade">                                         
                                                </ext:TreeNode>
                                            </Nodes>
                                        </ext:TreeNode>
                                         <ext:TreeNode Icon="Folder" Expanded="true" Text="Diretoria">
                                            <Nodes>
                                                <ext:TreeNode Icon="Accept" Expanded="true" Text="Autorizar abertura de turma">
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="Report" Expanded="true" Text="Relatorio de Ex-Alunos">
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="Report" Expanded="true" Text="Relatorio de Inadimplentes">
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="Report" Expanded="true" Text="Relatorio de cursos mais cursados">
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="Report" Expanded="true" Text="Relatorio de especialização dos professores">
                                                </ext:TreeNode>
                                            </Nodes>
                                        </ext:TreeNode>
                                         <ext:TreeNode Icon="Folder" Expanded="true" Text="Professor">
                                             <Nodes>
                                                <ext:TreeNode Icon="BookAddresses" Expanded="true" Text="Lançar Nota/Falta">
                                                     <Listeners>
                                                        <Click Handler="addTab(#{TabPanel1},'idAba3','/Professor/lancarNotaFalta','Lançar Nota/Falta')" />
                                                    </Listeners>
                                                </ext:TreeNode>
                                            </Nodes>
                                        </ext:TreeNode>
                                        <ext:TreeNode Icon="Folder" Expanded="true" Text="Recepção">
                                            <Nodes>
                                                <ext:TreeNode Icon="Clock" Expanded="true" Text="Consultar disponibilidade horário/turma">
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="BookOpen" Expanded="true" Text="Realizar Matrícula">
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="Money" Expanded="true" Text="Realizar Pagamento">
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="BookOpenMark" Expanded="true" Text="Realizar Pré-Matrícula">
                                                </ext:TreeNode>
                                                <ext:TreeNode Icon="Vcard" Expanded="true" Text="Vincular Aluno/Turma">
                                                </ext:TreeNode>
                                            </Nodes>
                                        </ext:TreeNode>
                                    </Nodes>
                                </ext:TreeNode>
                            </Root>
                            </ext:TreePanel>
                                   

                </West>
                <Center>
                    <ext:TabPanel ID="TabPanel1" runat="server" ActiveTabIndex="0">
                        <Items>
                            <ext:Panel 
                                ID="Tab1" 
                                runat="server" 
                                Title="Bem Vindo" 
                                Padding="6"
                                Html='
                                  <h1 class="h1_titulo">Bem Vindo ao SysCad</h1>
                                  <div id="sidebar_left">
                                    <div class="titulo_bloco"><h2 class="h2_titulo_bloco">Novidade</h2></div>
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                  </div>
                                  <div id="sidebar_center">
                                    <div class="titulo_bloco"><h2 class="h2_titulo_bloco">Atualizações</h2></div>
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                  </div>
                                  <div id="sidebar_right">
                                    <div class="titulo_bloco"><h2 class="h2_titulo_bloco">Notícias</h2></div>
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                    <div class="info">
                                      <h3 class="h3_titulo_info">Título da notícia</h3>
                                      <p class="p_descricao_info">Descrição da notícia, informando uma breve descrição do que sera falado.</p>
                                      <span class="span_data_info">Data de publicação: 19/04/2012</span>
                                    </div><!--Fim class info-->
                                  </div>'
                                />
                        </Items>
                    </ext:TabPanel>
                </Center>
            </ext:BorderLayout>
        </Items>
    </ext:Panel>
       
</body>
</html>

<% }
   else
   {
     %>
     <script>
         location.href = "/Home/";
     </script>
<% } %>