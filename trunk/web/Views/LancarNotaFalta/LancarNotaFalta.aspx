<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Professor</title>
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

            $.post('/LancarNotaFalta/EnviarNotaFalta', { idAluno: IdAluno, idTurma: IdTurma, idModulo: IdModulo, campo: field, valor: newValue }, function () {
                success: 
                {
                    grdNotaFalta.el.unmask();
                }
            });

        };

        function teste(data) {
           // alert(data.(Curso.Turmas[0].idTurma));
        }

        var traduzSituacaoAluno = function (value) {
            $.post("LancarNotaFalta/traduzSituacaoAluno", { idStatus: value }, function (result) {
                success:
                {
                    return result.descricao
                }
            });
        }

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
            var mensagem = "<b>Nota Cadastrada com sucesso!</b>";
            Ext.Msg.notify("Mensagem", mensagem);

            grdNotaFalta.store.commitChanges();
        };

//        var RenderGrid = function (e) {
//            if (parseFloat(e.record.data.Nota1) > 0) {
//                Ext.getCmp("Nota2").Editable = true;
//            }
//        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
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
                                <h1>Lançar notas e faltas</h1>
                                <p>Selecione o modulo de cada turma no primeiro Grid para carregar os alunos no segundo Grid, e assim lançar as notas e faltas dos alunos</p>
                            </Content>
                        </ext:Panel>
                    </North>
                    <Center MarginsSummary="0 5 0 5">
                        <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Modulo / Turma" Icon="Email" Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="grdTurmas"
                                    runat="server" 
                                    AutoExpandColumn="nome"
                                    Height="300"
                                    OnRefreshData="/LancarNotaFalta/FindTurmaByProfessor"
                                    >
                                    <Store>
                                        <ext:Store 
                                            ID="StoreTurma" 
                                            runat="server"
                                            AutoLoad="true"
                                            >
                                            <Proxy>
                                                <ext:HttpProxy Json="true" Method="GET" Url="/LancarNotaFalta/FindTurmaByProfessor" />
                                            </Proxy>
                                            <Reader>
                                                <ext:JsonReader Root="modulos" TotalProperty="totalReg">
                                                    <Fields>
                                                        <ext:RecordField Name="IdModulo" Type="Int" />
                                                        <ext:RecordField Name="IdTurma" Type="Int" />
                                                        <ext:RecordField Name="nomeModulo" Type="String" />
                                                        <ext:RecordField Name="nomeTurma" Type="String" />
                                                        <ext:RecordField Name="nomeCurso" Type="String" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                            <BaseParams>
                                                <ext:Parameter Name="codigoTurma" Value="1" Mode="Value" />               
                                            </BaseParams>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:Column ColumnID="idModulo" Header="Id" DataIndex="IdModulo" Width="50"/>
                                            <ext:Column ColumnID="nome" Header="Modulo" DataIndex="nomeModulo" />
                                            <ext:Column ColumnID="nomeTurma" Header="Turma" DataIndex="nomeTurma" Width="200" />
                                            <ext:Column ColumnID="nomeCurso" Header="Curso" DataIndex="nomeCurso" Width="200"/>
                                            
                                        </Columns>
                                    </ColumnModel>
                                     <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                            <Listeners>
                                                <RowSelect Handler="if (#{pnlSouth}.isVisible()) {#{StoreALuno}.reload();}" Buffer="250" />
                                            </Listeners>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    <LoadMask ShowMask="true" />
                                    <BottomBar>
                                        <ext:PagingToolbar ID="PagingToolbar3" runat="server" PageSize="10" />
                                    </BottomBar>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Center>
                    <South Collapsible="true" Split="true" MarginsSummary="0 5 5 5">
                        <ext:Panel 
                            ID="pnlSouth" 
                            runat="server" 
                            Title="Alunos" 
                            Height="200" 
                            Icon="Clipboard" 
                            Layout="Fit">
                            <Items>
                                <ext:GridPanel 
                                    ID="grdNotaFalta"
                                    runat="server" 
                                    AutoExpandColumn="Nome"
                                    OnRefreshData="/LancarNotaFalta/FindAlunos">
                                    <Store>
                                        <ext:Store 
                                            ID="StoreALuno" 
                                            runat="server"
                                            AutoLoad="false">
                                            <Proxy>
                                                <ext:HttpProxy Json="true" Method="GET" Url="/LancarNotaFalta/FindAlunos" />
                                            </Proxy>
                                            <Reader>
                                                <ext:JsonReader Root="alunos" TotalProperty="totalReg">
                                                    <Fields>
                                                        <ext:RecordField Name="IdAluno" Type="Int" />
                                                        <ext:RecordField Name="IdTurma" Type="Int" />
                                                        <ext:RecordField Name="IdModulo" Type="Int" />
                                                        <ext:RecordField Name="Nome" Type="String" />
                                                         <ext:RecordField Name="Nota1" Type="Float" />
                                                        <ext:RecordField Name="Nota2" Type="Float" />
                                                        <ext:RecordField Name="Faltas" Type="Int" />
                                                        <ext:RecordField Name="situacaoAluno" Type="Int" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                            <BaseParams>
                                                <ext:Parameter Name="codigoTurma" Value="Ext.getCmp('#{grdTurmas}') && #{grdTurmas}.getSelectionModel().hasSelection() ? #{grdTurmas}.getSelectionModel().getSelected().data.IdTurma : -1" Mode="Raw" /> 
                                                <ext:Parameter Name="codigoModulo" Value="Ext.getCmp('#{grdTurmas}') && #{grdTurmas}.getSelectionModel().hasSelection() ? #{grdTurmas}.getSelectionModel().getSelected().data.IdModulo : -1" Mode="Raw" />              
                                            </BaseParams>
                                        </ext:Store>
                                    </Store>
                                    <Listeners>
                                        <KeyDown Fn="startEditing" />
                                        <AfterEdit Fn="afterEdit" />
                                    </Listeners>
                                    <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:Column ColumnID="IdAluno" Header="Id" DataIndex="IdAluno" Width="50"/>
                                            <ext:Column ColumnID="Nome" Header="Nome" DataIndex="Nome" />
                                            <ext:Column ColumnID="situacaoAluno" Header="Situação" >
                                                <Renderer Fn="traduzSituacaoAluno" />
                                            </ext:Column>
                                            <ext:Column ColumnID="Nota1" Header="Nota" DataIndex="Nota1" Width="150">
                                                <Editor>
                                                    <ext:NumberField ID="txtNota1" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="Nota2" Header="Nota de Recuperação" DataIndex="Nota2" Width="150" Editable="false">
                                                <Editor>
                                                    <ext:NumberField ID="TextNota2" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="Faltas" Header="Faltas" DataIndex="Faltas" Width="150">
                                                <Editor>
                                                    <ext:NumberField ID="TextFaltas" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" SingleSelect="true">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    <LoadMask ShowMask="true" />
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
    </form>
</body>
</html>
