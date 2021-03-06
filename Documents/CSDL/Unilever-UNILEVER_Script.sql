--A. PHAN TAO CAC BANG
-- 1. Tao bang NHOMHANG
Create table NHOM_HANG
(
	MANHOM  nvarchar(5) not null,
	TENNHOM nvarchar(20)null,   
	Constraint PK_NHOMHANG primary key (MANHOM)
)

-- 2. Tao bang HANGHOA
Create table HANG_HOA
(
	MAHH nvarchar(5) not null,
	MAHTDG nvarchar(5) not null,
	MANHOM nvarchar(5) not null,
	TENHH nvarchar(50) null,
	DVT nvarchar(5) null,
	DONGIA float null,
	SLTON float null,
	Constraint PK_HANGHOA primary key (MAHH)	
)	
-- 3. Tao bang HINH_THUC_DONG_GOI 
Create table HINH_THUC_DONG_GOI
(
	MAHTDG nvarchar(5) not null,
	THUNG int null,
	LOC int null,
	Constraint PK_HTDG primary key(MAHTDG)
)
-- 4. Tao bang DOI
Create table DOI
(
	MADOI nvarchar(3)not null,
	MANHOM nvarchar(5)null,
	Constraint PK_DOI primary key (MADOI),	 	
)

-- 5. Tao bang NHAN_VIEN
Create table NHAN_VIEN
(
	MANV  nvarchar(5) not null,
	MALNV nvarchar(2) not null,
	MADOI nvarchar(3) not null,
	HOTEN nvarchar(50) null,
	GIOITINH nvarchar(3) null, 
	NAMSINH  datetime null,
	DIACHI nvarchar(50) null,
	DIENTHOAI nvarchar(10) null,
	NGAYVAOLAM  datetime null,
	GHICHU nvarchar(100) null,
	Constraint PK_NHANVIEN primary key (MANV)	
	
)
alter table NHAN_VIEN add constraint C_GIOITINH check(GIOITINH = N'Nam' OR GIOITINH = N'Nữ' )

-- 6. Tao bang LOAI_NV
Create table LOAI_NV
(
	MALNV nvarchar(2) not null,
	TENLOAI nvarchar(20) null,
	Constraint PK_LOAINV primary key (MALNV)
)

-- 7. Tao bang DAILY
Create table DAI_LY
(
	MADL nvarchar(5) not null,
	TENDL nvarchar(50) null,
	MASOTHUE nvarchar(14) null,
	DIACHI nvarchar(50) null,
	DIENTHOAI nvarchar(10) null,
	Constraint PK_DAILY primary key (MADL)
)

-- 8. Tao bang PHIEU_XUAT
Create table PHIEU_XUAT
(
	MAPX  nvarchar(11) not null,
	MANV  nvarchar(5) not null,
	NGAYXUAT datetime null,
	Constraint PK_PHIEU_XUAT primary key (MAPX)
	
)	

-- 9. Tao bang CTPX
Create table CTPX
(
	MAPX nvarchar(11)not null,
	MAHH nvarchar(5) not null,
	SOLUONG float null,
	Constraint PK_CTPX primary key (MAPX,MAHH)
)

-- 10.Tao bang HOADON
Create table HOA_DON
( 
	MAHD nvarchar(11) not null,
	MANV nvarchar(5) not null,
	MADL nvarchar(5) not null,
	NGAYLAP datetime null,
	TONGTIEN float null,
	Constraint PK_HOADON primary key (MAHD)
) 

-- 11.Tao bang CTHD
Create table CTHD
( 
	MAHD 	nvarchar(11) not null,
	MAHH   nvarchar(5) not null,
	SLBAN    float null,
	CKBAN    float null,
	THANHTIEN float null,
	Constraint PK_CTHD primary key (MAHD, MAHH),
)   

alter table CTHD add 
	Constraint FK_CTHD_HOADON foreign key (MAHD) references HOA_DON(MAHD),
	Constraint FK_CTHD_HANGHOA foreign key (MAHH) references HANG_HOA(MAHH)

