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
    </style>
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

        var realizarPagamento = function (serialize) {          

            if (validaTotal()) {
                
                $.post('/Pagamento/Pagar', serialize, function (result) {
                    //grdNotaFalta.el.unmask();
                    success:
                    {
                        alert(result.message);
                    }
                });
            }

        };

        var validaTotal = function () {
            var valorTotal = $("#valorTotal").text();
            var valorPago = $("#valorPagar").val();

            if (valorPago < validaTotal) {
                if (confirm("O valor pago é menor que o valor total, deseja continuar?")) {
                    $("#valorPago").text(valorPago);
                    $("#valorFaltante").text(valorTotal - valorPago);
                    return true;
                }
            }
        }

        var LoadFormulario = function () {
            alert($("#valorPago").text());
        }

        var mostrarCampos = function (cmpFaltante, cmpValorPago) {
            cmpFaltante.show();
            cmpValorPago.show();
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
            salvarAlteracoes(e.record.data.IdAluno, e.record.data.IdTurma, e.record.data.IdModulo, e.field, e.value);
            var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;
            Ext.Msg.notify("Cadastrado com sucesso!", mensagem);

            grdNotaFalta.store.commitChanges();
        };
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
            
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
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
                <ext:GridPanel ID="GridPanel1" 
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
                                        <ext:RecordField Name="dataVencimento" Type="Date"/>
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
                            <ext:Column DataIndex="idCobranca" Header="Id" Width="50" />
                            <ext:Column DataIndex="Taxa.nome" Header="Cobrança" />
                            <ext:DateColumn DataIndex="dataVencimento" Header="Data de Vencimento" Width="150" Format="d/M/Y" />
                            <ext:Column DataIndex="Taxa.valor" Header="Valor" Width="150" />
                            <ext:Column DataIndex="juros" Header="Juros" Width="150" />
                            <ext:Column DataIndex="valorTotal" Header="ValorTotal" Width="150" />
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                            <Listeners>
                                <RowSelect Handler="#{FormPanel1}.getForm().loadRecord(record);" />
                            </Listeners>
                        </ext:RowSelectionModel>
                    </SelectionModel>   
                    <BottomBar>
                        <ext:PagingToolbar ID="PagingToolbar1" runat="server" />
                    </BottomBar>
                    <LoadMask ShowMask="true" />
                </ext:GridPanel>
                <ext:FormPanel 
                    ID="FormPanel1" 
                    runat="server" 
                    Region="East"
                    Split="true"
                    Margins="0 5 5 5"
                    Frame="true" 
                    Title="Pagamento" 
                    Width="280"
                    Icon="MoneyDollar"
                    DefaultAnchor="100%"
                    >
                    <Items>
                        <ext:Hidden ID="idCobranca" DataIndex="idCobranca" runat="server" />                       
                        <ext:DisplayField ID="DisplayField1" runat="server" FieldLabel="Aluno" DataIndex="Aluno.nome" />
                        <ext:DisplayField ID="DisplayField2" runat="server" FieldLabel="Cobrança" DataIndex="Taxa.nome" />
                        <ext:DisplayField ID="DisplayField4" runat="server" FieldLabel="Data Vencimento" DataIndex="dataVencimento" LabelWidth="150"  />
                        <ext:DisplayField ID="valorTotal" runat="server" FieldLabel="Valor Total" DataIndex="valorTotal" />
                        <ext:DisplayField ID="valorPago" runat="server" FieldLabel="Valor Pago" DataIndex="valorPago" Hidden="true" />
                        <ext:DisplayField ID="valorFaltante" runat="server" FieldLabel="Valor Faltante" DataIndex="valorFaltante" Hidden="true" Cls="faltante" />
                        <ext:NumberField ID="valorPagar" FieldLabel="Valor à pagar" runat="server" AllowBlank="false" />
                        <ext:ComboBox ID="formaPag" runat="server" FieldLabel="Forma Pagto" AllowBlank="false">
                            <Items>
                                <ext:ListItem Text="Dinheiro" Value="1" />
                                <ext:ListItem Text="Cartão de Crédito" Value="2" />
                            </Items>
                        </ext:ComboBox>
                        <ext:Button ID="btnPagar" Text="Realizar Pagamento" Icon="MoneyAdd" runat="server" >
                            <Listeners>
                                <Click Handler="mostrarCampos(#{valorFaltante},#{valorPago}); realizarPagamento(#{FormPanel1}.getForm().getValues());" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:FormPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
</html>
