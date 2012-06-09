<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Professor</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        var processarCobranca = function () {
            //$.post("/Pagamento/GerarCobrancas", {}, function (result) {

            // });
            var grid = grdCobranca;
            grid.insertRecord(0, { aluno: "leonardo", valor: "200", situacao: "1" }, true);
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
                            Height="100" 
                            Padding="5"
                            Frame="true" 
                            Icon="Information">
                            <Items>
                                <ext:Label html="<h1>Selecione o mês para gerar as cobranças de mensalidade!</h1><br/>" runat="server" BoxMaxHeight="50" />
                                <ext:Button ID="btnProcessar" Text="Processar cobrança" runat="server" >
                                    <Listeners>
                                        <Click Fn="processarCobranca" />
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
                                    AutoExpandColumn="aluno"
                                    >
                                     <Store>
                                        <ext:Store ID="Store1" runat="server">
                                            <Reader>
                                                <ext:ArrayReader>
                                                    <Fields>
                                                        <ext:RecordField Name="aluno" />
                                                        <ext:RecordField Name="valor" />
                                                        <ext:RecordField Name="situacao" />
                                                    </Fields>
                                                </ext:ArrayReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn ColumnID="number" />
                                            <ext:Column Header="Aluno" DataIndex="aluno"  Width="200" />
                                            <ext:Column Header="Valor" DataIndex="valor" Width="200" />
                                            <ext:Column Header="Situação" DataIndex="situacao" Width="100" />
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