alter table HOA_DON add 
	Constraint FK_HOADON_NHANVIEN foreign key (MANV) references NHAN_VIEN(MANV),
	Constraint FK_HOADON_DAILY foreign key (MADL) references DAI_LY(MADL)

alter table HANG_HOA add 
	Constraint FK_HANGHOA_HTDG foreign key(MAHTDG) references HINH_THUC_DONG_GOI(MAHTDG),
	Constraint FK_HANGHOA_NHOMHANG foreign key(MANHOM) references NHOM_HANG(MANHOM)

alter table DOI add
	Constraint FK_DOI_NHOMHANG foreign key (MANHOM) references NHOM_HANG(MANHOM)

alter table NHAN_VIEN add
	Constraint FK_NHANVIEN_LOAINV foreign key (MALNV) references LOAI_NV(MALNV),
	Constraint FK_NHANVIEN_DOI foreign key (MADOI) references DOI(MADOI)

alter table PHIEU_XUAT add
	Constraint FK_PHIEUXUAT_NHANVIEN foreign key (MANV) references NHAN_VIEN(MANV)

alter table CTPX add 
	Constraint FK_CTPX_PHIEUXUAT foreign key (MAPX) references PHIEU_XUAT(MAPX) ,
	Constraint FK_CTPX_HANGHOA foreign key (MAHH) references HANG_HOA(MAHH)


