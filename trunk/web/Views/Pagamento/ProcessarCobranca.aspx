<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Professor</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var formataDinheiro = function (num) {
            num = num.toString().replace(/\R$|\,/g, '');
            if (isNaN(num)) num = "0";
            sign = (num == (num = Math.abs(num)));
            num = Math.floor(num * 100 + 0.50000000001);
            cents = num % 100;
            num = Math.floor(num / 100).toString();
            if (cents < 10) cents = "0" + cents;
            for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
                num = num.substring(0, num.length - (4 * i + 3)) + '.' + num.substring(num.length - (4 * i + 3));
            return (((sign) ? '' : '-') + 'R$ ' + num + ',' + cents);
        }

        var processarCobranca = function () {
            if ($("#mes").val() != "") {
                var grid = Ext.getCmp("grdCobranca");
                grid.load();
                setTimeout("geraCobranca(0)", 1000);
            } else {
                Ext.Msg.show({
                    title: 'Erro',
                    msg: 'Selecione um mês para processar as cobranças!',
                    buttons: Ext.Msg.OK,
                    icon: Ext.Msg.ERROR
                });
            }
        }

        var geraCobranca = function (i) {
            if (Store1.getCount() > 0) {
                var record = Store1.getAt(i);
                var mes = $("#mes").val();
                $.post("/Pagamento/GeraCobranca", { idAluno: record.data.idAluno, mes: mes }, function (result) {
                    before:
                    {
                        record.set('situacao', 'blue-loading.gif');
                    }
                    complete:
                    {
                        if (result.success == true) {
                            setTimeout(function () {
                                record.set('situacao', 'accept.png');
                                var count = Store1.getCount() - 1;
                                i++;
                                if (count >= i) {
                                    geraCobranca(i);
                                } else {
                                    exibeMensagem();
                                }
                                grdCobranca.store.commitChanges();
                            }, 1000);
                        } else {
                            setTimeout(function () {
                                record.set('situacao', 'error_icon.gif');
                                var count = Store1.getCount() - 1;
                                i++;
                                if (count >= i) {
                                    geraCobranca(i);
                                } else {
                                    exibeMensagem();
                                }
                                grdCobranca.store.commitChanges();
                            }, 1000);
                        }
                    }
                });
            }
        }

        var exibeMensagem = function () {
            Ext.Msg.show({
                title: 'Sucesso',
                msg: "Cobranças geradas com sucesso!",
                buttons: Ext.Msg.OK,
                icon: Ext.Msg.INFO
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
                            Height="140" 
                            Padding="5"
                            Frame="true" 
                            Icon="Information"
                            ButtonAlign="Left"
                            >
                            <Items>
                                <ext:Label html="<h1>Selecione o mês para gerar as cobranças de mensalidade!</h1><br/>" runat="server" BoxMaxHeight="50" />
                                <ext:CompositeField runat="server" FieldLabel="Mês" CombineErrors="false" LabelWidth="25">
                                    <Items>
                                        <ext:ComboBox ID="mes" runat="server" Width="45" AnchorHorizontal="100%" AllowBlank="false">
                                            <Items>
                                                <ext:ListItem Text="01" Value="1" />
                                                <ext:ListItem Text="02" Value="2" />
                                                <ext:ListItem Text="03" Value="3" />
                                                <ext:ListItem Text="04" Value="4" />
                                                <ext:ListItem Text="05" Value="5" />
                                                <ext:ListItem Text="06" Value="6" />
                                                <ext:ListItem Text="07" Value="7" />
                                                <ext:ListItem Text="08" Value="8" />
                                                <ext:ListItem Text="09" Value="9" />
                                                <ext:ListItem Text="10" Value="10" />
                                                <ext:ListItem Text="11" Value="11" />
                                                <ext:ListItem Text="12" Value="12" />
                                            </Items>
                                        </ext:ComboBox>
                                        <ext:DisplayField runat="server" ID="ano" Text="/2012" />
                                    </Items>
                                </ext:CompositeField>                                
                            </Items>
                            <Buttons>
                                <ext:Button ID="btnProcessar" Text="Processar Cobranças" runat="server" StyleSpec="text-align:left" Icon="MoneyAdd">
                                    <Listeners>
                                        <Click Fn="processarCobranca" />
                                    </Listeners>
                                </ext:Button>                                
                            </Buttons>
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
                                        <ext:Store ID="Store1" runat="server" AutoLoad="false" AutoSync="true">
                                            <Proxy>
                                                <ext:HttpProxy Method="POST" Url="/Pagamento/CarregaAlunos"/>
                                            </Proxy>
                                            <Reader>
                                                <ext:JsonReader Root="cobrancas">
                                                    <Fields>
                                                        <ext:RecordField Name="idAluno" />
                                                        <ext:RecordField Name="aluno" />
                                                        <ext:RecordField Name="curso" />
                                                        <ext:RecordField Name="valor" />
                                                        <ext:RecordField Name="situacao" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                            <BaseParams>
                                                <ext:Parameter Name="mes" Value="#{mes}.getValue()" Mode="Raw" />
                                            </BaseParams>
                                        </ext:Store>
                                    </Store>          
                                    <ColumnModel ID="ColumnModel1" runat="server">
                                        <Columns>
                                            <ext:RowNumbererColumn ColumnID="number" />
                                            <ext:Column Header="idAluno" DataIndex="idAluno" Width="200" Hidden="true" />
                                            <ext:Column Header="Aluno" DataIndex="aluno"  Width="200" />
                                            <ext:Column Header="Curso" DataIndex="curso"  Width="200" />
                                            <ext:Column Header="Valor" DataIndex="valor" Width="200" >
                                                <Renderer Fn="formataDinheiro" />
                                            </ext:Column>
                                            <ext:Column Header="img" DataIndex="situacao" Width="100" Hidden="true" />
                                            <ext:TemplateColumn DataIndex="" MenuDisabled="true" Header="Situação">
                                                <Template ID="Template1" runat="server">
                                                    <Html>
						                                <tpl for=".">
							                                <div style="width:100%;text-align:center;"><img src="../Content/imagens/{situacao}" width="16px" /></div>
								                        </tpl>
					                                </Html>
                                                </Template>
                                            </ext:TemplateColumn>
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
