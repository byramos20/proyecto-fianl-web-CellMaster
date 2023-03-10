USE master
GO
CREATE DATABASE CELLMASTER
GO
USE CellMaster
GO 
CREATE TABLE [dbo].[Formularios]
(
[IdFormulario] [INT] PRIMARY KEY NOT NULL IDENTITY(1, 1),
[NombreFormulario] [VARCHAR] (100)  NOT NULL,
[Activo] [BIT] NOT NULL,
[Usuarioregistro] [INT] NOT NULL,
[Fecharegistro] [DATETIME] NOT NULL,
[Usuarioactualiza] [INT] NULL,
[Fechaactualiza] [DATETIME] NULL
)
GO
CREATE TABLE [dbo].[Roll]
(
[IdRol] [INT] PRIMARY KEY NOT NULL IDENTITY(1, 1),
[NombreRol] [VARCHAR] (50)  NOT NULL,
[Descripcion] [VARCHAR] (150)  NOT NULL,
[Activo] [BIT] NOT NULL
)
GO
CREATE TABLE [dbo].[RolFormularios]
(
[IdRolFormulario] [INT] PRIMARY KEY NOT NULL IDENTITY(1, 1),
[IdRol] [INT] FOREIGN KEY REFERENCES Rol(IdRol) NOT NULL,
[IdFormulario] [INT] FOREIGN KEY REFERENCES Formulario(IdFormulario) NOT NULL,
[Escribir] [BIT] NOT NULL,
[Anular] [BIT] NOT NULL,
[FinalizarSolicitud] [BIT] NOT NULL,
[Activo] [BIT] NOT NULL,
[UsuarioRegistra] [INT] NOT NULL,
[FechaRegistro] [DATETIME] NOT NULL,
[UsuarioActualiza] [INT] NULL,
[FechaActualizacion] [DATETIME] NULL
)
GO
CREATE TABLE [dbo].[Usuarios ]
(
[IdUsuario] [INT] PRIMARY KEY NOT NULL IDENTITY(1, 1),
[Nombre] [VARCHAR] (250)  NOT NULL,
[Login] [VARCHAR] (20)  NOT NULL,
[Password] [varbinary] (250) NOT NULL,
[Email] [VARCHAR] (50)  NULL,
[Cargo] [VARCHAR] (100)  NULL,
[IdRol] [INT] NOT NULL,
[Intentos] [INT] NOT NULL,
[Bloqueado] [BIT] NOT NULL,
[Baja] [BIT] NOT NULL,
[Activo] [BIT] NOT NULL,
[UsuarioRegistro] [INT] NOT NULL,
[FechaRegistro] [DATETIME] NOT NULL,
[UsuarioActualiza] [INT] NULL,
[FechaActualiza] [DATETIME] NULL
)
GO
CREATE TABLE [dbo].[Parametro]
(
[IdParametro] [INT] PRIMARY KEY NOT NULL IDENTITY(1, 1),
[Descripcion] [VARCHAR] (50)  NOT NULL,
[Parametro] [VARCHAR] (50)  NOT NULL,
[TipoDato] [VARCHAR] (50)  NOT NULL,
[Activo] [BIT] NOT NULL,
[Fecharegistro] [DATETIME] NOT NULL,
[Usuarioregistro] [INT] NOT NULL,
[Fechaactualiza] [DATETIME] NULL,
[Usuarioactualiza] [INT] NULL
)
GO
CREATE TABLE UnidadesMedida (
	IdUnidadMedida INT PRIMARY KEY IDENTITY (1, 1)
   ,Descripcion VARCHAR(200) NOT NULL
   ,
	--Pistas de Auditoria
	IdUsuarioRegistro INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
   ,Activo BIT NOT NULL
)
GO
CREATE TABLE Producto (
	IdProducto INT PRIMARY KEY IDENTITY (1, 1)
   ,IdUnidadMedida INT FOREIGN KEY REFERENCES UnidadesMedidas (IdUnidadMedida)
   ,CodigoBarra INT NOT NULL
   ,Descripcion VARCHAR(200) NOT NULL
   ,PrecioUnitario DECIMAL(18, 2) NOT NULL
   ,PorcentajeUtilidad DECIMAL(18, 2) NOT NULL
   ,PorcentajeDescuento DECIMAL(18, 2) NOT NULL
   ,
	--Pistas de Auditoria
	IdUsuarioRegistro INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
   ,Activo BIT NOT NULL
)
GO
CREATE TABLE Inventarios (
	IdInventario INT PRIMARY KEY IDENTITY (1, 1)
   ,IdProducto INT FOREIGN KEY REFERENCES Productos (IdProducto)
   ,Lote INT NOT NULL
   ,Cantidad INT NOT NULL
   ,FechaCaducidad DATETIME NOT NULL
   ,
	--Pistas de Auditoria
	IdUsuarioRegistro INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
   ,Activo BIT NOT NULL
)
GO
CREATE TABLE Cliente (
	IdCliente INT PRIMARY KEY IDENTITY (1, 1)
   ,NombreCompleto VARCHAR(200) NOT NULL
   ,Identificacion VARCHAR(200) NOT NULL
   ,Celular VARCHAR(8) NULL
   ,Correo VARCHAR(200) NULL
   ,
	--Pistas de Auditoria
	IdUsuarioRegistro INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
   ,Activo BIT NOT NULL
)
GO
CREATE TABLE Fac (
	IdFactura INT PRIMARY KEY IDENTITY (1, 1)
   ,IdCliente INT FOREIGN KEY REFERENCES Clientes (IdCliente)
   ,CodigoFactura VARCHAR(100) NOT NULL
   ,FechaFactura DATETIME NOT NULL
   ,TotalSinIVA DECIMAL(18, 2) NOT NULL
   ,Descuento DECIMAL(18, 2) NOT NULL
   ,IVA DECIMAL(18, 2) NOT NULL
   ,TotalPagar DECIMAL(18, 2) NOT NULL
   ,
	--Pistas de Auditoria
	IdUsuarioRegistro INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
   ,Activo BIT NOT NULL
)
GO
CREATE TABLE DetallesFactura (
	IdDetalleFactura INT PRIMARY KEY IDENTITY (1, 1)
   ,IdProducto INT FOREIGN KEY REFERENCES Productos (IdProducto)
   ,IdFactura INT FOREIGN KEY REFERENCES Facturas (IdFactura)
   ,PrecioUnitario DECIMAL(18, 2) NOT NULL
   ,Cantidad DECIMAL(18, 2) NOT NULL
   ,TotalSinIVA DECIMAL(18, 2) NOT NULL
   ,IVA DECIMAL(18, 2) NOT NULL
   ,Descuento DECIMAL(18, 2) NOT NULL
   ,TotalPagar DECIMAL(18, 2) NOT NULL
   ,
	--Pistas de Auditoria
	IdUsuarioRegistro INT NOT NULL
   ,FechaRegistro DATETIME NOT NULL
   ,IdUsuarioActualiza INT NULL
   ,FechaActualizacion DATETIME NULL
   ,Activo BIT NOT NULL
)
GO