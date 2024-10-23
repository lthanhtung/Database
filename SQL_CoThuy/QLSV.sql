create database QLSV

use QLSV

create table KHOA
(
	MaKhoa	Varchar(10) not null,
	TenKhoa Nvarchar(50) not null,
	SL_CBGD	Smallint not null,
	constraint pk_Khoa  PRIMARY KEY(MaKhoa) 

)

create table SINHVIEN
(
	MSSV		Varchar(5)		not null,
	Ten			Nvarchar(50)	not null,
	GioiTinh	Varchar(5)		not null,
	DiaChi		Nvarchar(100)	not null,
	DienThoai	Varchar(20),
	MaKhoa		Varchar(10),
	SLM int,
	DTB decimal(3,1),
	XL nvarchar(50)
	Constraint pk_SINHVIEN PRIMARY KEY(MSSV),
	Constraint fk_SINHVIEN_KHOA FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa)

)

create table GIAOVIEN
(
	MaGV	Varchar(5)		not null,
	TenGV	Nvarchar(50)	not null,
	MaKhoa	Varchar(10),
	Constraint pk_GIAOVIEN PRIMARY KEY(MaGV),
	Constraint fk_GIAOVIEN_KHOA FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa)

)

create table GIANGDAY
(
	MaKhoaHoc	Varchar(5)	not null,
	MaGV		Varchar(5),
	MaMH		Varchar(5),
	HocKy		SmallInt	not null,
	Nam			int			not null,
	Constraint Pk_GIANGDAY PRIMARY KEY(MaKhoaHoc),
	Constraint fk_GiANGDAY_GIAOVIEN FOREIGN KEY(MaGV) REFERENCES GIAOVIEN(MaGV),
	Constraint fk_GIANGDAY_MONHOC	FOREIGN KEY(MaMH) REFERENCES MONHOC(MaMH)

)

create table KETQUA
(
	MaSV		Varchar(5)		not null,
	MaKhoaHoc	Varchar(5)		not null,
	Diem		Decimal(3,1)	not null,
	constraint pk_KETQUA PRIMARY KEY(MaSv,MaKhoaHoc),
	constraint fk_KETQUA_GIANGDAY FOREIGN KEY(MaKhoaHoc) REFERENCES GIANGDAY(MaKhoaHoc),
	constraint fk_KETQUA_SINHVIEN FOREIGN KEY(MaSV) REFERENCES SINHVIEN(MSSV)
)

create table MONHOC
(
	MaMH	Varchar(5)		not null,
	TenMH	Nvarchar(50)	not null,
	SoTC	Smallint,
	Constraint pk_MONHOC PRIMARY KEY(MaMH)

)

INSERT INTO KHOA
VALUES	('CNTT',N'Công nghệ thông tin',15),
		('TOAN',N'Toán',20),
		('SINH',N'Sinh học',7)

INSERT INTO SINHVIEN
VALUES	('SV001',N'BUI THUY AN','Nu',N'223 TRAN HUNG DAO .HCM','0843132202','CNTT'),
		('SV002',N'NGUYEN THANH TUNG','Nam',N'140 CONG QUYNH .HCM','0581525678','CNTT'),
		('SV003',N'NGUYEN THANH LONG','Nam',N'112/4 CONG QUYNH .HCM','0918345623','TOAN'),
		('SV004',N'HOANG THI HOA','Nu',N'90 NG VAN CU .HCM','0988320123','CNTT'),
		('SV005',N'TRAN HONG SON','Nam',N'54 CAO THANG .HA NOI','0928345987','TOAN')
INSERT INTO GIAOVIEN 
VALUES ('GV01','PHAM THI THAO','CNTT'),
	   ('GV02','LAM HOANG VU','TOAN'),
	   ('GV03','TRAN VAN TIEN','CNTT'),
	   ('GV04','HOANG VUONG','CNTT')
INSERT INTO MONHOC
VALUES ('CSDL','CO SO DU LIEU','3'),
	   ('CTDL','CAU TRUC DU LIEU','4'),
	   ('KTLT','KY THUAT LAP TRINH','5'),
	   ('CWIN','LAP TRINH C TREN WINDOW','4')
INSERT INTO GIANGDAY
VALUES ('K1','GV01','CSDL',1,2021),
	   ('K2','GV04','KTLT',2,2020),
	   ('K3','GV03','CTDL',1,2020),
	   ('K4','GV04','CWIN',1,2020),
	   ('K5','GV01','CSDL',1,2021)
INSERT INTO KETQUA
VALUES ('SV001','K1',8.5),
('SV002','K3',7.0),
('SV003','K4',7.5),
('SV001','K2',9.0),
('SV004','K3',6.0),
('SV005','K3',7.0),
('SV002','K1',7.0),
('SV003','K2',8.5),
('SV005','K5',7.0),
('SV004','K4',2.0)

