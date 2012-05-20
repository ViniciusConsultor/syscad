function salvarModulo(fooorm) {

    winNovoModulo.hide();

    GridPanelModulo.el.mask('Salvando', 'x-mask-loading');

    $.post('/Modulo/Save', fooorm, function (valor) {
        Ext.Msg.show({
            title: 'Sucesso',
            msg: 'Modulo salvo com sucesso',
            buttons: Ext.Msg.OK
        });
        GridPanelModulo.reload();
        GridPanelModulo.el.unmask();
    });

};

function excluirModulo() {
    var confirm = Ext.Msg.confirm('Confirmação', 'Tem certeza que deseja excluir Modulo ?', function (btn) {

        if (btn == 'yes') {
            if (GridPanelModulo.getSelectionModel().hasSelection()) {

                GridPanelModulo.el.mask('Excluindo Modulo', 'x-mask-loading');

                var record = GridPanelModulo.getSelectionModel().getSelected();

                $.post('/Modulo/Excluir', { id: record.data.idModulo }, function () {
                    GridPanelModulo.reload();
                    GridPanelModulo.el.unmask();
                });

            }
        }

    });

};

function novoModulo() {

    if (GridPanel.getSelectionModel().hasSelection()) {

        winNovoModulo.show();

    } else {

        Ext.Msg.show({
            title: 'Aviso',
            msg: 'Selecione uma Pessoa antes de cadastrar um novo endereço!',
            buttons: Ext.Msg.OK
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

var startEditingModulo = function (e) {

    if (e.getKey() === e.ENTER) {

        var grid = GridPanelModulo,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

        grid.startEditing(index, 1);

    }

};

var afterEditModulo = function (e) {
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

    var param1 = "e.record.data.idModulo";
    salvarAlteracoesModulo(eval(param1), e.field, e.value);

    var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;

    Ext.Msg.notify('Registro atualizado com sucesso!', mensagem);

    GridPanelModulo.store.commitChanges();
};

function salvarAlteracoesModulo(id, field, newValue) {

    GridPanelModulo.el.mask('Alterando ...', 'x-mask-loading');

    $.post('/Modulo/Editar', { id: id, campo: field, valor: newValue }, function () {
        GridPanelModulo.reload();
        GridPanelModulo.el.unmask();
    });

};