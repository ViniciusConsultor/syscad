USE [SysCad]
GO
/****** Object:  Table [dbo].[curso]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[curso](
	[idCurso] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NULL,
	[descricao] [varchar](100) NULL,
	[valor] [decimal](18, 0) NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_curso] PRIMARY KEY CLUSTERED 
(
	[idCurso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[curso] ON
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (2, N'C# Developer', N'Desenvolvimento C#', CAST(1000 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (3, N'php', N'php', CAST(2000 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (4, N'SDD', N'llll', CAST(3000 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (5, N'fdf', N'hh', CAST(300 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (6, N'ww', N'www', CAST(100 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (7, N'ee', N'ee', CAST(200 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (8, N'dds', N'ds', CAST(200 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (9, N'rere', N'ytyt', CAST(300 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (10, N'php', N'php', CAST(2000 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (11, N'SDD', N'llll', CAST(3000 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (12, N'Java develggg', N'Desenvolvimento java', CAST(1000 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (13, N'php', N'php', CAST(2000 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (14, N'Java develggg', N'Desenvolvimento java', CAST(1000 AS Decimal(18, 0)), 1)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (15, N'Java develggg', N'Desenvolvimento java', CAST(1000 AS Decimal(18, 0)), 1)
SET IDENTITY_INSERT [dbo].[curso] OFF
/****** Object:  Table [dbo].[cargo]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cargo](
	[idCargo] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[descricao] [varchar](100) NULL,
 CONSTRAINT [PK_cargo] PRIMARY KEY CLUSTERED 
(
	[idCargo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[menu]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[menu](
	[idMenu] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [nvarchar](100) NOT NULL,
	[url] [nvarchar](200) NULL,
	[grupo] [nvarchar](100) NOT NULL,
	[icon] [nvarchar](50) NULL,
	[nomeTab] [nvarchar](100) NULL,
	[perfis] [nvarchar](200) NULL,
 CONSTRAINT [PK_IdMenu] PRIMARY KEY CLUSTERED 
(
	[idMenu] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[menu] ON
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (2, N'Cargo/Funcionário', N'/Cargo/Cargo', N'Cadastro', N'UserSuitBlack', N'idAbaCargo', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (3, N'Curso', N'/Curso/Curso', N'Cadastro', N'ApplicationFormAdd', N'idAbaCurso', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (4, N'Modulo', N'/Modulo/Modulo', N'Cadastro', N'ApplicationFormAdd', N'idAbaModulo', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (5, N'Pessoa/Endereço', N'/Pessoa/Pessoa', N'Cadastro', N'User', N'idAbaPessoa', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (6, N'Taxas', N'/Taxa/Taxa', N'Cadastro', N'MoneyAdd', N'idAbaTaxas', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (7, N'Abertura de Turma', N'', N'Coordenação', N'ApplicationAdd', N'idAbaAbTurma', N'2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (8, N'Processar cobrança de mensalidade', N'', N'Coordenação', N'MoneyDollar', N'idAbaProcCob', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (9, N'Fechamento de Turma', N'/Turma/FecharTurma', N'Coordenação', N'ApplicationDelete', N'idAbaFecharTurma', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (10, N'Autorizar abertura de turma', N'/Turma/AbrirTurma', N'Diretoria', N'Accept', N'idAbaAbrirTurma', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (11, N'Relatorio de Ex-Alunos', N'', N'Diretoria', N'Report', N'idAbaRelatorio', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (12, N'Relatorio de Inadimplentes', N'', N'Diretoria', N'Report', N'idAbaRelatorio1', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (13, N'Relatorio de cursos mais cursados', N'', N'Diretoria', N'Report', N'idAbaRelatorio2', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (14, N'Relatorio de especialização dos professores', N'', N'Diretoria', N'Report', N'idAbaRelatorio3', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (15, N'Lançar Nota/Falta', N'/LancarNotaFalta/lancarNotaFalta', N'Professor', N'BookAddresses', N'idAbaLancaNota', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (16, N'Consultar disponibilidade horário/turma', N'', N'Recepção', N'Clock', N'idAbaHorario', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (17, N'Realizar Matrícula', N'/Matricula/Matricula', N'Recepção', N'BookOpen', N'idAbaMatricula', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (18, N'Realizar Pagamento', N'/Pagamento/RealizarPagamento', N'Recepção', N'Money', N'idAbaPagamento', N'1')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (19, N'Realizar Pré-Matrícula', N'', N'Recepção', N'BookOpenMark', N'idAbaPreMatricula', N'1')
SET IDENTITY_INSERT [dbo].[menu] OFF
/****** Object:  Table [dbo].[pessoa]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pessoa](
	[idPessoa] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[cpf] [varchar](15) NOT NULL,
	[email] [varchar](50) NULL,
	[telefone] [varchar](14) NULL,
	[celular] [varchar](14) NULL,
	[dataNascimento] [datetime] NOT NULL,
	[sexo] [int] NOT NULL,
 CONSTRAINT [PK_pessoa] PRIMARY KEY CLUSTERED 
(
	[idPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[pessoa] ON
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (1, N'Leonardo Oliveira', N'05635686745', N'leolirarj@yahoo.com.br', N'88411859', N'', CAST(0x0000798700000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (2, N'Jessica Muniz', N'1231', N'leolira@yahhd', N'3213', N'1231', CAST(0x0000A04B00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (3, N'fatima', N'12312', N'asd', N'1312', N'12312', CAST(0x00008D8000000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (4, N'leonardo', N'111', N'sfda', N'1231', N'31213', CAST(0x0000A0A500000000 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[pessoa] OFF
/****** Object:  Table [dbo].[perfil]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[perfil](
	[idPerfil] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NULL,
 CONSTRAINT [PK_perfil] PRIMARY KEY CLUSTERED 
(
	[idPerfil] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[perfil] ON
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (1, N'Adm')
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (2, N'coordenador')
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (3, N'Professor')
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (4, N'Diretor')
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (5, N'Recepção')
SET IDENTITY_INSERT [dbo].[perfil] OFF
/****** Object:  Table [dbo].[tipoEndereco]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tipoEndereco](
	[idTipoEndereco] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NULL,
 CONSTRAINT [PK_tipoEndereco] PRIMARY KEY CLUSTERED 
(
	[idTipoEndereco] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tipoEndereco] ON
INSERT [dbo].[tipoEndereco] ([idTipoEndereco], [nome]) VALUES (1, N'Cobrança')
SET IDENTITY_INSERT [dbo].[tipoEndereco] OFF
/****** Object:  Table [dbo].[taxa]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[taxa](
	[idTaxa] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nvarchar](50) NULL,
	[descricao] [varchar](100) NULL,
	[valor] [decimal](18, 0) NULL,
 CONSTRAINT [PK_taxa] PRIMARY KEY CLUSTERED 
(
	[idTaxa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[taxa] ON
INSERT [dbo].[taxa] ([idTaxa], [nome], [descricao], [valor]) VALUES (1, N'Taxa de Matricula', N'Mensalidade', CAST(500 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[taxa] OFF
/****** Object:  Table [dbo].[status]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[idStatus] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idStatus] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[status] ON
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (1, N'Aprovado')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (2, N'Reprovado')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (3, N'Recuperação')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (4, N'Ativo')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (5, N'Inativo')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (6, N'Pago')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (7, N'Não Pago')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (8, N'Pendente')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (9, N'Turma Fechada')
SET IDENTITY_INSERT [dbo].[status] OFF
/****** Object:  Table [dbo].[usuario]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[idPerfil] [int] NOT NULL,
	[login] [varchar](15) NOT NULL,
	[senha] [varchar](100) NOT NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[usuario] ON
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (1, 1, N'oliveira', N'eu')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (2, 2, N'leo', N'123')
SET IDENTITY_INSERT [dbo].[usuario] OFF
/****** Object:  Table [dbo].[turma]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[turma](
	[idTurma] [int] IDENTITY(1,1) NOT NULL,
	[idCurso] [int] NOT NULL,
	[descricao] [varchar](100) NOT NULL,
	[numeroVagas] [int] NULL,
	[vagasOcupadas] [int] NULL,
	[dataInicio] [datetime] NOT NULL,
	[dataFim] [datetime] NOT NULL,
	[dataFechamento] [datetime] NULL,
 CONSTRAINT [PK_turma] PRIMARY KEY CLUSTERED 
(
	[idTurma] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[turma] ON
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento]) VALUES (1, 2, N'Turma 1', 10, 5, CAST(0x0000A04100000000 AS DateTime), CAST(0x0000A07600000000 AS DateTime), CAST(0x0000A0600160CB57 AS DateTime))
SET IDENTITY_INSERT [dbo].[turma] OFF
/****** Object:  Table [dbo].[responsavel]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[responsavel](
	[idResponsavel] [int] IDENTITY(1,1) NOT NULL,
	[grauParentesco] [nvarchar](100) NULL,
	[idPessoa] [int] NOT NULL,
 CONSTRAINT [PK_responsavel] PRIMARY KEY CLUSTERED 
(
	[idResponsavel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[modulo]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[modulo](
	[idModulo] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NULL,
	[tempoDuracao] [int] NULL,
	[statusModulo] [int] NULL,
	[idCurso] [int] NOT NULL,
 CONSTRAINT [PK_modulo] PRIMARY KEY CLUSTERED 
(
	[idModulo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[modulo] ON
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (5, N'Word', 100, 1, 11)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (6, N'Excel', 100, 1, 12)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (7, N'xxx', 100, 1, 13)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (8, N'zzz', 100, 1, 14)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (9, N'Modulo 1', 100, 1, 2)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (10, N'Modulo 2', 100, 1, 2)
SET IDENTITY_INSERT [dbo].[modulo] OFF
/****** Object:  Table [dbo].[endereco]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[endereco](
	[idEndereco] [int] IDENTITY(1,1) NOT NULL,
	[idTipoEndereco] [int] NOT NULL,
	[idPessoa] [int] NOT NULL,
	[logradouro] [varchar](100) NOT NULL,
	[numero] [int] NOT NULL,
	[complemento] [varchar](100) NULL,
	[CEP] [varchar](9) NOT NULL,
	[bairro] [varchar](50) NOT NULL,
	[cidade] [varchar](50) NOT NULL,
	[uf] [char](2) NOT NULL,
	[tipo] [int] NULL,
 CONSTRAINT [PK_endereco] PRIMARY KEY CLUSTERED 
(
	[idEndereco] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[endereco] ON
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (2, 1, 1, N'Rua Wilson Souza Pinheiro', 517, N'casa 01', N'23573120', N'Paciência', N'Rio de Janeiro', N'RJ', 1)
SET IDENTITY_INSERT [dbo].[endereco] OFF
/****** Object:  Table [dbo].[funcionario]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[funcionario](
	[idFuncionario] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idCargo] [int] NOT NULL,
	[idPessoa] [int] NOT NULL,
	[salario] [decimal](18, 0) NULL,
 CONSTRAINT [PK_funcionario] PRIMARY KEY CLUSTERED 
(
	[idFuncionario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aluno]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aluno](
	[idAluno] [int] IDENTITY(1,1) NOT NULL,
	[idPessoa] [int] NOT NULL,
	[statusPedagogico] [int] NULL,
	[statusFinanceiro] [int] NULL,
	[idResponsavel] [int] NULL,
 CONSTRAINT [PK_aluno] PRIMARY KEY CLUSTERED 
(
	[idAluno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[aluno] ON
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (1, 1, 1, 1, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (2, 2, 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[aluno] OFF
/****** Object:  Table [dbo].[notaFalta]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notaFalta](
	[idNotaFalta] [int] IDENTITY(1,1) NOT NULL,
	[idTurma] [int] NOT NULL,
	[idModulo] [int] NOT NULL,
	[idAluno] [int] NOT NULL,
	[qtdFalta] [int] NULL,
	[nota1] [decimal](3, 1) NULL,
	[nota2] [decimal](3, 1) NULL,
	[situacaoAluno] [int] NULL,
	[notaFinal] [decimal](3, 1) NULL,
 CONSTRAINT [PK_notaFalta] PRIMARY KEY CLUSTERED 
(
	[idNotaFalta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[notaFalta] ON
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (16, 1, 9, 1, 10, CAST(5.0 AS Decimal(3, 1)), CAST(8.0 AS Decimal(3, 1)), 1, CAST(7.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (17, 1, 9, 2, 50, CAST(7.0 AS Decimal(3, 1)), NULL, 2, CAST(7.0 AS Decimal(3, 1)))
SET IDENTITY_INSERT [dbo].[notaFalta] OFF
/****** Object:  Table [dbo].[cobranca]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cobranca](
	[idCobranca] [int] IDENTITY(1,1) NOT NULL,
	[idTaxa] [int] NULL,
	[idAluno] [int] NOT NULL,
	[statusPagamento] [int] NULL,
	[valorTotal] [decimal](18, 2) NULL,
	[juros] [decimal](18, 2) NULL,
	[dataVencimento] [datetime] NULL,
	[idCurso] [int] NULL,
 CONSTRAINT [PK_cobranca] PRIMARY KEY CLUSTERED 
(
	[idCobranca] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cobranca] ON
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (1, 1, 1, 7, CAST(500.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), NULL)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (10, NULL, 1, 6, CAST(1000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A04F001F9038 AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[cobranca] OFF
/****** Object:  Table [dbo].[matricula]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[matricula](
	[idMatricula] [int] IDENTITY(1,1) NOT NULL,
	[idAluno] [int] NOT NULL,
	[numeroMatricula] [int] NOT NULL,
	[dataRegistro] [datetime] NOT NULL,
	[dataCancelamento] [datetime] NULL,
	[tipo] [varchar](30) NOT NULL,
 CONSTRAINT [PK_matricula] PRIMARY KEY CLUSTERED 
(
	[idMatricula] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[matricula] ON
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (1, 1, 1, CAST(0x0000A04200084E61 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (2, 2, 123, CAST(0x0000A060015CA135 AS DateTime), NULL, N'matricula')
SET IDENTITY_INSERT [dbo].[matricula] OFF
/****** Object:  Table [dbo].[pagamento]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pagamento](
	[idPagamento] [int] IDENTITY(1,1) NOT NULL,
	[idCobranca] [int] NOT NULL,
	[valor] [decimal](18, 2) NOT NULL,
	[formaPag] [int] NOT NULL,
	[dataPagamento] [datetime] NOT NULL,
 CONSTRAINT [PK_pagamento] PRIMARY KEY CLUSTERED 
(
	[idPagamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[pagamento] ON
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (45, 10, CAST(1.50 AS Decimal(18, 2)), 1, CAST(0x0000A05F014A9B00 AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (46, 10, CAST(100.40 AS Decimal(18, 2)), 1, CAST(0x0000A05F014DA783 AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (47, 10, CAST(100.10 AS Decimal(18, 2)), 1, CAST(0x0000A05F014DC99A AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (48, 10, CAST(100.50 AS Decimal(18, 2)), 1, CAST(0x0000A05F014F0FA2 AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (49, 10, CAST(100.45 AS Decimal(18, 2)), 1, CAST(0x0000A05F0151ABC7 AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (50, 10, CAST(197.05 AS Decimal(18, 2)), 1, CAST(0x0000A05F0151D8C8 AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (51, 10, CAST(100.37 AS Decimal(18, 2)), 1, CAST(0x0000A05F0151EE48 AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (52, 10, CAST(299.63 AS Decimal(18, 2)), 1, CAST(0x0000A05F01524060 AS DateTime))
SET IDENTITY_INSERT [dbo].[pagamento] OFF
/****** Object:  Table [dbo].[matriculaTurma]    Script Date: 06/06/2012 22:07:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matriculaTurma](
	[idTurma] [int] NOT NULL,
	[idMatricula] [int] NOT NULL,
	[idMatriculaTurma] [int] IDENTITY(1,1) NOT NULL,
	[situacaoAluno] [int] NULL,
	[notaFinal] [decimal](3, 1) NULL,
PRIMARY KEY CLUSTERED 
(
	[idMatriculaTurma] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[matriculaTurma] ON
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (1, 1, 1, 9, CAST(7.0 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (1, 2, 2, 9, NULL)
SET IDENTITY_INSERT [dbo].[matriculaTurma] OFF
/****** Object:  Default [DF_aluno_idResponsavel]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[aluno] ADD  CONSTRAINT [DF_aluno_idResponsavel]  DEFAULT ((0)) FOR [idResponsavel]
GO
/****** Object:  Default [DF_NotaFinal2]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[matriculaTurma] ADD  CONSTRAINT [DF_NotaFinal2]  DEFAULT ((0)) FOR [notaFinal]
GO
/****** Object:  Default [DF_QtdFaltas]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[notaFalta] ADD  CONSTRAINT [DF_QtdFaltas]  DEFAULT ((0)) FOR [qtdFalta]
GO
/****** Object:  Default [DF_Nota1]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[notaFalta] ADD  CONSTRAINT [DF_Nota1]  DEFAULT ((0)) FOR [nota1]
GO
/****** Object:  Default [DF_Nota2]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[notaFalta] ADD  CONSTRAINT [DF_Nota2]  DEFAULT ((0)) FOR [nota2]
GO
/****** Object:  Default [DF_NotaFinal]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[notaFalta] ADD  CONSTRAINT [DF_NotaFinal]  DEFAULT ((0)) FOR [notaFinal]
GO
/****** Object:  ForeignKey [FK_aluno_pessoa]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[aluno]  WITH CHECK ADD  CONSTRAINT [FK_aluno_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
ALTER TABLE [dbo].[aluno] CHECK CONSTRAINT [FK_aluno_pessoa]
GO
/****** Object:  ForeignKey [FK_aluno_responsavel]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[aluno]  WITH CHECK ADD  CONSTRAINT [FK_aluno_responsavel] FOREIGN KEY([idResponsavel])
REFERENCES [dbo].[responsavel] ([idResponsavel])
GO
ALTER TABLE [dbo].[aluno] CHECK CONSTRAINT [FK_aluno_responsavel]
GO
/****** Object:  ForeignKey [FK_cobranca_aluno]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[cobranca]  WITH CHECK ADD  CONSTRAINT [FK_cobranca_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
ALTER TABLE [dbo].[cobranca] CHECK CONSTRAINT [FK_cobranca_aluno]
GO
/****** Object:  ForeignKey [FK_cobranca_curso]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[cobranca]  WITH CHECK ADD  CONSTRAINT [FK_cobranca_curso] FOREIGN KEY([idCurso])
REFERENCES [dbo].[curso] ([idCurso])
GO
ALTER TABLE [dbo].[cobranca] CHECK CONSTRAINT [FK_cobranca_curso]
GO
/****** Object:  ForeignKey [FK_cobranca_taxa]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[cobranca]  WITH CHECK ADD  CONSTRAINT [FK_cobranca_taxa] FOREIGN KEY([idTaxa])
REFERENCES [dbo].[taxa] ([idTaxa])
GO
ALTER TABLE [dbo].[cobranca] CHECK CONSTRAINT [FK_cobranca_taxa]
GO
/****** Object:  ForeignKey [FK_endereco_pessoa]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[endereco]  WITH CHECK ADD  CONSTRAINT [FK_endereco_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
ALTER TABLE [dbo].[endereco] CHECK CONSTRAINT [FK_endereco_pessoa]
GO
/****** Object:  ForeignKey [FK_endereco_tipoEndereco]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[endereco]  WITH CHECK ADD  CONSTRAINT [FK_endereco_tipoEndereco] FOREIGN KEY([idTipoEndereco])
REFERENCES [dbo].[tipoEndereco] ([idTipoEndereco])
GO
ALTER TABLE [dbo].[endereco] CHECK CONSTRAINT [FK_endereco_tipoEndereco]
GO
/****** Object:  ForeignKey [FK_funcionario_cargo]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_cargo] FOREIGN KEY([idCargo])
REFERENCES [dbo].[cargo] ([idCargo])
GO
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_cargo]
GO
/****** Object:  ForeignKey [FK_funcionario_pessoa]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_pessoa]
GO
/****** Object:  ForeignKey [FK_funcionario_usuario]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_usuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_usuario]
GO
/****** Object:  ForeignKey [FK_matricula_aluno]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[matricula]  WITH CHECK ADD  CONSTRAINT [FK_matricula_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
ALTER TABLE [dbo].[matricula] CHECK CONSTRAINT [FK_matricula_aluno]
GO
/****** Object:  ForeignKey [FK_matriculaTurma_matricula]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[matriculaTurma]  WITH CHECK ADD  CONSTRAINT [FK_matriculaTurma_matricula] FOREIGN KEY([idMatricula])
REFERENCES [dbo].[matricula] ([idMatricula])
GO
ALTER TABLE [dbo].[matriculaTurma] CHECK CONSTRAINT [FK_matriculaTurma_matricula]
GO
/****** Object:  ForeignKey [FK_matriculaTurma_turma]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[matriculaTurma]  WITH CHECK ADD  CONSTRAINT [FK_matriculaTurma_turma] FOREIGN KEY([idTurma])
REFERENCES [dbo].[turma] ([idTurma])
GO
ALTER TABLE [dbo].[matriculaTurma] CHECK CONSTRAINT [FK_matriculaTurma_turma]
GO
/****** Object:  ForeignKey [FK_modulo_curso]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[modulo]  WITH CHECK ADD  CONSTRAINT [FK_modulo_curso] FOREIGN KEY([idCurso])
REFERENCES [dbo].[curso] ([idCurso])
GO
ALTER TABLE [dbo].[modulo] CHECK CONSTRAINT [FK_modulo_curso]
GO
/****** Object:  ForeignKey [FK_notaFalta_aluno]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_aluno]
GO
/****** Object:  ForeignKey [FK_notaFalta_modulo]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_modulo] FOREIGN KEY([idModulo])
REFERENCES [dbo].[modulo] ([idModulo])
GO
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_modulo]
GO
/****** Object:  ForeignKey [FK_notaFalta_turma]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_turma] FOREIGN KEY([idTurma])
REFERENCES [dbo].[turma] ([idTurma])
GO
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_turma]
GO
/****** Object:  ForeignKey [FK_pagamento_cobranca]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[pagamento]  WITH CHECK ADD  CONSTRAINT [FK_pagamento_cobranca] FOREIGN KEY([idCobranca])
REFERENCES [dbo].[cobranca] ([idCobranca])
GO
ALTER TABLE [dbo].[pagamento] CHECK CONSTRAINT [FK_pagamento_cobranca]
GO
/****** Object:  ForeignKey [FK_responsavel_pessoa]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[responsavel]  WITH CHECK ADD  CONSTRAINT [FK_responsavel_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
ALTER TABLE [dbo].[responsavel] CHECK CONSTRAINT [FK_responsavel_pessoa]
GO
/****** Object:  ForeignKey [FK_turma_curso]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[turma]  WITH CHECK ADD  CONSTRAINT [FK_turma_curso] FOREIGN KEY([idCurso])
REFERENCES [dbo].[curso] ([idCurso])
GO
ALTER TABLE [dbo].[turma] CHECK CONSTRAINT [FK_turma_curso]
GO
/****** Object:  ForeignKey [FK_usuario_perfil]    Script Date: 06/06/2012 22:07:48 ******/
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_usuario_perfil] FOREIGN KEY([idPerfil])
REFERENCES [dbo].[perfil] ([idPerfil])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_perfil]
GO