--BÀI TẬP QLSV(Bài tập chương 4- Bài Tập 1)
-- Phần Cơ Bản --
-- CÂU 1: Cho biết tên, địa chỉ, số điện thoại từ bảng sinh viên
Select Ten,Diachi,Dienthoai
From SINHVIEN
-- CÂU 2: Cho biết tên các môn học và số tín chỉ của từng môn học
Select TenMH,SoTC 
From MONHOC
-- CÂU 3: Cho biết kết quả học tập của sinh viên có Mã số "SV03"
SELECT MaSV, MaKhoaHoc, Diem
FROM KETQUA
WHERE MaSV='SV003'
-- CÂU 4:  Cho biết tên các môn học và số tín chỉ của những môn học có cấu trúc của mà học như sau: ký tự thứ 1 là "C", ký tự thứ 3 là “D”.
SELECT TenMH, SoTC
FROM MONHOC
WHERE MaMH LIKE 'C_D_'
-- CÂU 5: Cho biết giáo viên có ký tự thứ 3 là "A"
SELECT * FROM GIAOVIEN
WHERE SUBSTRING(TenGV, 3, 1) = 'A';
-- CÂU 6: Cho biết tên những môn học có chứ chữ "DU"
SELECT TenMH
FROM MONHOC
WHERE TenMH LIKE '%DU%'
-- CÂU 7: Cho biết tên các giáo viên có ký tự đầu của họ và tên là "P" và "L"
SELECT TenGV
FROM GIAOVIEN
WHERE LEFT(TenGV, 1) IN ('P', 'L');
-- CÂU 8: Cho biết tên, địa chỉ của những sinh viên có địa chỉ trên đường "Cống Quỳnh"
SELECT Ten, DiaChi
FROM SINHVIEN
WHERE DiaChi LIKE '%CONG QUYNH%'
-- CÂU 9: Cho biết danh sách các môn học được dạy trong năm 2020
SELECT DISTINCT MONHOC.TENMH
FROM MONHOC
JOIN GIANGDAY ON MONHOC.MAMH=GIANGDAY.MAMH
WHERE GIANGDAY.Nam=2020;
-- CÂU 10: Cho biết mã, tên, địa chỉ của các sinh viên theo từng khoa sắp xếp theo thứ tự A-Z của tên sinh viên
SELECT MSSV, Ten, DiaChi, MaKhoa
From SINHVIEN
Order by MaKhoa, Ten
-- CÂU 11: Cho biết điểm của các sinh viên theo từng môn học
Select SINHVIEN.Ten, MONHOC.TenMH,KETQUA.Diem
From SINHVIEN, MONHOC, KETQUA, GIANGDAY
Where SINHVIEN.MSSV = KETQUA.MaSV AND KETQUA.MaKhoaHoc = GIANGDAY.MaKhoaHoc AND MONHOC.MaMH = GIANGDAY.MaMH
-- CÂU 12: Cho biết các sinh viên học môn 'CSDL' có điểm từ 8 đến 10
Select c.MaSV, Diem 
From GIANGDAY d join KETQUA c on d.MaKhoaHoc= c.MaKhoaHoc
Where (Diem between 8 and 10) and MaMH='CSDL'
-- CÂU 13: Cho biết bảng điểm của sinh viên có tên là TUNG
--Cách 1:
SELECT SINHVIEN.Ten, MONHOC.TenMH, KETQUA.Diem
FROM SINHVIEN
JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MaSV
JOIN GIANGDAY ON KETQUA.MaKhoaHoc = GIANGDAY.MaKhoaHoc
JOIN MONHOC ON GIANGDAY.MaMH = MONHOC.MaMH
WHERE SINHVIEN.Ten LIKE N'%TUNG';
--Cách 2:
Select Ten, Diem, MaMH 
From KETQUA a inner join GIANGDAY b on a.MaKhoaHoc = b.MaKhoaHoc
			 inner join SINHVIEN c on c.MSSV = a.MaSV
Where  Ten like '%TUNG%'
-- CÂU 14: Cho biết tên khoa, tên môn học mà những sinh viên trong khoa đã học
Select distinct TenKhoa,TenMH
From GIANGDAY a inner join MONHOC b on a.MaMH= b.MaMH
				inner join KETQUA c on c.MaKhoaHoc= a.MaKhoaHoc
				inner join SINHVIEN d on d.MSSV=c.MaSV
				inner join KHOA e on e.MaKhoa=d.MaKhoa
-- CÂU 15: Cho biết tên khoa, mã khóa học mà giáo viên của khoa có tham gia giảng dạy
SELECT KHOA.TenKhoa, GiangDay.MaKhoaHoc
FROM KHOA INNER JOIN GIAOVIEN ON KHOA.MaKhoa = GIAOVIEN.MaKhoa
		  JOIN GIANGDAY ON GIANGDAY.MaGV = GIAOVIEN.MaGV
-- CÂU 16: Cho biết tên sinh viên đã học môn CSDL, CTDL
Select distinct Ten
From  SINHVIEN a inner join KETQUA b on a.MSSV= b.MaSV
				 inner join GIANGDAY c on c.MaKhoaHoc= b.MaKhoaHoc
Where MaMH in('CSDL', 'CTDL')
Group by Ten, MaMH
Having count(MaMH)=2;
-- CÂU 17: Cho biết tên những giáo viên tham gia giảng dạy môn "Ki thuat lap trinh".
SELECT DISTINCT GIAOVIEN.TenGV
FROM GIAOVIEN
JOIN GIANGDAY ON GIANGDAY.MaGV = GIAOVIEN.MaGV
JOIN MONHOC ON GIANGDAY.MaMH = MONHOC.MaMH
WHERE MONHOC.TenMH = 'KY THUAT LAP TRINH'
-- CÂU 18: Cho biết môn học mà giáo viên "Tran Van Tien" tham gia giảng dạy trong học kỳ 1 năm 2020
SELECT MONHOC.TenMH
FROM GIAOVIEN
JOIN GIANGDAY ON GIAOVIEN.MaGV = GIANGDAY.MaGV
JOIN MONHOC ON GIANGDAY.MaMH = MONHOC.MaMH
WHERE GIAOVIEN.TenGV = N'Tran Van Tien' AND GIANGDAY.HocKy = 1 AND GIANGDAY.Nam = 2020;
-- CÂU 19: Cho biết mã, tên các sinh viên có kết quả 1 môn học nào đó trên 8 điểm 
Select distinct MSSV, Ten
From SINHVIEN a , MONHOC b , GIANGDAY c, KETQUA d
Where (a.MSSV=d.MaSV and c.MaMH= b.MaMH and c.MaKhoaHoc = d.MaKhoaHoc)
and d.Diem >= any (Select Diem From KETQUA Where Diem>8)
-- CÂU 20:Cho biết mã, tên các sinh viên có kết quả các môn học đều trên 8 điểm
Select distinct MSSV, Ten
From SINHVIEN a , MONHOC b , GIANGDAY c, KETQUA d
Where (a.MSSV=d.MaSV and c.MaMH= b.MaMH and c.MaKhoaHoc = d.MaKhoaHoc)
and d.Diem >= all ( select Diem from KETQUA where Diem>8)
-- Aggregate functions
-- CÂU 21: Có bao nhiêu sinh viên
SELECT COUNT(MSSV) SO_LUONG_SV FROM SINHVIEN
-- CÂU 22: Có bao nhiêu giáo viên
SELECT COUNT(MaGV) AS SO_LUONG_GV
FROM GIAOVIEN
-- CÂU 23: Có bao nhiêu sinh viên giới tính nữ và thuộc khoa "CNTT"
SELECT COUNT(*) AS SoLuongNuCNTT
FROM SINHVIEN
WHERE GioiTinh = 'Nu' AND MaKhoa = 'CNTT'
-- CÂU 24: Có bao nhiêu giáo viên khoa "CNTT"
SELECT COUNT (*) AS SoLuongGVcntt
FROM GIAOVIEN
WHERE MaKhoa = 'CNTT';
-- CÂU 25: Có bao nhiêu sinh viên học môn CSDL
SELECT COUNT(MaSV) AS SOLUONG 
FROM KETQUA, GIANGDAY 
WHERE KETQUA.MaKhoaHoc = GIANGDAY.MaKhoaHoc AND MaMH = 'CSDL'
-- CÂU 26: Có bao nhiêu môn học được giảng dạy trong học kỳ 1 trong năm 2021
SELECT DISTINCT COUNT(MaMH) AS SoLuongMonHoc
FROM GIANGDAY
where HocKy = 1 AND Nam = 2021;
-- CÂU 27: Cho biet diem trung binh cua sv co mssv = "sv04"
SELECT SUM(SOTC * DIEM) / SUM(SOTC) AS [DIEM TB]
FROM KETQUA KQ INNER JOIN GIANGDAY GD ON KQ.MAKHOAHOC = GD.MAKHOAHOC
			   INNER JOIN MONHOC MH ON GD.MAMH = MH.MAMH
