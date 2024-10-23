use QLDA_LETHANHTUNG

select nv.MANV,nv.HONV +' '+ nv.TENNV as N'Ho ten Nhan Vien', pb.TENPHG
from NHANVIEN nv, PHONGBAN pb
where pb.MAPHG = nv.PHG

begin
declare @ThongTinNV		nvarchar(max)=''
select @ThongTinNV = CONCAT(@ThongTinNV,'MSNV:',nv.MANV,char(10),'Ho ten nhan vien:',nv.HONV,' ',nv.TENNV, CHAR(10),'ten phong ban:',pb.TENPHG,CHAR(10))
from NHANVIEN nv, PHONGBAN pb
where pb.MAPHG = nv.PHG
print @ThongTinNV
end


--cau 5
select COUNT(*)
from NHANVIEN 
where MA_NQL =50 and PHAI= 'NU'


create procedure Soluongnv_nu
(@matruongphong varchar(max))
as begin
declare @soluongnv varchar(max)=''
	select @soluongnv =COUNT(*)
	from NHANVIEN
	where MA_NQL = @matruongphong and PHAI='NU'

	print 'so luong nhan vien nu:' +@soluongnv

end
go
exec Soluongnv_nu @matruongphong = 2
drop procedure Soluongnv_nu




-------------------------------------------------------------------------------------------------------
--Câu 1
-- Hiển thị dạng văn bản cho biết danh sách các nhân viên gồm các thông tin:
--mã số nhân viên, họ và tên của nhân viên, tên phòng ban nhân viên làm việc.

select nv.MANV,nv.HONV +' '+ nv.TENNV as N'Ho ten Nhan Vien', pb.TENPHG
from NHANVIEN nv, PHONGBAN pb
where pb.MAPHG = nv.PHG

--Lap trinh T-SQL
begin 
	declare @TenNV	Nvarchar(max)
	set @TenNV =''
select @TenNV = CONCAT(@TenNV,N'Mã số nhân viên:',nv.MANV,char(10),N'Họ tên nhân viên:',nv.HONV,' ',nv.TENNV,CHAR(10),N'Tên phòng ban nhân viên làm việc:',pb.TENPHG,CHAR(10))
from NHANVIEN nv, PHONGBAN pb
where pb.MAPHG = nv.PHG

print @TenNV
end

--câu 5:Viết thủ tục hoặc hàm thực hiện công việc sau: cho biết số lượng nhân viên nữ 
--mà một nhân viên có mã xác định quản lý trực tiếp. 
alter procedure count_nv_Nu(@Ma_QL	varchar(10))
as begin
	declare @soluong int
	set @soluong =0
select @soluong = COUNT(*)
from NHANVIEN
where MA_NQL = @Ma_QL and PHAI = 'NU'
select @soluong as N'Số lượng nhân viên nữ'
end
EXEC count_nv_Nu @Ma_QL =50


--câu 4:Viết thủ tục hoặc hàm thực hiện công việc sau:
--liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự một đề án cụ thể có mã số đề án được xác 
--định trước.

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

--Câu 2:Tạo transaction thêm dữ liệu đầy đủ 1 phòng ban mới và 1 nhân viên mới làm trưởng phòng của phòng ban đó. 
--Người quản lý trực tiếp của nhân viên mới cũng là chính người đó


--Câu 3: Tạo Trigger kiểm soát lương của nhân viên mới khi thêm dữ liệu nhân viên.
--Nếu lương của nhân viên > 50.000.000 thì thiết lập về mức 50.000.000
GO
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

SELECT *
FROM NHANVIEN

update NHANVIEN
set LUONG = 85000
where PHG = 30


----------------------------------------------------------------------
