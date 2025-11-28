USE [master]
GO
/****** Object:  Database [Culturi]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  User [alumno]    Script Date: 26/11/2025 09:06:39 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[ChatPrivado]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[Grupo]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[MensajeChatPrivado]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[Mensajes]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[Notificacion]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[Pais]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[PasoDelTramite]    Script Date: 26/11/2025 09:06:39 ******/
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
PRIMARY KEY CLUSTERED 
(
	[id_paso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ProgresoTramites]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[Tramite]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 26/11/2025 09:06:39 ******/
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
/****** Object:  Table [dbo].[UsuarioXGrupo]    Script Date: 26/11/2025 09:06:39 ******/
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

INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (1, 1, 1, N'hacer algo', N'nose')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (2, 1, 2, N'nhio', N'dbrth')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (3, 2, 1, N'vaer', N'avr')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (4, 2, 2, N'wvr', N'efwe')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (5, 3, 1, N'aergar', N'rga')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (6, 3, 2, N'bt', N'ergae5')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (7, 4, 1, N'w', N'w')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (8, 4, 2, N'e', N'e')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (9, 5, 1, N'd', N'd')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (10, 5, 2, N'd', N'd')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (11, 6, 1, N's', N's')
INSERT [dbo].[PasoDelTramite] ([id_paso], [id_tramite], [numero_orden], [descripcion], [documento_requerido]) VALUES (12, 6, 2, N's', N's')
SET IDENTITY_INSERT [dbo].[PasoDelTramite] OFF
GO
SET IDENTITY_INSERT [dbo].[ProgresoTramites] ON 

INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (11, 2, 3, N'pendiente', CAST(N'2025-11-26T08:43:32.207' AS DateTime))
INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (12, 2, 3, N'pendiente', CAST(N'2025-11-26T08:43:35.020' AS DateTime))
INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (13, 2, 3, N'pendiente', CAST(N'2025-11-26T08:43:36.640' AS DateTime))
INSERT [dbo].[ProgresoTramites] ([id_progreso], [id_usuario], [id_tramite], [estado], [fecha_actualizacion]) VALUES (14, 1, 3, N'pendiente', CAST(N'2025-11-26T09:03:52.180' AS DateTime))
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
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__AB6E61643C473938]    Script Date: 26/11/2025 09:06:39 ******/
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
GO

--- CAMBIOS CLARA 28/11
CREATE TABLE CartaMemotest (
    id_carta INT IDENTITY(1,1) PRIMARY KEY,
    id_nivel INT NOT NULL,
    id_pais INT NOT NULL,
    imagen VARCHAR(200) NOT NULL,  -- ruta/archivo de la carta
    numero_par INT NOT NULL        -- del 1 al 8, para armar los pares

    FOREIGN KEY (id_nivel) REFERENCES Nivel(id_nivel) ON DELETE CASCADE,
    FOREIGN KEY (id_pais) REFERENCES Pais(id_pais) ON DELETE CASCADE
);
-- las cartas que traes: WHERE id_nivel = X AND id_pais = usuario.id_paisDestino
-- ¿Dónde cargar las imágenes?
	-- Las rutas en CartaMemotest.imagen pueden ser:
	-- /img/memotest/n1/p1a.png
	-- /img/memotest/n1/p1b.png
	-- Las guardás a mano con inserts.

CREATE TABLE ProgresoMemotest (
    id_usuario INT NOT NULL,
    id_nivel INT NOT NULL,
    completado BIT NOT NULL DEFAULT 0,
    fecha_completado DATETIME NULL,

    PRIMARY KEY(id_usuario, id_nivel),

    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_nivel) REFERENCES Nivel(id_nivel) ON DELETE CASCADE
);

CREATE TABLE JuegoNivelPais (
    id_juego INT NOT NULL,
    id_nivel INT NOT NULL,
    id_pais INT NOT NULL,
    descripcion VARCHAR(255) NULL,

    PRIMARY KEY(id_juego, id_nivel, id_pais),

    FOREIGN KEY(id_juego) REFERENCES Juego(id_juego),
    FOREIGN KEY(id_nivel) REFERENCES Nivel(id_nivel),
    FOREIGN KEY(id_pais) REFERENCES Pais(id_pais)
);

INSERT INTO Juego (nombre, tipo, descripcion)
VALUES ('Memotest', 'cultura e idioma', 'Juego de memoria y relación, para entender conceptos, situaciones y palabras!');
SELECT SCOPE_IDENTITY() AS id_memotest;
DECLARE @idMemotest INT = 1;  -- reemplazar por el real si es distinto
-- Nivel 1
INSERT INTO Nivel (id_juego, numero_nivel, descripcion, dificultad)
VALUES (@idMemotest, 1, 'Nivel 1: ', 'básico');

-- Nivel 2
INSERT INTO Nivel (id_juego, numero_nivel, descripcion, dificultad)
VALUES (@idMemotest, 2, 'Nivel 2: ', 'intermedio');