WHERE KQ.MaSV = 'SV004'
-- CÂU 28: Cho biết mã, tên, địa chỉ và điểm trung bình của từng sinh viên
-- Cách 1
SELECT SINHVIEN.MSSV, SINHVIEN.Ten, SINHVIEN.diachi, AVG(KETQUA.Diem) as DiemTrungBinh
FROM SINHVIEN
JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MaSV
GROUP BY SINHVIEN.MSSV, SINHVIEN.Ten, SINHVIEN.diachi
-- Cách 2
SELECT MSSV,TEN,DIACHI,sum (mh.SoTC*kq.Diem)/sum(mh.SoTC) as [DiemTB]
FROM SINHVIEN sv, KETQUA kq, GIANGDAY gd, MONHOC mh
WHERE SV.MSSV = KQ.MASV AND gd.MAKHOAHOC=kq.MAKHOAHOC 
AND gd.MAMH = mh.MAMH
GROUP BY MSSV,TEN,DIACHI
-- CÂU 29: Cho biet so luong diem >=8 cua tung sv
Select sv.MSSV, count(kq.Diem) as [So luong diem >=8]
From KETQUA kq inner join SINHVIEN sv on kq.MaSV=sv.MSSV
Where kq.Diem >=8
Group by sv.MSSV
-- CÂU 30: Cho biết tên khoa, số lượng sinh viên có trong từng khoa
SELECT KHOA.TenKhoa, COUNT(SINHVIEN.MSSV) AS SoLuongSinhVien 
FROM KHOA JOIN SINHVIEN ON KHOA.MaKhoa = SINHVIEN.MaKhoa 
GROUP BY KHOA.TenKhoa;
-- CÂU 31: Cho biết tên khoa, số lượng khóa học mà giáo viên của khoa có tham gia giảng dạy
Select c.TenKhoa, a.MaGV, a.TenGV, Count(b.MaGV) as SoLuongKhoaHoc
From GIAOVIEN as a Join GIANGDAY as b on a.MaGV=b.MaGV 
	Join KHOA as c on c.MaKhoa=a.MaKhoa
Group by c.TenKhoa, a.MaGV, a.TenGV
-- CÂU 32: Cho biết tên tất cả sinh viên, điểm trung bình, số lượng khóa học đã tham gia
SELECT TEN, SUM(SOTC * DIEM) / SUM(SOTC) AS DIEMTRUNGBINH, 
COUNT(KETQUA.MAKHOAHOC) AS TONGKHOAHOC
FROM SINHVIEN INNER JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MASV 
		   INNER JOIN GIANGDAY ON KETQUA.MAKHOAHOC = GIANGDAY.MAKHOAHOC
		   INNER JOIN MONHOC ON GIANGDAY.MAMH = MONHOC.MAMH
GROUP BY TEN
-- CÂU 33: Cho biết số lượng tín chỉ mà từng sinh viên đã tham gia
SELECT sv.MSSV, sv.Ten, SUM(mh.SoTC) AS 'SoLuongTinChi'
FROM SINHVIEN sv, MONHOC mh, KETQUA kq, GIANGDAY gd
Where sv.MSSV = kq.MaSV and  gd.MaMH = mh.MaMH and kq.MaKhoaHoc = gd.MaKhoaHoc
GROUP BY sv.MSSV, sv.Ten;
-- Having --
-- CÂU 34: Cho biết tên những sinh viên chỉ mới thi đúng 1 một môn
SELECT SINHVIEN.Ten 
FROM SINHVIEN
INNER JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MaSV
GROUP BY SINHVIEN.Ten
HAVING COUNT(KETQUA.Diem) = 1
-- CÂU 35: Cho biết mã, tên, điạ chỉ, và điểm của các sinh viên có dtb >8.5
-- Cách 1
Select SINHVIEN.MSSV, SINHVIEN.Ten, SINHVIEN.DiaChi, ROUND(avg(KETQUA.Diem),2) as GPA
From SINHVIEN
Join KETQUA on SINHVIEN.MSSV = KETQUA.MaSV
Group by MSSV, Ten, DiaChi
Having avg(Diem) > 8.5;
-- Cách 2
Select sv.MSSV, sv.Ten, sv.DiaChi, 
Sum(mh.SoTC * kq.Diem) / sum(mh.SoTC) as[Diem TB]
From SINHVIEN sv inner join KETQUA kq on sv.MSSV=kq.MaSV
				 inner join GIANGDAY gd on kq.MaKhoaHoc=gd.MaKhoaHoc
			     inner join MONHOC mh on mh.MaMH=gd.MaMH
