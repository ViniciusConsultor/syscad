<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cargos e Funcionários</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">

    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER

    var novaEspecializacao = function () {
        Ext.getCmp("txtNome").reset();
        winNovo.show();
    }

    var novoProfessor = function () {
        Ext.getCmp("txtNome").reset();
        winNovoProfessorEspecializacao.show();
    }

</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>
<script src="../../Scripts/funcoes.js" type="text/javascript"></script>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" RemoveViewState="true" IDMode="Explicit" />
    
    <ext:Viewport ID="ViewPort1" runat="server">
        <Items>
            <ext:BorderLayout ID="BorderLayout1" runat="server">
                <North MarginsSummary="5 5 5 5">
                    <ext:Panel 
                        ID="pnlInformation" 
                        runat="server" 
                        Title="Descrição" 
                        Height="80" 
                        Padding="5"
                        Frame="true" 
                        Icon="Information">
                        <Content>
                            <h1>Cadastrar Especializacao dos Professores</h1>
                            <p>Selecione o professor no primeiro GRID para que o segundo GRID seja preenchido com as especializações</p>
                        </Content>
                    </ext:Panel>
                </North>
                <Center MarginsSummary="5 5 5 5">
                    <ext:Panel ID="pnlCenter" Layout="Fit" runat="server" Frame="true" Title="Especializacoes" Icon="UserSuitBlack">

                        <Items>
                            <ext:GridPanel 
                                ID="GridPanel"
                                runat="server" 
                                StripeRows="true"
                                TrackMouseOver="true"
                                Icon="UserSuitBlack"
                                AutoExpandColumn="nome"
                                >
                                <Store>
                                    <ext:Store 
                                        ID="StoreEspecializacao" 
                                        runat="server">
                                        <Proxy>
                                            <ext:HttpProxy Json="true" Method="GET" Url="/Especializacao/FindAll" AutoDataBind="true" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="especializacoes" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idEspecializacao" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Listeners>
                                    <KeyDown Fn="startEditing" />
                                    <AfterEdit Fn="afterEdit" />
                                </Listeners>
                                <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn />
                                            <ext:Column ColumnID="idEspecializacao" Header="Id" DataIndex="idEspecializacao" Hidden="true" />

                                            <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" Width="300" >
                                                <Editor>
                                                    <ext:TextField ID="txtNomeEspecializacaoEditar" runat="server" MaxLength="100" />
                                                </Editor>
                                            </ext:Column>
                                        </Columns>
                                </ColumnModel>

                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" SingleSelect="true">
                                        <Listeners>
                                            <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreProfessor}.reload();}; #{formulario}.getForm().loadRecord(record);" Buffer="250" />
                                        </Listeners>
                                    </ext:RowSelectionModel>
                                </SelectionModel>

                                <TopBar>
                                    <ext:Toolbar ID="Toolbar3" runat="server">
                                        <Items>
                                            <ext:Button ID="Button2" runat="server" Text="Novo" Icon="Add">
                                                <Listeners> 
                                                    <Click Handler="novaEspecializacao()" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="Button3" runat="server" Text="Excluir" Icon="Delete">
                                                <Listeners> 
                                                    <Click Handler="excluir()" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="Button5" runat="server" Text="Editar" Icon="Information">
                                                <Listeners> 
                                                    <Click Handler="editar()" />
                                                </Listeners>
                                            </ext:Button>
                                        </Items>
                                    </ext:Toolbar>
                                </TopBar>

                                <BottomBar>
                                    <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" />
                                </BottomBar>
                            </ext:GridPanel>
                        </Items>
                    </ext:Panel>
                </Center>
                <South MarginsSummary="0 5 5 5">
                    <ext:Panel ID="pnlSouth" runat="server" Frame="true" Title="Professores" Icon="UserSuitBlack" Layout="Fit"  Split="true" Collapsible="true" Height="200">
                        <Items>
                            <ext:GridPanel 
                                ID="GridPanel1"
                                runat="server" 
                                StripeRows="true"
                                TrackMouseOver="true"
                                Icon="UserSuitBlack"
                                AutoExpandColumn="Funcionario.Pessoa.nome"
                                >
                                <Store>
                                    <ext:Store 
                                        ID="StoreProfessor" 
                                        runat="server">
                                        <Proxy>
                                            <ext:HttpProxy Json="true" Method="GET" Url="/Funcionario/FindAllProfessores" AutoDataBind="true" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="funcionarios" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idFuncionarioEspecializacao" Type="Int" />
                                                    <ext:RecordField Name="Funcionario.Pessoa.nome" Type="String" />
                                                    <ext:RecordField Name="Funcionario.Pessoa.cpf" Type="String" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                        <BaseParams>
                                            <ext:Parameter Name="idEspecializacao" Value="Ext.getCmp('#{GridPanel}') && #{GridPanel}.getSelectionModel().hasSelection() ? #{GridPanel}.getSelectionModel().getSelected().data.idEspecializacao : -1" Mode="Raw" />               
                                        </BaseParams>
                                    </ext:Store>
                                </Store>
                                <Listeners>
                                    <KeyDown Fn="startEditing" />
                                    <AfterEdit Fn="afterEdit" />
                                </Listeners>
                                <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn />
                                            <ext:Column ColumnID="idFuncionarioEspecializacao" Header="Id" DataIndex="idFuncionarioEspecializacao" Hidden="true" />
                                            <ext:Column ColumnID="Funcionario.Pessoa.nome" Header="Nome" DataIndex="Funcionario.Pessoa.nome" AutoDataBind="true" Width="300" />
                                            <ext:Column ColumnID="Funcionario.Pessoa.cpf" Header="CPF" DataIndex="Funcionario.Pessoa.cpf" />
                                        </Columns>
                                </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                        <Listeners>
                                            <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreEspecializacao}.reload();}; #{formulario}.getForm().loadRecord(record);" Buffer="250" />
                                        </Listeners>
                                    </ext:RowSelectionModel>
                                </SelectionModel>
                                <TopBar>
                                    <ext:Toolbar ID="Toolbar2" runat="server">
                                        <Items>
                                            <ext:Button ID="Button1" runat="server" Text="Novo" Icon="Add">
                                                <Listeners> 
                                                    <Click Handler="novoProfessor()" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="Button4" runat="server" Text="Excluir" Icon="Delete">
                                                <Listeners> 
                                                    <Click Handler="excluir()" />
                                                </Listeners>
                                            </ext:Button>
                                        </Items>
                                    </ext:Toolbar>
                                </TopBar>

                                <BottomBar>
                                    <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="10" />
                                </BottomBar>
                            </ext:GridPanel>
                        </Items>
                    </ext:Panel>
                </South>
            </ext:BorderLayout>
        </Items>
    </ext:Viewport>


    <form id="Novo" runat="server">
    
        <ext:Window 
                ID="winNovo" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Nova Especialização" 
                Hidden="true"
                X="250"
                Y="100"
                Layout="FormLayout"
                AutoHeight="true"
                Frame="true"
                Width="300"
                Modal="true"
                >
                <Items>
                    <ext:FormPanel ID="formulario" runat="server">
                        <Items>
                            <ext:TextField ID="txtNome" runat="server" FieldLabel="Nome" InputType="Text" Width="175" AllowBlank="false" MaxLength="100"/>
                        </Items>

                        <BottomBar>
                            <ext:Toolbar ID="Toolbar1" runat="server">
                                <Items>
                                    <ext:ToolbarFill />
                                        <ext:Button ID="btnSalvar" Text="Salvar" Icon="Disk" runat="server">
                                            <Listeners>
                                                <Click Handler="salvar()" />
                                            </Listeners>
                                        </ext:Button>
                                </Items>
                            </ext:Toolbar>  
                        </BottomBar>

                    </ext:FormPanel>
                </Items>
        </ext:Window>
    </form>

    <ext:Window 
                ID="winNovoProfessorEspecializacao" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Novo Professor/Especialização" 
                Hidden="true"
                X="250"
                Y="100"
                Layout="FormLayout"
                AutoHeight="true"
                Frame="true"
                Width="500"
                Modal="true">
                <Items>
                    <ext:FormPanel ID="professor" runat="server">
                        <Items>
                            <ext:ComboBox ID="cmbProfessor" 
                                runat="server" 
                                DisplayField="Pessoa.nome" 
                                ValueField="idFuncionario" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Professor"
                                TriggerAction="All"
                                AllowBlank="false">
                                <Store>
                                    <ext:Store ID="Store3" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Funcionario/FindAllProfessor" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="professores" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idFuncionario" Type="Int" />
                                                    <ext:RecordField Name="Pessoa.nome" Type="String">
                                                        <Convert Fn="convertePessoa()" />
                                                    </ext:RecordField>
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template2" runat="server">
                                   <Html>
					                   <tpl for=".">
						                  <div class="search-item">
							                 <h3>{nomePessoa}</h3>
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                            </ext:ComboBox>
                    </Items>
                    </ext:FormPanel>
                </Items>
                <BottomBar>
                    <ext:Toolbar ID="Toolbar4" runat="server">
                        <Items>
                            <ext:ToolbarFill />
                                <ext:Button ID="Button10" Text="Salvar" Icon="Disk" runat="server">
                                    <Listeners>
                                        <Click Handler="salvarEndereco(#{endereco}.getForm().getValues())" />
                                    </Listeners>
                                </ext:Button>
                        </Items>
                    </ext:Toolbar>  
                </BottomBar>
        </ext:Window>


</body>
</html>
