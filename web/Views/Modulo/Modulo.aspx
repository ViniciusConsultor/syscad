<%@ Page Language="C#"  %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Modulos</title>
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

            var confirm = Ext.Msg.confirm('Confirmação', 'Tem certeza que deseja excluir o modulo?', function (btn) {

                if (btn == 'yes') {
                    if (GridPanelNormal.getSelectionModel().hasSelection()) {

                        GridPanelNormal.el.mask('Excluindo Modulo', 'x-mask-loading');

                        var record = GridPanelNormal.getSelectionModel().getSelected();

                        $.post('/Modulo/Excluir', { idModulo: record.data.idModulo }, function () {
                            GridPanelNormal.reload();
                            GridPanelNormal.el.unmask();
                        });

                    }

                }

            });

        };


        function salvarAlteracoes() {

            if (GridPanelEdicao.getSelectionModel().hasSelection()) {

                GridPanelEdicao.el.mask('Alterando modulo', 'x-mask-loading');

                var record = GridPanelEdicao.getSelectionModel().getSelected();

                $.post('/Modulo/Editar', { idModulo: record.data.idModulo, Nome: record.data.nome, tempoDuracao: record.data.tempoDuracao, statusModulo: record.data.statusModulo, idCurso: record.data.idCurso }, function () {
                    GridPanelEdicao.el.unmask();
                });

            }

        };

        function salvar() {
            winNovo.hide();
            GridPanelNormal.el.mask('Salvando', 'x-mask-loading');
            $.post('/Modulo/Save', $("#Form1").serialize(), function (valor) {
                //Ext.Msg.alert('Modulo salvo com sucesso!');
                Ext.Msg.show({
                    title: 'Sucesso',
                    msg: 'Modulo cadastrado com sucesso',
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
            Title="Editando Modulo" 
            Width="1164" 
            Height="704"
            OnRefreshData="/Modulo/FindAll"
            >
            <Listeners>
                <BeforeRender Handler="carregaGrid()" />
            </Listeners>
            <Store>
                <ext:Store 
                    ID="Store1" 
                    runat="server">
                    <Proxy>
                        <ext:HttpProxy Json="true" Method="GET" Url="/Modulo/FindAll" AutoDataBind="true" />
                    </Proxy>
                    <Reader>
                        <ext:JsonReader Root="modulos" TotalProperty="totalReg">
                            <Fields>
                                <ext:RecordField Name="idModulo" Type="Int" />
                                <ext:RecordField Name="nome" Type="String" />
                                <ext:RecordField Name="tempoDuracao" Type="Int" />
                                <ext:RecordField Name="statusModulo" Type="Int" />
                                <ext:RecordField Name="idCurso" Type="Int" />
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                <Columns>
                    <ext:Column ColumnID="idModulo" Header="Id" DataIndex="idModulo" Hidden="true" />

                    <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" >
                        <Editor>
                            <ext:TextField ID="txtNomeEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="tempoDuracao" Header="Tempo de Duração" DataIndex="tempoDuracao">
                        <Editor>
                            <ext:TextField ID="txtTempoDuracaoEditar" runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column ColumnID="statusModulo" Header="StatusModulo" Width="75" DataIndex="statusModulo">
                        <Editor>
                            <ext:TextField ID="txtStatusModuloEditar" runat="server" />
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
                <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" />
            </BottomBar>
        </ext:GridPanel>


        <ext:GridPanel 
            ID="GridPanelNormal"
            runat="server" 
            Title="Modulo" 
            Width="1164" 
            Height="705"
            OnRefreshData="/Modulo/FindAll"
            >
            <Store>
                <ext:Store 
                    ID="Store2" 
                    runat="server">
                    <Proxy>
                        <ext:HttpProxy Json="true" Method="GET" Url="/Modulo/FindAll" AutoDataBind="true" />
                    </Proxy>
                    <Reader>
                        <ext:JsonReader Root="modulos" TotalProperty="totalReg">
                            <Fields>
                                <ext:RecordField Name="idModulo" Type="Int" />
                                <ext:RecordField Name="nome" Type="String" />
                                <ext:RecordField Name="tempoDuracao" Type="Int" />
                                <ext:RecordField Name="statusModulo" Type="Int" />
                                <ext:RecordField Name="Curso.nome" Type="String"/>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                <Columns>
                    <ext:Column ColumnID="idModulo" Header="Id" DataIndex="idModulo" Width="50"/>

                    <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" Width="150">
                       
                    </ext:Column>
                    <ext:Column ColumnID="tempoDuracao" Header="Duração" DataIndex="tempoDuracao" Width="150">
                       
                    </ext:Column>
                    <ext:Column ColumnID="statusModulo" Header="Status" DataIndex="statusModulo" Width="150">
                        
                    </ext:Column>
                     <ext:Column ColumnID="curso" Header="Curso" DataIndex="Curso.nome" Width="150">
                        
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
            Title="Novo Modulo" 
            Hidden="true"
            X="250"
            Y="100"
            Layout="FormLayout"
            AutoHeight="true"
            Frame="true"
            Width="400"
            Modal="true"
            >
            <Items>
                <ext:FormPanel ID="formulario" runat="server">

                    <Items>
                        <ext:TextField ID="txtNome" runat="server" FieldLabel="Nome" InputType="Text" Width="175" AllowBlank="false" AutoFocus="true" />
                        <ext:NumberField ID="txtTempoDuracao" runat="server" FieldLabel="Duração" Width="175" Vtype="numberrange" AllowBlank="false"   />                            
                        <ext:NumberField ID="txtStatusModulo" runat="server" FieldLabel="Status" Width="175" Vtype="numberrange" AllowBlank="false" />
                        <ext:ComboBox 
                            ID="txtIdCurso"
                            Mode="Remote"
                            DisplayField="nome"
                            ValueField="idCurso"
                            runat="server"
                            TypeAhead="true"
                            ForceSelection="true"
                            TriggerAction="All"
                             >
                         <Store>
                             <ext:Store ID="StoreCurso" runat="server">
                                <Proxy>
                                    <ext:HttpProxy Url="/Curso/FindAll" Json="true" Method="GET" AutoDataBind="true" />
                                </Proxy>
                                <Reader>
                                    <ext:JsonReader Root="cursos">
                                        <Fields>
                                            <ext:RecordField Name="idCurso" Type="Int" Mapping="idCurso" />
                                            <ext:RecordField Name="nome" Type="String"  Mapping="nome"/>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                         </Store>    
                         </ext:ComboBox>
                        
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
