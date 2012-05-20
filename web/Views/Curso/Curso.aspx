<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cursos / Modulos</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">

    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER

</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>
<script src="../../Scripts/CRUD-Modulo.js" type="text/javascript"></script>

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
                            <h1>Cadastrar Cursos e Modulos</h1>
                            <p>Selecione o curso no primeiro GRID para que o segundo GRID seja preenchido com os Modulos do Curso</p>
                        </Content>
                    </ext:Panel>
                </North>

                <Center MarginsSummary="0 5 0 5">
                    <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Gerenciar Cursos" Icon="User" Layout="Fit">
                        <Items>
                            <ext:GridPanel 
                                ID="GridPanel"
                                runat="server"  
                                StripeRows="true"
                                TrackMouseOver="true"
                                Width="1181" 
                                Height="704"
                                AutoExpandColumn="descricao"
                                >
                                <Store>
                                    <ext:Store 
                                        ID="Store1" 
                                        runat="server">
                                        <Proxy>
                                            <ext:HttpProxy Json="true" Method="GET" Url="/Curso/FindAll" AutoDataBind="true" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="cursos" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idCurso" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                    <ext:RecordField Name="descricao" Type="String" />
                                                    <ext:RecordField Name="valor" Type="Float" />
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
                                            <ext:Column ColumnID="idCurso" Header="Id" DataIndex="idCurso" Hidden="true" />

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
                                            <ext:Column Header="valor" Width="75" DataIndex="valor">
                                                <Renderer Format="UsMoney" />
                                                <Editor>
                                                    <ext:TextField ID="txtValorEditar" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                            <Listeners>
                                                <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreModulo}.reload();}; #{modulo}.getForm().loadRecord(record);" Buffer="250" />
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
                            Height="200" 
                            Icon="TransmitAdd" 
                            Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="GridPanelModulo"
                                    runat="server" 
                                    Title="Gerenciar Modulo" 
                                    StripeRows="true"
                                    TrackMouseOver="true"
                                    Width="1181"
                                    Height="704"
                                    AutoExpandColumn="curso">
                                    <Store>
                                        <ext:Store 
                                            ID="StoreModulo" 
                                            runat="server">
                                            <Proxy>
                                                <ext:HttpProxy Json="true" Method="GET" Url="/Modulo/FindModulos" AutoDataBind="true" />
                                            </Proxy>
                                            <Reader>
                                                <ext:JsonReader Root="modulos" TotalProperty="totalReg">
                                                    <Fields>
                                                        <ext:RecordField Name="idModulo" Type="Int" />
                                                        <ext:RecordField Name="nome" Type="String" />
                                                        <ext:RecordField Name="tempoDuracao" Type="String" />
                                                        <ext:RecordField Name="statusModulo" Type="String" />
                                                        <ext:RecordField Name="Curso.nome" Type="String" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                            <BaseParams>
                                                <ext:Parameter Name="idCUrso" Value="Ext.getCmp('#{GridPanel}') && #{GridPanel}.getSelectionModel().hasSelection() ? #{GridPanel}.getSelectionModel().getSelected().data.idCurso : -1" Mode="Raw" />               
                                            </BaseParams>
                                        </ext:Store>
                                    </Store>
                                    <Listeners>
                                        <KeyDown Fn="startEditingModulo" />
                                        <AfterEdit Fn="afterEditModulo" />
                                    </Listeners>
                                    <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                            <Columns>
                                                <ext:Column ColumnID="idModulo" Header="Id" DataIndex="idFuncionario" Hidden="true" />

                                                <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" >
                                                    <Editor>
                                                        <ext:TextField ID="TextField1" runat="server" />
                                                    </Editor>
                                                </ext:Column>

                                                <ext:Column ColumnID="tempoDuracao" Header="Tempo de Duracao" DataIndex="tempoDuracao" >
                                                    <Editor>
                                                        <ext:TextField ID="txtTempoDuracaoEditar" runat="server" />
                                                    </Editor>
                                                </ext:Column>
                    
                                                <ext:Column ColumnID="statusModulo" Header="Status do Modulo" DataIndex="statusModulo" >
                                                    <Editor>
                                                        <ext:TextField ID="txtStatusModuloEditar" runat="server" />
                                                    </Editor>
                                                </ext:Column>

                                                <ext:Column ColumnID="curso" Header="Curso" Width="75" DataIndex="Curso.nome" >
                                                    <Editor>
                                                        <ext:ComboBox ID="cmbCursoEditar" 
                                                            runat="server" 
                                                            DisplayField="nome" 
                                                            ValueField="idCurso" 
                                                            TypeAhead="false" 
                                                            LoadingText="Procurando..." 
                                                            Width="50" 
                                                            HideTrigger="false"
                                                            ItemSelector="div.search-item"        
                                                            MinChars="1"
                                                            TriggerAction="All">
                                                            <Store>
                                                                <ext:Store ID="Store3" runat="server" AutoLoad="false">
                                                                    <Proxy>
                                                                        <ext:HttpProxy Method="POST" Url="/Curso/Search" />
                                                                    </Proxy>
                                                                    <Reader>
                                                                        <ext:JsonReader Root="cursos" TotalProperty="totalReg">
                                                                            <Fields>
                                                                                <ext:RecordField Name="idCurso" Type="Int" />
                                                                                <ext:RecordField Name="nome" Type="String" />
                                                                            </Fields>
                                                                        </ext:JsonReader>
                                                                    </Reader>
                                                                </ext:Store>
                                                            </Store>
                                                            <Template ID="Template1" runat="server">
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
                                                        <Click Handler="novoModulo()" />
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button ID="Button3" runat="server" Text="Excluir" Icon="Delete">
                                                    <Listeners> 
                                                        <Click Handler="excluirModulo()" />
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
                Title="Novo Curso" 
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
                            <ext:TextField ID="txtDescricao" runat="server" FieldLabel="Descrição" InputType="Text" Width="175" AllowBlank="false" />                            
                            <ext:NumberField ID="txtValor" runat="server" FieldLabel="Valor" Width="175" AllowBlank="false" />
                        </Items>

                        <BottomBar>
                            <ext:Toolbar ID="Toolbar3" runat="server">
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

    <form id="FormNovoModulo">
    
        <ext:Window 
                ID="winNovoModulo" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Novo Módulo" 
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
                    <ext:FormPanel ID="modulo" runat="server">

                        <Items>
                            <ext:TextField ID="txtNomeModulo" runat="server" FieldLabel=" Nome" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtTempoDuracao" runat="server" FieldLabel=" Tempo de Duração" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtStatusModulo" runat="server" FieldLabel=" Status do Módulo" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />

                            <ext:ComboBox ID="idCurso" 
                                runat="server" 
                                DisplayField="nome" 
                                ValueField="idCurso" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel=" Curso"
                                TriggerAction="All"
                                Hidden="true">
                                <Store>
                                    <ext:Store ID="Store4" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Curso/Search" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="cursos" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idCurso" Type="Int" />
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
							                 <h3><span>{idCurso}</span>{nome}</h3>
                                             Seleção de Curso
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                            </ext:ComboBox>
                        </Items>

                        <BottomBar>
                            <ext:Toolbar ID="Toolbar4" runat="server">
                                <Items>
                                    <ext:ToolbarFill />
                                        <ext:Button ID="Button10" Text="Salvar" Icon="Disk" runat="server">
                                            <Listeners>
                                                <Click Handler="salvarModulo(#{modulo}.getForm().getValues())" />
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
