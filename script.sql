USE [master]
GO
/****** Object:  Database [Panleksa]    Script Date: 8/28/2021 2:48:57 PM ******/
CREATE DATABASE [Panleksa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Panleksa', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ARES\MSSQL\DATA\Panleksa.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Panleksa_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.ARES\MSSQL\DATA\Panleksa_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Panleksa] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Panleksa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Panleksa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Panleksa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Panleksa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Panleksa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Panleksa] SET ARITHABORT OFF 
GO
ALTER DATABASE [Panleksa] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Panleksa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Panleksa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Panleksa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Panleksa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Panleksa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Panleksa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Panleksa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Panleksa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Panleksa] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Panleksa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Panleksa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Panleksa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Panleksa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Panleksa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Panleksa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Panleksa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Panleksa] SET RECOVERY FULL 
GO
ALTER DATABASE [Panleksa] SET  MULTI_USER 
GO
ALTER DATABASE [Panleksa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Panleksa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Panleksa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Panleksa] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Panleksa] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Panleksa] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Panleksa', N'ON'
GO
ALTER DATABASE [Panleksa] SET QUERY_STORE = OFF
GO
USE [Panleksa]
GO
/****** Object:  User [Panzo]    Script Date: 8/28/2021 2:48:57 PM ******/
CREATE USER [Panzo] FOR LOGIN [Panzo] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Aleksa]    Script Date: 8/28/2021 2:48:57 PM ******/
CREATE USER [Aleksa] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Panzo]
GO
/****** Object:  UserDefinedFunction [dbo].[Iznos]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUnction [dbo].[Iznos] (@Cijena INT, @Kolicina Int, @PDV bit, @Rabat Int)
REturns INT
As 
Begin	
Declare @Result Smallmoney
IF @PDV = 1  and @Rabat >0
begin
	SET @Result = (@Cijena * @Kolicina * 17) / 100 + @Cijena * @Kolicina - (@Cijena * @Kolicina * @Rabat) / 100;
	end

Else if @Pdv = 1 and @Rabat = 0
begin
	SET @Result = (@Cijena * @Kolicina * 17) / 100 + @Cijena * @Kolicina;
	end
Else if @PDV = 0 and @Rabat > 0
begin
	Set @Result = @Cijena * @Kolicina - (@Cijena * @Kolicina * @Rabat) / 100
	end
else	
begin
	Set @Result = (@Cijena * @Kolicina);
	end
RETURN 
@Result
end
GO
/****** Object:  Table [dbo].[Inventar]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventar](
	[id_robe] [smallint] NOT NULL,
	[naziv_robe] [nvarchar](50) NOT NULL,
	[kolicina] [smallint] NULL,
	[cijena] [smallmoney] NULL,
	[jed_mjere] [bit] NULL,
 CONSTRAINT [PK_Inventar] PRIMARY KEY CLUSTERED 
(
	[naziv_robe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Osnovne]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Osnovne](
	[naziv_pravnog_lica] [smallint] NULL,
	[adresa] [nvarchar](50) NULL,
	[IB] [char](13) NOT NULL,
	[otpremi_na_naslov] [nvarchar](50) NULL,
	[adresa_kupac] [nvarchar](50) NULL,
	[nacin_otpreme] [smallint] NULL,
	[reklamacija] [char](1) NULL,
	[datum] [date] NULL,
	[ID] [smallint] NOT NULL,
	[IB_kupac] [char](13) NULL,
	[reg_br_vozila_sluzbenog] [char](9) NULL,
 CONSTRAINT [PK_Osnovne] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rabat]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rabat](
	[rb] [nvarchar](3) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[radne_pozicije]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[radne_pozicije](
	[id] [smallint] NOT NULL,
	[radna_pozicija] [char](20) NULL,
 CONSTRAINT [PK_radne_pozicije] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[servis]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[servis](
	[id_servisa] [smallint] NOT NULL,
	[serviser] [smallint] NULL,
	[usluga] [text] NULL,
	[otprema_na_naslov] [varchar](50) NULL,
	[prijem] [date] NULL,
	[stanje_servisa] [bit] NULL,
	[isporuka] [date] NULL,
	[email] [varchar](50) NULL,
	[telefon] [varchar](20) NULL,
	[opis_servisa] [text] NULL,
 CONSTRAINT [PK_servis] PRIMARY KEY CLUSTERED 
(
	[id_servisa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipovi_naloga]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipovi_naloga](
	[id] [smallint] NOT NULL,
	[naziv] [char](20) NULL,
 CONSTRAINT [PK_tipovi_naloga] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usluge]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usluge](
	[redni_broj] [smallint] NULL,
	[naziv_robe] [smallint] NULL,
	[jed_mjere] [bit] NULL,
	[kolicina] [smallint] NULL,
	[cijena] [smallmoney] NULL,
	[rabat] [smallint] NULL,
	[pdv] [bit] NULL,
	[otpremnica_br] [smallint] NULL,
	[Iznos]  AS ([dbo].[Iznos]([Cijena],[Kolicina],[PDV],[rabat]))
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zaposleni]    Script Date: 8/28/2021 2:48:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zaposleni](
	[id] [smallint] NOT NULL,
	[korisnicko_ime] [nvarchar](20) NULL,
	[lozinka] [nvarchar](260) NULL,
	[tip_naloga] [smallint] NULL,
	[ime] [nvarchar](15) NULL,
	[prezime] [nvarchar](15) NULL,
	[pozicija] [smallint] NULL,
	[adresa] [nvarchar](50) NULL,
	[telefon] [char](13) NULL,
	[sluz_voz] [char](9) NULL,
	[email] [varchar](50) NULL,
	[salt] [varchar](50) NULL,
 CONSTRAINT [PK_zaposleni] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (59, N'AMD Radeon RX 5500 XT 4GB', 315, 169.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (55, N'AMD Radeon RX 6600 XT', 150, 379.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (52, N'AMD Radeon RX 6700 XT', 91, 479.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (50, N'AMD Radeon RX 6800', 58, 579.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (48, N'AMD Radeon RX 6800 XT', 39, 649.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (47, N'AMD Radeon RX 6900 XT', 15, 999.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (23, N'AMD Ryxen 9 5950X', 10, 799.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (28, N'AMD Ryzen 9 3950X', 24, 749.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (27, N'AMD Ryzen 9 5900X', 20, 549.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (31, N'AMD Ryzen Threadripper 3960X', 3, 1399.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (107, N'Antec P82 Silent', 75, 85.4900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (37, N'ASUS ROG Maximus XIII Hero Z590', 18, 380.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (32, N'ASUS ROG Strix X570-E', 15, 327.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (33, N'ASUS ROG Strix Z590-E', 18, 360.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (39, N'ASUS ROG Strix Z590-I', 38, 350.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (34, N'ASUS TUF B550-PLIS', 50, 156.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (35, N'ASUS TUF H570-PRO', 60, 190.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (108, N'be quiet! Dark Base 700', 26, 159.9000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (43, N'Colorful CVN Guardian 16GB DDR4-3200', 55, 111.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (66, N'Cooler Master Hyper 212 EVO', 319, 36.9900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (67, N'Cooler Master MasterLiquid ML360R', 379, 119.9000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (12, N'Core i7 9th', 2, 300.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (13, N'Core i9 3rd', 81, 260.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (14, N'Core i9 5th', 77, 280.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (15, N'Core i9 7th', 50, 311.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (16, N'Core i9 9th', 25, 400.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (74, N'Corsair AX1600i', 29, 500.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (72, N'Corsair CX450', 39, 55.6300, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (41, N'Corsair Dominator Platinum RGB 32GB DDR4-3200MHz', 19, 211.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (60, N'Corsair H115i RGB Platinum', 80, 154.9000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (65, N'Corsair H60', 222, 84.9000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (105, N'Corsair Obsidian Series 4000X RGB', 111, 115.2900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (70, N'Corsair RM750x (2021)', 33, 94.9000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (97, N'Crucial MX500 1TB SATA SSD', 453, 39.4900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (83, N'Crucial P5 Plus 1TB M.2 SSD', 15, 173.7600, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (84, N'Crucial P5 Plus 2TB M.2 SSD', 9, 199.9900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (82, N'Crucial P5 Plus 500GB M.2 SSD', 37, 116.1500, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (63, N'EVGA CLC 240', 165, 90.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (106, N'Fractal Design Define 7', 102, 110.4200, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (75, N'Fractal Design Ion SFX 650 Gold', 35, 159.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (102, N'Fractal Design Meshify 2', 142, 88.8900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (100, N'Fractal Design Meshify 2 Compact', 70, 102.5800, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (45, N'G.Skill Ripjaws V 16GB DDR4-2400MHz', 91, 84.0900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (42, N'G.Skill Trident Z Neo 32GB DDR4-3600MHz', 27, 293.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (44, N'G.Skill Trident Z Royal 16GB DDR4-4000MHz', 10, 271.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (68, N'GamerStorm Deep Cool Assassin III', 186, 87.1000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (17, N'GeForce GTX 1550', 19, 400.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (18, N'GeForce GTX 1660', 9, 470.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (19, N'GeForce GTX 1660Ti', 7, 550.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (36, N'Gigabyte TRX40 AORUS Master', 11, 495.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (38, N'Gigabyte X570 I AORUS Pro WIFI', 27, 226.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (2, N'HDD 512GB', 179, 20.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (20, N'Instaliranje RAM-a', 1, 15.0000, 0)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (26, N'Intel Core i9-10850K', 42, 453.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (24, N'Intel Core i9-10900K', 30, 488.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (25, N'Intel Core i9-10900KF', 37, 463.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (29, N'Intel Core i9-11900K', 81, 539.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (30, N'Intel Core i9-7980XE', 7, 1979.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (101, N'Lian Li Lancool II Mesh', 89, 106.9700, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (62, N'Noctua NH-D15', 90, 83.9400, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (64, N'Noctua NH-P1', 231, 106.8900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (58, N'Nvidia GeForce GTX 1650 Super', 256, 159.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (57, N'Nvidia GeForce GTX 1660 Super', 211, 229.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (56, N'Nvidia GeForce RTX 3060 12GB', 179, 329.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (54, N'Nvidia GeForce RTX 3060 Ti', 121, 399.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (51, N'Nvidia GeForce RTX 3070', 86, 499.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (49, N'Nvidia GeForce RTX 3080', 49, 699.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (46, N'Nvidia GeForce RTX 3090', 5, 1499.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (11, N'NVMe M.2 256GB', 17, 500.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (103, N'Phanteks Eclipse P360A', 156, 79.7900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (109, N'Phanteks Enthoo Pro II', 75, 174.9900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (104, N'Phanteks Evolv Shift 2', 179, 108.9000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (1, N'RAM DDR3 2GB', 350, 30.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (3, N'RAM DDR3 4GB', 191, 55.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (6, N'RAM DDR4 16GB ', 65, 120.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (4, N'RAM DDR4 4GB', 161, 65.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (5, N'RAM DDR4 8GB', 109, 80.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (85, N'Sabrent Rocket 4 Plus 1TB M.2 SSD', 18, 152.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (86, N'Sabrent Rocket 4 Plus 2TB M.2 SSD', 15, 186.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (87, N'Sabrent Rocket 4 Plus 4TB M.2 SSD', 12, 215.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (96, N'Samsung 870 EVo 4TB SATA SSD', 563, 107.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (92, N'Samsung 970 EVO Plus 1TB M.2 SSD', 36, 156.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (90, N'Samsung 970 EVO Plus 250GB M.2 SSD', 86, 65.3100, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (91, N'Samsung 970 EVO Plus 500GB M.2 SSD', 75, 94.3100, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (78, N'Samsung 980 Pro 1TB M.2 SSD', 17, 179.6000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (76, N'Samsung 980 Pro 250GB M.2 SSD', 46, 90.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (79, N'Samsung 980 Pro 2TB M.2 SSD', 6, 216.9900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (77, N'Samsung 980 Pro 500GB M.2 SSD', 35, 111.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (98, N'Sastavljanje racunara (komponente od musterije)', 1, 15.0000, 0)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (99, N'Sastavljanje racunara (kupljene nase komponente)', 1, 8.0000, 0)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (71, N'Seasonic Prime Titanium TX-1000', 17, 289.9900, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (89, N'SK hynix Gold P31 1TB M.2 SSD', 53, 126.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (88, N'SK hynix Gold P31 500GB M.2 SSD', 68, 85.9800, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (7, N'SSD 128GB', 442, 80.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (10, N'SSD 1T', 7, 300.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (8, N'SSD 256GB', 152, 160.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (21, N'SSD 2T', 8, 550.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (9, N'SSD 512GB', 76, 220.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (95, N'Team Group T-Force Cardea Zero Z340 1TB M.2 SSD', 76, 219.7600, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (93, N'Team Group T-Force Cardea Zero Z340 256GB M.2 SSD', 156, 126.1900, 1)
GO
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (94, N'Team Group T-Force Cardea Zero Z340 512GB M.2 SSD', 94, 183.5700, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (40, N'Team XTREEM ARGB 16GB DDR4-3600MHz C14', 16, 169.0000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (81, N'WB Black SN850 2TB M.2 SSD', 18, 156.3600, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (80, N'WB Black SN850 500GB M.2 SSD', 35, 89.9000, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (73, N'XPG Core Reactor 650W', 46, 96.8500, 1)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (61, N'Zamjena coolera na procesoru.', 1, 7.0000, 0)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (53, N'Zamjena graficke karte', 1, 10.0000, 0)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (69, N'Zamjena racunarskog napajanja.', 1, 3.0000, 0)
INSERT [dbo].[Inventar] ([id_robe], [naziv_robe], [kolicina], [cijena], [jed_mjere]) VALUES (22, N'Zamjena termalne paste', 1, 5.0000, 0)
GO
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (5, N'Vatrenih Jahaca BB', N'4428006942051', N'Janko Vitkovic', N'Samozivih Jedrenjaka BB', 2, N'1', CAST(N'2021-06-30' AS Date), 1, N'4425896578051', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (5, N'Vatrenih Jahaca BB', N'4428006942051', N'Janko Vitkovic', N'Samozivih Jedrenjaka BB', 2, N'1', CAST(N'2021-06-30' AS Date), 2, N'4425896578051', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (5, N'Vatrenih Jahaca BB', N'4428006942051', N'Janko Vitkovic', N'Samozivih Jedrenjaka BB', 2, N'1', CAST(N'2021-06-30' AS Date), 3, N'4425896578051', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (5, N'Vatrenih Jahaca BB', N'4428006942051', N'Janko Vitkovic', N'Samozivih Jedrenjaka BB', 2, N'1', CAST(N'2021-06-30' AS Date), 4, N'4425896578051', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (5, N'Vatrenih Jahaca BB', N'4428006942051', N'Janko Vitkovic', N'Samozivih Jedrenjaka BB', 2, N'1', CAST(N'2021-06-30' AS Date), 5, N'4425896578051', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (6, N'Vatrenih Jahaca BB', N'4428006942051', N'Slavojko Vrabac', N'Brace Kojic 18a', 2, N'2', CAST(N'2021-08-17' AS Date), 6, N'4428006632014', N'V13-G-093')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (1, N'Vatrenih Jahaca BB', N'4428006942051', N'Svitka Slavuja', N'Bosonoge Djece 11a', 2, N'3', CAST(N'2021-08-17' AS Date), 7, N'4428005144459', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (4, N'Vatrenih Jahaca BB', N'4428006942051', N'Svitka Slavuja', N'Bosonoge Djece 11a', 2, N'1', CAST(N'2021-08-17' AS Date), 8, N'4428005144459', N'V13-G-093')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (1, N'Vatrenih Jahaca BB', N'4428006942051', N'Svitka Slavuja', N'Bosonoge Djece 11a', 2, N'2', CAST(N'2021-08-19' AS Date), 9, N'4428005144459', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (2, N'Vatrenih Jahaca BB', N'4428006942051', N'Jevrosim Ljbkovic', N'Slavojka Svitka', 2, N'2', CAST(N'2021-08-20' AS Date), 10, N'4428003212582', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (11, N'Vatrenih Jahaca BB', N'4428006942051', N'Slavojko Vrabac', N'Brace Kojic 18a', 3, N'1', CAST(N'2021-08-20' AS Date), 11, N'4428006632014', N'123-5-786')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (5, N'Vatrenih Jahaca BB', N'4428006942051', N'Slavojko Vrabac', N'Brace Kojic 18a', 2, N'1', CAST(N'2021-08-20' AS Date), 12, N'4428006632014', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (7, N'Vatrenih Jahaca BB', N'4428006942051', N'Janko Vitkovic', N'Samozivih Jedrenjaka BB', 2, N'1', CAST(N'2021-08-20' AS Date), 13, N'4425896578051', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (1, N'Vatrenih Jahaca BB', N'4428006942051', N'Predrag Marceta', N'Zore Kovacevic 9a', 2, N'3', CAST(N'2021-08-20' AS Date), 14, N'4428002547869', N'V13-R-182')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (4, N'Vatrenih Jahaca BB', N'4428006942051', N'Predrag Marceta', N'Zore Kovacevic 9a', 2, N'2', CAST(N'2021-08-21' AS Date), 15, N'4428002547869', N'V13-G-093')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (5, N'Vatrenih Jahaca BB', N'4428006942051', N'Predrag Marceta', N'Zore Kovacevic 9a', 2, N'1', CAST(N'2021-08-21' AS Date), 16, N'4428002547869', N'V13-G-093')
INSERT [dbo].[Osnovne] ([naziv_pravnog_lica], [adresa], [IB], [otpremi_na_naslov], [adresa_kupac], [nacin_otpreme], [reklamacija], [datum], [ID], [IB_kupac], [reg_br_vozila_sluzbenog]) VALUES (6, N'Vatrenih Jahaca BB', N'4428006942051', N'Slavojko Vrabac', N'Brace Kojic 18a', 3, N'3', CAST(N'2021-08-21' AS Date), 17, N'4428006632014', N'123-4-543')
GO
INSERT [dbo].[rabat] ([rb]) VALUES (N'0')
INSERT [dbo].[rabat] ([rb]) VALUES (N'1')
INSERT [dbo].[rabat] ([rb]) VALUES (N'2')
INSERT [dbo].[rabat] ([rb]) VALUES (N'3')
INSERT [dbo].[rabat] ([rb]) VALUES (N'4')
INSERT [dbo].[rabat] ([rb]) VALUES (N'5')
INSERT [dbo].[rabat] ([rb]) VALUES (N'6')
INSERT [dbo].[rabat] ([rb]) VALUES (N'7')
INSERT [dbo].[rabat] ([rb]) VALUES (N'8')
INSERT [dbo].[rabat] ([rb]) VALUES (N'9')
INSERT [dbo].[rabat] ([rb]) VALUES (N'10')
INSERT [dbo].[rabat] ([rb]) VALUES (N'11')
INSERT [dbo].[rabat] ([rb]) VALUES (N'12')
INSERT [dbo].[rabat] ([rb]) VALUES (N'13')
INSERT [dbo].[rabat] ([rb]) VALUES (N'14')
INSERT [dbo].[rabat] ([rb]) VALUES (N'15')
INSERT [dbo].[rabat] ([rb]) VALUES (N'16')
INSERT [dbo].[rabat] ([rb]) VALUES (N'17')
INSERT [dbo].[rabat] ([rb]) VALUES (N'18')
INSERT [dbo].[rabat] ([rb]) VALUES (N'19')
INSERT [dbo].[rabat] ([rb]) VALUES (N'20')
INSERT [dbo].[rabat] ([rb]) VALUES (N'21')
INSERT [dbo].[rabat] ([rb]) VALUES (N'22')
INSERT [dbo].[rabat] ([rb]) VALUES (N'23')
INSERT [dbo].[rabat] ([rb]) VALUES (N'24')
INSERT [dbo].[rabat] ([rb]) VALUES (N'25')
INSERT [dbo].[rabat] ([rb]) VALUES (N'26')
INSERT [dbo].[rabat] ([rb]) VALUES (N'27')
INSERT [dbo].[rabat] ([rb]) VALUES (N'28')
INSERT [dbo].[rabat] ([rb]) VALUES (N'29')
INSERT [dbo].[rabat] ([rb]) VALUES (N'30')
INSERT [dbo].[rabat] ([rb]) VALUES (N'31')
INSERT [dbo].[rabat] ([rb]) VALUES (N'32')
INSERT [dbo].[rabat] ([rb]) VALUES (N'33')
INSERT [dbo].[rabat] ([rb]) VALUES (N'34')
INSERT [dbo].[rabat] ([rb]) VALUES (N'35')
INSERT [dbo].[rabat] ([rb]) VALUES (N'36')
INSERT [dbo].[rabat] ([rb]) VALUES (N'37')
INSERT [dbo].[rabat] ([rb]) VALUES (N'38')
INSERT [dbo].[rabat] ([rb]) VALUES (N'39')
INSERT [dbo].[rabat] ([rb]) VALUES (N'40')
INSERT [dbo].[rabat] ([rb]) VALUES (N'41')
INSERT [dbo].[rabat] ([rb]) VALUES (N'42')
INSERT [dbo].[rabat] ([rb]) VALUES (N'43')
INSERT [dbo].[rabat] ([rb]) VALUES (N'44')
INSERT [dbo].[rabat] ([rb]) VALUES (N'45')
INSERT [dbo].[rabat] ([rb]) VALUES (N'46')
INSERT [dbo].[rabat] ([rb]) VALUES (N'47')
INSERT [dbo].[rabat] ([rb]) VALUES (N'48')
INSERT [dbo].[rabat] ([rb]) VALUES (N'49')
INSERT [dbo].[rabat] ([rb]) VALUES (N'50')
INSERT [dbo].[rabat] ([rb]) VALUES (N'51')
INSERT [dbo].[rabat] ([rb]) VALUES (N'52')
INSERT [dbo].[rabat] ([rb]) VALUES (N'53')
INSERT [dbo].[rabat] ([rb]) VALUES (N'54')
INSERT [dbo].[rabat] ([rb]) VALUES (N'55')
INSERT [dbo].[rabat] ([rb]) VALUES (N'56')
INSERT [dbo].[rabat] ([rb]) VALUES (N'57')
INSERT [dbo].[rabat] ([rb]) VALUES (N'58')
INSERT [dbo].[rabat] ([rb]) VALUES (N'59')
INSERT [dbo].[rabat] ([rb]) VALUES (N'60')
INSERT [dbo].[rabat] ([rb]) VALUES (N'61')
INSERT [dbo].[rabat] ([rb]) VALUES (N'62')
INSERT [dbo].[rabat] ([rb]) VALUES (N'63')
INSERT [dbo].[rabat] ([rb]) VALUES (N'64')
INSERT [dbo].[rabat] ([rb]) VALUES (N'65')
INSERT [dbo].[rabat] ([rb]) VALUES (N'66')
INSERT [dbo].[rabat] ([rb]) VALUES (N'67')
INSERT [dbo].[rabat] ([rb]) VALUES (N'68')
INSERT [dbo].[rabat] ([rb]) VALUES (N'69')
INSERT [dbo].[rabat] ([rb]) VALUES (N'70')
INSERT [dbo].[rabat] ([rb]) VALUES (N'71')
INSERT [dbo].[rabat] ([rb]) VALUES (N'72')
INSERT [dbo].[rabat] ([rb]) VALUES (N'73')
INSERT [dbo].[rabat] ([rb]) VALUES (N'74')
INSERT [dbo].[rabat] ([rb]) VALUES (N'75')
INSERT [dbo].[rabat] ([rb]) VALUES (N'76')
INSERT [dbo].[rabat] ([rb]) VALUES (N'77')
INSERT [dbo].[rabat] ([rb]) VALUES (N'78')
INSERT [dbo].[rabat] ([rb]) VALUES (N'79')
INSERT [dbo].[rabat] ([rb]) VALUES (N'80')
INSERT [dbo].[rabat] ([rb]) VALUES (N'81')
INSERT [dbo].[rabat] ([rb]) VALUES (N'82')
INSERT [dbo].[rabat] ([rb]) VALUES (N'83')
INSERT [dbo].[rabat] ([rb]) VALUES (N'84')
INSERT [dbo].[rabat] ([rb]) VALUES (N'85')
INSERT [dbo].[rabat] ([rb]) VALUES (N'86')
INSERT [dbo].[rabat] ([rb]) VALUES (N'87')
INSERT [dbo].[rabat] ([rb]) VALUES (N'88')
INSERT [dbo].[rabat] ([rb]) VALUES (N'89')
INSERT [dbo].[rabat] ([rb]) VALUES (N'90')
INSERT [dbo].[rabat] ([rb]) VALUES (N'91')
INSERT [dbo].[rabat] ([rb]) VALUES (N'92')
INSERT [dbo].[rabat] ([rb]) VALUES (N'93')
INSERT [dbo].[rabat] ([rb]) VALUES (N'94')
INSERT [dbo].[rabat] ([rb]) VALUES (N'95')
INSERT [dbo].[rabat] ([rb]) VALUES (N'96')
INSERT [dbo].[rabat] ([rb]) VALUES (N'97')
INSERT [dbo].[rabat] ([rb]) VALUES (N'98')
INSERT [dbo].[rabat] ([rb]) VALUES (N'99')
GO
INSERT [dbo].[rabat] ([rb]) VALUES (N'100')
GO
INSERT [dbo].[radne_pozicije] ([id], [radna_pozicija]) VALUES (1, N'Administrator       ')
INSERT [dbo].[radne_pozicije] ([id], [radna_pozicija]) VALUES (2, N'Vlasnik             ')
INSERT [dbo].[radne_pozicije] ([id], [radna_pozicija]) VALUES (3, N'Sef Skladista       ')
INSERT [dbo].[radne_pozicije] ([id], [radna_pozicija]) VALUES (4, N'Menadzer Skladista  ')
INSERT [dbo].[radne_pozicije] ([id], [radna_pozicija]) VALUES (5, N'Direktor Marketinga ')
INSERT [dbo].[radne_pozicije] ([id], [radna_pozicija]) VALUES (6, N'Radnik              ')
INSERT [dbo].[radne_pozicije] ([id], [radna_pozicija]) VALUES (7, N'Vozac               ')
GO
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (1, 1, N'Popravka Laptopa (Laptop pao u bazen)', N'Jovanko Jeremic', CAST(N'2021-06-27' AS Date), 1, CAST(N'2021-08-20' AS Date), N'aleksa.marceta2@apeiron-edu.eu', N'+387662586985', N'Kvar nije otklonjen.')
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (2, 2, N'Zamjena napajanja.', N'Jelenko Jelenko', CAST(N'2021-08-27' AS Date), 1, CAST(N'2021-08-27' AS Date), N'jelenko.jelenko@gmail.com', N'+387662586985', N'Napajanje zamjenjeno.')
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (3, 4, N'Popravka laptopa (musterija ne zna sta je problem)', N'Slavojko Slavic', CAST(N'2021-07-05' AS Date), 1, CAST(N'2021-08-23' AS Date), N'slavojko.slavic@gmail.com', N'+387662586985', N'Procesor pregorio. Potrebno ubaciti novi.')
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (4, 8, N'Zamjena termalne paste.', N'Zdenko Cvrkut', CAST(N'2021-08-27' AS Date), 1, CAST(N'2021-08-27' AS Date), N'zdenko.cvrkut@gmail.com', N'+387659862591', N'Uspjesno.')
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (5, 4, N'Zamjena HDD-a za SSD.', N'Jelenko Svirlic', CAST(N'2021-08-28' AS Date), 1, CAST(N'2021-08-28' AS Date), N'jelenko.svirlic@gmail.com', N'+38766985698', N'HDD zamjenjen sa SSD.')
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (6, 5, N'Popravka laptopa (djeca razbila u igri)', N'Snjegovan Ljupcic', CAST(N'2021-08-22' AS Date), 0, NULL, N'snjegovan.ljupcic@gmail.com', N'+38762593658', NULL)
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (7, 7, N'Ciscenje racunara od virusa', N'Jevrosim Dugovic', CAST(N'2021-07-30' AS Date), 0, NULL, N'jevrosim.dugovic@gmail.com', N'+38765456852', NULL)
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (8, 1, N'Instaliranje anti-virusa', N'Jadranka Stojic', CAST(N'2021-08-15' AS Date), 0, NULL, N'jadranka.stojic@gmail.com', N'+38766963548', NULL)
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (9, 2, N'Instaliranje OS-a (Windows 10 Home Edition)', N'Milenko Simic', CAST(N'2021-08-22' AS Date), 0, NULL, N'milenko.simic@gmail.com', N'+38765214589', NULL)
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (10, 1, N'Instaliranje OS-a (Linux Ubuntu 20.04)', N'Svetozar Jahmut', CAST(N'2021-08-22' AS Date), 0, NULL, N'svetozar.jahmut@gmail.com', N'+38765412547', NULL)
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (11, 1, N'Instaliranje OS-a (Win XP Professional)', N'Drago Dragutinovic', CAST(N'2021-08-22' AS Date), 0, NULL, N'dragutin.dragutinovic@gmail.com', N'+38766965269', NULL)
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (12, 2, N'Zamjena procesora (musterija je donjela zamjenski procesor)', N'Mirko Leskovic', CAST(N'2021-08-23' AS Date), 0, NULL, N'mirko.leskovic@gmail.com', N'+38765965325', NULL)
INSERT [dbo].[servis] ([id_servisa], [serviser], [usluga], [otprema_na_naslov], [prijem], [stanje_servisa], [isporuka], [email], [telefon], [opis_servisa]) VALUES (13, 2, N'Zamjena napajanja.', N'Janko Cistica', CAST(N'2021-08-28' AS Date), 1, CAST(N'2021-08-28' AS Date), N'janko.cistica@gmail.com', N'+38766968526', N'Napajanje zamjenjeno.')
GO
INSERT [dbo].[tipovi_naloga] ([id], [naziv]) VALUES (1, N'Administrator       ')
INSERT [dbo].[tipovi_naloga] ([id], [naziv]) VALUES (2, N'Zaposleni           ')
INSERT [dbo].[tipovi_naloga] ([id], [naziv]) VALUES (3, N'Sefovi              ')
GO
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 1, 1, 12, 30.0000, 0, 0, 1)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 3, 1, 3, 55.0000, 0, 0, 2)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 6, 1, 12, 120.0000, 0, 0, 3)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 7, 1, 3, 80.0000, 75, 1, 4)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 11, 1, 17, 500.0000, 15, 1, 5)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 9, 0, 1, 15.0000, 0, 1, 7)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (2, 7, 1, 3, 550.0000, 0, 1, 7)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (3, 17, 1, 5, 300.0000, 0, 1, 7)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 9, 0, 1, 15.0000, 0, 1, 8)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (2, 18, 1, 1, 160.0000, 0, 1, 8)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 9, 0, 1, 15.0000, 0, 1, 12)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 6, 1, 5, 120.0000, 0, 1, 15)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 11, 1, 1, 500.0000, 0, 1, 16)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 18, 1, 1, 470.0000, 0, 1, 17)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (2, 19, 1, 1, 550.0000, 10, 1, 17)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 5, 1, 5, 400.0000, 0, 1, 6)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (2, 9, 0, 1, 15.0000, 0, 1, 6)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (3, 8, 1, 10, 20.0000, 0, 1, 6)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 6, 1, 4, 470.0000, 10, 1, 9)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (2, 8, 1, 10, 20.0000, 0, 1, 9)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 19, 1, 1, 550.0000, 20, 0, 14)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (2, 11, 1, 1, 500.0000, 20, 0, 14)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (3, 5, 1, 4, 80.0000, 20, 0, 14)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 11, 1, 9, 55.0000, 0, 1, 10)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (2, 16, 1, 10, 300.0000, 0, 1, 10)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (3, 8, 1, 1, 20.0000, 0, 1, 10)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (4, 15, 1, 10, 80.0000, 0, 1, 10)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 9, 0, 1, 15.0000, 0, 1, 11)
INSERT [dbo].[Usluge] ([redni_broj], [naziv_robe], [jed_mjere], [kolicina], [cijena], [rabat], [pdv], [otpremnica_br]) VALUES (1, 20, 0, 1, 15.0000, 0, 1, 13)
GO
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (1, N'aleksa', N'€2290E425D6ABDBA9765581D5844D21364F2CD40D79D7FB60721C74321881890EB438A178F73172E2EEC53F9FE6B4211BDFC14FB1B5041A1A6673B622123E2BA7', 1, N'Aleksa', N'Marceta', 1, N'Osvajackih brigada 11', N'+38766311227 ', N'M69-A-420', N'aleksa.marceta2@apeiron-edu.eu', N'Jugoslavija')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (2, N'aleksandar', N'€FAE7748CB4825E92EA80BBAFEA2F366E82B0C102D0882362D966D63BE81C22705ECB1EEA3E53D9612E70CAE4F8396907B2279FD6341AA8C40F0DE7318F2C9643', 1, N'Aleksandar', N'Panzalovic', 1, N'Odbrambenih brigada 69', N'+38766311228 ', N'M69-A-420', N'aco.panzalovic@gmail.com', N'Srbija')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (3, N'dragomir', N'€D1DD11AA65C85956A0B15CA23FCA846D6F552056EB4FB34A08E11EF3044A14E6987549BD7468B9AE80C68E76666A498443D92617B159E04A94F12E2BE1C6BBFD', 3, N'Dragomir', N'Jevric', 3, N'Nikolije Jakovljevica 99i', N'+38766311229 ', N'S66-T-429', N'dragomir.jevric@gmail.com', N'Dragica')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (4, N'radenko', N'€0F819823AABD59B518985169FEFF2CFE0B5FA872EE6295AECDFE516ACFC2DA527920C96348135686E6113EA3F31CAFA1B97974D69DEECA116AC6D737531D5A1B', 3, N'Radenko', N'Gligovic', 4, N'Slavuljice Janka 52', N'+38766311230 ', N'S66-T-429', N'radenko.gligovic@gmail.com', N'R4jk0')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (5, N'mirko', N'€3622688DB3137A53992F1CE4B325D1CFEAE95DDDCFA4612E63012D89F78ABBEFFF90C91F15D89DC3584AE1A5A94A2D98E9B99E55E028C3A409F983C738972ECB', 2, N'Mirko', N'Mianovic', 6, N'Jevgenija Ohridejskog 49', N'+38766311231 ', N'V13-R-182', N'mirko.mirko@gmail.com', N'Jevgenje')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (6, N'rajka', N'€86D394F7F59C6352CEF3C439F078A03F2936B5BF3FA80422E0E7410EB7AA6B416E5C9528C188C9B0451BCCAD3820B1CB1B1E0ACE55B96DA483FF8F8BB93710D0', 3, N'Rajka', N'Jevric', 5, N'Nikolije Jakovljevica 99i', N'+38766311232 ', N'S66-T-429', N'rajka.jevric@gmail.com', N'Slanina ')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (7, N'slavojko', N'€910EB33940DF5459602E927002600D97DE2D707448E016E933EB835A77DA279E22E92F6F61E5A36F7000B3BA55C08AD84040D17F374A9165672E84910C4D7030', 3, N'Slavojko', N'Cvrkut', 2, N'Sofronija Crnog 420', N'+38766311233 ', N'S66-T-429', N'slavojko.cvrkut@gmail.com', N'Glad')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (8, N'zagorka', N'€69E9F0C9AEFDCA4DD526C04A0D7E27D268A6F0EFD242FA3626261A42E0407AA22F0A84883F4D43C8A81976CCFB2D638A04F922D2EE5CC621E20B5D2A76338F06', 2, N'Zagorka', N'Kantar', 6, N'Sirote Jagnjati', N'+38766311234 ', N'V13-R-183', N'zagorko.kantar@gmail.com', N'Snicla  ')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (9, N'dobrasin', N'€07C65DDC5297C28CDE4C79704FF3E93A00BA11C7186A8FF4721DDD484FDE7F39C8C4AE9F9A2A94302CCAD9A6C99453BE065D03CADBFF284FA591BFD3150A17CA', 2, N'Dobrasin', N'Pandrc', 2, N'Pataftovih Drugova 1', N'+38766311235 ', N'V13-R-184', N'dobrasin.pandrc@gmail.com', N'Kupus   ')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (10, N'bisenija', N'€80896E9C828DD5A09BEA9D8CCB0BAC6B6E1ED3CAF559B35D1F0AAA89736A5A8DD416B0F6F55F0A446FA47AF460E1E5726EC3342EC357DA23EF0B5DA74DA27D9C', 2, N'Bisenija', N'Hrkman', 2, N'Heleta Tabasa 6', N'+38766311236 ', N'V13-R-185', N'bisenija.hrkman@gmail.com', N'Krompir')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (11, N'persida', N'€13CC906EC845CCF3D32A34EA1BCB076BC8A6AE63C4791043073AABDE2DF945193C0DE6D99216EE171FE69C567D7835B789518BE64C20F54F1EC2F7FA822B8410', 2, N'Persida', N'Matavulj', 2, N'Ispod Mosta Kuljani 15', N'+38766311237 ', N'V13-R-186', N'persida.matavulj@gmail.com', N'Musaka')
INSERT [dbo].[zaposleni] ([id], [korisnicko_ime], [lozinka], [tip_naloga], [ime], [prezime], [pozicija], [adresa], [telefon], [sluz_voz], [email], [salt]) VALUES (12, N'uzahije', N'€9727770DA8EB81DE08A0843A56728E72BD61F13F5C4F6C21FC915D4E1AFCA298C9674ADB365F0DF0AD6241A7B0D6131A9B9A5D0FFFD06C2B330339221F519635', 2, N'Uzahije', N'Promaja', 2, N'Vjetrovitih Puteva 8', N'+38766311238 ', N'V13-R-187', N'uzahije.promaja@gmail.com', N'Lazanje')
GO
ALTER TABLE [dbo].[Osnovne]  WITH CHECK ADD  CONSTRAINT [FK_Osnovne_Osnovne] FOREIGN KEY([naziv_pravnog_lica])
REFERENCES [dbo].[zaposleni] ([id])
GO
ALTER TABLE [dbo].[Osnovne] CHECK CONSTRAINT [FK_Osnovne_Osnovne]
GO
ALTER TABLE [dbo].[servis]  WITH CHECK ADD  CONSTRAINT [FK_servis_zaposleni] FOREIGN KEY([serviser])
REFERENCES [dbo].[zaposleni] ([id])
GO
ALTER TABLE [dbo].[servis] CHECK CONSTRAINT [FK_servis_zaposleni]
GO
ALTER TABLE [dbo].[zaposleni]  WITH CHECK ADD  CONSTRAINT [FK_zaposleni_radne_pozicije] FOREIGN KEY([pozicija])
REFERENCES [dbo].[radne_pozicije] ([id])
GO
ALTER TABLE [dbo].[zaposleni] CHECK CONSTRAINT [FK_zaposleni_radne_pozicije]
GO
ALTER TABLE [dbo].[zaposleni]  WITH CHECK ADD  CONSTRAINT [FK_zaposleni_tipovi_naloga] FOREIGN KEY([tip_naloga])
REFERENCES [dbo].[tipovi_naloga] ([id])
GO
ALTER TABLE [dbo].[zaposleni] CHECK CONSTRAINT [FK_zaposleni_tipovi_naloga]
GO
USE [master]
GO
ALTER DATABASE [Panleksa] SET  READ_WRITE 
GO
