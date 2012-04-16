<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<YuiGrid>" %>

<%@ Import Namespace="ExtExtenders" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
                    }, '-'
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

        var adicionar = function(){

            winForm.update = false;
            winForm.setTitle(formTitle + '[Inserindo]');
            winForm.show();
            formulario.getForm().reset();
        };
            
    

    </script>
</head>
<body>

<div id="grid_curso"></div>
</body>
</html>

