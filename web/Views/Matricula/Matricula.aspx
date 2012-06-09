<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Realizar matrícula</title>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>

</head>

<script type="text/javascript">
    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER

    var trataCurso = function (value, rec) {
        rec.cursoNome = rec.Curso.nome;
    }
</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>

<body>
<ext:ResourceManager ID="ResourceManager1" runat="server" RemoveViewState="true" IDMode="Explicit" />
    
    <ext:GridPanel 
        ID="GridPanel"
        runat="server" 
        Title="Gerenciar Matrícula" 
        StripeRows="true"
        TrackMouseOver="true"
        Width="850"
        Height="704"
        >
        <Store>
            <ext:Store 
                ID="Store1" 
                runat="server">
                <Proxy>
                    <ext:HttpProxy Json="true" Method="GET" Url="/Matricula/FindAll" AutoDataBind="true" />
                </Proxy>
                <Reader>
                    <ext:JsonReader Root="matriculas" TotalProperty="totalReg">
                        <Fields>
                            <ext:RecordField Name="idMatricula" Type="Int" />
                            <ext:RecordField Name="numeroMatricula" Type="Int" />
                            <ext:RecordField Name="Aluno.nome" Type="String" />
                            <ext:RecordField Name="dataRegistro" Type="Date" />
                            <ext:RecordField Name="dataCancelamento" Type="Date" />
                            <ext:RecordField Name="tipo" Type="String" />
                            <ext:RecordField Name="Aluno.Responsavel.nome" Type="String" />
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
                    <ext:Column ColumnID="idmatricula" Hidden="true" DataIndex="idMatricula"></ext:Column>

                    <ext:Column ColumnID="matricula" Header="Matrícula" DataIndex="numeroMatricula"></ext:Column>

                    <ext:Column ColumnID="aluno" Header="Aluno" DataIndex="Aluno.nome" width="180px"></ext:Column>

                    <ext:Column ColumnID="responsavel" Header="Responsavel" DataIndex="Aluno.Responsavel.nome" width="180px"></ext:Column>
                    
                    <ext:DateColumn DataIndex="dataRegistro" Header="Data de Registro" Width="100px" Format="dd/MM/yyyy"></ext:DateColumn>

                    <ext:DateColumn DataIndex="dataCancelamento" Header="Data de Cancelamento" Width="120px" Format="dd/MM/yyyy"></ext:DateColumn>

                    <ext:Column ColumnID="tipo" Header="Tipo" DataIndex="tipo"></ext:Column>

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
                Title="Novo Matrícula" 
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
                    <ext:FormPanel ID="matricula" runat="server">

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

                            <ext:ComboBox ID="cmbResponsavel" 
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
                                FieldLabel="Responsavel"
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
                                <Template ID="Template2" runat="server">
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

                            <ext:TextField ID="txtGrauParentesco" runat="server" FieldLabel="Grau de Parentesco" Width="350" AllowBlank="false" />
                      
                            <ext:DateField ID="txtDataRegistro" runat="server" FieldLabel="Data de Registro" Width="350" EnableKeyEvents="true" AllowBlank="false" /> 

                            <ext:DateField ID="txtDataCancelamento" runat="server" FieldLabel="Data de Cancelamento" Width="350" EnableKeyEvents="true" /> 

                            <ext:ComboBox ID="cmbTurma" 
                                runat="server" 
                                DisplayField="turma" 
                                ValueField="idTurma" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Turma"
                                TriggerAction="All">
                                <Store>
                                    <ext:Store ID="Store4" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Turma/Search" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="turmas" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idTurma" Type="Int" />
                                                    <ext:RecordField Name="descricao" Type="String" />
                                                    <ext:RecordField Name="Curso.nome" Type="String">
                                                        <Convert Fn="trataCurso" />
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="numeroVagas" Type="String" />
                                                    <ext:RecordField Name="vagasOcupadas" Type="String" />
                                                    <ext:RecordField Name="dataInicio" Type="Date" />
                                                    <ext:RecordField Name="dataFim" Type="Date" />
                                                    <ext:RecordField Name="cursoNome" Type="String" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template3" runat="server">
                                   <Html>
					                   <tpl for=".">
						                  <div class="search-item">
							                 <h3><span>{cursoNome}</span>{descricao}</h3>
							                 Vagas: {vagasOcupadas}/{numeroVagas} - Data início: {dataInicio} - Data fim: {dataFim}                                             
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
