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

        var fecharTurma = function (command, rec) {
            $.post("/Turma/FechamentoTurma", { codigoTurma: rec.data.idTurma }, function () {
                success:
                {
                    Ext.Msg.show({
                        title: 'Sucesso',
                        msg: 'Turma fechada com sucesso!',
                        buttons: Ext.Msg.OK,
                        icon: Ext.Msg.INFO,
                        fn: function () {
                            Ext.getCmp("grdTurmas").reload();
                        }
                    });
                    
                }
            });
        }
    </script>
</head>
<body>
<ext:ResourceManager ID="ResourceManager1" runat="server" />
            
        <ext:Viewport ID="Viewport1" runat="server">
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
                                <h1>Fechar Turma</h1>
                                <p>Selecione o Curso para fechar a turma!</p>
                            </Content>
                        </ext:Panel>
                    </North>
                    <Center MarginsSummary="0 5 0 5">
                        <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Curso" Icon="ApplicationAdd" Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="grdCurso"
                                    runat="server"  
                                    AutoExpandColumn="nome"
                                    OnRefreshData="/Curso/FindAll"
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
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn />
                                            <ext:Column ColumnID="idCurso" Header="IdCurso" DataIndex="idCurso" Hidden="true" />
                                            <ext:Column ColumnID="nome" Header="Curso" DataIndex="nome"  />
                                        </Columns>
                                    </ColumnModel>
                                        <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                            <Listeners>
                                                <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{grdTurmas}.reload();}" Buffer="250" />
                                            </Listeners>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    <BottomBar>
                                        <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="10" />
                                    </BottomBar>
                                    <LoadMask ShowMask="true" />
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>                        
                    </Center>
                    <South Collapsible="true" Split="true">
                      <ext:Panel ID="pnlSouth" runat="server" Frame="true" Title="Turmas" Icon="ApplicationDouble" Layout="Fit" Height="250" MaxHeight="250">
                            <Items>
                                <ext:GridPanel 
                                    ID="grdTurmas"
                                    runat="server"  
                                    AutoExpandColumn="descricao"
                                    OnRefreshData="/Turma/FindAllAbertas"
                                    >
                                    <Store>
                                        <ext:Store 
                                            ID="Store2" 
                                            runat="server">
                                            <Proxy>
                                                <ext:HttpProxy Json="true" Method="GET" Url="/Turma/FindAllAbertas" AutoDataBind="true" />
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
                                                        <ext:RecordField Name="vagasOcupadas" Type="Int" />
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
                                                <ext:Column ColumnID="vagasOcupadas" Header="Vagas Ocupadas" DataIndex="vagasOcupadas" Width="150" />
                                                <ext:CommandColumn Width="110" Align="Center" Header="Ação">
                                                    <Commands>
                                                        <ext:GridCommand Icon="Delete" CommandName="fecharTurma" Text="Fechar Turma"  />
                                                    </Commands>
                                                </ext:CommandColumn>
                                            </Columns>
                                    </ColumnModel>
                                    <Listeners>
                                        <Command Handler="fecharTurma(command, record)" />
                                    </Listeners>                                    
                                    <BottomBar>
                                        <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="10" />
                                    </BottomBar>
                                     <LoadMask ShowMask="true" />
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>                                            
                    </South>
                </ext:BorderLayout>
            </Items>
        </ext:Viewport>
</body>
</html>
