<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>FecharTurma</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var fomataData = function (value, rec) {
            var data = new Date(value);
            rec.dataInicioFormatada = data.format('d/m/Y');
        }

        var fomataDataFim = function (value, rec) {
            var data = new Date(value);
            rec.dataFimFormatada = data.format('d/m/Y');
        }

        var nomePessoaF = function (value, rec) {
            rec.nomePessoa = rec.Pessoa.nome
        }

        var nomeCargoF = function (value, rec) {
            rec.nomeCargo = rec.Cargo.nome
        }

    </script>
</head>
<script type="text/javascript">
    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER
</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>

<body>
<ext:ResourceManager ID="ResourceManager1" runat="server" />
            
        <ext:Viewport ID="Viewport1" runat="server">
            <Items>
                <ext:BorderLayout ID="BorderLayout1" runat="server">
                    <Center MarginsSummary="0 5 0 5">
                        <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Solicitar Abertura de Turma" Icon="ApplicationAdd" Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="GridPanel"
                                    runat="server"  
                                    AutoExpandColumn="descricao"
                                    OnRefreshData="/Turma/FindAllTurmas"
                                    >
                                    <Store>
                                        <ext:Store 
                                            ID="Store2" 
                                            runat="server">
                                            <Proxy>
                                                <ext:HttpProxy Json="true" Method="GET" Url="/Turma/FindAllTurmas" AutoDataBind="true" />
                                            </Proxy>
                                            <Reader>
                                                <ext:JsonReader Root="turmas" TotalProperty="totalReg">
                                                    <Fields>
                                                        <ext:RecordField Name="idTurma" Type="Int" />
                                                        <ext:RecordField Name="idCurso" Type="Int" />
                                                        <ext:RecordField Name="descricao" Type="String" />
                                                        <ext:RecordField Name="dataInicio" Type="Date" >
                                                            <Convert Fn="fomataData" />
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="dataFim" Type="Date" >
                                                            <Convert Fn="fomataDataFim" />
                                                        </ext:RecordField>
                                                         <ext:RecordField Name="numeroVagas" Type="Int" />
                                                        <ext:RecordField Name="dataInicioFormatada" Type="String" />
                                                        <ext:RecordField Name="dataFimFormatada" Type="String" />
                                                        <ext:RecordField Name="Curso.nome" Type="String" />
                                                        <ext:RecordField Name="Professor.nome" Type="String" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>                                            
                                            <BaseParams>
                                                <ext:Parameter Name="codigoCurso" Value="Ext.getCmp('#{grdCurso}') && #{grdCurso}.getSelectionModel().hasSelection() ? #{grdCurso}.getSelectionModel().getSelected().data.idCurso : -1" Mode="Raw" /> 
                                            </BaseParams>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                            <Columns>
                                                <ext:RowNumbererColumn />
                                                <ext:Column ColumnID="idTurma" Header="IdTurma" DataIndex="idTurma" Hidden="true" />
                                                <ext:Column ColumnID="descricao" Header="Turma" DataIndex="descricao" />
                                                <ext:Column ColumnID="curso" Header="Curso" DataIndex="Curso.nome" Width="200" />
                                                <ext:Column ColumnID="professor" Header="Professor" DataIndex="Professor.nome" Width="200" />
                                                <ext:Column ColumnID="dataInicioFormatada" Header="Data Inicio" DataIndex="dataInicioFormatada" Width="100" />
                                                <ext:Column ColumnID="dataFimFormatada" Header="Data Fim" DataIndex="dataFimFormatada" Width="100" />
                                                <ext:Column ColumnID="numeroVagas" Header="Vagas Disponíveis" DataIndex="numeroVagas" Width="100" />
                                            </Columns>
                                    </ColumnModel>

                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    
                                    <TopBar>
                                        <ext:Toolbar ID="Toolbar2" runat="server">
                                            <Items>
                                                <ext:Button ID="Button4" runat="server" Text="Novo" Icon="Add">
                                                    <Listeners> 
                                                        <Click Handler="novo(formulario)" />
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button ID="Button6" runat="server" Text="Excluir" Icon="Delete">
                                                    <Listeners> 
                                                        <Click Handler="excluirRegistro()" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:Toolbar>            
                                    </TopBar>

                                    <BottomBar>
                                        <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" />
                                    </BottomBar>
                                     <LoadMask ShowMask="true" />
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>                        
                    </Center>
                </ext:BorderLayout>
            </Items>
        </ext:Viewport>

        <form id="Novo" runat="server" >
    
        <ext:Window 
                ID="winNovo" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Solicitar Nova Turma" 
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
                            <ext:TextField ID="txtDescricao" runat="server" FieldLabel="Descrição" AnchorHorizontal="100%" InputType="Text" Width="175" AllowBlank="false" MaxLength="100" />
                            <ext:DateField ID="dtInicio" runat="server" FieldLabel="Data Início" AnchorHorizontal="100%" EnableKeyEvents="true" AllowBlank="false" /> 
                            <ext:DateField ID="dtFim" runat="server" FieldLabel="Data Fim" AnchorHorizontal="100%" EnableKeyEvents="true" AllowBlank="false" /> 
                            <ext:NumberField ID="txtNumeroVagas" runat="server" FieldLabel="Numero Vagas" AnchorHorizontal="100%" Width="175" AllowBlank="false" />
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
                                TriggerAction="All"
                                AnchorHorizontal="100%"
                                AllowBlank="false">
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
							                 <h3>{nome}</h3>
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                            </ext:ComboBox>

                            <ext:ComboBox ID="cmbProfessor" 
                                runat="server" 
                                DisplayField="nomePessoa" 
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
                                AnchorHorizontal="100%"
                                AllowBlank="false">
                                <Store>
                                    <ext:Store ID="Store7" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="GET" Url="/Funcionario/FindFuncionarios" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="funcionarios" TotalProperty="total">
                                                <Fields>
                                                    <ext:RecordField Name="idFuncionario" Type="Int" />
                                                    <ext:RecordField Name="Pessoa.nome" Type="String">
                                                        <Convert Fn="nomePessoaF" />
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="Cargo.nome" Type="String">
                                                        <Convert Fn="nomeCargoF" />
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="nomeCargo" Type="String" />
                                                    <ext:RecordField Name="nomePessoa" Type="String" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                        <BaseParams>
                                            <ext:Parameter Name="idCargo" Value="2" Mode="Raw" />
                                        </BaseParams>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template6" runat="server">
                                   <Html>
					                   <tpl for=".">
						                  <div class="search-item">
							                 <h3><span></span>{nomePessoa}</h3>
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
