<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Realizar matrícula</title>
    <link href="../../Content/Grid.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>

</head>

<script type="text/javascript">
    //Variaveis GENERICAS
    var controller = '<%= ViewContext.RouteData.Values["Controller"] %>'; // NÃO MECHER

    var trataSituacao = function (value, rec) {
        if (value != null) {
            switch (value) {
                case 1:
                    rec.nomeSituacao = "Aprovado";
                    break;
                case 2:
                    rec.nomeSituacao = "Reprovado";
                    break;
                case 3:
                    rec.nomeSituacao = "Recuperação";
                    break;
            }
        } else {
            rec.nomeSituacao = "Matriculado";
        };
    }

    var trataCurso = function (value, rec) {
        rec.cursoNome = value;        
    }

    var idadePessoa = function (value) {

        $.get('/Matricula/Idade', { idPessoa: cmbPessoa.getValue() }, function (valor) {
            if (valor < 18) {
                Ext.getCmp("cmbResponsavel").show();
                Ext.getCmp("txtGrauParentesco").show();
            } else {
                Ext.getCmp("cmbResponsavel").hide();
                Ext.getCmp("txtGrauParentesco").hide();
            }
        });

    }
</script>
<script src="../../Scripts/CRUD.js" type="text/javascript"></script>

<body>
<ext:ResourceManager ID="ResourceManager1" runat="server" RemoveViewState="true" IDMode="Explicit" />

 <ext:Viewport ID="ViewPort1" runat="server">
    <Items>
        <ext:BorderLayout ID="BorderLayout1" runat="server">
            <Center MarginsSummary="0 5 0 5">    
                <ext:GridPanel 
                    ID="GridPanel"
                    runat="server" 
                    Title="Gerenciar Matrícula" 
                    StripeRows="true"
                    TrackMouseOver="true"
                    Width="850"
                    Height="704"
                    AutoExpandColumn="Matricula.Aluno.nome"
                    onRefreshData="/Matricula/FindAll"
                    >
                    <Store>
                        <ext:Store 
                            ID="Store1" 
                            runat="server">
                            <Proxy>
                                <ext:HttpProxy Json="true" Method="GET" Url="/Matricula/FindAll" AutoDataBind="true" />
                            </Proxy>
                            <Reader>
                                <ext:JsonReader Root="matriculas" TotalProperty="totalReg">
                                    <Fields>
                                        <ext:RecordField Name="idMatricula" Type="Int" />
                                        <ext:RecordField Name="Matricula.numeroMatricula" Type="Int" />
                                        <ext:RecordField Name="Matricula.Aluno.nome" Type="String" />
                                        <ext:RecordField Name="Matricula.dataRegistro" DateFormat="dd/MM/yyyy" />
                                        <ext:RecordField Name="Matricula.Aluno.Responsavel.nome" Type="String" />
                                        <ext:RecordField Name="Turma.descricao" Type="String" />
                                        <ext:RecordField Name="Turma.Curso.nome" Type="String" />
                                        <ext:RecordField Name="situacaoAluno" Type="Int" >
                                            <Convert Fn="trataSituacao" />
                                        </ext:RecordField>
                                        <ext:RecordField Name="notaFinal" Type="Float" />
                                        <ext:RecordField Name="nomeSituacao" Type="String" />
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
                                <ext:Column ColumnID="idMatricula" Hidden="true" DataIndex="idMatricula"></ext:Column>
                                <ext:Column ColumnID="Matricula" Header="Mat." DataIndex="Matricula.numeroMatricula" Width="40"></ext:Column>
                                <ext:Column ColumnID="Aluno" Header="Aluno" DataIndex="Matricula.Aluno.nome" width="180px"></ext:Column>
                                <ext:Column ColumnID="Curso" Header="Curso" DataIndex="Turma.Curso.nome" width="180px"></ext:Column>
                                <ext:Column ColumnID="Turma" Header="Turma" DataIndex="Turma.descricao" width="100px"></ext:Column>
                                <ext:Column ColumnID="responsavel" Header="Responsavel" DataIndex="Matricula.Aluno.Responsavel.nome" width="180px" /> 
                                <ext:Column DataIndex="nomeSituacao" Header="Situação" Width="80px" />
                                <ext:Column DataIndex="notaFinal" Header="Nota Final" Width="80px" />                  
                                <ext:DateColumn DataIndex="Matricula.dataRegistro" Header="Data de Registro" Width="90px" Format="dd/MM/yyyy" />
                            </Columns>
                        </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
                    </SelectionModel>

                    <TopBar>
                        <ext:Toolbar ID="Toolbar2" runat="server">
                            <Items>
                                <ext:Button ID="Button4" runat="server" Text="Novo" Icon="Add">
                                    <Listeners> 
                                        <Click Handler="novo(formulario)" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button ID="Button6" runat="server" Text="Excluir" Icon="Delete">
                                    <Listeners> 
                                        <Click Handler="excluirRegistro()" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>            
                    </TopBar>
                    <BottomBar>
                        <ext:PagingToolbar ID="PagingToolbar2" runat="server" PageSize="10" />
                    </BottomBar>
                    <LoadMask ShowMask="true" />
                </ext:GridPanel>
            </Center>
        </ext:BorderLayout>
    </Items>
