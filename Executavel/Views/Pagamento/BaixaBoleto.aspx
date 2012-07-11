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

        var formataValor = function (val) {
            return val.toString().replace(/\,/g, '.');
        }

        var trataDados = function (value, rec) {
            if (value == 0) {
                rec.nomeCobranca = "Mensalidade";
                var dataAtual = new Date();
                var dataVencimento = new Date(rec.dataVencimento);
                if (dataAtual > dataVencimento) {
                    rec.valorCobranca = rec.Curso.valor;
                    rec.valorTotal = rec.Curso.valor + rec.juros;
                } else {
                    rec.valorCobranca = rec.Curso.valor;
                }
            } else {
                rec.nomeCobranca = rec.Taxa.nome;
                var dataAtual = new Date();
                var dataVencimento = new Date(rec.dataVencimento);
                if (dataAtual > dataVencimento) {
                    rec.valorCobranca = rec.Taxa.valor;
                    rec.valorTotal = rec.Taxa.valor + rec.juros;
                } else {
                    rec.valorCobranca = rec.Taxa.valor;
                }

            }
        }


        var BaixaBoleto = function (command, record) {
            $.post("/Pagamento/PagarBoleto", { idCobranca: record.data.idCobranca, valorPagar: record.data.valorCobranca, formaPag_Value: 3 }, function () {
                Ext.Msg.show({
                    title: 'Sucesso',
                    msg: 'Boleto baixado com sucesso!',
                    buttons: Ext.Msg.OK,
                    icon: Ext.Msg.INTO,
                    fn: function () {
                        Ext.getCmp("grdCobrancas").reload();
                    }
                });
            });
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
                               <ext:Label ID="Label1" Html="<h1>Informe a matricula ou o nome do aluno para realizar o pagamento!</h1><br />" runat="server" />
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
                            AutoExpandColumn="Curso.nome" 
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
                                                <ext:RecordField Name="idTaxa" Type="Int" >
                                                    <Convert fn="trataDados" />
                                                </ext:RecordField>
                                                <ext:RecordField Name="Taxa.valor" Type="Float" />
                                                <ext:RecordField Name="juros" Type="Float" />
                                                <ext:RecordField Name="valorTotal" Type="Float" />
                                                <ext:RecordField Name="Aluno.nome" Type="string" />
                                                <ext:RecordField Name="valorPago" Type="Float" />
                                                <ext:RecordField Name="valorFaltante" Type="Float" />
                                                <ext:RecordField Name="idCurso" Type="Int" />
                                                <ext:RecordField Name="Curso.valor" Type="Float" />
                                                <ext:RecordField Name="valorCobranca" Type="Float" />
                                                <ext:RecordField Name="nomeCobranca" Type="String" />
                                                <ext:RecordField Name="Curso.nome" Type="String" />
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
                                    <ext:Column DataIndex="Curso.nome" Header="Curso" />
                                    <ext:Column DataIndex="nomeCobranca" Header="Cobrança" >                                     
                                    </ext:Column>
                                    <ext:DateColumn DataIndex="dataVencimento" Header="Data de Vencimento" Width="150" Format="dd/MM/yyyy" />
                                    <ext:Column DataIndex="valorCobranca" Header="Valor" Width="100">
                                        <Renderer Fn="formataDinheiro" />
                                    </ext:Column>
                                    <ext:Column DataIndex="juros" Header="Juros" Width="100" >
                                        <Renderer Fn="formataDinheiro" />
                                    </ext:Column>
                                    <ext:Column DataIndex="valorTotal" Header="ValorTotal" Width="100" >
                                        <Renderer Fn="formataDinheiro" />
                                    </ext:Column>
                                    <ext:CommandColumn Width="110" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="MoneyDelete" CommandName="Boleto" Text="Baixa Boleto"  />
                                        </Commands>
                                    </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                    <Listeners>
                                        <RowSelect Handler="void(0)" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel> 
                            <Listeners>
                                <Command Handler="BaixaBoleto(command, record)" />
                            </Listeners>  
                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolbar1" runat="server" />
                            </BottomBar>
                            <LoadMask ShowMask="true" />
                        </ext:GridPanel>
                    </Center>                   
                </ext:BorderLayout>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
