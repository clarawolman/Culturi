USE [master]
GO
/****** Object:  Database [Culturi]    Script Date: 1/12/2025 08:29:19 ******/
CREATE DATABASE [Culturi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Culturi', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Culturi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Culturi_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Culturi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Culturi] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Culturi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Culturi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Culturi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Culturi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Culturi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Culturi] SET ARITHABORT OFF 
GO
ALTER DATABASE [Culturi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Culturi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Culturi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Culturi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Culturi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Culturi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Culturi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Culturi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Culturi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Culturi] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Culturi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Culturi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Culturi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Culturi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Culturi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Culturi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Culturi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Culturi] SET RECOVERY FULL 
GO
ALTER DATABASE [Culturi] SET  MULTI_USER 
GO
ALTER DATABASE [Culturi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Culturi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Culturi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Culturi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Culturi] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Culturi', N'ON'
GO
ALTER DATABASE [Culturi] SET QUERY_STORE = OFF
GO
USE [Culturi]
GO
/****** Object:  User [alumno]    Script Date: 1/12/2025 08:29:19 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[ChatPrivado]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatPrivado](
	[id_chat] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario1] [int] NOT NULL,
	[id_usuario2] [int] NOT NULL,
	[fecha_creacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_chat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupo]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo](
	[id_grupo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[descripcion] [text] NULL,
	[id_pais] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MensajeChatPrivado]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MensajeChatPrivado](
	[id_mensaje] [int] IDENTITY(1,1) NOT NULL,
	[id_chat] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[contenido] [text] NOT NULL,
	[fecha_envio] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_mensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mensajes]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mensajes](
	[id_mensaje] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_grupo] [int] NOT NULL,
	[contenido] [text] NOT NULL,
	[fecha_envio] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_mensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificacion]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificacion](
	[id_notificacion] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[tipo] [nvarchar](50) NOT NULL,
	[contenido] [nvarchar](50) NOT NULL,
	[leida] [bit] NOT NULL,
	[fecha] [date] NOT NULL,
 CONSTRAINT [PK_Notificacion] PRIMARY KEY CLUSTERED 
(
	[id_notificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[id_pais] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[idioma_oficial] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasoDelTramite]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasoDelTramite](
	[id_paso] [int] IDENTITY(1,1) NOT NULL,
	[id_tramite] [int] NOT NULL,
	[numero_orden] [int] NOT NULL,
	[descripcion] [text] NOT NULL,
	[documento_requerido] [varchar](255) NULL,
	[completado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_paso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProgresoTramites]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgresoTramites](
	[id_progreso] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_tramite] [int] NOT NULL,
	[estado] [varchar](20) NULL,
	[fecha_actualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_progreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tramite]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tramite](
	[id_tramite] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](150) NOT NULL,
	[descripcion] [text] NULL,
	[id_paisOrigen] [int] NULL,
	[id_paisDestino] [int] NOT NULL,
 CONSTRAINT [PK__Tramite__DC2729AEB522D0ED] PRIMARY KEY CLUSTERED 
(
	[id_tramite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[idiomaPreferencia] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[contrasena] [varchar](255) NOT NULL,
	[id_paisOrigen] [int] NOT NULL,
	[id_paisDestino] [int] NOT NULL,
	[fechaMigracion] [date] NOT NULL,
	[fechaNacimiento] [date] NOT NULL,
	[fotoperfil] [varchar](50) NULL,
 CONSTRAINT [PK__Usuario__4E3E04ADC125FD2A] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioXGrupo]    Script Date: 1/12/2025 08:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioXGrupo](
	[id_usuario] [int] NOT NULL,
	[id_grupo] [int] NOT NULL,
	[fecha_union] [date] NULL,
	[rol] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC,
	[id_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Pais] ON 

INSERT [dbo].[Pais] ([id_pais], [nombre], [idioma_oficial]) VALUES (1, N'Argentina', N'Español')
INSERT [dbo].[Pais] ([id_pais], [nombre], [idioma_oficial]) VALUES (2, N'Chile', N'Español')
INSERT [dbo].[Pais] ([id_pais], [nombre], [idioma_oficial]) VALUES (3, N'Uruguay', N'Español')
SET IDENTITY_INSERT [dbo].[Pais] OFF
GO
SET IDENTITY_INSERT [dbo].[PasoDelTramite] ON 

INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (1, 1, 1, N'hacer algo', N'nose', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (2, 1, 2, N'nhio', N'dbrth', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (3, 2, 1, N'vaer', N'avr', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (4, 2, 2, N'wvr', N'efwe', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (5, 3, 1, N'aergar', N'rga', 1)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (6, 3, 2, N'bt', N'ergae5', 0)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (7, 4, 1, N'w', N'w', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (8, 4, 2, N'e', N'e', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (9, 5, 1, N'd', N'd', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (10, 5, 2, N'd', N'd', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (11, 6, 1, N's', N's', NULL)
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido], [completado]) VALUES (12, 6, 2, N's', N's', NULL)
SET IDENTITY_INSERT [dbo].[PasoDelTramite] OFF
GO
SET IDENTITY_INSERT [dbo].[ProgresoTramites] ON 

INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (11, 2, 3, N'pendiente', CAST(N'2025-11-26T08:43:32.207' AS DateTime))
INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (12, 2, 3, N'pendiente', CAST(N'2025-11-26T08:43:35.020' AS DateTime))
INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (13, 2, 3, N'pendiente', CAST(N'2025-11-26T08:43:36.640' AS DateTime))
INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (14, 1, 3, N'pendiente', CAST(N'2025-11-26T09:03:52.180' AS DateTime))
INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (16, 4, 3, N'pendiente', CAST(N'2025-12-01T08:18:00.237' AS DateTime))
SET IDENTITY_INSERT [dbo].[ProgresoTramites] OFF
GO
SET IDENTITY_INSERT [dbo].[Tramite] ON 

INSERT [dbo].[Tramite] ([id_tramite], [titulo], [descripcion], [id_paisOrigen], [id_paisDestino]) VALUES (1, N'Permanencia', N'Permiso de permanencia', 1, 2)
INSERT [dbo].[Tramite] ([id_tramite], [titulo], [descripcion], [id_paisOrigen], [id_paisDestino]) VALUES (2, N'DNI', N'Obtener DNI', 1, 3)
INSERT [dbo].[Tramite] ([id_tramite], [titulo], [descripcion], [id_paisOrigen], [id_paisDestino]) VALUES (3, N'Cuenta bancaria', N'Apertura de cuenta bancaria', 2, 1)
INSERT [dbo].[Tramite] ([id_tramite], [titulo], [descripcion], [id_paisOrigen], [id_paisDestino]) VALUES (4, N'CUIT', N'Obtencion del CUIT', 2, 3)
INSERT [dbo].[Tramite] ([id_tramite], [titulo], [descripcion], [id_paisOrigen], [id_paisDestino]) VALUES (5, N'Salud', N'Inscrpción al sistema de salud', 3, 1)
INSERT [dbo].[Tramite] ([id_tramite], [titulo], [descripcion], [id_paisOrigen], [id_paisDestino]) VALUES (6, N'Estudios', N'Validación de estudios', 3, 2)
SET IDENTITY_INSERT [dbo].[Tramite] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([id_usuario], [nombre], [usuario], [idiomaPreferencia], [email], [contrasena], [id_paisOrigen], [id_paisDestino], [fechaMigracion], [fechaNacimiento], [fotoperfil]) VALUES (1, N'luciana kampel', N'lukampel', N'Español', N'lu@gmail.com', N'lu', 2, 1, CAST(N'2025-11-11' AS Date), CAST(N'2024-05-09' AS Date), NULL)
INSERT [dbo].[Usuario] ([id_usuario], [nombre], [usuario], [idiomaPreferencia], [email], [contrasena], [id_paisOrigen], [id_paisDestino], [fechaMigracion], [fechaNacimiento], [fotoperfil]) VALUES (2, N'clara', N'claraw', N'Español', N'ceh@kgeo', N'123', 2, 1, CAST(N'2025-11-22' AS Date), CAST(N'2025-11-11' AS Date), NULL)
INSERT [dbo].[Usuario] ([id_usuario], [nombre], [usuario], [idiomaPreferencia], [email], [contrasena], [id_paisOrigen], [id_paisDestino], [fechaMigracion], [fechaNacimiento], [fotoperfil]) VALUES (3, N'augusto perez', N'augustopr', N'Español', N'augusto@gmail', N'ogi', 2, 1, CAST(N'2025-12-11' AS Date), CAST(N'2025-12-11' AS Date), NULL)
INSERT [dbo].[Usuario] ([id_usuario], [nombre], [usuario], [idiomaPreferencia], [email], [contrasena], [id_paisOrigen], [id_paisDestino], [fechaMigracion], [fechaNacimiento], [fotoperfil]) VALUES (4, N'clara', N'clara', N'Español', N'augusto@gmail.com', N'12', 2, 1, CAST(N'2025-12-30' AS Date), CAST(N'2025-12-09' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__AB6E61643C473938]    Script Date: 1/12/2025 08:29:19 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ__Usuario__AB6E61643C473938] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChatPrivado] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[MensajeChatPrivado] ADD  DEFAULT (getdate()) FOR [fecha_envio]
GO
ALTER TABLE [dbo].[Mensajes] ADD  DEFAULT (getdate()) FOR [fecha_envio]
GO
ALTER TABLE [dbo].[PasoDelTramite] ADD  DEFAULT ((0)) FOR [completado]
GO
ALTER TABLE [dbo].[ProgresoTramites] ADD  DEFAULT (getdate()) FOR [fecha_actualizacion]
GO
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [DF__Usuario__fecha_r__5535A963]  DEFAULT (getdate()) FOR [fechaNacimiento]
GO
ALTER TABLE [dbo].[UsuarioXGrupo] ADD  DEFAULT (getdate()) FOR [fecha_union]
GO
ALTER TABLE [dbo].[Grupo]  WITH CHECK ADD  CONSTRAINT [FK__Grupo__id_pais__571DF1D5] FOREIGN KEY([id_pais])
REFERENCES [dbo].[Pais] ([id_pais])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Grupo] CHECK CONSTRAINT [FK__Grupo__id_pais__571DF1D5]
GO
ALTER TABLE [dbo].[MensajeChatPrivado]  WITH CHECK ADD  CONSTRAINT [FK__MensajeCh__id_ch__5812160E] FOREIGN KEY([id_chat])
REFERENCES [dbo].[ChatPrivado] ([id_chat])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MensajeChatPrivado] CHECK CONSTRAINT [FK__MensajeCh__id_ch__5812160E]
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK__Mensajes__id_usu__59FA5E80] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK__Mensajes__id_usu__59FA5E80]
GO
ALTER TABLE [dbo].[PasoDelTramite]  WITH CHECK ADD  CONSTRAINT [FK_PasoDelTramite_Tramite] FOREIGN KEY([id_tramite])
REFERENCES [dbo].[Tramite] ([id_tramite])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PasoDelTramite] CHECK CONSTRAINT [FK_PasoDelTramite_Tramite]
GO
ALTER TABLE [dbo].[ProgresoTramites]  WITH CHECK ADD  CONSTRAINT [FK_ProgresoTramites_Tramite] FOREIGN KEY([id_tramite])
REFERENCES [dbo].[Tramite] ([id_tramite])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProgresoTramites] CHECK CONSTRAINT [FK_ProgresoTramites_Tramite]
GO
ALTER TABLE [dbo].[ProgresoTramites]  WITH CHECK ADD  CONSTRAINT [FK_ProgresoTramites_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProgresoTramites] CHECK CONSTRAINT [FK_ProgresoTramites_Usuario]
GO
ALTER TABLE [dbo].[UsuarioXGrupo]  WITH CHECK ADD  CONSTRAINT [FK__UsuarioXG__id_gr__60A75C0F] FOREIGN KEY([id_grupo])
REFERENCES [dbo].[Grupo] ([id_grupo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsuarioXGrupo] CHECK CONSTRAINT [FK__UsuarioXG__id_gr__60A75C0F]
GO
ALTER TABLE [dbo].[UsuarioXGrupo]  WITH CHECK ADD  CONSTRAINT [FK__UsuarioXG__id_us__619B8048] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsuarioXGrupo] CHECK CONSTRAINT [FK__UsuarioXG__id_us__619B8048]
GO
ALTER TABLE [dbo].[ProgresoTramites]  WITH CHECK ADD CHECK  (([estado]='completado' OR [estado]='en proceso' OR [estado]='pendiente'))
GO
ALTER TABLE [dbo].[UsuarioXGrupo]  WITH CHECK ADD CHECK  (([rol]='moderador' OR [rol]='miembro' OR [rol]='admin'))
GO
USE [master]
GO
ALTER DATABASE [Culturi] SET  READ_WRITE 

--- CAMBIOS CLARA 28/11
USE [Culturi]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE name = 'Juego')
BEGIN
    CREATE TABLE Juego(
        id_juego INT IDENTITY(1,1) PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        tipo VARCHAR(50) NULL,
        descripcion TEXT NULL
    );
END
IF NOT EXISTS (SELECT * FROM sys.objects WHERE name = 'Nivel')
BEGIN
    CREATE TABLE Nivel(
        id_nivel INT IDENTITY(1,1) PRIMARY KEY,
        id_juego INT NOT NULL,
        numero_nivel INT NOT NULL,
        descripcion TEXT NULL,
        dificultad VARCHAR(20) NULL,
        FOREIGN KEY (id_juego) REFERENCES Juego(id_juego)
    );
END
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE name = 'CartaMemotest')
BEGIN
    CREATE TABLE CartaMemotest (
        id_carta INT IDENTITY(1,1) PRIMARY KEY,
        id_nivel INT NOT NULL,
        id_pais INT NOT NULL,
        imagen VARCHAR(200) NOT NULL,
        numero_par INT NOT NULL,

        FOREIGN KEY (id_nivel) REFERENCES Nivel(id_nivel) ON DELETE CASCADE,
        FOREIGN KEY (id_pais) REFERENCES Pais(id_pais) ON DELETE CASCADE
    );
END

-- las cartas que traes: WHERE id_nivel = X AND id_pais = usuario.id_paisDestino
-- ¿Dónde cargar las imágenes?
	-- Las rutas en CartaMemotest.imagen pueden ser:
	-- /img/memotest/n1/p1a.png
	-- /img/memotest/n1/p1b.png
	-- Las guardás a mano con inserts.

IF NOT EXISTS (SELECT * FROM sys.objects WHERE name = 'ProgresoMemotest')
BEGIN
    CREATE TABLE ProgresoMemotest (
        id_usuario INT NOT NULL,
        id_nivel INT NOT NULL,
        completado BIT NOT NULL DEFAULT 0,
        fecha_completado DATETIME NULL,

        PRIMARY KEY(id_usuario, id_nivel),

        FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
        FOREIGN KEY (id_nivel) REFERENCES Nivel(id_nivel) ON DELETE CASCADE
    );
END

DECLARE @idMemotest INT;

SELECT @idMemotest = id_juego
FROM Juego
WHERE nombre = 'Memotest';

IF @idMemotest IS NULL
BEGIN
    INSERT INTO Juego (nombre, tipo, descripcion)
    VALUES ('Memotest', 'cultura e idioma', 'Juego de memoria cultural por niveles.');

    SET @idMemotest = SCOPE_IDENTITY();
END
DECLARE @Nivel1 INT, @Nivel2 INT, @Nivel3 INT;

-- Nivel 1
IF NOT EXISTS (SELECT 1 FROM Nivel WHERE id_juego = @idMemotest AND numero_nivel = 1)
BEGIN
    INSERT INTO Nivel (id_juego, numero_nivel, descripcion, dificultad)
    VALUES (@idMemotest, 1, 'Nivel 1', 'básico');
END

-- Nivel 2
IF NOT EXISTS (SELECT 1 FROM Nivel WHERE id_juego = @idMemotest AND numero_nivel = 2)
BEGIN
    INSERT INTO Nivel (id_juego, numero_nivel, descripcion, dificultad)
    VALUES (@idMemotest, 2, 'Nivel 2', 'intermedio');
END

-- Nivel 3
IF NOT EXISTS (SELECT 1 FROM Nivel WHERE id_juego = @idMemotest AND numero_nivel = 3)
BEGIN
    INSERT INTO Nivel (id_juego, numero_nivel, descripcion, dificultad)
    VALUES (@idMemotest, 3, 'Nivel 3', 'avanzado');
END

-- Obtener los 3 IDs reales
SELECT 
    @Nivel1 = (SELECT id_nivel FROM Nivel WHERE id_juego = @idMemotest AND numero_nivel = 1),
    @Nivel2 = (SELECT id_nivel FROM Nivel WHERE id_juego = @idMemotest AND numero_nivel = 2),
    @Nivel3 = (SELECT id_nivel FROM Nivel WHERE id_juego = @idMemotest AND numero_nivel = 3);

DECLARE @PaisDestino INT = 1; -- Argentina
-- Nivel 1
IF NOT EXISTS (SELECT 1 FROM CartaMemotest WHERE id_nivel = @Nivel1)
BEGIN
    INSERT INTO CartaMemotest (id_nivel, id_pais, imagen, numero_par)
    VALUES
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p1a.png', 1),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p1b.png', 1),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p2a.png', 2),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p2b.png', 2),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p3a.png', 3),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p3b.png', 3),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p4a.png', 4),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p4b.png', 4),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p5a.png', 5),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p5b.png', 5),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p6a.png', 6),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p6b.png', 6),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p7a.png', 7),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p7b.png', 7),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p8a.png', 8),
    (@Nivel1, @PaisDestino, '/img/memotest/n1_p8b.png', 8);
END
-- Nivel 2
IF NOT EXISTS (SELECT 1 FROM CartaMemotest WHERE id_nivel = @Nivel2)
BEGIN
    INSERT INTO CartaMemotest (id_nivel, id_pais, imagen, numero_par)
    VALUES
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p1a.png', 1),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p1b.png', 1),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p2a.png', 2),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p2b.png', 2),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p3a.png', 3),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p3b.png', 3),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p4a.png', 4),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p4b.png', 4),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p5a.png', 5),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p5b.png', 5),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p6a.png', 6),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p6b.png', 6),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p7a.png', 7),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p7b.png', 7),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p8a.png', 8),
    (@Nivel2, @PaisDestino, '/img/memotest/n2_p8b.png', 8);
END

GO
CREATE TABLE OracionJuego (
    id_oracion INT IDENTITY(1,1) PRIMARY KEY,
    id_pais INT NOT NULL,          -- CLAVE
    nivel INT NOT NULL,
    texto NVARCHAR(500) NOT NULL,  -- "Hola, me llamo ___"
    orden INT NOT NULL,            -- orden dentro del nivel
    FOREIGN KEY(id_pais) REFERENCES Pais(id_pais)
);
CREATE TABLE OracionOpcion (
    id_opcion INT IDENTITY(1,1) PRIMARY KEY,
    id_oracion INT NOT NULL,
    texto NVARCHAR(200) NOT NULL,
    es_correcta BIT NOT NULL,
    FOREIGN KEY(id_oracion) REFERENCES OracionJuego(id_oracion)
);

INSERT INTO OracionJuego (id_pais, nivel, texto, orden) VALUES
(1, 1, 'Hola, me llamo ___', 1),
(1, 1, 'Yo ___ de otro país', 2),
(1, 1, '¡Un ___ conocerte!', 3),
(1, 1, 'Tengo 29 ___', 4),
(1, 1, 'Hablo un poco de ___', 5);

-- 1) Hola, me llamo ___
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(1, 'Clara', 1),
(1, 'rojo', 0),
(1, 'bondi', 0);

-- 2) Soy de ___
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(2, 'soy', 1),
(2, 'es', 0),
(2, 'estoy', 0);

-- 3) ¡Un ___ conocerte!
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(3, 'camino', 0),
(3, 'placer', 1),
(3, 'amigo', 0);

-- 4) Tengo 29 ___ 
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(4, 'hora', 0),
(4, 'estudio', 0),
(4, 'años', 1);

-- 5) Hablo un poco de ___
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(5, 'español', 1),
(5, 'bueno', 0),
(5, 'laburo', 0);

INSERT INTO OracionJuego (id_pais, nivel, texto, orden) VALUES
(1, 2, 'Tengo que tomar el ___ para ir a la escuela', 1),
(1, 2, 'Voy al ___ a comprar comida', 2),
(1, 2, 'Hace mucho ___ hoy', 3),
(1, 2, '¿Cuánto sale ___?', 4),
(1, 2, 'Estoy muy ___, trabajé todo el día', 5);

-- 1) Tengo que tomar el ___
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(6, 'bondi', 1),
(6, 'casco', 0),
(6, 'joda', 0);

-- 2) Voy al ___ a comprar comida
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(7, 'supermercado', 1),
(7, 'estudio', 0),
(7, 'comprador', 0);

-- 3) Hace mucho ___ hoy
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(8, 'música', 0),
(8, 'invierno', 0),
(8, 'calor', 1);

-- 4) ¿Cuánto sale ___?
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(9, 'casa', 0),
(9, 'esto', 1),
(9, 'lugar', 0);

-- 5) Estoy muy ___, trabajé todo el día
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(10, 'estado', 0),
(10, 'laburo', 0),
(10, 'cansado', 1);

INSERT INTO OracionJuego (id_pais, nivel, texto, orden) VALUES
(1, 3, 'Necesito ___ en el trámite', 1),
(1, 3, 'Mi ___ (mamá) se siente mal', 2),
(1, 3, 'Debo sacar un ___ para hacer este trámite', 3),
(1, 3, 'Hoy ___ que ir a la oficina de Migraciones', 4),
(1, 3, 'Debo pagar el ___ antes de la fecha', 5);

-- 1) Necesito presentar mi ___
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(11, 'cargar el futuro', 0),
(11, 'presentar la ropa', 0),
(11, 'presentar mi DNI', 1);

-- 2) Mi ___ se siente mal
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(12, 'boludo', 0),
(12, 'vieja', 1),
(12, 'mesa', 0);

-- 3) Debo sacar un ___
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(13, 'joda', 0),
(13, 'che', 0),
(13, 'turno', 1);

-- 4) Hoy ___ que ir a la oficina de Migraciones
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(14, 'suelo', 0),
(14, 'tengo', 1),
(14, 'tomo', 0);

-- 5) Debo pagar el ___
INSERT INTO OracionOpcion (id_oracion, texto, es_correcta) VALUES
(15, 'impuesto', 1),
(15, 'tango', 0),
(15, 'empanada', 0);
