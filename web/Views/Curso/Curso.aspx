<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cursos</title>
    
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    

    <script type="text/javascript">

        var genericParamsRecord = "record.data."; //Não mecher
        var titulo = "Curso";
        var metodoExcluir = "/Curso/Excluir";
        var parametrosExcluir = genericParams + "idCurso";
        var makeParams = genericParamsRecord + metodoExcluir; //Não mecher

        function salvar() {
            winNovo.hide();
            GridPanel.el.mask('Salvando', 'x-mask-loading');
            $.post('/Curso/Save', $("#NovoCurso").serialize(), function (valor) {
                //Ext.Msg.alert('Curso salvo com sucesso!');
                Ext.Msg.show({
                    title: 'Sucesso',
                    msg: 'Curso cadastrado com sucesso',
                    buttons: Ext.Msg.OK
                });
                GridPanel.reload();
                GridPanel.el.unmask();
            });

        };

        function editar() {

            Ext.Msg.show({
                title: 'Como Editar',
                msg: 'Para editar qualquer registro basta selecionar o curso que deseja editar e dar dois cliques na em cima do registro que deseja alterar, ou se preferir pressione o botão ENTER.',
                buttons: Ext.Msg.OK
            });

        }

        function salvarAlteracoes(id, field, newValue) {

            GridPanel.el.mask('Alterando curso', 'x-mask-loading');

            $.post('/Curso/Editar', { idCurso: id, campo: field, valor: newValue }, function () {
                GridPanel.el.unmask();
            });

        };

       var startEditing = function (e) {
            if (e.getKey() === e.ENTER) {
                var grid = GridPanel,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

                grid.startEditing(index, 1);
            }
        };

        var afterEdit = function (e) {
            /*
            Properties of 'e' include:
            e.grid - This grid
            e.record - The record being edited
            e.field - The field name being edited
            e.value - The value being set
            e.originalValue - The original value for the field, before the edit.
            e.row - The grid row index
            e.column - The grid column index
            */
            salvarAlteracoes(e.record.data.idCurso, e.field, e.value);
            var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;
            Ext.Msg.notify('Curso editado com sucesso!', mensagem);
            GridPanel.store.commitChanges();
        };
    </script>
    <script src="../../Scripts/CRUD.js" type="text/javascript"></script>

</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" RemoveViewState="true" IDMode="Explicit" />
    
    <ext:GridPanel 
        ID="GridPanel"
        runat="server" 
        Title="Gerenciar Curso" 
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
                    <ext:Column ColumnID="idCurso" Header="Id" DataIndex="idCurso" Hidden="true" />

                    <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" >
                        <Editor>
                            <ext:TextField ID="txtNomeEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="descricao" Header="Descrição" DataIndex="descricao">
                        <Editor>
                            <ext:TextField ID="txtDescricaoEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column Header="valor" Width="75" DataIndex="valor">
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
                            <Click Handler="winNovo.show()" />
                        </Listeners>
                    </ext:Button>
                    <ext:Button ID="Button6" runat="server" Text="Excluir" Icon="Delete">
                        <Listeners> 
                            <Click Handler="excluirRegistro()" />
                        </Listeners>
                    </ext:Button>
                    <ext:Button ID="Button1" runat="server" Text="Editar" Icon="Pencil">
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
    
    <form id="NovoCurso" runat="server" >
    
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