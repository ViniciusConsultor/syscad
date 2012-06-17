SET IDENTITY_INSERT [curso] ON
INSERT [curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (16, N'WEBDEVELOPER C#.NET', N'Web Developer', CAST(3120 AS Decimal(18, 0)), 4)
INSERT [curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (17, N'JAVA', N'java', CAST(3000 AS Decimal(18, 0)), 4)
SET IDENTITY_INSERT [curso] OFF
SET IDENTITY_INSERT [cargo] ON
INSERT [cargo] ([idCargo], [nome], [descricao]) VALUES (2, N'Professor', N'A pessoa que dá aula')
INSERT [cargo] ([idCargo], [nome], [descricao]) VALUES (3, N'Coordenador', N'A pessoa que coordena')
INSERT [cargo] ([idCargo], [nome], [descricao]) VALUES (4, N'Diretor', N'O que manda')
INSERT [cargo] ([idCargo], [nome], [descricao]) VALUES (5, N'Recepcionista', N'Pessoa que fica na recepção')
SET IDENTITY_INSERT [cargo] OFF
SET IDENTITY_INSERT [menu] ON
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (2, N'Cargo/Funcionário', N'/Cargo/Cargo', N'Cadastro', N'UserSuitBlack', N'idAbaCargo', N'1,2')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (3, N'Curso', N'/Curso/Curso', N'Cadastro', N'ApplicationFormAdd', N'idAbaCurso', N'1,2')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (4, N'Modulo', N'/Modulo/Modulo', N'Cadastro', N'ApplicationFormAdd', N'idAbaModulo', N'1,2')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (5, N'Pessoa/Endereço', N'/Pessoa/Pessoa', N'Cadastro', N'User', N'idAbaPessoa', N'1,2')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (6, N'Taxas', N'/Taxa/Taxa', N'Cadastro', N'MoneyAdd', N'idAbaTaxas', N'1,4')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (7, N'Solicitar Abertura de Turma', N'/Turma/AbrirTurma', N'Coordenação', N'ApplicationAdd', N'idAbaAbTurma', N'1,2')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (8, N'Processar cobrança de mensalidade', N'/Pagamento/ProcessarCobranca', N'Coordenação', N'MoneyDollar', N'idAbaProcCob', N'1,2')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (9, N'Fechar de Turma', N'/Turma/FecharTurma', N'Coordenação', N'ApplicationDelete', N'idAbaFecharTurma', N'1,2')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (10, N'Autorizar abertura de turma', N'/Turma/AutorizarTurma', N'Diretoria', N'Accept', N'idAbaAbrirTurma', N'1,4')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (11, N'Relatorio de Ex-Alunos', N'/Relatorio/ExAlunos', N'Diretoria', N'Report', N'idAbaRelatorio', N'1,4')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (12, N'Relatorio de Inadimplentes', N'/Relatorio/Inadimplentes', N'Diretoria', N'Report', N'idAbaRelatorio1', N'1,4')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (13, N'Relatorio de cursos mais cursados', N'/Relatorio/CursosMaisCursados', N'Diretoria', N'Report', N'idAbaRelatorio2', N'1,4')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (14, N'Relatorio de especialização dos professores', N'/Relatorio/Especializacao', N'Diretoria', N'Report', N'idAbaRelatorio3', N'1,4')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (15, N'Lançar Nota/Falta', N'/LancarNotaFalta/lancarNotaFalta', N'Professor', N'BookAddresses', N'idAbaLancaNota', N'1,3')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (16, N'Consultar disponibilidade horário/turma', N'/Turma/ConsultarDisponibilidade', N'Recepção', N'Clock', N'idAbaHorario', N'1,5')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (17, N'Realizar Matrícula', N'/Matricula/Matricula', N'Recepção', N'BookOpen', N'idAbaMatricula', N'1,5')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (18, N'Realizar Pagamento', N'/Pagamento/RealizarPagamento', N'Recepção', N'Money', N'idAbaPagamento', N'1,5')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (19, N'Realizar Pré-Matrícula', N'/Matricula/Prematricula', N'Recepção', N'BookOpenMark', N'idAbaPreMatricula', N'1,5')
INSERT [menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (20, N'Vincular Aluno/Turma', N'/Turma/VincularAluno', N'Recepção', N'ApplicationAdd', N'idAbaVincularAlunoTurma', N'1,5')
SET IDENTITY_INSERT [menu] OFF
SET IDENTITY_INSERT [funcionarioEspecializacao] ON
INSERT [funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (1, 1, 1)
INSERT [funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [funcionarioEspecializacao] OFF
SET IDENTITY_INSERT [pessoa] ON
INSERT [pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (1, N'Leonardo Oliveira', N'05635686745', N'leolirarj@yahoo.com.br', N'88411859', N'', CAST(0x0000798700000000 AS DateTime), 1)
INSERT [pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (2, N'Jessica Muniz', N'05635686745', N'leolira@yahhd', N'3213', N'1231', CAST(0x0000A04B00000000 AS DateTime), 0)
INSERT [pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (3, N'Fatima Oliveira', N'12312', N'asd', N'1312', N'12312', CAST(0x00008D8000000000 AS DateTime), 1)
INSERT [pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (4, N'Adilson', N'05635686745', N'sfda', N'(11) 1111-1111', N'(23) 2323-2323', CAST(0x0000A0A500000000 AS DateTime), 1)
INSERT [pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (5, N'Fernando', N'056.356.867-45', N'sfad', N'(11) 1111-1111', N'(11) 1111-1111', CAST(0x0000A06700000000 AS DateTime), 1)
INSERT [pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (6, N'Marcio Canedo', N'05635686745', N'loeldsf', N'(11) 1111-1111', N'(11) 1111-1111', CAST(0x0000A06F00000000 AS DateTime), 1)
INSERT [pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (8, N'Aluno 1', N'05635686745', N'aasd', N'(12) 3412-3412', N'(12) 3412-3412', CAST(0x0000798900000000 AS DateTime), 1)
INSERT [pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (9, N'Aluno 2', N'05635686745', N'asdfasd', N'(12) 4314-3123', N'(12) 3412-3412', CAST(0x000071B500000000 AS DateTime), 0)
SET IDENTITY_INSERT [pessoa] OFF
SET IDENTITY_INSERT [perfil] ON
INSERT [perfil] ([idPerfil], [nome]) VALUES (1, N'Adm')
INSERT [perfil] ([idPerfil], [nome]) VALUES (2, N'coordenador')
INSERT [perfil] ([idPerfil], [nome]) VALUES (3, N'Professor')
INSERT [perfil] ([idPerfil], [nome]) VALUES (4, N'Diretor')
INSERT [perfil] ([idPerfil], [nome]) VALUES (5, N'Recepção')
SET IDENTITY_INSERT [perfil] OFF
SET IDENTITY_INSERT [tipoEndereco] ON
INSERT [tipoEndereco] ([idTipoEndereco], [nome]) VALUES (1, N'Cobrança')
SET IDENTITY_INSERT [tipoEndereco] OFF
SET IDENTITY_INSERT [taxa] ON
INSERT [taxa] ([idTaxa], [nome], [descricao], [valor]) VALUES (1, N'Taxa de Matricula', N'Mensalidade', CAST(30 AS Decimal(18, 0)))
SET IDENTITY_INSERT [taxa] OFF
SET IDENTITY_INSERT [status] ON
INSERT [status] ([idStatus], [descricao]) VALUES (1, N'Aprovado')
INSERT [status] ([idStatus], [descricao]) VALUES (2, N'Reprovado')
INSERT [status] ([idStatus], [descricao]) VALUES (3, N'Recuperação')
INSERT [status] ([idStatus], [descricao]) VALUES (4, N'Ativo')
INSERT [status] ([idStatus], [descricao]) VALUES (5, N'Inativo')
INSERT [status] ([idStatus], [descricao]) VALUES (6, N'Pago')
INSERT [status] ([idStatus], [descricao]) VALUES (7, N'Não Pago')
INSERT [status] ([idStatus], [descricao]) VALUES (8, N'Pendente')
INSERT [status] ([idStatus], [descricao]) VALUES (9, N'Turma Fechada')
INSERT [status] ([idStatus], [descricao]) VALUES (10, N'Turma Solicitada')
INSERT [status] ([idStatus], [descricao]) VALUES (11, N'Turma Aberta')
INSERT [status] ([idStatus], [descricao]) VALUES (12, N'Inadimplente')
INSERT [status] ([idStatus], [descricao]) VALUES (13, N'Turma Rejeitada')
SET IDENTITY_INSERT [status] OFF
SET IDENTITY_INSERT [modulo] ON
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (11, N'C# Orientado a Objetos ', 10, 4, 16)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (17, N'Asp.Net - Desenvolvimento Web', 5, 4, 16)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (18, N'Asp.Net - Codebehind', 10, 4, 16)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (19, N'Ajax.Net', 8, 4, 16)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (20, N'C#.Net - Segurança', 5, 4, 16)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (21, N'Java Orientado a Objetos', 5, 4, 17)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (22, N'Criação de Sites com JSP, JEE ', 5, 4, 17)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (23, N'Hibernate e JPA', 5, 4, 17)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (24, N'Java Server Faces', 5, 4, 17)
INSERT [modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (25, N'Desenvolvimento RIA com RichFa', 6, 4, 17)
SET IDENTITY_INSERT [modulo] OFF
SET IDENTITY_INSERT [responsavel] ON
INSERT [responsavel] ([idResponsavel], [grauParentesco], [idPessoa]) VALUES (1, N'Pai', 5)
INSERT [responsavel] ([idResponsavel], [grauParentesco], [idPessoa]) VALUES (2, N'mae', 2)
SET IDENTITY_INSERT [responsavel] OFF
SET IDENTITY_INSERT [usuario] ON
INSERT [usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (3, 3, N'professor', N'1')
INSERT [usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (4, 2, N'coordenador', N'1')
INSERT [usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (5, 4, N'diretor', N'1')
INSERT [usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (6, 5, N'recepcao', N'1')
INSERT [usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (7, 1, N'oliveira', N'eu')
INSERT [usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (8, 3, N'marcio', N'123')
INSERT [usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (9, 5, N'fernando', N'123')
SET IDENTITY_INSERT [usuario] OFF
SET IDENTITY_INSERT [endereco] ON
INSERT [endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (2, 1, 1, N'Rua Wilson Souza Pinheiro', 517, N'casa 01', N'23573-120', N'Paciência', N'Rio de Janeiro', N'RJ', 1)
INSERT [endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (3, 1, 2, N'Rua Wilson Souza Pinheiro', 517, N'Casa 01', N'23573120', N'Paciência', N'Rio de Janeiro', N'RJ', 0)
INSERT [endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (5, 1, 4, N'fasd', 111, N'adsf', N'22222-222', N'dsa', N'adsd', N'RJ', 0)
INSERT [endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (6, 1, 8, N'teste', 3232, N'asfasdf', N'32423-424', N'asf', N'asdf', N'as', 0)
SET IDENTITY_INSERT [endereco] OFF
SET IDENTITY_INSERT [funcionario] ON
INSERT [funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (1, 3, 2, 1, CAST(2000 AS Decimal(18, 0)))
INSERT [funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (2, 4, 3, 2, CAST(2000 AS Decimal(18, 0)))
INSERT [funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (3, 5, 4, 3, CAST(2000 AS Decimal(18, 0)))
INSERT [funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (4, 6, 5, 4, CAST(2000 AS Decimal(18, 0)))
INSERT [funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (5, 8, 2, 6, CAST(10000 AS Decimal(18, 0)))
INSERT [funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (6, 9, 5, 5, CAST(3340 AS Decimal(18, 0)))
SET IDENTITY_INSERT [funcionario] OFF
SET IDENTITY_INSERT [aluno] ON
INSERT [aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (5, 8, 0, 0, NULL)
INSERT [aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (6, 9, 0, 0, NULL)
SET IDENTITY_INSERT [aluno] OFF
SET IDENTITY_INSERT [cobranca] ON
INSERT [cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (81, 1, 5, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A078005A33BE AS DateTime), NULL)
INSERT [cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (82, 1, 6, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A078013074D2 AS DateTime), NULL)
INSERT [cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (83, 1, 5, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A078013086D2 AS DateTime), NULL)
SET IDENTITY_INSERT [cobranca] OFF
SET IDENTITY_INSERT [matricula] ON
INSERT [matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (7, 5, 7, CAST(0x0000A073005A3368 AS DateTime), NULL, N'matricula')
INSERT [matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (8, 6, 8, CAST(0x0000A073013074B5 AS DateTime), NULL, N'matricula')
INSERT [matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (9, 5, 7, CAST(0x0000A073013086D1 AS DateTime), NULL, N'matricula')
SET IDENTITY_INSERT [matricula] OFF
SET IDENTITY_INSERT [turma] ON
INSERT [turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario]) VALUES (5, 16, N'Turma A', 10, 0, CAST(0x0000A07400000000 AS DateTime), CAST(0x0000A07F00000000 AS DateTime), NULL, 13, 5)
INSERT [turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario]) VALUES (6, 17, N'Turma A', 10, 0, CAST(0x0000A07400000000 AS DateTime), CAST(0x0000A07F00000000 AS DateTime), NULL, 11, 1)
SET IDENTITY_INSERT [turma] OFF
SET IDENTITY_INSERT [matriculaTurma] ON
INSERT [matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (6, 7, 1, NULL, NULL)
INSERT [matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (6, 8, 2, NULL, NULL)
INSERT [matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (6, 9, 3, NULL, NULL)
SET IDENTITY_INSERT [matriculaTurma] OFF