Group by sv.MSSV, sv.Ten, sv.DiaChi
Having sum(mh.SoTC * kq.Diem) / sum(mh.SoTC) >8.5
/* CÂU 36:  Cho biết mã khóa học, học kỳ, năm, số lượng sv 
tham gia cua những khóa học có số lượng sv tham gia(da co diem)từ 2 đến 4 sv
*/
Select gd.MaKhoaHoc, gd.HocKy, gd.Nam, count(kq.MaSV) as [SLSV] 
From KETQUA kq inner join GIANGDAY gd on kq.MaKhoaHoc = gd.MaKhoaHoc
Group by  gd.MaKhoaHoc, gd.HocKy, gd.Nam
Having count(kq.MaSV) between 2 and 4
-- CÂU 37: Cho biết các sinh viên học cả 2 môn 'CSDL' và 'CTDL',có điểm của 1 trong 2 môn >=8
SELECT SV.MSSV, SV.Ten
FROM SINHVIEN SV JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
JOIN GIANGDAY GD ON KQ.MaKhoaHoc = GD.MaKhoaHoc 
JOIN MONHOC MH ON GD.MaMH = MH.MaMH
WHERE MH.TenMH IN ('CSDL', 'CTDL') AND KQ.DIEM >= 8
GROUP BY SV.MSSV, SV.Ten
HAVING COUNT(DISTINCT MH.TenMH) >= 2;
--Lớn/Nhỏ nhất
-- CÂU 38: Điểm cao nhất mà sinh viên đã đạt được trong các khóa học
select MaSV, max(kq.Diem) as[Diem cao nhat ma sinh vien dat duoc]
from KETQUA kq
Group By MaSV
-- CÂU 39: Trong các môn học số tín chỉ nhỏ nhất là bao nhiêu
SELECT MIN(SoTC) as TcMin FROM MONHOC
-- CÂU 40: Cho biết tên của môn học có số tín chỉ nhiều nhất 
SELECT TenMH, SoTC FROM MONHOC
WHERE SoTC = (SELECT MAX(SoTC) FROM MONHOC);
-- CÂU 41: Cho biết tên của khoa có số lượng CBGD ít nhất
SELECT TenKhoa
FROM KHOA
WHERE SL_CBGD = (SELECT MIN(SL_CBGD) FROM KHOA)
-- CÂU 42: Tên các sinh viên có điểm cao nhất trong môn 'Kỹ Thuật Lập Trình'
SELECT sv.TEN
FROM SINHVIEN sv JOIN KETQUA kq ON sv.MSSV = kq.MaSV
JOIN GIANGDAY gd ON kq.MaKhoaHoc = gd.MaKhoaHoc
JOIN MONHOC mh ON gd.MaMH = mh.MaMH
WHERE mh.TenMH = 'Ky Thuat Lap Trinh' 
AND kq.Diem = (SELECT MAX(Diem)FROM KETQUA JOIN GIANGDAY ON KETQUA.MaKhoaHoc = GIANGDAY.MaKhoaHoc 
WHERE MaMH = 'KTLT')
-- CAU 43: Cho biet thong tin sv co diem thi mon CSDL lon nhat
SELECT SV.MSSV, TEN, DIACHI
FROM SINHVIEN SV INNER JOIN KETQUA KQ ON SV.MSSV = KQ.MaSV
				 INNER JOIN GIANGDAY GD ON KQ.MAKHOAHOC = GD.MAKHOAHOC
WHERE MAMH = 'CSDL' AND DIEM = 
(SELECT MAX(DIEM) FROM KETQUA INNER JOIN GIANGDAY 
ON KETQUA.MAKHOAHOC = GIANGDAY.MAKHOAHOC WHERE MAMH = 'CSDL')
-- CÂU 44: Cho biết tên các môn học có nhiều sv tham gia nhất
Select mh.TenMH, count(kq.MaSV) as [SLSV]
From MONHOC mh, KETQUA kq, GIANGDAY gd
Where mh.MaMH= gd.MaMH and kq.MaKhoaHoc=gd.MaKhoaHoc
Group by mh.TenMH
Having count(kq.MaSV)>=all(select count(kq1.MaSV)
From MONHOC mh1, KETQUA kq1, GIANGDAY gd1
Where mh1.MaMH= gd1.MaMH and kq1.MaKhoaHoc=gd1.MaKhoaHoc
Group by mh1.TenMH)
-- CÂU 45 Đối với mỗi môn học cho biết tên và điểm các sinh viên có điểm cao nhất
select SINHVIEN.TEN,KETQUA.DIEM,MONHOC.TENMH
from SINHVIEN,KETQUA,MONHOC
where KETQUA.DIEM=(SELECT(MAX(KETQUA.DIEM)))
-- CÂU 46: Học kỳ nào có nhiều môn giảng dạy nhất
Select gd.HocKy, count(mh.MaMH) as[So mon hoc duoc day nhieu nhat]
From  GIANGDAY gd inner join  MONHOC mh on gd.MaMH=mh.MaMH
Group by gd.HocKy
Having  count(mh.MaMH) >= all
(Select count(mh1.MaMH) From  GIANGDAY gd1 Inner Join  MONHOC mh1 on gd1.MaMH=mh1.MaMH
Group by gd1.HocKy)
-- CÂU 47: Cho biết tên sv có nhiều điểm 7
Select sv.Ten, count(kq.Diem) as [SV co nhieu diem 7]
From SINHVIEN sv, KETQUA kq
Where sv.MSSV = kq.MaSV and kq.Diem =7
Group by sv.Ten
Having count(kq.Diem)>=all (Select count(kq1.Diem)
From SINHVIEN sv1, KETQUA kq1
Where sv1.MSSV = kq1.MaSV and kq1.Diem =7
Group by sv1.Ten)
-- CÂU 48: cho biết tên các sinh viên có số lượng tín chỉ nhiều nhất
SELECT SINHVIEN.TEN, SUM(MONHOC.SoTC) AS TongTC
FROM SINHVIEN
JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MaSV
JOIN GIANGDAY ON KETQUA.MaKhoaHoc = GIANGDAY.MaKhoaHoc
JOIN MONHOC ON GIANGDAY.MaMH = MONHOC.MaMH
GROUP BY SINHVIEN.TEN
HAVING SUM(MONHOC.SoTC) >= 
	ALL(SELECT SUM(MONHOC.SoTC)
	FROM SINHVIEN
    JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MaSV
    JOIN GIANGDAY ON KETQUA.MaKhoaHoc = GIANGDAY.MaKhoaHoc
    JOIN MONHOC ON GIANGDAY.MaMH = MONHOC.MaMH
    GROUP BY SINHVIEN.TEN)
