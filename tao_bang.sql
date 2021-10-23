
Create Database test
	Go
	Use kien
	Go
	

Create Table THAMGIADT
	(
		MAGV nchar(3),
		MADT nchar(4),
		STT int,
		PHUCAP float,
		KETQUA nvarchar(10),
		Primary Key (MAGV,MADT,STT)
	)
	go
	
	Create Table KHOA
	(
		MAKHOA nchar (4),
		TENKHOA nvarchar (50),
		NAMTL int,
		PHONG char(3),
		DIENTHOAI char(10),
		TRUONGKHOA nchar(3),
		NGAYNHANCHUC datetime,
		primary key (MAKHOA)
	)
	go
	
	create table BOMON
	(
		MABM nchar(4),
		TENBM nchar (50),
		PHONG char(3),
		DIENTHOAI char(11),
		TRUONGBM nchar(3),
		MAKHOA nchar (4),
		NGAYNHANCHUC date,
		primary key (MABM)
	)
	go
	
	create table CONGVIEC 
	(
		MADT nchar(4),
		SOTT int,
		TENCV nvarchar(50),
		NGAYBD datetime,
		NGAYKT datetime,
		primary key (MADT,SOTT)
	)
	go
	
	create table DETAI
	(
		MADT nchar(4),
		TENDT nvarchar(50),
		CAPQL nchar(20),
		KINHPHI float,
		NGAYBD date,
		NGAYKT date,
		MACD nchar(4),
		GVCNDT nchar(3),
		primary key (MADT)
	)
	go
	create table CHUDE
	(
		MACD nchar(4),
		TENCD nvarchar(30),
		primary key (MACD)
	)
	go
	
	create table GIAOVIEN
	(
		MAGV nchar(3),
		HOTEN nvarchar(50),
		LUONG float,
		PHAI nchar(3),
		NGSINH date,
		DIACHI nchar(50),
		GVQLCM nchar(3),
		MABM nchar(4),
		primary key (MAGV)
	)
	go
	
	create table NGUOITHAN
	(
		MAGV nchar(3),
		TEN nchar(12),
		NGSINH datetime,
		PHAI nchar(3),
		primary key (MAGV,TEN)
	)
	go
	
	create table GV_DT
	(
		MAGV nchar(3),
		DIENTHOAI char (10),
		primary key (MAGV,DIENTHOAI)
	)
	go
	

	Alter table THAMGIADT
		add constraint FK1_MADT
		foreign key (MADT, STT)
		references CONGVIEC(MADT,SOTT)
		go
		

	Alter table CONGVIEC
		add constraint FK2_MADT
		foreign key (MADT)
		references DETAI(MADT)
		go
		

	Alter table DETAI
		add constraint FK3_MACD
		foreign key (MACD)
		references CHUDE(MACD)
		go
		

	Alter table DETAI
		add constraint FK4_GVCNDT
		foreign key (GVCNDT)
		references GIAOVIEN(MAGV)
		go
		

	Alter table THAMGIADT
		add constraint FK5_MAGV
		foreign key (MAGV)
		references GIAOVIEN(MAGV)
		go
		

	Alter table GIAOVIEN
		add constraint FK6_GVQLCM
		foreign key (GVQLCM)
		references GIAOVIEN(MAGV)
		go
			

	Alter table KHOA
		add constraint FK7_TRUONGKHOA
		foreign key (TRUONGKHOA)
		references GIAOVIEN(MAGV)
		go
		

	Alter table NGUOITHAN
		add constraint FK8_MAGV
		foreign key (MAGV)
		references GIAOVIEN(MAGV)
		go
		

	Alter table GIAOVIEN
		add constraint FK9_MABM
		foreign key (MABM)
		references BOMON(MABM)
		go
		

	Alter table BOMON
		add constraint FK10_MAKHOA
		foreign key (MAKHOA)
		references KHOA(MAKHOA)
		go
		
	Alter table BOMON
		add constraint FK11_TRUONGBM
		foreign key (TRUONGBM)
		references GIAOVIEN(MAGV)
		go
		

	Alter table GV_DT
		add constraint FK12_MAGV
		foreign key (MAGV)
		references GIAOVIEN(MAGV)
		go
