<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Vincular Aluno/Turma</title>
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var fomataData = function (value, rec) {
            var data = new Date(value);
            rec.dataInicioFormatada = data.format('d/m/Y');
        }
    </script>
</head>

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
                        <h1>Vincular Aluno a Turma</h1>
                        <p>Selecione a Turma no primeiro GRID para que o segundo GRID seja preenchido com os Alunos pré-matriculados</p>
                    </Content>
                </ext:Panel>
            </North>
            <Center MarginsSummary="0 5 0 5">
                <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Turmas" Icon="User" Layout="Fit">
                    <Items>
                        <ext:GridPanel 
                            ID="grdTurmas"
                            runat="server"  
                            AutoExpandColumn="descricao"
                            OnRefreshData="/Turma/FindTurmas"
                            >
                            <Store>
                                <ext:Store 
                                    ID="Store2" 
                                    runat="server">
                                    <Proxy>
                                        <ext:HttpProxy Json="true" Method="GET" Url="/Turma/FindTurmas" AutoDataBind="true" />
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
                                                <ext:RecordField Name="vagasOcupadas" Type="Int" />
                                                <ext:RecordField Name="numeroVagas" Type="Int" />
                                                <ext:RecordField Name="dataInicioFormatada" Type="String" />
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
                                        <ext:Column ColumnID="descricao" Header="Turma" DataIndex="descricao" Width="150" />
                                        <ext:Column ColumnID="dataInicioFormatada" Header="Data Inicio" DataIndex="dataInicioFormatada" Width="150" />
                                        <ext:Column ColumnID="numeroVagas" Header="Vagas Disponíveis" DataIndex="numeroVagas" Width="150" />                                        <ext:Column ColumnID="vagasOcupadas" Header="Vagas Ocupadas" DataIndex="vagasOcupadas" Width="150" />
                                    </Columns>
                            </ColumnModel>                                   
                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" />
                            </BottomBar>
                                <LoadMask ShowMask="true" />
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Center>
            <South>
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

                    </Listeners>
                    <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                            <Columns>
                                <ext:Column ColumnID="idMatricula" Header="Id" DataIndex="idMatricula" Hidden="true" />

                                <ext:Column ColumnID="matricula" Header="Matrícula" DataIndex="numeroMatricula"></ext:Column>

                                <ext:Column ColumnID="aluno" Header="Aluno" DataIndex="Aluno.Pessoa.nome" width="180px"></ext:Column>

                                <ext:Column ColumnID="responsavel" Header="Responsavel" DataIndex="Aluno.Responsavel.nome" width="180px"></ext:Column>
                    
                                <ext:DateColumn DataIndex="dataRegistro" Header="Data de Registro" Format="d/m/Y" />
                     
                                <ext:DateColumn DataIndex="dataCancelamento" Header="Data de Cancelamento" Format="d/m/Y" />

                                <ext:Column ColumnID="tipo" Header="Tipo" DataIndex="tipo">
                                    <Editor>
                                        <ext:TextField ID="TextField4" runat="server" MaxLength="15" />
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
            </South>
        </ext:BorderLayout>
    </Items>
</ext:Viewport>

</body>
</html>