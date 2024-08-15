USE [master]
GO
/****** Object:  Database [stuquiz]    Script Date: 8/15/2024 1:22:19 PM ******/
CREATE DATABASE [stuquiz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'stuquiz', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\stuquiz.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'stuquiz_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\stuquiz_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [stuquiz] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [stuquiz].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [stuquiz] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [stuquiz] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [stuquiz] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [stuquiz] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [stuquiz] SET ARITHABORT OFF 
GO
ALTER DATABASE [stuquiz] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [stuquiz] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [stuquiz] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [stuquiz] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [stuquiz] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [stuquiz] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [stuquiz] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [stuquiz] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [stuquiz] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [stuquiz] SET  ENABLE_BROKER 
GO
ALTER DATABASE [stuquiz] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [stuquiz] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [stuquiz] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [stuquiz] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [stuquiz] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [stuquiz] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [stuquiz] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [stuquiz] SET RECOVERY FULL 
GO
ALTER DATABASE [stuquiz] SET  MULTI_USER 
GO
ALTER DATABASE [stuquiz] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [stuquiz] SET DB_CHAINING OFF 
GO
ALTER DATABASE [stuquiz] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [stuquiz] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [stuquiz] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [stuquiz] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'stuquiz', N'ON'
GO
ALTER DATABASE [stuquiz] SET QUERY_STORE = OFF
GO
USE [stuquiz]
GO
/****** Object:  Table [dbo].[answer]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[answer](
	[answer_id] [int] IDENTITY(1,1) NOT NULL,
	[question_id] [int] NOT NULL,
	[answer_content] [nvarchar](4000) NOT NULL,
	[is_true] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[answer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[boxchat]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[boxchat](
	[boxchat_id] [int] IDENTITY(1,1) NOT NULL,
	[sender_id] [int] NOT NULL,
	[receiver_id] [int] NOT NULL,
	[chat_content] [nvarchar](500) NOT NULL,
	[send_time] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[boxchat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[lesson_id] [int] NOT NULL,
	[pre_comment] [int] NULL,
	[comment_content] [nvarchar](1500) NULL,
	[comment_time] [varchar](500) NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course](
	[course_id] [int] IDENTITY(1,1) NOT NULL,
	[course_name] [nvarchar](100) NOT NULL,
	[course_code] [varchar](20) NOT NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exam]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exam](
	[exam_id] [int] IDENTITY(1,1) NOT NULL,
	[quiz_id] [int] NULL,
	[student_id] [int] NULL,
	[exam_rate] [float] NULL,
	[is_pass] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exam_question]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exam_question](
	[exam_question_id] [int] IDENTITY(1,1) NOT NULL,
	[exam_id] [int] NULL,
	[question_id] [int] NULL,
	[selected_answer] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[exam_question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[item]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[item](
	[item_id] [int] IDENTITY(1,1) NOT NULL,
	[buyer_id] [int] NOT NULL,
	[subject_id] [int] NOT NULL,
	[item_price] [float] NOT NULL,
	[qr_code] [varchar](500) NULL,
	[transaction_code] [varchar](500) NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lesson]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lesson](
	[lesson_id] [int] IDENTITY(1,1) NOT NULL,
	[lesson_name] [nvarchar](100) NULL,
	[subject_id] [int] NULL,
	[video_link] [varchar](500) NULL,
	[lesson_description] [nvarchar](4000) NULL,
	[created_date] [date] NOT NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[lesson_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[post]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[post](
	[post_id] [int] IDENTITY(1,1) NOT NULL,
	[creator] [int] NOT NULL,
	[post_content] [nvarchar](4000) NULL,
	[post_image] [varchar](500) NULL,
	[hashTag] [varchar](500) NULL,
	[created_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[post_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question](
	[question_id] [int] IDENTITY(1,1) NOT NULL,
	[subject_id] [int] NULL,
	[question_image] [varchar](500) NULL,
	[question_level] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[question_content] [nvarchar](4000) NULL,
PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quiz]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quiz](
	[quiz_id] [int] IDENTITY(1,1) NOT NULL,
	[lesson_id] [int] NOT NULL,
	[quiz_name] [nvarchar](100) NOT NULL,
	[quiz_level] [int] NOT NULL,
	[quiz_duration] [int] NOT NULL,
	[pass_rate] [float] NOT NULL,
	[quiz_type] [int] NOT NULL,
	[quiz_description] [nvarchar](200) NULL,
	[e_question] [int] NOT NULL,
	[m_question] [int] NOT NULL,
	[h_question] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[quiz_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quiz_bank]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quiz_bank](
	[quiz_bank_id] [int] IDENTITY(1,1) NOT NULL,
	[quiz_id] [int] NULL,
	[question_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[quiz_bank_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reqest_teacher]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reqest_teacher](
	[reqest_teacher_id] [int] IDENTITY(1,1) NOT NULL,
	[maker_id] [int] NOT NULL,
	[user_bank] [varchar](30) NULL,
	[user_bank_code] [varchar](100) NULL,
	[reqest_content] [varchar](4000) NULL,
	[created_time] [varchar](500) NOT NULL,
	[is_accept] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[reqest_teacher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subject]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject](
	[subject_id] [int] IDENTITY(1,1) NOT NULL,
	[owner_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
	[subject_code] [varchar](20) NOT NULL,
	[subject_name] [nvarchar](100) NOT NULL,
	[subject_description] [nvarchar](4000) NULL,
	[subject_image] [varchar](500) NULL,
	[subject_price] [float] NOT NULL,
	[sale_price] [float] NOT NULL,
	[created_date] [date] NOT NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[subject_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subject_statistic]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject_statistic](
	[subject_statistic_id] [int] IDENTITY(1,1) NOT NULL,
	[subject_id] [int] NOT NULL,
	[revenue] [float] NOT NULL,
	[purchases] [int] NOT NULL,
	[views] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[subject_statistic_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[user_name] [nvarchar](50) NOT NULL,
	[user_email] [varchar](50) NOT NULL,
	[user_password] [varchar](50) NOT NULL,
	[role_level] [int] NULL,
	[user_avatar] [varchar](300) NULL,
	[user_bank] [varchar](30) NULL,
	[user_bank_code] [varchar](100) NULL,
	[created_time] [varchar](500) NOT NULL,
	[active_code] [varchar](10) NOT NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vote]    Script Date: 8/15/2024 1:22:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote](
	[vote_id] [int] IDENTITY(1,1) NOT NULL,
	[maker_id] [int] NOT NULL,
	[lesson_id] [int] NOT NULL,
	[star] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[vote_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[answer] ON 
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (1, 1, N'A. Các nhà quản lý của chính công ty', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (2, 1, N'B. Hội đồng quản trị', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (3, 1, N'C. Các cổ đông', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (4, 1, N'D. Tất cả các câu trên đều đúng', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (5, 2, N'A. Công ty tư nhân', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (6, 2, N'B. Công ty hợp danh', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (7, 2, N'C. Công ty nhỏ', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (8, 2, N'D. Người nhận thầu độc lập', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (9, 3, N'A. Công ty tư nhân', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (10, 3, N'B. Công ty hợp danh', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (11, 3, N'C. Công ty cổ phần', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (12, 3, N'D. Tất cả các câu trên đều đúng', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (13, 4, N'A. Huy động vốn', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (14, 4, N'B. Chuẩn bị các báo cáo tài chính', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (15, 4, N'C. Quyết định chính sách cổ tức', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (16, 4, N'D. Tạo giá trị cho doanh nghiệp', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (17, 5, N'A. Lập các báo cáo tài chính', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (18, 5, N'B. Thiết lập các mối quan hệ với các nhà đầu tư', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (19, 5, N'C. Quản lý tiền mặt', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (20, 5, N'D. Tìm kiếm các nguồn tài trợ', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (21, 6, N'A. Được miễn thuế', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (22, 6, N'B. Tách bạch giữa quyền sở hữu và quyền quản lý', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (23, 6, N'C. Trách nhiệm vô hạn', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (24, 6, N'D. Các yêu cầu báo cáo được giảm thiểu', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (25, 7, N'A. Trách nhiệm hữu hạn', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (26, 7, N'B. Đời sống là vĩnh viễn', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (27, 7, N'C. Thuế bị đánh trùng hai lần 2', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (28, 7, N'D. Trách nhiệm vô hạn', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (29, 8, N'A. Doanh số tối đa', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (30, 8, N'B. Tối đa hoá lợi nhuận', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (31, 8, N'C. Tối đa hoá giá trị công ty cho các cổ đông', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (32, 8, N'D. Tối đa hoá thu nhập cho các nhà quản lý', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (33, 9, N'A. Tối đa hoá giá trị cổ phiếu trên thị trường của công ty', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (34, 9, N'B. Tối đa hoá thị phần của công ty', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (35, 9, N'C. Tối đa hoá lợi nhuận hiện tại của công ty', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (36, 9, N'D. Tối thiểu hoá các khoản nợ của công ty', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (37, 10, N'A. Bảng cân đối kế toán', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (38, 10, N'B. Bảng thuyết minh báo cáo tài chính', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (39, 10, N'C. Báo cáo dòng tiền', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (40, 10, N'D. Báo cáo thu nhập', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (41, 11, N'A. Dòng tiền dự án', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (42, 11, N'B. Dòng tiền tài chính', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (43, 11, N'C. Dòng tiền hoạt động', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (44, 11, N'D. Dòng tiền đầu tư', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (45, 12, N'A. Đất đai và thiết bị', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (46, 12, N'B. Hàng tồn kho', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (47, 12, N'C. Thương hiệu', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (48, 12, N'D. Các khoản phải thu', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (49, 13, N'A. Nhà cửa', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (50, 13, N'B. Máy móc', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (51, 13, N'C. Thương hiệu', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (52, 13, N'D. Thiết bị', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (53, 14, N'A. Tổng tài sản tổng nợ', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (54, 14, N'B. Tài sản lưu động nợ ngắn hạn', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (55, 14, N'C. Tài sản lưu động nợ ngắn hạn', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (56, 14, N'D. Không câu nào đúng', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (57, 15, N'A. Khả năng thanh toán lãi vay', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (58, 15, N'B. Tỷ số thanh toán nhanh', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (59, 15, N'C. Kỳ thu tiền bình quân', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (60, 15, N'D. Cả 3 câu trên đều đúng', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (61, 16, N'A. Thanh toán nhanh', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (62, 16, N'B. Thanh toán hiện hành', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (63, 16, N'C. Sinh lợi', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (64, 16, N'D. Hoạt động', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (65, 17, N'A. Lãi gộp từ hoạt động kinh doanh', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (66, 17, N'B. Lãi ròng', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (67, 17, N'C. Lãi gộp', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (68, 17, N'D. Các chỉ tiêu trên là tương đương nhau', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (69, 18, N'A. Doanh thu', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (70, 18, N'B. Tổng tài sản', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (71, 18, N'C. Lãi ròng', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (72, 18, N'D. EBIT', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (73, 19, N'A. Tỷ suất lợi nhuận trên tổng tài sản', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (74, 19, N'B. Lãi gộp', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (75, 19, N'C. Tỷ số P/E', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (76, 19, N'D. Tỷ số lợi nhuận trên vốn cổ phần', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (77, 20, N'A. Chỉ số trung bình ngành', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (78, 20, N'B. Chỉ số của công ty cạnh tranh', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (79, 20, N'C. Mục tiêu quản lý của doanh nghiệp', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (80, 20, N'D. Tất cả đều đúng', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (81, 21, N'A. Chỉ số khả năng thanh toán lãi vay', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (82, 21, N'B. ROA', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (83, 21, N'C. P/E', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (84, 21, N'D. Phân tích xu hướng', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (85, 22, N'A. Chỉ số thanh toán', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (86, 22, N'B. Chỉ số hoạt động', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (87, 22, N'C. Chỉ số sinh lợi', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (88, 22, N'D. Chỉ số đòn bẩy', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (89, 23, N'A. EAT, tổng tài sản, dòng tiền', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (90, 23, N'B. EAT, tổng tài sản, doanh thu', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (91, 23, N'C. EAT, doanh thu và dòng tiền', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (92, 23, N'D. Doanh thu, dòng tiền và tổng tài sản', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (93, 24, N'A. 0,5', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (94, 24, N'B. 1,0', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (95, 24, N'C. 1,5', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (96, 24, N'D. 2,0', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (97, 25, N'A. 5,0', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (98, 25, N'B. 7,0', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (99, 25, N'C. 4,7', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (100, 25, N'D. 14,0', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (101, 26, N'A. 1,25', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (102, 26, N'B. 0,9375', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (103, 26, N'C. 1,33', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (104, 26, N'D. Không câu nào dúng', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (105, 27, N'A. Hiệu suất sử dụng tổng tài sản', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (106, 27, N'B. Đòn bẩy tài chính', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (107, 27, N'C. Lợi nhuận giữ lại', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (108, 27, N'D. Lãi gộp', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (109, 28, N'A. Ðúng', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (110, 28, N'B. Sai', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (152, 39, N'A', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (153, 39, N'B', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (154, 39, N'C', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (155, 39, N'D', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (156, 40, N'E', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (157, 40, N'F', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (158, 40, N'G', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (159, 40, N'H', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (160, 41, N'A', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (161, 41, N'B', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (162, 41, N'C', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (163, 41, N'D', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (164, 42, N'E', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (165, 42, N'F', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (166, 42, N'G', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (167, 42, N'H', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (168, 43, N'A', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (169, 43, N'B', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (170, 43, N'C', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (171, 43, N'D', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (172, 44, N'E', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (173, 44, N'F', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (174, 44, N'G', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (175, 44, N'H', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (176, 45, N'A', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (177, 45, N'B', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (178, 45, N'C', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (179, 45, N'D', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (180, 46, N'E', 1)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (181, 46, N'F', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (182, 46, N'G', 0)
GO
INSERT [dbo].[answer] ([answer_id], [question_id], [answer_content], [is_true]) VALUES (183, 46, N'H', 0)
GO
SET IDENTITY_INSERT [dbo].[answer] OFF
GO
SET IDENTITY_INSERT [dbo].[boxchat] ON 
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1199, 5, 1, N'Chào anh', N'-1718259233420')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1200, 5, 1, N'Em có thẻ giúp gì cho anh', N'-1718259252233')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1201, 1, 5, N'Mình muốn đăng kí khóa học 3 tháng môn PRJ ạ', N'1718259276365')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1202, 5, 1, N'Ok bạn bạn có thể cho mình biết mã môn học không ạ PRF202 hay 102 ạ', N'-1718259716055')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1203, 5, 1, N'Bạn gửi mình số điện thoại với ạ', N'-1718260688327')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1204, 5, 2, N'Hello', N'-1718261419321')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1205, 5, 1, N'Ban cho minh dia chi nhe', N'-1718354487780')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1206, 1, 5, N'Uk', N'1718354506218')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1207, 5, 1, N'Alo ban oi', N'-1718354615861')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1208, 1, 5, N'Hello', N'-1718617164374')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1209, 1, 5, N'Hello', N'1718619727419')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1210, 5, 1, N'Có việc j vây', N'-1718619744775')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1211, 1, 5, N'Daaa', N'-1718864174767')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1212, 1, 5, N'SSSS', N'1718864187607')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1213, 5, 1, N'Hello', N'-1718864197553')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1214, 1, 5, N'aaaa', N'-1721013655836')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1215, 1, 5, N'Em dang lmj ddos', N'1721013661828')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1216, 5, 1, N'Hi', N'-1722045518515')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1217, 5, 1, N'Có việc gì', N'-1722057704919')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1218, 1, 5, N'Tao muốn mua khóa học', N'1722057714786')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1219, 5, 1, N'Mày mua khóa học nào', N'-1722057724790')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1220, 5, 3, N'Hello Hải', N'-1722057748457')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1221, 11, 5, N'Hello', N'1722067155369')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1222, 5, 11, N'Gi do', N'-1722067167097')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1223, 5, 11, N'', N'-1722068737594')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1224, 5, 11, N'', N'-1722068741437')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1225, 5, 11, N'', N'-1722068748655')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1226, 5, 11, N'', N'-1722068750332')
GO
INSERT [dbo].[boxchat] ([boxchat_id], [sender_id], [receiver_id], [chat_content], [send_time]) VALUES (1227, 5, 11, N'', N'-1722068752872')
GO
SET IDENTITY_INSERT [dbo].[boxchat] OFF
GO
SET IDENTITY_INSERT [dbo].[comment] ON 
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (84, 1, 2, 0, N'Hellu tôi là đoàn hải minh', N'1721204449484', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (85, 1, 2, 84, N'@You Tôi đang trả lời chính tôi', N'1721204470526', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (86, 1, 2, 84, N'@You mua không', N'1721205172712', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (87, 1, 2, 0, N'Chào buổi sáng', N'1721205384608', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (88, 1, 2, 85, N'@You Ai cho mà chào', N'1721205395130', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (89, 1, 2, 87, N'@You hei how are u', N'1721206908071', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (90, 1, 2, 85, N'@You k cho tra loi', N'1721215941457', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (91, 1, 2, 88, N'@You Hellu cc', N'1721216639779', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (92, 1, 2, 91, N'@You dadsdsd', N'1721216661835', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (93, 1, 2, 90, N'@You HHehehehe', N'1721216740401', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (94, 1, 3, 0, N'Hello', N'1722067995482', 1)
GO
INSERT [dbo].[comment] ([comment_id], [user_id], [lesson_id], [pre_comment], [comment_content], [comment_time], [is_active]) VALUES (95, 1, 3, 94, N'@You Hello', N'1722068004110', 1)
GO
SET IDENTITY_INSERT [dbo].[comment] OFF
GO
SET IDENTITY_INSERT [dbo].[course] ON 
GO
INSERT [dbo].[course] ([course_id], [course_name], [course_code], [is_active]) VALUES (1, N'Software technology', N'SE', 1)
GO
INSERT [dbo].[course] ([course_id], [course_name], [course_code], [is_active]) VALUES (2, N'Data analysis', N'DA', 1)
GO
INSERT [dbo].[course] ([course_id], [course_name], [course_code], [is_active]) VALUES (3, N'Logistic', N'LS', 1)
GO
INSERT [dbo].[course] ([course_id], [course_name], [course_code], [is_active]) VALUES (4, N'Hotel management', N'HM', 1)
GO
SET IDENTITY_INSERT [dbo].[course] OFF
GO
SET IDENTITY_INSERT [dbo].[exam] ON 
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1011, 1, 1, 0, 0)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1012, 1, 1, 0, 0)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1013, 1, 1, 0.25, 0)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1014, 1, 1, 0, 0)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1015, 1, 1, 0.5, 1)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1016, 1, 1, 0.2, 0)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1017, 1, 1, 0.45, 0)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1018, 1, 1, 0.3, 0)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1019, 1, 1, 0.3, 0)
GO
INSERT [dbo].[exam] ([exam_id], [quiz_id], [student_id], [exam_rate], [is_pass]) VALUES (1020, 1, 1, 0.1, 0)
GO
SET IDENTITY_INSERT [dbo].[exam] OFF
GO
SET IDENTITY_INSERT [dbo].[exam_question] ON 
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1211, 1011, 12, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1212, 1011, 4, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1213, 1011, 15, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1214, 1011, 5, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1215, 1011, 14, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1216, 1011, 8, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1217, 1011, 11, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1218, 1011, 2, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1219, 1011, 13, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1220, 1011, 3, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1221, 1011, 16, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1222, 1011, 22, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1223, 1011, 19, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1224, 1011, 17, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1225, 1011, 18, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1226, 1011, 23, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1227, 1011, 21, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1228, 1011, 25, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1229, 1011, 28, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1230, 1011, 27, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1231, 1012, 5, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1232, 1012, 2, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1233, 1012, 6, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1234, 1012, 13, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1235, 1012, 15, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1236, 1012, 11, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1237, 1012, 9, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1238, 1012, 1, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1239, 1012, 14, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1240, 1012, 12, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1241, 1012, 22, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1242, 1012, 17, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1243, 1012, 18, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1244, 1012, 20, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1245, 1012, 16, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1246, 1012, 19, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1247, 1012, 23, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1248, 1012, 28, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1249, 1012, 26, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1250, 1012, 27, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1251, 1013, 10, 38)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1252, 1013, 6, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1253, 1013, 2, 6)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1254, 1013, 13, 50)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1255, 1013, 1, 2)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1256, 1013, 5, 18)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1257, 1013, 15, 58)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1258, 1013, 8, 30)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1259, 1013, 11, 42)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1260, 1013, 12, 46)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1261, 1013, 19, 74)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1262, 1013, 18, 70)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1263, 1013, 23, 90)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1264, 1013, 16, 62)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1265, 1013, 21, 82)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1266, 1013, 20, 78)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1267, 1013, 24, 94)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1268, 1013, 25, 98)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1269, 1013, 26, 102)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1270, 1013, 28, 109)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1271, 1014, 2, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1272, 1014, 7, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1273, 1014, 11, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1274, 1014, 9, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1275, 1014, 15, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1276, 1014, 14, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1277, 1014, 3, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1278, 1014, 8, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1279, 1014, 5, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1280, 1014, 4, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1281, 1014, 19, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1282, 1014, 22, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1283, 1014, 16, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1284, 1014, 23, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1285, 1014, 21, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1286, 1014, 20, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1287, 1014, 17, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1288, 1014, 27, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1289, 1014, 26, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1290, 1014, 25, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1291, 1015, 7, 25)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1292, 1015, 11, 41)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1293, 1015, 3, 9)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1294, 1015, 10, 37)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1295, 1015, 6, 22)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1296, 1015, 4, 14)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1297, 1015, 2, 6)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1298, 1015, 15, 58)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1299, 1015, 8, 30)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1300, 1015, 9, 34)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1301, 1015, 21, 82)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1302, 1015, 18, 70)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1303, 1015, 20, 78)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1304, 1015, 24, 94)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1305, 1015, 23, 90)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1306, 1015, 22, 86)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1307, 1015, 17, 66)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1308, 1015, 27, 106)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1309, 1015, 28, 109)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1310, 1015, 26, 101)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1311, 1016, 4, 13)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1312, 1016, 7, 25)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1313, 1016, 11, 41)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1314, 1016, 14, 53)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1315, 1016, 5, 17)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1316, 1016, 13, 49)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1317, 1016, 15, 57)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1318, 1016, 8, 29)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1319, 1016, 1, 1)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1320, 1016, 2, 5)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1321, 1016, 19, 73)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1322, 1016, 20, 77)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1323, 1016, 24, 93)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1324, 1016, 23, 89)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1325, 1016, 22, 85)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1326, 1016, 21, 81)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1327, 1016, 16, 61)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1328, 1016, 27, 105)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1329, 1016, 25, 97)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1330, 1016, 26, 101)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1331, 1017, 13, 50)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1332, 1017, 14, 54)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1333, 1017, 3, 10)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1334, 1017, 12, 48)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1335, 1017, 6, 24)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1336, 1017, 5, 17)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1337, 1017, 10, 37)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1338, 1017, 1, 3)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1339, 1017, 2, 7)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1340, 1017, 9, 35)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1341, 1017, 18, 70)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1342, 1017, 16, 62)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1343, 1017, 24, 94)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1344, 1017, 17, 66)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1345, 1017, 20, 78)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1346, 1017, 23, 90)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1347, 1017, 21, 82)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1348, 1017, 25, 98)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1349, 1017, 26, 102)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1350, 1017, 28, 109)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1351, 1018, 9, 34)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1352, 1018, 1, 3)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1353, 1018, 13, 51)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1354, 1018, 7, 27)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1355, 1018, 8, 31)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1356, 1018, 15, 59)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1357, 1018, 4, 15)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1358, 1018, 5, 19)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1359, 1018, 14, 55)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1360, 1018, 11, 43)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1361, 1018, 19, 75)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1362, 1018, 20, 79)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1363, 1018, 18, 71)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1364, 1018, 16, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1365, 1018, 21, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1366, 1018, 17, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1367, 1018, 22, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1368, 1018, 25, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1369, 1018, 26, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1370, 1018, 27, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1371, 1019, 14, 53)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1372, 1019, 5, 17)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1373, 1019, 3, 9)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1374, 1019, 12, 45)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1375, 1019, 13, 49)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1376, 1019, 8, 29)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1377, 1019, 7, 25)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1378, 1019, 15, 57)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1379, 1019, 4, 14)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1380, 1019, 6, 22)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1381, 1019, 21, 82)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1382, 1019, 16, 62)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1383, 1019, 23, 90)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1384, 1019, 22, 87)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1385, 1019, 19, 75)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1386, 1019, 17, 67)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1387, 1019, 18, 70)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1388, 1019, 25, 98)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1389, 1019, 26, 101)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1390, 1019, 27, 106)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1391, 1020, 10, 37)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1392, 1020, 11, 41)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1393, 1020, 1, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1394, 1020, 3, 9)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1395, 1020, 5, 19)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1396, 1020, 12, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1397, 1020, 2, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1398, 1020, 14, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1399, 1020, 6, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1400, 1020, 4, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1401, 1020, 24, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1402, 1020, 23, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1403, 1020, 17, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1404, 1020, 22, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1405, 1020, 16, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1406, 1020, 21, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1407, 1020, 19, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1408, 1020, 25, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1409, 1020, 26, NULL)
GO
INSERT [dbo].[exam_question] ([exam_question_id], [exam_id], [question_id], [selected_answer]) VALUES (1410, 1020, 28, NULL)
GO
SET IDENTITY_INSERT [dbo].[exam_question] OFF
GO
SET IDENTITY_INSERT [dbo].[item] ON 
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (3, 1, 1, 10000, N'''1221''', N'TranM3M1722062413146', CAST(N'2024-07-27' AS Date), CAST(N'2024-10-25' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (4, 1, 3, 10000, NULL, N'TranM4M1718541252541', CAST(N'2023-06-16' AS Date), CAST(N'2023-09-14' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (5, 1, 2, 0, NULL, N'Tran_5_1718464994461', CAST(N'2024-06-15' AS Date), CAST(N'2024-06-16' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (6, 1, 4, 10000, NULL, N'Tran_6_1718459278016', CAST(N'2024-06-15' AS Date), CAST(N'2024-06-16' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (7, 9, 4, 90000, NULL, NULL, CAST(N'2114-06-15' AS Date), CAST(N'2023-06-15' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (8, 1, 6, 10000, NULL, N'TranM8M1722059095231', CAST(N'2024-07-27' AS Date), CAST(N'2024-10-25' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (9, 1, 8, 12.1, NULL, N'TranM9M1722058988103', CAST(N'2114-07-27' AS Date), CAST(N'2023-07-27' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (10, 1, 11, 12.1, NULL, N'TranM10M1722069196350', CAST(N'2114-07-27' AS Date), CAST(N'2023-07-27' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (11, 8, 2, 0, NULL, N'TranM11M1722042395521', CAST(N'2114-07-27' AS Date), CAST(N'2023-07-27' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (12, 8, 3, 10000, NULL, N'TranM12M1722042478083', CAST(N'2114-07-27' AS Date), CAST(N'2023-07-27' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (13, 4, 6, 90000, NULL, NULL, CAST(N'2114-07-27' AS Date), CAST(N'2023-07-27' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (14, 1, 9, 10000, NULL, N'TranM14M1722067428407', CAST(N'2024-07-27' AS Date), CAST(N'2024-10-25' AS Date))
GO
INSERT [dbo].[item] ([item_id], [buyer_id], [subject_id], [item_price], [qr_code], [transaction_code], [start_date], [end_date]) VALUES (15, 5, 9, 10000, NULL, N'TranM15M1722058605006', CAST(N'2024-07-27' AS Date), CAST(N'2015-10-25' AS Date))
GO
SET IDENTITY_INSERT [dbo].[item] OFF
GO
SET IDENTITY_INSERT [dbo].[lesson] ON 
GO
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [subject_id], [video_link], [lesson_description], [created_date], [is_active]) VALUES (2, N'Started Guide Line', 1, N'https://www.youtube.com/watch?v=jNBFwGjRjZc', N'Đây là bài học khởi đầu', CAST(N'2024-06-07' AS Date), 0)
GO
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [subject_id], [video_link], [lesson_description], [created_date], [is_active]) VALUES (3, N'Bài học thứ 2', 1, N'https://www.youtube.com/embed/jNBFwGjRjZc', N'Bài học này siêu hay', CAST(N'2024-07-27' AS Date), 1)
GO
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [subject_id], [video_link], [lesson_description], [created_date], [is_active]) VALUES (4, N'Bài học thứ 2', 1, N'https://www.youtube.com/embed/jNBFwGjRjZc', N'abc', CAST(N'2024-07-27' AS Date), 1)
GO
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [subject_id], [video_link], [lesson_description], [created_date], [is_active]) VALUES (5, N'Bài học thứ 2', 1, N'https://www.youtube.com/embed/jNBFwGjRjZc', N'asd', CAST(N'2024-07-27' AS Date), 1)
GO
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [subject_id], [video_link], [lesson_description], [created_date], [is_active]) VALUES (6, N'Bài học thứ 3', 1, N'https://www.youtube.com/embed/jNBFwGjRjZc', N'123', CAST(N'2024-07-27' AS Date), 1)
GO
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [subject_id], [video_link], [lesson_description], [created_date], [is_active]) VALUES (7, NULL, 1, NULL, NULL, CAST(N'2024-07-27' AS Date), 1)
GO
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [subject_id], [video_link], [lesson_description], [created_date], [is_active]) VALUES (8, NULL, 1, NULL, NULL, CAST(N'2024-07-27' AS Date), 1)
GO
SET IDENTITY_INSERT [dbo].[lesson] OFF
GO
SET IDENTITY_INSERT [dbo].[post] ON 
GO
INSERT [dbo].[post] ([post_id], [creator], [post_content], [post_image], [hashTag], [created_date]) VALUES (2, 5, N'<p>ssasasasaas</p>
', N'https://th.bing.com/th/id/R.a06540c84c354244a96450742a701b6f?rik=2NvE4t1PyzY%2fDg&riu=http%3a%2f%2fthuthuatphanmem.vn%2fuploads%2f2018%2f09%2f11%2fhinh-anh-dep-62_044135376.jpg&ehk=ybfSrFxYckpHrcejxmpSY9vzNC07Np4EBKUILpup0iU%3d&risl=1&pid=ImgRaw&r=0', N'sss', CAST(N'2024-07-27' AS Date))
GO
INSERT [dbo].[post] ([post_id], [creator], [post_content], [post_image], [hashTag], [created_date]) VALUES (3, 5, N'<p>fef</p>
', NULL, N'', CAST(N'2024-07-27' AS Date))
GO
SET IDENTITY_INSERT [dbo].[post] OFF
GO
SET IDENTITY_INSERT [dbo].[question] ON 
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (1, 2, N'', 1, 1, N'Thông thường công ty cổ phần được sở hữu bởi:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (2, 1, NULL, 1, 1, N'Loại hình kinh doanh được sở hữu bởi một cá nhân duy nhất được gọi là:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (3, 1, NULL, 1, 1, N'Trách nhiệm hữu hạn là đặc điểm quan trọng của:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (4, 1, NULL, 1, 1, N'Một nhiệm vụ quan trọng của nhà quản trị tài chính là:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (5, 1, NULL, 1, 1, N'Các giám đốc vốn thường phụ trách công việc sau đây của một công ty cổ phần ngoại trừ:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (6, 1, NULL, 1, 1, N'Công ty cổ phần có thuận lợi so với loại hình công ty tư nhân và công ty hợp danh bởi vì:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (7, 1, NULL, 1, 1, N'Những không thuận lợi chính trong việc tổ chức một công ty cổ phần là:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (8, 1, NULL, 1, 1, N'Mục tiêu về tài chính của một công ty cổ phần là:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (9, 1, NULL, 1, 1, N'Mục tiêu nào sau đây là phù hợp nhất đối với nhà quản trị tài chính một công ty cổ phần:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (10, 1, NULL, 1, 1, N'__________ cung cấp tóm tắt vị thế tài chính của công ty tại một thời điểm nhất định.')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (11, 1, NULL, 1, 1, N'Báo cáo dòng tiền tóm lược dòng tiền nào sau đây ngoại trừ:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (12, 1, NULL, 1, 1, N'Trong những tài sản sau đây, tài sản nào có tính thanh khoản cao nhất:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (13, 1, NULL, 1, 1, N'Tài sản cố định vô hình bao gồm:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (14, 1, NULL, 1, 1, N'Vốn luân chuyển (NWC) được xác định như là:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (15, 1, NULL, 1, 1, N'Câu nào sau đây là một ví dụ của tỷ số thanh toán:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (16, 1, NULL, 2, 1, N'Chỉ số __________ đo lường tốc độ có thể chuyển tài sản sang tiền mặt:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (17, 1, NULL, 2, 1, N'Chỉ tiêu nào sau đây là bé nhất:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (18, 1, NULL, 2, 1, N'Trong báo cáo thu nhập theo quy mô chung, mỗi một khoản được diễn đạt như là phần trăm của:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (19, 1, NULL, 2, 1, N'Khi lợi nhuận và doanh thu của một công ty tăng lên thì __________ giảm:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (20, 1, NULL, 2, 1, N'Chỉ số tài chính chỉ có ý nghĩa khi được so sánh với một vài tiêu chuẩn, đó là:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (21, 1, NULL, 2, 1, N'__________ đưa ra nhân tố thời gian vào phân tích các chỉ số tài chính:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (22, 1, NULL, 2, 1, N'__________ cho thấy mức độ một công ty sử dụng tài sản của mình như thế nào:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (23, 1, NULL, 2, 1, N'ROA sẽ thay đổi khi yếu tố nào sau đây thay đổi:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (24, 1, NULL, 2, 1, N'Nếu tỷ số nợ là 0,5, tỷ số nợ trên vốn cổ phần là:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (25, 1, NULL, 3, 1, N'EBIT 100; khấu hao 40; lãi vay 20; cổ tức 10; tính khả năng thanh toán lãi vay?')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (26, 1, NULL, 3, 1, N'Doanh thu 2000; giá vốn hàng bán 1500; tổng tài sản 1600; hàng tồn kho 100; tính hiệu suất sử dụng tổng tài sản?')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (27, 1, NULL, 3, 1, N'Mô hình Dupont của phân tích tài chính đánh giá tỷ suất sinh lợi dưới những thuật ngữ sau đây, ngoại trừ:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (28, 1, NULL, 3, 1, N'Sự khác biệt giữa giá trị theo sổ sách kế toán và giá trị thị trường của các tài sản trong điều kiện lạm phát cao đã làm giảm độ chính xác của các chỉ số tài chính:')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (30, 1, N'a', 0, 1, N'Ai là người thông minh nhất hành tin')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (31, 1, N'a', 0, 1, N'Ai là tổng thống đầu tiên của Mỹ')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (32, 1, N'a', 0, 1, N'Ai là người thông minh nhất hành tin')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (33, 1, N'a', 0, 1, N'Ai là tổng thống đầu tiên của Mỹ')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (34, 1, N'a', 0, 1, N'Ai là người thông minh nhất hành tin')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (35, 1, N'a', 0, 1, N'Ai là tổng thống đầu tiên của Mỹ')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (36, 1, N'a', 0, 1, N'Ai là người thông minh nhất hành tin')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (37, 1, N'a', 0, 1, N'Ai là tổng thống đầu tiên của Mỹ')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (38, 1, N'a', 0, 1, N'Ai là người thông minh nhất hành tin')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (39, 1, N'a', 0, 1, N'Ai là tổng thống đầu tiên của Mỹ')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (40, 1, N'a', 0, 1, N'Ai là người thông minh nhất hành tin')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (41, 1, N'a', 3, 1, N'Ai là tổng thống đầu tiên của Mỹ')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (42, 1, N'a', 0, 1, N'Ai là người thông minh nhất hành tin')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (43, 1, N'a', 3, 1, N'Ai là tổng thống đầu tiên của Mỹ')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (44, 1, N'a', 2, 1, N'Ai là người thông minh nhất hành tin')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (45, 1, N'a', 3, 1, N'Ai là tổng thống đầu tiên của Mỹ')
GO
INSERT [dbo].[question] ([question_id], [subject_id], [question_image], [question_level], [is_active], [question_content]) VALUES (46, 1, N'a', 2, 1, N'Ai là người thông minh nhất hành tin')
GO
SET IDENTITY_INSERT [dbo].[question] OFF
GO
SET IDENTITY_INSERT [dbo].[quiz] ON 
GO
INSERT [dbo].[quiz] ([quiz_id], [lesson_id], [quiz_name], [quiz_level], [quiz_duration], [pass_rate], [quiz_type], [quiz_description], [e_question], [m_question], [h_question], [is_active]) VALUES (1, 2, N'Start Quiz', 1, 15, 0.5, 1, N'Học sinh không được sử dụng tài liệu', 10, 7, 3, 1)
GO
INSERT [dbo].[quiz] ([quiz_id], [lesson_id], [quiz_name], [quiz_level], [quiz_duration], [pass_rate], [quiz_type], [quiz_description], [e_question], [m_question], [h_question], [is_active]) VALUES (2, 2, N'Bai kiem tra', 1, 15, 80, 2, N'abc', 2, 3, 4, 1)
GO
SET IDENTITY_INSERT [dbo].[quiz] OFF
GO
SET IDENTITY_INSERT [dbo].[quiz_bank] ON 
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (1, 1, 1)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (2, 1, 2)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (3, 1, 3)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (4, 1, 4)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (5, 1, 5)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (6, 1, 6)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (7, 1, 7)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (8, 1, 8)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (9, 1, 9)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (10, 1, 10)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (11, 1, 11)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (12, 1, 12)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (13, 1, 13)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (14, 1, 14)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (15, 1, 15)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (16, 1, 16)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (17, 1, 17)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (18, 1, 18)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (19, 1, 19)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (20, 1, 20)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (21, 1, 21)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (22, 1, 22)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (23, 1, 23)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (24, 1, 24)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (25, 1, 25)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (26, 1, 26)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (27, 1, 27)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (28, 1, 28)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (29, 2, 1)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (30, 2, 2)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (31, 2, 4)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (32, 2, 5)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (33, 2, 6)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (34, 2, 7)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (35, 2, 8)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (36, 2, 9)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (37, 2, 10)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (38, 2, 11)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (39, 2, 12)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (40, 2, 13)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (41, 2, 14)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (42, 2, 15)
GO
INSERT [dbo].[quiz_bank] ([quiz_bank_id], [quiz_id], [question_id]) VALUES (43, 2, 3)
GO
SET IDENTITY_INSERT [dbo].[quiz_bank] OFF
GO
SET IDENTITY_INSERT [dbo].[subject] ON 
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (1, 8, 3, N'FIN3005', N'Financial Management', N'Financial management is a management science that studies financial relationships arising in the production and business process of an enterprise or organization. In other words, financial management is capital management, aiming to maximize business profits.', N'https://th.bing.com/th/id/R.1c5193f51ad9e7c7ccdd7766a5f29113?rik=CJUIs6xelFnv1g&riu=http%3a%2f%2fthuthuatphanmem.vn%2fuploads%2f2018%2f09%2f11%2fhinh-anh-dep-11_044127919.jpg&ehk=HYnGHiCmwCg9jjQVYivEaTcby%2blBBfnJdu6%2bEEzi5Yc%3d&risl=&pid=ImgRaw&r=0', 10000, 0, CAST(N'2024-07-15' AS Date), 1)
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (2, 1, 1, N'PRJ301', N' Web-Based Java Applications', N'A course on programming and developing web.', NULL, 10000, 100, CAST(N'2024-05-22' AS Date), 1)
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (3, 1, 1, N'SWE102', N'Introduction to Software Engineering', N'Introduction to Software Engineering.', NULL, 10000, 0, CAST(N'2024-05-22' AS Date), 1)
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (4, 1, 4, N'IOT102', N'Internet of Things', N'The Internet of Things (IoT) describes the network of physical objects—“things”—that are embedded with sensors, software, and other technologies for the purpose of connecting and exchanging data with other devices and systems over the internet.', NULL, 100000, 90, CAST(N'2024-05-22' AS Date), 1)
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (6, 8, 1, N'PRJ405', N'Progam Web ', N'3333adadaddddd', N'https://th.bing.com/th/id/OIP.Dc9z4uo9fSeFHzKyRvimbQHaEK?rs=1&pid=ImgDetMain', 100000, 90, CAST(N'2024-07-15' AS Date), 1)
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (8, 8, 1, N'PRJ401', N'Progam Web ', N'ssssaaas', N'https://th.bing.com/th/id/R.1c5193f51ad9e7c7ccdd7766a5f29113?rik=CJUIs6xelFnv1g&riu=http%3a%2f%2fthuthuatphanmem.vn%2fuploads%2f2018%2f09%2f11%2fhinh-anh-dep-11_044127919.jpg&ehk=HYnGHiCmwCg9jjQVYivEaTcby%2blBBfnJdu6%2bEEzi5Yc%3d&risl=&pid=ImgRaw&r=0', 121, 90, CAST(N'2024-07-15' AS Date), 1)
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (9, 8, 1, N'PRJ4031', N'Progam Web ', N'wwwqwqw', N'https://th.bing.com/th/id/R.1c5193f51ad9e7c7ccdd7766a5f29113?rik=CJUIs6xelFnv1g&riu=http%3a%2f%2fthuthuatphanmem.vn%2fuploads%2f2018%2f09%2f11%2fhinh-anh-dep-11_044127919.jpg&ehk=HYnGHiCmwCg9jjQVYivEaTcby%2blBBfnJdu6%2bEEzi5Yc%3d&risl=&pid=ImgRaw&r=0', 100000, 90, CAST(N'2024-07-15' AS Date), 1)
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (10, 8, 1, N'PRJ40321', N'Progam Web ', N'wwwww', N'https://th.bing.com/th/id/R.1c5193f51ad9e7c7ccdd7766a5f29113?rik=CJUIs6xelFnv1g&riu=http%3a%2f%2fthuthuatphanmem.vn%2fuploads%2f2018%2f09%2f11%2fhinh-anh-dep-11_044127919.jpg&ehk=HYnGHiCmwCg9jjQVYivEaTcby%2blBBfnJdu6%2bEEzi5Yc%3d&risl=&pid=ImgRaw&r=0', 121, 90, CAST(N'2024-07-15' AS Date), 0)
GO
INSERT [dbo].[subject] ([subject_id], [owner_id], [course_id], [subject_code], [subject_name], [subject_description], [subject_image], [subject_price], [sale_price], [created_date], [is_active]) VALUES (11, 8, 1, N'PRJ4032000', N'Progam Web ', N'121212', N'anh/subject_11.jpg', 121, 90, CAST(N'2024-07-15' AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[subject] OFF
GO
SET IDENTITY_INSERT [dbo].[user] ON 
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (1, N'Hải Minh', N'haiminh17052003@gmail.com', N'12345678', 4, N'https://th.bing.com/th/id/OIP.SYq1khSGoX8u_8eSDjSFmgHaE_?rs=1&pid=ImgDetMain', NULL, NULL, N'1716200067651', N'Dyv7lROIBr', 1)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (2, N'Nguyễn Thị Bích Ngọc', N'admisasaaaaaaan@gmail.com', N'admin21212', 4, NULL, NULL, NULL, N'1716130091945', N'MPMlAOsXUe', 0)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (3, N'Nguyễn Hải', N'addmdsssswearin@gmail.com', N'admin21212121', 4, NULL, NULL, NULL, N'1716130198385', N'Ix2jlfGVIt', 0)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (4, N'Hải Minh Admin', N'minhbeo1705@gmail.com', N'11111111', 1, N'https://th.bing.com/th/id/OIP.SYq1khSGoX8u_8eSDjSFmgHaE_?rs=1&pid=ImgDetMain', NULL, NULL, N'1716188498837', N'mkRLnthOte', 1)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (5, N'Hải Minh', N'minhbeao1705@gmail.com', N'doanhaiminh123', 2, N'https://th.bing.com/th/id/OIP.SYq1khSGoX8u_8eSDjSFmgHaE_?rs=1&pid=ImgDetMain', NULL, NULL, N'1716146149324', N'VGQ2juyY8O', 1)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (6, N'Trần Dũng', N'haimiddddaaanh17052003@gmail.com', N'12345678', 4, NULL, NULL, NULL, N'1716179541394', N'OKDsowVxfM', 0)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (8, N'Vũ Dũng', N'haimddinh17052003@gmail.com', N'12345678', 3, NULL, NULL, NULL, N'1716198282716', N'MnZuffMp2Y', 1)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (9, N'Hai Minh', N'minhbeaoo1705@gmail.com', N'12345678', 4, NULL, NULL, NULL, N'1717052334568', N'gW8Pct5sVo', 1)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (10, N'Doan Hai Minh', N'hahahahaiminh17052003@gmail.com', N'12345678', 4, NULL, NULL, NULL, N'1717407537584', N'edlC2y5g7B', 1)
GO
INSERT [dbo].[user] ([user_id], [user_name], [user_email], [user_password], [role_level], [user_avatar], [user_bank], [user_bank_code], [created_time], [active_code], [is_active]) VALUES (11, N'Doan Hai Minh', N'minhbeao170512@gmail.com', N'12345678', 4, NULL, NULL, NULL, N'1722067020510', N'VjYXttjR17', 1)
GO
SET IDENTITY_INSERT [dbo].[user] OFF
GO
SET IDENTITY_INSERT [dbo].[vote] ON 
GO
INSERT [dbo].[vote] ([vote_id], [maker_id], [lesson_id], [star]) VALUES (1, 1, 2, 3)
GO
INSERT [dbo].[vote] ([vote_id], [maker_id], [lesson_id], [star]) VALUES (2, 1, 3, 2)
GO
INSERT [dbo].[vote] ([vote_id], [maker_id], [lesson_id], [star]) VALUES (3, 8, 3, 4)
GO
SET IDENTITY_INSERT [dbo].[vote] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__course__AB6B45F12B6E012E]    Script Date: 8/15/2024 1:22:19 PM ******/
ALTER TABLE [dbo].[course] ADD UNIQUE NONCLUSTERED 
(
	[course_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__subject__CEACD92047462671]    Script Date: 8/15/2024 1:22:19 PM ******/
ALTER TABLE [dbo].[subject] ADD UNIQUE NONCLUSTERED 
(
	[subject_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__user__B0FBA212F69D7285]    Script Date: 8/15/2024 1:22:19 PM ******/
ALTER TABLE [dbo].[user] ADD UNIQUE NONCLUSTERED 
(
	[user_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[answer] ADD  DEFAULT ((0)) FOR [is_true]
GO
ALTER TABLE [dbo].[comment] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[course] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[exam] ADD  DEFAULT ((0)) FOR [is_pass]
GO
ALTER TABLE [dbo].[lesson] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[question] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[quiz] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[reqest_teacher] ADD  DEFAULT ((0)) FOR [is_accept]
GO
ALTER TABLE [dbo].[subject] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[user] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[answer]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[question] ([question_id])
GO
ALTER TABLE [dbo].[boxchat]  WITH CHECK ADD FOREIGN KEY([receiver_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[boxchat]  WITH CHECK ADD FOREIGN KEY([sender_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD FOREIGN KEY([lesson_id])
REFERENCES [dbo].[lesson] ([lesson_id])
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[exam]  WITH CHECK ADD FOREIGN KEY([quiz_id])
REFERENCES [dbo].[quiz] ([quiz_id])
GO
ALTER TABLE [dbo].[exam]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[exam_question]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[exam] ([exam_id])
GO
ALTER TABLE [dbo].[exam_question]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[question] ([question_id])
GO
ALTER TABLE [dbo].[exam_question]  WITH CHECK ADD FOREIGN KEY([selected_answer])
REFERENCES [dbo].[answer] ([answer_id])
GO
ALTER TABLE [dbo].[item]  WITH CHECK ADD FOREIGN KEY([buyer_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[item]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subject] ([subject_id])
GO
ALTER TABLE [dbo].[lesson]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subject] ([subject_id])
GO
ALTER TABLE [dbo].[post]  WITH CHECK ADD FOREIGN KEY([creator])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[question]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subject] ([subject_id])
GO
ALTER TABLE [dbo].[quiz]  WITH CHECK ADD FOREIGN KEY([lesson_id])
REFERENCES [dbo].[lesson] ([lesson_id])
GO
ALTER TABLE [dbo].[quiz_bank]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[question] ([question_id])
GO
ALTER TABLE [dbo].[quiz_bank]  WITH CHECK ADD FOREIGN KEY([quiz_id])
REFERENCES [dbo].[quiz] ([quiz_id])
GO
ALTER TABLE [dbo].[reqest_teacher]  WITH CHECK ADD FOREIGN KEY([maker_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[subject]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
ALTER TABLE [dbo].[subject]  WITH CHECK ADD FOREIGN KEY([owner_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[subject_statistic]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subject] ([subject_id])
GO
ALTER TABLE [dbo].[vote]  WITH CHECK ADD FOREIGN KEY([lesson_id])
REFERENCES [dbo].[lesson] ([lesson_id])
GO
ALTER TABLE [dbo].[vote]  WITH CHECK ADD FOREIGN KEY([maker_id])
REFERENCES [dbo].[user] ([user_id])
GO
USE [master]
GO
ALTER DATABASE [stuquiz] SET  READ_WRITE 
GO