--B. PHAN NHAP DU LIEU
--1. Nhap lieu cho bang NHOMHANG
Insert into NHOM_HANG values ('BOT',N'Bột')
Insert into NHOM_HANG values ('CSSD',N'Chăm sóc sắc đẹp')
Insert into NHOM_HANG values ('CSTT',N'Chăm sóc thân thể')
Insert into NHOM_HANG values ('TP',N'Thực phẩm')
--2. Nhap lieu cho bang HTDG
Insert into HINH_THUC_DONG_GOI values ('00600',6,NULL)
Insert into HINH_THUC_DONG_GOI values ('01200',12,NULL)
Insert into HINH_THUC_DONG_GOI values ('01500',15,NULL)
Insert into HINH_THUC_DONG_GOI values ('02400',24,NULL)
Insert into HINH_THUC_DONG_GOI values ('03000',30,NULL)
Insert into HINH_THUC_DONG_GOI values ('03600',36,NULL)
Insert into HINH_THUC_DONG_GOI values ('03603',36,3)
Insert into HINH_THUC_DONG_GOI values ('03606',36,6)
Insert into HINH_THUC_DONG_GOI values ('03612',36,12)
Insert into HINH_THUC_DONG_GOI values ('04800',48,NULL)
Insert into HINH_THUC_DONG_GOI values ('06000',60,NULL)
Insert into HINH_THUC_DONG_GOI values ('06006',60,6)
Insert into HINH_THUC_DONG_GOI values ('07200',72,NULL)
Insert into HINH_THUC_DONG_GOI values ('07204',72,4)
Insert into HINH_THUC_DONG_GOI values ('07206',72,6)
Insert into HINH_THUC_DONG_GOI values ('07212',72,12)
Insert into HINH_THUC_DONG_GOI values ('10000',100,NULL)
Insert into HINH_THUC_DONG_GOI values ('10010',100,10)
Insert into HINH_THUC_DONG_GOI values ('12012',120,12)
Insert into HINH_THUC_DONG_GOI values ('14412',144,12)
Insert into HINH_THUC_DONG_GOI values ('72012',720,12)
--3. Nhap lieu cho bang DOI
Insert into DOI values ('01','BOT')
Insert into DOI values ('02','BOT')
Insert into DOI values ('03','CSTT')
Insert into DOI values ('04','CSTT')
Insert into DOI values ('05','CSTT')
Insert into DOI values ('06','CSSD')
Insert into DOI values ('07','CSSD')
Insert into DOI values ('08','CSSD')
Insert into DOI values ('09','TP')
Insert into DOI values ('10','TP')
--4. Nhap lieu cho bang LOAINV
Insert into LOAI_NV values ('GH',N'Giao hàng')
Insert into LOAI_NV values ('TD',N'Trưởng đội')
Insert into LOAI_NV values ('TT',N'Tiếp thị')
--5. Nhap lieu cho bang DAILY
Insert into DAI_LY values('DL001',N'Cửa hàng bách hóa tổng hợp IC','020220118412',N'202 Trần Hưng Đạo,P5,Q5, TPHCM','8990771')
Insert into DAI_LY values('DL002',N'Công ty bách hóa Long An','013444432943',N'99 Hoàng Hoa Thám, Long An','0658515044')
Insert into DAI_LY values('DL003',N'Cửa hàng tổng hợp DDC','085784344522',N'50 Phạm Ngọc Thạch, Long Xuyên','075611299')
Insert into DAI_LY values('DL004',N'Chi nhánh 2 công ty bách hóa FH','093328330377',N'11 Lý Tự Trọng, Vũng Tàu','0568900122')
Insert into DAI_LY values('DL005',N'Cửa hàng tổng hợp ABX','011445367745',N'2 Nguyễn Chí Thanh, Cần Thơ','071811111')
Insert into DAI_LY values('DL006',N'Công ty ASB','045567845454',N'1 Nguyễn Huệ, Đà Lạt','045990722')
Insert into DAI_LY values('DL007',N'Công ty bách hóa Đà Nắng','011546234533',N'98 Hòang Văn Thụ, Đà Nẵng','022877133')
Insert into DAI_LY values('DL008',N'Cửa hàng bách hóa BBF','011443354534',N'56 Đề Thám, Nha Trang','060871155')
Insert into DAI_LY values('DL009',N'Cửa hàng bách hóa GTT','085089664433',N'112 Lê Lợi, Hà Nội','0129890731')
Insert into DAI_LY values('DL010',N'Công ty ACD','058023458397',N'45 Quốc Lộ 1A, Bến Tre','062811077')
Insert into DAI_LY values('DL011',N'Cừa hàng thực phẩm ABC','034093362343',N'355 Nguyễn Chí Thanh, Q1, TPHCM','089890211')
Insert into DAI_LY values('DL012',N'Công ty thực phẩm An Đông','045231452213',N'178 Hà Tôn Quyền,Q5,TPHCM','088732342')

