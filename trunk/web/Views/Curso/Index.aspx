<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<YuiGrid>" %>

<%@ Import Namespace="ExtExtenders" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Curso</title>
    <link href="../../Extjs/resources/css/ext-all.css" rel="stylesheet" type="text/css" />
    <script src="../../Extjs/ext.js" type="text/javascript"></script>
    <script src="../../Extjs/ext-all.js" type="text/javascript"></script>
    <script src="../../Extjs/locate/ext-lang-pt_BR.js" type="text/javascript"></script>
    <script type="text/javascript">

    Ext.onReady(function () {

        Ext.define('Curso', {
            extend: 'Ext.data.Model',
            fields: [
                        { name: 'nome', type: 'string' },
                        { name: 'descricao', type: 'string' },
                        { name: 'valor', type: 'decimal' }
                    ]
        });

        var cursoStore = Ext.create('Ext.data.Store', {
            model: 'Curso',
            proxy: {
                type: 'ajax',
                url: '/Curso/FindAll',
                reader: {
                    type: 'json',
                    root: 'cursos'
                }
            },
            autoLoad: true,
        });

        var gridCurso = new Ext.grid.GridPanel({
            id: 'gridCurso',
            name: 'gridCurso',
            store: cursoStore,
            title: 'Cursos',
            width: 500,
            height: 300,
            renderTo: 'grid_curso',
            loadMask: true,
            border: true,
            stripRows: true,
            columns: [
                        {
                            dataIndex: 'nome',
                            header: 'Nome',
                            width: 200
                        },
                        {
                            dataIndex: 'descricao',
                            header: 'Descrição',
                            width: 200
                        },
                        {
                            dataIndex: 'valor',
                            header: 'Valor',
                            width: 100
                        },
                    ],
            tbar:[
                    {
                        text: 'Novo',
                        iconCls: 'btn-add',
                        handler: adicionar
                    },
                    {
                        text: 'Editar',
                        iconCls: 'btn-edit',
                        handler: editar
                    },
                    {
                        text: 'Deletar',
                        iconCls: 'btn-add',
                      
                    }
                 ]
        });
    });


    var formulario = new Ext.form.FormPanel({
            border: false,
            frame: true,
            labelWidth: 70,
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
            ]
            

        });

       var cancelar = function(){
            formulario.getForm().reset();
            winForm.hide();
       }

       var salvar = function(){

            if(formulario.getForm().isValid()){
                winForm.el.mask('Salvando', 'x-mask-loading');
                formulario.getForm().submit({
                    url: '/Curso/Save',
                    params: {
                        action: winForm.update ? 'update' : 'insert'
                    },
                    success: function(form, action){
                        if(action.result.success){                       
                            Ext.Msg.show({
                                title: 'Sucesso',
                                msg: 'Curso cadastrado com sucesso',
                                buttons: Ext.Msg.OK
                            });
                            winForm.el.mask();
                            winForm.hide();
                            cursoStore.reload();
                            
                        }
                    },
                    failure: function(form, action){
                        winForm.el.mask();
                        Ext.Msg.alert('Erro',action.result.message);
                    },
                    scope: this
                });
            }else{
                Ext.Msg.alert('Atenção', 'Existem campos inválidos');
            }
        }

       var formTitle = 'Curso ';

       var winForm = new Ext.Window({
            name: 'formNovoRegisro',
            id: 'formNovoRegistro',
            title: formTitle,
            expandonShow: false,
            closeAction: 'hide',
            modal: true,
            width: 500,
            height: 150,
            closable: true,
            items: formulario,
            layout: 'fit',
            buttonAlign: 'center',
            buttons: [
                {
                    name: 'btnSalvar',
                    id: 'btnSalvar',
                    text: 'Salvar',
                    scope: this,
                    handler: salvar
                },
                {
                    name: 'btnFechar',
                    id: 'btnFechar',
                    text: 'Fechar',
                    scope: this,
                    handler: cancelar
                }
            ]

        });

        var adicionar = function(){

            winForm.update = false;
            winForm.setTitle(formTitle + '[Inserindo]');
            winForm.show();
            formulario.getForm().reset();
        };       

        var editar = function(){
            if(gridCurso.getSelectionModel().hasSelection()){
                winForm.update = true;
                winForm.setTitle(formTitle + '[Alterando]');
                winForm.show();
                var record = gridCurso.getSelectionModel().getSelected();
                Ext.getCmp('txtNome').setValue(record.data.nome);
                Ext.getCmp('txtDescricao').setValue(record.data.descricao);
                Ext.getCmp('txtValor').setValue(record.data.valor);
            }else{
                Ext.Msg.alert('Atenção', 'Selecione um registro');
            }
        };
    </script>
</head>
<body>

<div id="grid_curso"></div>
</body>
</html>

