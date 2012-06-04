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
                    <Center MarginsSummary="0 5 0 5">
                        <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Solicitar Abertura de Turma" Icon="ApplicationAdd" Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="grdTurmas"
                                    runat="server"  
                                    AutoExpandColumn="descricao"
                                    OnRefreshData="/Turma/FindAll"
                                    >
                                    <Store>
                                        <ext:Store 
                                            ID="Store2" 
                                            runat="server">
                                            <Proxy>
                                                <ext:HttpProxy Json="true" Method="GET" Url="/Turma/FindAll" AutoDataBind="true" />
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
                                                <ext:Column ColumnID="numeroVagas" Header="Vagas Disponíveis" DataIndex="numeroVagas" Width="150" />
                                                <ext:Column ColumnID="vagasOcupadas" Header="Vagas Ocupadas" DataIndex="vagasOcupadas" Width="150" />
                                                <ext:CommandColumn Width="110" Align="Center">
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
                    </Center>
                </ext:BorderLayout>
            </Items>
        </ext:Viewport>
</body>
</html>
