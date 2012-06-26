function salvarProfessor(form) {

    if (!professor.isValid()) {
        return false;
    }

    winNovoProfessor.hide();

    GridPanelProfessor.el.mask('Salvando', 'x-mask-loading');

    $.post('/Especializacao/SaveProfessorEspecializacao', form, function (result) {
        if (result.success) {
            Ext.Msg.show({
                title: 'Sucesso',
                msg: 'Professor salvo com sucesso',
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
        GridPanelProfessor.reload();
        GridPanelProfessor.el.unmask();
    });

};

function excluirProfessorEspecializacao() {
    var confirm = Ext.Msg.confirm('Confirmação', 'Tem certeza que deseja excluir Professor ?', function (btn) {

        if (btn == 'yes') {
            if (GridPanelProfessor.getSelectionModel().hasSelection()) {

                GridPanelProfessor.el.mask('Excluindo Professor', 'x-mask-loading');

                var record = GridPanelProfessor.getSelectionModel().getSelected();

                $.post('/Especializacao/ExcluirProfessorEspecializacao', { id: record.data.idFuncionarioEspecializacao }, function () {
                    GridPanelProfessor.reload();
                    GridPanelProfessor.el.unmask();
                });

            }
        }

    });

};

function novoProfessor(form) {

    if (GridPanel.getSelectionModel().hasSelection()) {

        Ext.getCmp("cmbProfessor").reset();
//        Ext.getCmp("txtLogradouro").reset();
//        Ext.getCmp("txtNumero").reset();
//        Ext.getCmp("txtComplemento").reset();
//        Ext.getCmp("txtCep").reset();
//        Ext.getCmp("txtBairro").reset();
//        Ext.getCmp("txtCidade").reset();
//        Ext.getCmp("txtUf").reset();

        winNovoProfessor.show();

    } else {

        Ext.Msg.show({
            title: 'Aviso',
            msg: 'Selecione uma especialização antes de cadastrar um novo professor!',
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

var startEditingProfessor = function (e) {

    if (e.getKey() === e.ENTER) {

        var grid = GridPanelProfessor,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

        grid.startEditing(index, 1);

    }

};

var afterEditProfessor = function (e) {
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

    var param1 = "e.record.data.idProfessor";
    salvarAlteracoesProfessor(eval(param1), e.field, e.value);

    var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;

    Ext.Msg.notify('Registro atualizado com sucesso!', mensagem);

    GridPanelProfessor.store.commitChanges();
};

function salvarAlteracoesProfessor(id, field, newValue) {

    GridPanelProfessor.el.mask('Alterando ...', 'x-mask-loading');

    $.post('/Professor/Editar', { id: id, campo: field, valor: newValue }, function () {
        GridPanelProfessor.reload();
        GridPanelProfessor.el.unmask();
    });

};