<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" MasterPageFile="~/Views/Shared/Site.Master" %>

<script type="text/javascript">
    Ext.onReady(function () {

        var painel = new Ext.form.FormPanel({
            id: 'painel',
            name: 'painel',
            renderTo: 'formCreate',
            items: [
                    {
                        xtype: 'textfield',
                        allowBlank: false,
                        name: 'txtNome',
                        id: 'txtNome',
                        fieldLabel: 'Nome'
                    },
                    {
                        xtype: 'textfield',
                        allowBlank: false,
                        name: 'txtDescricao',
                        id: 'txtDescricao',
                        fieldLabel: 'Descrição'
                    },
                    {
                        xtype: 'textfield',
                        allowBlank: false,
                        name: 'txtValor',
                        id: 'txtValor',
                        fieldLabel: 'Valor'
                    }
            ],
            buttonAlign: 'center',
            buttons: [
                {
                    name: 'btnSalvar',
                    id: 'btnSalvar',
                    text: 'Salvar',
                    iconCls: 'icon-save'
                },
                {
                    name: 'btnFechar',
                    id: 'btnFechar',
                    text: 'Fechar',
                    iconCls: 'icon-cancel'
                }
            ]
        });

    });
</script>

