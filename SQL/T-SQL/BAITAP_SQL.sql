--1.Tìm các nhân viên làm việc ở phòng số 5 

CREATE FUNCTION timNV()
RETURNS varchar(MAX)
AS
BEGIN
    DECLARE @nv varchar(MAX) = ''; -- khởi tạo giá trị ban đầu cho biến @nv
    SELECT @nv = @nv + ' ' + HONV + ' ' + TENNV + CHAR(10) -- cộng chuỗi kết quả với họ tên nhân viên
    FROM NHANVIEN
    WHERE PHG = 20;
    RETURN @nv; -- trả về chuỗi kết quả
	END;
print(N'Nhân viên làm việc ở phòng 5:');
print dbo.timNV();

--Tìm các nhân viên có mức lương trên 25000

select HONV, TENNV
from NHANVIEN
where LUONG >25000


create function Tim_luong() 
returns varchar(MAX) as
begin
declare @Tim_nv varchar(MAX)='';
	select @Tim_nv = @Tim_nv +' ' +HONV +' '+TENNV + char(10)
	from NHANVIEN
	where LUONG >2500
	return @Tim_nv;

end;
print dbo.Tim_luong();

--Tìm các nhân viên có mức lương trên 65,000 ở phòng 10 hoặc các nhân viên cómức lương trên 70,000 ở phòng 20

select HONV, TENNV, PHG
from NHANVIEN
where LUONG > 65000 and PHG= 10 or LUONG > 70000 and PHG= 30

create function Tim_Luong_theo_YC()
returns varchar(MAX) as
begin
declare @tim_nv  varchar(MAX)=''
select @tim_nv = @tim_nv + ' ' + HONV + ' ' +TENNV + char(10)
from NHANVIEN
where LUONG > 65000 and PHG= 10 or LUONG > 70000 and PHG= 30
return @tim_nv;
end;
print dbo.Tim_Luong_theo_YC()
drop function Tim_Luong_theo_YC;

--4. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM

select HONV+ ' '+ TENNV 
from NHANVIEN
where DCHI = N'Tp.Hồ Chí Minh'

create function tim_nv()
returns varchar(MAX) as
begin
declare @tim_nv varchar(MAX)=''
select @tim_nv=@tim_nv+'' + HONV+ ' '+ TENNV +char(10) 
from NHANVIEN
where DCHI = N'Tp.Hồ Chí Minh'
return @tim_nv
end

print dbo.tim_nv();


--Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N' 
create function Tim_nv_theo_yc()
returns varchar(MAX) as
begin
declare @tim_nv varchar(MAX)=''
select @tim_nv = @tim_nv+ ' ' + HONV +' ' + TENNV + char(10)
from NHANVIEN
where HONV like 'N%'
return @tim_nv;

end
print dbo.Tim_nv_theo_yc()

--Cho biết ngày sinh và địa chỉ của nhân viên Le 1--procedure giống với void trong lập trìnhcreate procedure cau6f(@ten nvarchar(50))asbegin declare @ns smalldatetime;set @ns ='';declare @dchi Nvarchar(50);set @dchi = '';select @ns = NGSINH, @dchi = DCHIfrom NHANVIENwhere HONV + ' '+ TENNV = @ten print N'Ngày sinh: '+ convert(varchar(50),@ns);print N'Địa chỉ:' + @dchi;end;drop procedure cau6fexec cau6f @ten = 'Le 1';select NGSINH, DCHI from NHANVIEN where MANV = '1'
--Cho biết các nhân viên có năm sinh trong khoảng 1955 đến 1975 --function giống với hàm trả về trong lập trìnhcreate function timnv_theons()returns varchar(MAX) asbegindeclare @tenNV varchar(MAX)='';select @tenNV = @tenNV+ ' ' + HONV +' ' + TENNV + char(10)from NHANVIENwhere YEAR(NGSINH) between 1955 and 1975return @tenNV;enddrop function timnv_theonsprint dbo.timnv_theons();--Cho biết các nhân viên và năm sinh của nhân viên(code chính không sử dụng con trỏ mà sử dụng hàm CONCAT())
--CONCAT(BIẾN,CHAR(9 OR 10),CÁC TRƯỜNG VÀ DÙNG DẤU PHẨY ĐỂ NỐI CÁC TRƯỜNG VỚI NHAU)
CREATE PROCEDURE ns
AS
BEGIN
    DECLARE @Count INT, @MaxCount INT, @TenNV VARCHAR(MAX)
    SET @Count = 1
    SET @MaxCount = (SELECT COUNT(*) FROM NHANVIEN)
    SET @TenNV = ''
    WHILE @Count <= @MaxCount
    BEGIN 
        DECLARE @hoten VARCHAR(50), @ten VARCHAR(MAX), @nam SMALLDATETIME
        SELECT @hoten = HONV, @ten = TENNV, @nam = NGSINH
        FROM NHANVIEN
        WHERE MANV = @Count

        SET @TenNV = CONCAT(@TenNV, @hoten, ' ', @ten, CHAR(9), char(9), CONVERT(VARCHAR, YEAR(@nam)), CHAR(10))

        SET @Count = @Count + 1
    END

    PRINT N'Tên và năm sinh của nhân viên'
    PRINT @TenNV
