USE [master]
GO
/****** Object:  Database [SJMS]    Script Date: 24/12/2019 11:21:23 AM ******/
CREATE DATABASE [SJMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SJMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.QAS\MSSQL\DATA\SJMS.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SJMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.QAS\MSSQL\DATA\SJMS_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SJMS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SJMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SJMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SJMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SJMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SJMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SJMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SJMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SJMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SJMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SJMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SJMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SJMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SJMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SJMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SJMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SJMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SJMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SJMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SJMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SJMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SJMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SJMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SJMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SJMS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SJMS] SET  MULTI_USER 
GO
ALTER DATABASE [SJMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SJMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SJMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SJMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SJMS] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SJMS]
GO
/****** Object:  User [CALTEK\Administrator]    Script Date: 24/12/2019 11:21:23 AM ******/
CREATE USER [CALTEK\Administrator] FOR LOGIN [CALTEK\Administrator] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedTableType [dbo].[AccessType]    Script Date: 24/12/2019 11:21:23 AM ******/
CREATE TYPE [dbo].[AccessType] AS TABLE(
	[RoleID] [int] NULL,
	[ScreenID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DatatableType]    Script Date: 24/12/2019 11:21:23 AM ******/
CREATE TYPE [dbo].[DatatableType] AS TABLE(
	[ID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DelPlanType]    Script Date: 24/12/2019 11:21:23 AM ******/
CREATE TYPE [dbo].[DelPlanType] AS TABLE(
	[ProductionID] [int] NULL,
	[Date] [varchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ProdAssignedType]    Script Date: 24/12/2019 11:21:23 AM ******/
CREATE TYPE [dbo].[ProdAssignedType] AS TABLE(
	[ProductionID] [int] NULL,
	[Date] [varchar](100) NULL,
	[Employee] [varchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ProdPlanType]    Script Date: 24/12/2019 11:21:23 AM ******/
CREATE TYPE [dbo].[ProdPlanType] AS TABLE(
	[ProductionID] [int] NULL,
	[Date] [varchar](100) NULL
)
GO
/****** Object:  Table [dbo].[AccessRights]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessRights](
	[AccessID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[ScreenID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleID] ASC,
	[ScreenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditActual]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditActual](
	[ActualId] [int] IDENTITY(1,1) NOT NULL,
	[PlanId] [int] NOT NULL,
	[AuditDate] [date] NOT NULL,
	[Comments] [varchar](100) NOT NULL,
	[EMPID] [int] NOT NULL,
	[Status] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ActualId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PlanId] ASC,
	[EMPID] ASC,
	[AuditDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditCycle]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditCycle](
	[ACId] [int] IDENTITY(1,1) NOT NULL,
	[AuditID] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ACId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[AuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Interface] [int] NOT NULL,
	[Activity] [nvarchar](50) NOT NULL,
	[DateTime] [timestamp] NOT NULL,
	[User] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditPlan]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditPlan](
	[AId] [int] IDENTITY(1,1) NOT NULL,
	[AuditID] [int] NOT NULL,
	[Criteria] [int] NOT NULL,
	[Department] [int] NOT NULL,
	[AuditDate] [date] NOT NULL,
	[Comments] [varchar](100) NOT NULL,
	[EMPID] [int] NOT NULL,
	[ExecuteStatus] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[AId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[AuditID] ASC,
	[Department] ASC,
	[Criteria] ASC,
	[EMPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ButtonList]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ButtonList](
	[BId] [int] IDENTITY(1,1) NOT NULL,
	[ButtonName] [varchar](50) NOT NULL,
	[Screen] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CertificateStatus]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CertificateStatus](
	[ProductionID] [int] NOT NULL,
	[Certificate Status] [varchar](50) NOT NULL,
	[Date] [varchar](50) NOT NULL,
	[Remarks] [varchar](100) NOT NULL,
	[MidState] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CertPrefix]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CertPrefix](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Prefix] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Prefix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clause]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clause](
	[CId] [int] IDENTITY(1,1) NOT NULL,
	[ClauseNo] [nvarchar](50) NOT NULL,
	[Standard] [int] NOT NULL,
	[Content] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Standard] ASC,
	[ClauseNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[CId] [int] IDENTITY(1,1) NOT NULL,
	[Client] [nvarchar](50) NOT NULL,
	[Address Line 1] [nvarchar](50) NOT NULL,
	[Address Line 2] [nvarchar](50) NOT NULL,
	[Address Line 3] [nvarchar](50) NULL,
	[Country] [int] NOT NULL,
	[PostalCode] [int] NOT NULL,
	[Salutation] [nvarchar](5) NOT NULL,
	[Contact] [nvarchar](25) NOT NULL,
	[Telephone] [int] NOT NULL,
	[Handphone] [int] NOT NULL,
	[Email ID] [varchar](50) NOT NULL,
	[Caltek Sales] [int] NOT NULL,
	[Remarks] [nvarchar](50) NULL,
	[Last Modified] [timestamp] NOT NULL,
	[Created by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Collection]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collection](
	[CollectionId] [int] IDENTITY(1,1) NOT NULL,
	[Client] [nvarchar](50) NOT NULL,
	[Address Line 1] [nvarchar](50) NOT NULL,
	[Address Line 2] [nvarchar](50) NOT NULL,
	[Address Line 3] [nvarchar](50) NULL,
	[Country] [int] NOT NULL,
	[PostalCode] [int] NOT NULL,
	[Salutation] [nvarchar](5) NOT NULL,
	[Contact] [nvarchar](25) NOT NULL,
	[Telephone] [int] NOT NULL,
	[Handphone] [int] NOT NULL,
	[DOC] [varchar](50) NOT NULL,
	[Caltek Sales] [nvarchar](50) NOT NULL,
	[Transporter] [int] NOT NULL,
	[Note] [nvarchar](100) NULL,
	[Created] [datetime] NOT NULL,
	[Created by] [int] NOT NULL,
	[Modfied] [datetime] NOT NULL,
	[Modified by] [int] NULL,
	[Status] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CollectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Compliance]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compliance](
	[CId] [int] IDENTITY(1,1) NOT NULL,
	[RID] [int] NOT NULL,
	[Comments] [varchar](250) NOT NULL,
	[AOJ] [varchar](250) NOT NULL,
	[FC] [int] NOT NULL,
	[Department] [int] NOT NULL,
	[AuditCycle] [int] NOT NULL,
	[AStartDate] [date] NOT NULL,
	[AEndDate] [date] NOT NULL,
	[Auditor] [int] NOT NULL,
	[Auditee] [int] NOT NULL,
	[Status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RID] ASC,
	[AuditCycle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Country] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CoId] [int] IDENTITY(1,1) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Country] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Deliveryplan]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deliveryplan](
	[ProductionID] [int] NOT NULL,
	[DDate] [varchar](50) NOT NULL,
	[Agent] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DId] [int] IDENTITY(1,1) NOT NULL,
	[Department] [nvarchar](50) NOT NULL,
	[Division] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Department] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Eid] [int] NOT NULL,
	[FName] [varchar](50) NOT NULL,
	[MName] [varchar](50) NULL,
	[LName] [varchar](50) NOT NULL,
	[EmailID] [varchar](50) NOT NULL,
	[Department] [int] NOT NULL,
	[Gender] [varchar](10) NOT NULL,
	[Role] [int] NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[DOB] [varchar](50) NOT NULL,
	[Photo] [image] NULL,
PRIMARY KEY CLUSTERED 
(
	[Eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FCategory]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FCategory](
	[FId] [int] IDENTITY(1,1) NOT NULL,
	[FC] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Cat] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[FC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FocusData]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FocusData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date Received] [varchar](100) NOT NULL,
	[Job Number] [varchar](100) NOT NULL,
	[Client Name] [varchar](100) NOT NULL,
	[Quantity] [varchar](100) NOT NULL,
	[Instrument] [varchar](100) NOT NULL,
	[Department] [varchar](100) NOT NULL,
	[Serial No] [varchar](100) NOT NULL,
	[Delivery Date] [varchar](100) NOT NULL,
	[Certificate To] [varchar](100) NOT NULL,
	[Certificate Address] [varchar](250) NOT NULL,
	[Make] [varchar](100) NULL,
	[Model] [varchar](100) NULL,
	[Certification] [varchar](100) NOT NULL,
	[Compliance] [varchar](100) NOT NULL,
	[Cal. Interval] [varchar](100) NOT NULL,
	[Cal Points] [varchar](100) NULL,
	[Deliver To] [varchar](100) NOT NULL,
	[Delivery Address] [varchar](250) NOT NULL,
	[Attention] [varchar](100) NOT NULL,
	[Telephone] [varchar](100) NULL,
	[Salesperson] [varchar](100) NOT NULL,
	[Delivery Type] [varchar](100) NOT NULL,
	[TAT] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[iamsrole]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[iamsrole](
	[rid] [int] IDENTITY(1,1) NOT NULL,
	[role] [varchar](100) NOT NULL,
 CONSTRAINT [PK_iamsrole] PRIMARY KEY CLUSTERED 
(
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobRequest]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Client] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](250) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[PostalCode] [int] NOT NULL,
	[Contact] [nvarchar](50) NOT NULL,
	[Tel] [int] NOT NULL,
	[Remarks] [nvarchar](250) NOT NULL,
	[DOR] [date] NOT NULL,
	[JobNo] [nvarchar](50) NULL,
	[Sales] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobRequestInstruments]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobRequestInstruments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JRID] [int] NOT NULL,
	[Instrument] [nvarchar](100) NOT NULL,
	[Range] [nvarchar](25) NOT NULL,
	[Make] [nvarchar](25) NOT NULL,
	[Model] [nvarchar](25) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Cert. Type] [nvarchar](15) NOT NULL,
	[Cal. Points] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostAuditStatus]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostAuditStatus](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[AuditID] [int] NOT NULL,
	[Department] [int] NOT NULL,
	[CDate] [date] NOT NULL,
	[RDate] [date] NOT NULL,
	[VDate] [date] NOT NULL,
	[CloseStatus] [varchar](50) NOT NULL,
	[EComments] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductionAssigned]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductionAssigned](
	[ProductionID] [int] NOT NULL,
	[Date] [varchar](50) NOT NULL,
	[Employee] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductionPlan]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductionPlan](
	[ProductionID] [int] NOT NULL,
	[Date] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductionStatus]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductionStatus](
	[ProductionID] [int] NOT NULL,
	[Date] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[Remarks] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requirements]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requirements](
	[RId] [int] IDENTITY(1,1) NOT NULL,
	[Standards] [int] NOT NULL,
	[ClauseNo] [int] NOT NULL,
	[Subheader] [nvarchar](10) NULL,
	[Requirement] [nvarchar](250) NOT NULL,
	[ObjEvi] [nvarchar](250) NULL,
	[Department] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Standards] ASC,
	[ClauseNo] ASC,
	[Department] ASC,
	[Subheader] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[rid] [int] IDENTITY(1,1) NOT NULL,
	[role] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_role] PRIMARY KEY CLUSTERED 
(
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleButton]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleButton](
	[RBId] [int] IDENTITY(1,1) NOT NULL,
	[RId] [int] NOT NULL,
	[BId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RBId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScreenList]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScreenList](
	[ScreenID] [int] IDENTITY(1,1) NOT NULL,
	[ScreenName] [nvarchar](50) NOT NULL,
	[ParentName] [nvarchar](50) NOT NULL,
	[Rights] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ScreenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SessionLog]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Standards]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Standards](
	[sid] [int] IDENTITY(1,1) NOT NULL,
	[Standards] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Standards] PRIMARY KEY CLUSTERED 
(
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Standards] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table](
	[Type] [varchar](50) NOT NULL,
	[ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Userdata]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Userdata](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Repassword] [varchar](50) NOT NULL,
	[EmpID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usertable]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usertable](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[EmpID] [int] NOT NULL,
	[Role] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendor]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor](
	[VId] [int] IDENTITY(1,1) NOT NULL,
	[Vendor] [nvarchar](50) NOT NULL,
	[Address Line 1] [nvarchar](50) NOT NULL,
	[Address Line 2] [nvarchar](50) NOT NULL,
	[Address Line 3] [nvarchar](50) NULL,
	[Country] [int] NOT NULL,
	[PostalCode] [int] NOT NULL,
	[Salutation] [nvarchar](5) NOT NULL,
	[Contact] [nvarchar](25) NOT NULL,
	[Telephone] [int] NOT NULL,
	[Handphone] [int] NOT NULL,
	[Email ID] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Remarks] [nvarchar](50) NULL,
	[Last Modified] [timestamp] NOT NULL,
	[Created by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Vendor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorksheetReception]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorksheetReception](
	[ProductionID] [int] NOT NULL,
	[Certificate Prefix] [int] NOT NULL,
	[Certificate No.] [varchar](10) NOT NULL,
	[Certificate Year] [int] NOT NULL,
	[Allocated To] [int] NOT NULL,
	[Note] [varchar](100) NOT NULL,
	[Allocated Time] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Certificate Prefix] ASC,
	[Certificate No.] ASC,
	[Certificate Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductionStatusView]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductionStatusView]
	AS 
Select 
Focusdata.Id, 
FocusData.Instrument,  
CONVERT(Date, FocusData.[Date Received]) as [Date Received], 
FocusData.[Job Number], 
FocusData.[Client Name], 
FocusData.Quantity, 
FocusData.Department, 
FocusData.[Serial No], 
CONVERT(Date, FocusData.[Delivery Date]) as [Delivery Date], 
FocusData.Certification,
OVERALL.Status from FocusData JOIN 
(Select ID AS ID, Status = 'Unplanned' from FocusData Where ID NOT IN (Select ProductionID from ProductionPlan)  UNION
Select ProductionID as ID, Status = 'Unassigned' from ProductionPlan Where ProductionID NOT IN (Select ProductionID from ProductionAssigned) UNION
Select ProductionID AS ID, Status = 'Assigned' from ProductionAssigned Where ProductionID NOT IN (Select ProductionID from ProductionStatus) UNION
Select ProductionID AS ID, Status = 'Calibrated' from ProductionStatus Where Status = 'Completed' UNION
Select ProductionID AS ID, Status = ' Calibration On-hold' from ProductionStatus Where Status = 'On-hold' UNION
Select ProductionID AS ID, Status = 'Certicate Completed' from CertificateStatus Where [Certificate Status] = 'Completed' UNION
Select ProductionID AS ID, Status = 'Certificate Incomplete' from ProductionStatus Where Status = 'Incomplete' UNION
Select ProductionID AS ID, Status = 'Delivery Planned' from Deliveryplan) AS OVERALL
ON FocusData.Id = Overall.ID
GO
ALTER TABLE [dbo].[CertificateStatus] ADD  DEFAULT ('NA') FOR [Remarks]
GO
ALTER TABLE [dbo].[CertificateStatus] ADD  DEFAULT ((0)) FOR [MidState]
GO
ALTER TABLE [dbo].[WorksheetReception] ADD  DEFAULT ('NA') FOR [Note]
GO
ALTER TABLE [dbo].[AccessRights]  WITH CHECK ADD  CONSTRAINT [FK_AccessRights_RoleID] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([rid])
GO
ALTER TABLE [dbo].[AccessRights] CHECK CONSTRAINT [FK_AccessRights_RoleID]
GO
ALTER TABLE [dbo].[AccessRights]  WITH CHECK ADD  CONSTRAINT [FK_AccessRights_ScreenID] FOREIGN KEY([ScreenID])
REFERENCES [dbo].[ScreenList] ([ScreenID])
GO
ALTER TABLE [dbo].[AccessRights] CHECK CONSTRAINT [FK_AccessRights_ScreenID]
GO
ALTER TABLE [dbo].[AuditActual]  WITH CHECK ADD  CONSTRAINT [FK_AuditActual_AuditPlan] FOREIGN KEY([PlanId])
REFERENCES [dbo].[AuditPlan] ([AId])
GO
ALTER TABLE [dbo].[AuditActual] CHECK CONSTRAINT [FK_AuditActual_AuditPlan]
GO
ALTER TABLE [dbo].[AuditActual]  WITH CHECK ADD  CONSTRAINT [FK_AuditActual_Employee] FOREIGN KEY([EMPID])
REFERENCES [dbo].[Employee] ([Eid])
GO
ALTER TABLE [dbo].[AuditActual] CHECK CONSTRAINT [FK_AuditActual_Employee]
GO
ALTER TABLE [dbo].[AuditLog]  WITH CHECK ADD  CONSTRAINT [FK_AuditLog_User] FOREIGN KEY([User])
REFERENCES [dbo].[Usertable] ([Username])
GO
ALTER TABLE [dbo].[AuditLog] CHECK CONSTRAINT [FK_AuditLog_User]
GO
ALTER TABLE [dbo].[AuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_AuditPlan_AuditCycle] FOREIGN KEY([AuditID])
REFERENCES [dbo].[AuditCycle] ([ACId])
GO
ALTER TABLE [dbo].[AuditPlan] CHECK CONSTRAINT [FK_AuditPlan_AuditCycle]
GO
ALTER TABLE [dbo].[AuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_AuditPlan_Department] FOREIGN KEY([Department])
REFERENCES [dbo].[Department] ([DId])
GO
ALTER TABLE [dbo].[AuditPlan] CHECK CONSTRAINT [FK_AuditPlan_Department]
GO
ALTER TABLE [dbo].[AuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_AuditPlan_Employee] FOREIGN KEY([EMPID])
REFERENCES [dbo].[Employee] ([Eid])
GO
ALTER TABLE [dbo].[AuditPlan] CHECK CONSTRAINT [FK_AuditPlan_Employee]
GO
ALTER TABLE [dbo].[AuditPlan]  WITH CHECK ADD  CONSTRAINT [FK_AuditPlan_Standards] FOREIGN KEY([Criteria])
REFERENCES [dbo].[Standards] ([sid])
GO
ALTER TABLE [dbo].[AuditPlan] CHECK CONSTRAINT [FK_AuditPlan_Standards]
GO
ALTER TABLE [dbo].[Clause]  WITH CHECK ADD  CONSTRAINT [FK_Clause_Standards] FOREIGN KEY([Standard])
REFERENCES [dbo].[Standards] ([sid])
GO
ALTER TABLE [dbo].[Clause] CHECK CONSTRAINT [FK_Clause_Standards]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD FOREIGN KEY([Caltek Sales])
REFERENCES [dbo].[Employee] ([Eid])
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD FOREIGN KEY([Country])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD FOREIGN KEY([Country])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD FOREIGN KEY([Created by])
REFERENCES [dbo].[Employee] ([Eid])
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD FOREIGN KEY([Modified by])
REFERENCES [dbo].[Employee] ([Eid])
GO
ALTER TABLE [dbo].[Compliance]  WITH CHECK ADD  CONSTRAINT [FK_Compliance_FC] FOREIGN KEY([FC])
REFERENCES [dbo].[FCategory] ([FId])
GO
ALTER TABLE [dbo].[Compliance] CHECK CONSTRAINT [FK_Compliance_FC]
GO
ALTER TABLE [dbo].[Compliance]  WITH CHECK ADD  CONSTRAINT [FK_Compliance_RID] FOREIGN KEY([RID])
REFERENCES [dbo].[Requirements] ([RId])
GO
ALTER TABLE [dbo].[Compliance] CHECK CONSTRAINT [FK_Compliance_RID]
GO
ALTER TABLE [dbo].[Deliveryplan]  WITH CHECK ADD  CONSTRAINT [Deliveryplan_Agent] FOREIGN KEY([Agent])
REFERENCES [dbo].[Vendor] ([VId])
GO
ALTER TABLE [dbo].[Deliveryplan] CHECK CONSTRAINT [Deliveryplan_Agent]
GO
ALTER TABLE [dbo].[Deliveryplan]  WITH CHECK ADD  CONSTRAINT [Deliveryplan_ProductionID] FOREIGN KEY([ProductionID])
REFERENCES [dbo].[FocusData] ([Id])
GO
ALTER TABLE [dbo].[Deliveryplan] CHECK CONSTRAINT [Deliveryplan_ProductionID]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([Department])
REFERENCES [dbo].[Department] ([DId])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([rid])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Role]
GO
ALTER TABLE [dbo].[JobRequestInstruments]  WITH CHECK ADD  CONSTRAINT [FK_JRID] FOREIGN KEY([JRID])
REFERENCES [dbo].[JobRequest] ([Id])
GO
ALTER TABLE [dbo].[JobRequestInstruments] CHECK CONSTRAINT [FK_JRID]
GO
ALTER TABLE [dbo].[PostAuditStatus]  WITH CHECK ADD  CONSTRAINT [FK_PostAuditStatus_AuditCycle] FOREIGN KEY([AuditID])
REFERENCES [dbo].[AuditCycle] ([ACId])
GO
ALTER TABLE [dbo].[PostAuditStatus] CHECK CONSTRAINT [FK_PostAuditStatus_AuditCycle]
GO
ALTER TABLE [dbo].[PostAuditStatus]  WITH CHECK ADD  CONSTRAINT [FK_PostAuditStatus_Department] FOREIGN KEY([Department])
REFERENCES [dbo].[Department] ([DId])
GO
ALTER TABLE [dbo].[PostAuditStatus] CHECK CONSTRAINT [FK_PostAuditStatus_Department]
GO
ALTER TABLE [dbo].[ProductionAssigned]  WITH CHECK ADD  CONSTRAINT [FK_ProductionPlan_Employee] FOREIGN KEY([Employee])
REFERENCES [dbo].[Employee] ([Eid])
GO
ALTER TABLE [dbo].[ProductionAssigned] CHECK CONSTRAINT [FK_ProductionPlan_Employee]
GO
ALTER TABLE [dbo].[ProductionAssigned]  WITH CHECK ADD  CONSTRAINT [FK_ProductionPlan_ProductionAssignedID] FOREIGN KEY([ProductionID])
REFERENCES [dbo].[FocusData] ([Id])
GO
ALTER TABLE [dbo].[ProductionAssigned] CHECK CONSTRAINT [FK_ProductionPlan_ProductionAssignedID]
GO
ALTER TABLE [dbo].[ProductionPlan]  WITH CHECK ADD  CONSTRAINT [FK_ProductionPlan_ProductionPlanID] FOREIGN KEY([ProductionID])
REFERENCES [dbo].[FocusData] ([Id])
GO
ALTER TABLE [dbo].[ProductionPlan] CHECK CONSTRAINT [FK_ProductionPlan_ProductionPlanID]
GO
ALTER TABLE [dbo].[ProductionStatus]  WITH CHECK ADD  CONSTRAINT [FK_ProductionPlan_ProductionStatusID] FOREIGN KEY([ProductionID])
REFERENCES [dbo].[FocusData] ([Id])
GO
ALTER TABLE [dbo].[ProductionStatus] CHECK CONSTRAINT [FK_ProductionPlan_ProductionStatusID]
GO
ALTER TABLE [dbo].[Requirements]  WITH CHECK ADD  CONSTRAINT [FK_Requirements_Clause] FOREIGN KEY([ClauseNo])
REFERENCES [dbo].[Clause] ([CId])
GO
ALTER TABLE [dbo].[Requirements] CHECK CONSTRAINT [FK_Requirements_Clause]
GO
ALTER TABLE [dbo].[Requirements]  WITH CHECK ADD  CONSTRAINT [FK_Requirements_Department] FOREIGN KEY([Department])
REFERENCES [dbo].[Department] ([DId])
GO
ALTER TABLE [dbo].[Requirements] CHECK CONSTRAINT [FK_Requirements_Department]
GO
ALTER TABLE [dbo].[Requirements]  WITH CHECK ADD  CONSTRAINT [FK_Requirements_Standards1] FOREIGN KEY([Standards])
REFERENCES [dbo].[Standards] ([sid])
GO
ALTER TABLE [dbo].[Requirements] CHECK CONSTRAINT [FK_Requirements_Standards1]
GO
ALTER TABLE [dbo].[RoleButton]  WITH CHECK ADD FOREIGN KEY([BId])
REFERENCES [dbo].[ButtonList] ([BId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[RoleButton]  WITH CHECK ADD FOREIGN KEY([RId])
REFERENCES [dbo].[iamsrole] ([rid])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SessionLog]  WITH CHECK ADD  CONSTRAINT [SessionID_Username] FOREIGN KEY([Username])
REFERENCES [dbo].[Usertable] ([UID])
GO
ALTER TABLE [dbo].[SessionLog] CHECK CONSTRAINT [SessionID_Username]
GO
ALTER TABLE [dbo].[Userdata]  WITH CHECK ADD FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([Eid])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Usertable]  WITH CHECK ADD  CONSTRAINT [FK_Usertabe_Employee] FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([Eid])
GO
ALTER TABLE [dbo].[Usertable] CHECK CONSTRAINT [FK_Usertabe_Employee]
GO
ALTER TABLE [dbo].[Usertable]  WITH CHECK ADD  CONSTRAINT [FK_Usertable_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([rid])
GO
ALTER TABLE [dbo].[Usertable] CHECK CONSTRAINT [FK_Usertable_Role]
GO
ALTER TABLE [dbo].[Vendor]  WITH CHECK ADD FOREIGN KEY([Country])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[WorksheetReception]  WITH CHECK ADD  CONSTRAINT [ProductionCertificate_AllocatedTo] FOREIGN KEY([Allocated To])
REFERENCES [dbo].[Employee] ([Eid])
GO
ALTER TABLE [dbo].[WorksheetReception] CHECK CONSTRAINT [ProductionCertificate_AllocatedTo]
GO
ALTER TABLE [dbo].[WorksheetReception]  WITH CHECK ADD  CONSTRAINT [ProductionCertificate_CertificateID] FOREIGN KEY([Certificate Prefix])
REFERENCES [dbo].[CertPrefix] ([Id])
GO
ALTER TABLE [dbo].[WorksheetReception] CHECK CONSTRAINT [ProductionCertificate_CertificateID]
GO
ALTER TABLE [dbo].[WorksheetReception]  WITH CHECK ADD  CONSTRAINT [ProductionCertificate_ProductionID] FOREIGN KEY([ProductionID])
REFERENCES [dbo].[FocusData] ([Id])
GO
ALTER TABLE [dbo].[WorksheetReception] CHECK CONSTRAINT [ProductionCertificate_ProductionID]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [CHK_Salutation] CHECK  (([Salutation]='Ms.' OR [Salutation]='Mrs.' OR [Salutation]='Mr.'))
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [CHK_Salutation]
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD  CONSTRAINT [CHK_Collection_Salutation] CHECK  (([Salutation]='Ms.' OR [Salutation]='Mrs.' OR [Salutation]='Mr.'))
GO
ALTER TABLE [dbo].[Collection] CHECK CONSTRAINT [CHK_Collection_Salutation]
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD  CONSTRAINT [CHK_Collection_Status] CHECK  (([Status]='New' OR [Status]='Updated' OR [Status]='Deleted'))
GO
ALTER TABLE [dbo].[Collection] CHECK CONSTRAINT [CHK_Collection_Status]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [CHK_Division] CHECK  (([Division]='Support' OR [Division]='Technical'))
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [CHK_Division]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CHK_Gender] CHECK  (([Gender]='Male' OR [Gender]='Female'))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CHK_Gender]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CHK_Status] CHECK  (([Status]='Active' OR [Status]='Inactive'))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CHK_Status]
GO
ALTER TABLE [dbo].[ProductionStatus]  WITH CHECK ADD  CONSTRAINT [CHK_ProductionStatus_Status] CHECK  (([Status]='Certificate' OR [Status]='On-hold'))
GO
ALTER TABLE [dbo].[ProductionStatus] CHECK CONSTRAINT [CHK_ProductionStatus_Status]
GO
ALTER TABLE [dbo].[Usertable]  WITH CHECK ADD  CONSTRAINT [CK_Usertable_Password] CHECK  ((len([Password])>=(8)))
GO
ALTER TABLE [dbo].[Usertable] CHECK CONSTRAINT [CK_Usertable_Password]
GO
ALTER TABLE [dbo].[Usertable]  WITH CHECK ADD  CONSTRAINT [CK_Usertable_Username] CHECK  ((len([Username])>=(8)))
GO
ALTER TABLE [dbo].[Usertable] CHECK CONSTRAINT [CK_Usertable_Username]
GO
ALTER TABLE [dbo].[Vendor]  WITH CHECK ADD  CONSTRAINT [CHK_Vendor_Salutation] CHECK  (([Salutation]='Ms.' OR [Salutation]='Mrs.' OR [Salutation]='Mr.'))
GO
ALTER TABLE [dbo].[Vendor] CHECK CONSTRAINT [CHK_Vendor_Salutation]
GO
ALTER TABLE [dbo].[Vendor]  WITH CHECK ADD  CONSTRAINT [CHK_Vendor_Status] CHECK  (([Status]='Active' OR [Status]='Inactive'))
GO
ALTER TABLE [dbo].[Vendor] CHECK CONSTRAINT [CHK_Vendor_Status]
GO
/****** Object:  StoredProcedure [dbo].[AccessRights_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccessRights_Insert]
	  @Role INT,
	  @Dtable Accesstype Readonly 
AS
BEGIN
		SET NOCOUNT ON;
		Delete AccessRights Where RoleID=@Role
      INSERT INTO AccessRights(RoleID, ScreenID)
      Select RoleID, ScreenID from @Dtable
END
GO
/****** Object:  StoredProcedure [dbo].[Certificatestatus_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Certificatestatus_Insert]
        @ProductionID INT,
		@Certstatus VARCHAR(10),
		@Date VARCHAR (50),
		@Note VARCHAR (100),
		@Midstate INT
AS BEGIN
		SET NOCOUNT ON;
		INSERT INTO CertificateStatus(ProductionID, [Certificate Status], Date, Remarks, MidState)
		VALUES
		(@ProductionID, @Certstatus, @Date, @Note, @Midstate)
END
GO
/****** Object:  StoredProcedure [dbo].[Client_Delete]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Client_Delete]
	@CID INT
AS BEGIN
	Delete Client Where CId = @Cid
END
GO
/****** Object:  StoredProcedure [dbo].[Client_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Client_Insert]
	@Client NVARCHAR(50),
	@AddressLine1 NVARCHAR(50),
	@AddressLine2 NVARCHAR(50),
	@AddressLine3 NVARCHAR(50),
	@Country NVARCHAR(50),
	@Postalcode INT,
	@Salutation NVARCHAR(5),
	@Contact NVARCHAR(25),
	@Telephone INT,
	@Handphone INT,
	@EmailID VARCHAR(50),
	@CaltekSales NVARCHAR(50),
	@Createduser NVARCHAR(50),
	@Remarks NVARCHAR (50)
AS
BEGIN
	Insert into Client 
	(Client, [Address Line 1], [Address Line 2], [Address Line 3], Country, PostalCode, Salutation, Contact, Telephone, Handphone, [Email ID], [Caltek Sales], Remarks, [Created by])
	VALUES
	(@Client, @AddressLine1, @AddressLine2, @AddressLine3, (Select CountryID from Countries Where Country=@Country), @Postalcode, @Salutation, @Contact, @Telephone, @Handphone, @EmailID, (select EID from Employee Where concat(Eid, '-', FName,' ', LName) = @Calteksales), @Remarks, (select Uid from Usertable Where Username = @Createduser))
END
GO
/****** Object:  StoredProcedure [dbo].[Client_Update]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Client_Update]
	@ClientID INT,
	@AddressLine1 NVARCHAR(50),
	@AddressLine2 NVARCHAR(50),
	@AddressLine3 NVARCHAR(50),
	@Country NVARCHAR(50),
	@Postalcode INT,
	@Salutation NVARCHAR(5),
	@Contact NVARCHAR(25),
	@Telephone INT,
	@Handphone INT,
	@EmailID VARCHAR(50),
	@CaltekSales NVARCHAR(50),
	@Createduser NVARCHAR(50),
	@Remarks NVARCHAR (50)
AS
BEGIN
	Update Client 
	Set
	[Address Line 1]=@AddressLine1, 
	[Address Line 2]=@AddressLine2,
	[Address Line 3]=@AddressLine3,
	Country=(Select CountryID from Countries Where Country=@Country), 
	PostalCode=@Postalcode,
	Salutation=@Salutation,
	Contact=@Contact,
	Telephone=@Telephone,
	Handphone=@Handphone,
	[Email ID]=@EmailID,
	[Caltek Sales]=(select EID from Employee Where concat(Eid,'-',FName,' ', LName) = @Calteksales),
	Remarks=@Remarks,
	[Created by]=(select Uid from Usertable Where Username = @Createduser)
	Where CID=@ClientID
END
GO
/****** Object:  StoredProcedure [dbo].[Collection_Delete]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Collection_Delete]
	@CollectionID INT,
	@Status NVARCHAR(10)
AS
BEGIN
	Update Collection
	Set
	Status=@Status
	Where CollectionId=@CollectionID
END
GO
/****** Object:  StoredProcedure [dbo].[Collection_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Collection_Insert]
	@Client NVARCHAR(50),
	@AddressLine1 NVARCHAR(50),
	@AddressLine2 NVARCHAR(50),
	@AddressLine3 NVARCHAR(50),
	@Country NVARCHAR(50),
	@Postalcode INT,
	@Salutation NVARCHAR(5),
	@Contact NVARCHAR(25),
	@Telephone INT,
	@Handphone INT,
	@DOC VARCHAR(50),
	@CaltekSales NVARCHAR(50),
	@Transporter NVARCHAR(50),
	@Note NVARCHAR (100),
	@Createduser NVARCHAR(50),
	@Created DATETIME,
	@Modifieduser NVARCHAR(50),
	@Modified DATETIME,
	@Status NVARCHAR(10)
AS
BEGIN
	Insert into Collection
	(Client, [Address Line 1], [Address Line 2], [Address Line 3], Country, PostalCode, Salutation, Contact, Telephone, Handphone, DOC, [Caltek Sales], Transporter, Note, [Created by], Created, Modfied, [Modified by], Status)
	VALUES
	(@Client, @AddressLine1, @AddressLine2, @AddressLine3, (Select CountryID from Countries Where Country=@Country), @Postalcode, @Salutation, @Contact, @Telephone, @Handphone, @DOC, (select EID from Employee Where concat(FName,' ', LName) = @Calteksales), (Select VID from Vendor Where Vendor=@Transporter), @Note, (select Uid from Usertable Where Username = @Createduser),@Created,@Modified,(select Uid from Usertable Where Username = @Modifieduser),@Status)
END
GO
/****** Object:  StoredProcedure [dbo].[Collection_Update]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Collection_Update]
	@CollectionID INT,
	@AddressLine1 NVARCHAR(50),
	@AddressLine2 NVARCHAR(50),
	@AddressLine3 NVARCHAR(50),
	@Country NVARCHAR(50),
	@Postalcode INT,
	@Salutation NVARCHAR(5),
	@Contact NVARCHAR(25),
	@Telephone INT,
	@Handphone INT,
	@DOC VARCHAR(50),
	@CaltekSales NVARCHAR(50),
	@Transporter NVARCHAR(50),
	@Note NVARCHAR (100),
	@Modifieduser NVARCHAR(50),
	@Modified DATETIME,
	@Status NVARCHAR(10)
AS
BEGIN
	Update Collection
	Set
	[Address Line 1]=@AddressLine1, 
	[Address Line 2]=@AddressLine2, 
	[Address Line 3]=@AddressLine3, 
	Country=(Select CountryID from Countries Where Country=@Country),
	PostalCode=@Postalcode, 
	Salutation=@Salutation, 
	Contact=@Contact, 
	Telephone=@Telephone, 
	Handphone=@Handphone, 
	DOC=@DOC, 
	[Caltek Sales]=(select EID from Employee Where concat(FName,' ', LName) = @Calteksales), 
	Transporter=(Select Vid from Vendor Where Vendor=@Transporter), 
	Note=@Note, 
	Modfied=@Modified, 
	[Modified by]=(select Uid from Usertable Where Username = @Modifieduser),
	Status=@Status
	Where CollectionId=@CollectionID
END
GO
/****** Object:  StoredProcedure [dbo].[CreateServer]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateServer]
   @FileLocation varchar(100)
AS
BEGIN
Declare @Servername nvarchar(50) = N'Excelserver'
Declare @SQL nvarchar(500)
EXEC master.dbo.sp_addlinkedserver @server = @Servername, @srvproduct=N'Excel', @provider=N'Microsoft.ACE.OLEDB.12.0', @datasrc= @FileLocation, @provstr=N'Excel 12.0;IMEX=1;HDR=YES;'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=@Servername, @useself=N'False', @locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=@Servername, @useself=N'True', @locallogin=N'CALTEK\vikram.mgmt', @rmtuser=NULL,@rmtpassword=NULL
END
GO
/****** Object:  StoredProcedure [dbo].[Datasheetstatus_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Datasheetstatus_Insert]
        @ProductionID INT,
		@Certprefix VARCHAR(10),
		@CertNo VARCHAR (10),
		@Certyear INT,
		@Employee VARCHAR (100),
		@Note VARCHAR (100),
		@Date VARCHAR (50)
AS BEGIN
		SET NOCOUNT ON;
		INSERT INTO WorksheetReception(ProductionID, [Certificate Prefix], [Certificate No.], [Certificate Year], [Allocated To], Note, [Allocated Time])
		VALUES
		(@ProductionID, (Select Id from CertPrefix Where Prefix=@Certprefix), @CertNo, @Certyear, (Select Eid from Employee Where concat(Eid, '-', FName,' ' , LName)=@Employee), @Note, @Date)
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteAuditPlan]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAuditPlan]
	@Aid Int
	As Begin
	Delete AuditPlan where AId = @Aid
	End

GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteEmployee]
	@eid INT
AS BEGIN
	Delete Employee Where EId = @eid
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteRoleButton]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteRoleButton]
	@rid varchar (100)
AS BEGIN
	Delete RoleButton Where RId = (Select rid from iamsrole Where Role = @rid)
END

GO
/****** Object:  StoredProcedure [dbo].[Deliveryplan_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Deliveryplan_Insert]
	  @Dt DelPlantype Readonly 
AS
BEGIN
		SET NOCOUNT ON;
		INSERT INTO Deliveryplan(ProductionID, DDate)
		Select ProductionID, Date from @Dt
END
GO
/****** Object:  StoredProcedure [dbo].[DeliveryplanAgent_Update]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeliveryplanAgent_Update]
	@Dt DatatableType Readonly,
	@Dt1 DatatableType Readonly,
	@Agent VARCHAR (50)
AS BEGIN
	Update Deliveryplan Set Agent = (Select VID from Vendor Where Vendor = @Agent) Where ProductionID IN (Select * from @Dt)
	Update Collection Set Transporter = (Select VID from Vendor Where Vendor = @Agent) Where CollectionId IN (Select * from @Dt1)
END
GO
/****** Object:  StoredProcedure [dbo].[Dept_Delete]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dept_Delete]
	@Did INT
AS BEGIN
	Delete Department Where DId = @Did
END
GO
/****** Object:  StoredProcedure [dbo].[Dept_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dept_Insert]
@Department NVARCHAR(50),
@Division NVARCHAR (50)
AS
BEGIN
INSERT INTO Department(Department, Division) VALUES (@Department, @Division)
END
GO
/****** Object:  StoredProcedure [dbo].[Dept_Update]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dept_Update]
@Did INT,
@Department NVARCHAR(50),
@Division NVARCHAR (50)
AS BEGIN
UPDATE Department
Set Department=@Department, Division=@Division WHERE Did = @Did
End
GO
/****** Object:  StoredProcedure [dbo].[InsertintoAuditActual]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoAuditActual]
	@PlanID Int,
	@Auditdate date,
	@Comments varchar(100),
	@EID INT,
	@Status VARCHAR (100)
AS
BEGIN
DELETE AuditActual Where PlanId = @PlanID
INSERT INTO AuditActual(PlanID, AuditDate, Comments, EMPID, Status) VALUES 
(
@PlanID,
@Auditdate, 
@Comments,
@EID,
@Status
)
Update AuditPlan
Set ExecuteStatus = @Status Where AID = @PlanID
END

GO
/****** Object:  StoredProcedure [dbo].[InsertintoAuditCycle]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoAuditCycle]
	@AuditID varchar(10)
AS BEGIN
Insert into AuditCycle(AuditID)Values(@AuditID)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertintoAuditPlan]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoAuditPlan]
	@AuditID varchar(10),
	@Criteria varchar(50),
	@Department varchar(50),
	@Auditdate date,
	@Comments varchar(100),
	@EID INT
AS
BEGIN
INSERT INTO AuditPlan(AuditID, Criteria, Department, AuditDate, Comments, EMPID) VALUES 
(
(Select Acid from AuditCycle where AuditID = @AuditID), 
(Select sid from Standards where Standards = @Criteria), 
(Select Did from Department where Department = @Department),
@Auditdate, 
@Comments,
@EID
)
END

GO
/****** Object:  StoredProcedure [dbo].[InsertintoClause]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoClause]
@ClauseNo nVARCHAR(50),
@Standard NVARCHAR (50),
@Content NVARCHAR (50)
AS
BEGIN
INSERT INTO Clause(ClauseNo, Standard, Content) VALUES (@ClauseNo, (Select sid from Standards where Standards = @Standard), @Content)
END

GO
/****** Object:  StoredProcedure [dbo].[InsertintoCompliance]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoCompliance]
@RID int,
@Comments VARCHAR (250),
@AOJ VARCHAR (250),
@FC VARCHAR (50),
@Department VARCHAR (50),
@AuditCycle VARCHAR (50),
@AStartDate Date,
@AEndDate Date,
@Auditor varchar(100),
@Auditee Int
AS
BEGIN
INSERT INTO Compliance(RID, Comments, AOJ, FC, Department, AuditCycle, AStartDate, AEndDate, Auditor, Auditee) VALUES 
(
@RID, 
@Comments,
@AOJ,
(Select FID from FCategory Where Description = @FC),
(Select DID from Department Where Department = @Department),
(Select ACID from AuditCycle Where AuditID = @AuditCycle),
@AStartDate,
@AEndDate,
(Select EMPID from Userdata Where Username = @Auditor),
@Auditee
)
END

GO
/****** Object:  StoredProcedure [dbo].[Insertintodept]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insertintodept]
@department nVARCHAR(50),
@Division nVARCHAR (50)
AS
BEGIN
INSERT INTO Department(Department, Division) VALUES (@department, @Division)
END

GO
/****** Object:  StoredProcedure [dbo].[Insertintoemployee]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insertintoemployee]
@Eid int,
@FName VARCHAR(50),
@MName VARCHAR (50),
@LName VARCHAR (50),
@EmailID VARCHAR (50),
@Department VARCHAR (50),
@Gender VARCHAR (10),
@Role VARCHAR (50),
@Status VARCHAR (10),
@DOB DATE
AS
BEGIN
INSERT INTO Employee(eid, FName, MName, LName, EmailID, Department, Gender, Role, Status, DOB) VALUES (@eid, @FName, @MName, @LName, @EmailID, (select Did from Department where Department = @Department), @Gender, (select rid from role where Role = @Role), @Status, @DOB)
END

--INSERT INTO Employee(eid, FName, MName, LName, EmailID, Department, Gender, Role, Status, DOB) VALUES (@eid, @FName, @MName, @LName, @EmailID, @Department, @Gender, @Role, @Status, @DOB)
GO
/****** Object:  StoredProcedure [dbo].[InsertintoFCategory]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoFCategory]
@FC nVARCHAR(50),
@Description nVARCHAR (250),
@Cat VARCHAR (50)
AS
BEGIN
INSERT INTO FCategory(FC, Description, Cat) VALUES (@FC, @Description, @Cat)
END

GO
/****** Object:  StoredProcedure [dbo].[InsertintoPostStatus]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoPostStatus]
	@AIDP varchar(100),
	@DepartmentP varchar(100),
	@CDate DATE, 
    @RDate DATE, 
    @VDate DATE, 
	@EComments varchar(250),
	@CloseStatus varchar(50)
AS
BEGIN
DELETE PostAuditStatus Where AuditID = (Select ACID from AuditCycle Where AuditID = @AIDP) and Department = (Select DID from Department Where Department = @DepartmentP)
INSERT INTO PostAuditStatus(AuditID, Department, CDate, RDate, VDAte, CloseStatus, EComments) VALUES 
(
(Select ACID from AuditCycle Where AuditID = @AIDP),
(Select DID from Department Where Department = @DepartmentP), 
@CDate,
@RDate,
@VDate,
@CloseStatus,
@EComments
)
END

GO
/****** Object:  StoredProcedure [dbo].[InsertintoRequirements]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoRequirements]
@Standards NVARCHAR (50),
@ClauseNo NVARCHAR (50),
@Subheader NVARCHAR (10),
@Requiement NVARCHAR (250),
@ObjEvi NVARCHAR (250),
@Department NVARCHAR (50)
AS
BEGIN
INSERT INTO Requirements(Standards, ClauseNo, Subheader, Requirement, ObjEvi, Department) VALUES ((Select sid from Standards where Standards = @Standards), 
(Select cid from Clause where ClauseNo = @ClauseNo), @Subheader, @Requiement, @ObjEvi, (Select did from Department where Department = @Department))
END

GO
/****** Object:  StoredProcedure [dbo].[Insertintorole]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insertintorole]
@role varchar(100)
AS
BEGIN
INSERT INTO iamsrole(role) VALUES (@role)
END

GO
/****** Object:  StoredProcedure [dbo].[InsertintoRoleButton]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoRoleButton]
	@RID Varchar(100),
	@BID varchar (100)
AS
BEGIN
INSERT INTO RoleButton(RId, BId) VALUES 
(
(Select Rid from iamsrole where Role = @RID),
(Select Bid from ButtonList where ButtonName = @BID)
)
END

GO
/****** Object:  StoredProcedure [dbo].[InsertintoStandards]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertintoStandards]
@Standards varchar(50)
AS
BEGIN
INSERT INTO Standards(Standards) VALUES (@Standards)
END

GO
/****** Object:  StoredProcedure [dbo].[Insertintouserdata]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insertintouserdata]
@Username varchar(50),
@Password VARCHAR(50),
@Repassword VARCHAR (50),
@Photo Image,
@EmpID Int
AS
BEGIN
INSERT INTO Userdata(Username, Password, Repassword, Photo, EmpID) VALUES (@Username, @Password, @RePassword, @Photo, @EmpID)
END

GO
/****** Object:  StoredProcedure [dbo].[Linked_CreateServer]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Linked_CreateServer]
	@FileLocation varchar(100),
	@Linkedserver varchar(50),
	@UserID nvarchar(50)
AS
BEGIN
EXEC master.dbo.sp_addlinkedserver @server = @Linkedserver, @srvproduct=N'Excel', @provider=N'Microsoft.ACE.OLEDB.12.0', @datasrc= @FileLocation, @provstr=N'Excel 12.0;IMEX=1;HDR=YES;'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=@Linkedserver, @useself=N'False', @locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=@Linkedserver, @useself=N'True', @locallogin=@UserID, @rmtuser=NULL,@rmtpassword=NULL
END
GO
/****** Object:  StoredProcedure [dbo].[Linked_DropServer]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Linked_DropServer]
@LinkedServer NVARCHAR(50)
AS
BEGIN
EXEC master.dbo.sp_dropserver @server = @LinkedServer, @droplogins='droplogins'
END
GO
/****** Object:  StoredProcedure [dbo].[Linked_Insertdata]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Linked_Insertdata]
	@tablename VARCHAR(100),
	@Servername VARCHAR(100)
AS
BEGIN
DECLARE @sql varchar(1000)
SET @sql = 'INSERT INTO ' + @tablename + ' SELECT * FROM OPENQUERY(' + @Servername + ', ''SELECT * FROM [Sheet1$]'')'
EXEC @sql
END
GO
/****** Object:  StoredProcedure [dbo].[Password_Update]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Password_Update]
	@Username VARCHAR (50),
	@Password VARCHAR (100)
AS BEGIN
UPDATE Usertable
Set 
Password=@Password where Username = @Username
END
GO
/****** Object:  StoredProcedure [dbo].[ProdAssigned_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdAssigned_Insert]
	  @Dt ProdAssignedType Readonly,
	  @Employee VARCHAR(100)
AS
BEGIN
		SET NOCOUNT ON;
		INSERT INTO ProductionAssigned(ProductionId, Date, Employee)
		Select ProductionID, Date, (select Eid from Employee Where concat(Eid,'-',FName,' ',LName) = @Employee) from @Dt
END
GO
/****** Object:  StoredProcedure [dbo].[ProdPlan_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProdPlan_Insert]
	  @Dt ProdPlanType Readonly
AS
BEGIN
		SET NOCOUNT ON;
		INSERT INTO ProductionPlan(ProductionId, Date)
		Select ProductionID, Date from @Dt
END
GO
/****** Object:  StoredProcedure [dbo].[ProductionStatus_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductionStatus_Insert]
	  @ProductionID INT,
	  @Date VARCHAR(100),
	  @Status VARCHAR(100),
	  @Remarks VARCHAR(250)
AS
BEGIN
		SET NOCOUNT ON;
		DELETE ProductionStatus Where ProductionID = @ProductionID
		INSERT INTO ProductionStatus VALUES
		(@ProductionId, @Date, @Status, @Remarks)	
END
GO
/****** Object:  StoredProcedure [dbo].[Role_Delete]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_Delete]
	@rid INT
AS BEGIN
	Delete Role Where rId = @rid
END
GO
/****** Object:  StoredProcedure [dbo].[Role_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_Insert]
@Role NVARCHAR(50)
AS
BEGIN
INSERT INTO Role(role) VALUES (@Role)
END
GO
/****** Object:  StoredProcedure [dbo].[Role_Update]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_Update]
@rid INT,
@Role NVARCHAR(50)
AS BEGIN
UPDATE Role
Set role=@Role WHERE rid = @rid
End
GO
/****** Object:  StoredProcedure [dbo].[UpdateAuditActual]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAuditActual]
	@ActualID int,
	@Auditdate date,
	@Comments varchar(100),
	@EID INT,
	@Status VARCHAR (100)
AS BEGIN
UPDATE AuditActual
Set 
AuditDate=@Auditdate, 
Comments=@Comments,
EMPID=@EID,
Status=@Status
where ActualId = @ActualID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateAuditCycle]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAuditCycle]
	@Acid int,
	@AuditID varchar(10)
AS BEGIN
UPDATE AuditCycle
Set 
AuditID=@AuditID
where ACId = @Acid
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateAuditPlan]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAuditPlan]
	@Aid int,
	@AuditID varchar(10),
	@Department varchar(50),
	@Auditdate date,
	@Comments varchar(100)
AS BEGIN
UPDATE AuditPlan
Set 
AuditID=(Select Acid from AuditCycle where AuditID = @AuditID), 
Department=(Select Did from Department where Department = @Department), 
AuditDate=@Auditdate, 
Comments=@Comments
where AId = @Aid
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateAuditPlanFromActual]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAuditPlanFromActual]
	@PlanId int,
	@Status varchar(100)
AS BEGIN
UPDATE AuditPlan
Set 
ExecuteStatus=@Status where AId = @PlanId
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateAuditPlanFromAuditor]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAuditPlanFromAuditor]
	@AID varchar(100),
	@Department varchar(100)
AS BEGIN
UPDATE AuditPlan
Set 
ExecuteStatus='Complete by Auditor'
Where AuditID = (select ACID from AuditCycle Where AuditID = @AID) and Department = (Select Did from Department Where Department = @Department)
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateClause]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateClause]
@CId INT,
@ClauseNo NVARCHAR(50),
@Standard NVARCHAR (50),
@Content NVARCHAR (50)
AS BEGIN
UPDATE Clause
Set ClauseNo=@ClauseNo, Standard=(Select sid from Standards where Standards = @Standard), Content=@Content WHERE cId = @CId
End

GO
/****** Object:  StoredProcedure [dbo].[UpdateCompliance]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCompliance]
	@Cid int,
	@Comments VARCHAR (250),
	@AOJ VARCHAR (250),
	@FC VARCHAR (50),
	@Auditee Int
AS BEGIN
UPDATE Compliance
Set 
Comments = @Comments, 
AOJ = @AOJ, 
FC = (Select FID from FCategory Where Description = @FC), 
Auditee = @Auditee
where CId = @Cid
END

GO
/****** Object:  StoredProcedure [dbo].[Updatedept]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Updatedept]
@Did int,
@Department nVARCHAR(50),
@Division nVARCHAR (50)
AS BEGIN
UPDATE Department
Set Department=@Department, Division=@Division WHERE Did = @Did
End

GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEmployee]
@Eid int,
@FName VARCHAR(50),
@MName VARCHAR (50),
@LName VARCHAR (50),
@EmailID VARCHAR (50),
@Department VARCHAR (50),
@Gender VARCHAR (10),
@Role VARCHAR (50),
@Status VARCHAR (10),
@DOB DATE
AS BEGIN
UPDATE Employee
Set FName=@FName, MName=@MName, LName=@LName, EmailID=@EmailID, Department=(select Did from Department where Department = @Department), Gender=@Gender, Role=(select rid from Role where Role = @Role), Status=@Status, DOB=@DOB WHERE Eid = @Eid
End
GO
/****** Object:  StoredProcedure [dbo].[UpdateFCategory]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFCategory]
@Fid int,
@FC nVARCHAR(50),
@Description nVARCHAR (250),
@Cat varchar(50)
AS BEGIN
UPDATE FCategory
Set FC=@FC, Description=@Description, Cat=@Cat WHERE FId = @Fid
End

GO
/****** Object:  StoredProcedure [dbo].[UpdatePostAuditStatus]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePostAuditStatus]
	@PlanID Int,
	@Auditdate date,
	@Comments varchar(100),
	@EID INT,
	@Status VARCHAR (100)
AS
BEGIN
DELETE AuditActual Where PlanId = @PlanID
INSERT INTO AuditActual(PlanID, AuditDate, Comments, EMPID, Status) VALUES 
(
@PlanID,
@Auditdate, 
@Comments,
@EID,
@Status
)
Update AuditPlan
Set ExecuteStatus = @Status Where AID = @PlanID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateRequirements]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateRequirements]
@Rid int,
@Standards NVARCHAR (50),
@ClauseNo NVARCHAR (50),
@Subheader NVARCHAR (10),
@Requiement NVARCHAR (250),
@ObjEvi NVARCHAR (250),
@Department VARCHAR (50)
AS BEGIN
UPDATE Requirements
Set Standards=(Select sid from Standards where Standards = @Standards), ClauseNo=(Select cid from Clause where ClauseNo = @ClauseNo), 
Subheader=@Subheader, Requirement=@Requiement, ObjEvi=@ObjEvi, Department = (Select did from Department Where Department = @Department) where rid = @Rid
END

GO
/****** Object:  StoredProcedure [dbo].[Updaterole]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Updaterole]
@rid int,
@Role VARCHAR(100)
AS BEGIN
UPDATE iamsrole
Set Role=@Role WHERE Rid = @rid
End

GO
/****** Object:  StoredProcedure [dbo].[UpdateStandards]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStandards]
@sid int,
@Standards VARCHAR(50)
AS BEGIN
UPDATE Standards
Set Standards=@Standards WHERE sid = @sid
End

GO
/****** Object:  StoredProcedure [dbo].[UpdateUserdata]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUserdata]
@Username varchar(50),
@Password VARCHAR(50),
@Repassword VARCHAR (50),
@Photo Image
AS
BEGIN
Update Userdata
SET Password = @Password, Repassword=@Repassword, Photo=@Photo where Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[Usertable_Delete]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usertable_Delete]
	@Uid INT
AS BEGIN
	Delete Usertable Where UID = @Uid
END
GO
/****** Object:  StoredProcedure [dbo].[Usertable_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usertable_Insert]
@Username VARCHAR (50),
@Password VARCHAR (100),
@Employeename VARCHAR (50),
@Rolename VARCHAR (50)
AS
BEGIN
INSERT INTO Usertable(EmpID, Role, Username, Password) VALUES ((select Eid from Employee where concat(Eid,'-',FName,' ',LName) = @Employeename), (select rid from Role where Role = @Rolename), @Username, @Password)
END
GO
/****** Object:  StoredProcedure [dbo].[Usertable_Update]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usertable_Update]
	@Uid int,
	@Username VARCHAR (50),
	@Password VARCHAR (100),
	@Role VARCHAR (50)
AS BEGIN
UPDATE Usertable
Set 
Username=@Username, 
Password=@Password,
Role=(select rid from Role where Role = @Role)
where UID = @UID
END
GO
/****** Object:  StoredProcedure [dbo].[Vendor_Delete]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Vendor_Delete]
	@VID INT
AS BEGIN
	Delete Vendor Where VId = @Vid
END
GO
/****** Object:  StoredProcedure [dbo].[Vendor_Insert]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Vendor_Insert]
	@Vendor NVARCHAR(50),
	@AddressLine1 NVARCHAR(50),
	@AddressLine2 NVARCHAR(50),
	@AddressLine3 NVARCHAR(50),
	@Country NVARCHAR(50),
	@Postalcode INT,
	@Salutation NVARCHAR(5),
	@Contact NVARCHAR(25),
	@Telephone INT,
	@Handphone INT,
	@EmailID VARCHAR(50),
	@Status NVARCHAR(50),
	@Createduser NVARCHAR(50),
	@Remarks NVARCHAR (50)
AS
BEGIN
	Insert into Vendor 
	(Vendor, [Address Line 1], [Address Line 2], [Address Line 3], Country, PostalCode, Salutation, Contact, Telephone, Handphone, [Email ID], Status, Remarks, [Created by])
	VALUES
	(@Vendor, @AddressLine1, @AddressLine2, @AddressLine3, (Select CountryID from Countries Where Country=@Country), @Postalcode, @Salutation, @Contact, @Telephone, @Handphone, @EmailID, @Status, @Remarks, (select Uid from Usertable Where Username = @Createduser))
END
GO
/****** Object:  StoredProcedure [dbo].[Vendor_Update]    Script Date: 24/12/2019 11:21:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Vendor_Update]
	@VID INT,
	@AddressLine1 NVARCHAR(50),
	@AddressLine2 NVARCHAR(50),
	@AddressLine3 NVARCHAR(50),
	@Country NVARCHAR(50),
	@Postalcode INT,
	@Salutation NVARCHAR(5),
	@Contact NVARCHAR(25),
	@Telephone INT,
	@Handphone INT,
	@EmailID NVARCHAR(50),
	@Status NVARCHAR(50),
	@Createduser NVARCHAR(50),
	@Remarks NVARCHAR (50)
AS
BEGIN
	Update Vendor 
	Set
	[Address Line 1]=@AddressLine1, 
	[Address Line 2]=@AddressLine2,
	[Address Line 3]=@AddressLine3,
	Country=(Select CountryID from Countries Where Country=@Country), 
	PostalCode=@Postalcode,
	Salutation=@Salutation,
	Contact=@Contact,
	Telephone=@Telephone,
	Handphone=@Handphone,
	[Email ID]=@EmailID,
	Status=@Status,
	Remarks=@Remarks,
	[Created by]=(select Uid from Usertable Where Username = @Createduser)
	Where VID=@VID
END
GO
USE [master]
GO
ALTER DATABASE [SJMS] SET  READ_WRITE 
GO