-- CÂU 49:Cho biết tên môn học, tên sinh viên, điểm của các sinh viên học những môn học có số tín chỉ là thấp nhất
--Cách 1
SELECT TenMH,Ten,Diem
FROM (SELECT TenMH,Ten,Diem,SoTC
	FROM KETQUA A
	JOIN SINHVIEN B ON A.MaSV = B.MSSV
	JOIN GIANGDAY C ON A.MaKhoaHoc = C.MaKhoaHoc
	JOIN MONHOC D ON C.MaMH = D.MaMH) A,(SELECT MIN(SoTC) MIN_TC	
	FROM MONHOC) B
WHERE SoTC = MIN_TC
-- Cách  2
Select mh.TenMH, sv.Ten, kq.Diem, min(mh.SoTC) as[ Diem sv co tin chi thap]
From SINHVIEN sv Join KETQUA kq on kq.MaSV=sv.MSSV
				 Join GIANGDAY gd on gd.MaKhoaHoc=kq.MaKhoaHoc 
				 Join MONHOC mh on mh.MaMH= gd.MaMH
Where mh.SoTC = (Select min(mh.SoTC) From MONHOC mh)
Group by mh.TenMH,sv.Ten, kq.Diem
-- CÂU 50:  Cho biết tên giáo viên tham gia giảng dạy nhiều nhất
Select gv.TenGV,count(gd.MaKhoaHoc) as [So luong khoa hoc da day]
From GIAOVIEN gv, GIANGDAY gd
Where gv.MaGV=gd.MaGV
Group by gv.TenGV
Having count(gd.MaKhoaHoc) >= all( Select count(gd.MaKhoaHoc) 
From GIANGDAY gd Group by gd.MaGV)
-- Không/Chưa có(Not in và left/right join)
-- CÂU 51: Tên các giáo viên không tham gia giảng dạy trong năm 2021
Select gv.TenGV
From GIAOVIEN  gv Join GIANGDAY gd on gv.MaGV=gd.MaGV
Where gd.MaGV not in ( Select gd.MaGV From GIANGDAY gd Where gd.Nam=2021) 
-- CÂU 52: LIỆT KÊ CÁC MÔN HỌC KHÔNG ĐƯỢC TỔ CHỨC TRONG NĂM 2021 
-- Cách 1: Sử dụng NOT IN
SELECT MH.TenMH
FROM MONHOC MH , GIANGDAY GH
WHERE GH.MaMH = MH.MaMH AND gh.Nam not in (2021)

--Cách 2: Sử dụng toán tử !=
SELECT MH.TenMH, GD.Nam
FROM MONHOC MH , GIANGDAY GD
WHERE GD.MaMH = MH.MaMH AND GD.Nam !=2021

--Cách 3: Sử dụng Not in với truy vấn con
 select mh.TenMH
 from MONHOC mh join GIANGDAY gd on mh.MaMH = gd.MaMH
 where mh.MaMH not in					-- Điều kiện: Phủ định lại truy vấn con 
 (
	select distinct gd.MaMH				-- Chọn các mã môn học có năm giảng dạy là năm 2021
	from GIANGDAY gd 
	where gd.Nam=2021
 )
-- CÂU 53: Tên những khoa chưa có sinh viên theo học
SELECT DISTINCT KHOA.TenKhoa
FROM KHOA
WHERE KHOA.MaKhoa NOT IN (SELECT MaKhoa FROM SINHVIEN);
-- CÂU 54: Cho biết tên những môn học chưa được tổ chức cho các khóa học
SELECT DISTINCT MONHOC.TenMH
FROM MONHOC
WHERE MONHOC.MaMH NOT IN (SELECT MaMH FROM GIANGDAY);
-- CÂU 55: Cho biết tên sv chưa có điểm kiểm tra
SELECT Ten 
FROM SINHVIEN LEFT JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MaSV 
WHERE KETQUA.Diem IS NULL
-- CÂU 56: Cho biết tên những khoa không có sinh viên theo học
SELECT TENKHOA FROM KHOA 
WHERE MAKHOA NOT IN (SELECT MAKHOA FROM SINHVIEN);
-- CÂU 57: Tương tự, cho biết tên sinh viên, số lượng môn mà sinh viên chưa học
Select sv.Ten, COUNT(distinct gd.MaMH) as [So luong mon chua hoc]
From SINHVIEN sv cross join GIANGDAY gd
Left join KETQUA kq on kq.MaSV=sv.MSSV and gd.MaKhoaHoc=kq.MaKhoaHoc
Where kq.Diem is null
Group by sv.Ten
-- CÂU 58: Cho biết các sv chưa học môn ' LTC tren windowns'
Select distinct sv.Ten
From SINHVIEN sv
Where sv.MSSV not in (select kq.MaSV 
From  KETQUA kq join GIANGDAY gd on kq.MaKhoaHoc = gd.MaKhoaHoc
where gd.MaMH='CWIN')
-- CÂU 59: Cho biết tên tất cả các giáo viên cùng với số lượng khóa học mà từng giáo viên đã tham gia giảng dạy
Select gv.TenGV, count (gd.MaKhoaHoc) as[SL giang day]
From GIAOVIEN gv Join GIANGDAY gd on gv.MaGV = gd.MaGV
Group by gv.TenGV
-- Hợp/Giao/Trừ
-- CÂU 60: Cho biết tên sinh viên, tên môn học mà sinh viên chưa học
Select SINHVIEN.Ten, MONHOC.TenMH
From SINHVIEN, MONHOC
Except
(
	Select sv.Ten, mh.TenMH
	From SINHVIEN sv join KETQUA kq on sv.MSSV=kq.MaSV Join GIANGDAY gd on kq.MaKhoaHoc=gd.MaKhoaHoc 
	Join MONHOC mh on gd.MaMH=mh.MaMH
)
-- CÂU 61: Cho biết tên những giáo viên tham gia dạy đủ tất cả các môn học
SELECT GV.TENGV FROM GIAOVIEN GV 
WHERE NOT EXISTS (
	SELECT * FROM MONHOC
	WHERE MONHOC.MAMH NOT IN (
		SELECT GIANGDAY.MAMH FROM GIANGDAY
		WHERE GIANGDAY.MAGV = GV.MAGV));
-- CÂU 62: Cho biết tên môn học mà tất cả các giáo viên đều giảng dạy
Select distinct mh.TenMH
From GIANGDAY gd1,MONHOC mh
Where gd1.MaMH = mh.MaMH and 
not exists (
	Select gd.MaGV	
	From GIANGDAY gd
	Except
	Select gd2.MaGV
	From GIANGDAY gd2
	Where gd2.MaMH=mh.MaMH)
