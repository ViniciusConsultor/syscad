function salvarEndereco(form) {

    if (!endereco.isValid()) {
        return false;
    }

    winNovoEndereco.hide();

    GridPanelEndereco.el.mask('Salvando', 'x-mask-loading');

    $.post('/Endereco/Save', form, function (result) {
        if (result.success) {
            Ext.Msg.show({
                title: 'Sucesso',
                msg: 'Endereço salvo com sucesso',
                buttons: Ext.Msg.OK,
                icon: Ext.Msg.INFO
            });
        } else {
            Ext.Msg.show({
                title: 'Erro',
                msg: 'Erro ao cadastrar ' + controller,
                buttons: Ext.Msg.OK,
                icon: Ext.Msg.ERROR
            });
        }
        GridPanelEndereco.reload();
        GridPanelEndereco.el.unmask();
    });

};

function excluirEndereco() {
    var confirm = Ext.Msg.confirm('Confirmação', 'Tem certeza que deseja excluir endereco ?', function (btn) {

        if (btn == 'yes') {
            if (GridPanelEndereco.getSelectionModel().hasSelection()) {

                GridPanelEndereco.el.mask('Excluindo endereco', 'x-mask-loading');

                var record = GridPanelEndereco.getSelectionModel().getSelected();

                $.post('/Endereco/Excluir', { id: record.data.idEndereco }, function () {
                    GridPanelEndereco.reload();
                    GridPanelEndereco.el.unmask();
                });

            }
        }

    });

};

function novoEndereco(form) {

    if (GridPanel.getSelectionModel().hasSelection()) {

       // form.getForm().reset();
        winNovoEndereco.show();

    } else {

        Ext.Msg.show({
            title: 'Aviso',
            msg: 'Selecione uma Pessoa antes de cadastrar um novo endereço!',
            buttons: Ext.Msg.OK,
            icon: Ext.Msg.INFO
        });

    }

}

function formataSexo(sexo) {

    if (sexo == 1) {
        return "Masculino";

    } else {
        return "Feminino";
    }

}

var startEditingEndereco = function (e) {

    if (e.getKey() === e.ENTER) {

        var grid = GridPanelEndereco,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

        grid.startEditing(index, 1);

    }

};

var afterEditEndereco = function (e) {
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

    var param1 = "e.record.data.idEndereco";
    salvarAlteracoesEndereco(eval(param1), e.field, e.value);

    var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;

    Ext.Msg.notify('Registro atualizado com sucesso!', mensagem);

    GridPanelEndereco.store.commitChanges();
};

function salvarAlteracoesEndereco(id, field, newValue) {

    GridPanelEndereco.el.mask('Alterando ...', 'x-mask-loading');

    $.post('/Endereco/Editar', { id: id, campo: field, valor: newValue }, function () {
        GridPanelEndereco.reload();
        GridPanelEndereco.el.unmask();
    });

};