-- Nivel 3
INSERT INTO Nivel (id_juego, numero_nivel, descripcion, dificultad)
VALUES (@idMemotest, 3, 'Nivel 3: ', 'avanzado');

SELECT id_nivel, numero_nivel 
FROM Nivel 
WHERE id_juego = @idMemotest;
DECLARE @idNivel1 INT = 10; --cambiar dsp estos ids
DECLARE @idPais INT = 1;

INSERT INTO CartaMemotest (id_nivel, id_pais, imagen, numero_par)
VALUES
(@idNivel1, @idPais, '/img/memotest/n1/par1a.png', 1),
(@idNivel1, @idPais, '/img/memotest/n1/par1b.png', 1),

(@idNivel1, @idPais, '/img/memotest/n1/par2a.png', 2),
(@idNivel1, @idPais, '/img/memotest/n1/par2b.png', 2),

(@idNivel1, @idPais, '/img/memotest/n1/par3a.png', 3),
(@idNivel1, @idPais, '/img/memotest/n1/par3b.png', 3),

(@idNivel1, @idPais, '/img/memotest/n1/par4a.png', 4),
(@idNivel1, @idPais, '/img/memotest/n1/par4b.png', 4),

(@idNivel1, @idPais, '/img/memotest/n1/par5a.png', 5),
(@idNivel1, @idPais, '/img/memotest/n1/par5b.png', 5),

(@idNivel1, @idPais, '/img/memotest/n1/par6a.png', 6),
(@idNivel1, @idPais, '/img/memotest/n1/par6b.png', 6),

(@idNivel1, @idPais, '/img/memotest/n1/par7a.png', 7),
(@idNivel1, @idPais, '/img/memotest/n1/par7b.png', 7),

(@idNivel1, @idPais, '/img/memotest/n1/par8a.png', 8),
(@idNivel1, @idPais, '/img/memotest/n1/par8b.png', 8);

DECLARE @idNivel2 INT = 11;

INSERT INTO CartaMemotest (id_nivel, id_pais, imagen, numero_par)
VALUES
(@idNivel2, @idPais, '/img/memotest/n2/par1a.png', 1),
(@idNivel2, @idPais, '/img/memotest/n2/par1b.png', 1),

(@idNivel2, @idPais, '/img/memotest/n2/par2a.png', 2),
(@idNivel2, @idPais, '/img/memotest/n2/par2b.png', 2),

(@idNivel2, @idPais, '/img/memotest/n2/par3a.png', 3),
(@idNivel2, @idPais, '/img/memotest/n2/par3b.png', 3),

(@idNivel2, @idPais, '/img/memotest/n2/par4a.png', 4),
(@idNivel2, @idPais, '/img/memotest/n2/par4b.png', 4),

(@idNivel2, @idPais, '/img/memotest/n2/par5a.png', 5),
(@idNivel2, @idPais, '/img/memotest/n2/par5b.png', 5),

(@idNivel2, @idPais, '/img/memotest/n2/par6a.png', 6),
(@idNivel2, @idPais, '/img/memotest/n2/par6b.png', 6),

(@idNivel2, @idPais, '/img/memotest/n2/par7a.png', 7),
(@idNivel2, @idPais, '/img/memotest/n2/par7b.png', 7),

(@idNivel2, @idPais, '/img/memotest/n2/par8a.png', 8),
(@idNivel2, @idPais, '/img/memotest/n2/par8b.png', 8);

DECLARE @idNivel3 INT = 12;

INSERT INTO CartaMemotest (id_nivel, id_pais, imagen, numero_par)
VALUES
(@idNivel3, @idPais, '/img/memotest/n3/par1a.png', 1),
(@idNivel3, @idPais, '/img/memotest/n3/par1b.png', 1),

(@idNivel3, @idPais, '/img/memotest/n3/par2a.png', 2),
(@idNivel3, @idPais, '/img/memotest/n3/par2b.png', 2),

(@idNivel3, @idPais, '/img/memotest/n3/par3a.png', 3),
(@idNivel3, @idPais, '/img/memotest/n3/par3b.png', 3),

(@idNivel3, @idPais, '/img/memotest/n3/par4a.png', 4),
(@idNivel3, @idPais, '/img/memotest/n3/par4b.png', 4),

(@idNivel3, @idPais, '/img/memotest/n3/par5a.png', 5),
(@idNivel3, @idPais, '/img/memotest/n3/par5b.png', 5),

(@idNivel3, @idPais, '/img/memotest/n3/par6a.png', 6),
(@idNivel3, @idPais, '/img/memotest/n3/par6b.png', 6),

(@idNivel3, @idPais, '/img/memotest/n3/par7a.png', 7),
(@idNivel3, @idPais, '/img/memotest/n3/par7b.png', 7),

(@idNivel3, @idPais, '/img/memotest/n3/par8a.png', 8),
(@idNivel3, @idPais, '/img/memotest/n3/par8b.png', 8);
