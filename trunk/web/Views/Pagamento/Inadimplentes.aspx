﻿<%@ Page Language="C#"  %>
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
        
        #customers-ct .header { padding : 10px 0px 10px 5px; }
        
        #customers-ct .header p { font-size : 2em; }

        #customers-ct .header a { margin-bottom : 10px; }
        
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

        var trataPessoaCPF = function (value, rec) {
            rec.CPFPessoa = rec.Pessoa.cpf;
        }

        var trataPessoaEmail = function (value, rec) {
            rec.emailPessoa = rec.Pessoa.email;
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
            <ext:HttpProxy Method="POST" Url="/Pagamento/FindInadimplentes" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="alunos" TotalProperty="totalReg" IDProperty="idAluno">
                <Fields>
                    <ext:RecordField Name="idAluno" Type="Int" />
                    <ext:RecordField Name="Pessoa.nome" Type="String">
                        <Convert Fn="trataPessoaNome" />
                    </ext:RecordField>
                    <ext:RecordField Name="Pessoa.cpf" Type="String">
                        <Convert Fn="trataPessoaCPF" />
                    </ext:RecordField>
                    <ext:RecordField Name="Pessoa.email" Type="String">
                        <Convert Fn="trataPessoaEmail" />
                    </ext:RecordField>
                    <ext:RecordField Name="nomePessoa" Type="String" />
                    <ext:RecordField Name="CPFPessoa" Type="String" />
                    <ext:RecordField Name="emailPessoa" Type="String" />
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    
    <ext:Toolbar runat="server">
        <Items>
            <ext:Button runat="server" Text="Imprimir Relatório" Icon="Printer" OnClientClick="window.print();" />
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
				<div id="customers-ct">
					<div class="header">
						<p>Alunos Inadimplentes</p>                                                                        
					</div>
					<table>
						<tr>
							<th>Nome</th>
							<th>CPF</th>
							<th>E-mail</th>
						</tr>
					
						<tpl for=".">
									<tr class="customer-record">
                                        <td class="cust-name" emailPessoa="{emailPessoa}" nomePessoa="{nomePessoa}" CPFPessoa="{CPFPessoa}">&nbsp;{nomePessoa}</td>
                                        <td>&nbsp;{CPFPessoa}</td>
                                        <td>&nbsp;{emailPessoa}</td>
									</tr>
						</tpl>                    
					</table>
				</div>
			</Html>
        </Template>
        <Listeners>
            <ContainerClick Fn="viewClick" />
            <Click Fn="nodeClick" />
        </Listeners>
    </ext:DataView>
</body>
</html>