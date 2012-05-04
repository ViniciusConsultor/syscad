USE [SysCad]
GO
/****** Object:  Table [dbo].[pessoa]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pessoa]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[perfil]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[perfil]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[perfil](
	[idPerfil] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NULL,
 CONSTRAINT [PK_perfil] PRIMARY KEY CLUSTERED 
(
	[idPerfil] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[curso]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[curso]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cargo]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cargo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cargo](
	[idCargo] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[descricao] [varchar](100) NULL,
 CONSTRAINT [PK_cargo] PRIMARY KEY CLUSTERED 
(
	[idCargo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tipoEndereco]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tipoEndereco]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tipoEndereco](
	[idTipoEndereco] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NULL,
 CONSTRAINT [PK_tipoEndereco] PRIMARY KEY CLUSTERED 
(
	[idTipoEndereco] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[taxa]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[taxa]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[turma]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[turma]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[modulo]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[modulo]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[responsavel]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[responsavel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[responsavel](
	[idResponsavel] [int] IDENTITY(1,1) NOT NULL,
	[grauParentesco] [nvarchar](100) NULL,
	[idPessoa] [int] NOT NULL,
 CONSTRAINT [PK_responsavel] PRIMARY KEY CLUSTERED 
(
	[idResponsavel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[endereco]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[endereco]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[funcionario]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funcionario]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[aluno]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aluno]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[notaFalta]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[notaFalta]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[notaFalta](
	[idNotaFalta] [int] IDENTITY(1,1) NOT NULL,
	[idTurma] [int] NOT NULL,
	[idModulo] [int] NOT NULL,
	[idAluno] [int] NOT NULL,
	[qtdFalta] [int] NULL,
	[nota1] [decimal](18, 0) NULL,
	[nota2] [decimal](18, 0) NULL,
 CONSTRAINT [PK_notaFalta] PRIMARY KEY CLUSTERED 
(
	[idNotaFalta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cobranca]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cobranca]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cobranca](
	[idCobranca] [int] IDENTITY(1,1) NOT NULL,
	[idTaxa] [int] NOT NULL,
	[idAluno] [int] NOT NULL,
	[statusPagamento] [int] NULL,
	[valorTotal] [decimal](18, 0) NULL,
	[juros] [decimal](18, 0) NULL,
 CONSTRAINT [PK_cobranca] PRIMARY KEY CLUSTERED 
(
	[idCobranca] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[matricula]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[matricula]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[matriculaTurma]    Script Date: 05/04/2012 20:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[matriculaTurma]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[matriculaTurma](
	[idTurma] [int] NOT NULL,
	[idMatricula] [int] NOT NULL,
	[idMatriculaTurma] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idMatriculaTurma] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Default [DF_aluno_idResponsavel]    Script Date: 05/04/2012 20:11:49 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_aluno_idResponsavel]') AND parent_object_id = OBJECT_ID(N'[dbo].[aluno]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_aluno_idResponsavel]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aluno] ADD  CONSTRAINT [DF_aluno_idResponsavel]  DEFAULT ((0)) FOR [idResponsavel]
END


End
GO
/****** Object:  ForeignKey [FK_aluno_pessoa]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_aluno_pessoa]') AND parent_object_id = OBJECT_ID(N'[dbo].[aluno]'))
ALTER TABLE [dbo].[aluno]  WITH CHECK ADD  CONSTRAINT [FK_aluno_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_aluno_pessoa]') AND parent_object_id = OBJECT_ID(N'[dbo].[aluno]'))
ALTER TABLE [dbo].[aluno] CHECK CONSTRAINT [FK_aluno_pessoa]
GO
/****** Object:  ForeignKey [FK_aluno_responsavel]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_aluno_responsavel]') AND parent_object_id = OBJECT_ID(N'[dbo].[aluno]'))
ALTER TABLE [dbo].[aluno]  WITH CHECK ADD  CONSTRAINT [FK_aluno_responsavel] FOREIGN KEY([idResponsavel])
REFERENCES [dbo].[responsavel] ([idResponsavel])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_aluno_responsavel]') AND parent_object_id = OBJECT_ID(N'[dbo].[aluno]'))
ALTER TABLE [dbo].[aluno] CHECK CONSTRAINT [FK_aluno_responsavel]
GO
/****** Object:  ForeignKey [FK_cobranca_aluno]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_cobranca_aluno]') AND parent_object_id = OBJECT_ID(N'[dbo].[cobranca]'))
ALTER TABLE [dbo].[cobranca]  WITH CHECK ADD  CONSTRAINT [FK_cobranca_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_cobranca_aluno]') AND parent_object_id = OBJECT_ID(N'[dbo].[cobranca]'))
ALTER TABLE [dbo].[cobranca] CHECK CONSTRAINT [FK_cobranca_aluno]
GO
/****** Object:  ForeignKey [FK_cobranca_taxa]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_cobranca_taxa]') AND parent_object_id = OBJECT_ID(N'[dbo].[cobranca]'))
ALTER TABLE [dbo].[cobranca]  WITH CHECK ADD  CONSTRAINT [FK_cobranca_taxa] FOREIGN KEY([idTaxa])
REFERENCES [dbo].[taxa] ([idTaxa])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_cobranca_taxa]') AND parent_object_id = OBJECT_ID(N'[dbo].[cobranca]'))
ALTER TABLE [dbo].[cobranca] CHECK CONSTRAINT [FK_cobranca_taxa]
GO
/****** Object:  ForeignKey [FK_endereco_pessoa]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_endereco_pessoa]') AND parent_object_id = OBJECT_ID(N'[dbo].[endereco]'))
ALTER TABLE [dbo].[endereco]  WITH CHECK ADD  CONSTRAINT [FK_endereco_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_endereco_pessoa]') AND parent_object_id = OBJECT_ID(N'[dbo].[endereco]'))
ALTER TABLE [dbo].[endereco] CHECK CONSTRAINT [FK_endereco_pessoa]
GO
/****** Object:  ForeignKey [FK_endereco_tipoEndereco]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_endereco_tipoEndereco]') AND parent_object_id = OBJECT_ID(N'[dbo].[endereco]'))
ALTER TABLE [dbo].[endereco]  WITH CHECK ADD  CONSTRAINT [FK_endereco_tipoEndereco] FOREIGN KEY([idTipoEndereco])
REFERENCES [dbo].[tipoEndereco] ([idTipoEndereco])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_endereco_tipoEndereco]') AND parent_object_id = OBJECT_ID(N'[dbo].[endereco]'))
ALTER TABLE [dbo].[endereco] CHECK CONSTRAINT [FK_endereco_tipoEndereco]
GO
/****** Object:  ForeignKey [FK_funcionario_cargo]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_funcionario_cargo]') AND parent_object_id = OBJECT_ID(N'[dbo].[funcionario]'))
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_cargo] FOREIGN KEY([idCargo])
REFERENCES [dbo].[cargo] ([idCargo])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_funcionario_cargo]') AND parent_object_id = OBJECT_ID(N'[dbo].[funcionario]'))
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_cargo]
GO
/****** Object:  ForeignKey [FK_funcionario_pessoa]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_funcionario_pessoa]') AND parent_object_id = OBJECT_ID(N'[dbo].[funcionario]'))
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_funcionario_pessoa]') AND parent_object_id = OBJECT_ID(N'[dbo].[funcionario]'))
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_pessoa]
GO
/****** Object:  ForeignKey [FK_funcionario_usuario]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_funcionario_usuario]') AND parent_object_id = OBJECT_ID(N'[dbo].[funcionario]'))
ALTER TABLE [dbo].[funcionario]  WITH CHECK ADD  CONSTRAINT [FK_funcionario_usuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[usuario] ([idUsuario])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_funcionario_usuario]') AND parent_object_id = OBJECT_ID(N'[dbo].[funcionario]'))
ALTER TABLE [dbo].[funcionario] CHECK CONSTRAINT [FK_funcionario_usuario]
GO
/****** Object:  ForeignKey [FK_matricula_aluno]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_matricula_aluno]') AND parent_object_id = OBJECT_ID(N'[dbo].[matricula]'))
ALTER TABLE [dbo].[matricula]  WITH CHECK ADD  CONSTRAINT [FK_matricula_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_matricula_aluno]') AND parent_object_id = OBJECT_ID(N'[dbo].[matricula]'))
ALTER TABLE [dbo].[matricula] CHECK CONSTRAINT [FK_matricula_aluno]
GO
/****** Object:  ForeignKey [FK_matriculaTurma_matricula]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_matriculaTurma_matricula]') AND parent_object_id = OBJECT_ID(N'[dbo].[matriculaTurma]'))
ALTER TABLE [dbo].[matriculaTurma]  WITH CHECK ADD  CONSTRAINT [FK_matriculaTurma_matricula] FOREIGN KEY([idMatricula])
REFERENCES [dbo].[matricula] ([idMatricula])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_matriculaTurma_matricula]') AND parent_object_id = OBJECT_ID(N'[dbo].[matriculaTurma]'))
ALTER TABLE [dbo].[matriculaTurma] CHECK CONSTRAINT [FK_matriculaTurma_matricula]
GO
/****** Object:  ForeignKey [FK_matriculaTurma_turma]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_matriculaTurma_turma]') AND parent_object_id = OBJECT_ID(N'[dbo].[matriculaTurma]'))
ALTER TABLE [dbo].[matriculaTurma]  WITH CHECK ADD  CONSTRAINT [FK_matriculaTurma_turma] FOREIGN KEY([idTurma])
REFERENCES [dbo].[turma] ([idTurma])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_matriculaTurma_turma]') AND parent_object_id = OBJECT_ID(N'[dbo].[matriculaTurma]'))
ALTER TABLE [dbo].[matriculaTurma] CHECK CONSTRAINT [FK_matriculaTurma_turma]
GO
/****** Object:  ForeignKey [FK_modulo_curso]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_modulo_curso]') AND parent_object_id = OBJECT_ID(N'[dbo].[modulo]'))
ALTER TABLE [dbo].[modulo]  WITH CHECK ADD  CONSTRAINT [FK_modulo_curso] FOREIGN KEY([idCurso])
REFERENCES [dbo].[curso] ([idCurso])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_modulo_curso]') AND parent_object_id = OBJECT_ID(N'[dbo].[modulo]'))
ALTER TABLE [dbo].[modulo] CHECK CONSTRAINT [FK_modulo_curso]
GO
/****** Object:  ForeignKey [FK_notaFalta_aluno]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_notaFalta_aluno]') AND parent_object_id = OBJECT_ID(N'[dbo].[notaFalta]'))
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_aluno] FOREIGN KEY([idAluno])
REFERENCES [dbo].[aluno] ([idAluno])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_notaFalta_aluno]') AND parent_object_id = OBJECT_ID(N'[dbo].[notaFalta]'))
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_aluno]
GO
/****** Object:  ForeignKey [FK_notaFalta_modulo]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_notaFalta_modulo]') AND parent_object_id = OBJECT_ID(N'[dbo].[notaFalta]'))
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_modulo] FOREIGN KEY([idModulo])
REFERENCES [dbo].[modulo] ([idModulo])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_notaFalta_modulo]') AND parent_object_id = OBJECT_ID(N'[dbo].[notaFalta]'))
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_modulo]
GO
/****** Object:  ForeignKey [FK_notaFalta_turma]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_notaFalta_turma]') AND parent_object_id = OBJECT_ID(N'[dbo].[notaFalta]'))
ALTER TABLE [dbo].[notaFalta]  WITH CHECK ADD  CONSTRAINT [FK_notaFalta_turma] FOREIGN KEY([idTurma])
REFERENCES [dbo].[turma] ([idTurma])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_notaFalta_turma]') AND parent_object_id = OBJECT_ID(N'[dbo].[notaFalta]'))
ALTER TABLE [dbo].[notaFalta] CHECK CONSTRAINT [FK_notaFalta_turma]
GO
/****** Object:  ForeignKey [FK_responsavel_pessoa]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_responsavel_pessoa]') AND parent_object_id = OBJECT_ID(N'[dbo].[responsavel]'))
ALTER TABLE [dbo].[responsavel]  WITH CHECK ADD  CONSTRAINT [FK_responsavel_pessoa] FOREIGN KEY([idPessoa])
REFERENCES [dbo].[pessoa] ([idPessoa])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_responsavel_pessoa]') AND parent_object_id = OBJECT_ID(N'[dbo].[responsavel]'))
ALTER TABLE [dbo].[responsavel] CHECK CONSTRAINT [FK_responsavel_pessoa]
GO
/****** Object:  ForeignKey [FK_turma_curso]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_turma_curso]') AND parent_object_id = OBJECT_ID(N'[dbo].[turma]'))
ALTER TABLE [dbo].[turma]  WITH CHECK ADD  CONSTRAINT [FK_turma_curso] FOREIGN KEY([idCurso])
REFERENCES [dbo].[curso] ([idCurso])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_turma_curso]') AND parent_object_id = OBJECT_ID(N'[dbo].[turma]'))
ALTER TABLE [dbo].[turma] CHECK CONSTRAINT [FK_turma_curso]
GO
/****** Object:  ForeignKey [FK_usuario_perfil]    Script Date: 05/04/2012 20:11:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_usuario_perfil]') AND parent_object_id = OBJECT_ID(N'[dbo].[usuario]'))
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_usuario_perfil] FOREIGN KEY([idPerfil])
REFERENCES [dbo].[perfil] ([idPerfil])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_usuario_perfil]') AND parent_object_id = OBJECT_ID(N'[dbo].[usuario]'))
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_perfil]
GO
