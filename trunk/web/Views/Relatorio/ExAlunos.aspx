﻿<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Relatório de Ex-Alunos</title>
    
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
        
        .header { padding : 10px 0px 10px 5px; display:none; }
        
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
        
        .logo
        {
            float:left;
            position:absolute;            
        }

    </style>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
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
            rec.nomePessoa = rec.nome;
        }

        var trataPessoaTelefone = function (value, rec) {
            rec.telefonePessoa = rec.telefone;
        }

        var trataPessoaTelefoneCelular = function (value, rec) {
            rec.telefoneCelularPessoa = rec.celular;
        }

        var trataPessoaEmail = function (value, rec) {
            rec.emailPessoa = rec.email;
        }

        var enviar = function () {
            var dtInicio = Ext.getCmp('dtInicio').getValue();
            var dtFim = Ext.getCmp('dtFim').getValue();
            Ext.getCmp("Toolbar1").show();
            Ext.getCmp("DataView1").show();
            Ext.getCmp("DataView1").getStore().reload();
            Ext.getCmp("winPeriodo").hide();

            $(".header").show();
            Ext.getCmp("periodo").show().setText("Período: " + dtInicio.format("d/m/Y") + " até " + dtFim.format("d/m/Y"));
        }
    </script>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" />
    
    <ext:Store ID="dsReport" runat="server" AutoLoad="false">
        <Proxy>
            <ext:HttpProxy Method="POST" Url="/Relatorio/FindExAlunos" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="alunos" TotalProperty="totalReg" IDProperty="idAluno">
                <Fields>
                    <ext:RecordField Name="idAluno" Type="Int" />
                    <ext:RecordField Name="nome" Type="String">
                        <Convert Fn="trataPessoaNome" />
                    </ext:RecordField>
                    <ext:RecordField Name="email" Type="String">
                        <Convert Fn="trataPessoaEmail" />
                    </ext:RecordField>
                    <ext:RecordField Name="telefone" Type="String">
                        <Convert Fn="trataPessoaTelefone" />
                    </ext:RecordField>
                    <ext:RecordField Name="celular" Type="String">
                        <Convert Fn="trataPessoaTelefoneCelular" />
                    </ext:RecordField>
                    <ext:RecordField Name="nomePessoa" Type="String" />
                    <ext:RecordField Name="emailPessoa" Type="String" />
                    <ext:RecordField Name="telefonePessoa" Type="String" />
                    <ext:RecordField Name="telefoneCelularPessoa" Type="String" />
                </Fields>
            </ext:JsonReader>
        </Reader>
        <BaseParams>
            <ext:Parameter Name="dtInicio" Value="Ext.getCmp('dtInicio').getValue()" Mode="Raw" />
            <ext:Parameter Name="dtFim" Value="Ext.getCmp('dtFim').getValue()" Mode="Raw" />
        </BaseParams>
    </ext:Store>
    
    <ext:Toolbar ID="Toolbar1" runat="server" Hidden="true">
        <Items>
            <ext:Button ID="Button1" runat="server" Text="Imprimir Relatório" Icon="Printer" OnClientClick="window.print();" />
            <ext:Button ID="Button2" runat="server" Text="Trocar Periodo" Icon="Clock" OnClientClick="winPeriodo.show();" />
        </Items>
    </ext:Toolbar>
    
    <div class="header">
        <div class="logo"><img src="../../Content/imagens/logo_masterCurso.png" width="150px" /></div>
        <p>Relatório de Ex-Aluno</p>
        <p>V Mendonsa da Costa Idiomas e Informática</p>
        <p>CNPJ: 10.668.613/0001-55</p>
        <br />
    </div>
    <ext:Label ID="periodo" runat="server" LabelWidth="50" Hidden="true" AnchorHorizontal="100%"  />
    <br /><br />
    <ext:DataView ID="DataView1" 
        runat="server" 
        StoreID="dsReport" 
        SingleSelect="true"
        ItemSelector="tr.customer-record" 
        OverClass="cust-name-over"
        EmptyText="<center><br/><h3>Não há ex-alunos neste período</h3></center>"
        Hidden="true">
        <Template ID="Template1" runat="server">
            <Html>
				<div id="customers-ct">
					<table>
						<tr>
							<th>Nome</th>
                            <th>E-mail</th>
                            <th>Telefone</th>
                            <th>Celular</th>
						</tr>
					
						<tpl for=".">
									<tr class="customer-record">
                                        <td class="cust-name" nomePessoa="{nomePessoa}" emailPessoa="{emailPessoa}" telefonePessoa="{telefonePessoa}" telefoneCelularPessoa="{telefoneCelularPessoa}">&nbsp;{nomePessoa}</td>
                                        <td>&nbsp;{emailPessoa}</td>
                                        <td>&nbsp;{telefonePessoa}</td>
                                        <td>&nbsp;{telefoneCelularPessoa}</td>
									</tr>
						</tpl>                    
					</table>
				</div>
			</Html>
        </Template>
    </ext:DataView>

    <ext:Window 
        ID="winPeriodo" 
        runat="server" 
        Icon="Clock" 
        Title="Periodo" 
        X="250"
        Y="100"
        Layout="FormLayout"
        AutoHeight="true"
        Frame="true"
        Width="250"
        Modal="true"
        Closable="false"
        >
        <Items>
            <ext:FormPanel ID="formulario" runat="server">
                <Items>
                    <ext:DateField ID="dtInicio" runat="server" FieldLabel="Data Inicio" AnchorHorizontal="100%" AllowBlank="false" /> 
                    <ext:DateField ID="dtFim" runat="server" FieldLabel="Data Fim" AnchorHorizontal="100%" AllowBlank="false" /> 
                </Items>

                <BottomBar>
                    <ext:Toolbar ID="Toolbar2" runat="server">
                        <Items>
                            <ext:ToolbarFill />
                                <ext:Button ID="btnSalvar" Text="Enviar" Icon="Disk" runat="server">
                                    <Listeners>
                                        <Click Handler="Ext.getCmp('formulario').getForm().isValid() ? enviar(): void(0);" />
                                    </Listeners>
                                </ext:Button>
                        </Items>
                    </ext:Toolbar>  
                </BottomBar>

            </ext:FormPanel>
        </Items>

    </ext:Window>
</body>
</html>