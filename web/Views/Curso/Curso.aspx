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

    var formataDinheiro = function (num) {
        num = num.toString().replace(/\R$|\,/g, '');
        if (isNaN(num)) num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num * 100 + 0.50000000001);
        cents = num % 100;
        num = Math.floor(num / 100).toString();
        if (cents < 10) cents = "0" + cents;
        for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
            num = num.substring(0, num.length - (4 * i + 3)) + '.' + num.substring(num.length - (4 * i + 3));
        return (((sign) ? '' : '-') + 'R$ ' + num + ',' + cents);
    }
</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>

<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" RemoveViewState="true" IDMode="Explicit" />
<ext:Viewport ID="ViewPort1" runat="server">
  <Items>
    <ext:BorderLayout ID="BorderLayout1" runat="server">
    
    <Center>
                    <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Gerenciar Cursos" Icon="User" Layout="Fit">
                        <Items>
                            <ext:GridPanel 
                                ID="GridPanel"
                                runat="server"  
                                StripeRows="true"
                                TrackMouseOver="true"
                                Width="1181" 
                                Height="704"
                                AutoExpandColumn="descricao"
                                >
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
                                                    <ext:RecordField Name="idCurso" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                    <ext:RecordField Name="descricao" Type="String" />
                                                    <ext:RecordField Name="valor" Type="Float" />
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
                                            <ext:RowNumbererColumn />
                                            <ext:Column ColumnID="idCurso" Header="Id" DataIndex="idCurso" Hidden="true" />

                                            <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" Width="150" >
                                                <Editor>
                                                    <ext:TextField ID="txtNomeEditar" runat="server" MaxLength="50" AllowBlank="false"/>
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="descricao" Header="Descrição" DataIndex="descricao" Width="400">
                                                <Editor>
                                                    <ext:TextField ID="txtDescricaoEditar" runat="server" MaxLength="100" AllowBlank="true" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column Header="Valor" Width="100" DataIndex="valor">
                                                <Renderer Fn="formataDinheiro" />
                                                <Editor>
                                                    <ext:NumberField ID="txtValorEditar" runat="server" MaxLength="35" AllowBlank="false" />
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
                                                    <Click Handler="novo(formulario)" />
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

                                        </Items>
                                    </ext:Toolbar>            
                                </TopBar>
                                <BottomBar>
                                    <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="10" />
                                </BottomBar>
                            </ext:GridPanel>
                        </Items>
                    </ext:Panel>
                </Center>

            </ext:BorderLayout>
        </Items>
    </ext:Viewport>

    <form id="Novo" runat="server" >
    
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
                            <ext:TextField ID="txtNome" runat="server" FieldLabel="Nome" InputType="Text" Width="175" AllowBlank="false" MaxLength="50" />
                            <ext:TextField ID="txtDescricao" runat="server" FieldLabel="Descrição" InputType="Text" Width="175" AllowBlank="true" MaxLength="100" />                            
                            <ext:NumberField ID="txtValor" runat="server" FieldLabel="Valor" Width="175" AllowBlank="false" />
                        </Items>

                        <BottomBar>
                            <ext:Toolbar ID="Toolbar3" runat="server">
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
