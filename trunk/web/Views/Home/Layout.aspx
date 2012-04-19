<%@ Page Language="C#" %>
<%@ Import Namespace="TreeNode=Ext.Net.TreeNode" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>TreeNode</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
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
                        maskMsg: "Loading " + url + "..."
                    }
                });

                tab.on("activate", function () {
                    var item = MenuPanel1.menu.items.get(id + "_item");

                    if (item) {
                        MenuPanel1.setSelection(item);
                    }
                }, this);
            }

            tabPanel.setActiveTab(tab);
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
                <li>Olá, <%= Session["login_usuario"] %> <img src="../../Content/imagens/user_perfil.jpg" alt="Usuario" /></li>
            </ul>
        </div>
    </div>

    <ext:ResourceManager ID="ResourceManager1" runat="server" />

    <ext:Panel ID="Panel2" runat="server" Height="735">
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
                                        <ext:TreeNode Icon="ApplicationFormAdd" Expanded="true" Text="Curso">
                                            <Listeners>
                                                <Click Handler="addTab(#{TabPanel1},'idAba1','/Curso/Curso','Curso')" />
                                            </Listeners>
                                        </ext:TreeNode>
                                    </Nodes>
                                    <Nodes>
                                        <ext:TreeNode Icon="User" Expanded="true" Text="Usuario">
                                            <Listeners>
                                                <Click Handler="addTab(#{TabPanel1},'idAba2','/Curso/Curso','Usuario')" />
                                            </Listeners>
                                        </ext:TreeNode>
                                    </Nodes>
                                    <Nodes>
                                        <ext:TreeNode Icon="Book" Expanded="true" Text="Professor">
                                            <Listeners>
                                                <Click Handler="addTab(#{TabPanel1},'idAba3','/Curso/Curso','Professor')" />
                                            </Listeners>
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
                                Title="First Tab" 
                                Padding="6"
                                Html="First Tab"
                                />
                        </Items>
                    </ext:TabPanel>
                </Center>
            </ext:BorderLayout>
        </Items>
    </ext:Panel>
       
</body>
</html>