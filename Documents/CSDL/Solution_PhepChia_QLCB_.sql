--51.  Cho biết mã những chuyến bay đã bay tất cả các máy bay của hãng “Boeing”.
go
select * 
from LOAIMB lmb
where lmb.HANGSX like 'Boeing'
	and not exists (select * 
					from CHUYENBAY cb
					where not exists (select * 
										from LICHBAY lb
										where lb.MALOAI = lmb.MALOAI
											and lb.MACB = cb.MACB)
					)
--52.  Cho biết mã và tên phi công có khả năng lái tất cả các máy bay của hãng “Airbus”.
go
select nv.MANV, nv.TEN
from NHANVIEN nv
where nv.LOAINV = 1
	and not exists (select *
					from LOAIMB lmb
					where lmb.HANGSX like 'Airbus'
						and not exists (select * 
										from KHANANG kn
										where kn.MALOAI = lmb.MALOAI
											and kn.MANV = nv.MANV)
					)
--53.  Cho  biết  tên  nhân  viên  (không  phải  là  phi  công)  được  phân  công  bay  vào  t ất  cả  các 
--chuyến bay có mã 100.
go
select nv.TEN
from NHANVIEN nv
where nv.LOAINV = 0
	and not exists (select *
					from LICHBAY lb
					where not exists (select *
										from PHANCONG pc
										where pc.MACB = lb.MACB
											and pc.NGAYDI = lb.NGAYDI
											and pc.MANV = nv.MANV)
					)
--54.  Cho biết ngày đi nào mà có t ất cả các loại máy bay c ủa hãng “Boeing” tham gia.
go
select lb.NGAYDI
from LICHBAY lb
where not exists( select lmb.*
				  from LOAIMB lmb
				  where lmb.HANGSX like 'Boeing'
					and lmb.MALOAI not in( select lb2.MALOAI 
										   from LICHBAY lb2
										   where lb2.NGAYDI = lb.NGAYDI
										   group by lb2.MALOAI)
				)
--55.  Cho biết loại máy bay của hãng “Boeing” nào có tham gia vào tất cả các ngày đi.
go
select *
from LOAIMB lmb
where lmb.HANGSX like 'Boeing'
and not exists (select * from LICHBAY lb 
				where lb.NGAYDI not in(select lb2.NGAYDI 
								  from LICHBAY lb2 
								  where lb2.MALOAI = lmb.MALOAI
								  group by lb2.NGAYDI)
								  )
go
select *
from LOAIMB lmb
where lmb.HANGSX like 'Boeing'
and not exists (select * from LICHBAY lb 
				where not exists (select *
								  from LICHBAY lb2 
								  where lb2.MALOAI = lmb.MALOAI
								  and lb2.NGAYDI <> lb.NGAYDI)
								  )

--56.  Cho biết mã và tên các khách hàng có đ ặt chổ trong tất cả các ngày từ 31/10/2000 đến 
--1/11/2000
select kh.MAKH, kh.TEN
from KHACHHANG kh
where not exists (select dc.MACB
				  from DATCHO dc
				  where NGAYDI between '2000-10-31' and '2000-11-1'
					and dc.MACB not in (select lb.MaCB 
										from LICHBAY lb
										where lb.NGAYDI = dc.NGAYDI
										group by lb.MACB)
				  )
--57.  Cho  biết  mã  và  tên  phi  công  không  có  khả  năng  lái  được  
--tất  cả  các  máy  bay  của  hãng “Airbus”
go
select nv.MANV, nv.TEN
from NHANVIEN nv
where nv.LOAINV = 1
	and exists (select lmb.*
				from LOAIMB lmb
				where lmb.HANGSX like 'Airbus'
					and not exists (select kn.*
									from KHANANG kn
									where kn.MALOAI = lmb.MALOAI
										and kn.MANV = nv.MANV)
				)										
--58.  Cho biết sân bay nào đã có t ất cả các loại máy bay của hãng “Boeing” xuất phát  
go
select cb.SBDI
from CHUYENBAY cb
where not exists (select * 
				  from LOAIMB lmb
				  where lmb.HANGSX like 'Boeing'
					and not exists (select *
									from LICHBAY lb
									where lb.MALOAI = lmb.MALOAI
										and lb.MACB = cb.MACB)
				)