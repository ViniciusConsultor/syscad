<%@ Page Language="C#"  %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cursos</title>
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
            var store = GridPanelEdicao.getStore();
            store.directEventConfig.isUpload = true;


            store.submitData();

            store.directEventConfig.isUpload = false;
        };

        var submitValue = function (grid, hiddenFormat, format) {
            hiddenFormat.setValue(format);
            grid.submitData(false);
        };


        function modoEdicao() {
            GridPanelEdicao.reload('yes');
            GridPanelNormal.hide();
            GridPanelEdicao.show();
        };

        function sairModoEdicao () {
            GridPanelNormal.reload();
            GridPanelNormal.show();
            GridPanelEdicao.hide();
        };


        function excluirRegistro() {

            var confirm = Ext.Msg.confirm('Confirmação','Tem certeza que deseja excluir o curso?', function (btn) {

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
    <script type="text/javascript">
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

        var startEditing = function (e) {
            if (e.getKey() === e.ENTER) {
                var grid = GridPanelCurso,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

                grid.startEditing(index, 1);
            }
        };

        function salvarAlteracoes(id, field, newValue) {

                GridPanelCurso.el.mask('Alterando curso', 'x-mask-loading');

                $.post('/Curso/Editar', { idCurso: id, campo: field, valor: newValue }, function () {
                    GridPanelCurso.el.unmask();
                });

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
            Ext.Msg.notify({
                title: 'Editado com sucesso',
                msg: 'Registro alterado com sucesso!'
            }).Show();
            grid.Store.Primary.CommitChanges();
        };
    </script>

</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" RemoveViewState="true" IDMode="Explicit" />
    
    <h1>Editable GridPanel With Save To [DirectMethod]</h1>
    
    <ext:GridPanel 
        ID="GridPanelCurso"
        runat="server" 
        Title="Editable GridPanel" 
        StripeRows="true"
        TrackMouseOver="true"
        Width="600" 
        Height="350"
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
    </ext:GridPanel>          
</body>
</html>