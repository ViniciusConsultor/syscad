<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Professor</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        var processarCobranca = function () {
            $.post("/Pagamento/GerarCobrancas", {}, function (result) {

            });
        }

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
                                <ext:Label Text="Selecione o mês para gerar as cobranças de mensalidade" runat="server" BoxMaxHeight="50" />
                                <ext:Button ID="btnProcessar" Text="Processar cobrança" runat="server" >
                                    <Listeners>
                                        <Click Fn="" />
                                    </Listeners>
                                </ext:Button>
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
