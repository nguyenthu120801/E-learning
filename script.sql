USE [master]
GO
/****** Object:  Database [SWP391_ONLINE_LEARN]    Script Date: 7/21/2022 10:22:44 AM ******/
CREATE DATABASE [SWP391_ONLINE_LEARN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SWP391_ONLINE_LEARN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.NGUYENTHU\MSSQL\DATA\SWP391_ONLINE_LEARN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SWP391_ONLINE_LEARN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.NGUYENTHU\MSSQL\DATA\SWP391_ONLINE_LEARN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP391_ONLINE_LEARN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET  MULTI_USER 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP391_ONLINE_LEARN', N'ON'
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET QUERY_STORE = OFF
GO
USE [SWP391_ONLINE_LEARN]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
 CONSTRAINT [PK__Category__3214EC2783F64C64] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [varchar](255) NOT NULL,
	[image] [varchar](max) NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[TeacherID] [int] NOT NULL,
	[description] [varchar](max) NULL,
 CONSTRAINT [PK__Course__C92D71872392EA35] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lesson]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lesson](
	[LessonID] [int] IDENTITY(1,1) NOT NULL,
	[LessonName] [varchar](200) NOT NULL,
	[CourseID] [int] NOT NULL,
	[LessonNo] [int] NOT NULL,
 CONSTRAINT [PK__Lesson__B084ACB09BF8366E] PRIMARY KEY CLUSTERED 
(
	[LessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LessonPDF]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LessonPDF](
	[PDFID] [int] IDENTITY(1,1) NOT NULL,
	[PDFName] [varchar](max) NOT NULL,
	[FilePDF] [varchar](max) NOT NULL,
	[LessonID] [int] NOT NULL,
 CONSTRAINT [PK__LessonPD__AAE555B25614A65E] PRIMARY KEY CLUSTERED 
(
	[PDFID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LessonVideo]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LessonVideo](
	[VideoID] [int] IDENTITY(1,1) NOT NULL,
	[VideoName] [varchar](200) NOT NULL,
	[FileVideo] [varchar](max) NOT NULL,
	[LessonID] [int] NOT NULL,
 CONSTRAINT [PK__LessonVi__BAE5124A3EADACC7] PRIMARY KEY CLUSTERED 
(
	[VideoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pay_Course]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pay_Course](
	[PayID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[type] [varchar](100) NOT NULL,
	[CourseID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
 CONSTRAINT [PK__Pay_Cour__EE8FCE2FB9875299] PRIMARY KEY CLUSTERED 
(
	[PayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quiz]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quiz](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[Question] [varchar](max) NOT NULL,
	[LessonID] [int] NOT NULL,
	[Answer1] [varchar](max) NOT NULL,
	[Answer2] [varchar](max) NOT NULL,
	[Answer3] [varchar](max) NULL,
	[Answer4] [varchar](max) NULL,
	[AnswerCorrect] [int] NOT NULL,
 CONSTRAINT [PK__Quiz__0DC06F8CBABFF3C3] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Result]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Result](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[LessonID] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[DateRecord] [date] NOT NULL,
	[score] [decimal](10, 2) NOT NULL,
	[status] [varchar](50) NULL,
 CONSTRAINT [PK__Result__97690228778D515F] PRIMARY KEY CLUSTERED 
(
	[ResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](255) NOT NULL,
	[phone] [varchar](30) NULL,
	[address] [varchar](100) NULL,
	[image] [varchar](max) NULL,
	[email] [varchar](200) NOT NULL,
	[gender] [varchar](30) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[DateOfBirth] [date] NULL,
 CONSTRAINT [PK__Student__3214EC277C9A8366] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 7/21/2022 10:22:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](255) NOT NULL,
	[phone] [varchar](30) NULL,
	[image] [varchar](max) NULL,
	[email] [varchar](200) NOT NULL,
	[gender] [varchar](30) NOT NULL,
	[username] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Teacher__3214EC276FB0F1BB] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (16, N'Admin', N'999@', N'Admin')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (3, N'AnhTuan', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (19, N'ChiChi', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (21, N'DatLa', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (28, N'HaLan', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (22, N'HangThuy', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (2, N'Kirk', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (29, N'LamHang', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (27, N'LanChi', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (18, N'LeNam', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (25, N'Minh Anh', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (6, N'MinhDuc', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (30, N'MinhHang', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (5, N'NhatAnh', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (8, N'Nicky', N'123@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (26, N'Phuong Anh', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (4, N'QuangQuan', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (13, N'Terrell', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (1, N'ThuThu', N'123@', N'Student')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (23, N'Tien', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (15, N'Tommy', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (24, N'TuPM', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (12, N'Ulises', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (14, N'Virge', N'111@', N'Teacher')
INSERT [dbo].[Account] ([ID], [username], [password], [RoleName]) VALUES (7, N'VuongDepTrai', N'123@', N'Student')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([ID], [Name]) VALUES (1, N'Graphic Design')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (2, N'Software Technology')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (3, N'Soft Skills')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (4, N'Language')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (5, N'Business')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (6, N'Edit Video')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (7, N'Web Design')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (8, N'Online Maketing')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (9, N'Programming')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (10, N'IT')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (11, N'Management')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (12, N'Health')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (13, N'Engineering')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (1, N'Working With Color Color in Adobe Photoshop', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTtAJzLDx1VGYsdC9Mg1rqYkhswW8kQ4dLRw&usqp=CAU', CAST(49.30 AS Decimal(10, 2)), 1, 1, N'Any artist will tell you that the use of color is a major component of the design process, regardless of the medium. Digital art and photography are no exceptions. Color can be powerful and evocative, but only if you know how to use it properly. In this course you will learn about the basics of color theory. We will then take a look at the different ways Photoshop handles colors using color modes, and what the advantages and disadvantages are. After that we will use this knowledge to assemble a colorful and vibrant digital scene, using several different techniques for controlling color in Photoshop.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (2, N'CertNexus Certified Ethical Emerging Technologist Professional Certificate', N'http://img.youtube.com/vi/3OJOEo6MTaI/hqdefault.jpg', CAST(35.40 AS Decimal(10, 2)), 2, 2, N'Learners will create a portfolio of assets highlighting their skills as ethical leaders. The assets consist of written documents and video communications required of ethical leaders, including Op-Ed articles, risk management reports, strategy memos, media releases, and video press briefings.Learners who complete the Honors projects will also author an industry feature article; a recommendation memo for the most appropriate ethical framework to guide an organization or a project; an Algorithmic Impact Assessment; a change management presentation to a Board of Directors; and a strategic business document such as a cost-benefit analysis, design plan, or business continuity plan.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (3, N'Learning How to Learn : Powerful mental tools to help you master tough subjects', N'https://s3-ap-southeast-1.amazonaws.com/images.spiderum.com/sp-images/ecc93e90203511ec9c8281a41a921537.png', CAST(29.50 AS Decimal(10, 2)), 3, 3, N'Although living brains are very complex, this module uses metaphor and analogy to help simplify matters. You will discover several fundamentally different modes of thinking, and how you can use these modes to improve your learning. You will also be introduced to a tool for tackling procrastination, be given some practical information about memory, and discover surprisingly useful insights about learning and sleep.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (4, N'Better Business Writing in English', N'https://technicalwriterhq.com/wp-content/uploads/2022/02/41-Business-Writing-Course.jpg', CAST(33.00 AS Decimal(10, 2)), 4, 4, N'Learning outcomes: After this module, you will be able to develop your personal voice and increase your accuracy, and appropriateness in written English, and produce a written document which displays your personal voice.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (5, N'Social Media Marketing', N'https://social.vn/wp-content/uploads/2020/11/Social-Media-Marketing.jpg', CAST(29.36 AS Decimal(10, 2)), 5, 1, N'In a 2018 survey of businesses, Buffer found that only 29% had effective social media marketing programs.    A recent survey of consumers by Tomoson found 92% of consumers trust recommendations from other people over brand content, 70% found consumer reviews to be their second most trusted source, 47% read blogs developed by influencers and experts to discover new trends and new ideas and 35% used blogs to discover new products and services.  Also, 20% of women who used social considered products promoted by bloggers they knew.   Today, businesses and consumers use social media to make their purchase decisions.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (6, N'Object Oriented Programming in C++', N'https://res.cloudinary.com/practicaldev/image/fetch/s--rPvSn38T--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/i/h2917prj7ldo0ow5x5ih.png', CAST(10.25 AS Decimal(10, 2)), 2, 2, N'Object-Oriented-Programming is an object-based programming method to find the essence of the problem. C++ OOP course helps programmers learn programming techniques where all logic')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (7, N'Basic Cross-Platform Application Programming With .NET', N'https://coodesh.com/blog/wp-content/uploads/2021/11/Artigo-148-scaled.jpg', CAST(9.99 AS Decimal(10, 2)), 2, 2, N'.NET Core is a free and open source framework for developing cross-platform applications targeting Windows, Linux and macOS. It is capable of running applications on devices, the cloud and the IoT. It supports four cross-platform scenarios: ASP.NET Core Web apps, command line apps, libraries and Web APIs. The recently released .NET Core 3 (preview bits) supports Windows rendering forms like WinForms, WPF and UWP, but only on Windows.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (9, N'Skill Play Game', N'https://cdn.sforum.vn/sforum/wp-content/uploads/2022/01/thum-960x540.jpg', CAST(0.30 AS Decimal(10, 2)), 3, 3, N'You can master all the skills in league of legends wild rift with the instructional tips learned from this course')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (10, N'Servlet JSP tutorial', N'https://wiki.tino.org/wp-content/uploads/2021/04/servlet-jsp-tutorial.png', CAST(9.52 AS Decimal(10, 2)), 9, 1, N'Servlet is Sun Microsystem''s web programming technology that is designed to solve the problems of matches.
of CGI. The servlet uses the multicast technique to serve the requirements instead of the CGI-like process.
Combining servlet and jsp programming is the beauty of web programming with Java. Then the servlet plays the role
Receive and process the request, and JSP will negotiate the responsibility of creating a display interface for users.
dung. JavaBean, EL, and JSTL I are powerful tools for JSP. Web Apps with Servlets and Game JSPs
should be more perfect when you deploy according to the MVC model.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (12, N'Basic Web Desgin HTML, CSS, JS', N'https://nentang.vn/wp-content/uploads/2018/07/html-css-js-course-intro.jpeg', CAST(0.50 AS Decimal(10, 2)), 7, 1, N'The basic web design course HTML, CSS, JS helps you familiarize yourself with the command line, providing you with the basic foundationÃ?Â can make great, smooth websites.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (14, N'Data Structures and Algorithms', N'https://braniumacademy.net/wp-content/uploads/2021/11/cpp-background.webp', CAST(0.00 AS Decimal(10, 2)), 2, 6, N'-Strengths and weaknesses of data structures. From there choose the best data structure to represent the data in the application you are implementing.
Many popular algorithms are often used to sort data. Thereby improving the efficiency of sorting large data sets.
-Detailed implementation source code of each data structure in C/C++ programming language. From there you will understand both the theory and the concrete implementation in the programming language.
-The exercises are diverse and rich with corresponding sample solutions. You want to eat onions? We will sell to you. Practice is the key for you to understand and apply the best theory.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (15, N'Java GUI programming', N'https://braniumacademy.net/wp-content/uploads/2020/11/java-swing_v2.webp', CAST(9.35 AS Decimal(10, 2)), 3, 6, N'-This course provides you with basic to advanced knowledge of the Java programming language. The course content covers the fundamental knowledge of the programming language that any Java programmer must know. The point across all of our courses is: Provide you with the most practical value. And we build buildings starting from a solid foundation, not building houses that are patchwork or top-down. The advantages of the course include:

Full and detailed content
Constantly updated knowledge
Use modern tools
Unlimited time to learn
Unlimited study locations
Mastering the Java language foundation
You can confidently apply for the Java Core field
Not having to go out to breathe dust
Not afraid of infection
The exercises are diverse and full of solutions
Comprehensive and comprehensive multiple-choice tests
There is a project at the end of the elective course
Confidence in school tests
Train programmers don''t train coders')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (16, N'Programming interface Megaman tool with WPF', N'https://cdn.videogamesblogger.com/wp-content/uploads/2018/10/mega-man-11-cheats.jpg', CAST(0.00 AS Decimal(10, 2)), 9, 6, N'Megaman X4 is a very interesting game that stuck with me for a long time through electronic presses, when computers or programming were still very far away. I still remember the whole summer months sticking my head in the game to practice my hands through the screen, but I couldn''t break the island. Still spicy now! So to challenge myself, I created a solution to help me conquer this "childhood dream". That is TOOL CHEAT GAME MEGAMAN X4

This serial is definitely for those of you who want to break the game Megaman x4 already. However, to be able to follow this course in the best way you should have knowledge of WPF PROGRAMMING. Having played through the game Megaman x4 to understand my "game-specialist" terms such as One hit Creep, One Hit Boss, Full Life, ....avoid being surprised by the content of the lesson''s instructions.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (18, N'machine learning bascic', N'https://i.ytimg.com/vi/ukzFI9rgwfU/hq720.jpg?sqp=-oaymwEXCNAFEJQDSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLBabPwMvRRu0nNZ6J1yiNEPlIqMGw', CAST(0.00 AS Decimal(10, 2)), 9, 6, N'With the purpose of introducing people to Machine Learning as well as creating a starting point for new people who want to join and learn initially about this hot field. Join the Team to learn about basic Machine Learning with Python language.')
INSERT [dbo].[Course] ([CourseID], [CourseName], [image], [price], [CategoryID], [TeacherID], [description]) VALUES (22, N'Diploma in Caregiving', N'https://apnaahangout.com/wp-content/uploads/2019/03/Diploma-Home-Care.png', CAST(0.00 AS Decimal(10, 2)), 12, 5, N'Learn The Knowledge And Skills You Need To Work As An Effective Carer.')
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[Lesson] ON 

INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (1, N'Introduction', 1, 1)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (2, N'Basic Color Theory', 1, 2)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (3, N'Color Modes', 1, 3)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (4, N'Working With Color', 1, 4)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (5, N'Tips and Tricks', 1, 5)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (6, N'Overview', 2, 1)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (7, N'Data Science Fundamentals', 2, 2)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (8, N'Artificial Intelligence Fundamentals', 2, 3)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (9, N'Data and Privacy', 2, 4)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (10, N'Legal Concepts Related to Data-Driven Technologies', 2, 5)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (11, N'Introduction', 3, 1)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (12, N'Forcused versus Diffuse Thinking', 3, 2)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (13, N'Procrastination, Memory, and Sleep', 3, 3)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (14, N'Summary', 3, 4)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (15, N'Optional Further Readings and Interviews', 3, 5)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (16, N'Perosonal Voice', 4, 1)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (17, N'Sentence Types', 4, 2)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (18, N'3 Key Parts of a Proposal', 4, 3)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (19, N'Write Better Sentences', 4, 4)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (20, N'Connect Ideas & Sentences', 4, 5)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (21, N'Security, Privacy & Governance Concerns', 5, 1)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (22, N'Most Important Metrics to Observe', 5, 2)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (23, N'Building a Successful Social Marketing Program', 5, 3)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (24, N'Sustaining Your Social Programs', 5, 4)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (25, N'Why is listening critical to your social programs?', 5, 5)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (26, N'Summary', 1, 6)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (27, N'Install Tomcat Server for Eclipse', 10, 1)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (28, N'Introduction', 12, 1)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (30, N'Installing Glassfish Web Server on Windows', 10, 2)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [CourseID], [LessonNo]) VALUES (31, N'Java Servlet Programming Tutorial for Beginners', 10, 3)
SET IDENTITY_INSERT [dbo].[Lesson] OFF
GO
SET IDENTITY_INSERT [dbo].[LessonPDF] ON 

INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (1, N'Get More from the Georgia Tech Language Institute', N'Get More from the Georgia Tech Language Institute.pdf', 18)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (2, N'Reading', N'Reading.pdf', 17)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (3, N'Farewell and Hello', N'Farewell and Hello.pdf', 20)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (4, N'Welcome and Course Information', N'Welcome and Course Information.pdf', 11)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (5, N'Written Communication', N'Written Communication.pdf', 19)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (6, N'Get to Know Your Classmates', N'Get to Know Your Classmates.pdf', 12)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (7, N'Focused versus Diffuse Thinking', N'Focused versus Diffuse Thinking.pdf', 13)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (8, N'A Posting about Anxiety', N'A Posting about Anxiety.pdf', 14)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (9, N'Chunking', N'Chunking.pdf', 15)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (10, N'Ethical Considerations for Data Science', N'Ethical Considerations for Data Science.pdf', 7)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (11, N'Benefits of Ethical Data Science', N'Benefits of Ethical Data Science.pdf', 8)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (12, N'A Day in the Life of an Ethical Data Scientis', N'A Day in the Life of an Ethical Data Scientist.pdf', 7)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (13, N'How to Teach Artificial Intelligence Some Common Sense', N'How to Teach Artificial Intelligence Some Common Sense.pdf', 9)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (14, N'Ethical Considerations for AI', N'Ethical Considerations for AI.pdf', 10)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (15, N'How AI detectives are cracking open the black box of deep learning', N'How AI detectives are cracking open the black box of deep learning.pdf', 9)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (16, N'Reading Summary', N'Chunking.pdf', 26)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (17, N'Chucking 2', N'Chunking.pdf', 28)
INSERT [dbo].[LessonPDF] ([PDFID], [PDFName], [FilePDF], [LessonID]) VALUES (22, N'Install TomCat', N'tomcat.pdf', 27)
SET IDENTITY_INSERT [dbo].[LessonPDF] OFF
GO
SET IDENTITY_INSERT [dbo].[LessonVideo] ON 

INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (1, N'Introduction', N'Photoshop/1.Introduction.mp4', 1)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (2, N'The Color Wheel', N'Photoshop/2.1.The Color Wheel.mp4', 2)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (3, N'Warm vs Cool', N'Photoshop/2.2.Warm vs Cool.mp4', 2)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (4, N'Color Schemes', N'Photoshop/2.3.Color Schemes.mp4', 2)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (5, N'Hue, Sturation and Linghtness', N'Photoshop/2.4.Hue, Sturation and Linghtness.mp4', 2)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (6, N'When Colors Collide', N'Photoshop/2.5.When Colors Collide.mp4', 2)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (7, N'RGB', N'Photoshop/3.1.RGB.mp4', 3)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (8, N'CMYK', N'Photoshop/3.2.CMYK.mp4', 3)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (9, N'LAB', N'Photoshop/3.3.LAB.mp4', 3)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (10, N'Scene Planning', N'Photoshop/4.1.Scene Planning.mp4', 4)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (11, N'Controlling Color With the Hue/Saturation Adjustment Layer', N'Photoshop/4.2.Controlling Color With the Hue_Saturation Adjustment Layer.mp4', 4)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (12, N'Controlling Color With Blending Modes', N'Photoshop/4.3.Controlling Color With Blending Modes.mp4', 4)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (13, N'Controlling Color With Gradient Maps', N'Photoshop/4.4.Controlling Color With Gradient Maps.mp4', 4)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (14, N'GUI Color Wheel', N'Photoshop/5.1.GUI Color Wheel.mp4', 5)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (15, N'Adobe Color Themes', N'Photoshop/5.2.Adobe Color Themes.mp4', 5)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (16, N'Color Look-Up Tables (CLUT)', N'Photoshop/5.3.Color Look-Up Tables (CLUT).mp4', 5)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (17, N'Understanding Data Protection', N'markerting/Understanding Data Protection.mp4', 21)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (18, N'Security, Privacy, and Governance Pt. 1', N'markerting/Security, Privacy, and Governance Pt. 1.mp4', 21)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (19, N'Managing Social Programs', N'markerting/Managing Social Programs.mp4', 22)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (20, N'Identifying Social Successes', N'markerting/Identifying Social Successes.mp4', 22)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (21, N'A New Model for Marketers', N'markerting/A New Model for Marketers.mp4', 22)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (22, N'Measuring Engagement', N'markerting/Measuring Engagement.mp4', 22)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (23, N'Finding Relevant Performance Metrics', N'markerting/Finding Relevant Performance Metrics.mp4', 22)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (24, N'Performance Funnels and KPIs', N'markerting/Performance Funnels and KPIs.mp4', 22)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (25, N'Developing Your Budget', N'markerting/Developing Your Budget.mp4', 23)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (26, N'Justification Metrics', N'markerting/Justification Metrics.mp4', 23)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (27, N'Calculating Performance Metrics', N'markerting/Calculating Performance Metrics.mp4', 23)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (28, N'Program Testing', N'markerting/Program Testing.mp4', 24)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (29, N'Program Management', N'markerting/Program Management.mp4', 24)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (30, N'Learn More with Medill IMC', N'markerting/Learn More with Medill IMC.mp4', 24)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (31, N'Moore Law and the 3 Accelerations that changed business forever', N'markerting/Moore''s Law and the 3 Accelerations that changed business forever.mp4', 25)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (32, N'Thomas Friedman on the 3 Accelerations [book link in resources]', N'markerting/Thomas Friedman on the 3 Accelerations [book link in resources].mp4', 25)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (33, N'Using Social Data', N'markerting/Using Social Data.mp4', 25)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (34, N'Social Data Flows from a Single Source', N'markerting/Social Data Flows from a Single Source.mp4', 25)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (35, N'CEET Specialization Introduction', N'ITE/CEET Specialization Introduction.mp4', 6)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (36, N'Promote the Ethical Use of Data-Driven Technologies Course Introduction', N'ITE/Promote the Ethical Use of Data-Driven Technologies Course Introduction.mp4', 6)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (37, N'Course Welcome & Success Tips', N'ITE/Course Welcome & Success Tips.mp4', 6)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (38, N'Ethics Make a Difference in Emerging Technologies', N'ITE/Ethics Make a Difference in Emerging Technologies.mp4', 6)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (39, N'Big Data', N'ITE/Big Data.mp4', 7)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (40, N'Working with Big Data', N'ITE/Working with Big Data.mp4', 7)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (41, N'Data Analytics', N'ITE/Data Analytics.mp4', 7)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (42, N'Data Science Pipeline', N'ITE/Data Science Pipeline.mp4', 7)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (43, N'Artificial Intelligence', N'ITE/Artificial Intelligence.mp4', 8)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (44, N'Narrow AI', N'ITE/Narrow AI.mp4', 8)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (45, N'General AI and Superintelligence', N'ITE/General AI and Superintelligence.mp4', 8)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (46, N'Ambient Intelligence and IoT', N'ITE/Ambient Intelligence and IoT.mp4', 8)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (47, N'Data Privacy', N'ITE/Data Privacy.mp4', 9)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (48, N'PII', N'ITE/PII.mp4', 9)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (49, N'Privacy Risks in IoT/Ambient Intelligence Technologies', N'ITE/Privacy Risks in IoT Ambient Intelligence Technologies.mp4', 9)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (50, N'Privacy Protection through Individual Authorization', N'ITE/Privacy Protection through Individual Authorization.mp4', 9)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (51, N'Legal Terminology: Responsibility, Accountability, and Liability', N'ITE/Legal Terminology Responsibility, Accountability, and Liability.mp4', 10)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (52, N'Technology Contract Types', N'ITE/Technology Contract Types.mp4', 10)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (53, N'Smart Contracts', N'ITE/Smart Contracts.mp4', 10)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (54, N'Introduction to the Focused and Diffuse Modes', N'Learn/Introduction to the Focused and Diffuse Modes.mp4', 11)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (55, N'Terrence Sejnowski and Barbara Oakley--Introduction to the Course Structure', N'Learn/Terrence Sejnowski and Barbara Oakley--Introduction to the Course Structure.mp4', 12)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (56, N'Using the Focused and Diffuse Modes--Or, a Little Dali will do You', N'Learn/Using the Focused and Diffuse Modes--Or, a Little Dali will do You.mp4', 12)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (57, N'What is Learning?', N'Learn/What is Learning.mp4', 12)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (58, N'A Procrastination Preview', N'Learn/A Procrastination Preview.mp4', 13)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (59, N'Practice Makes Permanent', N'Learn/Practice Makes Permanent.mp4', 13)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (60, N'Introduction to Memory', N'Learn/Introduction to Memory.mp4', 13)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (61, N'The Importance of Sleep in Learning', N'Learn/The Importance of Sleep in Learning.mp4', 13)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (62, N'Summary ', N'Learn/Summary video for Module 1.mp4', 14)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (63, N'Excitement About Whats Next! MaryAnne Nestor Gives Special Hints', N'Learn/Excitement About Whats Next! MaryAnne Nestor Gives Special Hints.mp4', 14)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (64, N'Introduction to Renaissance Learning and Unlocking Your Potential', N'Learn/Introduction to Renaissance Learning and Unlocking Your Potential.mp4', 15)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (65, N'How to Become a Better Learner', N'Learn/How to Become a Better Learner.mp4', 15)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (66, N'Create a Lively Visual Metaphor or Analogy', N'Learn/Create a Lively Visual Metaphor or Analogy.mp4', 15)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (67, N'Intro to Course', N'writing/Intro to Course.mp4', 16)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (68, N'Personal Voice', N'writing/Personal Voice.mp4', 16)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (69, N'Sentence Types Part 1', N'writing/Sentence Types Part 1.mp4', 17)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (70, N'Strong Sentences Part 1: Verb Tense & Parallel Structure', N'writing/Strong Sentences Part 1 Verb Tense & Parallel Structure.mp4', 17)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (71, N'Strong Sentences Part 2: Subject-Verb Agreement', N'writing/Strong Sentences Part 2  Subject-Verb Agreement.mp4', 17)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (72, N'3 Key Parts of a Proposal', N'writing/3 Key Parts of a Proposal.mp4', 18)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (73, N'How to Connect Ideas & Sentences', N'writing/How to Connect Ideas & Sentences.mp4', 18)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (74, N'How to Write a Process', N'writing/How to Write a Process.mp4', 18)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (75, N'No Need for Genius Envy', N'writing/No Need for Genius Envy.mp4', 19)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (76, N'Organize, Write, and Design Effective Slides', N'writing/Organize, Write, and Design Effective Slides.mp4', 19)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (77, N'How to Use Articles and Count/Non-count Nouns', N'writing/How to Use Articles and Count Non-count Nouns.mp4', 20)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (78, N'Change Your Thoughts, Change Your Life', N'writing/Change Your Thoughts, Change Your Life.mp4', 20)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (79, N'Summary', N'Working with Big Data.mp4', 26)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (80, N'Sumary2', N'Privacy Protection through Individual Authorization.mp4', 26)
INSERT [dbo].[LessonVideo] ([VideoID], [VideoName], [FileVideo], [LessonID]) VALUES (82, N'Introduction hi', N'Color color mixing.mp4', 28)
SET IDENTITY_INSERT [dbo].[LessonVideo] OFF
GO
SET IDENTITY_INSERT [dbo].[Pay_Course] ON 

INSERT [dbo].[Pay_Course] ([PayID], [Date], [type], [CourseID], [StudentID]) VALUES (1, CAST(N'2022-05-26' AS Date), N'Card', 1, 1)
INSERT [dbo].[Pay_Course] ([PayID], [Date], [type], [CourseID], [StudentID]) VALUES (2, CAST(N'2022-07-10' AS Date), N'card', 5, 3)
INSERT [dbo].[Pay_Course] ([PayID], [Date], [type], [CourseID], [StudentID]) VALUES (3, CAST(N'2022-07-10' AS Date), N'card', 5, 3)
INSERT [dbo].[Pay_Course] ([PayID], [Date], [type], [CourseID], [StudentID]) VALUES (4, CAST(N'2022-07-10' AS Date), N'card', 3, 3)
INSERT [dbo].[Pay_Course] ([PayID], [Date], [type], [CourseID], [StudentID]) VALUES (5, CAST(N'2022-07-19' AS Date), N'card', 1, 3)
INSERT [dbo].[Pay_Course] ([PayID], [Date], [type], [CourseID], [StudentID]) VALUES (6, CAST(N'2022-07-19' AS Date), N'card', 9, 3)
INSERT [dbo].[Pay_Course] ([PayID], [Date], [type], [CourseID], [StudentID]) VALUES (7, CAST(N'2022-07-19' AS Date), N'card', 3, 1)
INSERT [dbo].[Pay_Course] ([PayID], [Date], [type], [CourseID], [StudentID]) VALUES (8, CAST(N'2022-07-20' AS Date), N'card', 12, 3)
SET IDENTITY_INSERT [dbo].[Pay_Course] OFF
GO
SET IDENTITY_INSERT [dbo].[Quiz] ON 

INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (1, N'In discussing security, privacy, and governance, Seth Redmore discussed “progressive profiling.” Which of the following statements is an attributes of “progressive profiling”? ', 21, N'Progressive profiling involves an exchange of value between a company and consumer, such as name and email from the consumer resulting in a free white paper from the company.', N'Progressive profiling involves interaction between a company and government and territories, and the varying laws that differ from place to place', N'Progressive profiling involves a government or territory monitoring companies on social based on their size and worth', N'Progressive profiling involves a company taking user behavior and information, running analytics on it, and selling leads to another company.', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (2, N'Which of the following members of an organization are security professionals who already have an open dialogue with the Board or CEO on data security?', 21, N'Reactors', N'Influencers ', N'Protectors ', N'Representatives', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (3, N'Which of the following would be included in a fully integrated marketing plan', 22, N'Promotions', N'Direct Response', N'Social', N'All Correct', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (4, N'When using metrics to measure success in social, which of the following would be most appropriate for measuring the success of the content syndication of a video?', 22, N'Measuring return on investment', N'Measuring the cost for a click', N'Cost per complete view', N'Raw number or views or shares.', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (5, N'What is a present-day framework that explains the current engagement ecosystem, including insight into how social engagement can play an active role?', 22, N'The Customer Decision Journey', N'Loyalty Loop', N'AIDA Model, or “The Funnel”', N'Customer Engagement Engine', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (6, N'The metric for Amplification measures what? ', 22, N'Overall engagement rate', N'A measure of how appealing your post is', N'A measure of viral reach or how much your content has inspired your social audience to share it', N'Number of comments or replies per post', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (7, N'What are performance funnels?', 22, N'Performance funnels track the price per click', N'Performance funnels track the number of to clicks that result in shares.', N'Performance funnels track a company’s success in securing customer data and performance behavior. ', N'Performance funnels track the consumer journey from total market to product purchase.', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (8, N'Which of the following steps are involved in developing your budget?', 23, N'Determine your technology costs.', N'Create performance funnels and establish Key Performance Indicators (KPIs).', N'Develop your staffing costs.', N'All correct', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (9, N'What indicates success has been achieved when calculating the marketing return on investment (MROI) of a program?', 23, N'The MROI is a negative number', N'The MROI is 50% or better. ', N'The MROI is over 100%', N'The MROI is zero, meaning break even.', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (10, N'What are the benefits of a pilot program for a social marketing strategy?', 24, N'Pilots help identify the risks of the program. ', N'It’s a way to convince skeptical senior management to at least try the program to see its benefits.', N'A pilot program allows you to gauge action performance and make adjustments to the program before you commit to a plan.', N'All correct', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (11, N'Testing different types of media to determine the ones which reach your target markets in an efficient and effective way is known as ______?', 24, N'Social pyramid', N'Maximizing market share', N'Return on investment', N'Maturity modeling', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (12, N'Which of the following methods assist is developing a pilot project?', 24, N'Reduce the breadth or reach of the program. ', N'Reduce the scope of the original plan.', N'Reduce the timing of the program.', N'All correct', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (13, N'In social Big Data a “document” refers to:', 25, N'an application programming interface.', N'any writing that is generated by a word processor.', N'a portion of an entry containing important analysis information.', N'any single entry or posting on any type of social media.', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (14, N'A paragraph within a blog article would be considered a/an:', 25, N'snippet', N'SocialGist', N'document', N'API', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (15, N'APIs (automatic programming interface) are used for what purpose? ', 25, N'Generating discussion about social media', N'To extract social data in real-time from a social site.', N'To standardize the connection of learning systems with external service tools.', N'Microblogging within social networks.', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (16, N'Which of the following text analytics terms is used to describe how people on social “feel” about a topic?', 25, N'Themes/Topics ', N'Intentions', N'Sentiment', N'Categories', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (17, N'Which sentence uses the article a/an correctly?', 20, N'A efficient manager plans an meeting every month', N'An efficient manager plans an meeting every month', N' An efficient manager plans a meeting every month.', N'An employee in this store works late every night. ', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (18, N'Which sentence uses the articles a/an or the correctly?', 20, N'Did you meet the owner of the car you want to buy?', N'Did you meet an owner of a car you want to buy? ', N'Did you meet the owner of  a car you want to buy?', NULL, 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (19, N' I have a problem and need __________________. ', 20, N'advices', N'one advice', N'some advice', NULL, 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (20, N'Which sentence uses articles correctly?', 20, N'Employee in this store works late every night. ', N'An employees in this store work late every night. ', N'An employee every night.', NULL, 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (21, N'Which sentence uses articles correctly?', 19, N'Customer and employee enjoy eating in the restaurant on a third floor. ', N'Customers and employees enjoy eating in the restaurant on the third floor.', N'Customer and employee enjoy eating in the restaurant on the third floor.', NULL, 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (22, N'Which sentence uses expressions of quantity correctly?', 19, N'A lot of the management live in the city', N'All of the progress helps us attract new business.', N'None of the equipment work. ', NULL, 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (23, N'How do we write imperatives? ', 19, N'We use the simple base form of a verb and a simple subject.', N'We use the simple base form of a verb and a simple subject.', N'We use the simple base form of the verb after the subject. ', N'We use the simple base form of the verb at the beginning of the sentence. We do not write the subject.', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (24, N'We use consistent ___________________ to connect sentences.', 19, N'pronouns', N'transition words', N'key words and phrases', N'lavie', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (25, N'We repeat ___________________ to connect sentences.', 18, N'logical order', N'key words and phrases', N'pronouns', N'lahase', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (26, N' We add ____________________________ to connect sentences.', 18, N'Pronouns  ', N'Transition words', N'key words and phrases', N'logical order', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (27, N'Which tense would mainly be used for the following business document. Year-end progress report', 18, N'Simple Present', N'Simple Past', N'Simple Future', N'Simple base', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (28, N'Which tense would mainly be used for the following business document. Vision Statement', 18, N'Simple Present', N'Simple Past', N'Simple Future', N'Simple base', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (29, N'What is parallel structure?', 17, N'Matching subjects with verb', N'Using the same word forms', N'Talking about time', N'Take care', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (30, N'Choose the sentence with subject verb agreement.', 17, N'Our cars is always available.', N'Our car are always available.', N'Our cars are always available.', N'Our Table are oke', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (31, N'What should the final section of a proposal include?', 16, N'Testimonials from satisfied customers', N'Restatement of the problem and the solution', N'Important facts and figures that highlight your qualifications', N'Provides the solution to the client', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (32, N'Complete the sentences to describe the 3 parts of a proposal. State the _____________________. Provide the _____________________. Highlight your _____________________.', 16, N'problem,solution,qualifications', N'problem,title,solution', N'title, solution, qualifications', N'solution, problem, qualifications', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (33, N'How can you develop personal voice when you write in English?', 16, N'Focus on your own story, and write informally ', N'Focus on your readers, write actively and be positive and sincere.', N'Focus on your accomplishments, write actively', N'Focus on your accomplishments, write actively and be polite.', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (34, N'Which sentence shows active writing?', 16, N'The design was completed by our team on time.', N'Our team completed the design on time.', N'On time,  the design was completed', N'So your readers know you care about them', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (35, N'What is academic integrity?', 15, N' Understanding academic culture in its entirety, without being divided into parts.', N'Behaving ethically and responsibly at university.', N' Being honest and not cheating.', N'Displaying the core values of academic culture - honesty, trust, fairness, respect and responsibility - in class.', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (36, N'According to the lecture, universities are not just trying to train you for a job role, but are also trying to prepare you ___', 15, N'to behave ethically', N'to not cheat', N'to not become involved in political scandals', N'to conduct qualitative research', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (37, N'"Academic communities of integrity value the interactive, cooperative, participatory nature of learning. They honor, value, and consider diverse opinions and ideas. ... In academic environments of integrity, even those who disagree on facts share ... reverence for knowledge and the methods by which it is obtained." (International Centre for Academic Integrity , 2014, pg 24).Which of the academic values is this referring to?', 15, N'Honesty', N'Trust', N'Fairness', N'Responsibility', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (38, N'"Knowledge is soon changed, then lost in the mist, an echo half-heard." - Gene Wolfe. What quality of academic culture does this relate to?', 15, N'The contingent nature of academic knowledge.', N'The need for evidence to support opinions.', N'The use of research to produce knowledge.', N'The importance of independent learning.', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (39, N'Consider the following situation. In Jeong Woo s first semester at university he often forgot to get his course readings done in time, and had to ask for an extension twice for his assignments as he couldnt complete them. In his second semester he became a lot more aware of when he needed to have completed readings and assignments, which resulted in better grades and greater contributions to tutorials. Which survival skill mentioned in lesson 1.3 does this refer to?', 14, N'Time management', N'Collaboration', N'Noticing how your field structures knowledge.', N'Study skills', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (40, N'Academic journal articles allow us to enter the discussions that define our academic field. However, what is a DISADVANTAGE of academic journal articles?', 14, N'They are too general.', N'They are difficult to read because of the expert vocabulary used.', N' They are shorter than textbooks, and therefore contain less information.', N'They are available on subscription only.', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (41, N'Consider the following question. "You have zero privacy anyway. Get over it" (Scott McNealey, 1999). What is privacy? How have changes in technology made privacy an issue for citizens and governments? Another important step in developing a search strategy is to develop a set of search terms using synonyms of key words in the question. Choose the best set of synonyms of key terms from the groups below.', 14, N' solitude, computers, civilians, subjects, state, politics', N' surveillance, computers, inhabitants, dwellers, state, politics', N'surveillance, computers, civilians, subjects, state, politics', N'surveillance, machines, civilians, subjects, state, politics', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (42, N'"You have zero privacy anyway. Get over it" (Scott McNealey, 1999). What is privacy? How have changes in technology made privacy an issue for citizens and governments? A student wants to research the effects of technology on privacy for citizens. What is the best combination of search terms below?', 13, N'privacy AND technology AND civil*', N'privacy AND technology AND (civilians OR citizens OR subjects)', N' privacy OR technology AND civilian', N'privacy AND technology NOT government', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (43, N'Which record is an article on positive topological entropy in the journal Annals of Mathematics part of?', 13, N'Cultural record', N'Scholarly record', N'Public record', N'Police record', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (44, N'Is a first year visual art textbook called Introduction to Art History an example of a primary source, secondary source, or tertiary source?', 12, N'Primary source', N'Secondary source', N'Tertiary source', N'Quaternary source', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (45, N'In which part of an academic journal article would you encounter the findings or outcomes of the research that was conducted?', 12, N'Abstract', N'Introduction', N'Methodology', N'Results', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (46, N'Which of these options is the usual structure of a humanities journal article?', 12, N'Abstract, Introduction, Methodology, Results, Discussion, Conclusion, References', N'Abstract, Introduction, Results, Methodology , Discussion, Conclusion, References', N'Abstract, Introduction, Body, Conclusion, References', N'Abstract, Introduction, Body, References, Conclusion', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (47, N'What is the most important thing that determines where you look for information sources, according to Pat Norman in lesson 2.3?', 11, N'The academic field youre studying.', N'How easy it is to access.', N'How fine-grained you want your information to be.', N'What youre looking for', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (48, N'"It is important to remember that educational software, like textbooks, is only one tool in the learning process. Neither can be a substitute for well-trained teachers, leadership, and parental involvement" (Keith Krueger). How important is educational technology? A student wants to research the importance of technology in curriculum change. What would be the best combination of search terms below?', 11, N'technology OR curriculum AND change', N'technology OR curriculum change', N'technology AND "curriculum change"', N'technology OR curriculum OR change', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (49, N'Which of the following is NOT a criterion used to judge the credibility of sources?', 11, N'Clarity', N'Scholarly purpose', N'Audience', N'Objectivity', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (50, N'You would like to save the PLos One article on robot surgery to your computer. The article citation is: Noda Y, Ida Y, Tanaka S, Toyama T, Roggia MF, et al. (2013) Impact of Robotic Assistance on Precision of Vitreoretinal Surgical Procedures. PLoS ONE 8(1): e54116. doi:10.1371/journal.pone.0054116. According to lesson 3.3a, what would be the best file name to use?', 11, N'Yasuo_2013_robot surgery', N'Noda et al_2013_robot surgery', N' 20170511_sociology of technology assignment', N'journal.pone.0054116.PDF', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (51, N'You have a collection of course notes from your course in Business Communications (BUS1002) from the first year of your undergraduate course in Business Management. You took the course in the second quarter of 2018 and your lecturer was Caroline Ng. What would be the best name for the top level folder in your university folder hierarchy for this information', 10, N'BUS1002', N'2018_Quarter 2', N'Caroline Ng', N'Business Communications', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (52, N'Which of these parts of an academic journal article would you probably NOT read in great detail?', 10, N'Abstract', N'Introduction', N'Methodology', N'Conclusion', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (53, N'If you want to check the relevance of an information source to your assessment question, why is it important to check if it is written at the appropriate level?', 10, N'Because the level of difficulty of technical vocabulary in a source reflects the audience the source is aimed at and the complexity of concepts used.', N'Because sources without appropriately formal language will sound unusual when quoted.', N' Because it means that the topic is explored at an appropriate depth.', N'Because it means that it is related to the topic of your assessment question', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (54, N'When checking for relevance, what does it mean if an information source meets the needs of your assignment?', 10, N'It means the information source is part of the scholarly record.', N'It means the information source is the correct type of source for the assignment (e.g., textbook, primary or secondary source).', N' It means that it is in the same academic field that you are studying in.', N' It means that the topic is appropriately explored.', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (55, N'Based upon studies from conducted by accredited certification bodies and the Lumina Foundation, which of the following is true regarding professionals who hold industry validated certifications?', 9, N'They demonstrate higher productivity than peers without professional certifications.', N'They have greater potential to earn higher salaries than peers without professional certifications.', N'They are statistically shown to have greater intelligence than their peers without professional certifications.', N' They are more likely to be employed by enterprise level organizations.', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (56, N'When scheduling your exam on Pearson VUE, you will be asked to provide information about yourself. Which of the following do you need to be sure to do when entering this information?', 9, N'Have your video camera on and set to the correct aspect ratio', N'Run the speed the test prior to entering your information.', N'Set up a unique email to receive exam information from Pearson VUE.', N'Match the government-issued ID that you will use to verify your identity on the day of the exam.', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (57, N'Which of the following is a noted difference between a certificate and a certification?', 9, N'Certifications cannot be revoked.', N'Certifications are granted upon completion of a course.', N'Certifications are issued by industry certification bodies.', N'Certifications can be accredited.', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (58, N'Which of the following are included in an exam blueprint?', 9, N' The length of the exam', N'How to schedule your exam', N' Time and date of your exam', N'Practice questions', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (59, N'Upon successful completion of your exam, which of the following actions can you take to share your certification with employers and peers?', 8, N'Post your Accredible-issued badge on social platforms such as LinkedIn.', N'Share a screenshot from the end of the exam showing that you passed.', N'Display your Coursera Professional Certificate on social platforms such as LinkedIn.', N'Forward the email notification from Pearson VUE that you receive upon passing the exam to your employer.', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (60, N'Which of the following are included in the CertNexus Candidate Agreement?', 8, N'Instructions on how to schedule your exam', N'Domains and objectives covered in the exam', N'Expectations of personal conduct such as cheating', N'List of subject matter experts that contributed to the job task analysis', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (61, N'Reviewing the exam blueprint prior to scheduling your exam will allow candidates to do which of the following?', 8, N'Practice the skills required to complete the tasks outlined in the objectives.', N'Consider whether you possess the knowledge, skills, and abilities required to successfully pass the exam.', N'Practice exam items that reflect the questions on the certification exam.', N'Consider whether you have the required degree or licensure to successfully pass the exam.', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (62, N'Which of the following defines the AI black box problem?', 8, N'A dangerous machine intelligence put in a digital prison', N'The challenge of understanding the inner workings of opaque systems', N'Not being able to know how something crashed or failed', N'Machine intelligence making something illusory, like pulling a rabbit from a hat', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (63, N'Which of the following describes dual-use or multipurpose data?', 7, N'Data collected for one application that could also be applied to another application in a different domain.', N'Data that can be used in multiple devices or formats, such as a video on a Smart TV, tablet, and computer.', N'Data that can be transformed into multiple forms, e.g. extracting audio from a video file.', N'Data that can be easily shared with a partner or family member for mutual enjoyment.', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (64, N'Which of the following is the generally agreed upon current state of the art of AI?', 7, N'Superintelligence', N'Perceptrons', N'Narrow AI', N'Strong AI', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (65, N'Which of the following, by itself, qualifies as personally identifiable information (PII)?', 6, N'A user is home address', N' A users customer ID in an online ordering system', N'System events added to a log', N'Temperature readings for an office building', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (66, N'Why are groups like race and religion considered protected classes?', 6, N'Data about the user is always collected, regardless of the users consent.', N'These groups can be used to personally identify someone.', N'People use these groups as the basis for their identities.', N'These groups have been used as the basis for wholesale discrimination.', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (67, N'Which of the following describes an opt-out policy in regards to the collection of private data?', 6, N'Data about the user is always collected, regardless of the users consent.', N'Data about that user isnt collected until that user explicitly states you are allowed to.', N'Data about the user is never collected, regardless of the users consent.', N'Data about the user is automatically collected unless that user explicitly states that you should not do so.', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (68, N'What is the purpose of differential privacy?', 6, N'To enable parties to share private data without revealing individuals represented in the data.', N'To ensure the data is completely confidential and cannot be read by unauthorized parties.', N'To only allow certain parties to access certain portions of the data.', N'To remove the direct identifiers that can be used to identify individuals.', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (69, N'Primary colors are considered "primary" because:', 5, N'They are the best colors', N'They can be mixed by using a variety of other colors', N'They can not be made by mixing other colors', N'They are the first colors', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (70, N'Which key would you press when you would like to add to an active selection.?', 5, N'Command', N'Function', N'Shift', N'Alt/option', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (71, N'Secondary colors can be created by mixing:', 5, N'Terciary Colors', N'All colors', N'One primary and one secondary color', N'2 primary colors', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (72, N'There are a number of systems for organizing color. Joseph Albers used this method to organize his theory of color, the same system we have used in class.', 4, N'Monochromatic color', N'The color wheel', N'The color tire', N'Secondary color', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (73, N'Color can evoke emotions and have many symbolic meanings.  For example Red is the color of extremes.  It can represent passion, danger, anger and adventure. Red was a rare and expensive dye in ancient times and as a result it has taken on magical qualities.  Check the following answers not that best describe the meaning of  RED.', 4, N'Red is a soothing color used in many bedrooms in America.', N'Red is one of the top two favorite colors of all people.', N'Red is the most popular color used on flags throughout the world.', N'Red is the international color of STOP.', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (74, N'Harmony can be achieved by', 4, N'Using secondary colors', N'Making primaries', N'Making a pleasing arrangement of colors and elements of art.', N'Making things look good', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (75, N'What is the shortcut for transforming a shape in Photoshop?', 4, N'Command Z', N'Command T', N'M', N'Command P', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (76, N'When creating harmony in a work of art, using ______________________ colors work the best.', 3, N'Analogous', N'Complementary', N'Secondary', N'Primary', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (77, N'Color behaves differently based on the background the color is placed upon as well as the colors around it.  Artists use this information to create color schemes for their work. When using a color scheme based on opposite colors, the effect is one of :', 3, N'Intellegent', N'Energetic and active.', N'Calm and peaceful', N'None', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (78, N'Which letter is the shortcut key for the marquee tool in Photoshop?', 3, N'A', N'D', N'M', N'Z', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (79, N'Blue is the favorite color of all people.  It is natures color for water and sky, but is rarely found in fruit or vegetables. Blue is also the color of heaven. Choose the sentence  below that best represents blue.', 3, N'Blue is the color of emergencies.', N'Bright blue can represent cleanliness, strength and coolness.', N'Blue represents royalty, but not in a good, kingly way', N'None', 2)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (80, N'Analogous colors are colors that are next to each other on the color wheel.  An example of Analogous colors would be:', 2, N'Green, yellow green, and yellow', N'Orange, purple and green', N'Orange, Orange and green', N'Red , blue and yellow', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (81, N'Harmony can be achieved by', 2, N'Making things look good', N'Using secondary colors', N'Making a pleasing arrangement of colors and elements of art.', N'Making primaries', 3)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (82, N'The magic wand tool selects areas on the image by using a _______________________ based on the tolorence you have set in the', 2, N'Color range', N'Home on the range', N'Shape range', N'Transform range', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (83, N'Artists can base their color schemes on many different aspects of our world.  One color scheme would be one based on nature.  Nature provides a perfect departure point for color harmony.  One example of a color scheme derived from nature would be __________', 2, N'Color based on cars', N'Color based on a living room', N'Color based on the internet', N'Color based on fall leaves', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (84, N'At what point should ethical consideration ideally be applied to emerging technologies?', 7, N'Upon delivery, with appropriate warranties where necessary.', N'During periodic reviews, with ongoing customer feedback solicited.', N' Once an ethical issue has received negative feedback in public media.', N' From its inception, through maintenance, to applying foresight regarding its decommissioning.', 4)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (85, N'Which of the following is an example of the contribution of information and digital literacy to the values of academic culture?', 2, N'Beginning an assignment with one opinion but changing your opinion as you gather and read more information sources with contrary evidence.', N'Giving a presentation', N'Cataloging information on a library website.', N'Making a valid argument', 1)
INSERT [dbo].[Quiz] ([QuestionID], [Question], [LessonID], [Answer1], [Answer2], [Answer3], [Answer4], [AnswerCorrect]) VALUES (87, N'What is a correct syntax to output "Hello World" in Java?', 27, N'echo("Hello World"); ', N'Console.WriteLine("Hello World");', N'System.out.println("Hello World");  ', N'print ("Hello World")', 3)
SET IDENTITY_INSERT [dbo].[Quiz] OFF
GO
SET IDENTITY_INSERT [dbo].[Result] ON 

INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (1, 3, N'AnhTuan', CAST(N'2022-07-10' AS Date), CAST(5.00 AS Decimal(10, 2)), N'PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (2, 5, N'ThuThu', CAST(N'2022-07-10' AS Date), CAST(6.67 AS Decimal(10, 2)), N'PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (3, 2, N'ThuThu', CAST(N'2022-07-10' AS Date), CAST(0.00 AS Decimal(10, 2)), N'NOT PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (4, 21, N'QuangQuan', CAST(N'2022-07-10' AS Date), CAST(5.00 AS Decimal(10, 2)), N'PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (5, 2, N'QuangQuan', CAST(N'2022-07-19' AS Date), CAST(4.00 AS Decimal(10, 2)), N'NOT PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (6, 2, N'ThuThu', CAST(N'2022-07-19' AS Date), CAST(0.00 AS Decimal(10, 2)), N'NOT PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (7, 2, N'ThuThu', CAST(N'2022-07-19' AS Date), CAST(0.00 AS Decimal(10, 2)), N'NOT PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (8, 11, N'ThuThu', CAST(N'2022-07-19' AS Date), CAST(0.00 AS Decimal(10, 2)), N'NOT PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (9, 21, N'QuangQuan', CAST(N'2022-07-20' AS Date), CAST(5.00 AS Decimal(10, 2)), N'PASS')
INSERT [dbo].[Result] ([ResultID], [LessonID], [Username], [DateRecord], [score], [status]) VALUES (10, 22, N'QuangQuan', CAST(N'2022-07-21' AS Date), CAST(4.00 AS Decimal(10, 2)), N'NOT PASS')
SET IDENTITY_INSERT [dbo].[Result] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (1, N'Nguyen Thi Thu', N'0984739845', N'7683 Ruskin Avenue', N'./img/7c3bfe2a3377aa43ccc0baa048fb1449.jpg', N'oparagreen0@usnews.com', N'Male', N'ThuThu', CAST(N'2001-12-08' AS Date))
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (2, N'Nguyen Anh Tuan', N'6298446654', N'0341 Everett Court', N'./img/8f8aa2f4307101c6483042f6310d1842.jpg', N'kfleet1@artisteer.com', N'Male', N'AnhTuan', NULL)
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (3, N'Chu Quang Quan', N'0984739845', N'7023 Algoma Street', N'./img/d5495158249f773d9521015316be85a5.jpg', N'nguyenthu12@gmail.com', N'Male', N'QuangQuan', CAST(N'2001-09-09' AS Date))
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (4, N'Ta Nhat Anh', N'9306711406', N'943 Heath Pass', N'https://pdp.edu.vn/wp-content/uploads/2021/05/hinh-anh-avatar-nam-1-600x600.jpg', N'phatherell3@sun.com', N'Female', N'NhatAnh', CAST(N'2001-02-03' AS Date))
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (5, N'Nguyen Minh Duc', N'5541282702', N'005 Prairie Rose Point', N'https://hinhnen123.com/?attachment_id=405', N'bkervin4@fotki.com', N'Female', N'MinhDuc', CAST(N'2001-09-01' AS Date))
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (6, N'Nguyen Minh Vuong', N'9544569704', N'4 Aberg Drive', N'https://demoda.vn/wp-content/uploads/2022/04/avatar-cap-doi-chibi-lang-man-ve-nu.jpg', N'rrushworth5@topsy.com', N'Male', N'VuongDepTrai', NULL)
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (8, N'Nguyen Linh Chi', N'0984739845', N'Thai Binh', N'./img/4653e8a0b6b786a32fafeda215fd8b64.jpg', N'nguyenthu120801@gmail.com', N'Female', N'ChiChi', NULL)
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (10, N'Nguyen Phuong Anh', NULL, N'Ha Noi', N'./img/c4b0bb737d3c403069dda4ca1df8d7cb.jpg', N'Anhnp@gmail.com', N'Female', N'Phuong Anh', NULL)
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (11, N'Nguyen Linh Chi', NULL, N'Nam Dinh', N'./img/4653e8a0b6b786a32fafeda215fd8b64.jpg', N'chi@gmail.com', N'Female', N'LanChi', CAST(N'2001-02-12' AS Date))
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (12, N'Nong Ha Lan', NULL, NULL, N'./img/testimonial-4.jpg', N'lan@gmail.com', N'Female', N'HaLan', NULL)
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (13, N'Lam Phuong Hang', NULL, NULL, N'https://i.pinimg.com/736x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg', N'hang12080@gmail.com', N'Male', N'LamHang', NULL)
INSERT [dbo].[Student] ([ID], [FullName], [phone], [address], [image], [email], [gender], [username], [DateOfBirth]) VALUES (14, N'Nguyen Minh Hang', N'0984739845', N'Ha Nam', N'https://i.pinimg.com/736x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg', N'Hang22@gmail.com', N'Male', N'MinhHang', NULL)
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (1, N'Kirk Nelson', N'6481628081', N'https://s3.amazonaws.com/cms-assets.tutsplus.com/uploads/users/8/profiles/18494/profileImage/KirkHeadShot.jpg', N'KirkNelson@upenn.edu', N'FeMale', N'Kirk')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (2, N'Ulises Ayliffe', N'6511678528', N'./img/team-1.jpg', N'uayliffe1@yahoo.co.jp', N'FeMale', N'Ulises')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (3, N'Terrell Cordobes', N'7908661977', N'./img/team-2.jpg', N'tcordobes2@europa.eu', N'Male', N'Terrell')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (4, N'Virge Aldred', N'2934629124', N'./img/team-3.jpg', N'valdred3@wisc.edu', N'FeMale', N'Virge')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (5, N'Tommy Walbrun', N'9661305299', N'https://img.lovepik.com/free-png/20210919/lovepik-male-teacher-teaching-png-image_400770642_wh1200.png', N'twalbrun4@rambler.ru', N'Male', N'Tommy')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (6, N'Nguyen Thi Le Nam', N'0984739845', N'./img/8b07da75efb3dfd02481aa2ae9a84de9.jpg', N'LeNam@gmail.com', N'Female', N'LeNam')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (7, N'Nguyen Minh Dat', N'1234567891', N'./img/f918777a19aaa184dfc252224a8640c1.jpg', N'Dat1l@gmail.com', N'Male', N'DatLa')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (8, N'Nong Thuy Hang', N'0328194997', N'https://i.pinimg.com/736x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg', N'hang@gmail.com', N'Female', N'HangThuy')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (9, N'Nguyen Thuc Thuy Tien', N'0321234123', N'https://i.pinimg.com/736x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg', N'tien@gmail.com', N'Female', N'Tien')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (10, N'Pham Minh Tu', N'0984739845', N'https://i.pinimg.com/736x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg', N'Tu@gmail.com', N'Female', N'TuPM')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (11, N'Nicky Gaitone', N'7583151589', N'https://i.pinimg.com/564x/08/51/e6/0851e61234e5341c687dbb716158e320.jpg', N'ngaitone6@cyberchimps.com', N'Female', N'Nicky')
INSERT [dbo].[Teacher] ([ID], [FullName], [phone], [image], [email], [gender], [username]) VALUES (12, N'Nguyen Minh Anh', N'9288319812', N'https://i.pinimg.com/736x/75/ae/6e/75ae6eeeeb590c066ec53b277b614ce3.jpg', N'minhanh@gmail.com', N'Male', N'Minh Anh')
SET IDENTITY_INSERT [dbo].[Teacher] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Student__F3DBC57271454B9A]    Script Date: 7/21/2022 10:22:44 AM ******/
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [UQ__Student__F3DBC57271454B9A] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Teacher__F3DBC5721E9C1D1B]    Script Date: 7/21/2022 10:22:44 AM ******/
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [UQ__Teacher__F3DBC5721E9C1D1B] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK__Course__Category__398D8EEE] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK__Course__Category__398D8EEE]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK__Course__TeacherI__3A81B327] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teacher] ([ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK__Course__TeacherI__3A81B327]
GO
ALTER TABLE [dbo].[Lesson]  WITH CHECK ADD  CONSTRAINT [FK__Lesson__CourseID__3B75D760] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Lesson] CHECK CONSTRAINT [FK__Lesson__CourseID__3B75D760]
GO
ALTER TABLE [dbo].[LessonPDF]  WITH CHECK ADD  CONSTRAINT [FK__LessonPDF__Lesso__3C69FB99] FOREIGN KEY([LessonID])
REFERENCES [dbo].[Lesson] ([LessonID])
GO
ALTER TABLE [dbo].[LessonPDF] CHECK CONSTRAINT [FK__LessonPDF__Lesso__3C69FB99]
GO
ALTER TABLE [dbo].[LessonVideo]  WITH CHECK ADD  CONSTRAINT [FK__LessonVid__Lesso__3D5E1FD2] FOREIGN KEY([LessonID])
REFERENCES [dbo].[Lesson] ([LessonID])
GO
ALTER TABLE [dbo].[LessonVideo] CHECK CONSTRAINT [FK__LessonVid__Lesso__3D5E1FD2]
GO
ALTER TABLE [dbo].[Pay_Course]  WITH CHECK ADD  CONSTRAINT [FK__Pay_Cours__Cours__403A8C7D] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Pay_Course] CHECK CONSTRAINT [FK__Pay_Cours__Cours__403A8C7D]
GO
ALTER TABLE [dbo].[Pay_Course]  WITH CHECK ADD  CONSTRAINT [FK_Pay_Course_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Pay_Course] CHECK CONSTRAINT [FK_Pay_Course_Student]
GO
ALTER TABLE [dbo].[Quiz]  WITH CHECK ADD  CONSTRAINT [FK__Quiz__LessonID__3E52440B] FOREIGN KEY([LessonID])
REFERENCES [dbo].[Lesson] ([LessonID])
GO
ALTER TABLE [dbo].[Quiz] CHECK CONSTRAINT [FK__Quiz__LessonID__3E52440B]
GO
ALTER TABLE [dbo].[Result]  WITH CHECK ADD  CONSTRAINT [FK__Result__LessonID__412EB0B6] FOREIGN KEY([LessonID])
REFERENCES [dbo].[Lesson] ([LessonID])
GO
ALTER TABLE [dbo].[Result] CHECK CONSTRAINT [FK__Result__LessonID__412EB0B6]
GO
ALTER TABLE [dbo].[Result]  WITH CHECK ADD  CONSTRAINT [FK_Result_Student] FOREIGN KEY([Username])
REFERENCES [dbo].[Student] ([username])
GO
ALTER TABLE [dbo].[Result] CHECK CONSTRAINT [FK_Result_Student]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK__Student__usernam__4316F928] FOREIGN KEY([username])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK__Student__usernam__4316F928]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK__Teacher__usernam__440B1D61] FOREIGN KEY([username])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK__Teacher__usernam__440B1D61]
GO
USE [master]
GO
ALTER DATABASE [SWP391_ONLINE_LEARN] SET  READ_WRITE 
GO
