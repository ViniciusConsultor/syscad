<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Realizar Pagamento</title>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .faltante
        {
            font-weight:bold;
            color:Red;
        }
        .x-window-mc
        {
            background:#fff
        }
        .frameBoleto
        {
            height:525px
        }
    </style>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.maskMoney.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#valorPagar").maskMoney();
        });

       var formataDinheiro = function(num) {
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

        var pagar = function (serialize) {
            $.post('/Pagamento/Pagar', serialize, function (result) {
                success:
                {
                    Ext.Msg.show({
                        title: 'Sucesso',
                        msg: result.message,
                        buttons: Ext.Msg.OK,
                        icon: Ext.Msg.INFO
                    });                    
                }
            });
        };

        var realizarPagamento = function (serialize) {
            var valorTotal = parseFloat(Ext.getCmp("grdCobrancas").getSelectionModel().getSelected().data.valorTotal);
            var valorPagar = parseFloat($("#valorPagar").val());
            var valorPago = parseFloat($("#_valorPago").val());
            var valorFaltante = parseFloat($("#_valorFaltante").val());

            if ((valorPagar + valorPago) > valorTotal) {
                Ext.Msg.show({
                    title: 'Erro',
                    msg: 'O valor pago é maior que o valor total!',
                    buttons: Ext.Msg.OK,
                    icon: Ext.Msg.ERROR
                });

            } else if ((valorPagar + valorPago) < valorTotal) {
                Ext.Msg.confirm("Atenção", "O valor pago é menor que o valor total, deseja continuar?", function (btn) {
                    if (btn == "yes") {
                        mostrarCampos(Ext.getCmp("grdCobrancas").getSelectionModel().getSelected());
                        $("#valorPago").text(formataDinheiro(valorPago + valorPagar));
                        $("#_valorPago").text(valorPago + valorPagar);
                        $("#valorFaltante").text(formataDinheiro(valorTotal - (valorPago + valorPagar)));
                        $("#_valorFaltante").text(valorTotal - (valorPago + valorPagar));
                        $("#valorPagar").val('');
                        $("#formaPag").val('');
                        pagar(serialize);
                    }
                });
            } else if ((valorPagar + valorPago) == valorTotal) {
                Ext.getCmp("FormPanel1").toggleCollapse();
                Ext.getCmp("valorPago").hide();
                Ext.getCmp("valorFaltante").hide();
                pagar(serialize);
                mudarStatus();
                Ext.getCmp("FormPanel1").getForm().reset();
            }
        }

        var mudarStatus = function () {
            var idCobranca = Ext.getCmp("idCobranca").getValue();
            $.post("/Pagamento/MudarStatus", { idCobranca: idCobranca, status: 6 }, function (result) {
                complete:
                {
                    Ext.getCmp('grdCobrancas').getStore().reload();
                }
            });
        };

        var LoadFormulario = function (record) {
            Ext.getCmp("FormPanel1").expand();
            var dataVenc = new Date(record.data.dataVencimento);
            Ext.getCmp("dataVencimento").setValue(dataVenc.format("d/m/Y"));
            Ext.getCmp("valorTotal").setValue(formataDinheiro(record.data.valorTotal));
            if (record.data.valorPago != "") {
                mostrarCampos(record);
            } else {
                esconderCampos();
            }
        }

        var mostrarCampos = function (record) {
            Ext.getCmp("valorPago").show();
            Ext.getCmp("valorFaltante").show();
            Ext.getCmp("valorPago").setValue(formataDinheiro(record.data.valorPago));
            Ext.getCmp("_valorPago").setValue(record.data.valorPago);
            Ext.getCmp("valorFaltante").setValue(formataDinheiro(record.data.valorFaltante));
            Ext.getCmp("_valorFaltante").setValue(record.data.valorFaltante);
        }

        var esconderCampos = function () {
            Ext.getCmp("valorPago").hide();
            Ext.getCmp("valorFaltante").hide();
        }

        var GerarBoleto = function (idCobranca) {

            window.open("/Pagamento/GerarBoleto/?idCobranca=" + idCobranca, "Boleto Bancário", "Width=750px,height=550px,scrollbars=yes,resizable=no,location=no");

        }

    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <ext:Viewport ID="Viewport1" runat="server">
            <Items>
                <ext:BorderLayout ID="BorderLayout1" runat="server">
                    <North>
                        <ext:Panel ID="Panel1" 
                            runat="server" 
                            Region="North"
                            Margins="5 5 5 5"
                            Title="Informe Aluno" 
                            Height="100" 
                            Padding="5"
                            Frame="true" 
                            Icon="User">
                            <Items>
                               <ext:ComboBox ID="txtAluno" 
                                        runat="server" 
                                        DisplayField="nome" 
                                        ValueField="idAluno"
                                        FieldLabel="Aluno"
                                        TypeAhead="false" 
                                        LoadingText="Procurando..." 
                                        Width="350"
                                        LabelWidth="40"
                                        HideTrigger="false"
                                        ItemSelector="div.search-item"        
                                        MinChars="1"
                                        PageSize="10"
                                        TriggerAction="Query"
                                        TriggerIcon="Search"
                                        AutoFocus="true">
                                        <Store>
                                            <ext:Store ID="StoreAluno" runat="server" AutoLoad="false">
                                                <Proxy>
                                                    <ext:HttpProxy Method="POST" Url="/Pagamento/Search" />
                                                </Proxy>
                                                <Reader>
                                                    <ext:JsonReader Root="alunos" TotalProperty="totalReg" IDProperty="idAluno">
                                                        <Fields>
                                                            <ext:RecordField Name="idAluno" Type="Int" />
                                                            <ext:RecordField Name="nome" Type="String" />
                                                            <ext:RecordField Name="cpf" Type="String"/>
                                                            <ext:RecordField Name="email" Type="String" />
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                        </Store>
                                        <Template ID="Template4" runat="server">
                                           <Html>
					                           <tpl for=".">
						                          <div class="search-item">
							                         <h3><span>{cpf}</span>{nome}</h3>
							                         {email}
						                          </div>
					                           </tpl>
				                           </Html>
                                        </Template>
                                        <Listeners>
                                            <Select Handler="#{StoreCobrancas}.reload()" />
                                        </Listeners>
                                    </ext:ComboBox>
                            </Items>
                        </ext:Panel>
                    </North>
                    <Center>
                        <ext:GridPanel ID="grdCobrancas" 
                            runat="server" 
                            Title="Cobranças"
                            Margins="0 0 5 5"
                            Icon="Money"
                            Region="Center"
                            AutoExpandColumn="Taxa.nome" 
                            Frame="true">
                            <Store>
                                <ext:Store ID="StoreCobrancas" runat="server" AutoLoad="false">
                                    <Proxy>
                                        <ext:HttpProxy Method="GET" Url="/Pagamento/FindAllCobrancas" />
                                    </Proxy>
                                    <Reader>
                                        <ext:JsonReader Root="cobrancas" TotalProperty="totalReg" IDProperty="idCobranca">
                                            <Fields>
                                                <ext:RecordField Name="idCobranca" Type="int"/>
                                                <ext:RecordField Name="Taxa.nome" Type="String"/>
                                                <ext:RecordField Name="dataVencimento" DateFormat="dd/MM/yyyy" />
                                                <ext:RecordField Name="Taxa.valor" Type="Float" />
                                                <ext:RecordField Name="juros" Type="Float" />
                                                <ext:RecordField Name="valorTotal" Type="Float" />
                                                <ext:RecordField Name="Aluno.nome" Type="string" />
                                                <ext:RecordField Name="valorPago" Type="Float" />
                                                <ext:RecordField Name="valorFaltante" Type="Float" />
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                    <BaseParams>
                                        <ext:Parameter Name="idAluno" Value="#{txtAluno}.getValue()" Mode="Raw" /> 
                                    </BaseParams>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ColumnID="number" />
                                    <ext:Column DataIndex="idCobranca" Header="Id" Width="50" Hidden="true" />
                                    <ext:Column DataIndex="Taxa.nome" Header="Cobrança" />
                                    <ext:DateColumn DataIndex="dataVencimento" Header="Data de Vencimento" Width="150" Format="dd/MM/yyyy" />
                                    <ext:Column DataIndex="Taxa.valor" Header="Valor" Width="150">
                                        <Renderer Fn="formataDinheiro" />
                                    </ext:Column>
                                    <ext:Column DataIndex="juros" Header="Juros" Width="150" >
                                        <Renderer Fn="formataDinheiro" />
                                    </ext:Column>
                                    <ext:Column DataIndex="valorTotal" Header="ValorTotal" Width="150" >
                                        <Renderer Fn="formataDinheiro" />
                                    </ext:Column>
                                    <ext:CommandColumn Width="110" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="Money" CommandName="Boleto" Text="Boleto"  />
                                        </Commands>
                                    </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                    <Listeners>
                                        <RowSelect Handler="#{FormPanel1}.getForm().loadRecord(record); LoadFormulario(record);" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel> 
                            <Listeners>
                                <Command Handler="#{boletoWindow}.load('/Pagamento/GerarBoleto/?idCobranca='+record.data.idCobranca).show();" />
                            </Listeners>  
                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolbar1" runat="server" />
                            </BottomBar>
                            <LoadMask ShowMask="true" />
                        </ext:GridPanel>
                    </Center>
                    <East Collapsible="true" Split="false" >
                        <ext:FormPanel 
                            ID="FormPanel1" 
                            runat="server" 
                            Margins="0 5 5 5"
                            Frame="true" 
                            Title="Pagamento" 
                            Width="280"
                            Icon="MoneyDollar"
                            DefaultAnchor="100%"
                            Collapsed="true"
                            >
                            <Items>
                                <ext:Hidden ID="idCobranca" DataIndex="idCobranca" runat="server" />                                                     
                                <ext:DisplayField ID="DisplayField1" runat="server" FieldLabel="Aluno" DataIndex="Aluno.nome" />
                                <ext:DisplayField ID="DisplayField2" runat="server" FieldLabel="Cobrança" DataIndex="Taxa.nome" />
                                <ext:DisplayField ID="dataVencimento" runat="server" FieldLabel="Data Vencimento" />
                                <ext:DisplayField ID="valorTotal" runat="server" FieldLabel="Valor Total" DataIndex="valorTotal"/>
                                <ext:DisplayField ID="valorPago" runat="server" FieldLabel="Valor Pago" DataIndex="valorPago" Hidden="true" />
                                <ext:Hidden ID="_valorPago" runat="server" />
                                <ext:DisplayField ID="valorFaltante" runat="server" FieldLabel="Valor Faltante" DataIndex="valorFaltante" Hidden="true" Cls="faltante" />
                                <ext:Hidden ID="_valorFaltante" runat="server" />
                                <ext:NumberField ID="valorPagar" FieldLabel="Valor à pagar" runat="server" AllowBlank="false" />
                                <ext:ComboBox ID="formaPag" runat="server" FieldLabel="Forma Pagto" AllowBlank="false">
                                    <Items>
                                        <ext:ListItem Text="Dinheiro" Value="1" />
                                        <ext:ListItem Text="Cartão de Crédito" Value="2" />
                                    </Items>
                                </ext:ComboBox>
                                <ext:Button ID="btnPagar" Text="Realizar Pagamento" Icon="MoneyAdd" runat="server" >
                                    <Listeners>
                                        <Click Handler="realizarPagamento(#{FormPanel1}.getForm().getValues());" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:FormPanel>
                    </East>
                </ext:BorderLayout>
            </Items>
        </ext:Viewport>
    </form>
    <ext:Window ID="boletoWindow" runat="server" IDMode="Static" Title="Boleto Bancário"
      Hidden="true" Modal="true" Height="550px" Width="750px">
        <AutoLoad Url="/Pagamento/GerarBoleto" TriggerEvent="show" NoCache="true" ReloadOnEvent="true" ShowMask="true" MaskMsg="Carregando Boleto..."  Mode="IFrame">
            <Params>
                <ext:Parameter Name="idCobranca" Value="1" Mode="Raw" />
            </Params>
        </AutoLoad>              
        <Listeners>
            <Show Handler="boletoWindow.reload()" />
        </Listeners>
        <BottomBar>
        <ext:Toolbar ID="botoesBar" runat="server">
            <Items>
                <ext:ToolbarFill />
                <ext:Button ID="Button1" runat="server" Text="Imprimir" Icon="Printer">
                    <Listeners>
                        <Click Handler="#{boletoWindow}.getBody().print();" />
                    </Listeners>
                </ext:Button>
            </Items>
        </ext:Toolbar>
        </BottomBar>
  </ext:Window>
</body>
</html>
