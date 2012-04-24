<%@ Page Language="C#"  %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Funcionário</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>

    <script type="text/javascript">

        function modoEdicao() {
            GridPanelEdicao.reload('yes');
            GridPanelNormal.hide();
            GridPanelEdicao.show();
        };

        function sairModoEdicao() {
            GridPanelNormal.reload();
            GridPanelNormal.show();
            GridPanelEdicao.hide();
        };


        function excluirRegistro() {

            var confirm = Ext.Msg.confirm('Confirmação', 'Tem certeza que deseja excluir o curso?', function (btn) {

                if (btn == 'yes') {
                    if (GridPanelNormal.getSelectionModel().hasSelection()) {

                        GridPanelNormal.el.mask('Excluindo curso', 'x-mask-loading');

                        var record = GridPanelNormal.getSelectionModel().getSelected();

                        $.post('/Curso/Excluir', { idCurso: record.data.idCurso }, function () {
                            GridPanelNormal.reload();
                            GridPanelNormal.el.unmask();
                        });

                    }

                }

            });

        };


        function salvarAlteracoes() {

            if (GridPanelEdicao.getSelectionModel().hasSelection()) {

                GridPanelEdicao.el.mask('Alterando curso', 'x-mask-loading');

                var record = GridPanelEdicao.getSelectionModel().getSelected();

                $.post('/Curso/Editar', { idCurso: record.data.idCurso, Nome: record.data.nome, Descricao: record.data.descricao, Valor: record.data.valor }, function () {
                    GridPanelEdicao.el.unmask();
                });

            }

        };

        function salvar() {
            winNovo.hide();
            GridPanelNormal.el.mask('Salvando', 'x-mask-loading');
            $.post('/Curso/Save', $("#Form1").serialize(), function (valor) {
                //Ext.Msg.alert('Curso salvo com sucesso!');
                Ext.Msg.show({
                    title: 'Sucesso',
                    msg: 'Curso cadastrado com sucesso',
                    buttons: Ext.Msg.OK
                });
                GridPanelNormal.reload();
                GridPanelNormal.el.unmask();
            });

        };

        function carregaGrid() {

            GridPanelEdicao.hide();

        }

    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <ext:Hidden ID="FormatType" runat="server" />

        <ext:GridPanel 
            ID="GridPanelEdicao"
            runat="server" 
            Title="Funcionários" 
            Width="1164" 
            Height="704"
            OnRefreshData="/Funcionario/FindAll"
            >
            <Listeners>
                <BeforeRender Handler="carregaGrid()" />
            </Listeners>
            <Store>
                <ext:Store 
                    ID="Store1" 
                    runat="server">
                    <Proxy>
                        <ext:HttpProxy Json="true" Method="GET" Url="/Funcionario/FindAll" AutoDataBind="true" />
                    </Proxy>
                    <Reader>
                        <ext:JsonReader Root="funcionarios" TotalProperty="totalReg">
                            <Fields>
                                <ext:RecordField Name="idFuncionario" Type="Int" />
                                <ext:RecordField Name="idUsuario" Type="Int" />
                                <ext:RecordField Name="idCargo" Type="Int" />
                                <ext:RecordField Name="idPessoa" Type="Int" />
                                <ext:RecordField Name="salario" Type="Float" />
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                <Columns>
                    <ext:Column ColumnID="idFuncionario" Header="Id" DataIndex="idFuncionario" Hidden="true" />

                    <ext:Column ColumnID="idUsuario" Header="Usuario" DataIndex="idUsuario" AutoDataBind="true" >
                        <Editor>
                            <ext:TextField ID="txtUsuarioEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="idCargo" Header="Cargo" DataIndex="idCargo">
                        <Editor>
                            <ext:TextField ID="txtCargoEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="idPessoa" Header="Pessoa" DataIndex="idPessoa">
                        <Editor>
                            <ext:TextField ID="txtPessoaEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="salario" Header="Salario" DataIndex="salario">
                        <Editor>
                            <ext:TextField ID="txtSalarioEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" >
                    <Listeners> 
                        <BeforeRowSelect Handler="salvarAlteracoes()" />
                    </Listeners>
                </ext:RowSelectionModel>
            </SelectionModel>
            <LoadMask ShowMask="true" />
            <TopBar>
                <ext:Toolbar ID="Toolbar1" runat="server">
                    <Items>

                        <ext:Button ID="btnEditar" runat="server" Text="Modo Edição" Icon="Pencil" Pressed="true">
                            <Listeners> 
                                <Click Handler="sairModoEdicao()" />
                            </Listeners>
                        </ext:Button>
                        
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <BottomBar>
                <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" RefreshText="Esta pagina será recarregada" />
            </BottomBar>
        </ext:GridPanel>


        <ext:GridPanel 
            ID="GridPanelNormal"
            runat="server" 
            Title="Funcionários" 
            Width="1164" 
            Height="705"
            OnRefreshData="/Funcionario/FindAll"
            >
            <Store>
                <ext:Store 
                    ID="Store2" 
                    runat="server">
                    <Proxy>
                        <ext:HttpProxy Json="true" Method="GET" Url="/Funcionario/FindAll" AutoDataBind="true" />
                    </Proxy>
                    <Reader>
                        <ext:JsonReader Root="funcionarios" TotalProperty="totalReg">
                            <Fields>
                                <ext:RecordField Name="idFuncionario" Type="Int" />
                                <ext:RecordField Name="idUsuario" Type="Int" />
                                <ext:RecordField Name="idCargo" Type="Int" />
                                <ext:RecordField Name="idPessoa" Type="Int" />
                                <ext:RecordField Name="salario" Type="Float" />
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                <Columns>
                    <ext:Column ColumnID="idFuncionario" Header="Id" DataIndex="idFuncionario" Hidden="true" />

                    <ext:Column ColumnID="idUsuario" Header="Usuario" DataIndex="idUsuario" AutoDataBind="true" >
                        <Editor>
                            <ext:TextField ID="TextField1" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="idCargo" Header="Cargo" DataIndex="idCargo">
                        <Editor>
                            <ext:TextField ID="TextField2" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="idPessoa" Header="Pessoa" DataIndex="idPessoa">
                        <Editor>
                            <ext:TextField ID="TextField3" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="salario" Header="Salario" DataIndex="salario">
                        <Editor>
                            <ext:TextField ID="TextField4" runat="server" />
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" >
                </ext:RowSelectionModel>
            </SelectionModel>
            <LoadMask ShowMask="true" />
            <TopBar>
                <ext:Toolbar ID="Toolbar2" runat="server">
                    <Items>
                        <ext:Button ID="Button4" runat="server" Text="Novo" Icon="Add">
                            <Listeners> 
                                <Click Handler="winNovo.show()" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="Button5" runat="server" Text="Modo Edição" Icon="Pencil">
                            <Listeners> 
                                <Click Handler="modoEdicao()" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="Button6" runat="server" Text="Excluir" Icon="Delete">
                            <Listeners> 
                                <Click Handler="excluirRegistro()" />
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