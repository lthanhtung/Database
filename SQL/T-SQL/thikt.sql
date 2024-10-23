use QLDA_LETHANHTUNG
-----------------------------------------------------------------------
--Câu 1
begin
	declare @demnv	int
	declare @diadiem	nvarchar(max)
	declare	@Tenphong	nvarchar(max)
	declare contro	cursor for 
	select  pg.TENPHG,DD.DIADIEM,COUNT(MANV)
	from NHANVIEN nv, DIADIEM_PHG DD, PHONGBAN pg
	where nv.PHG = dd.MAPHG and dd.MAPHG = pg.MAPHG
	group by dd.DIADIEM,pg.TENPHG
open contro
fetch next from contro into @Tenphong,@diadiem,@demnv
while @@FETCH_STATUS = 0
	begin
	print (N'Tên Phòng ban:' + @Tenphong)
	print (N'Địa Điểm phòng:' + @diadiem)
	print (N'Số lượng nhân viên:' + CAST(@demnv as varchar(20)))
	fetch next from contro into @Tenphong,@diadiem,@demnv
	end

end
close contro
deallocate contro
--câu 3
create trigger


--------------------------------------------------------------------------------------------
--Câu 4


select nv.HONV,nv.TENNV, nql.HONV,nql.TENNV
from NHANVIEN nv, NHANVIEN nql
where nv.MANV = 12 and nql.MAnv =nv.MA_NQL


create procedure Cau4(@manv	varchar(120) output)
as begin

	declare @Hoten		varchar(200)
	declare @hotenNQl	varchar(200)
	select @Hoten=nv.HONV + ' '+ nv.TENNV, @hotenNQl = nql.HONV +' '+nql.TENNV
	from NHANVIEN nv, NHANVIEN nql
	where nv.MANV = @manv and nql.MAnv =nv.MA_NQL

	select @Hoten as N'Tên nhân viên', @hotenNQl  as N'Họ tên người quản lý'


end
exec Cau4 @manv = 12
drop procedure Cau4


--Câu 5
begin
declare @luong int
select @luong = MAX(LUONG)
from NHANVIEN
where PHG =1

select HONV , TENNV
from NHANVIEN
where PHG =1 and LUONG = @luong
end

create function Cau5(@phongban	varchar(max))
returns varchar(100)
begin
	declare @HotenNV	varchar(max)
	declare	@Luong	int
	select @Luong = MAX(LUONG) 
	from NHANVIEN
	where phg=@phongban


	select @HotenNV = HONV + ' '+ TENNV
	from NHANVIEN
	where PHG = @phongban and LUONG = @Luong
	return @HotenNV
end

select dbo.Cau5(20) as N'Nhân viên có lương cao nhất trong phòng'
drop function Cau5

