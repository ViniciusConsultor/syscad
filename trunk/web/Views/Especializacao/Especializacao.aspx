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
<script type="text/javascript"></script>
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
                            <h1>Cadastrar Especializacao dos Professores</h1>
                            <p>Selecione o professor no primeiro GRID para que o segundo GRID seja preenchido com as especializações</p>
                        </Content>
                    </ext:Panel>
                </North>
                <Center MarginsSummary="5 5 5 5">
                    <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Professores" Icon="UserSuitBlack" Layout="Fit">
                        <Items>
                            <ext:GridPanel 
                                ID="GridPanel"
                                runat="server" 
                                StripeRows="true"
                                TrackMouseOver="true"
                                Icon="UserSuitBlack"
                                AutoExpandColumn="Pessoa.nome"
                                >
                                <Store>
                                    <ext:Store 
                                        ID="Store1" 
                                        runat="server">
                                        <Proxy>
                                            <ext:HttpProxy Json="true" Method="GET" Url="/Funcionario/FindAllProfessores" AutoDataBind="true" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="funcionarios" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idFuncionario" Type="Int" />
                                                    <ext:RecordField Name="Pessoa.nome" Type="String" />
                                                    <ext:RecordField Name="Pessoa.cpf" Type="String" />
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
                                            <ext:Column ColumnID="idFuncionario" Header="Id" DataIndex="idCurso" Hidden="true" />
                                            <ext:Column ColumnID="Pessoa.nome" Header="Nome" DataIndex="Pessoa.nome" AutoDataBind="true" Width="300" />
                                            <ext:Column ColumnID="Pessoa.cpf" Header="CPF" DataIndex="Pessoa.cpf" />
                                        </Columns>
                                </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                        <Listeners>
                                            <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreEspecializacao}.reload();}; " Buffer="250" />
                                        </Listeners>
                                    </ext:RowSelectionModel>
                                </SelectionModel>
                                <BottomBar>
                                    <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="10" />
                                </BottomBar>
                            </ext:GridPanel>
                        </Items>
                    </ext:Panel>
                </Center>
                <South MarginsSummary="5 5 5 5">
                    <ext:Panel 
                        ID="pnlSouth"
                        runat="server"
                        Frame="true" 
                        Title="Especializações" 
                        Icon="UserSuitBlack"
                        Visible="true"
                        >

                        <Items>
                            <ext:GridPanel 
                                ID="grdEspecializacoes"
                                runat="server" 
                                StripeRows="true"
                                TrackMouseOver="true"
                                Icon="UserSuitBlack"
                                AutoExpandColumn="Especializacao.nome"
                                >
                                <Store>
                                    <ext:Store 
                                        ID="StoreEspecializacao" 
                                        runat="server">
                                        <Proxy>
                                            <ext:HttpProxy Json="true" Method="GET" Url="/Especializacao/FindAll" AutoDataBind="true" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="especializacoes" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idFuncionarioEspecializacao" Type="Int" />
                                                    <ext:RecordField Name="Especializacao.nome" Type="String" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                        <BaseParams>
                                            <ext:Parameter Name="idFuncionario" Value="Ext.getCmp('#{GridPanel}') && #{GridPanel}.getSelectionModel().hasSelection() ? #{GridPanel}.getSelectionModel().getSelected().data.idFuncionario : -1" Mode="Raw" />               
                                        </BaseParams>
                                    </ext:Store>
                                </Store>
                                <Listeners>
                                    <KeyDown Fn="startEditing" />
                                    <AfterEdit Fn="afterEdit" />
                                </Listeners>
                                <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn />
                                            <ext:Column ColumnID="idEspecializacao" Header="Id" DataIndex="idCurso" Hidden="true" />

                                            <ext:Column ColumnID="Especializacao.nome" Header="Nome" DataIndex="Especializacao.nome" AutoDataBind="true" Width="300" >
                                                <Editor>
                                                    <ext:TextField ID="txtNomeEspecializacaoEditar" runat="server" MaxLength="100" />
                                                </Editor>
                                            </ext:Column>
                                        </Columns>
                                </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" SingleSelect="true">
                                        <Listeners>
                                            <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreEspecializacao}.reload();}; #{especializacao}.getForm().loadRecord(record);" Buffer="250" />
                                        </Listeners>
                                    </ext:RowSelectionModel>
                                </SelectionModel>
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
</body>
</html>
