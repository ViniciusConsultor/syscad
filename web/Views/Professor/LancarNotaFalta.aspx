<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Professor</title>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:GridPanel 
            ID="GridPanelNormal"
            runat="server" 
            Title="Lançar Nota / Falta" 
            Width="800" 
            Height="500"
            OnRefreshData="/Professor/FindAlunos"
            >
            <Store>
                <ext:Store 
                    ID="StoreGrid" 
                    runat="server"
                    AutoLoad="false"
                    >
                    <Proxy>
                        <ext:HttpProxy Json="true" Method="GET" Url="/Professor/FindAlunos" />
                    </Proxy>
                    <Reader>
                        <ext:JsonReader Root="alunos" TotalProperty="totalReg">
                            <Fields>
                                <ext:RecordField Name="IdAluno" Type="Int" />
                                <ext:RecordField Name="Nome" Type="String" />
                                 <ext:RecordField Name="Turma" Type="String" />
                                <ext:RecordField Name="Status" Type="Int" />
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                    <BaseParams>
                        <ext:Parameter Name="codigoTurma" Value="1" Mode="Value" />               
                    </BaseParams>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                <Columns>
                    <ext:Column ColumnID="IdAluno" Header="Id" DataIndex="IdAluno" Width="50"/>
                    <ext:Column ColumnID="Nome" Header="Nome" DataIndex="Nome" Width="150"/>
                    <ext:Column ColumnID="Turma" Header="Turma" DataIndex="Turma" Width="150"/>
                    <ext:Column ColumnID="Status" Header="Status" DataIndex="Status" Width="150"/>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" >
                </ext:RowSelectionModel>
            </SelectionModel>
            <LoadMask ShowMask="true" />
            <TopBar>
                <ext:Toolbar ID="Toolbar2" runat="server">
                    <Items>
                        <ext:Label ID="lblTurma" Text="Turma: " runat="server" />
                        <ext:ComboBox
                            ID="cbTurma"
                            Mode="Remote"
                            DisplayField="descricao"
                            ValueField="idTurma"
                            runat="server"
                            TypeAhead="true"
                            ForceSelection="false"
                            TriggerAction="All"
                            EmptyText="<-- Selecione -->"
                            AutoRender="true">
                            <Listeners>
                                <Select Handler="#{cbModulo}.clearValue();#{StoreModulo}.reload();" />
                            </Listeners>
                            <Store>
                                <ext:Store ID="StoreTurma" runat="server">
                                    <Proxy>
                                        <ext:HttpProxy Url="/Professor/FindTurmas" Json="true" Method="GET" AutoDataBind="true"/>
                                    </Proxy>
                                    <Reader>
                                        <ext:JsonReader Root="turmas">
                                            <Fields>
                                                <ext:RecordField Name="idTurma" Type="Int" Mapping="idTurma" />
                                                <ext:RecordField Name="descricao" Type="String" Mapping="descricao"/>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>   
                        </ext:ComboBox>
                        <ext:Label ID="lblModulo" Text="Modulo: " runat="server" />
                        <ext:ComboBox
                            ID="cbModulo"
                            Mode="Remote"
                            DisplayField="nome"
                            ValueField="idModulo"
                            runat="server"
                            TypeAhead="true"
                            ForceSelection="false"
                            TriggerAction="All"
                            EmptyText="<-- Selecione -->"
                            AutoRender="false" 
                            >
                            <Listeners>
                                <Select Handler="#{StoreGrid}.reload();" />
                            </Listeners>
                            <Store>
                                <ext:Store ID="StoreModulo" runat="server" AutoLoad="false">
                                    <Proxy>
                                        <ext:HttpProxy Url="/Professor/FindModulosByTurma" Json="true" Method="GET" />
                                    </Proxy>
                                    <Reader>
                                        <ext:JsonReader Root="modulos">
                                            <Fields>
                                                <ext:RecordField Name="idModulo" Type="Int" Mapping="idModulo" />
                                                <ext:RecordField Name="nome" Type="String" Mapping="nome"/>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                    <Listeners>
                                        <Load Handler="#{cbModulo}.setValue(#{cbModulo}.store.getAt(0).get('idModulo'));" />
                                    </Listeners>
                                    <BaseParams>
                                        <ext:Parameter Name="codigoTurma" Value="#{cbTurma}.getValue()" Mode="Raw" />               
                                    </BaseParams>
                                </ext:Store>
                            </Store>   
                        </ext:ComboBox>
                        <ext:ToolbarFill ID="ToolbarFill2" runat="server" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <BottomBar>
                <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="10" />
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>
