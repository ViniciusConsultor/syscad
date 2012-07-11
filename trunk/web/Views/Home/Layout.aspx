<%@ Page Language="C#" %>
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

         var addTab = function (id, url, title) {
             var tab = TabPanel1.getComponent(id);

             var tabPanel = Ext.getCmp("TabPanel1");

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
                     tab.reload();
                     if (item) {
                         TreePanel1.setSelection(item);
                     }
                 }, this);
             }

             tabPanel.setActiveTab(tab);
         }

         var carregaIcons = function () {
             Ext.net.ResourceMgr.registerIcon(["UserSuitBlack", "Folder", "ApplicationFormAdd", "ApplicationCascade", "User", "MoneyAdd", "MoneyDollar", "ApplicationDelete", "Accept", "Report", "BookAddresses", "BookOpen", "Money", "BookOpenMark", "Vcard", "Clock", "ApplicationAdd", "MoneyDelete", "UserEarth"]);
         }

         var GetSession = function (session) {
             var r = $.get("/Home/GetSession", { session: session }, function (result) {
                 return result.responseText                 
             });
             return r.responseText;
         }
    </script>
</head>

<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" >
        <Listeners>
             <DocumentReady Handler="carregaIcons();" />
        </Listeners>        
    </ext:ResourceManager>
    <ext:Viewport ID="ViewPort1" runat="server">
        <Items> 
            <ext:BorderLayout ID="BorderLayout1" runat="server">
                <North>
                    <ext:Panel 
                        ID="pnlInformation" 
                        runat="server">
                        <Content>
                            <div id="bar_login">
                                <div id="left_inside_bar_login">
                                    <ul>
                                        <li><img src="../../Content/imagens/logo_syscad_peq.png" alt="SysCad" /></li>
                                        <li><span>SysCad</span></li>
                                    </ul>
                                </div>
                                <div id="right_inside_bar_login">
                                    <ul>
                                        <li>Olá, <%= Session["login_usuario"]%> - <a href="/Home/Logout" title="Sair do SysCad">Sair</a></li>
                                    </ul>
                                </div>
                            </div>                            
                        </Content>
                    </ext:Panel>
                </North>
                <West Collapsible="true" MinWidth="175" Split="true">
                       <ext:TreePanel 
                            ID="TreePanel1"
                            runat="server" 
                            Height="300" 
                            Width="290"
                            UseArrows="true"
                            AutoScroll="true"
                            Animate="true"
                            EnableDD="false"
                            ContainerScroll="true"
                            RootVisible="true"
                            RemoteJson="true"
                            Title="Menu"
                            Icon="Cog"
                            Collapsible="true"                                                                                                         
                            >       
                            <TopBar>
                                <ext:Toolbar ID="Toolbar1" runat="server">
                                    <Items>
                                        <ext:ToolbarTextItem ID="ToolbarTextItem1" runat="server" Text="Filter:" />
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

                            <Loader>
                                <ext:TreeLoader DataUrl="/Home/CarregaMenu" RequestMethod="POST" PreloadChildren="true"/>
                            </Loader>                                        
                            <Root>
                                <ext:AsyncTreeNode NodeID="0" Text="SysCad" Icon="Application" AutoDataBind="true" Expanded="true" />  
                            </Root>
                    </ext:TreePanel>                                   
                </West>
                <Center>
                    <ext:TabPanel ID="TabPanel1" runat="server" ActiveTabIndex="0">
                        <Items>
                            <ext:Panel 
                                ID="tabPanel" 
                                runat="server" 
                                Title="Bem Vindo" 
                                Padding="0">
                                <Content>
                                    <img style="width:100%;" src="../../Content/imagens/syscad.png" alt="Bem Vindo" />
                                </Content>
                                </ext:Panel>
                                
                        </Items>
                    </ext:TabPanel>
                </Center>
            </ext:BorderLayout>
        </Items>
   </ext:Viewport>
</body>
</html>

<% }
   else
   {
     %>
     <script type="text/javascript">
         location.href = "/Home/";
     </script>
<% } %>