-- CÂU 63: Cho biết khóa học mà tất cả sinh viên đều tham gia
SELECT distinct kq.MaKhoaHoc
FROM KETQUA kq , SINHVIEN sv1
where sv1.MSSV = kq.MaSV and
	not exists
	(  select * from GIANGDAY gd
	   where not exists(
		select * from SINHVIEN sv2
		where sv2.MSSV = kq.MaSV and gd.MaKhoaHoc = sv2.Ten
	))
-- CÂU 64: Cho biết tên những sinh viên tham gia đầy đủ các khóa học
SELECT MSSV, Ten
FROM SINHVIEN
EXCEPT
SELECT MaSV, (SELECT Ten FROM SINHVIEN WHERE SINHVIEN.MSSV = MaSV) AS Ten
FROM KETQUA
GROUP BY MaSV
HAVING COUNT(DISTINCT MaKhoaHoc) < (SELECT COUNT(DISTINCT MaKhoaHoc) FROM GIANGDAY);
-- CÂU 65: LIỆT KÊ CÁC MÔN HỌC MÀ TẤT CẢ SINH VIÊN ĐỀU ĐÃ HỌC
SELECT distinct TenMH
FROM MONHOC MH JOIN GIANGDAY GD ON GD.MaMH = MH.MaMH   -- LẤY TÊN MÔN HỌC TRONG BẢNG MÔN HỌC
WHERE NOT EXISTS		--  ĐIỀU KIỆN: KHÔNG TÔN TẠI BẤT KỲ SINH VIÊN NÀO
(
	SELECT *				
	FROM SINHVIEN SV
	WHERE NOT EXISTS	--  KHÔNG CÓ KẾT QUẢ HỌC TẬP
	(
		SELECT *
		FROM KETQUA KQ
		WHERE SV.MSSV = KQ.MaSV AND KQ.MaKhoaHoc =GD.MaKhoaHoc
	)
)
-- CÂU 66: Cho biết tên sv đã học đủ tất cả các môn
-- Cách 1
Select distinct sv.Ten
From SINHVIEN sv Join KETQUA kq on sv.MSSV=kq.MaSV
Where  not exists
(
 Select * from MONHOC mh
 Where not exists
 (
   Select * From KETQUA kq2 Join GIANGDAY gd on gd.MaKhoaHoc = kq2.MaKhoaHoc
   Where mh.MaMH = gd.MaMH and sv.MSSV = kq2.MaSV
 )
)
-- Cách 2
SELECT SV.Ten
FROM SINHVIEN SV
WHERE NOT EXISTS (
    SELECT MH.MaMH
    FROM MONHOC MH
    WHERE NOT EXISTS (
        SELECT 1
        FROM GIANGDAY GD
        WHERE GD.MaMH = MH.MaMH
        AND GD.MaKhoaHoc IN (
            SELECT KQ.MaKhoaHoc
            FROM KETQUA KQ
            WHERE KQ.MaSV = SV.MSSV
        )
    )
);
-- CÂU 67  Cho biết tên sv đã học tất cả các môn mà sv0001 đã học
SELECT SV.Ten
FROM SINHVIEN SV
WHERE NOT EXISTS (
	SELECT * FROM SINHVIEN SV1 JOIN KETQUA KQ ON KQ.MaSV = SV1.MSSV
	JOIN GIANGDAY GD ON GD.MaKhoaHoc = KQ.MaKhoaHoc
	JOIN MONHOC MH ON MH.MaMH = GD.MaMH
	WHERE  SV1.MSSV = 'SV001' AND NOT EXISTS (
		SELECT *
		FROM KETQUA KQ1 JOIN GIANGDAY GD1 
		ON KQ1.MaKhoaHoc = GD1.MaKhoaHoc
		WHERE KQ1.MaSV = SV.MSSV AND GD1.MaMH = MH.MaMH))
-- CÂU 68: Cho biết tên các giáo viên dạy tất cả những môn học mà giáo viên ‘GV03’ đã dạy
select TenGV from GIAOVIEN where MaGV in(
SELECT R1.MaGV
FROM GIANGDAY R1
WHERE NOT EXISTS (
	SELECT S.MaKhoaHoc
	FROM GIANGDAY S
	WHERE S.MaGV='GV03' and NOT EXISTS (
		SELECT R2.MaKhoaHoc
		FROM GIANGDAY R2
		WHERE R2.MaKhoaHoc=S.MaKhoaHoc
		AND R1.MaGV=R2.MaGV )))
Except
(Select TenGV From GIAOVIEN Where MaGV='GV03')
-- Update
-- CÂU 69: Thêm các field SLMon(số lượng môn), DTB(điểm trung bình ), XL(xếp loại) vào table SINHVIEN
ALTER TABLE SINHVIEN
ADD SLMon INT,
DTB DECIMAL(3,1),
XL NVARCHAR(50);
-- CÂU 70: 
SELECT SLMon, DTB, XL,
		CASE
           WHEN DTB < 5 THEN 'Yếu'
           WHEN DTB >= 5 AND DTB < 6.5 THEN 'Trung bình'
           WHEN DTB >= 8 AND DTB < 9 THEN 'Giỏi'
           WHEN DTB >= 9 AND DTB <= 10 THEN 'Xuất sắc'
       END AS XepLoaiDTB
FROM SINHVIEN
-- Delete
-- CÂU 71: Xóa tất cả kết quả học tập của sinh viên 'SV002'
DELETE FROM KETQUA
WHERE MaSV = 'SV002'; 
-- CÂU 72: Xóa những sinh viên có điểm trung bình < 5
DELETE FROM SINHVIEN
WHERE MSSV IN (
  SELECT SINHVIEN.MSSV
  FROM SINHVIEN
  JOIN KETQUA ON SINHVIEN.MSSV = KETQUA.MaSV
  GROUP BY SINHVIEN.MSSV
  HAVING AVG(KETQUA.DIEM) < 5
);
-- CÂU 73: Xóa những khoa không có sinh viên theo học
DELETE FROM KHOA
WHERE MaKhoa NOT IN (SELECT DISTINCT MaKhoa FROM KETQUA);
--Bài tập chương 6 - bài tập 2
-- Câu 1a: Tạo thủ tục sp_Select_.. đối với các bảng:
-- Bảng SINHVIEN
CREATE PROCEDURE sp_ChonSV
    @Masv VARCHAR(10)
