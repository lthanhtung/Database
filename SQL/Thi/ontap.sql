--cau 1 contro
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


--cu phap tran
BEGIN TRAN
BEGIN TRY



COMMIT
END TRY
BEGIN CATCH



ROLLBACK
DECLARE @ErrorMessage VARCHAR(2000)
SELECT @ErrorMessage = ERROR_MESSAGE()
RAISERROR(@ErrorMessage, 16, 1)
END CATCH

--cau 2
CREATE TRIGGER KiemSoatLuong
on Nhanvien
for Insert
as begin

declare @luong  numeric(18, 0)
	select @luong = LUONG
	from inserted

if(@luong >  50000000)
	begin 
		PRINT 'LUONG NHAN VIEN THAY DOI THANH  50.000.000'
		UPDATE NHANVIEN
		SET LUONG =  50000000
		WHERE MANV in (select MANV FROM inserted)
	end

pRINT 'INSERT THANH CONG'
end

insert NHANVIEN(MANV,HONV,TENNV,LUONG)
values 
(
'52','LE THANH','HAI',6000000000
)

DROP TRIGGER KiemSoatLuong


--cau 4
select da.TENDA, sum(pc.THOIGIAN)
from DEAN da, NHANVIEN nv, PHANCONG pc
where da.MADA = pc.SODA and nv.MANV = pc.MA_NVIEN
group by da.TENDA

go

create procedure Thoigianlamviec(@Ma_dean	varchar(10))
as begin
declare @TongTg	 int, @tenda	  varchar(30)
set @TongTg = 0
select @TongTg = SUM(pc.THOIGIAN) , @tenda = da.TENDA
from DEAN da, PHANCONG pc
where da.MADA = @Ma_dean and da.MADA = pc.SODA
group by da.TENDA
select @tenda as'ten da', @TongTg as'Tong thoi gian'
end
go
exec Thoigianlamviec @Ma_dean = 10
drop procedure Thoigianlamviec
--cau 5 
CREATE FUNCTION timNV()
RETURNS varchar(MAX)
AS
BEGIN
    DECLARE @nv varchar(MAX) = ''; -- kh?i t?o giá tr? ban ??u cho bi?n @nv
    SELECT @nv = @nv + ' ' + HONV + ' ' + TENNV + CHAR(10) -- c?ng chu?i k?t qu? v?i h? tên nhân viên
    FROM NHANVIEN
    WHERE PHG = 20;
    RETURN @nv; -- tr? v? chu?i k?t qu?
	END;
print(N'Nhân viên làm vi?c ? phòng 5:');
print dbo.timNV();


--cau login
create login dsjsdjsdl
with password = 'matkhau'
--cau user
use QLDA
create user jdsjfsdj for login admin;