--6. Nhap lieu cho bang HANGHOA
Insert into HANG_HOA values ('BCCL1','10010','CSTT',N'Bàn chải Close-up năng động (72)',N'cây',7000,1200)
Insert into HANG_HOA values ('BCCL2','10010','CSTT',N'Bàn chải Close-up Fresh(720)',N'cây',4000,700)
Insert into HANG_HOA values ('BCCL3','10010','CSTT',N'Bàn chải Close-up Flesx',N'cây',6700,400)
Insert into HANG_HOA values ('BGO01','02400','BOT',N'Bột giặt Omo 30g',N'dây',4500,240)
Insert into HANG_HOA values ('BGO02','03600','BOT',N'Bột giặt Omo 200g', N'gói',2900,108)
Insert into HANG_HOA values ('BGOM1','01200','BOT',N'Bột giặt Omo Matic 1000g',N'hộp',17400,48)
Insert into HANG_HOA values ('BGOM2','00600','BOT',N'Bột giặt Omo Matic 4000g',N'hộp',69000,36)
Insert into HANG_HOA values ('BGVJ1','01200','BOT',N'Bột giặt Viso Javel 700ml',N'chai',3150,60)
Insert into HANG_HOA values ('BN001','06000','TP',N'Bột nêm', N'gói',1350,390)
Insert into HANG_HOA values ('CAL01','03000','TP',N'Cháo ăn liền', N'gói',720,450)
Insert into HANG_HOA values ('CLG01','14412','CSTT',N'Close-up Green 40g',N'cây',2000,1440)
Insert into HANG_HOA values ('CLM01','14412','CSTT',N'Close-up muoi 40g',N'cây',3500,1152)
Insert into HANG_HOA values ('CMLB2','03606','CSTT',N'Lifebouy chống muỗi 100ml',N'chai',15000,108)
Insert into HANG_HOA values ('DDCCP','06000','CSSD',N'Kem dướng da cao cấp Ponds 50g',N'chai',3500,420)
Insert into HANG_HOA values ('DGCB1','07200','CSTT',N'Dầu gội Clear bạc hà 7ml',N'dây',9600,144)
Insert into HANG_HOA values ('DGCB2','03612','CSTT',N'Dầu gội Clear bạc hà 100ml',N'chai',13500,108)
Insert into HANG_HOA values ('DGD01','03612','CSTT',N'Dầu gội Dove 100ml',N'chai',15000,360)
Insert into HANG_HOA values ('DGLB1','07200','CSTT',N'Dầu gội Lifebouy 6ml',N'dây',4800,216)
Insert into HANG_HOA values ('ITD01','07200','TP',N'Icetea day 10g',N'dây',8700,216)
Insert into HANG_HOA values ('KCNP1','06006','CSSD',N'Kem chống nắng Ponds 20g',N'chai',20000,360)
Insert into HANG_HOA values ('KDDH1','06006','CSSD',N'Kem dưỡng da Hazeline 20g',N'chai',12000,420)
Insert into HANG_HOA values ('TG01','10010','TP',N'Trà Lipton 10 gói',N'hộp',5300,400)
--7. Nhap lieu cho bang NHANVIEN

