USE [master]
GO
/****** Object:  Database [Company]    Script Date: 28/07/2018 5:20:36 PM ******/
CREATE DATABASE [Company]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Company', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQL2008\MSSQL\DATA\Company.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Company_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQL2008\MSSQL\DATA\Company_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Company] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Company].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Company] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Company] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Company] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Company] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Company] SET ARITHABORT OFF 
GO
ALTER DATABASE [Company] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Company] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Company] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Company] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Company] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Company] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Company] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Company] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Company] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Company] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Company] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Company] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Company] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Company] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Company] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Company] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Company] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Company] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Company] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Company] SET  MULTI_USER 
GO
ALTER DATABASE [Company] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Company] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Company] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Company] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Company]
GO
/****** Object:  User [Clv]    Script Date: 28/07/2018 5:20:36 PM ******/
CREATE USER [Clv] FOR LOGIN [Clv] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Clv]
GO
/****** Object:  UserDefinedTableType [dbo].[ABC]    Script Date: 28/07/2018 5:20:37 PM ******/
CREATE TYPE [dbo].[ABC] AS TABLE(
	[EmpName] [varchar](50) NULL,
	[Salary] [numeric](10, 2) NULL,
	[DeptName] [varchar](50) NULL,
	[Designation] [varchar](50) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[checkRegister]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[checkRegister]
@in_user_name varchar(50),
@in_mobile_no varchar(15),
@in_email_id varchar(20),
@in_password varchar(15),
@out_returnvalue int output
as
begin

if exists(select 1 from EmpMast where user_name=@in_user_name)
BEGIN
  set @out_returnvalue  = 0
END
else
	begin
	insert INTO EmpMast(user_name,mobile_number,email_id,password) values (@in_user_name,@in_mobile_no,@in_email_id,@in_password)
	set @out_returnvalue = 1
end
	select @out_returnvalue
	--select @out_returnvalue as 'msg'
end


GO
/****** Object:  StoredProcedure [dbo].[DeleteEMP]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteEMP]
@USER_NAME VARCHAR(15)=null,
@out_returnvalue INT OUTPUT
AS
BEGIN
If exists(select 1 from EmpMast where user_name=@USER_NAME)
BEGIN
 set @out_returnvalue  = 1
  delete FROM EmpMast WHERE  user_name=@USER_NAME
END
else
	begin	
	set @out_returnvalue = 0
end
	select @out_returnvalue
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployeeBySalary]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllEmployeeBySalary]
@Salary int=0
as
begin

select * from Employee where Salary>=@salary
end
GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployeesBySalary]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllEmployeesBySalary]
    (
        @Salary int=0
    )
AS
begin
        Select * from Employee where Salary>@Salary
   END
GO
/****** Object:  StoredProcedure [dbo].[GETEMP]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GETEMP]
@USER_NAME VARCHAR(15)=null,
@out_returnvalue INT OUTPUT
AS
BEGIN
--If exists(select 1 from EmpMast where user_name=@USER_NAME)
--BEGIN
 set @out_returnvalue  = 1
  SELECT * FROM EmpMast WHERE 1=1 and (@USER_NAME is null OR user_name=@USER_NAME)
--END
--else
--	begin	
--	set @out_returnvalue = 0
--end
	select @out_returnvalue
END
GO
/****** Object:  StoredProcedure [dbo].[updateemp]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[updateemp]
@in_user_name varchar(50),
@in_mobile_no varchar(15),
@in_email_id varchar(20),
@in_password varchar(15),
@out_returnvalue int output
as
begin

if exists(select 1 from EmpMast where user_name=@in_user_name)
BEGIN
update EmpMast set mobile_number=@in_mobile_no,email_id=@in_email_id where user_name=@in_user_name
  set @out_returnvalue  = 1
END
else
	begin
	--insert INTO EmpMast(user_name,mobile_number,email_id,password) values (@in_user_name,@in_mobile_no,@in_email_id,@in_password)
	set @out_returnvalue = 0
end
	select @out_returnvalue
	--select @out_returnvalue as 'msg'
end


GO
/****** Object:  Table [dbo].[Employee]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpNo] [int] NOT NULL,
	[EmpName] [varchar](50) NOT NULL,
	[Salary] [int] NOT NULL,
	[DeptNo] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmpNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmployeeInfo]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeInfo](
	[EmpNo] [int] IDENTITY(1,1) NOT NULL,
	[EmpName] [varchar](50) NOT NULL,
	[Salary] [decimal](18, 0) NOT NULL,
	[DeptName] [varchar](50) NOT NULL,
	[Designation] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EmployeeInfo] PRIMARY KEY CLUSTERED 
(
	[EmpNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[employer]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer](
	[user_name] [nvarchar](max) NULL,
	[mobile_number] [nvarchar](max) NULL,
	[email_id] [nvarchar](max) NULL,
	[password] [nvarchar](max) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmpMast]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmpMast](
	[user_name] [varchar](50) NULL,
	[mobile_number] [varchar](50) NULL,
	[email_id] [varchar](50) NULL,
	[password] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserMast]    Script Date: 28/07/2018 5:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMast](
	[username] [varchar](10) NULL,
	[password] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[mobile] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [Company] SET  READ_WRITE 
GO
