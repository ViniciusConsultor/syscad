function modoEdicao() {
    GridPanelEdicao.reload();
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