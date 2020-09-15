USE [master]
GO
/****** Object:  Database [2C2P]    Script Date: 9/14/2020 3:05:06 PM ******/
CREATE DATABASE [2C2P]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'2C2P', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLDEV\MSSQL\DATA\2C2P.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'2C2P_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLDEV\MSSQL\DATA\2C2P_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [2C2P] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [2C2P].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [2C2P] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [2C2P] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [2C2P] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [2C2P] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [2C2P] SET ARITHABORT OFF 
GO
ALTER DATABASE [2C2P] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [2C2P] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [2C2P] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [2C2P] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [2C2P] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [2C2P] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [2C2P] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [2C2P] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [2C2P] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [2C2P] SET  DISABLE_BROKER 
GO
ALTER DATABASE [2C2P] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [2C2P] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [2C2P] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [2C2P] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [2C2P] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [2C2P] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [2C2P] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [2C2P] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [2C2P] SET  MULTI_USER 
GO
ALTER DATABASE [2C2P] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [2C2P] SET DB_CHAINING OFF 
GO
ALTER DATABASE [2C2P] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [2C2P] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [2C2P] SET DELAYED_DURABILITY = DISABLED 
GO
USE [2C2P]
GO
/****** Object:  Table [dbo].[TBL_TransactionDATA]    Script Date: 9/14/2020 3:05:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_TransactionDATA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TRNID] [nvarchar](50) NULL,
	[AMOUNT] [decimal](18, 2) NULL,
	[CURRENCY] [text] NULL,
	[TRANDATE] [nvarchar](50) NULL,
	[STATUS] [nvarchar](50) NULL,
	[UPLOADDTE] [datetime] NULL,
 CONSTRAINT [PK_TBL_TransactionDATA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[TBL_TransactionDATA] ADD  CONSTRAINT [DF_TBL_TransactionDATA_UPLOADDTE]  DEFAULT (getdate()) FOR [UPLOADDTE]
GO
USE [master]
GO
ALTER DATABASE [2C2P] SET  READ_WRITE 
GO
