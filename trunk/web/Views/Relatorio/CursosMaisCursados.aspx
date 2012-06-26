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

        var enviar = function () {
            Ext.getCmp("Toolbar1").show();
            Ext.getCmp("DataView1").show();
            Ext.getCmp("DataView1").getStore().reload();
            Ext.getCmp("winPeriodo").hide();
        }
    </script>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" />
    
    <ext:Menu ID="DataViewContextMenu" runat="server">
        <Items>
            <ext:MenuTextItem ID="CustomerLabel" runat="server" CtCls="customer-label"  />
            <ext:MenuItem ID="MenuItem1" runat="server" Text="Enviar Email" Icon="Mail">   
                <Listeners>
                    <Click Handler="if (Ext.isEmpty(this.parentMenu.node.email, false)) { Ext.Msg.alert('Error', 'Customer has no email');} else { parent.location = 'mailto:'+this.parentMenu.node.email }" />
                </Listeners>                
            </ext:MenuItem>
            <ext:MenuItem ID="MenuItem2" runat="server" Text="Mostrar Detalhes" Icon="ApplicationFormEdit">
                <Listeners>
                    <Click Handler="Ext.Msg.alert('Detalhes', Ext.encode(this.parentMenu.node));" />
                </Listeners>
            </ext:MenuItem>
        </Items>
       <Listeners>
            <BeforeShow Handler="#{CustomerLabel}.setText(this.node.contato);" />
        </Listeners>
    </ext:Menu> 
    
    <ext:Store ID="dsReport" runat="server" AutoLoad="false">
        <Proxy>
            <ext:HttpProxy Method="POST" Url="/Relatorio/FindCursoMaisCursado" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="cursos" TotalProperty="totalReg">
                <Fields>
                    <ext:RecordField Name="Curso" Type="String" />
                    <ext:RecordField Name="QtdAluno" Type="Int" />
                    <ext:RecordField Name="dtInicio" Type="String" />  
                    <ext:RecordField Name="dtFim" Type="String" />                       
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
     
    <ext:DataView ID="DataView1" 
        runat="server" 
        StoreID="dsReport" 
        SingleSelect="true"
        ItemSelector="tr.customer-record" 
        OverClass="cust-name-over"
        EmptyText="<center><br/><h3>Não há nenhum aluno matriculado neste período</h3></center>"
        Hidden="true">
        <Template ID="Template1" runat="server">
            <Html>
                <div class="header">
                    <p>Relatório de Cursos mais procurados</p>
                    <p>V Mendonsa da Costa Idiomas e Informática</p>
                    <p>CNPJ: 10.668.613/0001-55</p>
                    <br />
                </div>
				<div id="customers-ct">
					<table>
						<tr>
							<th>Curso</th>
							<th>QtdAluno</th>
						</tr>
					
						<tpl for=".">
									<tr class="customer-record">
                                        <td class="cust-name" emailPessoa="{Curso}" nomePessoa="{QtdAluno}">&nbsp;{Curso}</td>
                                        <td>&nbsp;{QtdAluno}</td>
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
                                        <Click Handler="enviar()" />
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