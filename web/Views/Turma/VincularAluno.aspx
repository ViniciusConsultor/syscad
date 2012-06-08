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

        var vincularAluno = function (value) {

            grdTurmas.reload();
            $.post('/Turma/VincularAluno', { idMatriculaTurma: value }, function (valor) {
                if (valor == "Sim") {
                    Ext.Msg.show({
                        title: 'Sucesso',
                        msg: 'Aluno vinculado com sucesso a turma!',
                        buttons: Ext.Msg.OK
                    });

                    grdTurmas.reload();
                    pnlSouth.reload();

                } else {
                    Ext.Msg.show({
                        title: 'Erro',
                        msg: 'Erro ao vincular aluno a turma!',
                        buttons: Ext.Msg.OK
                    });
                }
            });

        }
    </script>
</head>
<script type="text/javascript">

    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER

</script>
<script src="../../Scripts/funcoes.js" type="text/javascript"></script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>
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
                                         
                                    </BaseParams>
                                </ext:Store>
                            </Store>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" SingleSelect="true">
                                    <Listeners>
                                        <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{storePreMatriculas}.reload();};" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                    <Columns>
                                        <ext:RowNumbererColumn />
                                        <ext:Column ColumnID="idTurma" Header="IdTurma" DataIndex="idTurma" Hidden="true" />
                                        <ext:Column ColumnID="descricao" Header="Turma" DataIndex="descricao" Width="150" />
                                        <ext:Column ColumnID="dataInicioFormatada" Header="Data Inicio" DataIndex="dataInicioFormatada" Width="150" />
                                        <ext:Column ColumnID="numeroVagas" Header="Quantidade de Vagas" DataIndex="numeroVagas" Width="150" />                                        <ext:Column ColumnID="vagasOcupadas" Header="Vagas Ocupadas" DataIndex="vagasOcupadas" Width="150" />
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
            <South Collapsible="true" Split="true" MarginsSummary="0 5 5 5">
                <ext:GridPanel 
                    ID="pnlSouth"
                    runat="server" 
                    Title="Gerenciar Matrícula" 
                    Height="200"
                    >
                    <Store>
                        <ext:Store 
                            ID="storePreMatriculas" 
                            runat="server">
                            <Proxy>
                                <ext:HttpProxy Json="true" Method="GET" Url="/Matricula/FindPreMatriculas" AutoDataBind="true" />
                            </Proxy>
                            <Reader>
                                <ext:JsonReader Root="matriculas" TotalProperty="totalReg">
                                    <Fields>
                                        <ext:RecordField Name="idMatriculaTurma" Type="Int" />
                                        <ext:RecordField Name="Matricula.numeroMatricula" Type="String" />
                                        <ext:RecordField Name="Matricula.Aluno.Pessoa.nome" Type="String" />
                                    </Fields>
                                </ext:JsonReader>
                            </Reader>
                            <BaseParams>
                                <ext:Parameter Name="idTurma" Value="Ext.getCmp('#{grdTurmas}') && #{grdTurmas}.getSelectionModel().hasSelection() ? #{grdTurmas}.getSelectionModel().getSelected().data.idTurma : -1" Mode="Raw" />               
                            </BaseParams>
                        </ext:Store>
                    </Store>

                    <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                
                <Columns>
                    <ext:RowNumbererColumn ColumnID="number" />
                    
                    <ext:Column ColumnID="idMatriculaTurma" Header="Id" DataIndex="idMatriculaTurma" Hidden="true" />

                    <ext:Column ColumnID="Matricula.numeroMatricula" Header="Matrícula" DataIndex="Matricula.numeroMatricula"></ext:Column>

                    <ext:Column ColumnID="Matricula.Aluno.Pessoa.nome" Header="Aluno" DataIndex="Matricula.Aluno.Pessoa.nome" width="180px"></ext:Column>

                    <ext:CommandColumn Width="110" Align="Center" Header="Vincular">
                        <Commands>
                            <ext:GridCommand Icon="Accept" CommandName="vincular" Text="Vincular Aluno"  />
                        </Commands>
                    </ext:CommandColumn>

                </Columns>
            </ColumnModel>
                    
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
                    </SelectionModel>

                    <Listeners>
                        <Command Handler="vincularAluno(record.data.idMatriculaTurma)" />
                    </Listeners>

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