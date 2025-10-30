USE [master]
GO
/****** Object:  Database [Culturi]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  User [alumno]    Script Date: 30/10/2025 13:45:47 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[ChatPrivado]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[Grupo]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[Juego]    Script Date: 30/10/2025 13:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Juego](
	[id_juego] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[tipo] [varchar](50) NULL,
	[descripcion] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_juego] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MensajeChatPrivado]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[Mensajes]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[Nivel]    Script Date: 30/10/2025 13:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nivel](
	[id_nivel] [int] IDENTITY(1,1) NOT NULL,
	[id_juego] [int] NOT NULL,
	[numero_nivel] [int] NOT NULL,
	[descripcion] [text] NULL,
	[dificultad] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_nivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificacion]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[Pais]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[PasoDelTramite]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[PreguntaJuego]    Script Date: 30/10/2025 13:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreguntaJuego](
	[id_pregunta] [int] IDENTITY(1,1) NOT NULL,
	[id_nivel] [int] NOT NULL,
	[enunciado] [text] NOT NULL,
	[opcion_a] [varchar](255) NOT NULL,
	[opcion_b] [varchar](255) NOT NULL,
	[opcion_c] [varchar](255) NOT NULL,
	[opcion_d] [varchar](255) NOT NULL,
	[respuesta_correcta] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pregunta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProgresoTramites]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[Tramite]    Script Date: 30/10/2025 13:45:47 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 30/10/2025 13:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[idiomaPreferencia] [nchar](10) NULL,
	[email] [varchar](100) NOT NULL,
	[contrasena] [varchar](255) NOT NULL,
	[id_paisOrigen] [nchar](10) NULL,
	[id_paisDestino] [int] NOT NULL,
	[fechaMigracion] [nchar](10) NULL,
	[fechaNacimiento] [date] NOT NULL,
 CONSTRAINT [PK__Usuario__4E3E04ADC125FD2A] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioJuego]    Script Date: 30/10/2025 13:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioJuego](
	[id_usuario] [int] NOT NULL,
	[id_juego] [int] NOT NULL,
	[puntaje] [int] NOT NULL,
	[fecha] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioXGrupo]    Script Date: 30/10/2025 13:45:47 ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__AB6E61643C473938]    Script Date: 30/10/2025 13:45:47 ******/
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
ALTER TABLE [dbo].[Grupo]  WITH CHECK ADD FOREIGN KEY([id_pais])
REFERENCES [dbo].[Pais] ([id_pais])
GO
ALTER TABLE [dbo].[MensajeChatPrivado]  WITH CHECK ADD FOREIGN KEY([id_chat])
REFERENCES [dbo].[ChatPrivado] ([id_chat])
GO
ALTER TABLE [dbo].[Mensajes]  WITH CHECK ADD  CONSTRAINT [FK__Mensajes__id_usu__59FA5E80] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Mensajes] CHECK CONSTRAINT [FK__Mensajes__id_usu__59FA5E80]
GO
ALTER TABLE [dbo].[Nivel]  WITH CHECK ADD FOREIGN KEY([id_juego])
REFERENCES [dbo].[Juego] ([id_juego])
GO
ALTER TABLE [dbo].[PasoDelTramite]  WITH CHECK ADD  CONSTRAINT [FK_PasoDelTramite_Tramite] FOREIGN KEY([id_tramite])
REFERENCES [dbo].[Tramite] ([id_tramite])
GO
ALTER TABLE [dbo].[PasoDelTramite] CHECK CONSTRAINT [FK_PasoDelTramite_Tramite]
GO
ALTER TABLE [dbo].[PreguntaJuego]  WITH CHECK ADD FOREIGN KEY([id_nivel])
REFERENCES [dbo].[Nivel] ([id_nivel])
GO
ALTER TABLE [dbo].[ProgresoTramites]  WITH CHECK ADD  CONSTRAINT [FK_ProgresoTramites_Tramite] FOREIGN KEY([id_tramite])
REFERENCES [dbo].[Tramite] ([id_tramite])
GO
ALTER TABLE [dbo].[ProgresoTramites] CHECK CONSTRAINT [FK_ProgresoTramites_Tramite]
GO
ALTER TABLE [dbo].[ProgresoTramites]  WITH CHECK ADD  CONSTRAINT [FK_ProgresoTramites_Usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[ProgresoTramites] CHECK CONSTRAINT [FK_ProgresoTramites_Usuario]
GO
ALTER TABLE [dbo].[Tramite]  WITH CHECK ADD  CONSTRAINT [FK_Tramite_Pais] FOREIGN KEY([id_paisOrigen])
REFERENCES [dbo].[Pais] ([id_pais])
GO
ALTER TABLE [dbo].[Tramite] CHECK CONSTRAINT [FK_Tramite_Pais]
GO
ALTER TABLE [dbo].[Tramite]  WITH CHECK ADD  CONSTRAINT [FK_Tramite_Pais1] FOREIGN KEY([id_paisDestino])
REFERENCES [dbo].[Pais] ([id_pais])
GO
ALTER TABLE [dbo].[Tramite] CHECK CONSTRAINT [FK_Tramite_Pais1]
GO
ALTER TABLE [dbo].[UsuarioXGrupo]  WITH CHECK ADD FOREIGN KEY([id_grupo])
REFERENCES [dbo].[Grupo] ([id_grupo])
GO
ALTER TABLE [dbo].[UsuarioXGrupo]  WITH CHECK ADD  CONSTRAINT [FK__UsuarioXG__id_us__619B8048] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[UsuarioXGrupo] CHECK CONSTRAINT [FK__UsuarioXG__id_us__619B8048]
GO
ALTER TABLE [dbo].[Juego]  WITH CHECK ADD CHECK  (([tipo]='idioma' OR [tipo]='cultura'))
GO
ALTER TABLE [dbo].[Nivel]  WITH CHECK ADD CHECK  (([dificultad]='avanzado' OR [dificultad]='intermedio' OR [dificultad]='básico'))
GO
ALTER TABLE [dbo].[PreguntaJuego]  WITH CHECK ADD CHECK  (([respuesta_correcta]='D' OR [respuesta_correcta]='C' OR [respuesta_correcta]='B' OR [respuesta_correcta]='A'))
GO
ALTER TABLE [dbo].[ProgresoTramites]  WITH CHECK ADD CHECK  (([estado]='completado' OR [estado]='en proceso' OR [estado]='pendiente'))
GO
ALTER TABLE [dbo].[UsuarioXGrupo]  WITH CHECK ADD CHECK  (([rol]='moderador' OR [rol]='miembro' OR [rol]='admin'))
GO
USE [master]
GO
ALTER DATABASE [Culturi] SET  READ_WRITE 
GO

