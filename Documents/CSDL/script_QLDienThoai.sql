set nocount on

if exists (select * from SysObjects where name='spGetTableList' and type='P') 
	drop proc spGetTableList
go
create proc spGetTableList
	@arrTables cursor varying output 
as begin 
	set @arrTables = cursor for
		select table_name
		from Information_Schema. TABLES
		where table_type='BASE TABLE'
		--and table_name <> 'dtproperties'
	open @arrTables
end
go

if exists (select * from SysObjects where name='spGetFKList' and type='P') 
	drop proc spGetFKList
go
create proc spGetFKList
	@arrFKs cursor varying output 
as begin 
	set @arrFKs = cursor for
		select constraint_name, table_name
		from Information_Schema. TABLE_CONSTRAINTS
		where constraint_type='FOREIGN KEY'
	open @arrFKs
end
go
-----------------------------------------------------------------------------------------------
-- đoạn này dùng để lấy tên table và fk để mình drop constraint của nó
if exists (select * from SysObjects where name='spClearFKs' and type='P') 
	drop proc spClearFKs
go
create proc spClearFKs
	@dbName varchar(66)
as begin
	--save db hiện hành
	declare @curDB varchar(66)
	set @curDB=db_name() 
		
	if (@dbName is null) or (@dbName='') begin
		set @dbName=db_name()
	end
	if @dbName in ('master') begin
		raisError ('Không thể xóa object(s) hệ thống!',16,1)
		return -1
	end
	
	--db_name() này ở đâu ra vậy , có phải là hàm có sẵn ko ? 
	----La` ha`m co' san~
	--chuyen de'n db muo'n xoa'
	declare @sc nvarchar(333)
	
	set @sc='use '+@dbName
	exec sp_executeSQL @sc

	--lấy ds các FK & bảng chứa chúng
	declare @c cursor 
	exec spGetFKList @c output
	--thực hiện xóa FK
	declare @tableName varchar(66), @fkName varchar(66)
	fetch next from @c into @fkName, @tableName
	while @@fetch_status=0 begin
		set @sc='alter table '+@tableName+' drop constraint '+ @fkName
		exec sp_executeSQL @sc

		fetch next from @c into @fkName, @tableName
	end
	close @c
	deallocate @c
	--
	set @sc='use '+@curDB
	exec sp_executeSQL @sc
end
go
-----------------------------------------------------------------------------------------------
--Đoạn này để drop table
if exists (select * from SysObjects where name='spClearTables' and type='P')
	drop proc spClearTables
go
create proc spClearTables
	@dbName varchar(66)
as begin
	declare @curDB varchar(66)
	set @curDB=db_name()
	--
	declare @sc nvarchar(333)

	if (@dbName is null) or (@dbName='') begin
		set @dbName=db_name()
	end
	if @dbName in ('master') begin
		raisError ('Không thể xóa object(s) hệ thống!',16,1)
		return -1
	end
		
	set @sc='use '+@dbName
	exec sp_executeSQL @sc
	--		
	declare @c cursor 
	exec spGetTableList @c output

	declare @tableName varchar(66)
	fetch next from @c into @tableName
	while @@fetch_status=0 begin
		set @sc='drop table '+@tableName
		exec sp_executeSQL @sc
		
		fetch next from @c into @tableName
	end
	close @c
	deallocate @c
	--
	set @sc = 'use '+@curDB
	exec sp_executeSQL @sc
	--
	return 0
end
go
-----------------------------------------------------------------------------------------------
--doạn này drop db
if exists (select * from SysObjects where name='spClearDB' and type='P')   --type ='P' or 'U' là gì vậy
	drop proc spClearDB
go
create proc spClearDB
	@dbName varchar(66)
as begin
	declare @curDB varchar(66)
	set @curDB=db_name()
	--	
	if (@dbName is null) or (@dbName='') begin
		set @dbName=db_name()
	end

	if @dbName in ('master') begin
		raisError ('Không thể xóa object(s) hệ thống!',16,1)
		return -1
	end
	--
	exec spClearFKs @dbName
	exec spClearTables @dbName
	--
	declare @sc nvarchar(333)
	set @sc = 'use '+@curDB
	exec sp_executeSQL @sc
	--
	return 0
