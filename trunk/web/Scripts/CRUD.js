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

    if (controller == "Pessoa") {
        if (vercpf($("#txtCpf").val())) {

        } else {
            Ext.Msg.show({
                title: 'Validação de CPF',
                msg: 'O CPF informado não é válido!',
                buttons: Ext.Msg.OK,
                icon: Ext.Msg.INFO
            });
            return false;
        }
    }

    if(!formulario.isValid()){
        return false;
    }

    winNovo.hide();

    GridPanel.el.mask('Salvando', 'x-mask-loading');

    $.post(metodoSalvar, $("#Novo").serialize(), function (result) {

        if (result.success) {
            Ext.Msg.show({
                title: 'Sucesso',
                msg: controller + ' salvo(a) com sucesso',
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
        GridPanel.reload();
        GridPanel.el.unmask();
    });

};

//-----------------------------------------------------------------------------------------------------------------------------

function editar() {

    Ext.Msg.show({
        title: 'Como Editar',
        msg: 'Para editar qualquer registro basta selecionar aquele que deseja editar e dar dois cliques em cima do registro que deseja alterar, ou se preferir pressione o botão ENTER.',
        buttons: Ext.Msg.OK
    });

}

//-----------------------------------------------------------------------------------------------------------------------------

function salvarAlteracoes(id, field, newValue) {

    if ( field == "dataNascimento") {

        newValue = newValue.dateFormat('d/m/Y').toString();

    }

    
    
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
    if (e.field == "cpf") {
        if (vercpf(e.value)) {

        } else {
            Ext.Msg.show({
                title: 'CPF Inválido!',
                msg: 'Campo não editado, o CPF digitado não é válido!',
                buttons: Ext.Msg.OK
            });
            return false;
        }
    }

    var param1 = "e.record.data." + campoIdRegistro;
    salvarAlteracoes(eval(param1), e.field, e.value);

    var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;

    Ext.Msg.notify('Registro atualizado com sucesso!', mensagem);

    GridPanel.store.commitChanges();
};

//-----------------------------------------------------------------------------------------------------------------------------

function novo(form) {

    form.getForm().reset();
    winNovo.show();

}