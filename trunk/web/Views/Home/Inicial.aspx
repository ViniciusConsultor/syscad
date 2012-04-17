<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>GroupTabPanel - Ext.NET Examples</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

        var shortTestMarkup = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.";

    </script>

    <style type="text/css">
        .custom {
            background-color : green;
            border : solid 5px gray;
        }
        .custom .x-grouptabs-corner {
            background-image : none;
        }
        
        .custom ul.x-grouptabs-strip li.x-grouptabs-strip-active {
            background : #DBDBDB;
            border : none !important;
        }
        
        .custom ul.x-grouptabs-strip li.x-grouptabs-main {
            border : solid 1px white;
        }
        
        .custom li.x-grouptabs-strip-active ul.x-grouptabs-sub li.x-grouptabs-strip-active {
            background-color : white;
        }
    </style>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" />
    
    <ext:Viewport ID="Viewport1" runat="server" Layout="border">
        <Items>
            <ext:GroupTabPanel ID="GroupTabPanel1" runat="server" Region="Center" TabWidth="130" ActiveGroupIndex="0">
                <Groups>
                    
                    <ext:GroupTab ID="GroupTab1" runat="server" MainItem="1" >
                        <Items>
                           <ext:Panel ID="Panel1"
                                runat="server" 
                                Title="Gerenciar" 
                                Icon="Group" 
                                TabTip="Users tabtip" 
                                StyleSpec="padding: 10px;" AutoScroll="true" Frame="true"
                                Html="<iframe width='100%' height='100%' frameborder='0' scrolling='yes' src='/Curso/'></iframe>" 
                            />

                            <ext:Portal ID="Portal1" 
                                runat="server" 
                                Title="Cursos" 
                                TabTip="Gerenciar Cursos" 
                                Layout="Column">
                            </ext:Portal> 

                            <ext:Panel ID="Panel2"
                                runat="server" 
                                Title="Associar" 
                                Icon="BookKey" 
                                TabTip="Users tabtip" 
                                StyleSpec="padding: 10px;"
                                Frame="true"
                                Html="TESTE" 
                            />

                                                                                 
                        </Items>
                    </ext:GroupTab>

                </Groups>
            </ext:GroupTabPanel>

            <ext:Panel ID="Panel7" runat="server" Region="South" Margins="5 10 10 10" ButtonAlign="Left" BodyBorder="false">
                <TopBar>
                    <ext:Toolbar ID="Toolbar1" runat="server" Flat="true">
                        <Items>

                            <ext:SplitButton ID="SplitButton1"
                                runat="server" 
                                Icon="Tab" 
                                ToggleGroup="group"
                                Pressed="true" 
                                Text="Cursos">
                                <Menu>
                                    <ext:Menu ID="Menu1" runat="server">
                                        <Items>
                                           
                                            <ext:MenuItem ID="MenuItem1" runat="server" Text="Gerenciar" Icon="Group">
                                                <Listeners>
                                                    <Click Handler="GroupTabPanel1.activeGroup.setActiveTab(0);" />
                                                </Listeners>
                                            </ext:MenuItem>

                                            <ext:MenuItem ID="MenuItem2" runat="server" Text="Associar" Icon="BookKey">
                                                <Listeners>
                                                    <Click Handler="GroupTabPanel1.activeGroup.setActiveTab(2);" />
                                                </Listeners>
                                            </ext:MenuItem>

                                        </Items>
                                    </ext:Menu>
                                </Menu>
                                <Listeners>
                                    <Click Handler="GroupTabPanel1.setActiveGroup(0);" />
                                </Listeners>
                            </ext:SplitButton>

                            <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" />

                            <ext:ToolbarFill ID="ToolbarFill1" runat="server" />
                            <ext:Button ID="Button1" runat="server" Text="Set Custom Css Class" Icon="BulletBlue">
                                <Listeners>
                                    <Click Handler="GroupTabPanel1.addClass('custom'); this.disable(); Button2.enable();" />
                                </Listeners>
                            </ext:Button>
                            
                            <ext:Button ID="Button2" runat="server" Text="Remove Customer Css Class" Disabled="true" Icon="BulletBlack">
                                <Listeners>
                                    <Click Handler="GroupTabPanel1.removeClass('custom'); this.disable(); Button1.enable();" />
                                </Listeners>
                            </ext:Button>

                        </Items>
                    </ext:Toolbar>
                </TopBar>
            </ext:Panel>

        </Items>
    </ext:Viewport>
</body>
</html>