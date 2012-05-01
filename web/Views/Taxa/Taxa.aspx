<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title>Modulos</title>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
</head>

<script type="text/javascript">

    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER

</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>

<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" RemoveViewState="true" IDMode="Explicit" />
    
    <ext:GridPanel 
        ID="GridPanel"
        runat="server" 
        Title="Gerenciar Taxas" 
        StripeRows="true"
        TrackMouseOver="true"
        Width="1181"
        Height="704"
        AutoExpandColumn="descricao">
        <Store>
            <ext:Store 
                ID="Store1" 
                runat="server">
                <Proxy>
                    <ext:HttpProxy Json="true" Method="GET" Url="/Taxa/FindAll" AutoDataBind="true" />
                </Proxy>
                <Reader>
                    <ext:JsonReader Root="taxas" TotalProperty="totalReg">
                        <Fields>
                            <ext:RecordField Name="idTaxa" Type="Int" />
                            <ext:RecordField Name="nome" Type="String" />
                            <ext:RecordField Name="descricao" Type="String" />
                            <ext:RecordField Name="valor" Type="String" />
                        </Fields>
                    </ext:JsonReader>
                </Reader>
            </ext:Store>
        </Store>
        <Listeners>
            <KeyDown Fn="startEditing" />
            <AfterEdit Fn="afterEdit" />
        </Listeners>
        <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                <Columns>
                    <ext:Column ColumnID="idTaxa" Header="Id" DataIndex="idFuncionario" Hidden="true" />

                    <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" >
                        <Editor>
                            <ext:TextField ID="txtNomeEditar" runat="server" />
                        </Editor>
                    </ext:Column>

                    <ext:Column ColumnID="descricao" Header="Descrição" DataIndex="descricao" >
                        <Editor>
                            <ext:TextField ID="txtDescricaoEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                    
                    <ext:Column ColumnID="valor" Header="Valor" DataIndex="valor" >
                        <Renderer Format="UsMoney" />
                        <Editor>
                            <ext:TextField ID="txtValorEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                </Columns>
        </ColumnModel>
        <SelectionModel>
            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
        </SelectionModel>

        <TopBar>
            <ext:Toolbar ID="Toolbar2" runat="server">
                <Items>
                    <ext:Button ID="Button4" runat="server" Text="Novo" Icon="Add">
                        <Listeners> 
                            <Click Handler="novo()" />
                        </Listeners>
                    </ext:Button>
                    <ext:Button ID="Button6" runat="server" Text="Excluir" Icon="Delete">
                        <Listeners> 
                            <Click Handler="excluirRegistro()" />
                        </Listeners>
                    </ext:Button>
                    <ext:Button ID="Button1" runat="server" Text="Editar" Icon="Information">
                        <Listeners> 
                            <Click Handler="editar()" />
                        </Listeners>
                    </ext:Button>

                    <ext:ToolbarFill ID="ToolbarFill2" runat="server" />

                    <ext:Button ID="Button7" runat="server" Text="To XML" Icon="PageCode">
                        <Listeners> 
                            <Click Handler="submitValue(#{GridPanelEdicao}, #{FormatType}, 'xml');" />
                        </Listeners>
                    </ext:Button>
                        
                    <ext:Button ID="Button8" runat="server" Text="To Excel" Icon="PageExcel">
                        <Listeners>
                            <Click Handler="exportData('xls');" />
                        </Listeners>
                    </ext:Button>
                        
                    <ext:Button ID="Button9" runat="server" Text="To CSV" Icon="PageAttach">
                        <Listeners>
                            <Click Handler="exportData('csv');" />
                        </Listeners>
                    </ext:Button>
                </Items>
            </ext:Toolbar>            
        </TopBar>
        <BottomBar>
            <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="10" />
        </BottomBar>
    </ext:GridPanel>


    
    <form id="Novo" runat="server" >
    
        <ext:Window 
                ID="winNovo" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Nova Taxa" 
                Hidden="true"
                X="250"
                Y="100"
                Layout="FormLayout"
                AutoHeight="true"
                Frame="true"
                Width="500"
                Modal="true"
                >
                <Items>
                    <ext:FormPanel ID="formulario" runat="server">

                        <Items>
                            <ext:TextField ID="txtNome" runat="server" FieldLabel=" Nome" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtDescricao" runat="server" FieldLabel=" Descricao" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtValor" runat="server" FieldLabel=" Valor" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                        </Items>

                        <BottomBar>
                            <ext:Toolbar ID="Toolbar1" runat="server">
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