Insert into NHAN_VIEN values ('NV001','TD','01',N'Huỳnh Trí Lâm',N'Nam','12/12/1960',N'12 Minh Phụng Q11','9634165','05/03/1984', N'Tốt nghiệp Đại học Kinh Tế năm 1982, chứng chỉ C Anh Văn')
Insert into NHAN_VIEN values ('NV002','TT','01',N'Trần Văn Minh',N'Nam','01/21/1965',N'7 Lê Lai Q1','8202933','09/13/1980', N'Tốt nghiệp Đại học Kinh Tế năm 1987')
Insert into NHAN_VIEN values ('NV003','TD','02',N'Trần Hoàng Ngân',N'Nữ','01/07/1962',N'551/1A Lạc Long Quân Q1','9112135','12/26/1985', N'Tốt nghiệp Đại học Kinh Tế năm 1984')
Insert into NHAN_VIEN values ('NV004','GH','02',N'Lý Hoài An',N'Nam','02/24/1977',N'1024/1 Hùng Vương Q5','9425354','12/14/1999','Tot nghiep Pho Thong Trung Hoc')
Insert into NHAN_VIEN values ('NV005','TD','03',N'Lâm Trọng Tín',N'Nam','03/13/1965',N'2 Trần Bình Trọng, Q5','9987165','07/19/1987', N'Tốt nghiệp Đại học Kinh Tế năm 1987, chứng chỉ C Anh Văn')
Insert into NHAN_VIEN values ('NV006','TT','03',N'Nguyễn Văn Phương',N'Nam','09/04/1967',N'56 Nguyễn Huệ Q1','8233911','12/01/1995', N'Tốt nghiệp Đại học Kinh Tế năm 1989')
Insert into NHAN_VIEN values ('NV007','TD','04',N'Trần Minh Tâm',N'Nữ','02/03/1961',N'78 Hàn Hải Nguyên Q11','9345235','06/05/1984', N'Tốt nghiệp Đại học Kinh Tế năm 1983, chứng chỉ B Anh Văn')
Insert into NHAN_VIEN values ('NV008','TT','04',N'Trần Minh',N'Nam','12/17/1969',N'455/432 Ba Hat Q10','8435523','03/17/1922', N'Tốt nghiệp Đại học Kinh Tế năm 1991')
Insert into NHAN_VIEN values ('NV009','TD','05',N'Hoàng Ly Ly',N'Nữ','02/13/1968',N'178/3 Minh Phụng Q1','9129833','12/25/1991', N'Tốt nghiệp Đại học Kinh Tế năm 1983')
Insert into NHAN_VIEN values ('NV010','TT','05',N'Nguyễn Hoài Nam',N'Nam','12/07/1970',N'321 Ba Huyen Thanh Quan Q3','8523122','07/21/1993', N'Tốt nghiệp Đại học Kinh Tế năm 1992')
Insert into NHAN_VIEN values ('NV011','TD','06',N'Trần Văn Lâm',N'Nam','11/09/1962',N'122/3 Minh Phụng Q11','9165002','12/13/1986', N'Tốt nghiệp Đại học Kinh Tế năm 1985, chứng chỉ C Anh Văn')
Insert into NHAN_VIEN values ('NV012','TT','06',N'Nguyễn Văn Hải',N'Nam','11/04/1967',N'94/76 Trần Hưng Đạo Q1','8332454','04/11/1991', N'Tốt nghiệp Đại học Kinh Tế năm 1990')
Insert into NHAN_VIEN values ('NV013','TD','07',N'Nguyễn Hoàng Minh',N'Nam','01/17/1963',N'5511A/4 Bình Thới Q11','9135521','02/16/1987', N'Tốt nghiệp Đại học Kinh Tế năm 1985')
Insert into NHAN_VIEN values ('NV014','TT','07',N'Phùng Văn Tín',N'Nam','11/19/1975',N'14/44 Trần Bình Trọng Q5','9884343','10/16/1999', N'Tốt nghiệp Đại học Kinh Tế năm 1998, vi tính văn phòng')
Insert into NHAN_VIEN values ('NV015','TD','08',N'Hà Văn Tùng',N'Nam','03/10/1966',N'2/45 Trần Bình Trọng Q5','9987165','12/19/1988', N'Tốt nghiệp Đại học Kinh Tế năm 1988, chứng chỉ C Anh Văn')
Insert into NHAN_VIEN values ('NV016','TT','08',N'Nguyễn Văn Phú',N'Nam','08/14/1962',N'454 Bùi Hữu Nghĩa Q5','8554911','12/02/1987', N'Tốt nghiệp Đại học Kinh Tế năm 1986')
Insert into NHAN_VIEN values ('NV017','TD','09',N'La Trí Trung',N'Nam','11/12/1965',N'12 Minh Phụng Q11','9631533','05/13/1986', N'Tốt nghiệp Đại học Kinh Tế năm 1985, chứng chỉ C Anh Văn')
Insert into NHAN_VIEN values ('NV018','TT','09',N'Trần Hồng Long',N'Nam','01/27/1963',N'7 Lê Lai Q1','8897633','09/03/1985', N'Tốt nghiệp Đại học Kinh Tế năm 1982')
Insert into NHAN_VIEN values ('NV019','TD','10',N'Lưu Tuyết Nhi',N'Nữ','01/05/1966',N'54/35 Bình Thới Q11','9634135','03/08/1989', N'Tốt nghiệp Đại học Kinh Tế năm 1988, chứng chỉ C Anh Văn')
Insert into NHAN_VIEN values ('NV020','TT','10',N'Trần Văn Tuấn',N'Nam','09/02/1961',N'27/4 Nguyễn Huệ Q1','8211911','12/11/1983', N'Tốt nghiệp Đại học Kinh Tế năm 1983')

