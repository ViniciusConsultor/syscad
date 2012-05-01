<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title>Modulos</title>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
</head>

<script type="text/javascript">

    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER

</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>

<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" RemoveViewState="true" IDMode="Explicit" />
    
    <ext:GridPanel 
        ID="GridPanel"
        runat="server" 
        Title="Gerenciar Modulo" 
        StripeRows="true"
        TrackMouseOver="true"
        Width="1181"
        Height="704"
        AutoExpandColumn="curso">
        <Store>
            <ext:Store 
                ID="Store1" 
                runat="server">
                <Proxy>
                    <ext:HttpProxy Json="true" Method="GET" Url="/Modulo/FindAll" AutoDataBind="true" />
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
            </ext:Store>
        </Store>
        <Listeners>
            <KeyDown Fn="startEditing" />
            <AfterEdit Fn="afterEdit" />
        </Listeners>
        <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                <Columns>
                    <ext:Column ColumnID="idModulo" Header="Id" DataIndex="idFuncionario" Hidden="true" />

                    <ext:Column ColumnID="nome" Header="Nome" DataIndex="nome" AutoDataBind="true" >
                        <Editor>
                            <ext:TextField ID="txtNomeEditar" runat="server" />
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
                                    <ext:Store ID="Store2" runat="server" AutoLoad="false">
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
            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
        </SelectionModel>

        <TopBar>
            <ext:Toolbar ID="Toolbar2" runat="server">
                <Items>
                    <ext:Button ID="Button4" runat="server" Text="Novo" Icon="Add">
                        <Listeners> 
                            <Click Handler="novo()" />
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

                    <ext:ToolbarFill ID="ToolbarFill2" runat="server" />

                    <ext:Button ID="Button7" runat="server" Text="To XML" Icon="PageCode">
                        <Listeners> 
                            <Click Handler="submitValue(#{GridPanelEdicao}, #{FormatType}, 'xml');" />
                        </Listeners>
                    </ext:Button>
                        
                    <ext:Button ID="Button8" runat="server" Text="To Excel" Icon="PageExcel">
                        <Listeners>
                            <Click Handler="exportData('xls');" />
                        </Listeners>
                    </ext:Button>
                        
                    <ext:Button ID="Button9" runat="server" Text="To CSV" Icon="PageAttach">
                        <Listeners>
                            <Click Handler="exportData('csv');" />
                        </Listeners>
                    </ext:Button>
                </Items>
            </ext:Toolbar>            
        </TopBar>
        <BottomBar>
            <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="10" />
        </BottomBar>
    </ext:GridPanel>


    
    <form id="Novo" runat="server" >
    
        <ext:Window 
                ID="winNovo" 
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
                    <ext:FormPanel ID="formulario" runat="server">

                        <Items>
                            <ext:TextField ID="txtNome" runat="server" FieldLabel=" Nome" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtTempoDuracao" runat="server" FieldLabel=" Tempo de Duração" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />
                            <ext:TextField ID="txtStatusModulo" runat="server" FieldLabel=" Status do Módulo" InputType="Text" Width="350" AllowBlank="false" AutoFocus="true" />

                            <ext:ComboBox ID="cmbCurso" 
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
                                TriggerAction="All">
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
                  
</body>
</html>