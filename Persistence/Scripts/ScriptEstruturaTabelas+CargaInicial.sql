USE [SysCad]
GO
/****** Object:  Table [dbo].[curso]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (3, N'WebDeveloper C#.Net', N'O curso WebDeveloper C#.Net visa a capacitação do aluno para atuar como programador na plat. .NET', CAST(3120 AS Decimal(18, 0)), 4)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (4, N'PHP + MySQL', N'Inicialização ao PHP e MYSQL', CAST(1000 AS Decimal(18, 0)), 4)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (5, N'PHP com Zend Framework + MySQL', N'PHP utilizando framework zend e banco de dados MySQL, estrutura MVC e programação orientada', CAST(2500 AS Decimal(18, 0)), 4)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (6, N'Montagem e Manutenção', N'Montagem e manutenção de micro computadores', CAST(800 AS Decimal(18, 0)), 4)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (7, N'Windows + Pacote Office', N'Windows + Pacote Office (Word, Excel, Power Point, etc))', CAST(800 AS Decimal(18, 0)), 4)
INSERT [dbo].[curso] ([idCurso], [nome], [descricao], [valor], [status]) VALUES (8, N'Ruby on Rails', N'Ruby on Rails', CAST(3000 AS Decimal(18, 0)), 4)
SET IDENTITY_INSERT [dbo].[curso] OFF
/****** Object:  Table [dbo].[cargo]    Script Date: 07/11/2012 13:44:15 ******/
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
SET IDENTITY_INSERT [dbo].[cargo] ON
INSERT [dbo].[cargo] ([idCargo], [nome], [descricao]) VALUES (1, N'Diretor', N'Responsável pelos processos da instituição e liderar seus funcionários')
INSERT [dbo].[cargo] ([idCargo], [nome], [descricao]) VALUES (2, N'Professor', N'Responsável pelas aulas ministradas na instituição')
INSERT [dbo].[cargo] ([idCargo], [nome], [descricao]) VALUES (3, N'Coordenador', N'Responsável por liderar a equipe pedagógica da instituição')
INSERT [dbo].[cargo] ([idCargo], [nome], [descricao]) VALUES (4, N'Recepcionista', N'Responsáel por receber e dar o primeiro atendimento aos clientes')
SET IDENTITY_INSERT [dbo].[cargo] OFF
/****** Object:  Table [dbo].[menu]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (3, N'Curso', N'/Curso/Curso', N'Cadastro', N'ApplicationFormAdd', N'idAbaCurso', N'1,2,4')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (4, N'Módulo', N'/Modulo/Modulo', N'Cadastro', N'ApplicationFormAdd', N'idAbaModulo', N'1,2,4')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (5, N'Pessoa/Endereço', N'/Pessoa/Pessoa', N'Cadastro', N'User', N'idAbaPessoa', N'1,2,5')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (6, N'Taxas', N'/Taxa/Taxa', N'Cadastro', N'MoneyAdd', N'idAbaTaxas', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (7, N'Solicitar Abertura de Turma', N'/Turma/AbrirTurma', N'Coordenação', N'ApplicationAdd', N'idAbaAbTurma', N'1,2,4')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (8, N'Processar cobrança de mensalidade', N'/Pagamento/ProcessarCobranca', N'Coordenação', N'MoneyDollar', N'idAbaProcCob', N'1,2,4')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (9, N'Fechar de Turma', N'/Turma/FecharTurma', N'Coordenação', N'ApplicationDelete', N'idAbaFecharTurma', N'1,2,4')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (10, N'Autorizar abertura de turma', N'/Turma/AutorizarTurma', N'Diretoria', N'Accept', N'idAbaAbrirTurma', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (11, N'Relatório de Ex-Alunos', N'/Relatorio/ExAlunos', N'Diretoria', N'Report', N'idAbaRelatorio', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (12, N'Relatório de Inadimplentes', N'/Relatorio/Inadimplentes', N'Diretoria', N'Report', N'idAbaRelatorio1', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (13, N'Relatório de cursos mais procurados', N'/Relatorio/CursosMaisCursados', N'Diretoria', N'Report', N'idAbaRelatorio2', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (14, N'Relatório de especialização dos professores', N'/Relatorio/Especializacao', N'Diretoria', N'Report', N'idAbaRelatorio3', N'1,2')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (15, N'Lançar Nota/Falta', N'/LancarNotaFalta/lancarNotaFalta', N'Professor', N'BookAddresses', N'idAbaLancaNota', N'1,3')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (16, N'Consultar disponibilidade turma', N'/Turma/ConsultarDisponibilidade', N'Recepção', N'Clock', N'idAbaHorario', N'1,5')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (17, N'Realizar Matrícula', N'/Matricula/Matricula', N'Recepção', N'BookOpen', N'idAbaMatricula', N'1,5')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (18, N'Realizar Pagamento', N'/Pagamento/RealizarPagamento', N'Recepção', N'Money', N'idAbaPagamento', N'1,5')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (19, N'Realizar Pré-Matrícula', N'/Matricula/Prematricula', N'Recepção', N'BookOpenMark', N'idAbaPreMatricula', N'1,5')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (20, N'Vincular Aluno/Turma', N'/Turma/VincularAluno', N'Recepção', N'ApplicationAdd', N'idAbaVincularAlunoTurma', N'1,5')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (21, N'Professor/Especialização', N'/Especializacao/Especializacao', N'Cadastro', N'UserEarth', N'idAbaProfessorEspecializacao', N'1,2,4')
INSERT [dbo].[menu] ([idMenu], [titulo], [url], [grupo], [icon], [nomeTab], [perfis]) VALUES (22, N'Baixa Boleto', N'/Pagamento/BaixaBoleto', N'Coordenação', N'MoneyDelete', N'idAbaBaixaBoleto', N'1,4')
SET IDENTITY_INSERT [dbo].[menu] OFF
/****** Object:  Table [dbo].[funcionarioEspecializacao]    Script Date: 07/11/2012 13:44:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[funcionarioEspecializacao](
	[idFuncionarioEspecializacao] [int] IDENTITY(1,1) NOT NULL,
	[idFuncionario] [int] NOT NULL,
	[idEspecializacao] [int] NOT NULL,
 CONSTRAINT [PK_funcionarioEspecializacao] PRIMARY KEY CLUSTERED 
(
	[idFuncionarioEspecializacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[funcionarioEspecializacao] ON
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (3, 2, 4)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (4, 5, 5)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (5, 7, 5)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (6, 5, 6)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (7, 7, 7)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (8, 2, 8)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (9, 8, 8)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (10, 6, 8)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (11, 5, 8)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (12, 7, 8)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (13, 5, 9)
INSERT [dbo].[funcionarioEspecializacao] ([idFuncionarioEspecializacao], [idFuncionario], [idEspecializacao]) VALUES (14, 6, 4)
SET IDENTITY_INSERT [dbo].[funcionarioEspecializacao] OFF
/****** Object:  Table [dbo].[especializacao]    Script Date: 07/11/2012 13:44:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[especializacao](
	[idEspecializacao] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](255) NULL,
 CONSTRAINT [PK_especializacao] PRIMARY KEY CLUSTERED 
(
	[idEspecializacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[especializacao] ON
INSERT [dbo].[especializacao] ([idEspecializacao], [nome]) VALUES (4, N'WEB C#')
INSERT [dbo].[especializacao] ([idEspecializacao], [nome]) VALUES (5, N'PHP + MySQL')
INSERT [dbo].[especializacao] ([idEspecializacao], [nome]) VALUES (6, N'PHP + Zend Framework + MySQL')
INSERT [dbo].[especializacao] ([idEspecializacao], [nome]) VALUES (7, N'Ruby on Rails')
INSERT [dbo].[especializacao] ([idEspecializacao], [nome]) VALUES (8, N'Windows + Pacote Office')
INSERT [dbo].[especializacao] ([idEspecializacao], [nome]) VALUES (9, N'Montagem e Manutenção')
SET IDENTITY_INSERT [dbo].[especializacao] OFF
/****** Object:  Table [dbo].[pessoa]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (1, N'Diego Pessanha Bentes', N'05838408766', N'diego.pessanha@grupoitec.com.br', N'(21) 3317-7508', N'(21) 9866-3599', CAST(0x0000824100000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (2, N'Leonardo Lira', N'03124551605', N'leolirarj@yahoo.com.br', N'(21) 2487-4566', N'(21) 9547-2183', CAST(0x0000782800000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (3, N'Renan de Almeida Valente', N'13543740709', N'renan.valente@ravsistema.com.br', N'(21) 2416-0077', N'(21) 8505-0932', CAST(0x00007F9E00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (4, N'Marcelle Teixeira de Souza', N'88495529718', N'marcelle_teixeira2@hotmail.com', N'(21) 3317-7508', N'(21) 8807-6333', CAST(0x000081F600000000 AS DateTime), 0)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (5, N'Rafael de Oliveira Bentes', N'12442934744', N'rafael@exemplo.com.br', N'(11) 1111-1111', N'(11) 1111-1111', CAST(0x0000963500000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (6, N'José Claudio Brandão Valente', N'93771587700', N'claudio.brandao@exemplo.com.br', N'(11) 1111-1111', N'', CAST(0x00006B0F00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (7, N'Renan Valente', N'13543740709', N'renan.valente@ravsistemas.com.br', N'(21) 2415-2810', N'(21) 8505-0932', CAST(0x0000814900000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (8, N'Diogo Nogueira Valente', N'05838408766', N'diego.nogueira@grupoitec.com.br', N'(21) 2222-2222', N'(21) 1313-1313', CAST(0x0000967F00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (9, N'Leandro Marques da Silva', N'03124551605', N'leonardo.marques@yahoo.com.br', N'(11) 1111-1111', N'(11) 1111-1111', CAST(0x00007E3800000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (10, N'Thais Silvestre', N'13543740709', N'thais.silvestre@thais.com', N'(11) 1111-1111', N'(11) 1111-1111', CAST(0x00008C8200000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (11, N'Olinda da Silva', N'13543740709', N'olinda@olinda.com.br', N'(21) 3384-2625', N'(21) 8658-2714', CAST(0x00007F0700000000 AS DateTime), 0)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (12, N'Marcia Teixeira de Oliveira', N'13543740709', N'marcia@marcia.com.br', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x0000814900000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (13, N'Ronaldo Bentes Nogueira', N'13543740709', N'ronaldo@hotmail.com', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x0000822A00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (14, N'Rosane Lopes de Almeida', N'13543740709', N'rosane@lopes.com.br', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x00007C8500000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (15, N'Rogério de Almeida Lopes', N'13543740709', N'rogerio@rogerio.com', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x00007F0700000000 AS DateTime), 0)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (16, N'Wagner de Almeida Lopes', N'03124551605', N'wagner@mastercurso.com.br', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x0000811E00000000 AS DateTime), 0)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (17, N'Ana Maria de Almeida Valente', N'03124551605', N'ana.almeida@mastercurso.com.br', N'(11) 1111-1111', N'(12) 2222-2222', CAST(0x0000821D00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (18, N'João Pedro Chaves da Silva', N'03124551605', N'joao.pedro@mastercurso.com.br', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x0000834E00000000 AS DateTime), 0)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (19, N'Tatiana Bendes de Almeida', N'03124551605', N'tatiana@mastercurso.com.br', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x00007FFC00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (20, N'Juliana Valente', N'03124551605', N'juliana@mastercurso.com.br', N'(22) 2222-2222', N'(22) 2222-2222', CAST(0x00007D7900000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (21, N'Mateus Souza Silveira', N'03124551605', N'mateus@mastercurso.com.br', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x000055FD00000000 AS DateTime), 0)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (22, N'Mirian Salazar Oliveira', N'03124551605', N'mirian@mastercurso.com.br', N'(44) 4444-4444', N'(44) 4444-4555', CAST(0x000081CA00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (23, N'Ricardo Braga de Souza', N'03124551605', N'ricardo.braga@mastercurso.com.br', N'(22) 2222-2222', N'(11) 1111-1111', CAST(0x0000637200000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (24, N'Renato de Souza Valente', N'03124551605', N'renato@mastercurso.com.br', N'(11) 1111-1111', N'(12) 1212-1212', CAST(0x0000814B00000000 AS DateTime), 1)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (25, N'Alexandre Felix de Almeida', N'03124551605', N'alexandre.felix@mastercurso.com.br', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x00007E8100000000 AS DateTime), 0)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (26, N'Marcelle Bentes', N'05838408766', N'marcelle@marcelle.com.br', N'(11) 1111-1111', N'(22) 2222-2222', CAST(0x000088A100000000 AS DateTime), 0)
INSERT [dbo].[pessoa] ([idPessoa], [nome], [cpf], [email], [telefone], [celular], [dataNascimento], [sexo]) VALUES (27, N'Jovina de Almeida Lopes', N'13543740709', N'jovina@jovina.com.br', N'(11) 1111-1111', N'(33) 3333-3333', CAST(0x000064BC00000000 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[pessoa] OFF
/****** Object:  Table [dbo].[perfil]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (1, N'Adm. Sistema')
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (2, N'Diretor')
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (3, N'Professor')
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (4, N'Coordenador')
INSERT [dbo].[perfil] ([idPerfil], [nome]) VALUES (5, N'Recepção')
SET IDENTITY_INSERT [dbo].[perfil] OFF
/****** Object:  Table [dbo].[tipoEndereco]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[tipoEndereco] ([idTipoEndereco], [nome]) VALUES (2, N'Residencial')
INSERT [dbo].[tipoEndereco] ([idTipoEndereco], [nome]) VALUES (3, N'Comercial')
SET IDENTITY_INSERT [dbo].[tipoEndereco] OFF
/****** Object:  Table [dbo].[taxa]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[taxa] ([idTaxa], [nome], [descricao], [valor]) VALUES (1, N'Taxa de Matrícula', N'Taxa referente a realização da matricula do aluno', CAST(30 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[taxa] OFF
/****** Object:  Table [dbo].[status]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (3, N'Recuperacao')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (4, N'Ativo')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (5, N'Inativo')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (6, N'Pago')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (7, N'Nao Pago')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (8, N'Pendentes')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (9, N'Turma Fechada')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (10, N'Turma Solicitada')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (11, N'Turma Aberta')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (12, N'Inadimplente')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (13, N'Turma Rejeitada')
INSERT [dbo].[status] ([idStatus], [descricao]) VALUES (14, N'Turma Fechada Antes do Termino')
SET IDENTITY_INSERT [dbo].[status] OFF
/****** Object:  Table [dbo].[modulo]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (1, N'C# Orientado a Objetos', 5, 4, 3)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (2, N'Asp.Net, C# e Frameworks', 17, 4, 3)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (3, N'Logica de programação', 3, 4, 4)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (4, N'Zend Framework', 10, 4, 5)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (5, N'Inicialização do php', 5, 4, 4)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (6, N'Banco de Dados MySQL', 5, 4, 4)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (7, N'Projeto Final', 15, 4, 5)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (8, N'Projeto Final', 10, 4, 4)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (9, N'Pacote Office', 10, 4, 7)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (10, N'Windows', 10, 4, 7)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (11, N'Hardware', 15, 4, 6)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (12, N'DOS', 5, 4, 6)
INSERT [dbo].[modulo] ([idModulo], [nome], [tempoDuracao], [statusModulo], [idCurso]) VALUES (13, N'Ruby on Rails', 15, 4, 8)
SET IDENTITY_INSERT [dbo].[modulo] OFF
/****** Object:  Table [dbo].[responsavel]    Script Date: 07/11/2012 13:44:15 ******/
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
SET IDENTITY_INSERT [dbo].[responsavel] ON
INSERT [dbo].[responsavel] ([idResponsavel], [grauParentesco], [idPessoa]) VALUES (1, N'filho', 6)
INSERT [dbo].[responsavel] ([idResponsavel], [grauParentesco], [idPessoa]) VALUES (2, N'Pai', 6)
INSERT [dbo].[responsavel] ([idResponsavel], [grauParentesco], [idPessoa]) VALUES (3, N'Pai', 6)
INSERT [dbo].[responsavel] ([idResponsavel], [grauParentesco], [idPessoa]) VALUES (4, N'Irmã', 27)
SET IDENTITY_INSERT [dbo].[responsavel] OFF
/****** Object:  Table [dbo].[usuario]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (1, 1, N'administrador', N'1')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (2, 2, N'diretor', N'1')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (3, 3, N'professor', N'1')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (4, 4, N'coordenador', N'1')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (5, 5, N'recepcao', N'1')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (6, 2, N'diego', N'diego')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (7, 3, N'leonardo', N'leonardo')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (8, 4, N'renan', N'renan')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (9, 5, N'marcelle', N'marcelle')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (10, 3, N'rvalente', N'123')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (11, 3, N'llira', N'123')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (12, 3, N'dpessanha', N'123')
INSERT [dbo].[usuario] ([idUsuario], [idPerfil], [login], [senha]) VALUES (13, 3, N'olinda', N'123')
SET IDENTITY_INSERT [dbo].[usuario] OFF
/****** Object:  Table [dbo].[endereco]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (1, 1, 1, N'Rua Sacramento Blacke', 87, N'Fundos', N'23052-160', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (2, 2, 1, N'Rua Sacramento Blacke', 87, N'Fundos', N'23052-160', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (3, 3, 1, N'Rua México', 41, N'Sala 402', N'23041-523', N'Centro', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (4, 1, 2, N'Rua 30', 450, N'Casa 2', N'23045-126', N'Urucânia', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (5, 2, 2, N'Rua 30', 220, N'Casa 1', N'23052-154', N'Urucânia', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (6, 3, 2, N'Rua da Passagem', 4578, N'Sala 550', N'21542-522', N'Botafogo', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (7, 1, 3, N'Rua Macedo Coimbra', 416, N'', N'23015-421', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (8, 2, 3, N'Rua Macedo Coimbra', 416, N'', N'23015-421', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (9, 3, 3, N'Rua Macedo Coimbra', 416, N'', N'23015-421', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (10, 1, 4, N'Rua Sacramento Blacke', 87, N'Fundos', N'23052-160', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (11, 2, 4, N'Rua Sacramento Blacke', 87, N'Fundos', N'23052-160', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (12, 3, 4, N'Rua Sacramento Blacke', 87, N'Fundos', N'23052-160', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (13, 1, 5, N'Rua Wilson Souza Pinheiro', 517, N'Casa 01', N'23573-120', N'Paciencia', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (14, 1, 6, N'Rua www', 222, N'xxx', N'32323-232', N'Paciencia', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (15, 1, 7, N'tttttttt', 11111, N'hhhhhh', N'11111-111', N'jhhhhh', N'hhhhh', N'hh', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (16, 1, 8, N'gfgfgf', 756565, N'hghghgh', N'77676-767', N'GGHG', N'GG', N'JJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (17, 1, 9, N'kjdskjkdjakjk', 221, N'dsjkdajkjs', N'11111-111', N'dajskdjkajskdjk', N'dajskjdkaj', N'da', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (18, 1, 10, N'hhhhhhhhhhhhh', 2345, N'dfghjk', N'45678-234', N'fghjk', N'4fghjkl', N'df', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (19, 1, 11, N'Rua Onça de Pitangui', 1222, N'Sobrado', N'11111-111', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (20, 1, 12, N'Rua Rua Rua', 121, N'Casa', N'11111-111', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (21, 1, 13, N'Rua Rua Rua', 111, N'Casa', N'22222-222', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (22, 1, 14, N'Rua Rua Rua', 222, N'Casa', N'33333-333', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (23, 1, 15, N'Rua Rua Rua', 333, N'Casa', N'33333-333', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (24, 1, 16, N'rua rua rua', 111, N'casa', N'11111-111', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (25, 1, 17, N'Rua Rua', 12, N'Casa', N'11111-111', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (26, 1, 18, N'Rua Casa', 123, N'Casa', N'22222-222', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (27, 1, 19, N'Rua 1', 1, N'Casa', N'11111-111', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (28, 1, 20, N'Rua A', 12, N'Casa', N'12121-212', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (29, 1, 21, N'Rua a2', 13, N'Casa', N'33333-333', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (30, 1, 22, N'Rua 3', 33, N'Casa', N'33333-333', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (31, 1, 23, N'Rua e', 41, N'Casa ', N'44444-444', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (32, 1, 24, N'Rua 4', 31, N'Casa', N'55555-555', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (33, 1, 25, N'Rua b', 1, N'Casa', N'11111-111', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (34, 1, 26, N'Rua ABC', 123, N'Casa', N'11111-111', N'Campo Grande', N'Rio de Janeiro', N'RJ', 0)
INSERT [dbo].[endereco] ([idEndereco], [idTipoEndereco], [idPessoa], [logradouro], [numero], [complemento], [CEP], [bairro], [cidade], [uf], [tipo]) VALUES (35, 1, 27, N'Rua do Lado', 4321, N'Casa', N'11111-111', N'Bangu', N'Rio de Janeiro', N'RJ', 0)
SET IDENTITY_INSERT [dbo].[endereco] OFF
/****** Object:  Table [dbo].[funcionario]    Script Date: 07/11/2012 13:44:15 ******/
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
SET IDENTITY_INSERT [dbo].[funcionario] ON
INSERT [dbo].[funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (1, 6, 1, 1, CAST(3000 AS Decimal(18, 0)))
INSERT [dbo].[funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (2, 7, 2, 2, CAST(2000 AS Decimal(18, 0)))
INSERT [dbo].[funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (3, 8, 3, 3, CAST(2500 AS Decimal(18, 0)))
INSERT [dbo].[funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (4, 9, 4, 4, CAST(1500 AS Decimal(18, 0)))
INSERT [dbo].[funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (5, 10, 2, 12, CAST(2000 AS Decimal(18, 0)))
INSERT [dbo].[funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (6, 11, 2, 14, CAST(2000 AS Decimal(18, 0)))
INSERT [dbo].[funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (7, 12, 2, 13, CAST(2000 AS Decimal(18, 0)))
INSERT [dbo].[funcionario] ([idFuncionario], [idUsuario], [idCargo], [idPessoa], [salario]) VALUES (8, 13, 2, 15, CAST(2000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[funcionario] OFF
/****** Object:  Table [dbo].[aluno]    Script Date: 07/11/2012 13:44:14 ******/
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
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (1, 5, 0, 0, 1)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (2, 7, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (3, 8, 0, 0, 2)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (4, 9, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (5, 10, 0, 0, 3)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (6, 11, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (7, 16, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (8, 17, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (9, 18, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (10, 19, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (11, 20, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (12, 21, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (13, 22, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (14, 23, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (15, 24, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (16, 25, 0, 0, NULL)
INSERT [dbo].[aluno] ([idAluno], [idPessoa], [statusPedagogico], [statusFinanceiro], [idResponsavel]) VALUES (17, 26, 0, 0, 4)
SET IDENTITY_INSERT [dbo].[aluno] OFF
/****** Object:  Table [dbo].[cobranca]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (1, 1, 1, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A07900000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (2, 1, 2, 6, CAST(30.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)), CAST(0x0000A081014DAA22 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (3, 1, 3, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A081014DC72E AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (4, 1, 4, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A081014DF1E6 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (5, NULL, 1, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A04D00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (6, NULL, 2, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A04D00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (7, NULL, 3, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A04D00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (8, NULL, 4, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A04D00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (9, 1, 5, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A0810156B32B AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (10, 1, 1, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A086012642FE AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (11, 1, 2, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A0860126AB03 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (12, 1, 4, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A0860126D156 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (13, 1, 3, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A08601272FAE AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (14, 1, 6, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A086012745B0 AS DateTime), 6)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (15, 1, 5, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A0860127654E AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (16, 1, 6, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A08601280550 AS DateTime), 6)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (17, 1, 2, 6, CAST(30.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), CAST(0x0000A0860128421E AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (18, 1, 4, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A08601288B5D AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (19, 1, 7, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011F1365 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (20, 1, 8, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011F3835 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (21, 1, 9, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011F4AC9 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (22, 1, 10, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011F5E35 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (23, 1, 11, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011F70C8 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (24, 1, 12, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011F813F AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (25, 1, 13, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011F9309 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (26, 1, 14, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011FA1FC AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (27, 1, 15, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011FB433 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (28, 1, 16, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A087011FC65F AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (29, NULL, 1, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (30, NULL, 1, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (31, NULL, 2, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (32, NULL, 2, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (33, NULL, 2, 7, CAST(3000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 8)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (34, NULL, 3, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (35, NULL, 3, 7, CAST(2500.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 5)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (36, NULL, 4, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (37, NULL, 4, 7, CAST(3000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 8)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (38, NULL, 4, 7, CAST(1000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 4)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (39, NULL, 5, 7, CAST(3120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 3)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (40, NULL, 5, 7, CAST(1000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 4)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (41, NULL, 6, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 6)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (42, NULL, 6, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (43, NULL, 7, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (44, NULL, 8, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (45, NULL, 9, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (46, NULL, 10, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (47, NULL, 11, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (48, NULL, 12, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (49, NULL, 13, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (50, NULL, 14, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (51, NULL, 15, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (52, NULL, 16, 7, CAST(800.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A06C00000000 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (53, 1, 17, 6, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A08C01357DE0 AS DateTime), 7)
INSERT [dbo].[cobranca] ([idCobranca], [idTaxa], [idAluno], [statusPagamento], [valorTotal], [juros], [dataVencimento], [idCurso]) VALUES (54, 1, 17, 7, CAST(30.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A08C01361E60 AS DateTime), 8)
SET IDENTITY_INSERT [dbo].[cobranca] OFF
/****** Object:  Table [dbo].[matricula]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (1, 1, 1, CAST(0x0000A0790162471A AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (2, 2, 2, CAST(0x0000A07C014DA97C AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (3, 3, 3, CAST(0x0000A07C014DC71F AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (4, 4, 4, CAST(0x0000A07C014DF1DC AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (5, 5, 5, CAST(0x0000A07C0156B30C AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (6, 1, 1, CAST(0x0000A081012642F4 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (7, 2, 2, CAST(0x0000A0810126AAFF AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (8, 4, 4, CAST(0x0000A0810126D152 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (9, 3, 3, CAST(0x0000A08101272FAA AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (10, 6, 10, CAST(0x0000A08101274592 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (11, 5, 5, CAST(0x0000A0810127653E AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (12, 6, 10, CAST(0x0000A0810128054C AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (13, 2, 2, CAST(0x0000A0810128421A AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (14, 4, 4, CAST(0x0000A08101288B59 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (15, 7, 15, CAST(0x0000A082011F132C AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (16, 8, 16, CAST(0x0000A082011F382D AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (17, 9, 17, CAST(0x0000A082011F4AC2 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (18, 10, 18, CAST(0x0000A082011F5E2D AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (19, 11, 19, CAST(0x0000A082011F70C0 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (20, 12, 20, CAST(0x0000A082011F8138 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (21, 13, 21, CAST(0x0000A082011F9301 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (22, 14, 22, CAST(0x0000A082011FA1F4 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (23, 15, 23, CAST(0x0000A082011FB42C AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (24, 16, 24, CAST(0x0000A082011FC657 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (25, 2, 2, CAST(0x0000A086013EF440 AS DateTime), NULL, N'prematricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (26, 4, 4, CAST(0x0000A086013F102B AS DateTime), NULL, N'prematricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (27, 3, 3, CAST(0x0000A086013F56AE AS DateTime), NULL, N'prematricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (28, 6, 10, CAST(0x0000A086013F64DB AS DateTime), NULL, N'prematricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (29, 5, 5, CAST(0x0000A086013F839B AS DateTime), NULL, N'prematricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (30, 17, 30, CAST(0x0000A08701357D93 AS DateTime), NULL, N'matricula')
INSERT [dbo].[matricula] ([idMatricula], [idAluno], [numeroMatricula], [dataRegistro], [dataCancelamento], [tipo]) VALUES (31, 17, 30, CAST(0x0000A08701361E55 AS DateTime), NULL, N'matricula')
SET IDENTITY_INSERT [dbo].[matricula] OFF
/****** Object:  Table [dbo].[turma]    Script Date: 07/11/2012 13:44:15 ******/
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
	[status] [int] NULL,
	[idFuncionario] [int] NULL,
	[justificativa] [nvarchar](max) NULL,
 CONSTRAINT [PK_turma] PRIMARY KEY CLUSTERED 
(
	[idTurma] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[turma] ON
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (1, 3, N'1001', 10, 5, CAST(0x0000A07800000000 AS DateTime), CAST(0x0000A07900000000 AS DateTime), NULL, 11, 2, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (2, 8, N'1002', 10, 2, CAST(0x0000A08100000000 AS DateTime), CAST(0x0000A09F00000000 AS DateTime), NULL, 11, 7, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (3, 4, N'1003', 10, 1, CAST(0x0000A08100000000 AS DateTime), CAST(0x0000A09F00000000 AS DateTime), NULL, 11, 5, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (4, 7, N'1004', 10, 2, CAST(0x0000A08100000000 AS DateTime), CAST(0x0000A09F00000000 AS DateTime), NULL, 11, 8, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (5, 5, N'1005', 10, 1, CAST(0x0000A08100000000 AS DateTime), CAST(0x0000A09F00000000 AS DateTime), NULL, 11, 5, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (6, 6, N'1006', 10, 1, CAST(0x0000A09F00000000 AS DateTime), CAST(0x0000A08100000000 AS DateTime), NULL, 11, 5, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (7, 7, N'1007', 11, 1, CAST(0x0000A08100000000 AS DateTime), CAST(0x0000A09F00000000 AS DateTime), NULL, 11, 6, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (8, 4, N'1008', 10, 1, CAST(0x0000A08100000000 AS DateTime), CAST(0x0000A09F00000000 AS DateTime), NULL, 11, 7, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (9, 7, N'2001', 10, 10, CAST(0x0000A08200000000 AS DateTime), CAST(0x0000A08300000000 AS DateTime), CAST(0x0000A086013C94E8 AS DateTime), 9, 2, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (10, 3, N'2002', 10, 0, CAST(0x0000A08200000000 AS DateTime), CAST(0x0000A08300000000 AS DateTime), NULL, 10, 2, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (11, 7, N'2003', 10, 0, CAST(0x0000A08200000000 AS DateTime), CAST(0x0000A08400000000 AS DateTime), NULL, 10, 5, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (12, 8, N'2004', 10, 0, CAST(0x0000A08200000000 AS DateTime), CAST(0x0000A09400000000 AS DateTime), NULL, 10, 7, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (13, 4, N'2005', 10, 0, CAST(0x0000A08200000000 AS DateTime), CAST(0x0000A09F00000000 AS DateTime), NULL, 10, 7, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (14, 6, N'2006', 10, 0, CAST(0x0000A08200000000 AS DateTime), CAST(0x0000A09900000000 AS DateTime), NULL, 10, 5, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (15, 3, N'2007', 10, 0, CAST(0x0000A08200000000 AS DateTime), CAST(0x0000A09900000000 AS DateTime), NULL, 10, 2, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (16, 7, N'3012', 1, 1, CAST(0x0000A08700000000 AS DateTime), CAST(0x0000A08800000000 AS DateTime), NULL, 11, 5, NULL)
INSERT [dbo].[turma] ([idTurma], [idCurso], [descricao], [numeroVagas], [vagasOcupadas], [dataInicio], [dataFim], [dataFechamento], [status], [idFuncionario], [justificativa]) VALUES (17, 8, N'312', 1, 1, CAST(0x0000A08700000000 AS DateTime), CAST(0x0000A08800000000 AS DateTime), NULL, 11, 7, NULL)
SET IDENTITY_INSERT [dbo].[turma] OFF
/****** Object:  Table [dbo].[pagamento]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (1, 53, CAST(15.00 AS Decimal(18, 2)), 1, CAST(0x0000A08701367DEA AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (2, 53, CAST(15.00 AS Decimal(18, 2)), 2, CAST(0x0000A08701371E4F AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (3, 17, CAST(30.00 AS Decimal(18, 2)), 3, CAST(0x0000A08B00DDA595 AS DateTime))
INSERT [dbo].[pagamento] ([idPagamento], [idCobranca], [valor], [formaPag], [dataPagamento]) VALUES (4, 2, CAST(30.00 AS Decimal(18, 2)), 3, CAST(0x0000A08B00DDABC6 AS DateTime))
SET IDENTITY_INSERT [dbo].[pagamento] OFF
/****** Object:  Table [dbo].[notaFalta]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (1, 9, 9, 7, 0, CAST(10.0 AS Decimal(3, 1)), NULL, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (2, 9, 9, 8, 0, CAST(9.0 AS Decimal(3, 1)), NULL, 1, CAST(9.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (3, 9, 9, 9, 0, CAST(8.5 AS Decimal(3, 1)), NULL, 1, CAST(8.5 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (4, 9, 9, 10, 0, CAST(9.0 AS Decimal(3, 1)), NULL, 1, CAST(9.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (5, 9, 9, 11, 0, CAST(8.0 AS Decimal(3, 1)), NULL, 1, CAST(8.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (6, 9, 9, 12, 0, CAST(10.0 AS Decimal(3, 1)), NULL, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (7, 9, 9, 13, 0, CAST(6.0 AS Decimal(3, 1)), CAST(8.0 AS Decimal(3, 1)), 1, CAST(7.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (8, 9, 9, 14, 0, CAST(7.0 AS Decimal(3, 1)), NULL, 1, CAST(7.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (9, 9, 9, 15, 0, CAST(7.5 AS Decimal(3, 1)), NULL, 1, CAST(7.5 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (10, 9, 9, 16, 0, CAST(9.5 AS Decimal(3, 1)), NULL, 1, CAST(9.5 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (11, 9, 10, 7, 0, CAST(10.0 AS Decimal(3, 1)), NULL, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (12, 9, 10, 8, 0, CAST(8.0 AS Decimal(3, 1)), NULL, 1, CAST(8.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (13, 9, 10, 9, 0, CAST(9.5 AS Decimal(3, 1)), NULL, 1, CAST(9.5 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (14, 9, 10, 10, 0, CAST(8.0 AS Decimal(3, 1)), NULL, 1, CAST(8.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (15, 9, 10, 11, 0, CAST(10.0 AS Decimal(3, 1)), NULL, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (16, 9, 10, 12, 0, CAST(10.0 AS Decimal(3, 1)), NULL, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (17, 9, 10, 13, 0, CAST(9.0 AS Decimal(3, 1)), NULL, 1, CAST(9.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (18, 9, 10, 14, 0, CAST(8.5 AS Decimal(3, 1)), NULL, 1, CAST(8.5 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (19, 9, 10, 15, 0, CAST(9.5 AS Decimal(3, 1)), NULL, 1, CAST(9.5 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (20, 9, 10, 16, 0, CAST(10.0 AS Decimal(3, 1)), NULL, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (21, 16, 10, 17, 0, CAST(10.0 AS Decimal(3, 1)), NULL, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[notaFalta] ([idNotaFalta], [idTurma], [idModulo], [idAluno], [qtdFalta], [nota1], [nota2], [situacaoAluno], [notaFinal]) VALUES (22, 16, 9, 17, 0, CAST(6.5 AS Decimal(3, 1)), CAST(9.0 AS Decimal(3, 1)), 1, CAST(7.0 AS Decimal(3, 1)))
SET IDENTITY_INSERT [dbo].[notaFalta] OFF
/****** Object:  Table [dbo].[matriculaTurma]    Script Date: 07/11/2012 13:44:15 ******/
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
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (1, 1, 1, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (1, 2, 2, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (1, 3, 3, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (1, 4, 4, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (1, 5, 5, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (4, 6, 6, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (4, 7, 7, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (2, 8, 8, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (5, 9, 9, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (6, 10, 10, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (3, 11, 11, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (7, 12, 12, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (2, 13, 13, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (8, 14, 14, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 15, 15, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 16, 16, 1, CAST(8.5 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 17, 17, 1, CAST(9.0 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 18, 18, 1, CAST(8.5 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 19, 19, 1, CAST(9.0 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 20, 20, 1, CAST(10.0 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 21, 21, 1, CAST(8.0 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 22, 22, 1, CAST(7.8 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 23, 23, 1, CAST(8.5 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (9, 24, 24, 1, CAST(9.8 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (8, 25, 25, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (3, 26, 26, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (3, 27, 27, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (3, 28, 28, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (3, 29, 29, NULL, NULL)
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (16, 30, 30, 1, CAST(8.5 AS Decimal(3, 1)))
INSERT [dbo].[matriculaTurma] ([idTurma], [idMatricula], [idMatriculaTurma], [situacaoAluno], [notaFinal]) VALUES (17, 31, 31, NULL, NULL)
SET IDENTITY_INSERT [dbo].[matriculaTurma] OFF
/****** Object:  Default [DF_aluno_idResponsavel]    Script Date: 07/11/2012 13:44:14 ******/
ALTER TABLE [dbo].[aluno] ADD  CONSTRAINT [DF_aluno_idResponsavel]  DEFAULT ((0)) FOR [idResponsavel]
GO
/****** Object:  Default [DF_NotaFinal2]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[matriculaTurma] ADD  CONSTRAINT [DF_NotaFinal2]  DEFAULT ((0)) FOR [notaFinal]
GO
/****** Object:  Default [DF_QtdFaltas]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[notaFalta] ADD  CONSTRAINT [DF_QtdFaltas]  DEFAULT ((0)) FOR [qtdFalta]
GO
/****** Object:  Default [DF_Nota1]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[notaFalta] ADD  CONSTRAINT [DF_Nota1]  DEFAULT ((0)) FOR [nota1]
GO
/****** Object:  Default [DF_Nota2]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[notaFalta] ADD  CONSTRAINT [DF_Nota2]  DEFAULT ((0)) FOR [nota2]
GO
/****** Object:  Default [DF_NotaFinal]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[notaFalta] ADD  CONSTRAINT [DF_NotaFinal]  DEFAULT ((0)) FOR [notaFinal]
GO
/****** Object:  ForeignKey [FK_aluno_pessoa]    Script Date: 07/11/2012 13:44:14 ******/
ALTER TABLE [dbo].[aluno]  WITH CHECK ADD  CONSTRAINT [FK_aluno_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
ALTER TABLE [dbo].[aluno] CHECK CONSTRAINT [FK_aluno_pessoa]
GO
/****** Object:  ForeignKey [FK_aluno_responsavel]    Script Date: 07/11/2012 13:44:14 ******/
ALTER TABLE [dbo].[aluno]  WITH CHECK ADD  CONSTRAINT [FK_aluno_responsavel] FOREIGN KEY([idResponsavel])
REFERENCES [dbo].[responsavel] ([idResponsavel])
GO
ALTER TABLE [dbo].[aluno] CHECK CONSTRAINT [FK_aluno_responsavel]
GO
/****** Object:  ForeignKey [FK_cobranca_aluno]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[cobranca]  WITH CHECK ADD  CONSTRAINT [FK_cobranca_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
ALTER TABLE [dbo].[cobranca] CHECK CONSTRAINT [FK_cobranca_aluno]
GO
/****** Object:  ForeignKey [FK_cobranca_curso]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[cobranca]  WITH CHECK ADD  CONSTRAINT [FK_cobranca_curso] FOREIGN KEY([idCurso])
REFERENCES [dbo].[curso] ([idCurso])
GO
ALTER TABLE [dbo].[cobranca] CHECK CONSTRAINT [FK_cobranca_curso]
GO
/****** Object:  ForeignKey [FK_cobranca_taxa]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[cobranca]  WITH CHECK ADD  CONSTRAINT [FK_cobranca_taxa] FOREIGN KEY([idTaxa])
REFERENCES [dbo].[taxa] ([idTaxa])
GO
ALTER TABLE [dbo].[cobranca] CHECK CONSTRAINT [FK_cobranca_taxa]
GO
/****** Object:  ForeignKey [FK_endereco_pessoa]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[endereco]  WITH CHECK ADD  CONSTRAINT [FK_endereco_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
ALTER TABLE [dbo].[endereco] CHECK CONSTRAINT [FK_endereco_pessoa]
GO
/****** Object:  ForeignKey [FK_endereco_tipoEndereco]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[endereco]  WITH CHECK ADD  CONSTRAINT [FK_endereco_tipoEndereco] FOREIGN KEY([idTipoEndereco])
REFERENCES [dbo].[tipoEndereco] ([idTipoEndereco])
GO
ALTER TABLE [dbo].[endereco] CHECK CONSTRAINT [FK_endereco_tipoEndereco]
GO
/****** Object:  ForeignKey [FK_funcionario_cargo]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_cargo] FOREIGN KEY([idCargo])
REFERENCES [dbo].[cargo] ([idCargo])
GO
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_cargo]
GO
/****** Object:  ForeignKey [FK_funcionario_pessoa]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_pessoa]
GO
/****** Object:  ForeignKey [FK_funcionario_usuario]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_usuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_usuario]
GO
/****** Object:  ForeignKey [FK_matricula_aluno]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[matricula]  WITH CHECK ADD  CONSTRAINT [FK_matricula_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
ALTER TABLE [dbo].[matricula] CHECK CONSTRAINT [FK_matricula_aluno]
GO
/****** Object:  ForeignKey [FK_matriculaTurma_matricula]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[matriculaTurma]  WITH CHECK ADD  CONSTRAINT [FK_matriculaTurma_matricula] FOREIGN KEY([idMatricula])
REFERENCES [dbo].[matricula] ([idMatricula])
GO
ALTER TABLE [dbo].[matriculaTurma] CHECK CONSTRAINT [FK_matriculaTurma_matricula]
GO
/****** Object:  ForeignKey [FK_matriculaTurma_turma]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[matriculaTurma]  WITH CHECK ADD  CONSTRAINT [FK_matriculaTurma_turma] FOREIGN KEY([idTurma])
REFERENCES [dbo].[turma] ([idTurma])
GO
ALTER TABLE [dbo].[matriculaTurma] CHECK CONSTRAINT [FK_matriculaTurma_turma]
GO
/****** Object:  ForeignKey [FK_modulo_curso]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[modulo]  WITH CHECK ADD  CONSTRAINT [FK_modulo_curso] FOREIGN KEY([idCurso])
REFERENCES [dbo].[curso] ([idCurso])
GO
ALTER TABLE [dbo].[modulo] CHECK CONSTRAINT [FK_modulo_curso]
GO
/****** Object:  ForeignKey [FK_notaFalta_aluno]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_aluno]
GO
/****** Object:  ForeignKey [FK_notaFalta_modulo]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_modulo] FOREIGN KEY([idModulo])
REFERENCES [dbo].[modulo] ([idModulo])
GO
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_modulo]
GO
/****** Object:  ForeignKey [FK_notaFalta_turma]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_turma] FOREIGN KEY([idTurma])
REFERENCES [dbo].[turma] ([idTurma])
GO
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_turma]
GO
/****** Object:  ForeignKey [FK_pagamento_cobranca]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[pagamento]  WITH CHECK ADD  CONSTRAINT [FK_pagamento_cobranca] FOREIGN KEY([idCobranca])
REFERENCES [dbo].[cobranca] ([idCobranca])
GO
ALTER TABLE [dbo].[pagamento] CHECK CONSTRAINT [FK_pagamento_cobranca]
GO
/****** Object:  ForeignKey [FK_responsavel_pessoa]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[responsavel]  WITH CHECK ADD  CONSTRAINT [FK_responsavel_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
ALTER TABLE [dbo].[responsavel] CHECK CONSTRAINT [FK_responsavel_pessoa]
GO
/****** Object:  ForeignKey [FK_turma_curso]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[turma]  WITH CHECK ADD  CONSTRAINT [FK_turma_curso] FOREIGN KEY([idCurso])
REFERENCES [dbo].[curso] ([idCurso])
GO
ALTER TABLE [dbo].[turma] CHECK CONSTRAINT [FK_turma_curso]
GO
/****** Object:  ForeignKey [FK_turma_funcionario]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[turma]  WITH CHECK ADD  CONSTRAINT [FK_turma_funcionario] FOREIGN KEY([idFuncionario])
REFERENCES [dbo].[funcionario] ([idFuncionario])
GO
ALTER TABLE [dbo].[turma] CHECK CONSTRAINT [FK_turma_funcionario]
GO
/****** Object:  ForeignKey [FK_usuario_perfil]    Script Date: 07/11/2012 13:44:15 ******/
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_usuario_perfil] FOREIGN KEY([idPerfil])
REFERENCES [dbo].[perfil] ([idPerfil])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_perfil]
GO
