--1.Xuất ra danh sách họtên các giáo viên cùng sốmôn họ được phân công giảng dạy (giáo 
-- viên giảng dạy môn đó 2 lần thì vẫn tính là một môn). 
select gv.TenGV, COUNT(distinct PHANCONG.MaMH) 
from giaovien gv, PHANCONG 
where gv.MaGV= PHANCONG.MaGV
group by gv.MaGV,gv.TenGV
-- 2.  Xuất ra danh sách họtên các giáo viên cùng sốmôn họcó khảnăng giảng dạy. 
select gv.TenGV, COUNT(*)
from GIAOVIEN gv, GIAOVIEN_DAY_MONHOC knday, MONHOC
where gv.MaGV= knday.MaGV and MONHOC.MaMonHoc= knday.MaMH
group by gv.MaGV,gv.TenGV
-- 3.  Xuất ra tên các môn học cùng sốhọc viên đã từng thi rớt môn này theo thứtựgiảm dần 
-- sốhọc viên rớt. 
select MONHOC.TenMonHoc, COUNT(*) as sohocsinhrot
from MONHOC, KETQUA
where MONHOC.MaMonHoc = KETQUA.MaMonHoc and KETQUA.Diem <5
group by MONHOC.MaMonHoc, MONHOC.TenMonHoc
order by COUNT(*) desc
-- 4.  Xuất ra danh sách học viên và số môn mà học viên này đã từng thi rớt. 
select distinct HOCVIEN.TenHocVien, MONHOC.TenMonHoc as MonTungThiRot
from HOCVIEN, MONHOC, KETQUA
where HOCVIEN.MaHocVien= KETQUA.MaHV and MONHOC.MaMonHoc= KETQUA.MaMonHoc
and KETQUA.Diem<5

-- 5.  Xuất ra mã số, họtên các giáo viên có quản lý từhai giáo viên trởlên. 
select GIAOVIEN.MaGV,GIAOVIEN.TenGV 
from GIAOVIEN 
where GIAOVIEN.MaGV in (select gv.MaGVQuanLi from GIAOVIEN gv group by gv.MaGVQuanLi having COUNT(*) >=2)
-- 6.  Xuất ra mã lớp và sốhọc viên đã từng thi đậu môn ‘Cấu trúc dữliệu’ ởcác lớp này. 

-- 7.  Đếm sốhọc viên đã từng thi rớt môn ‘Cấu trúc dữliệu’. 
select COUNT(*) as "So Hoc Vien Rot"
from KETQUA, MONHOC
where KETQUA.Diem<5 and KETQUA.MaMonHoc = MONHOC.MaMonHoc and MONHOC.TenMonHoc = N'Cấu trúc dữ liệu'

-- 8.  Đếm số môn mà giáo viên ‘Trần Minh Anh’ được phân công giảng dạy. 
select COUNT(distinct pc.MaMH)
from GIAOVIEN, PHANCONG pc
where GIAOVIEN.MaGV = pc.MaGV and GIAOVIEN.TenGV= N'Trần Minh Anh'
-- 9.  Ứng với mỗi học viên của lớp do học viên ‘HV000003’ là trưởng lớp, xuất ra họtên học 
-- viên cùng với sốmôn mà học viên này  đã từng thi đậu (học viên thi đậu môn này 2 lần 
-- thì vẫn tính là 1 môn). 
select HOCVIEN.TenHocVien, COUNT(distinct KETQUA.MaMonHoc)
from HOCVIEN, LOPHOC, KETQUA
where LOPHOC.LopTruong = 'HV000003' and HOCVIEN.MaLop= LOPHOC.MaLop and KETQUA.MaHV = HOCVIEN.MaHocVien
and KETQUA.Diem >=5
group by HOCVIEN.MaHocVien,HOCVIEN.TenHocVien

