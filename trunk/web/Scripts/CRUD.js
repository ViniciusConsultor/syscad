var campoIdRegistro = "id" + controller; // Adicione aqui o name do RecordField referente ao id do registro

var metodoExcluir = '/' + controller + '/Excluir';
var metodoSalvar = '/' + controller + '/Save';
var metodoEditar = '/' + controller + '/Editar';

function excluirRegistro() {

    var confirm = Ext.Msg.confirm('Confirmação', 'Tem certeza que deseja excluir ' + controller + '?', function (btn) {

        if (btn == 'yes') {
            if (GridPanel.getSelectionModel().hasSelection()) {

                GridPanel.el.mask('Excluindo ' + controller, 'x-mask-loading');

                var record = GridPanel.getSelectionModel().getSelected();

                var genericParamsRecord = "record.data."; //Não mecher
                var makeParams = genericParamsRecord + campoIdRegistro; //Não mecher

                $.post(metodoExcluir, { id: eval(makeParams) }, function () {
                    GridPanel.reload();
                    GridPanel.el.unmask();
                });

            }

        }

    });

};

//-----------------------------------------------------------------------------------------------------------------------------

function salvar() {

    winNovo.hide();

    GridPanel.el.mask('Salvando', 'x-mask-loading');

    $.post(metodoSalvar, $("#Novo").serialize(), function (valor) {
        Ext.Msg.show({
            title: 'Sucesso',
            msg: controller + ' salvo com sucesso',
            buttons: Ext.Msg.OK
        });
        GridPanel.reload();
        GridPanel.el.unmask();
    });

};

//-----------------------------------------------------------------------------------------------------------------------------

function editar() {

    Ext.Msg.show({
        title: 'Como Editar',
        msg: 'Para editar qualquer registro basta selecionar aquele que deseja editar e dar dois cliques na em cima do registro que deseja alterar, ou se preferir pressione o botão ENTER.',
        buttons: Ext.Msg.OK
    });

}

//-----------------------------------------------------------------------------------------------------------------------------

function salvarAlteracoes(id, field, newValue) {

    GridPanel.el.mask('Alterando ...', 'x-mask-loading');

    $.post(metodoEditar, { id: id, campo: field, valor: newValue }, function () {
        GridPanel.reload();
        GridPanel.el.unmask();
    });

};

//-----------------------------------------------------------------------------------------------------------------------------

var startEditing = function (e) {

    if (e.getKey() === e.ENTER) {

        var grid = GridPanel,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

        grid.startEditing(index, 1);

    }

};

//-----------------------------------------------------------------------------------------------------------------------------

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
    var param1 = "e.record.data." + campoIdRegistro;
    salvarAlteracoes(eval(param1), e.field, e.value);

    var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;

    Ext.Msg.notify('Registro atualizado com sucesso!', mensagem);

    GridPanel.store.commitChanges();
};

//-----------------------------------------------------------------------------------------------------------------------------

function novo() {

    winNovo.show();

}