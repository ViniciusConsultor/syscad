<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Realizar Pagamento</title>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var startEditing = function (e) {
            if (e.getKey() === e.ENTER) {
                var grid = grdNotaFalta,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

                grid.startEditing(index, 1);
            }
        };

        function salvarAlteracoes(IdAluno, IdTurma, IdModulo, field, newValue) {

            grdNotaFalta.el.mask('Alterando curso', 'x-mask-loading');

            $.post('/Professor/EnviarNotaFalta', { idAluno: IdAluno, idTurma: IdTurma, idModulo: IdModulo, campo: field, valor: newValue }, function () {
                grdNotaFalta.el.unmask();
            });

        };

        var afterEdit = function (e) {
            /*
            Properties of 'e' include:
            e.grid - This grid
            e.record - The record being edited
            e.field - The field name being edited
            e.value - The value being set
            e.originalValue - The original value for the field, before the edit.
            e.row - The grid row index
            e.column - The grid column index
            */
            salvarAlteracoes(e.record.data.IdAluno, e.record.data.IdTurma, e.record.data.IdModulo, e.field, e.value);
            var mensagem = "<b>Campo Editado:&nbsp;</b> " + e.field + "<br /><b>Valor Anterior:</b>&nbsp; " + e.originalValue + "<br /><b>Valor Atual:</b>&nbsp; " + e.value;
            Ext.Msg.notify("Cadastrado com sucesso!", mensagem);

            grdNotaFalta.store.commitChanges();
        };
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
            
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="Panel1" 
                    runat="server" 
                    Region="North"
                    Margins="5 5 5 5"
                    Title="Informe Aluno" 
                    Height="100" 
                    Padding="5"
                    Frame="true" 
                    Icon="User">
                    <Items>
                       <ext:ComboBox ID="txtAluno" 
                                runat="server" 
                                DisplayField="nome" 
                                ValueField="idAluno"
                                FieldLabel="Aluno"
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350"
                                LabelWidth="40"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                PageSize="10"
                                TriggerAction="Query"
                                TriggerIcon="Search">
                                <Store>
                                    <ext:Store ID="StoreAluno" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Pagamento/Search" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="alunos" TotalProperty="totalReg" IDProperty="idAluno">
                                                <Fields>
                                                    <ext:RecordField Name="nome" Type="String" Mapping="nome"/>
                                                    <ext:RecordField Name="cpf" Type="String" Mapping="cpf"/>
                                                    <ext:RecordField Name="email" Type="String" Mapping="email"/>
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template4" runat="server">
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
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="GridPanel1" 
                    runat="server" 
                    Title="Employees"
                    Margins="0 0 5 5"
                    Icon="UserSuit"
                    Region="Center"
                    AutoExpandColumn="LastName" 
                    Frame="true">
                    <Store>
                        <ext:Store 
                            ID="Store1" 
                            runat="server" 
                           
                           
                            AutoLoad="false">
                            <Reader>
                                <ext:JsonReader IDProperty="EmployeeID">
                                    <Fields>
                                        <ext:RecordField Name="LastName" />
                                        <ext:RecordField Name="FirstName" />
                                    </Fields>
                                </ext:JsonReader>
                            </Reader>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="ColumnModel1" runat="server">
                        <Columns>
                            <ext:Column ColumnID="LastName" DataIndex="LastName" Header="Last Name" />
                            <ext:Column DataIndex="FirstName" Header="First Name" Width="150" />
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
   
                        </ext:RowSelectionModel>
                    </SelectionModel>
                    <BottomBar>
                        <ext:PagingToolbar ID="PagingToolbar1" runat="server" />
                    </BottomBar>
                    <LoadMask ShowMask="true" />
                </ext:GridPanel>
                <ext:FormPanel 
                    ID="FormPanel1" 
                    runat="server" 
                    Region="East"
                    Split="true"
                    Margins="0 5 5 5"
                    Frame="true" 
                    Title="Employee Details" 
                    Width="280"
                    Icon="User"
                    DefaultAnchor="100%">
                    <Items>
                        <ext:DisplayField ID="DisplayField1" runat="server" FieldLabel="Employee ID" DataIndex="EmployeeID" />
                        <ext:TextField ID="TextField1" runat="server" FieldLabel="First Name" DataIndex="FirstName" />
                        <ext:TextField ID="TextField2" runat="server" FieldLabel="Last Name" DataIndex="LastName" />
                        <ext:TextField ID="TextField3" runat="server" FieldLabel="Title" DataIndex="Title" />
                        <ext:TextField ID="TextField4" runat="server" FieldLabel="Reports to" DataIndex="ReportsTo" />
                        <ext:DateField ID="DateField1" runat="server" FieldLabel="Hire date" Format="yyyy-MM-dd" DataIndex="HireDate" />
                        <ext:TextField ID="TextField5" runat="server" FieldLabel="Extension" DataIndex="Extension" />
                        <ext:TextField ID="TextField6" runat="server" FieldLabel="Address" DataIndex="Address" />
                        <ext:TextField ID="TextField7" runat="server" FieldLabel="City" DataIndex="City" />
                        <ext:TextField ID="TextField8" runat="server" FieldLabel="Post Code" DataIndex="PostalCode" />
                        <ext:TextField ID="TextField9" runat="server" FieldLabel="Home Phone" DataIndex="HomePhone" />
                        <ext:TextField ID="TextField10" runat="server" FieldLabel="Title Of Courtesy" DataIndex="TitleOfCourtesy" />
                        <ext:DateField ID="DateField2" runat="server" FieldLabel="Birth date" Format="yyyy-MM-dd" DataIndex="BirthDate" />
                        <ext:TextField ID="TextField11" runat="server" FieldLabel="Region" DataIndex="Region" />
                        <ext:TextField ID="TextField12" runat="server" FieldLabel="Country" DataIndex="Country" />
                        <ext:TextArea ID="TextArea1" runat="server" FieldLabel="Note" Height="50" DataIndex="Notes" />
                    </Items>
                </ext:FormPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
</html>