end
go
exec spClearDB ''
------------------------------------------------------------------------------------------------------------

CREATE TABLE CUOC_TRONG_NUOC (
	MA_TD char (4) NOT NULL ,
	TINH_THANH nvarchar (30) NOT NULL ,
	GIA_PHUT_DAU real NOT NULL ,
	GIA_PHUT_SAU real NOT NULL 
) 
GO

CREATE TABLE CG_QUOC_TE (
	SO_DT char (7) NOT NULL ,
	NGAY_GIO datetime NOT NULL ,
	MA_NUOC char (4) NOT NULL ,
	SO_MAY_NGHE char (9) NOT NULL ,
	SO_PHUT int NOT NULL ,
	THANH_TIEN real NULL 
)
GO

CREATE TABLE CG_TRONG_NUOC (
	SO_DT char (7) NOT NULL ,
	NGAY_GIO datetime NOT NULL ,
	MA_TD char (4) NOT NULL ,
	SO_MAY_NGHE char (7) NOT NULL ,
	SO_PHUT int NOT NULL ,
	THANH_TIEN real NULL 
) 
GO

CREATE TABLE CUOC_QUOC_TE (
	MA_NUOC char (4) NOT NULL ,
	TEN_NUOC nvarchar (50) NOT NULL ,
	GIA_PHUT_DAU real NOT NULL ,
	GIA_PHUT_SAU real NOT NULL 
) 
GO

CREATE TABLE KHACH_HANG (
	MA_KH char (9) NOT NULL ,
	HOTEN nvarchar (50) NOT NULL ,
	CMND char (9) NOT NULL ,
	DIACHI varchar (10)  NOT NULL ,
	DUONG nvarchar (50)  NOT NULL ,
	QUAN nvarchar (50)  NOT NULL,
	NGAYSINH	DATETIME
) 
GO

CREATE TABLE THUE_BAO (
	SO_DT char (7)  NOT NULL ,
	MA_KH char (9)  NOT NULL ,
	NGAY_BD datetime NOT NULL,
	DINH_MUC_TN real NOT NULL,
	DINH_MUC_QT real NOT NULL
) 
GO

ALTER TABLE CUOC_TRONG_NUOC WITH NOCHECK ADD 
	CONSTRAINT PK_CUOC_TRONG_NUOC PRIMARY KEY  CLUSTERED 
	(
		MA_TD
	)
GO

ALTER TABLE CG_QUOC_TE WITH NOCHECK ADD 
	CONSTRAINT PK_CG_QUOC_TE PRIMARY KEY  CLUSTERED 
	(
		SO_DT,
		NGAY_GIO
	)
GO

ALTER TABLE CG_TRONG_NUOC WITH NOCHECK ADD 
	CONSTRAINT PK_CG_TRONG_NUOC PRIMARY KEY  CLUSTERED 
	(
		SO_DT,
		NGAY_GIO
	)  
GO

ALTER TABLE CUOC_QUOC_TE WITH NOCHECK ADD 
	CONSTRAINT PK_CUOC_QUOC_TE PRIMARY KEY  CLUSTERED 
	(
		MA_NUOC
	)  
GO

ALTER TABLE KHACH_HANG WITH NOCHECK ADD 
	CONSTRAINT PK_KHACH_HANG PRIMARY KEY  CLUSTERED 
	(
		MA_KH
	)  
GO

ALTER TABLE THUE_BAO WITH NOCHECK ADD 
	CONSTRAINT PK_THUE_BAO PRIMARY KEY  CLUSTERED 
	(
		SO_DT
	) 
GO


ALTER TABLE CG_QUOC_TE ADD 
	CONSTRAINT FK_CG_QUOC_TE_CUOC_QUOC_TE FOREIGN KEY 
	(
		MA_NUOC
	) REFERENCES CUOC_QUOC_TE (
		MA_NUOC
	),
	CONSTRAINT FK_CG_QUOC_TE_THUE_BAO FOREIGN KEY 
	(
		SO_DT
	) REFERENCES THUE_BAO (
		SO_DT
	)
