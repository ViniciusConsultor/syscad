<%@ Page Language="C#"  Inherits="System.Web.Mvc.ViewPage<DataTable>" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Xml.Xsl" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Linq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
  



    
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>GridPanel using DataTable with Paging and Remote Reloading - Ext.NET Examples</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

        var exportData = function (format) {
            FormatType.setValue(format);
            var store = GridPanel1.getStore();
            store.directEventConfig.isUpload = true;


            store.submitData();

            store.directEventConfig.isUpload = false;
        };

        var submitValue = function (grid, hiddenFormat, format) {
            hiddenFormat.setValue(format);
            grid.submitData(false);
        };


        var salvar = function () {
            winNovo.hide();
            GridPanel1.el.mask('Salvando', 'x-mask-loading');
            this.formulario.getForm().submit({
                url: '/Curso/Index',
                params: {
                    action: 'insert'
                },
                success: function (form, action) {
                    if (action.result.success) {
                        GridPanel1.el.unmask();
                        GridPanel1.reload();
                    }
                },

                failure: function (form, action) {
                    winNovo.el.unmask();
                    Ext.Msg.alert('Erro', action.result.message);
                },
                scope: this
            })
        };


        /*var salvar = function () {

            if (formulario.getForm().isValid()) {
                winNovo.el.mask('Salvando', 'x-mask-loading');
                formulario.getForm().submit({
                    url: '/Curso/Save',
                   
                    success: function (form, action) {
                        if (action.result.success) {
                            Ext.Msg.show({
                                title: 'Sucesso',
                                msg: 'Curso cadastrado com sucesso',
                                buttons: Ext.Msg.OK
                            });
                            winNovo.el.mask();
                            winNovo.hide();
                            //cursoStore.reload();

                        }
                    },
                    failure: function (form, action) {
                        winNovo.el.mask();
                        Ext.Msg.alert('Erro', action.result.message);
                    }
                    
                });
            } else {
                Ext.Msg.alert('Atenção', 'Existem campos inválidos');
            }
        };*/
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <ext:Hidden ID="FormatType" runat="server" />

        <ext:GridPanel 
            ID="GridPanel1"
            runat="server" 
            Title="Cursos" 
            Width="1181" 
            Height="705"
            OnRefreshData="/Curso/FindAll">
            <Store>
                <ext:Store 
                    ID="Store1" 
                    runat="server">
                    <Proxy>
                        <ext:HttpProxy Json="true" Method="GET" Url="/Curso/FindAll" AutoDataBind="true" />
                    </Proxy>
                    <Reader>
                        <ext:JsonReader Root="cursos" TotalProperty="totalReg">
                            <Fields>
                                <ext:RecordField Name="nome" Type="String" />
                                <ext:RecordField Name="descricao" Type="String" />
                                <ext:RecordField Name="valor" Type="Float" />
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome">
                        <Editor>
                            <ext:TextField ID="TextField1" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="descricao" Header="Descrição" DataIndex="descricao">
                        <Editor>
                            <ext:TextField ID="TextField3" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column Header="Valor" Width="75" DataIndex="valor">
                        <Renderer Format="UsMoney" />
                        <Editor>
                            <ext:TextField ID="TextField2" runat="server" />
                        </Editor>
                    </ext:Column>
                    
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" />
            </SelectionModel>
            <LoadMask ShowMask="true" />
            <TopBar>
                <ext:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <ext:Button ID="btnNovo" runat="server" Text="Novo" Icon="Add">
                            <Listeners> 
                                <Click Handler="winNovo.show()" />
                            </Listeners>
                        </ext:Button>
                        <ext:ToolbarFill ID="ToolbarFill1" runat="server" />

                        <ext:Button ID="Button1" runat="server" Text="To XML" Icon="PageCode">
                            <Listeners> 
                                <Click Handler="submitValue(#{GridPanel1}, #{FormatType}, 'xml');" />
                            </Listeners>
                        </ext:Button>
                        
                        <ext:Button ID="Button2" runat="server" Text="To Excel" Icon="PageExcel">
                            <Listeners>
                                <Click Handler="exportData('xls');" />
                            </Listeners>
                        </ext:Button>
                        
                        <ext:Button ID="Button3" runat="server" Text="To CSV" Icon="PageAttach">
                            <Listeners>
                                <Click Handler="exportData('csv');" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <BottomBar>
                <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" />
            </BottomBar>
        </ext:GridPanel>



        <ext:Window 
            ID="winNovo" 
            runat="server" 
            Icon="ApplicationAdd" 
            Title="Novo Curso" 
            Hidden="true"
            X="250"
            Y="100"
            Layout="FormLayout"
            AutoHeight="true"
            Frame="true"
            Width="300"
            Modal="true"
            >
            <Items>
                <ext:FormPanel ID="formulario" runat="server">

                    <Items>
                        <ext:TextField ID="txtNome" runat="server" FieldLabel="Nome" InputType="Text" Width="175" AllowBlank="false" AutoFocus="true" />
                        <ext:TextField ID="txtDescricao" runat="server" FieldLabel="Descrição" InputType="Text" Width="175" AllowBlank="false" />                            
                        <ext:NumberField ID="txtValor" runat="server" FieldLabel="Valor" Width="175" Vtype="numberrange" AllowBlank="false" />
                    </Items>

                    <BottomBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ToolbarFill />
                                    <ext:Button ID="btnSalvar" Text="Salvar" Icon="Disk" runat="server">
                                        <Listeners>
                                            <Click Handler="salvar()" />
                                        </Listeners>
                                    </ext:Button>
                            </Items>
                        </ext:Toolbar>  
                    </BottomBar>

                </ext:FormPanel>
            </Items>

        </ext:Window>



    </form>
</body>
</html>