AS
BEGIN
    SELECT *
    FROM SINHVIEN
    WHERE MSSV = @Masv;
end
-- Bảng MONHOC
CREATE PROCEDURE sp_Select_ChonMonHoc
    @MaMH VARCHAR(10)
AS
BEGIN
    SELECT * FROM MONHOC
    WHERE MaMH = @MaMH;
END;
GO
--Bảng GIAOVIEN
CREATE PROCEDURE sp_Select_GiaoVien
    @MaGV VARCHAR(10)
AS
BEGIN
    SELECT * FROM GIAOVIEN
    WHERE MaGV = @MaGV;
END;
GO
-- Bảng GIANGDAY
CREATE PROCEDURE sp_Select_GiangDay
    @MaKhoaHoc VARCHAR(10)
AS
BEGIN
    SELECT * FROM GIANGDAY
    WHERE MaKhoaHoc = @MaKhoaHoc;
END;
GO
-- Bảng KHOA
CREATE PROCEDURE sp_Select_Khoa
    @MaKhoa VARCHAR(10)
AS
BEGIN
    SELECT * FROM KHOA
    WHERE MaKhoa = @MaKhoa;
END;
GO
-- Bảng KETQUA
CREATE PROCEDURE sp_Select_KetQua
    @MaSV VARCHAR(10),
    @MaKhoaHoc VARCHAR(5)
AS
BEGIN
    SELECT * FROM KETQUA
    WHERE MaSV = @MaSV AND MaKhoaHoc = @MaKhoaHoc;
END;
GO
-- Câu 2: Thực hiện tạo thủ tục sp_Insert_.. đối với các bảng:
-- Bảng SINHVIEN
CREATE PROC sp_Insert_SinhVien
    @Masv varchar(5),
    @Ten nvarchar(50),
    @GioiTinh varchar(5),
	@DiaChi		nvarchar(100),
	@DienThoai	Varchar(20),
	@MaKhoa		Varchar(10),
	@SoLuongMon int,
	@DTB decimal(3,1),
	@XepLoai nvarchar(50)
AS
BEGIN
    IF @Masv IS NULL OR @Masv = ''
    BEGIN
        PRINT N'Mã sinh viên là bắt buộc. Vui lòng nhập mã sinh viên.'
        RETURN
    END
	
    INSERT INTO SINHVIEN
    VALUES (@Masv,@Ten,@GioiTinh,@DiaChi,@DienThoai,@MaKhoa,@SoLuongMon,@DTB,@XepLoai)

    PRINT N'Thêm mới bảng kết quả thành công.'
END
--  Bảng MONHOC
CREATE PROCEDURE sp_Insert_MonHoc
    @MaMH VARCHAR(5),
    @TenMH NVARCHAR(50),
    @SoTC SMALLINT
AS
BEGIN
    IF @MaMH IS NULL
    BEGIN
        Print ('Mã môn học là bắt buộc.');
        RETURN;
    END

    INSERT INTO MONHOC (MaMH, TenMH, SoTC)
    VALUES (@MaMH, @TenMH, @SoTC);
END;
GO
-- Bảng GIAOVIEN
CREATE PROCEDURE sp_Insert_GiaoVien
    @MaGV VARCHAR(5),
    @TenGV NVARCHAR(50),
    @MaKhoa VARCHAR(10)
AS
BEGIN
    IF @MaGV IS NULL
    BEGIN
        Print ('Mã giáo viên là bắt buộc.');
        RETURN;
    END

    INSERT INTO GIAOVIEN (MaGV, TenGV, MaKhoa)
    VALUES (@MaGV, @TenGV, @MaKhoa);
END;
GO
-- Bảng GIANGDAY
CREATE PROCEDURE sp_Insert_GiangDay
    @MaKhoaHoc VARCHAR(5),
    @MaGV VARCHAR(5),
    @MaMH VARCHAR(5),
    @HocKy SMALLINT,
    @Nam INT
AS
BEGIN
    IF @MaKhoaHoc IS NULL
    BEGIN
        Print ('Mã khóa học là bắt buộc.', 16, 1);
        RETURN;
    END

    INSERT INTO GIANGDAY (MaKhoaHoc, MaGV, MaMH, HocKy, Nam)
    VALUES (@MaKhoaHoc, @MaGV, @MaMH, @HocKy, @Nam);
END;
GO
-- Bảng KHOA
CREATE PROCEDURE sp_Insert_Khoa
    @MaKhoa VARCHAR(10),
    @TenKhoa NVARCHAR(50),
    @SL_CBGD SMALLINT
AS
BEGIN
    IF @MaKhoa IS NULL
    BEGIN
        Print ('Mã khoa là bắt buộc.');
        RETURN;
    END

    INSERT INTO KHOA (MaKhoa, TenKhoa, SL_CBGD)
    VALUES (@MaKhoa, @TenKhoa, @SL_CBGD);
END;
GO
-- Bảng KETQUA
CREATE PROCEDURE sp_Insert_KetQua
    @MaSV VARCHAR(5),
    @MaKhoaHoc VARCHAR(5),
    @Diem DECIMAL(3,1)
AS
BEGIN
    IF @MaSV IS NULL OR @MaKhoaHoc IS NULL
    BEGIN
        Print ('Mã sinh viên và mã khóa học là bắt buộc.');
        RETURN;
    END
    INSERT INTO KETQUA (MaSV, MaKhoaHoc, Diem)
    VALUES (@MaSV, @MaKhoaHoc, @Diem);
END;
GO
-- Câu 3: Thực hiện tạo thủ tục:sp_Update_... sửa thông tin, nếu biến nào khác NULL thì mới cập nhật đối với các bảng
-- Bảng SINHVIEN
CREATE PROCEDURE sp_Update_SinhVien
    @Masv VARCHAR(5),
    @Ten NVARCHAR(50) = NULL,
    @GioiTinh VARCHAR(5) = NULL, 
    @DiaChi NVARCHAR(100) = NULL,
    @DienThoai VARCHAR(20) = NULL,
    @MaKhoa VARCHAR(10) = NULL,
    @SLM INT = NULL,
    @DTB DECIMAL(3,1) = NULL,
    @XL NVARCHAR(50) = NULL
