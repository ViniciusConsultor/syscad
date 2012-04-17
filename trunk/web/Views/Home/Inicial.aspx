<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>Adding Tabs On The Fly - Ext.NET Examples</title>

    <ext:XScript ID="XScript1" runat="server">
        <script type="text/javascript">

            var addTab = function (tabPanel, id, url, title) {
                var tab = tabPanel.getComponent(id);

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
    </ext:XScript>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <ext:Window ID="Window1" 
            runat="server" 
            Title="SysCad"
            Width="1420" 
            Height="700" 
            Icon="Link"
            Closable="false"
            Draggable="false"
            Region="North"
            Layout="BorderLayout">
            <Items>
                <ext:MenuPanel 
                    ID="MenuPanel1" 
                    runat="server" 
                    Width="200" 
                    Region="West">
                    <Menu ID="Menu1" runat="server">
                        <Items>
                            <ext:MenuItem ID="MenuItem1" runat="server" Text="Cursos">
                                <Listeners>
                                    <Click Handler="addTab(#{TabPanel1}, 'idClt', '/Curso/', 'Gerenciar Curso');" />
                                </Listeners>
                            </ext:MenuItem>
                            
                            <ext:MenuSeparator />
                            
                            <ext:MenuItem ID="MenuItem2" runat="server" Text="Ext.NET forums">
                                <Listeners>
                                    <Click Handler="addTab(#{TabPanel1}, 'idGgl', 'http://forums.ext.net');" />
                                </Listeners>
                            </ext:MenuItem>
                            
                        </Items>
                    </Menu>
                </ext:MenuPanel>
                <ext:TabPanel ID="TabPanel1" runat="server" Region="Center" />
            </Items>
        </ext:Window>
    </form>
</body>
</html>

