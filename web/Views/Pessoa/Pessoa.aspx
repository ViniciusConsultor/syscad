<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Pessoas</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">

    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER

</script>
<script src="../../Scripts/funcoes.js" type="text/javascript"></script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>
<script src="../../Scripts/CRUD-Endereco.js" type="text/javascript"></script>


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
                            <h1>Cadastrar Pessoas e Endereços</h1>
                            <p>Selecione a pessoa no primeiro GRID para que o segundo GRID seja preenchido com os endereços da Pessoa</p>
                        </Content>
                    </ext:Panel>
                </North>
                <Center MarginsSummary="0 5 0 5">
                    <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Gerenciar Pessoas" Icon="User" Layout="Fit">
                        <Items>
                            <ext:GridPanel 
                                ID="GridPanel"
                                runat="server" 
                                StripeRows="true"
                                TrackMouseOver="true"
                                Width="1181" 
                                Height="704"
                                AutoExpandColumn="nome">
                                <Store>
                                    <ext:Store 
                                        ID="Store1" 
                                        runat="server">
                                        <Proxy>
                                            <ext:HttpProxy Json="true" Method="GET" Url="/Pessoa/FindAll" AutoDataBind="true" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="pessoas" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idPessoa" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                    <ext:RecordField Name="cpf" Type="String" />
                                                    <ext:RecordField Name="email" Type="String" />
                                                    <ext:RecordField Name="telefone" Type="String" />
                                                    <ext:RecordField Name="celular" Type="String" />
                                                    <ext:RecordField Name="dataNascimento" Type="Date" />
                                                    <ext:RecordField Name="sexo" Type="Int" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Listeners>
                                    <KeyDown Fn="startEditing" />
                                    <AfterEdit Fn="afterEdit" />
                                </Listeners>
                                <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn />
                                            <ext:Column ColumnID="idPessoa" Header="idPessoa" DataIndex="idPessoa" Hidden="true" />

                                            <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" Width="150" >
                                                <Editor>
                                                    <ext:TextField ID="txtNomeEditar" runat="server" AnchorHorizontal="100%" AllowBlank="false" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="cpf" Header="CPF" DataIndex="cpf" Width="150">
                                                <Editor>
                                                    <ext:TextField ID="txtCPFEditar" runat="server" AnchorHorizontal="100%" AllowBlank="false" MaxLength="11" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column Header="Email" DataIndex="email" Width="200" >
                                                <Editor>
                                                    <ext:TextField ID="txtEmailEditar" runat="server" AnchorHorizontal="100%" AllowBlank="false" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column Header="Telefone" DataIndex="telefone" Width="100">
                                                <Editor>
                                                    <ext:TextField ID="txtTelefoneEditar" runat="server" AnchorHorizontal="100%" AllowBlank="false" EnableKeyEvents="true" Mask="(##) ####-####" >
                                                        <Listeners>
                                                            <KeyPress Fn="mascara" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column Header="Celular" DataIndex="celular" Width="100" >
                                                <Editor>
                                                    <ext:TextField ID="txtCelularEditar" runat="server" AnchorHorizontal="100%" AllowBlank="false" EnableKeyEvents="true" Mask="(##) ####-####" >
                                                        <Listeners>
                                                            <KeyPress Fn="mascara" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Editor>
                                            </ext:Column>

                                            <ext:DateColumn DataIndex="dataNascimento" Header="Data de Nascimento" Width="200" Format="dd/MM/yyyy">
                                                <Editor>
                                                    <ext:DateField ID="dtNascimentoEditar" runat="server" AnchorHorizontal="100%" AllowBlank="false" /> 
                                                </Editor>
                                            </ext:DateColumn>
                        
                                            <ext:Column Header="Sexo" DataIndex="sexo" Width="150">
                                                <Renderer Fn="formataSexo" />
                                                <Editor>
                                                    <ext:ComboBox ID="txtSexoEditar" runat="server" Width="175" AnchorHorizontal="100%" AllowBlank="false">
                                                        <Items>
                                                            <ext:ListItem Text="Masculino" Value="1" />
                                                            <ext:ListItem Text="Feminino" Value="0" />
                                                        </Items>
                                                    </ext:ComboBox>
                                                </Editor>                                                
                                            </ext:Column>

                                        </Columns>
                                    </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                        <Listeners>
                                            <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreEndereco}.reload();}; #{endereco}.getForm().loadRecord(record);" Buffer="250" />
                                        </Listeners>
                                    </ext:RowSelectionModel>
                                </SelectionModel>

                                <TopBar>
                                    <ext:Toolbar ID="Toolbar2" runat="server">
                                        <Items>
                                            <ext:Button ID="Button4" runat="server" Text="Novo" Icon="Add">
                                                <Listeners> 
                                                    <Click Handler="winNovo.show()" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="Button6" runat="server" Text="Excluir" Icon="Delete">
                                                <Listeners> 
                                                    <Click Handler="excluirRegistro()" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="Button1" runat="server" Text="Editar" Icon="Information">
                                                <Listeners> 
                                                    <Click Handler="editar()" />
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
                </Center>
                <South Collapsible="true" Split="true" MarginsSummary="0 5 5 5">
                        <ext:Panel 
                            ID="pnlSouth" 
                            runat="server" 
                            Title="Gerenciar Endereços" 
                            Height="200" 
                            Icon="TransmitAdd" 
                            Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="GridPanelEndereco"
                                    runat="server" 
                                    AutoExpandColumn="logradouro"
                                    OnRefreshData="/Endereco/FindEnderecos">
                                    <Store>
                                        <ext:Store 
                                            ID="StoreEndereco" 
                                            runat="server"
                                            AutoLoad="false"
                                            >
                                            <Proxy>
                                                <ext:HttpProxy Json="true" Method="GET" Url="/Endereco/FindEnderecos" />
                                            </Proxy>
                                            <Reader>
                                                <ext:JsonReader Root="enderecos" TotalProperty="totalReg">
                                                    <Fields>
                                                        <ext:RecordField Name="idEndereco" Type="Int" />
                                                        <ext:RecordField Name="TipoEndereco.nome" Type="String" />
                                                        <ext:RecordField Name="Pessoa.nome" Type="String" />
                                                        <ext:RecordField Name="logradouro" Type="String" />
                                                        <ext:RecordField Name="numero" Type="Int" />
                                                        <ext:RecordField Name="complemento" Type="String" />
                                                        <ext:RecordField Name="CEP" Type="String" />
                                                        <ext:RecordField Name="bairro" Type="String" />
                                                        <ext:RecordField Name="cidade" Type="String" />
                                                        <ext:RecordField Name="uf" Type="String" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                            <BaseParams>
                                                <ext:Parameter Name="idPessoa" Value="Ext.getCmp('#{GridPanel}') && #{GridPanel}.getSelectionModel().hasSelection() ? #{GridPanel}.getSelectionModel().getSelected().data.idPessoa : -1" Mode="Raw" />               
                                            </BaseParams>
                                        </ext:Store>
                                    </Store>
                                    <Listeners>
                                        <KeyDown Fn="startEditingEndereco" />
                                        <AfterEdit Fn="afterEditEndereco" />
                                    </Listeners>                                    
                                    <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn />
                                            <ext:Column ColumnID="idEndereco" Header="IdEndereco" DataIndex="idEndereco" Width="50" Hidden="true"/>
                                            <ext:Column ColumnID="idTipoEndereco" Header="Tipo Endereço" DataIndex="TipoEndereco.nome" Width="125">
                                                <Editor>
                                                    <ext:ComboBox ID="cmbTipoEnderecoEditar" 
                                                        runat="server" 
                                                        DisplayField="nome" 
                                                        ValueField="idTipoEndereco" 
                                                        TypeAhead="false" 
                                                        LoadingText="Procurando..." 
                                                        Width="350" 
                                                        PageSize="10"
                                                        HideTrigger="false"
                                                        ItemSelector="div.search-item"        
                                                        MinChars="1"
                                                        TriggerAction="All"
                                                        AllowBlank="false">
                                                        <Store>
                                                            <ext:Store ID="Store4" runat="server" AutoLoad="false">
                                                                <Proxy>
                                                                    <ext:HttpProxy Method="POST" Url="/TipoEndereco/Search" />
                                                                </Proxy>
                                                                <Reader>
                                                                    <ext:JsonReader Root="tipoEnderecos" TotalProperty="totalReg">
                                                                        <Fields>
                                                                            <ext:RecordField Name="idTipoEndereco" Type="Int" />
                                                                            <ext:RecordField Name="nome" Type="String" />
                                                                        </Fields>
                                                                    </ext:JsonReader>
                                                                </Reader>
                                                            </ext:Store>
                                                        </Store>
                                                        <Template ID="Template3" runat="server">
                                                           <Html>
					                                           <tpl for=".">
						                                          <div class="search-item">
							                                         <h3>{nome}</h3>
						                                          </div>
					                                           </tpl>
				                                           </Html>
                                                        </Template>
                                                    </ext:ComboBox>
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="logradouro" Header="Logradouro" DataIndex="logradouro" Width="150">
                                                <Editor>
                                                    <ext:TextField ID="txtLogradouroEditar" runat="server" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="numero" Header="Numero" DataIndex="numero" Width="100">
                                                <Editor>
                                                    <ext:NumberField ID="txtNumeroEditar" runat="server" Width="350" AllowBlank="false" AutoFocus="true" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="complemento" Header="Complemento" DataIndex="complemento" Width="100">
                                                <Editor>
                                                    <ext:TextField ID="txtComplementoEditar" runat="server" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="CEP" Header="CEP" DataIndex="CEP" Width="100">
                                                <Editor>
                                                    <ext:TextField ID="txtCepEditar" runat="server" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" EnableKeyEvents="true" Mask="#####-###">
                                                        <Listeners>
                                                            <KeyPress Fn="mascara" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="bairro" Header="Bairro" DataIndex="bairro" Width="100">
                                                <Editor>
                                                    <ext:TextField ID="txtBairroEditar" runat="server" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="cidade" Header="Cidade" DataIndex="cidade" Width="100">
                                                <Editor>
                                                    <ext:TextField ID="txtCidadeEditar" runat="server" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="uf" Header="UF" DataIndex="uf" Width="100">
                                                <Editor>
                                                    <ext:TextField ID="txtUFEditar" runat="server" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                                                </Editor>
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" SingleSelect="true" />
                                    </SelectionModel>
                                    <TopBar>
                                        <ext:Toolbar ID="Toolbar3" runat="server">
                                            <Items>
                                                <ext:Button ID="Button2" runat="server" Text="Novo" Icon="Add">
                                                    <Listeners> 
                                                        <Click Handler="novoEndereco()" />
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button ID="Button3" runat="server" Text="Excluir" Icon="Delete">
                                                    <Listeners> 
                                                        <Click Handler="excluirEndereco()" />
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
                                    <LoadMask ShowMask="true" />
                                    <BottomBar>
                                        <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" />
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
                Title="Nova Pessoa" 
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
                            <ext:TextField ID="txtNome" runat="server" FieldLabel="Nome" InputType="Text" Width="175" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtCpf" runat="server" FieldLabel="CPF" InputType="Text" Width="175" AllowBlank="false" MaxLength="11"></ext:TextField>                            
                            <ext:TextField ID="txtEmail" runat="server" FieldLabel="Email" Width="175" AllowBlank="false" />
                            <ext:TextField ID="txtTelefone" runat="server" FieldLabel="Telefone" Width="175" AllowBlank="false" Mask="(##) ####-####" EnableKeyEvents="true">
                                <Listeners>
                                    <KeyPress Fn="mascara" />
                                </Listeners>
                            </ext:TextField>
                            <ext:TextField ID="txtCelular" runat="server" FieldLabel="Celular" Width="175" AllowBlank="false" Mask="(##) ####-####" EnableKeyEvents="true">
                                <Listeners>
                                    <KeyPress Fn="mascara" />
                                </Listeners>
                            </ext:TextField>
                            <ext:DateField ID="dtNascimento" runat="server" FieldLabel="Data de Nascimento" AnchorHorizontal="100%" EnableKeyEvents="true" AllowBlank="false" /> 
                            <ext:ComboBox ID="txtSexo" runat="server" FieldLabel="Sexo" AllowBlank="false" Width="175">
                                <Items>
                                    <ext:ListItem Text="Masculino" Value="1" />
                                    <ext:ListItem Text="Feminino" Value="0" />
                                </Items>
                            </ext:ComboBox>
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

    <form id="FormNovoEndereco" >
    
        <ext:Window 
                ID="winNovoEndereco" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Novo Endereco" 
                Hidden="true"
                X="250"
                Y="100"
                Layout="FormLayout"
                AutoHeight="true"
                Frame="true"
                Width="500"
                Modal="true"
                >
                <Items>
                    <ext:FormPanel ID="endereco" runat="server">

                        <Items>
                            <ext:ComboBox ID="cmbTipoEndereco" 
                                runat="server" 
                                DisplayField="nome" 
                                ValueField="idTipoEndereco" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Tipo de Endereco"
                                TriggerAction="All"
                                AllowBlank="false">
                                <Store>
                                    <ext:Store ID="Store3" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/TipoEndereco/Search" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="tipoEnderecos" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idTipoEndereco" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template2" runat="server">
                                   <Html>
					                   <tpl for=".">
						                  <div class="search-item">
							                 <h3><span>{idTipoEndereco}</span>{nome}</h3>
							                 Tipo de Endereço
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                            </ext:ComboBox>

                            <ext:ComboBox ID="idPessoa" 
                                runat="server" 
                                DisplayField="nome" 
                                ValueField="idPessoa" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Pessoa"
                                TriggerAction="All"
                                AllowBlank="false"
                                Disabled="true"
                                Hidden ="true">
                                <Store>
                                    <ext:Store ID="Store2" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Pessoa/Search" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="pessoas" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idPessoa" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                    <ext:RecordField Name="cpf" Type="String" />
                                                    <ext:RecordField Name="email" Type="String" />
                                                    <ext:RecordField Name="telefone" Type="String" />
                                                    <ext:RecordField Name="celular" Type="String" />
                                                    <ext:RecordField Name="dataNascimento" Type="Date" />
                                                    <ext:RecordField Name="sexo" Type="Int" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template1" runat="server">
                                   <Html>
					                   <tpl for=".">
						                  <div class="search-item">
							                 <h3><span>{cpf}</span>{nome}</h3>
							                 {email}
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                            </ext:ComboBox>

                            <ext:TextField ID="txtLogradouro" runat="server" FieldLabel="Logradouro" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:NumberField ID="txtNumero" runat="server" FieldLabel="Numero" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtComplemento" runat="server" FieldLabel="Complemento" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtCep" runat="server" FieldLabel="CEP" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" EnableKeyEvents="true" Mask="#####-###" >
                                <Listeners>
                                    <KeyPress  fn="mascara" />
                                </Listeners>
                            </ext:TextField>
                            <ext:TextField ID="txtBairro" runat="server" FieldLabel="Bairro" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtCidade" runat="server" FieldLabel="Cidade" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtUf" runat="server" FieldLabel="UF" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />

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

                    </ext:FormPanel>
                </Items>

        </ext:Window>

    </form>    
                  
</body>
</html>