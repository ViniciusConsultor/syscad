<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Professor</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var startEditing = function (e) {
            if (e.getKey() === e.ENTER) {
                var grid = grdNotaFalta,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

                grid.startEditing(index, 1);
            }
        };

        var traduzSituacaoAluno = function (value) {
            var retorno;
            switch (value) {
                case 1:
                    retorno = "Aprovado";
                    break;
                case 2:
                    retorno = "Reprovado";
                    break;
                case 3:
                    retorno = "Recuperação";
                    break;
                default:
                    retorno = "Não Avaliado";
            }

            return retorno;
        }

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
            var IdAluno = e.record.data.IdAluno;
            var IdTurma = e.record.data.IdTurma;
            var IdModulo = e.record.data.IdModulo;
            var field = e.field;
            var newValue = e.value;

            grdNotaFalta.el.mask('Alterando curso', 'x-mask-loading');

            var r = $.post('/LancarNotaFalta/EnviarNotaFalta', { idAluno: IdAluno, idTurma: IdTurma, idModulo: IdModulo, campo: field, valor: newValue }, function (result) {
                complete:
                {
                    grdNotaFalta.el.unmask();
                    var mensagem = "<b>Nota Cadastrada com sucesso!</b>";
                    Ext.Msg.notify("Mensagem", mensagem);
                    e.record.data.situacaoAluno = result.notaFalta.situacaoAluno;
                    e.record.data.notaFinal = result.notaFalta.notaFinal;
                    grdNotaFalta.store.commitChanges();
                }
            });

            if (e.column === 4 && e.record.data.Faltas == "") {
                return 0;
            }
        };

        var beforeEdit = function (e) {
            if (e.column === 5 && (e.record.data.Nota1 >= 7 || e.record.data.Nota1 < 2)) {
                return false;
            }
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="ViewPort1" runat="server">
            <Items>
                <ext:BorderLayout ID="BorderLayout1" runat="server">
                    <North MarginsSummary="5 5 5 5">
                        <ext:Panel 
                            ID="pnlInformation" 
                            runat="server" 
                            Title="Processar cobrança de mensalidades" 
                            Height="80" 
                            Padding="5"
                            Frame="true" 
                            Icon="Information">
                            <Items>
                                <ext:Label Text="Selecione o mês para gerar as cobranças de mensalidade" runat="server" />
                            </Items>
                        </ext:Panel>
                    </North>
                    <Center MarginsSummary="0 5 0 5">
                        <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Cobranças de Mensalidades" Icon="MoneyDollar" Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="grdCobranca"
                                    runat="server" 
                                    
                                    Height="300"
                                    >
                                    <Store>
                                        <ext:EventStore ID="store" runat="server" />
                                    </Store>
                                    <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn ColumnID="number" />
                                            <ext:Column ColumnID="aluno" Header="Aluno" Width="200" />
                                            <ext:Column ColumnID="valor" Header="Valor"  Width="100" />
                                            <ext:Column ColumnID="situacao" Header="Situação" Width="50" />
                                        </Columns>
                                    </ColumnModel>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Center>                    
                </ext:BorderLayout>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
