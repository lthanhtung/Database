﻿USE QLDA_LETHANHTUNG
--Câu 1:
begin
declare @ThongtinNV	Nvarchar(max)=''
select @ThongtinNV = CONCAT(@ThongtinNV,N'Họ tên nhân viên:',nv.HONV,' ' ,nv.TENNV,char(10),N'Mã số đề án:',pc.SODA,char(10))
from  PHANCONG pc,NHANVIEN nv
where pc.MA_NVIEN= nv.MANV

print @ThongtinNV
end



--Câu 3
CREATE TRIGGER PhanDean
on PHANCONG
for insert
as begin
declare @Tonggio  int
	select @Tonggio = THOIGIAN
	from inserted

if(@Tonggio >= 180)
	begin 
		PRINT 'THoi gian lam viec > 180. Insert không thành công'
		ROlLBACK Tran
	end

print 'INSERT THANH CONG'
end
insert PHANCONG(MA_NVIEN,SODA,THOIGIAN)
values 
(
'51','8',180
)
insert PHANCONG(MA_NVIEN,SODA,THOIGIAN)
values
('52','8',70)
drop trigger PhanDean

--Câu 4

Create procedure ThongtinQL(@Phong	varchar(10),@maNQL	varchar(10))
as begin
declare @Tongnv	int, @HotenQL	varchar(max)
select @Tongnv = COUNT(MANV)-1
from NHANVIEN
where PHG = @Phong
select @HotenQL = HONV + ' ' + TENNV 
from NHANVIEN
where MANV = @maNQL

select @Tongnv as N'So lượng nhân viên quản lý', @HotenQL as N'Họ tên NQL'

end

exec ThongtinQL @phong = 10, @maNQL = 2
drop procedure ThongtinQL


--câu 5
create procedure TongLuong(@phongban varchar(10))
as begin
declare @sumluong int = 0
select @sumluong = SUM(LUONG)
from NHANVIEN nv, PHONGBAN pb
where pb.MAPHG = @phongban and pb.MAPHG = nv.PHG

select @sumluong as'luong cua phong ban'

end
exec TongLuong @phongban = '10'