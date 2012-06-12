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

</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>
<script src="../../Scripts/CRUD-Funcionario.js" type="text/javascript"></script>
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
</script>
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
                            <h1>Cadastrar Cargos e Funcionários</h1>
                            <p>Selecione o cargo no primeiro GRID para que o segundo GRID seja preenchido com os funcionários</p>
                        </Content>
                    </ext:Panel>
                </North>

                <Center MarginsSummary="0 5 0 5">
                    <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Gerenciar Cargos" Icon="UserSuitBlack" Layout="Fit">
                        <Items>
                            <ext:GridPanel 
                                ID="GridPanel"
                                runat="server" 
                                StripeRows="true"
                                TrackMouseOver="true"
                                Icon="UserSuitBlack"
                                AutoExpandColumn="descricao"
                                >
                                <Store>
                                    <ext:Store 
                                        ID="Store1" 
                                        runat="server">
                                        <Proxy>
                                            <ext:HttpProxy Json="true" Method="GET" Url="/Cargo/FindAll" AutoDataBind="true" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="cargos" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idCargo" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                    <ext:RecordField Name="descricao" Type="String" />
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
                                            <ext:Column ColumnID="idCargo" Header="Id" DataIndex="idCurso" Hidden="true" />

                                            <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" >
                                                <Editor>
                                                    <ext:TextField ID="txtNomeEditar" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="descricao" Header="Descrição" DataIndex="descricao">
                                                <Editor>
                                                    <ext:TextField ID="txtDescricaoEditar" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                        </Columns>
                                </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                        <Listeners>
                                            <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreFuncionario}.reload();}; #{funcionario}.getForm().loadRecord(record);" Buffer="250" />
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
                        Title="Gerenciar Funcionários"
                        Icon="UserAlert" 
                        Height="200" 
                        Layout="Fit">
                        <Items>
                            <ext:GridPanel 
                                ID="GridPanelFuncionario"
                                runat="server" 
                                AutoExpandColumn="salario"
                                OnRefreshData="/Funcionario/FindAll">
                                <Store>
                                    <ext:Store 
                                        ID="StoreFuncionario" 
                                        runat="server">
                                        <Proxy>
                                            <ext:HttpProxy Json="true" Method="GET" Url="/Funcionario/FindFuncionarios" AutoDataBind="true" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="funcionarios" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idFuncionario" Type="Int" />
                                                    <ext:RecordField Name="Usuario.login" Type="String" />
                                                    <ext:RecordField Name="Cargo.nome" Type="String" />
                                                    <ext:RecordField Name="Pessoa.nome" Type="String" />
                                                    <ext:RecordField Name="salario" Type="Float" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                        <BaseParams>
                                            <ext:Parameter Name="idCargo" Value="Ext.getCmp('#{GridPanel}') && #{GridPanel}.getSelectionModel().hasSelection() ? #{GridPanel}.getSelectionModel().getSelected().data.idCargo : -1" Mode="Raw" />               
                                        </BaseParams>
                                    </ext:Store>
                                </Store>
                                <Listeners>
                                    <KeyDown Fn="startEditingFuncionario" />
                                    <AfterEdit Fn="afterEditFuncionario" />
                                </Listeners>
                                <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn />
                                            <ext:Column ColumnID="idFuncionario" Header="Id" DataIndex="idFuncionario" Hidden="true" />

                                            <ext:Column ColumnID="usuario" Header="Usuario" DataIndex="Usuario.login" AutoDataBind="true" >
                                                <Editor>
                                                    <ext:TextField ID="txtUsuarioEditar" runat="server" MaxLength="15" />
                                                </Editor>
                                            </ext:Column>

                                            <ext:Column ColumnID="cargo" Header="Cargo" DataIndex="Cargo.nome">
                                                <Editor>
                                                    <ext:ComboBox ID="cmdCargoEditar" 
                                                        runat="server" 
                                                        DisplayField="nome" 
                                                        ValueField="idCargo" 
                                                        TypeAhead="false" 
                                                        LoadingText="Procurando..." 
                                                        Width="50"
                                                        HideTrigger="false"
                                                        ItemSelector="div.search-item"        
                                                        MinChars="1"
                                                        TriggerAction="All"
                                                        >
                                                        <Store>
                                                            <ext:Store ID="Store5" runat="server" AutoLoad="false">
                                                                <Proxy>
                                                                    <ext:HttpProxy Method="POST" Url="/Cargo/Search" />
                                                                </Proxy>
                                                                <Reader>
                                                                    <ext:JsonReader Root="cargos" TotalProperty="total">
                                                                        <Fields>
                                                                            <ext:RecordField Name="idCargo" Type="Int" />
                                                                            <ext:RecordField Name="nome" Type="String" />
                                                                            <ext:RecordField Name="descricao" Type="String" />
                                                                        </Fields>
                                                                    </ext:JsonReader>
                                                                </Reader>
                                                            </ext:Store>
                                                        </Store>
                                                        <Template ID="Template4" runat="server">
                                                            <Html>
					                                            <tpl for=".">
						                                            <div class="search-item">
							                                            <span>{nome}</span>
						                                            </div>
					                                            </tpl>
				                                            </Html>
                                                        </Template>
                                                    </ext:ComboBox>
                                                </Editor>
                                            </ext:Column>

                    
                                            <ext:Column ColumnID="pessoa" Header="Pessoa" DataIndex="Pessoa.nome">
                                                <Editor>
                                                    <ext:ComboBox ID="cmdPessoaEditar" 
                                                        runat="server" 
                                                        DisplayField="nome" 
                                                        ValueField="idPessoa" 
                                                        TypeAhead="false" 
                                                        LoadingText="Procurando..." 
                                                        Width="50" 
                                                        HideTrigger="false"
                                                        ItemSelector="div.search-item"        
                                                        MinChars="1"
                                                        TriggerAction="All">
                                                        <Store>
                                                            <ext:Store ID="Store6" runat="server" AutoLoad="false">
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
                                                        <Template ID="Template5" runat="server">
                                                            <Html>
					                                            <tpl for=".">
						                                            <div class="search-item">
							                                            <span>{nome}</span>
						                                            </div>
					                                            </tpl>
				                                            </Html>
                                                        </Template>
                                                    </ext:ComboBox>
                                                </Editor>
                                            </ext:Column>

                                            <ext:Column ColumnID="salario" Header="Salario" Width="75" DataIndex="salario">
                                                <Renderer Fn="formataDinheiro" />
                                                <Editor>
                                                    <ext:TextField ID="txtSalarioEditar" runat="server" />
                                                </Editor>
                                            </ext:Column>

                                        </Columns>
                                    </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" SingleSelect="true" />
                                </SelectionModel>
                                <TopBar>
                                    <ext:Toolbar ID="Toolbar1" runat="server">
                                        <Items>
                                            <ext:Button ID="Button2" runat="server" Text="Novo" Icon="Add">
                                                <Listeners> 
                                                    <Click Handler="novoFuncionario()" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="Button3" runat="server" Text="Excluir" Icon="Delete">
                                                <Listeners> 
                                                    <Click Handler="excluirFuncionario()" />
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
                </South>
            </ext:BorderLayout>
        </Items>
    </ext:Viewport>

    <form id="Novo" runat="server" >
    
        <ext:Window 
                ID="winNovo" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Novo Cargo" 
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
                    <ext:FormPanel ID="FormPanel1" runat="server">

                        <Items>
                            <ext:TextField ID="txtNome" runat="server" FieldLabel="Nome" InputType="Text" Width="175" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtDescricao" runat="server" FieldLabel="Descrição" InputType="Text" Width="175" AllowBlank="false" />                            
                        </Items>

                        <BottomBar>
                            <ext:Toolbar ID="Toolbar4" runat="server">
                                <Items>
                                    <ext:ToolbarFill />
                                        <ext:Button ID="Button13" Text="Salvar" Icon="Disk" runat="server">
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

    <form id="FormNovoFuncionario">
    
        <ext:Window 
                ID="winNovoFuncionario" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Novo Funcionário" 
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
                    <ext:FormPanel ID="funcionario" runat="server">

                        <Items>
                            <ext:ComboBox ID="cmbPessoa" 
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
                                TriggerAction="All">
                                <Store>
                                    <ext:Store ID="Store3" runat="server" AutoLoad="false">
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

                            <ext:ComboBox ID="idCargo" 
                                runat="server" 
                                DisplayField="nome" 
                                ValueField="idCargo" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Cargo"
                                TriggerAction="All"
                                Hidden="true">
                                <Store>
                                    <ext:Store ID="Store4" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Cargo/Search" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="cargos" TotalProperty="total">
                                                <Fields>
                                                    <ext:RecordField Name="idCargo" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                    <ext:RecordField Name="descricao" Type="String" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template2" runat="server">
                                   <Html>
					                   <tpl for=".">
						                  <div class="search-item">
							                 <h3><span>{idCargo}</span>{nome}</h3>
							                 {descricao}
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                            </ext:ComboBox>

                            <ext:NumberField ID="txtSalario" runat="server" FieldLabel="Salario" Width="350" AllowBlank="false" />

                            <ext:TextField ID="txtLogin" runat="server" FieldLabel="Login" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" MaxLength="15" />

                            <ext:TextField ID="txtSenha" runat="server" FieldLabel="Senha" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" MaxLength="100" />

                            <ext:ComboBox ID="cmbPerfil" 
                                runat="server" 
                                DisplayField="nome" 
                                ValueField="idPerfil" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Perfil de Acesso"
                                TriggerAction="All">
                                <Store>
                                    <ext:Store ID="Store7" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Perfil/Search" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="perfis" TotalProperty="total">
                                                <Fields>
                                                    <ext:RecordField Name="idPerfil" Type="Int" />
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
							                 <h3><span>{idPerfil}</span>{nome}</h3>
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                            </ext:ComboBox>
                        </Items>

                        <BottomBar>
                            <ext:Toolbar ID="Toolbar3" runat="server">
                                <Items>
                                    <ext:ToolbarFill />
                                        <ext:Button ID="btnSalvar" Text="Salvar" Icon="Disk" runat="server">
                                            <Listeners>
                                                <Click Handler="salvarFuncionario(#{funcionario}.getForm().getValues())" />
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