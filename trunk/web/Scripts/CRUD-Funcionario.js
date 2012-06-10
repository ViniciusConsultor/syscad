﻿function salvarFuncionario(fooorm) {

    winNovoFuncionario.hide();

    GridPanelFuncionario.el.mask('Salvando', 'x-mask-loading');

    $.post('/Funcionario/Save', fooorm, function (valor) {
        Ext.Msg.show({
            title: 'Sucesso',
            msg: 'Funcionário salvo com sucesso',
            buttons: Ext.Msg.OK
        });
        GridPanelFuncionario.reload();
        GridPanelFuncionario.el.unmask();
    });

};

function excluirFuncionario() {
    var confirm = Ext.Msg.confirm('Confirmação', 'Tem certeza que deseja excluir Funcionario ?', function (btn) {

        if (btn == 'yes') {
            if (GridPanelFuncionario.getSelectionModel().hasSelection()) {

                GridPanelFuncionario.el.mask('Excluindo Funcionario', 'x-mask-loading');

                var record = GridPanelFuncionario.getSelectionModel().getSelected();

                $.post('/Funcionario/Excluir', { id: record.data.idFuncionario }, function () {
                    GridPanelFuncionario.reload();
                    GridPanelFuncionario.el.unmask();
                });

            }
        }

    });

};

function novoFuncionario() {

    if (GridPanel.getSelectionModel().hasSelection()) {

        winNovoFuncionario.show();

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

var startEditingFuncionario = function (e) {

    if (e.getKey() === e.ENTER) {

        var grid = GridPanelFuncionario,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

        grid.startEditing(index, 1);

    }

};

var afterEditFuncionario = function (e) {
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

    var param1 = "e.record.data.idFuncionario";
    salvarAlteracoesFuncionario(eval(param1), e.field, e.value);

    var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;

    Ext.Msg.notify('Registro atualizado com sucesso!', mensagem);

    GridPanelFuncionario.store.commitChanges();
};

function salvarAlteracoesFuncionario(id, field, newValue) {

    GridPanelFuncionario.el.mask('Alterando ...', 'x-mask-loading');

    $.post('/Funcionario/Editar', { id: id, campo: field, valor: newValue }, function () {
        GridPanelFuncionario.reload();
        GridPanelFuncionario.el.unmask();
    });

};