GO

ALTER TABLE CG_TRONG_NUOC ADD 
	CONSTRAINT FK_CG_TRONG_NUOC_CUOC_TRONG_NUOC FOREIGN KEY 
	(
		MA_TD
	) REFERENCES CUOC_TRONG_NUOC (
		MA_TD
	),
	CONSTRAINT FK_CG_TRONG_NUOC_THUE_BAO FOREIGN KEY 
	(
		SO_DT
	) REFERENCES THUE_BAO (
		SO_DT
	)
GO
ALTER TABLE THUE_BAO ADD 
	CONSTRAINT FK_THUE_BAO_KHACH_HANG FOREIGN KEY 
	(
		MA_KH
	) REFERENCES KHACH_HANG (
		MA_KH
	)
go

SET DATEFORMAT DMY
INSERT INTO KHACH_HANG VALUES('123456789', N'Nguyễn Tường Vân', '250570414', '330/2', N'Lê Hồng Phong', N'Quận 5','20/12/2000')
INSERT INTO KHACH_HANG VALUES('112233445', N'Trần Thanh Tùng', '240460171', '111', N'Trương Định', N'Quận 3','1/2/1982')
INSERT INTO KHACH_HANG VALUES('222333444', N'Nguyễn Ngọc Nga', '230580456', '315', N'An Dương Vương', N'Quận 5','09/12/1992')

INSERT INTO THUE_BAO VALUES('8156789', '222333444', '1/3/1990', 100000, 50)
INSERT INTO THUE_BAO VALUES('8223304', '112233445', '15/1/2001', 200000, 100)
INSERT INTO THUE_BAO VALUES('8175566', '123456789', '30/10/1995', 300000, 0)

INSERT INTO CUOC_TRONG_NUOC VALUES('8', N'Hồ Chí Minh',100, 60)
INSERT INTO CUOC_TRONG_NUOC VALUES('61', N'Đồng Nai',900,750)
INSERT INTO CUOC_TRONG_NUOC VALUES('63', N'Lâm Đồng',1200, 1000)
INSERT INTO CUOC_TRONG_NUOC VALUES('58', N'Thừa Thiên Huế',2000, 1500)
INSERT INTO CUOC_TRONG_NUOC VALUES('4', N'Hà Nội',2500, 2000)

INSERT INTO CUOC_QUOC_TE VALUES('1', N'Canada',2, 1.5)
INSERT INTO CUOC_QUOC_TE VALUES('2', N'Mỹ',2,1.5)
INSERT INTO CUOC_QUOC_TE VALUES('33', N'Pháp',1.5,1.25)
INSERT INTO CUOC_QUOC_TE VALUES('61', N'Úc',1.25, 1)
INSERT INTO CUOC_QUOC_TE VALUES('81', N'Nhật',1, 0.75)


INSERT INTO CG_TRONG_NUOC VALUES('8175566','1/1/2006    15:10:6','8','8223304',10,640)
INSERT INTO CG_TRONG_NUOC VALUES('8223304','2/1/2006    6:23:25','8','8156789',15,940)
INSERT INTO CG_TRONG_NUOC VALUES('8175566','3/1/2006 8:16:00','8','8223304',20,1240)
INSERT INTO CG_TRONG_NUOC VALUES('8223304','5/1/2006 23:1:17','4','8112424',4,8500)
INSERT INTO CG_TRONG_NUOC VALUES('8223304','6/1/2006 17:2:15','58','8123456',7,11000)
INSERT INTO CG_TRONG_NUOC VALUES('8156789','7/1/2006 5:10:7','63','829454',8,8200)


INSERT INTO CG_QUOC_TE VALUES('8156789','1/1/2006 14:10:6','2', '112233445', 11,17)
INSERT INTO CG_QUOC_TE VALUES('8223304','2/1/2006 9:23:25','81','223344556',4,3.25)
INSERT INTO CG_QUOC_TE VALUES('8156789','15/1/2006 12:16:00','61','334455667',5,5.25)
INSERT INTO CG_QUOC_TE VALUES('8223304','25/1/2006 14:1:17','2','445566778',2,2.5)