--8. Nhap lieu cho bang PXUATKHO
Insert into PHIEU_XUAT values ('010202X0001','NV020','02/01/2009') 
Insert into PHIEU_XUAT values ('010202X0002','NV020','02/01/2009')
Insert into PHIEU_XUAT values ('010202X0003','NV001','02/01/2009')
Insert into PHIEU_XUAT values ('010302X0001','NV001','03/01/2009')
Insert into PHIEU_XUAT values ('010302X0002','NV010','03/01/2009')    
Insert into PHIEU_XUAT values ('010302X0003','NV010','03/01/2009')
Insert into PHIEU_XUAT values ('010402X0001','NV005','04/01/2009') 
Insert into PHIEU_XUAT values ('010402X0002','NV006','04/01/2009')  
Insert into PHIEU_XUAT values ('010402X0003','NV007','04/01/2009')
Insert into PHIEU_XUAT values ('010502X0001','NV002','05/01/2009')  
Insert into PHIEU_XUAT values ('010502X0002','NV010','05/01/2009')
Insert into PHIEU_XUAT values ('010602X0001','NV019','06/01/2009')    
Insert into PHIEU_XUAT values ('010602X0002','NV015','06/01/2009')
Insert into PHIEU_XUAT values ('010702X0001','NV008','07/01/2009')
Insert into PHIEU_XUAT values ('010702X0002','NV011','07/01/2009')
Insert into PHIEU_XUAT values ('010702X0003','NV013','07/01/2009')        
                
--9. Nhap lieu cho bang CTPX
Insert into CTPX values ('010202X0001','BCCL1',100)
Insert into CTPX values ('010202X0002','DDCCP',60)
Insert into CTPX values ('010202X0003','BGVJ1',200)
Insert into CTPX values ('010302X0001','CLG01',100)
Insert into CTPX values ('010302X0002','BGO01',50)
Insert into CTPX values ('010302X0003','CAL01',150)
Insert into CTPX values ('010402X0001','CLG01',100)
Insert into CTPX values ('010402X0002','DDCCP',60)
Insert into CTPX values ('010402X0003','CLM01',240)
Insert into CTPX values ('010502X0001','BGO01',24)
Insert into CTPX values ('010502X0002','CLG01',144)
Insert into CTPX values ('010502X0002','CLM01',144)
Insert into CTPX values ('010602X0001','ITD01',100)
Insert into CTPX values ('010602X0001','CLG01',100)
Insert into CTPX values ('010602X0002','CLG01',100)
Insert into CTPX values ('010702X0001','ITD01',100)
Insert into CTPX values ('010702X0001','BCCL1',100)
Insert into CTPX values ('010702X0002','KDDH1',60)
Insert into CTPX values ('010702X0003','KCNP1',60)
Insert into CTPX values ('010702X0003','KDDH1',720)
Insert into CTPX values ('010702X0003','CLG01',120)

Insert into CTPX values ('010702X0003','BGOM2',120)
Insert into CTPX values ('010702X0003','BN001',120)
Insert into CTPX values ('010702X0003','BGOM1',120)


--10. Nhap lieu cho bang HOADON
Insert into HOA_DON values ('010202HD001','NV006','DL011','02/01/2008',4540000)
Insert into HOA_DON values ('010202HD002','NV008','DL003','02/01/2008',4515200)
Insert into HOA_DON values ('010202HD003','NV014','DL004','02/01/2008',4987000)
Insert into HOA_DON values ('010302HD001','NV016','DL011','03/01/2008',4000000)
Insert into HOA_DON values ('010302HD002','NV005','DL003','03/01/2008',3643700)
Insert into HOA_DON values ('010302HD003','NV002','DL004','03/01/2008',3915940)
Insert into HOA_DON values ('010402HD001','NV007','DL012','04/01/2008',4540000)
Insert into HOA_DON values ('010402HD002','NV003','DL003','04/01/2008',4515200)
Insert into HOA_DON values ('010402HD003','NV012','DL005','04/01/2008',3915940)
Insert into HOA_DON values ('010502HD001','NV020','DL001','05/01/2008',624964)
Insert into HOA_DON values ('010502HD002','NV010','DL002','05/01/2008',1269576)
Insert into HOA_DON values ('010602HD001','NV017','DL012','06/01/2008',4000000)
Insert into HOA_DON values ('010602HD002','NV013','DL004','06/01/2008',3643700)
Insert into HOA_DON values ('010702HD001','NV004','DL011','07/01/2008',4000000)
Insert into HOA_DON values ('010702HD002','NV015','DL003','07/01/2008',3643700)
Insert into HOA_DON values ('010702HD003','NV018','DL004','07/01/2008',3915940)




