--CÂU 1
CREATE DATABASE ABC_LETHANHTUNG
USE ABC_LETHANHTUNG
--CÂU 2

--CÂU 3
CREATE TABLE NhanVien
(
MaNV	varchar(5) not null,
Ho		nvarchar(10),
Ten		nvarchar(30),
DiaChi	nvarchar(150),
SDT		varchar(11),
Email	varchar(150),
constraint FK_NhanVien primary key(MaNV),


);

CREATE TABLE HangHoa
(
MaHang		varchar(5) not null,
TenHang		nvarchar(50),
XuatXu		nvarchar(50),
NgayNhap	smalldatetime,
SoLuongT	int,
constraint PK_HangHoa primary key(Mahang)
);

CREATE TABLE GiaoDich
(
MaNV		varchar(5) not null,
MaHang		varchar(5) not null,
NgayXuat	smalldatetime not null,
SoLuongX	int,
constraint PK_GiaoDich primary key(MaNV,MaHang,NgayXuat),
constraint FK_GIaoDich_NhanVien foreign key(MaNV) references NhanVien(MaNV),
constraint FK_GIaoDich_HangHoa foreign key(MaHang) references HangHoa(MaHang)
);

insert into NhanVien(MaNV,Ho,Ten,DiaChi,SDT,Email)
values('NV001',N'Lê Thanh',N'Tùng',N'Nha Trang-Khánh Hòa','0287774258','Tung@gmail.com')
,('NV002',N'Lê Thanh',N'Tuấn',N'Nha Trang-Khánh Hòa','0289228197','Tuan@gmail.com')
,('NV003',N'Nguyễn Chí',N'Thiện',N'Nha Trang-Khánh Hòa','039651174','Thien@gmail.com')

insert into HangHoa(MaHang,TenHang,XuatXu,NgayNhap,SoLuongT)
values('T101',N'Điện Thoại Samsung',N'Nhật Bản','2023-01-12',10)
,('T102',N'Điện Thoại Iphone',N'Mỹ','2022-10-12',5)
,('T103',N'Điện Thoại Oppo',N'Trung Quốc','2023-03-12',10)

insert into GiaoDich(MaNV,MaHang,NgayXuat,SoLuongX)
values('NV001','T101','2023-04-10',5)
,('NV002','T102','2022-10-12',6)
,('NV003','T103','2023-04-9',8)

--Câu 4
create schema Kho;

--Câu 5
select *
from HangHoa
where YEAR(NgayNhap) = 2022

--Câu 6
select SUM(GD.SoLuongX) as N'tổng trọng hàng hóa xuất kho(tấn) '
from HangHoa HH,GiaoDich GD
where HH.MaHang = GD.MaHang


--Câu 8
select HH.MaHang,HH.TenHang,max(GD.MaHang) as N'hàng hóa có khối lượng xuất kho nhiều nhất năm 2022'
from HangHoa HH,GiaoDich GD
where HH.MaHang = GD.MaHang and Year(GD.NgayXuat) = 2022
group by HH.MaHang,HH.TenHang

--Câu 7
update HangHoa

create schema Kho
alter schema Kho transfer HangHoa





