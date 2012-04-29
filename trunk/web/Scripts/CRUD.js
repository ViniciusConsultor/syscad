function excluirRegistro() {

    var confirm = Ext.Msg.confirm('Confirmação', 'Tem certeza que deseja excluir ' + titulo + '?', function (btn) {

        if (btn == 'yes') {
            if (GridPanel.getSelectionModel().hasSelection()) {

                GridPanel.el.mask('Excluindo ' + titulo, 'x-mask-loading');

                var record = GridPanel.getSelectionModel().getSelected();

                $.post(metodoExcluir, { id: eval(makeParams) }, function () {
                    GridPanel.reload();
                    GridPanel.el.unmask();
                });

            }

        }

    });

};