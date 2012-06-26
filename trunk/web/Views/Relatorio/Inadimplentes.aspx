<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Relatório de Inadimplentes</title>
    
    <style type="text/css">
        body  {
            font : normal 11px tahoma, arial, helvetica, sans-serif;
        }
        
        #customers-ct table { width : 100% !important; }
        
        #customers-ct th {
            background : #F0F4F5 url(/extjs/resources/images/default/toolbar/bg-gif/ext.axd) repeat-x scroll left top;
            font-weight : bold;
            padding : 8px 5px;
        }
       
        #customers-ct td {
            padding : 5px;
            border-bottom : 1px solid silver;
        }
        
        #customers-ct .letter-row {
            padding-top : 15px;
            border : none;
        }
        
        #customers-ct .letter-row h2 { font-size : 2em; }
        
        .header { padding : 10px 0px 10px 5px; }
        
        .header p { font-size : 2em; text-align:center }

        .header a { margin-bottom : 10px; }
        
        .cust-name-over {
            cursor : pointer;
            background-color : #efefef;
        }
        
        #customers-ct .letter-row div {
            border-bottom : 2px solid #99bbe8;
            cursor : pointer;
            background : transparent url(/extjs/resources/images/default/grid/group-expand-sprite-gif/ext.axd) no-repeat 0px -42px;
            margin-bottom : 5px;
        }

        #customers-ct .letter-row div h2  { padding-left : 18px; }

        #customers-ct .letter-row div.collapsed { background-position : 0px 8px; }
        
        #customers-ct tr.collapsed { display : none; }
        
        .customer-label {
            font-weight : bold;
            font-size : 12px;
            padding : 5px 0px 5px 28px;            
            width : 150px;
        }
    </style>
    
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

        var viewClick = function (dv, e) {
            var group = e.getTarget("h2.letter-selector");

            if (group) {
                Ext.fly(group).up("div").toggleClass("collapsed");
                Ext.select("#customers-ct tr.l-" + group.innerHTML).toggleClass("collapsed");
            }
        };

        var nodeClick = function (view, index, node, e) {
            var nd = Ext.fly(node).first("td");

            DataViewContextMenu.node = {
                nome: nd.getAttributeNS("", "nomePessoa"),
                cpf: nd.getAttributeNS("", "CPFPessoa"),
                email: nd.getAttributeNS("", "emailPessoa"),
                contato: nd.dom.innerHTML
            };

            DataViewContextMenu.showAt(e.getXY());
        };

        var trataPessoaNome = function (value, rec) {
            rec.nomePessoa = rec.Pessoa.nome;
        }

        var trataData = function (value, rec) {
            var data = new Date(rec.dataVencimento);
            rec.dataVencimentoFormatado = data.format("d/m/Y");
        }

        var trataValor = function (value, rec) {
            rec.valorTotalFormatado = formataDinheiro(rec.valorTotal);
        }
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />
    
    <ext:Menu ID="DataViewContextMenu" runat="server">
        <Items>
            <ext:MenuTextItem ID="CustomerLabel" runat="server" CtCls="customer-label"  />
            <ext:MenuItem runat="server" Text="Enviar Email" Icon="Mail">   
                <Listeners>
                    <Click Handler="if (Ext.isEmpty(this.parentMenu.node.email, false)) { Ext.Msg.alert('Error', 'Customer has no email');} else { parent.location = 'mailto:'+this.parentMenu.node.email }" />
                </Listeners>                
            </ext:MenuItem>
        </Items>
       <Listeners>
            <BeforeShow Handler="#{CustomerLabel}.setText(this.node.contato);" />
        </Listeners>
    </ext:Menu> 
    
    <ext:Store ID="dsReport" runat="server">
        <Proxy>
            <ext:HttpProxy Method="POST" Url="/Relatorio/FindInadimplentes" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="alunos" TotalProperty="totalReg" IDProperty="idAluno">
                <Fields>
                    <ext:RecordField Name="idAluno" Type="Int" />
                    <ext:RecordField Name="nome" Type="String" />
                    <ext:RecordField Name="telefone" Type="String" />
                    <ext:RecordField Name="celular" Type="String" />
                    <ext:RecordField Name="email" Type="String" />
                    <ext:RecordField Name="dataVencimento" Type="String" >
                        <Convert Fn="trataData" />
                    </ext:RecordField>
                    <ext:RecordField Name="valorTotal" Type="Float" >
                        <Convert Fn="trataValor" />
                    </ext:RecordField>
                    <ext:RecordField Name="valorTotalFormatado" Type="String" />
                    <ext:RecordField Name="dataVencimentoFormatado" Type="String" />
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    
    <ext:Toolbar ID="Toolbar2" runat="server">
        <Items>
            <ext:Button ID="Button1" runat="server" Text="Imprimir Relatório" Icon="Printer" OnClientClick="window.print();" />
        </Items>
    </ext:Toolbar>
    
    <ext:DataView 
        runat="server" 
        StoreID="dsReport" 
        SingleSelect="true"
        ItemSelector="tr.customer-record" 
        OverClass="cust-name-over"
        EmptyText="Não há alunos inadimplentes.">
        <Template ID="Template1" runat="server">
            <Html>
                <div class="header">
                    <p>Relatório de Alunos Inadimplentes</p>
                    <p>V Mendonsa da Costa Idiomas e Informática</p>
                    <p>CNPJ: 10.668.613/0001-55</p>
                    <br />
                </div>
				<div id="customers-ct">
					<table>
						<tr>
							<th>Nome</th>
							<th>Telefone</th>
							<th>Celular</th>
                            <th>E-mail</th>
                            <th>Data Vencimento</th>
                            <th>Saldo Devedor</th>
						</tr>
					
						<tpl for=".">
									<tr class="customer-record">
                                        <td class="cust-name">&nbsp;{nome}</td>
                                        <td>&nbsp;{telefone}</td>
                                        <td>&nbsp;{celular}</td>
                                        <td>&nbsp;{email}</td>
                                        <td>&nbsp;{dataVencimentoFormatado}</td>
                                        <td>&nbsp;{valorTotalFormatado}</td>
									</tr>
						</tpl>                    
					</table>
				</div>
			</Html>
        </Template>
    </ext:DataView>
</body>
</html>