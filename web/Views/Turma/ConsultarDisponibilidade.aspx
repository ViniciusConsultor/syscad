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
                        <h1>Consultar Disponibilidade de Turmas</h1>
                        <p>Filtos:</p>
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
        </ext:BorderLayout>
    </Items>
</ext:Viewport>

</body>
</html>