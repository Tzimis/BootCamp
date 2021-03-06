USE [master]
GO
/****** Object:  Database [MyServiceTrade]    Script Date: 8/11/2016 2:09:47 πμ ******/
CREATE DATABASE [MyServiceTrade]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyServiceTrade', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\MyServiceTrade.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyServiceTrade_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\MyServiceTrade_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [MyServiceTrade] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyServiceTrade].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyServiceTrade] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyServiceTrade] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyServiceTrade] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyServiceTrade] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyServiceTrade] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyServiceTrade] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyServiceTrade] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyServiceTrade] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyServiceTrade] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyServiceTrade] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyServiceTrade] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyServiceTrade] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyServiceTrade] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyServiceTrade] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyServiceTrade] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyServiceTrade] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyServiceTrade] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyServiceTrade] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyServiceTrade] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyServiceTrade] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyServiceTrade] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyServiceTrade] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyServiceTrade] SET RECOVERY FULL 
GO
ALTER DATABASE [MyServiceTrade] SET  MULTI_USER 
GO
ALTER DATABASE [MyServiceTrade] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyServiceTrade] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyServiceTrade] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyServiceTrade] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyServiceTrade] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyServiceTrade', N'ON'
GO
ALTER DATABASE [MyServiceTrade] SET QUERY_STORE = OFF
GO
USE [MyServiceTrade]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [MyServiceTrade]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[eMail] [varchar](50) NOT NULL,
	[OwnedCredits] [decimal](18, 0) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[Address] [varchar](50) NULL,
	[PostCode] [varchar](15) NULL,
	[ImagePath] [varchar](100) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[All eMails]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[All eMails] as