--11. Nhap lieu cho bang CTHD
Insert into CTHD values ('010202HD001','BGO01',50,0.2,700000)  
Insert into CTHD values ('010202HD002','DDCCP',30,0.17,871500)
Insert into CTHD values ('010202HD003','KCNP1',60,0.17,747000)
Insert into CTHD values ('010302HD001','CLG01',50,0.2,700000)      
Insert into CTHD values ('010302HD002','ITD01',30,0.17,871500)
Insert into CTHD values ('010302HD002','KDDH1',60,0.17,896400)
Insert into CTHD values ('010302HD003','CAL01',60,0.17,747000)
Insert into CTHD values ('010402HD001','BN001',100,0.2,696000)      
Insert into CTHD values ('010402HD001','CLG01',50,0.2,70000)      
Insert into CTHD values ('010402HD002','CMLB2',60,0.17,896400)
Insert into CTHD values ('010402HD002','DDCCP',30,0.17,871500)
Insert into CTHD values ('010402HD003','BGOM1',60,0.17,747000)
Insert into CTHD values ('010402HD003','BGOM2',60,0.17,1444200)
Insert into CTHD values ('010502HD001','BGO01',24,0.18,88560)
Insert into CTHD values ('010502HD001','BGO02',3,0.18,62484)
Insert into CTHD values ('010502HD002','CLG01',72,0.15,122400)
Insert into CTHD values ('010502HD002','CLM01',72,0.15,214200)
Insert into CTHD values ('010602HD001','ITD01',100,0.2,696000)
Insert into CTHD values ('010602HD001','CLG01',50,0.2,700000)
Insert into CTHD values ('010602HD002','DGLB1',30,0.17,871500)
Insert into CTHD values ('010602HD002','KCNP1',60,0.17,896400)
Insert into CTHD values ('010702HD001','CLG01',50,0.2,700000)
Insert into CTHD values ('010702HD002','KDDH1',60,0.17,896400)
Insert into CTHD values ('010702HD003','BGO01',60,0.17,747000)

Insert into CTHD values ('010702HD003','BN001',60,0.17,747000)
Insert into CTHD values ('010702HD003','CAL01',60,0.17,747000)
Insert into CTHD values ('010702HD003','ITD01',60,0.17,747000)
Insert into CTHD values ('010702HD003','TG01',60,0.17,747000)


Insert into CTHD values ('010302HD003','BN001',60,0.17,747000)
Insert into CTHD values ('010302HD003','ITD01',60,0.17,747000)
Insert into CTHD values ('010302HD003','TG01',60,0.17,747000)

update HOA_DON
set NGAYLAP = '1/20/2008'


update HOA_DON
set MANV='NV012'
where TONGTIEN BETWEEN 3700000 and 3999999

update HOA_DON
set MANV='NV004'
where TONGTIEN BETWEEN 4000000 and 4500000

update HOA_DON
set MANV='NV006'
where TONGTIEN BETWEEN 4500000 and 5000000
--Test data
select * from dbo.CTHD
select * from dbo.CTPX
select * from dbo.DAI_LY
select * from dbo.DOI
select * from dbo.HANG_HOA
select * from dbo.HINH_THUC_DONG_GOI
select * from dbo.HOA_DON
select * from dbo.LOAI_NV
select * from dbo.NHAN_VIEN
select * from dbo.NHOM_HANG
select * from dbo.PHIEU_XUAT
