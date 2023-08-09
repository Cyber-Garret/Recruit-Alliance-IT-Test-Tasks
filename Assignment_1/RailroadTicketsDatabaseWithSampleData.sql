USE [master]
GO
/****** Object:  Database [RailroadTickets]    Script Date: 04.08.2023 15:08:46 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'RailroadTickets')
BEGIN
CREATE DATABASE [RailroadTickets]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RailroadTickets', FILENAME = N'/var/opt/mssql/data/RailroadTickets.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RailroadTickets_log', FILENAME = N'/var/opt/mssql/data/RailroadTickets_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
END
GO
ALTER DATABASE [RailroadTickets] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RailroadTickets].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RailroadTickets] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RailroadTickets] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RailroadTickets] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RailroadTickets] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RailroadTickets] SET ARITHABORT OFF 
GO
ALTER DATABASE [RailroadTickets] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RailroadTickets] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RailroadTickets] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RailroadTickets] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RailroadTickets] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RailroadTickets] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RailroadTickets] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RailroadTickets] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RailroadTickets] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RailroadTickets] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RailroadTickets] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RailroadTickets] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RailroadTickets] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RailroadTickets] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RailroadTickets] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RailroadTickets] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RailroadTickets] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RailroadTickets] SET RECOVERY FULL 
GO
ALTER DATABASE [RailroadTickets] SET  MULTI_USER 
GO
ALTER DATABASE [RailroadTickets] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RailroadTickets] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RailroadTickets] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RailroadTickets] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RailroadTickets] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RailroadTickets] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RailroadTickets', N'ON'
GO
ALTER DATABASE [RailroadTickets] SET QUERY_STORE = ON
GO
ALTER DATABASE [RailroadTickets] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [RailroadTickets]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 04.08.2023 15:08:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](254) NOT NULL,
	[Phone] [nvarchar](15) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Station]    Script Date: 04.08.2023 15:08:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Station]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Station](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 04.08.2023 15:08:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ticket]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Ticket](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[TrainId] [int] NOT NULL,
	[DepartureDateTime] [datetimeoffset](7) NOT NULL,
	[ArrivalDateTime] [datetimeoffset](7) NOT NULL,
	[SeatNumber] [int] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Train]    Script Date: 04.08.2023 15:08:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Train]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Train](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[TotalSeats] [int] NOT NULL,
	[DepartureStationId] [int] NULL,
	[ArrivalStationId] [int] NULL
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 
GO
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [Email], [Phone]) VALUES (1, N'Ezra', N'Rodriguez', N'test@email.com', N'380661234567')
GO
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [Email], [Phone]) VALUES (4, N'Maddox', N'Jenkins', N'test2@email.com', N'380661232323')
GO
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [Email], [Phone]) VALUES (6, N'Phoenix', N'Perez', N'test3@email.com', NULL)
GO
INSERT [dbo].[Customer] ([Id], [FirstName], [LastName], [Email], [Phone]) VALUES (8, N'Amari', N'Hope', N'test4@email.com', NULL)
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Station] ON 
GO
INSERT [dbo].[Station] ([Id], [Name], [City], [State], [Country]) VALUES (1, N'Київ-Пасажирський', N'Київ', N'Київська міська рада', N'Україна')
GO
INSERT [dbo].[Station] ([Id], [Name], [City], [State], [Country]) VALUES (2, N'Калинівка I', N'Калинівка', N'Хмільницький район', N'Україна')
GO
INSERT [dbo].[Station] ([Id], [Name], [City], [State], [Country]) VALUES (3, N'Калинівка II', N'Павлівка', N'Хмільницький район', N'Україна')
GO
INSERT [dbo].[Station] ([Id], [Name], [City], [State], [Country]) VALUES (4, N'Кабанне', N'Красноріченське', N'Сватівський район', N'Україна')
GO
INSERT [dbo].[Station] ([Id], [Name], [City], [State], [Country]) VALUES (5, N'Łódź Widzew', N'Łódź', N'łódzkie', N'Polska')
GO
INSERT [dbo].[Station] ([Id], [Name], [City], [State], [Country]) VALUES (6, N'Warszawa Wileńska', N'Warszawa', N'mazowieckie', N'Polska')
GO
SET IDENTITY_INSERT [dbo].[Station] OFF
GO
SET IDENTITY_INSERT [dbo].[Ticket] ON 
GO
INSERT [dbo].[Ticket] ([Id], [CustomerId], [TrainId], [DepartureDateTime], [ArrivalDateTime], [SeatNumber]) VALUES (2, 1, 3, CAST(N'2025-10-12T15:30:00.0000000+02:00' AS DateTimeOffset), CAST(N'2025-10-12T22:00:00.0000000+03:00' AS DateTimeOffset), 5)
GO
INSERT [dbo].[Ticket] ([Id], [CustomerId], [TrainId], [DepartureDateTime], [ArrivalDateTime], [SeatNumber]) VALUES (4, 4, 1, CAST(N'2024-10-12T22:00:00.0000000+03:00' AS DateTimeOffset), CAST(N'2024-10-13T06:00:00.0000000+02:00' AS DateTimeOffset), 100)
GO
INSERT [dbo].[Ticket] ([Id], [CustomerId], [TrainId], [DepartureDateTime], [ArrivalDateTime], [SeatNumber]) VALUES (6, 1, 2, CAST(N'2025-10-12T22:30:00.0000000+03:00' AS DateTimeOffset), CAST(N'2025-10-12T23:00:00.0000000+03:00' AS DateTimeOffset), 23)
GO
SET IDENTITY_INSERT [dbo].[Ticket] OFF
GO
SET IDENTITY_INSERT [dbo].[Train] ON 
GO
INSERT [dbo].[Train] ([Id], [Name], [TotalSeats], [DepartureStationId], [ArrivalStationId]) VALUES (1, N'067', 300, 1, 6)
GO
INSERT [dbo].[Train] ([Id], [Name], [TotalSeats], [DepartureStationId], [ArrivalStationId]) VALUES (2, N'376', 150, 1, 2)
GO
INSERT [dbo].[Train] ([Id], [Name], [TotalSeats], [DepartureStationId], [ArrivalStationId]) VALUES (3, N'ІС 3804', 500, 5, 1)
GO
SET IDENTITY_INSERT [dbo].[Train] OFF
GO
/****** Object:  Index [PK_Customer_Id]    Script Date: 04.08.2023 15:08:46 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND name = N'PK_Customer_Id')
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [PK_Customer_Id] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_Customer_Email]    Script Date: 04.08.2023 15:08:46 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND name = N'UX_Customer_Email')
CREATE UNIQUE NONCLUSTERED INDEX [UX_Customer_Email] ON [dbo].[Customer]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_Station_Id]    Script Date: 04.08.2023 15:08:46 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Station]') AND name = N'PK_Station_Id')
ALTER TABLE [dbo].[Station] ADD  CONSTRAINT [PK_Station_Id] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_Ticket_Id]    Script Date: 04.08.2023 15:08:46 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Ticket]') AND name = N'PK_Ticket_Id')
ALTER TABLE [dbo].[Ticket] ADD  CONSTRAINT [PK_Ticket_Id] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_Train_Id]    Script Date: 04.08.2023 15:08:46 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Train]') AND name = N'PK_Train_Id')
ALTER TABLE [dbo].[Train] ADD  CONSTRAINT [PK_Train_Id] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_Train_Name]    Script Date: 04.08.2023 15:08:46 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Train]') AND name = N'UX_Train_Name')
CREATE UNIQUE NONCLUSTERED INDEX [UX_Train_Name] ON [dbo].[Train]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ticket_CustomerId_Customer_Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ticket]'))
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_CustomerId_Customer_Id] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ticket_CustomerId_Customer_Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ticket]'))
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_CustomerId_Customer_Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ticket_TrainId_Train_Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ticket]'))
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_TrainId_Train_Id] FOREIGN KEY([TrainId])
REFERENCES [dbo].[Train] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ticket_TrainId_Train_Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ticket]'))
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_TrainId_Train_Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Train_ArrivalStationId_Station_Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Train]'))
ALTER TABLE [dbo].[Train]  WITH CHECK ADD  CONSTRAINT [FK_Train_ArrivalStationId_Station_Id] FOREIGN KEY([ArrivalStationId])
REFERENCES [dbo].[Station] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Train_ArrivalStationId_Station_Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Train]'))
ALTER TABLE [dbo].[Train] CHECK CONSTRAINT [FK_Train_ArrivalStationId_Station_Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Train_DepartureStationId_Station_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Train]'))
ALTER TABLE [dbo].[Train]  WITH CHECK ADD  CONSTRAINT [FK_Train_DepartureStationId_Station_id] FOREIGN KEY([DepartureStationId])
REFERENCES [dbo].[Station] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Train_DepartureStationId_Station_id]') AND parent_object_id = OBJECT_ID(N'[dbo].[Train]'))
ALTER TABLE [dbo].[Train] CHECK CONSTRAINT [FK_Train_DepartureStationId_Station_id]
GO
USE [master]
GO
ALTER DATABASE [RailroadTickets] SET  READ_WRITE 
GO