select userID, FirstName, LastName, UserName, eMail from users
where active = 1;
GO
/****** Object:  Table [dbo].[Services]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[ServiceID] [int] IDENTITY(1,1) NOT NULL,
	[OfferedBy] [int] NOT NULL,
	[ServiceTitle] [varchar](120) NOT NULL,
	[ServiceDescription] [varchar](500) NULL,
	[CreditsRequested] [decimal](18, 0) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[ImagePath] [varchar](100) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Offers] PRIMARY KEY CLUSTERED 
(
	[ServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Active Services]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Active Services]  as
select u.UserName, u.FirstName, u.LastName, s.ServiceID, s.ServiceTitle,
s.ServiceDescription, s.CreditsRequested, s.City
from services s
join users u on u.UserID = s.OfferedBy
where s.Active = 1 and u.Active = 1;
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[SenderID] [int] NOT NULL,
	[ReceiverID] [int] NOT NULL,
	[RelatedServiceID] [int] NULL,
	[ReplyToMessageID] [int] NULL,
	[SentDate] [datetime] NOT NULL,
	[ReadDate] [datetime] NULL,
	[IsDeletedBySender] [bit] NULL,
	[IsDeletedByReceiver] [bit] NULL,
	[IsPermanentlyDeletedBySender] [bit] NULL,
	[IsPermanentlyDeletedByReceiver] [bit] NULL,
	[Subject] [varchar](80) NULL,
	[Text] [varchar](500) NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServicesTags]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicesTags](
	[ServiceID] [int] NOT NULL,
	[TagID] [int] NOT NULL,
 CONSTRAINT [PK_OffersTags] PRIMARY KEY CLUSTERED 
(
	[ServiceID] ASC,
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tags]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[TagID] [int] IDENTITY(1,1) NOT NULL,
	[TagText] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[RequestedBy] [int] NOT NULL,
	[OfferID] [int] NOT NULL,
	[RequestedDate] [datetime] NOT NULL,
	[CancelledDate] [datetime] NULL,
	[AcceptedDate] [datetime] NULL,
	[CompletedDate] [datetime] NULL,
	[Status] [varchar](50) NOT NULL,
	[Multiplier] [decimal](18, 0) NOT NULL,
	[CreditValue] [decimal](18, 0) NOT NULL,
	[Rating] [int] NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (9, 7, 9, NULL, NULL, CAST(N'2016-09-20T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Lacus. Ut nec urna', N'Lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. ')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (10, 9, 10, 3, NULL, CAST(N'2016-01-31T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:50:48.090' AS DateTime), 0, 0, 0, 0, N'Nunc lectus pede,', N'Metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis dis parturient montes.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (11, 10, 7, 3, NULL, CAST(N'2016-10-20T00:00:00.000' AS DateTime), CAST(N'2016-11-06T19:52:28.260' AS DateTime), 1, 0, 0, 0, N'Vestibulum ante ipsum primis in faucibus', N'Neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (12, 8, 14, NULL, NULL, CAST(N'2015-12-07T00:00:00.000' AS DateTime), CAST(N'2016-11-04T12:19:53.607' AS DateTime), 0, 0, 0, 0, N'Auctor', N'Arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit amet ante. Vivamus.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (13, 6, 12, NULL, NULL, CAST(N'2016-08-05T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:41:48.043' AS DateTime), 0, 1, 0, 0, N'Cursus vestibulum. Mauris magna.', N'Nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus ornare.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (14, 13, 8, NULL, NULL, CAST(N'2016-03-07T00:00:00.000' AS DateTime), CAST(N'2016-11-04T23:55:53.000' AS DateTime), 0, 0, 0, 0, N'Nulla eget', N'Quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (15, 6, 12, NULL, NULL, CAST(N'2016-08-02T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:41:48.797' AS DateTime), 0, 0, 0, 0, N'Lacus. Ut', N'Et, eros. Proin ultrices. Duis volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (16, 9, 13, NULL, NULL, CAST(N'2016-10-03T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:13:25.790' AS DateTime), 0, 0, 0, 0, N'Mollis', N'Elit erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (17, 9, 11, NULL, NULL, CAST(N'2016-02-14T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Curabitur', N'Tincidunt nibh. Phasellus nulla. Integer vulputate, risus a ultricies adipiscing, enim mi tempor lorem, eget mollis lectus pede et risus. Quisque libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (18, 9, 12, NULL, NULL, CAST(N'2016-02-23T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:41:49.910' AS DateTime), 0, 0, 0, 0, N'Libero. Donec consectetuer mauris', N'Nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (19, 8, 9, NULL, NULL, CAST(N'2016-03-15T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Orci', N'Tempor lorem, eget mollis lectus pede et risus. Quisque libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (20, 13, 7, NULL, NULL, CAST(N'2016-04-25T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Aliquam nec enim.', N'Maecenas ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (21, 6, 8, NULL, NULL, CAST(N'2016-03-29T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Condimentum', N'Feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue, eu tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam fringilla cursus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (22, 7, 6, NULL, NULL, CAST(N'2016-05-29T00:00:00.000' AS DateTime), CAST(N'2016-11-07T14:52:18.987' AS DateTime), 0, 1, 0, 0, N'Dolor', N'Eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (23, 8, 7, NULL, NULL, CAST(N'2015-11-11T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Mauris', N'Egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (24, 13, 10, NULL, NULL, CAST(N'2016-07-16T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:50:46.227' AS DateTime), 0, 1, 0, 0, N'Vitae, orci', N'Hendrerit neque. In ornare sagittis felis. Donec tempor, est ac mattis semper, dui lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit amet,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (25, 8, 12, NULL, NULL, CAST(N'2016-06-10T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:41:49.747' AS DateTime), 0, 0, 0, 0, N'Egestas blandit. Nam nulla', N'Tellus lorem eu metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue, eu tempor erat neque non quam. Pellentesque habitant morbi')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (26, 6, 14, NULL, NULL, CAST(N'2016-07-17T00:00:00.000' AS DateTime), CAST(N'2016-11-04T12:28:08.680' AS DateTime), 0, 1, 0, 0, N'Lobortis, nisi nibh', N'Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (27, 14, 9, NULL, NULL, CAST(N'2016-10-23T00:00:00.000' AS DateTime), CAST(N'2016-11-04T12:44:45.907' AS DateTime), 0, 0, 0, 0, N'Adipiscing ligula. Aenean gravida', N'Sit amet, faucibus ut, nulla. Cras eu tellus eu augue porttitor interdum. Sed auctor odio a purus. Duis elementum, dui quis accumsan convallis, ante lectus convallis est, vitae sodales nisi magna sed dui. Fusce aliquam,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (28, 6, 14, NULL, NULL, CAST(N'2016-08-28T00:00:00.000' AS DateTime), CAST(N'2016-11-04T11:09:48.533' AS DateTime), 0, 0, 0, 0, N'Amet', N'Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (29, 6, 7, NULL, NULL, CAST(N'2016-03-31T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Ligula. Donec', N'Quisque ornare tortor at risus. Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (30, 11, 12, NULL, NULL, CAST(N'2016-01-12T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:41:50.073' AS DateTime), 0, 0, 0, 0, N'Curabitur vel lectus.', N'Vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat. Lorem ipsum')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (31, 14, 13, NULL, NULL, CAST(N'2016-05-27T00:00:00.000' AS DateTime), CAST(N'2016-11-04T12:43:01.327' AS DateTime), 0, 0, 0, 0, N'Leo', N'Vel arcu eu odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (32, 9, 14, NULL, NULL, CAST(N'2016-08-19T00:00:00.000' AS DateTime), CAST(N'2016-11-04T12:19:37.887' AS DateTime), 0, 0, 0, 0, N'Dui', N'Molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (33, 9, 10, NULL, NULL, CAST(N'2016-09-10T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:50:44.883' AS DateTime), 0, 0, 0, 0, N'Accumsan interdum libero dui nec', N'In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper tellus id')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (34, 6, 11, NULL, NULL, CAST(N'2016-07-11T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Nibh.', N'Neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (35, 9, 1, NULL, NULL, CAST(N'2015-11-08T00:00:00.000' AS DateTime), CAST(N'2016-11-06T03:58:27.003' AS DateTime), 0, 0, 0, 0, N'Vitae nibh. Donec est', N'Gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (36, 6, 11, NULL, NULL, CAST(N'2016-01-05T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Vitae mauris sit amet', N'Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (37, 10, 6, NULL, NULL, CAST(N'2015-12-25T00:00:00.000' AS DateTime), CAST(N'2016-11-07T16:45:47.573' AS DateTime), 0, 0, 0, 0, N'Nulla. Integer vulputate, risus', N'Neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec vitae')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (38, 12, 1, NULL, NULL, CAST(N'2016-09-10T00:00:00.000' AS DateTime), CAST(N'2016-11-06T13:00:02.743' AS DateTime), 1, 0, 0, 0, N'Fermentum fermentum arcu.', N'A, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (39, 12, 8, NULL, NULL, CAST(N'2016-08-05T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:23:42.070' AS DateTime), 0, 1, 0, 0, N'Eget, venenatis', N'Interdum ligula eu enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac facilisis facilisis, magna tellus faucibus leo, in lobortis tellus justo sit amet nulla. Donec non justo. Proin non massa non ante')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (40, 14, 13, NULL, NULL, CAST(N'2016-04-16T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:11:22.983' AS DateTime), 0, 0, 0, 0, N'Sem ut dolor', N'Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper tellus id nunc interdum feugiat. Sed nec metus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (41, 7, 12, NULL, NULL, CAST(N'2016-07-25T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:41:49.407' AS DateTime), 0, 0, 0, 0, N'Justo. Praesent luctus.', N'Metus facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum eu, placerat eget, venenatis a, magna. Lorem ipsum dolor')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (42, 8, 13, NULL, NULL, CAST(N'2015-12-28T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:11:25.923' AS DateTime), 0, 0, 0, 0, N'Diam nunc, ullamcorper eu, euismod', N'Sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio. Phasellus at augue id ante dictum cursus. Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (43, 10, 14, NULL, NULL, CAST(N'2016-03-28T00:00:00.000' AS DateTime), CAST(N'2016-11-04T11:09:59.187' AS DateTime), 0, 0, 0, 0, N'Rutrum magna. Cras convallis convallis', N'Mi tempor lorem, eget mollis lectus pede et risus. Quisque libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (44, 6, 14, NULL, NULL, CAST(N'2016-02-13T00:00:00.000' AS DateTime), CAST(N'2016-11-04T12:28:11.640' AS DateTime), 0, 1, 0, 0, N'Gravida. Praesent', N'Interdum ligula eu enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac facilisis facilisis, magna tellus faucibus leo, in lobortis tellus justo sit amet nulla. Donec non justo. Proin non massa')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (45, 10, 7, NULL, NULL, CAST(N'2015-12-28T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Id ante', N'Tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (46, 12, 10, NULL, NULL, CAST(N'2016-03-16T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:50:50.767' AS DateTime), 0, 0, 0, 0, N'Phasellus dolor elit, pellentesque a,', N'Justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (47, 14, 13, NULL, NULL, CAST(N'2016-06-24T00:00:00.000' AS DateTime), CAST(N'2016-11-04T12:42:58.027' AS DateTime), 0, 0, 0, 0, N'Sagittis. Nullam vitae', N'Amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (48, 6, 1, NULL, NULL, CAST(N'2015-12-27T00:00:00.000' AS DateTime), CAST(N'2016-11-05T23:04:11.147' AS DateTime), 0, 0, 0, 0, N'Aliquet molestie tellus. Aenean egestas', N'Diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (49, 9, 11, NULL, NULL, CAST(N'2016-01-01T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Tempus non, lacinia at, iaculis', N'In consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac sem')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (50, 6, 9, NULL, NULL, CAST(N'2016-02-23T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Habitant', N'Eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci, consectetuer')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (51, 7, 2, NULL, NULL, CAST(N'2016-09-22T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Blandit enim', N'Urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (52, 12, 7, NULL, NULL, CAST(N'2016-04-20T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:23:44.697' AS DateTime), 0, 0, 0, 0, N'Dapibus id, blandit', N'Et netus et malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (53, 6, 14, NULL, NULL, CAST(N'2016-09-08T00:00:00.000' AS DateTime), NULL, 0, 1, 0, 1, N'Ornare,', N'A odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (54, 8, 7, NULL, NULL, CAST(N'2016-07-24T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Consectetuer adipiscing elit. Curabitur sed', N'Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (55, 6, 7, NULL, NULL, CAST(N'2016-10-05T00:00:00.000' AS DateTime), CAST(N'2016-11-06T16:54:05.337' AS DateTime), 1, 0, 1, 0, N'Odio. Etiam', N'Magna. Praesent interdum ligula eu enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac facilisis facilisis, magna tellus faucibus leo, in lobortis tellus justo')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (56, 8, 6, NULL, NULL, CAST(N'2016-07-14T00:00:00.000' AS DateTime), CAST(N'2016-11-07T01:43:37.887' AS DateTime), 0, 1, 0, 0, N'Nulla semper tellus id nunc', N'Ultrices posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit amet diam eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (57, 8, 7, NULL, NULL, CAST(N'2016-08-11T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Viverra.', N'Eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna justo faucibus lectus, a sollicitudin orci sem eget massa. Suspendisse eleifend. Cras sed leo. Cras vehicula')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (58, 6, 7, NULL, NULL, CAST(N'2016-01-30T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Euismod mauris eu', N'Tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim magna a tortor.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (59, 7, 8, NULL, NULL, CAST(N'2016-02-20T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Vitae, posuere at,', N'In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (60, 8, 6, NULL, NULL, CAST(N'2016-07-24T00:00:00.000' AS DateTime), CAST(N'2016-11-07T01:45:07.683' AS DateTime), 0, 0, 0, 0, N'Sed eget', N'Donec fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (61, 8, 6, NULL, NULL, CAST(N'2016-01-28T00:00:00.000' AS DateTime), CAST(N'2016-11-08T00:13:17.797' AS DateTime), 0, 1, 0, 1, N'Nec', N'Congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec vitae erat vel')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (62, 6, 8, NULL, NULL, CAST(N'2016-02-22T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Nibh. Donec est mauris, rhoncus', N'Ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat non, lobortis')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (63, 7, 6, NULL, NULL, CAST(N'2015-12-12T00:00:00.000' AS DateTime), CAST(N'2016-11-07T14:55:43.620' AS DateTime), 0, 0, 0, 0, N'Nunc', N'Lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (64, 6, 11, NULL, NULL, CAST(N'2016-09-07T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:42:33.737' AS DateTime), 0, 0, 0, 0, N'Pharetra. Quisque ac', N'Cursus et, magna. Praesent interdum ligula eu enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac facilisis')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (65, 6, 11, NULL, NULL, CAST(N'2016-08-21T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:43:01.597' AS DateTime), 0, 1, 0, 0, N'Lacus. Quisque purus', N'Massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (66, 7, 8, NULL, NULL, CAST(N'2015-12-04T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Risus. Morbi metus. Vivamus euismod', N'Ullamcorper magna. Sed eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (67, 6, 7, NULL, NULL, CAST(N'2016-05-02T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Sed, est. Nunc laoreet', N'Dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit amet, risus. Donec nibh enim, gravida sit amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel nisl.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (68, 6, 11, NULL, NULL, CAST(N'2015-11-10T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Lacinia at, iaculis quis,', N'Massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec felis orci, adipiscing non, luctus sit amet, faucibus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (69, 7, 11, NULL, NULL, CAST(N'2016-10-20T00:00:00.000' AS DateTime), CAST(N'2016-11-04T14:24:11.413' AS DateTime), 0, 0, 0, 0, N'Mi pede,', N'Et magnis dis parturient montes, nascetur ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim. Sed nulla ante, iaculis')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (70, 8, 6, NULL, NULL, CAST(N'2015-12-03T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Risus.', N'Velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper eu,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (71, 6, 7, NULL, NULL, CAST(N'2016-09-24T00:00:00.000' AS DateTime), NULL, 1, 0, 0, 0, N'Mollis non, cursus', N'Et risus. Quisque libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem semper erat,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (72, 6, 8, NULL, NULL, CAST(N'2016-08-02T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Euismod ac,', N'Pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (73, 8, 7, NULL, NULL, CAST(N'2016-03-10T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Ipsum', N'Luctus et ultrices posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit amet diam eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (74, 7, 8, NULL, NULL, CAST(N'2016-04-09T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Nisl. Maecenas malesuada fringilla', N'Cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc mauris sapien, cursus in, hendrerit consectetuer, cursus et,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (75, 7, 6, NULL, NULL, CAST(N'2016-06-16T00:00:00.000' AS DateTime), CAST(N'2016-11-07T01:43:39.107' AS DateTime), 0, 0, 0, 0, N'Sem eget', N'Ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (76, 7, 11, NULL, NULL, CAST(N'2016-08-21T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:43:03.583' AS DateTime), 0, 1, 0, 0, N'Tincidunt tempus', N'Fermentum arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (77, 7, 6, NULL, NULL, CAST(N'2016-01-16T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Vitae', N'Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper tellus id nunc interdum')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (78, 6, 8, NULL, NULL, CAST(N'2016-05-09T00:00:00.000' AS DateTime), CAST(N'2016-11-05T23:22:43.430' AS DateTime), 0, 1, 0, 0, N'Sodales nisi magna sed dui.', N'Tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (79, 7, 8, NULL, NULL, CAST(N'2015-11-09T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Mauris id', N'Eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus ornare. Fusce')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (80, 8, 11, NULL, NULL, CAST(N'2016-08-16T00:00:00.000' AS DateTime), CAST(N'2016-11-04T13:43:06.380' AS DateTime), 0, 1, 0, 0, N'Vitae purus gravida sagittis. Duis', N'Fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce diam')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (81, 7, 6, NULL, NULL, CAST(N'2016-01-12T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Nonummy', N'Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (82, 7, 8, NULL, NULL, CAST(N'2015-11-07T00:00:00.000' AS DateTime), CAST(N'2016-11-03T11:12:44.000' AS DateTime), 0, 0, 0, 0, N'Pretium neque.', N'Pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (83, 6, 8, NULL, NULL, CAST(N'2016-06-04T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Velit. Sed malesuada', N'Vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (84, 8, 6, NULL, NULL, CAST(N'2016-02-27T00:00:00.000' AS DateTime), CAST(N'2016-11-07T16:21:14.310' AS DateTime), 0, 0, 0, 0, N'Dignissim pharetra. Nam ac', N'Adipiscing lobortis risus. In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (85, 8, 11, NULL, NULL, CAST(N'2015-11-11T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Egestas', N'Orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (86, 7, 6, NULL, NULL, CAST(N'2016-02-06T00:00:00.000' AS DateTime), CAST(N'2016-11-07T16:21:15.547' AS DateTime), 0, 0, 0, 0, N'Elit,', N'Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (87, 6, 7, NULL, NULL, CAST(N'2016-01-04T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Montes, nascetur ridiculus', N'Risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (88, 6, 11, NULL, NULL, CAST(N'2016-02-15T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Sodales nisi magna sed', N'Mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (89, 8, 6, NULL, NULL, CAST(N'2016-05-08T00:00:00.000' AS DateTime), CAST(N'2016-11-07T16:18:55.743' AS DateTime), 0, 0, 0, 0, N'Nam', N'Imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (90, 6, 8, NULL, NULL, CAST(N'2016-08-10T00:00:00.000' AS DateTime), NULL, 0, 1, 0, 0, N'Faucibus ut, nulla.', N'Orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (91, 7, 11, NULL, NULL, CAST(N'2016-03-21T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Dictum cursus. Nunc mauris', N'Enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim. Sed nulla ante, iaculis nec,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (92, 7, 11, NULL, NULL, CAST(N'2015-12-23T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Ante lectus convallis', N'Ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et libero. Proin mi. Aliquam gravida mauris ut mi. Duis risus odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (93, 8, 6, NULL, NULL, CAST(N'2016-03-18T00:00:00.000' AS DateTime), CAST(N'2016-11-07T16:20:26.643' AS DateTime), 0, 0, 0, 0, N'At, nisi. Cum sociis natoque', N'Ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros nec tellus. Nunc lectus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (94, 8, 7, NULL, NULL, CAST(N'2016-05-23T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Sit amet orci. Ut', N'Ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (95, 8, 7, NULL, NULL, CAST(N'2016-02-29T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Pellentesque', N'Dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (96, 8, 11, NULL, NULL, CAST(N'2016-01-16T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Lectus. Cum', N'Egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (97, 6, 11, NULL, NULL, CAST(N'2016-05-04T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'In tincidunt congue turpis. In', N'Gravida mauris ut mi. Duis risus odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat. Lorem ipsum')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (98, 8, 6, NULL, NULL, CAST(N'2016-08-04T00:00:00.000' AS DateTime), CAST(N'2016-11-06T04:16:32.187' AS DateTime), 0, 1, 0, 0, N'Magnis dis', N'Laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (99, 7, 11, NULL, NULL, CAST(N'2016-07-03T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Metus vitae velit egestas', N'A, aliquet vel, vulputate eu, odio. Phasellus at augue id ante dictum cursus. Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (100, 7, 6, NULL, NULL, CAST(N'2016-09-04T00:00:00.000' AS DateTime), CAST(N'2016-11-06T12:18:16.423' AS DateTime), 0, 1, 0, 0, N'Augue, eu tempor erat', N'At pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (101, 7, 8, NULL, NULL, CAST(N'2016-09-20T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Pharetra', N'Sem mollis dui, in sodales elit erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (102, 7, 11, NULL, NULL, CAST(N'2016-02-22T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Sapien,', N'Sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (103, 6, 8, NULL, NULL, CAST(N'2016-09-13T00:00:00.000' AS DateTime), CAST(N'2016-11-05T23:29:29.257' AS DateTime), 1, 1, 0, 0, N'Eget massa. Suspendisse eleifend. Cras', N'Dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie in,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (104, 8, 6, NULL, NULL, CAST(N'2016-04-13T00:00:00.000' AS DateTime), CAST(N'2016-11-07T16:20:11.270' AS DateTime), 0, 0, 0, 0, N'Nec, eleifend', N'Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (105, 7, 11, NULL, NULL, CAST(N'2016-04-14T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Mollis vitae, posuere at,', N'Lectus pede et risus. Quisque libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (106, 8, 11, NULL, NULL, CAST(N'2016-04-19T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Risus a ultricies adipiscing, enim', N'Sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (107, 6, 8, NULL, NULL, CAST(N'2016-04-15T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'In faucibus orci luctus et', N'Velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class')
GO
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (108, 8, 6, NULL, NULL, CAST(N'2016-01-10T00:00:00.000' AS DateTime), CAST(N'2016-11-07T16:45:44.737' AS DateTime), 0, 0, 0, 0, N'Massa. Suspendisse eleifend. Cras sed', N'Lorem eu metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue, eu tempor erat neque non quam. Pellentesque habitant morbi tristique senectus')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (109, 8, 11, NULL, NULL, CAST(N'2016-01-24T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Nibh. Donec', N'Non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (110, 7, 11, NULL, NULL, CAST(N'2016-02-12T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Diam. Sed diam', N'Interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (111, 8, 6, NULL, NULL, CAST(N'2015-11-30T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Pharetra. Quisque', N'Libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem semper erat, in')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (112, 6, 7, NULL, NULL, CAST(N'2016-09-11T00:00:00.000' AS DateTime), CAST(N'2016-11-06T16:54:15.623' AS DateTime), 1, 0, 0, 0, N'Pede blandit congue. In scelerisque', N'Non, feugiat nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (113, 7, 11, NULL, NULL, CAST(N'2016-03-13T00:00:00.000' AS DateTime), NULL, 0, 0, 0, 0, N'Fusce feugiat. Lorem ipsum dolor', N'Ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc mauris sapien, cursus in, hendrerit consectetuer, cursus et,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (115, 11, 1, NULL, NULL, CAST(N'2016-11-04T14:19:31.940' AS DateTime), CAST(N'2016-11-06T13:00:27.247' AS DateTime), 0, 1, 0, 0, N'Windows 10 latest update', N'Key changes include:
Improved reliability for Internet Explorer 11, .NET Framework, wireless LAN, Microsoft Edge, Windows Update, logon, Bluetooth, network connectivity, map apps, video playback, Cortana, USB, Windows Explorer, and Narrator.
Fixed issue with connectivity of USB devices until OS restart.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (116, 11, 3, NULL, NULL, CAST(N'2016-11-04T14:54:51.260' AS DateTime), CAST(N'2016-11-06T03:37:05.077' AS DateTime), 0, 0, 0, 0, N'Once upon a time', N'A fairy tale is a type of short story that typically features folkloric fantasy characters, such as dwarves, elves, fairies, giants, gnomes, goblins, mermaids, trolls, unicorns, or witches, and usually magic or enchantments.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (117, 11, 6, NULL, NULL, CAST(N'2016-11-04T14:57:17.063' AS DateTime), NULL, 0, 1, 0, 0, N'Three little pigs', N'The Three Little Pigs is a fable/fairy tale featuring anthropomorphic pigs who build three houses of different materials.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (118, 1, 2, NULL, NULL, CAST(N'2016-11-04T16:43:02.400' AS DateTime), NULL, 0, 0, 0, 0, N'Big problem', N'Windows 98 show many blue screens. What are we going to do?')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (119, 6, 2, NULL, NULL, CAST(N'2016-11-04T17:29:06.263' AS DateTime), NULL, 1, 0, 1, 0, N'This is a test', N'This is an &lt;strong&gt;html&lt;/strong&gt;.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (120, 1, 8, NULL, NULL, CAST(N'2016-11-05T23:01:23.003' AS DateTime), CAST(N'2016-11-05T23:08:13.857' AS DateTime), 1, 0, 0, 0, N'The &lt;sup&gt;Subject&lt;/sup&gt; is up', N'This is a &lt;strong&gt; bold &lt;/sTrOng&gt; move.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1118, 15, 4, NULL, NULL, CAST(N'2016-11-06T12:47:55.917' AS DateTime), CAST(N'2016-11-06T20:34:55.787' AS DateTime), 0, 0, 0, 0, N'Tenacious D', N'Shame on you Jack! KG is the best!')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1119, 4, 6, NULL, NULL, CAST(N'2016-11-06T20:47:34.723' AS DateTime), NULL, 0, 1, 0, 1, N'asdasdasdasd', N'asdasd')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1120, 6, 2, NULL, NULL, CAST(N'2016-11-07T00:24:18.757' AS DateTime), NULL, 0, 0, 0, 0, N'A not very long subject is a subject that is (ahm) below eighty characters long!', N'A not very long message is a message thar is (123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 
123456789) below 500 characters long!')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1121, 6, 15, NULL, NULL, CAST(N'2016-11-07T14:24:20.050' AS DateTime), NULL, 0, 0, 0, 0, N'Fw: Sed eget', N'Donec fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus        ')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1122, 6, 8, NULL, 60, CAST(N'2016-11-07T14:37:52.550' AS DateTime), NULL, 0, 0, 0, 0, N'Re: Sed eget', N'I am sorry, I do not understand latin.')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1123, 6, 7, NULL, 22, CAST(N'2016-11-07T14:52:43.503' AS DateTime), NULL, 0, 0, 0, 0, N'Re: Dolor', N'What &quot;Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien.&quot; means?')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1124, 6, 7, NULL, 81, CAST(N'2016-11-07T14:54:45.470' AS DateTime), NULL, 0, 0, 0, 0, N'Re: Nonummy', N'Does this break?')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1132, 6, 8, NULL, 56, CAST(N'2016-11-07T15:10:18.523' AS DateTime), CAST(N'2016-11-07T16:02:37.997' AS DateTime), 1, 0, 1, 0, N'Re: Nulla semper tellus id nunc', N'sdfsdfsdfsdfs')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1140, 6, 9, NULL, NULL, CAST(N'2016-11-07T22:20:40.790' AS DateTime), NULL, 0, 0, 0, 0, N'About model building', N'Do you build models from kits or from materials and components acquired by yourself?')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1141, 14, 4, NULL, NULL, CAST(N'2016-11-08T00:03:37.627' AS DateTime), NULL, 0, 0, 0, 0, N'Fw: Amet', N'Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non,')
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ReceiverID], [RelatedServiceID], [ReplyToMessageID], [SentDate], [ReadDate], [IsDeletedBySender], [IsDeletedByReceiver], [IsPermanentlyDeletedBySender], [IsPermanentlyDeletedByReceiver], [Subject], [Text]) VALUES (1142, 6, 8, NULL, 61, CAST(N'2016-11-08T00:14:04.450' AS DateTime), NULL, 0, 0, 0, 0, N'Re: Nec', N'I don&#39;t understand a word of what you are writing. What&#39;s the &lt;em&gt;matter&lt;/em&gt; with you?')
SET IDENTITY_INSERT [dbo].[Messages] OFF
SET IDENTITY_INSERT [dbo].[Services] ON 

INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (2, 1, N'English Lessons', N'Experienced english professor teaches per hour children 7-12 ages old.', CAST(15 AS Decimal(18, 0)), N'Redmont', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (3, 2, N'Math Lessons', N'Mathematics teacher delivers algebra lessons to highschool students. Credits per hour', CAST(20 AS Decimal(18, 0)), N'Redmont', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (4, 3, N'Wall painting', N'I paint whatever you want. Credits per square meter.', CAST(2 AS Decimal(18, 0)), N'Redmont', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (5, 2, N'Website Building', N'I build simple websites / blogs to your specs', CAST(50 AS Decimal(18, 0)), N'Athens', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (6, 4, N'Junk Collector', N'I collect everything you dont need. Clearing cellars, attics and everything else.', CAST(10 AS Decimal(18, 0)), N'Athens', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (7, 4, N'Μετάβαση στη Θήβα με αυτοκίνητο', N'Κάθε Σ/Κ του Απρίλη θα πηγαίνω από Αθήνα στη Θήβα με αμάξι την Παρασκευή το απόγευμα και θα γυρίζω Κυριακή βράδυ. Έχω 3 διαθέσιμες θέσεις.', CAST(10 AS Decimal(18, 0)), N'Αθήνα', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (14, 6, N'Dancing Lessons', N'Over time, however, Lippman says her son learned to adjust. By age seven, she says, her son had become fond of standing at the front window of subway trains, mapping out and memorizing the labyrinthian system of railroad tracks underneath the city. ', CAST(15 AS Decimal(18, 0)), N'Dieppe', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (15, 12, N'Statistical analysis', N'It was a hobby that relied on an ability to accommodate the loud noises that accompanied each train ride. "Only the initial noise seemed to bother him," says Lippman. "It was as if he got shocked by the sound but his nerves learned how to make the adjustment.', CAST(33 AS Decimal(18, 0)), N'Bal?kesir', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (16, 14, N'Washing sofas', N'Outside the classroom, Stallman pursued his studies with even more diligence, rushing off to fulfill his laboratory-assistant duties at Rockefeller University during the week and dodging the Vietnam protesters on his way to Saturday school at Columbia. ', CAST(40 AS Decimal(18, 0)), N'Tropea', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (17, 13, N'Guarding houses', N'It was there, while the rest of the Science Honors Program students sat around discussing their college choices, that Stallman finally took a moment to participate in the preclass bull session.', CAST(39 AS Decimal(18, 0)), N'Caucaia', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (18, 8, N'Repairing electronics', N'Over time, however, Lippman says her son learned to adjust. By age seven, she says, her son had become fond of standing at the front window of subway trains, mapping out and memorizing the labyrinthian system of railroad tracks underneath the city. ', CAST(18 AS Decimal(18, 0)), N'Opole', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (19, 11, N'Cleaning rooms', N' It was a hobby that relied on an ability to accommodate the loud noises that accompanied each train ride. "Only the initial noise seemed to bother him," says Lippman. "It was as if he got shocked by the sound but his nerves learned how to make the adjustment.', CAST(24 AS Decimal(18, 0)), N'North Vancouver', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (20, 13, N'I can beat a neighbor', N'Although it meant courting more run-ins at school, Lippman decided to indulge her sons passion.', CAST(24 AS Decimal(18, 0)), N'Opglabbeek', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (21, 11, N'Dancing shows', N'By age 12, Richard was attending science camps during the summer and private school during the school year. When a teacher recommended her son enroll in the Columbia Science Honors Program, a post-Sputnik program designed for gifted middle- and high-school students in New York City', CAST(14 AS Decimal(18, 0)), N'Termes', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (22, 6, N'I can curl telephone wires', N'Stallman added to his extracurriculars and was soon commuting uptown to the Columbia University campus on Saturdays.', CAST(29 AS Decimal(18, 0)), N'Gallicchio', NULL, 1)
INSERT [dbo].[Services] ([ServiceID], [OfferedBy], [ServiceTitle], [ServiceDescription], [CreditsRequested], [City], [ImagePath], [Active]) VALUES (23, 9, N'Model building', N'As a single parent for nearly a decade-she and Richards father, Daniel Stallman, were married in 1948, divorced in 1958, and split custody of their son afterwards-Lippman can attest to her sons aversion to authority. ', CAST(31 AS Decimal(18, 0)), N'Sens', NULL, 1)
SET IDENTITY_INSERT [dbo].[Services] OFF
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (2, 1)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (2, 2)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (2, 9)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (3, 1)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (3, 3)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (4, 4)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (4, 9)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (5, 5)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (5, 10)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (6, 5)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (6, 8)
INSERT [dbo].[ServicesTags] ([ServiceID], [TagID]) VALUES (6, 9)
SET IDENTITY_INSERT [dbo].[Tags] ON 

INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (8, N'afternoon')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (11, N'algebra')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (5, N'building')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (12, N'certificate')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (9, N'cheap')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (10, N'degree')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (2, N'english')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (6, N'kids')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (1, N'lessons')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (3, N'math')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (4, N'painting')
INSERT [dbo].[Tags] ([TagID], [TagText]) VALUES (7, N'taxi')
SET IDENTITY_INSERT [dbo].[Tags] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (1, N'Bill', N'Gates', N'billy', N'1', N'billy@microsoft.com', CAST(15 AS Decimal(18, 0)), N'Redmont', N'Bing 32', N'AK2121', N'/assets/user_img/user1.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (2, N'Paul', N'Allen', N'paulie', N'1', N'paul@microsoft.com', CAST(15 AS Decimal(18, 0)), N'Redmont', N'Otranto 2', N'AK2321', N'/assets/user_img/user2.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (3, N'Joe', N'Buschemi', N'joebu', N'1', N'joebu@fargo.com', CAST(15 AS Decimal(18, 0)), N'Redmont', N'Fargo 6', N'AK2345', N'/assets/user_img/user3.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (4, N'Jack', N'Black', N'blackman', N'1', N'blackman@teanciousd.com', CAST(15 AS Decimal(18, 0)), N'Redmont', N'Kane 162', N'AK3611', N'/assets/user_img/user4.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (6, N'Karleigh', N'Woods', N'u1', N'1', N'parturient@utquam.edu', CAST(15 AS Decimal(18, 0)), N'Amroha', N'Ap #541-6182 Blandit. Rd.', N'65431-953', N'/assets/user_img/user6.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (7, N'Tashya', N'Bauer', N'u2', N'1', N'eu.euismod.ac@etmalesuadafames.ca', CAST(15 AS Decimal(18, 0)), N'West Vancouver', N'161-2630 Leo Rd.', N'51104', N'/assets/user_img/user7.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (8, N'Teagan', N'Schroeder', N'u3', N'1', N'tortor.at.risus@egestas.net', CAST(15 AS Decimal(18, 0)), N'Zwolle', N'6751 Nec Ave', N'34-638', N'/assets/user_img/user8.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (9, N'Doris', N'Strickland', N'u4', N'1', N'ante.ipsum@ante.ca', CAST(15 AS Decimal(18, 0)), N'Ligny', N'Ap #667-5757 Suspendisse Road', N'971908', N'/assets/user_img/user9.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (10, N'Rina', N'Norman', N'u5', N'1', N'gravida.mauris@semNulla.org', CAST(15 AS Decimal(18, 0)), N'La Rochelle', N'P.O. Box 317, 3499 Mattis. Street', N'7150', N'/assets/user_img/user10.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (11, NULL, N'Walls', N'u6', N'1', N'lectus.a@ipsumprimisin.net', CAST(15 AS Decimal(18, 0)), N'Lens-Saint-Remy', N'151 Turpis Road', N'16764', N'/assets/user_img/user11.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (12, N'Mona', NULL, N'u7', N'1', N'aliquet.libero@Donec.ca', CAST(15 AS Decimal(18, 0)), N'Bromley', N'412-4353 Eu, Road', N'1034', N'/assets/user_img/user12.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (13, N'Lee', N'Garner', N'u8', N'1', N'posuere.at@ut.co.uk', CAST(15 AS Decimal(18, 0)), N'Bostanici', N'8218 Quam St.', N'5620', N'/assets/user_img/user13.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (14, N'Emmanuel', N'Salazar', N'u9', N'1', N'elementum@Donec.co.uk', CAST(15 AS Decimal(18, 0)), N'Nagaon', N'9061 Cras Avenue', N'95728', N'/assets/user_img/user14.jpg', 1)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [UserName], [Password], [eMail], [OwnedCredits], [City], [Address], [PostCode], [ImagePath], [Active]) VALUES (15, NULL, NULL, N'doe', N'1', N'jdoe@nowhere.com', CAST(15 AS Decimal(18, 0)), N'Neverland', N'4, Unknown St.', N'AK7662', NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [U_TagText]    Script Date: 8/11/2016 2:09:47 πμ ******/
CREATE UNIQUE NONCLUSTERED INDEX [U_TagText] ON [dbo].[Tags]
(
	[TagText] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [U_eMail]    Script Date: 8/11/2016 2:09:47 πμ ******/
CREATE UNIQUE NONCLUSTERED INDEX [U_eMail] ON [dbo].[Users]
(
	[eMail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [U_UserName]    Script Date: 8/11/2016 2:09:47 πμ ******/
CREATE UNIQUE NONCLUSTERED INDEX [U_UserName] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_OwnedCredits]  DEFAULT ((0)) FOR [OwnedCredits]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Messages] FOREIGN KEY([ReplyToMessageID])
REFERENCES [dbo].[Messages] ([MessageID])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Messages]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Services] FOREIGN KEY([RelatedServiceID])
REFERENCES [dbo].[Services] ([ServiceID])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Services]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users] FOREIGN KEY([SenderID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users1] FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users1]
GO
ALTER TABLE [dbo].[Services]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Users] FOREIGN KEY([OfferedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Services] CHECK CONSTRAINT [FK_Offers_Users]
GO
ALTER TABLE [dbo].[ServicesTags]  WITH CHECK ADD  CONSTRAINT [FK_OffersTags_Offers] FOREIGN KEY([ServiceID])
REFERENCES [dbo].[Services] ([ServiceID])
GO
ALTER TABLE [dbo].[ServicesTags] CHECK CONSTRAINT [FK_OffersTags_Offers]
GO
ALTER TABLE [dbo].[ServicesTags]  WITH CHECK ADD  CONSTRAINT [FK_OffersTags_Tags] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tags] ([TagID])
GO
ALTER TABLE [dbo].[ServicesTags] CHECK CONSTRAINT [FK_OffersTags_Tags]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Offers] FOREIGN KEY([OfferID])
REFERENCES [dbo].[Services] ([ServiceID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Offers]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Users] FOREIGN KEY([RequestedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Users]
GO
/****** Object:  StoredProcedure [dbo].[Get Tags by ServiceID]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get Tags by ServiceID] @ServiceID int AS
select distinct t.TagText from Tags t
join ServicesTags st on t.TagID = st.TagID
where st.ServiceID = @ServiceID
order by t.TagText;
GO
/****** Object:  StoredProcedure [dbo].[Get Tags by Title Substring]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get Tags by Title Substring] @Substring varchar(50) AS
select distinct t.TagText from ServicesTags st
join Tags t on t.TagID = st.TagID
join Services s on st.ServiceID = s.ServiceID
where s.ServiceTitle like '%' + @Substring + '%'
order by t.TagText;
GO
/****** Object:  StoredProcedure [dbo].[Search]    Script Date: 8/11/2016 2:09:47 πμ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Search] @query varchar(50) as
select distinct s.UserName, s.FirstName, s.LastName,
s.ServiceID, s.ServiceTitle, s.ServiceDescription,
s.CreditsRequested, s.City 
from [Active Services] s
join ServicesTags st on st.ServiceID = s.ServiceID
join Tags t on st.TagID = t.TagID
where t.TagText like '%' + @query + '%' OR
s.ServiceTitle like '%' + @query + '%' OR
s.ServiceDescription like '%' + @query + '%';
GO
USE [master]
GO
ALTER DATABASE [MyServiceTrade] SET  READ_WRITE 
GO