AS
BEGIN
    UPDATE SINHVIEN
    SET 
        Ten = ISNULL(@Ten, Ten),
        GioiTinh = ISNULL(@GioiTinh, GioiTinh),
        DiaChi = ISNULL(@DiaChi, DiaChi),
        DienThoai = ISNULL(@DienThoai, DienThoai),
        MaKhoa = ISNULL(@MaKhoa, MaKhoa),
        SLMon = ISNULL(@SLM, SLMon),
        DTB = ISNULL(@DTB, DTB),
        XL = ISNULL(@XL, XL)
    WHERE MSSV = @Masv;
END
-- Bảng MONHOC
CREATE PROCEDURE sp_Update_MONHOC
@MaMH Varchar(5), @TenMH_Moi Nvarchar(50), @SoTC_Moi Smallint
AS
BEGIN
    IF @MaMH IS NULL OR @TenMH_Moi IS NULL OR @SoTC_Moi IS NULL
    BEGIN
        Print('Vui lòng cung cấp đầy đủ thông tin!');
        RETURN;
    END
    UPDATE MONHOC
    SET TenMH = @TenMH_Moi,
        SoTC = @SoTC_Moi
    WHERE MaMH = @MaMH;
END
-- Bảng GIAOVIEN
CREATE PROCEDURE sp_Update_GIAOVIEN
@MaGV Varchar(5),
@TenGV_Moi Nvarchar(50),
@MaKhoa_Moi Varchar(10)
AS
BEGIN
    IF @MaGV IS NULL OR @TenGV_Moi IS NULL OR @MaKhoa_Moi IS NULL
    BEGIN
        Print('Vui lòng cung cấp đầy đủ thông tin!');
        RETURN;
    END
    UPDATE GIAOVIEN
    SET TenGV = @TenGV_Moi,
        MaKhoa = @MaKhoa_Moi
    WHERE MaGV = @MaGV;
END
-- Bảng GIANGDAY
CREATE PROCEDURE sp_Update_GIANGDAY
    @MaKhoaHoc Varchar(5),
    @MaGV Varchar(5),
    @MaMH Varchar(5),
    @HocKy_Moi Smallint,
    @Nam_Moi Smallint
AS
BEGIN
    IF @MaKhoaHoc IS NULL OR @MaGV IS NULL OR @MaMH IS NULL OR @HocKy_Moi IS NULL OR @Nam_Moi IS NULL
    BEGIN
        Print('Vui lòng cung cấp đầy đủ thông tin!');
        RETURN;
    END
    -- Kiểm tra xem mã khóa học, mã giáo viên, mã môn học đã tồn tại hay chưa
    IF EXISTS (SELECT * FROM GIANGDAY WHERE MaKhoaHoc = @MaKhoaHoc AND MaGV = @MaGV AND MaMH = @MaMH)
    BEGIN
        -- Cập nhật thông tin giảng dạy
        UPDATE GIANGDAY
        SET HocKy = @HocKy_Moi,
            Nam = @Nam_Moi
        WHERE MaKhoaHoc = @MaKhoaHoc AND MaGV = @MaGV AND MaMH = @MaMH;
        Print ('Cập nhật thông tin giảng dạy thành công!')
    END
    ELSE
        Print ('Mã khóa học, mã giáo viên, mã môn học không tồn tại!')
END
-- Bảng KHOA
CREATE PROCEDURE sp_Update_Khoa
@MaKhoa Varchar(10),
@TenKhoa_Moi Nvarchar(50),
@SL_CBGD_Moi Smallint
AS
BEGIN
    IF @MaKhoa IS NULL OR @TenKhoa_Moi IS NULL OR @SL_CBGD_Moi IS NULL
    BEGIN
        RAISERROR('Vui lòng cung cấp đầy đủ thông tin!', 16, 1);
        RETURN;
    END

    UPDATE KHOA
    SET TenKhoa = @TenKhoa_Moi,
        SL_CBGD = @SL_CBGD_Moi
    WHERE MaKhoa = @MaKhoa;
END

-- Bảng KETQUA
CREATE PROCEDURE sp_Update_KETQUA
@MaSV Varchar(5),
@MaKhoaHoc Varchar(5),
@Diem_Moi Decimal(3,1)
AS
BEGIN
    IF @MaSV IS NULL OR @MaKhoaHoc IS NULL OR @Diem_Moi IS NULL
    BEGIN
        Print('Vui lòng cung cấp đầy đủ thông tin!');
        RETURN;
    END

    UPDATE KETQUA
    SET Diem = @Diem_Moi
    WHERE MaSV = @MaSV AND MaKhoaHoc = @MaKhoaHoc;
END

-- Câu 4: Thực hiện tạo thủ tục: sp_Delete_ Xóa thông tin dựa vào mã truyền vào đối với các bảng 
--Bảng SINHVIEN
CREATE PROCEDURE sp_Delete_SINHVIEN
@Masv varchar(5)
AS
BEGIN
    DELETE FROM SINHVIEN
    WHERE MSSV = @Masv
end
-- Bảng MONHOC
CREATE PROCEDURE sp_Delete_MONHOC
@MaMH Varchar(5)
AS
BEGIN
    DELETE MONHOC
    WHERE MaMH = @MaMH
END
-- Bảng GIAOVIEN
CREATE PROCEDURE sp_Delete_GIAOVIEN
@MaGV Varchar(5)
AS
BEGIN
    DELETE GIAOVIEN
    WHERE MaGV = @MaGV
END
-- Bảng GIANGDAY
CREATE PROCEDURE sp_Delete_GIANGDAY
@MaKhoaHoc Varchar(5)
AS
BEGIN
    DELETE GIANGDAY
    WHERE MaKhoaHoc = @MaKhoaHoc
END
-- Bảng KHOA
CREATE PROCEDURE sp_Delete_KHOA
@MaKhoa Varchar(5)
AS
BEGIN
    DELETE KHOA
    WHERE MaKhoa = @MaKhoa
END
-- Bảng KETQUA
CREATE PROCEDURE sp_Delete_KETQUA
@Masv varchar(5)
AS
BEGIN
    DELETE KETQUA
    WHERE MaSV = @Masv
END

