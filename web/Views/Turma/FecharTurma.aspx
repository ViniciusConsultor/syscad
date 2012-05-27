<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>FecharTurma</title>
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
                                        <KeyDown Fn="" />
                                        <AfterEdit Fn="" />
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

                    <South>
                        <ext:Panel ID="Panel1" runat="server" Frame="true" Title="Turma" Icon="User" Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="GridPanel1"
                                    runat="server"  
                                    StripeRows="true"
                                    TrackMouseOver="true"
                                    Width="1181" 
                                    Height="704"
                                    AutoExpandColumn="idTurma"
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
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <Listeners>
                                        <KeyDown Fn="" />
                                        <AfterEdit Fn="" />
                                    </Listeners>
                                    <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                            <Columns>
                                                <ext:Column ColumnID="idTurma" Header="Id" DataIndex="idTurma" Hidden="true" />
                                            </Columns>
                                        </ColumnModel>
                                        <SelectionModel>
                                            <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" SingleSelect="true">
                                                <Listeners>
                                                    <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreModulo}.reload();}; #{modulo}.getForm().loadRecord(record);" Buffer="250" />
                                                </Listeners>
                                            </ext:RowSelectionModel>
                                        </SelectionModel>

                                    <TopBar>
                                        <ext:Toolbar ID="Toolbar1" runat="server">
                                            <Items>
                                                <ext:Button ID="Button2" runat="server" Text="Novo" Icon="Add">
                                                    <Listeners> 
                                                        <Click Handler="winNovo.show()" />
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button ID="Button3" runat="server" Text="Excluir" Icon="Delete">
                                                    <Listeners> 
                                                        <Click Handler="excluirRegistro()" />
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

                    <East Collapsible="true">
                        <ext:FormPanel 
                            ID="FormPanel1" 
                            runat="server" 
                            Margins="0 5 5 5"
                            Frame="true" 
                            Title="Fechar Turma" 
                            Width="280"
                            Icon="MoneyDollar"
                            DefaultAnchor="100%"
                            Collapsed="true"
                            >
                            <Items>
                                <ext:DisplayField ID="idCobranca" DataIndex="idCobranca" runat="server" />                                                     
                            </Items>
                        </ext:FormPanel>
                    </East>

                </ext:BorderLayout>
            </Items>
        </ext:Viewport>
</body>
</html>
