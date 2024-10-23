--On tap
--De 1
--Cau 1
declare @msnv	varchar(100)
declare @hoten	varchar(max)
declare	@Phong	Nvarchar(50)
declare contro	cursor for
select nv.MANV , nv.HONV + ' ' + nv.TENNV , pg.TENPHG
from NHANVIEN nv, PHONGBAN pg
where pg.MAPHG = nv.PHG
open contro
fetch next from contro into @msnv, @hoten, @Phong
while @@FETCH_STATUS = 0
begin
	print ('ma so nhan vien:'+ @msnv)
	print ('ho ten nhan vien:' + @hoten)
	print ('phong ban:'+ @phong + char(10))
fetch next from contro into @msnv, @hoten, @phong
end
close contro
deallocate contro

--Cau 4
create procedure Cau4de1(@masodean	varchar(10) OUTPUT)
as
begin
	declare @Tendean	varchar(100)
	declare @tonggio	int

select @Tendean = TENDA 
from DEAN
where MADA = @masodean

select @tonggio= SUM(7*THOIGIAN)
from PHANCONG
where PHANCONG.SODA =  @masodean

select @Tendean as 'ten de an',@tonggio as 'tong gio'



end


go

exec Cau4de1 @masodean = '1'
drop procedure Cau4de1


--Cau 5
select COUNT(MANV) as'so luong nhan vien nu quan ly'
from NHANVIEN
where PHAI = 'NU' and MA_NQL = 14


Create function dsNVnu(@QuanLy	varchar(200))
returns int
as begin
	declare	@TongNV	int

	select @TongNV = COUNT(MANV)
	from NHANVIEN
	where PHAI = 'NU' and MA_NQL = @QuanLy
return @tongNV
end

select dbo.dsNVnu('100') as fjasldkjfasd

drop function dsNVnu


create function C5(@QuanLY	varchar(20))
returns int
as begin
	declare @TongnvNu int
	select @TongnvNu = COUNT(MANV)
	from NHANVIEN
	where PHAI = 'NU' and MA_NQL = @QuanLY
return @tongnvnu

end

select dbo.C5('100') as 'so luong nhan vien nu quan ly'

drop function C5