</ext:Viewport>

    <form id="Novo" runat="server" >
    
        <ext:Window 
                ID="winNovo" 
                runat="server" 
                Icon="ApplicationAdd" 
                Title="Novo Matrícula" 
                Hidden="true"
                X="250"
                Y="100"
                Layout="FormLayout"
                AutoHeight="true"
                Frame="true"
                Width="500"
                Modal="true"
                >
                <Items>
                    <ext:FormPanel ID="formulario" runat="server">

                        <Items>
                                                        
                            <ext:ComboBox ID="cmbPessoa" 
                                runat="server" 
                                DisplayField="nome" 
                                ValueField="idPessoa" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Aluno"
                                TriggerAction="All"
                                AllowBlank="false">
                                <Store>
                                    <ext:Store ID="Store2" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Pessoa/PessoaAluno" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="pessoas" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idPessoa" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                    <ext:RecordField Name="cpf" Type="String" />
                                                    <ext:RecordField Name="email" Type="String" />
                                                    <ext:RecordField Name="telefone" Type="String" />
                                                    <ext:RecordField Name="celular" Type="String" />
                                                    <ext:RecordField Name="dataNascimento" Type="Date" />
                                                    <ext:RecordField Name="sexo" Type="Int" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template1" runat="server">
                                   <Html>
					                   <tpl for=".">
						                  <div class="search-item">
							                 <h3><span>{cpf}</span>{nome}</h3>
							                 {email}
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                                <Listeners>
                                    <Select Fn="idadePessoa" />
                                </Listeners>
                            </ext:ComboBox>

                            <ext:ComboBox ID="cmbResponsavel" 
                                runat="server" 
                                DisplayField="nome" 
                                ValueField="idPessoa" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Responsavel"
                                TriggerAction="All"
                                Hidden="true"
                                AllowBlank="true">
                                <Store>
                                    <ext:Store ID="Store3" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Pessoa/PessoaResponsavel" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="pessoas" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idPessoa" Type="Int" />
                                                    <ext:RecordField Name="nome" Type="String" />
                                                    <ext:RecordField Name="cpf" Type="String" />
                                                    <ext:RecordField Name="email" Type="String" />
                                                    <ext:RecordField Name="telefone" Type="String" />
                                                    <ext:RecordField Name="celular" Type="String" />
                                                    <ext:RecordField Name="dataNascimento" Type="Date" />
                                                    <ext:RecordField Name="sexo" Type="Int" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template2" runat="server">
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

                            <ext:TextField Hidden="true" ID="txtGrauParentesco" runat="server" FieldLabel="Grau de Parentesco" Width="350" AllowBlank="true" />

                            <ext:ComboBox ID="cmbTurma" 
                                runat="server" 
                                DisplayField="descricao" 
                                ValueField="idTurma" 
                                TypeAhead="false" 
                                LoadingText="Procurando..." 
                                Width="350" 
                                PageSize="10"
                                HideTrigger="false"
                                ItemSelector="div.search-item"        
                                MinChars="1"
                                FieldLabel="Turma"
                                TriggerAction="All"
                                AllowBlank="false">
                                <Store>
                                    <ext:Store ID="Store4" runat="server" AutoLoad="false">
                                        <Proxy>
                                            <ext:HttpProxy Method="POST" Url="/Turma/GetTurmasAtivas" />
                                        </Proxy>
                                        <Reader>
                                            <ext:JsonReader Root="turmas" TotalProperty="totalReg">
                                                <Fields>
                                                    <ext:RecordField Name="idTurma" Type="Int" />
                                                    <ext:RecordField Name="descricao" Type="String" />
                                                    <ext:RecordField Name="Curso.nome" Type="String">
                                                        <Convert Fn="trataCurso" />
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="numeroVagas" Type="String" />
                                                    <ext:RecordField Name="vagasOcupadas" Type="String" />
                                                    <ext:RecordField Name="dataInicio" Type="Date" />
                                                    <ext:RecordField Name="dataFim" Type="Date" />
                                                    <ext:RecordField Name="cursoNome" Type="String" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <Template ID="Template3" runat="server">
                                   <Html>
					                   <tpl for=".">
						                  <div class="search-item">
							                 <h3><span>{cursoNome}</span>{descricao}</h3>
                                             Vagas Ocupadas: {vagasOcupadas}/{numeroVagas} 							                                                            
						                  </div>
					                   </tpl>
				                   </Html>
                                </Template>
                            </ext:ComboBox>

                        </Items>

                        <BottomBar>
                            <ext:Toolbar ID="Toolbar1" runat="server">
                                <Items>
                                    <ext:ToolbarFill />
                                        <ext:Button ID="btnSalvar" Text="Salvar" Icon="Disk" runat="server">
                                            <Listeners>
                                                <Click Handler="salvar()" />
                                            </Listeners>
                                        </ext:Button>
                                </Items>
                            </ext:Toolbar>  
                        </BottomBar>
                    </ext:FormPanel>
                </Items>
        </ext:Window>
    </form>
</body>
</html>
