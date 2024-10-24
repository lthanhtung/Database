﻿--Câu 1
create database  KhachSan_LeThanhTung

use KhachSan_LeThanhTung
--Câu 2

create table Phong
(
MaPhong varchar(5) not null,
Tang	int,
LoaiPhong	nvarchar(30),
GiaNienYet	money,
constraint PK_Phong primary key(MaPhong),
constraint GiaPhong check(GiaNienYet > 100000)



);

create table KhachHang
(
MaKH varchar(5) not null,
HoKH nvarchar(30),
TenKH nvarchar(20),
SoCC varchar(13),
GioiTinh int,
SoDienThoai	varchar(20),
constraint PK_KhachHang primary key(MaKH)
);

create table PhieuDatPhong
(
MaPhieu	varchar(5) not null,
MaKH varchar(5) not null,
NgayDatPhong	smalldatetime,
constraint Pk_PhieuDatPhong primary key(MaPhieu),
constraint FK_PhieuDatPhong foreign key(MaKH) references KhachHang(MaKH)

);

create table ChiTietPDP
(
MaPhieu	varchar(5) not null,
MaPhong varchar(5) not null,
NgayDen	smalldatetime,
NgayDi	smalldatetime,
Dongia	money,
constraint Pk_ChiTietPDP primary key(MaPhieu,MaPhong),
constraint FK_ChiTietPDP_PhieuDatPhong foreign key(MaPhieu) references PhieuDatPhong(MaPhieu),
constraint FK_ChiTietPDP_Phong foreign key(MaPhong) references Phong(MaPhong),
constraint Dongia check(DonGia > 100000)
);


insert into Phong(MaPhong,Tang,LoaiPhong,GiaNienYet)
values
('A101',1,N'Phổ Thông',150000),
('A102',1,N'Tổng Thống',350000),
('A103',1,N'Cao Cấp',250000)

insert into KhachHang(MaKH,HoKH,TenKH,SoCC,GioiTinh,SoDienThoai)
values
('0001',N'Lê Thi',N'Thùy Linh','01234567890',1,'0287774221'),
('0002',N'Lê Hoàng',N'Bảo','01234567891',0,'0287774229'),
('0003',N'Lê Thanh',N'Hoàng Long','01234567895',0,'0287774245')

insert into PhieuDatPhong(MaPhieu,MaKH,NgayDatPhong)
values
('P0001','0001','2023-01-23'),
('P0002','0002','2023-02-03'),
('P0003','0003','2023-03-14')

insert into ChiTietPDP(MaPhieu,MaPhong,NgayDen,NgayDi,Dongia)
values
('P0001','A101','2023-01-24','2023-02-05',150000),
('P0003','A103','2023-03-20','2023-04-04',250000)

insert into ChiTietPDP(MaPhieu,MaPhong,NgayDen,Dongia)
values ('P0002','A103','2023-02-10',250000)

--Câu 3
select *
from KhachHang
where HoKH =N'Nguyễn'

--Câu 4
select KH.HoKH+' '+ KH.TenKH as N'Họ Tên KH',KH.SoCC,KH.SoDienThoai,CT.MaPhong,P.LoaiPhong,CT.NgayDen
from KhachHang KH,ChiTietPDP CT, Phong P,PhieuDatPhong PDP
where p.MaPhong = CT.MaPhong and KH.MaKH = PDP.MaKH and YEAR(PDP.NgayDatPhong) = 2022

--Câu 5
select P.MaPhong,P.LoaiPhong,COUNT(PDG.MaPhieu)
from Phong p, PhieuDatPhong PDG, KhachHang KH, ChiTietPDP CT
where KH.MaKH= PDG.MaKH and p.MaPhong=Ct.MaPhong and YEAR(PDG.NgayDatPhong) = 2023
group by P.MaPhong,P.LoaiPhong