-- 10.  Ứng với mỗi giáo viên do giáo viên ‘Nguyễn ThịNhưLan’ làm quản lý, xuất ra họtên 
-- giáo viên và sốmôn mà giáo viên này có khảnăng giảng dạy với thâm niên trên 3 năm. 
-- Xuất theo thứtựgiảm dần sốmôn. 
select GIAOVIEN.TenGV, COUNT(GIAOVIEN_DAY_MONHOC.MaMH) as somon
from GIAOVIEN, GIAOVIEN_DAY_MONHOC
where GIAOVIEN.MaGVQuanLi in (select MaGV from GIAOVIEN where TenGV= N'Nguyễn Thị Như Lan')
and GIAOVIEN.MaGV = GIAOVIEN_DAY_MONHOC.MaGV and GIAOVIEN_DAY_MONHOC.ThamNien >=3
group by GIAOVIEN.MaGV,GIAOVIEN.TenGV
order by somon desc
-- 11.  Ứng với mỗi giáo viên, đếm xem giáo viên này từng giảng dạy cho lớp ‘LH000001’ bao 
-- nhiều môn, xuất ra mã số, họtên giáo viên và sốmôn. 
select GIAOVIEN.MaGV,GIAOVIEN.TenGV, COUNT(*)as Somon
from GIAOVIEN, PHANCONG
where GIAOVIEN.MaGV = PHANCONG.MaGV and PHANCONG.MaLop = 'LH000001'
group by GIAOVIEN.MaGV,GIAOVIEN.TenGV
-- 12.  Xuất ra tên các môn học có nhiều hơn 1 học viên thi đậu ngay lần thi đầu tiên. 
select distinct MONHOC.TenMonHoc
from MONHOC,KETQUA kq1
where MONHOC.MaMonHoc = kq1.MaMonHoc
and exists (select * 
			from KETQUA kq2 
			where kq1.MaMonHoc= kq2.MaMonHoc and kq2.LanThi=1 and kq2.Diem>=5 
			group by kq2.MaMonHoc 
			having COUNT(kq2.MaHV)>=1)
-- 13.  Xuất ra mã số, họtên các giáo viên có quản lý từhai giáo viên trởlên. 
select GIAOVIEN.MaGV,GIAOVIEN.TenGV 
from GIAOVIEN 
where GIAOVIEN.MaGV in (select gv.MaGVQuanLi from GIAOVIEN gv group by gv.MaGVQuanLi having COUNT(*) >=2)
-- 14.  Xuất ra tên giáo viên quản lý của giáo viên từng dạy môn có nhiều hơn 2 học viên thi 
-- đậu ngay lần thi đầu tiên. 
select distinct gv1.TenGV
from GIAOVIEN gv1, GIAOVIEN gv2, KETQUA kq1, PHANCONG
where gv1.MaGV = gv2.MaGVQuanLi and gv2.MaGV = PHANCONG.MaGV and PHANCONG.MaMH = kq1.MaMonHoc and 
exists (select * 
			from KETQUA kq2 
			where kq1.MaMonHoc= kq2.MaMonHoc and kq2.LanThi=1 and kq2.Diem>=5 
			group by kq2.MaMonHoc 
			having COUNT(kq2.MaHV)>=2)
			
--select * from GIAOVIEN
--select * from phancong where MaGV= 'GV00006'
--select * from KETQUA where KETQUA.MaMonHoc in ('MH00008','MH00009','MH00010') and Diem >=5 and LanThi=1
-- 15.  Xuất ra tên và sĩ số các lớp có giáo viên có khả năng giảng dạy nhiều hơn hai môn làm quản lý
select LOPHOC.MaLop, LOPHOC.SiSo
from LOPHOC, GIAOVIEN,GIAOVIEN_DAY_MONHOC gvd
where LOPHOC.GVQuanLi = GIAOVIEN.MaGV and gvd.MaGV = GIAOVIEN.MaGV
group by LOPHOC.MaLop,LOPHOC.SiSo,gvd.MaGV
having COUNT(gvd.MaGV) >=2