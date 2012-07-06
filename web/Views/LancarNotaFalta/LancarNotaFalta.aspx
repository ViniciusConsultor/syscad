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

        var traduzSituacaoAluno = function (value) {
            var retorno;
            switch (value) {
                case 1:
                    retorno = "Aprovado";
                    break;
                case 2:
                    retorno = "Reprovado";
                    break;
                case 3:
                    retorno = "Recuperação";
                    break;
                default:
                    retorno = "Não Avaliado";
            }

            return retorno;
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
            var IdAluno = e.record.data.IdAluno;
            var IdTurma = e.record.data.IdTurma;
            var IdModulo = e.record.data.IdModulo;
            var IdMatricula = e.record.data.IdMatricula;
            var field = e.field;
            var newValue = e.value;

            if (newValue > 0) {
                grdNotaFalta.el.mask('Alterando curso', 'x-mask-loading');

                var r = $.post('/LancarNotaFalta/EnviarNotaFalta', { idMatricula: IdMatricula, idAluno: IdAluno, idTurma: IdTurma, idModulo: IdModulo, campo: field, valor: newValue }, function (result) {
                    complete:
                    {
                        grdNotaFalta.el.unmask();
                        var mensagem = "<b>Nota Cadastrada com sucesso!</b>";
                        Ext.Msg.notify("Mensagem", mensagem);
                        e.record.data.situacaoAluno = result.notaFalta.situacaoAluno;
                        e.record.data.notaFinal = result.notaFalta.notaFinal;
                        grdNotaFalta.store.commitChanges();
                    }
                });

                if (e.column === 4 && e.record.data.Faltas == "") {
                    return 0;
                }
            } else {
                return 0;
            }

        };

        var beforeEdit = function (e) {
            //Nota Recuperação
            if (e.column === 5 && (e.record.data.Nota1 >= 7 || e.record.data.Nota1 < 2)) {
                return false;
            }

            //Nota 1
            if (e.column === 4 && (e.record.data.Nota1 < 7 || e.record.data.Nota1 >= 2) && (e.record.data.Nota2 != "" || e.record.data.Nota2 == 0) && e.record.data.Nota2 != null) {
                return false;
            }
        };
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
                        <ext:Panel ID="pnlCenter" runat="server" Frame="true" Title="Modulo / Turma" Icon="Cog" Layout="Fit">
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
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel1" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn ColumnID="number" />
                                            <ext:Column ColumnID="idModulo" Header="Id" DataIndex="IdModulo" Width="50" Hidden="true"/>
                                            <ext:Column ColumnID="IdTurma" Header="IdTurma" DataIndex="IdTurma" Width="50" Hidden="true"/>
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
                            Icon="UserTick" 
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
                                                        <ext:RecordField Name="Nota1"  />
                                                        <ext:RecordField Name="Nota2"  />
                                                        <ext:RecordField Name="Faltas" Type="Int" />
                                                        <ext:RecordField Name="situacaoAluno" Type="Int" />
                                                        <ext:RecordField Name="notaFinal"  />
                                                        <ext:RecordField Name="IdMatricula" Type="Int"  />
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
                                        <BeforeEdit Fn="beforeEdit" />
                                    </Listeners>
                                    <ColumnModel ID="ColumnModel2" runat="server" RegisterAllResources="false">
                                        <Columns>
                                            <ext:RowNumbererColumn ColumnID="number" />
                                            <ext:Column ColumnID="IdAluno" Header="Id" DataIndex="IdAluno" Width="50" Hidden="true"/>
                                            <ext:Column ColumnID="Nome" Header="Nome" DataIndex="Nome" />
                                            <ext:Column ColumnID="situacaoAluno" Header="Situação" DataIndex="situacaoAluno" >
                                                <Renderer Fn="traduzSituacaoAluno" />
                                            </ext:Column>
                                            <ext:Column ColumnID="Nota1" Header="Nota" DataIndex="Nota1" Width="150">                                                
                                                <Editor>                     
                                                    <ext:NumberField ID="txtNota1" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="Nota2" Header="Nota de Recuperação" DataIndex="Nota2" Width="150">
                                                <Editor>
                                                    <ext:NumberField ID="TextNota2" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="Faltas" Header="Faltas" DataIndex="Faltas" Width="150">
                                                <Editor>
                                                    <ext:NumberField ID="TextFaltas" runat="server" />
                                                </Editor>
                                            </ext:Column>
                                            <ext:Column ColumnID="notaFinal" Header="Nota Final" DataIndex="notaFinal" />
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