END
GO

EXEC ns
drop  PROCEDURE ns

--Cho biết các nhân viên và tuổi của nhân viên 
CREATE PROCEDURE TUOI_nv
AS BEGIN
DECLARE @DEM INT, @DEMMAX	INT, @Tenv VARCHAR(MAX), @tuoi VARCHAR(100)
SET @DEM = 1;
SET @DEMMAX = (SELECT COUNT(*) FROM NHANVIEN)
SET @Tenv = ''
SET @tuoi = ''
WHILE @DEM <= @DEMMAX
BEGIN
DECLARE @hoten	varchar(20), @ten	varchar(max), @Sotuoi int
select @hoten = HONV, @ten = TENNV , @Sotuoi =DATEDIFF(YEAR,NGSINH,GETDATE())
from NHANVIEN
where MANV = @DEM

SET @Tenv = CONCAT(@Tenv,@hoten,' ' ,@ten, Char(10) ,'age:',convert(varchar,@Sotuoi),char(10))
Set @DEM = @DEM +1

END

PRINT N'Tên và tuổi của nhân viên'
    PRINT @Tenv
END
go
exec TUOI_nv

drop procedure TUOI_nv


--Truy vấn có sử dụng kết nối
--Với mỗi phòng ban, cho biết tên phòng ban và địa điểm phòng create procedure ThongTinPBas begindeclare @output	nvarchar(Max) = '';	select @output = CONCAT(@output,PB.TENPHG,':',dd.DIADIEM,char(10))	from PHONGBAN PB, DIADIEM_PHG DD	where pb.MAPHG = dd.MAPHG	PRINT @outputend

go
exec ThongTinPB
drop  PROCEDURE ThongTinPB

--Tìm tên những người trưởng phòng của từng phòng ban
select nv.MANV , pb.TENPHG
from PHONGBAN pb, NHANVIEN NV 
where nv.MANV = pb.TRPHG


create procedure TenTrgPhg
as begin
declare @TenTrgPhong	varchar(max)= ''
select @TenTrgPhong = CONCAT(@TenTrgPhong,nv.HONV,' ', nv.TENNV,char(10),'Tên phòng ban:',pb.TENPHG ,char(10))
from	PHONGBAN pb, NHANVIEN NV
where nv.MANV = pb.TRPHG

print @TenTrgPhong


end
go
exec TenTrgPhg
DROP PROCEDURE TenTrgPhg


-- tìm tên và địa chỉ của tất cả các nhân viên của phòng điều hành(nhân sự)

select NHANVIEN.MANV , NHANVIEN.TENNV,NHANVIEN.DCHI, PHONGBAN.TENPHG
from NHANVIEN , PHONGBAN
where PHONGBAN.MAPHG = NHANVIEN.PHG

create procedure Timten_diachi
as begin
declare @Tennv	nvarchar(max) =''

select @Tennv = CONCAT(@Tennv,NV.HONV,' ',NV.TENNV,char(10),' Ten phong ban:',PB.TENPHG,CHAR(10))
from NHANVIEN NV , PHONGBAN PB
where PB.MAPHG = NV.PHG

print @Tennv
end
go
exec Timten_diachi
drop procedure Timten_diachi

--với mỗi đề án ở nha trang cho biết tên đề án, tên phòng ban, họ tên và ngày
--nhận chức của trưởng phòng của phòng ban chủ trì đề án đó
select Nv.HONV + ' ' + nv.TENNV as N'Họ tên trưởng phòng', da.TENDA, pb.TENPHG,pb.NG_NHANCHUC
from DEAN da, NHANVIEN nv, PHONGBAN pb
where pb.MAPHG = da.PHONG and da.DDIEM_DA = 'NHA TRANG' and nv.MANV = pb.TRPHG

create procedure ThongtinDean
as begin
declare @Thongtindean	nvarchar(max)
select @Thongtindean = CONCAT(@Thongtindean,N'Tên trưởng phòng:',nv.HONV,' ',nv.TENNV,CHAR(10),N'Ngày nhận chức:',pb.NG_NHANCHUC,CHAR(10),N'Tên đề án:',da.TENDA,CHAR(10))
from DEAN da, NHANVIEN nv, PHONGBAN pb
where pb.MAPHG = da.PHONG and da.DDIEM_DA = 'NHA TRANG' and nv.MANV = pb.TRPHG
print @Thongtindean
end
go
exec Thongtindean
drop procedure ThongtinDean

--

