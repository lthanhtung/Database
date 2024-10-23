CREATE DATABASE QLHH

USE QLHH

CREATE TABLE KHACHHANG
(
    MAKHACHHANG     VARCHAR(10)     NOT NULL,
    TENCONGTY       NVARCHAR(100)	NOT NULL,
    TENGIAODICH     NVARCHAR(100)	NOT NULL,
    DIACHI          NVARCHAR(100)	NOT NULL,
    EMAIL           VARCHAR(20)		NOT NULL,
    FAX             VARCHAR(20)		NOT NULL,
	DIENTHOAI		 VARCHAR(20)	NOT NULL
    PRIMARY KEY(MAKHACHHANG)

)

CREATE TABLE NHANVIEN
(
    MANHANVIEN	VARCHAR(10)		NOT NULL,
    HO			NVARCHAR(30)	NOT NULL,
    TEN			NVARCHAR(20)	NOT NULL,
    NGAYSINH	DATE			NOT NULL,
    NGAYLAMVIEC DATE			NOT NULL,
    DIACHI NVARCHAR(100)		NOT NULL,
    DIENTHOAI   VARCHAR(20),
    LUONGCOBAN  MONEY			NOT NULL,
    PHUCAP  MONEY				NOT NULL,

    PRIMARY KEY (MANHANVIEN)
)

CREATE TABLE DONDATHANG
(
    SOHOADON    VARCHAR(10) NOT NULL,
    MAKHACHHANG VARCHAR(10) NOT NULL,
    MANHANVIEN  VARCHAR(10) NOT NULL,
    NGAYDATHANG DATETIME,
    NGAYGIAOHANG DATETIME,
    NGAYCHUYENHANG  DATETIME,
    NOIGIAOHANG NVARCHAR(100),
    
    PRIMARY KEY (SOHOADON),
    CONSTRAINT Fk_DDH1 FOREIGN KEY (MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG),
	CONSTRAINT Fk_DDH2 FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN)
)

CREATE TABLE LOAIHANG
(
    MALOAIHANG  VARCHAR(10)     NOT NULL,
    TENLOAIHANG NVARCHAR(100)   NOT NULL,

    PRIMARY KEY (MALOAIHANG)
)

CREATE TABLE NHACUNGCAP
(
	MACONGTY	VARCHAR(10)		NOT NULL,
	TENCONGTY	NVARCHAR(100)	NOT NULL,
	TENGIAODICH	NVARCHAR(100)	NOT NULL,
	DIACHI		NVARCHAR(100)	NOT NULL,
	DIENTHOAI	VARCHAR(20)		NOT NULL,
	FAX			VARCHAR(20)		NOT NULL,
	EMAIL		VARCHAR(20)		NOT NULL,

	PRIMARY KEY (MACONGTY)
)

CREATE TABLE MATHANG
(
    MAHANG      VARCHAR(10)     NOT NULL,
    TENHANG     NVARCHAR(100)   NOT NULL,
    MACONGTY    VARCHAR(10)     NOT NULL,
    MALOAIHANG  VARCHAR(10)     NOT NULL,
    SOLUONG     DECIMAL(10,2)   NOT NULL,
    DONVITINH   NVARCHAR(20)    NOT NULL,
    GIAHANG     MONEY,

    PRIMARY KEY (MAHANG),
    CONSTRAINT Fk_MH1 FOREIGN KEY(MALOAIHANG) REFERENCES LOAIHANG(MALOAIHANG),
	CONSTRAINT Fk_MH2 FOREIGN KEY(MACONGTY)	REFERENCES	NHACUNGCAP(MACONGTY)
)

CREATE TABLE CTDATHANG
(
	SOHOADON	VARCHAR(10)		NOT NULL,
	MAHANG		VARCHAR(10)		NOT NULL,
	GIABAN		MONEY,
	SOLUONG		DECIMAL(10,2)	NOT NULL,
	MUCGIAMGIA	DECIMAL(4,2)	NOT NULL

	PRIMARY KEY(SOHOADON, MAHANG),
	CONSTRAINT Fk_CT1	FOREIGN KEY(MAHANG)	REFERENCES MATHANG(MAHANG),
	CONSTRAINT Fk_CT2 FOREIGN KEY(SOHOADON) REFERENCES DONDATHANG(SOHOADON)

)

-- Chèn 5 bản ghi vào bảng KHACHHANG
INSERT INTO KHACHHANG (MAKHACHHANG, TENCONGTY, TENGIAODICH, DIACHI, EMAIL, FAX)
VALUES 
    ('KH01', N'Công ty A', N'Giao dịch A', N'Địa chỉ A', 'emailA@example.com', '12345678'),
    ('KH02', N'Công ty B', N'Giao dịch B', N'Địa chỉ B', 'emailB@example.com', '98765432'),
    ('KH03', N'Công ty C', N'Giao dịch C', N'Địa chỉ C', 'emailC@example.com', '45678912'),
    ('KH04', N'Công ty D', N'Giao dịch D', N'Địa chỉ D', 'emailD@example.com', '32165498'),
    ('KH05', N'Công ty E', N'Giao dịch E', N'Địa chỉ E', 'emailE@example.com', '78945612');

-- Chèn 5 bản ghi vào bảng NHANVIEN
INSERT INTO NHANVIEN (MANHANVIEN, HO, TEN, NGAYSINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONGCOBAN, PHUCAP)
VALUES 
    ('NV01', N'Nguyễn', N'VănTài', '1990-01-01', '2022-01-01', N'Địa chỉ NV01', '123456789', 10000000, 2000000),
    ('NV02', N'Trần', N'Thị Thanh Trúc', '1995-02-02', '2022-02-02', N'Địa chỉ NV02', '987654321', 8000000, 1500000),
    ('NV03', N'Lê', N'Thành Công', '1992-03-03', '2022-03-03', N'Địa chỉ NV03', '456789123', 9000000, 1800000),
    ('NV04', N'Huỳnh', N'Quang Đức', '1994-04-04', '2022-04-04', N'Địa chỉ NV04', '321654987', 11000000, 2500000),
    ('NV05', N'Phạm', N'Thị Ánh Tuyết', '1991-05-05', '2022-05-05', N'Địa chỉ NV05', '789456123', 9500000, 2000000);

-- Chèn 5 bản ghi vào bảng DONDATHANG
INSERT INTO DONDATHANG (SOHOADON, MAKHACHHANG, MANHANVIEN, NGAYDATHANG, NGAYGIAOHANG, NGAYCHUYENHANG, NOIGIAOHANG)
VALUES 
    ('DH01', 'KH01', 'NV01', '2022-01-01', '2022-01-05', '2022-01-10', N'Nơi giao hàng 01'),
    ('DH02', 'KH02', 'NV02', '2022-02-01', '2022-02-05', '2022-02-10', N'Nơi giao hàng 02'),
    ('DH03', 'KH03', 'NV03', '2022-03-01', '2022-03-05', '2022-03-10', N'Nơi giao hàng 03'),
    ('DH04', 'KH04', 'NV04', '2022-04-01', '2022-04-05', '2022-04-10', N'Nơi giao hàng 04'),
    ('DH05', 'KH05', 'NV05', '2022-05-01', '2022-05-05', '2022-05-10', N'Nơi giao hàng 05');

-- Chèn 5 bản ghi vào bảng LOAIHANG
INSERT INTO LOAIHANG (MALOAIHANG, TENLOAIHANG)
VALUES 
    ('LH01', N'Thực Phẩm'),
    ('LH02', N'Loại hàng B'),
    ('LH03', N'Loại hàng C'),
    ('LH04', N'Loại hàng D'),
    ('LH05', N'Loại hàng E');

-- Chèn 5 bản ghi vào bảng NHACUNGCAP
INSERT INTO NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL)
VALUES 
    ('CC01', N'Việt Tiến', N'Giao dịch C', N'Địa chỉ C', '987654321', '99999999', 'emailC@example.com'),
    ('CC02', N'Công ty D', N'Giao dịch D', N'Địa chỉ D', '123456789', '11111111', 'emailD@example.com'),
    ('CC03', N'Công ty E', N'Giao dịch E', N'Địa chỉ E', '456789123', '22222222', 'emailE@example.com'),
    ('CC04', N'Công ty F', N'Giao dịch F', N'Địa chỉ F', '789456123', '33333333', 'emailF@example.com'),
    ('CC05', N'Công ty G', N'Giao dịch G', N'Địa chỉ G', '321654987', '44444444', 'emailG@example.com');

-- Chèn 5 bản ghi vào bảng MATHANG
INSERT INTO MATHANG (MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG)
VALUES 
    ('MH01', N'Hàng 1', 'CC01', 'LH01', 10, N'Cái', 50000),
    ('MH02', N'Hàng 2', 'CC02', 'LH02', 20, N'Cái', 70000),
    ('MH03', N'Hàng 3', 'CC03', 'LH03', 15, N'Cái', 60000),
    ('MH04', N'Hàng 4', 'CC04', 'LH04', 8, N'Cái', 45000),
    ('MH05', N'Hàng 5', 'CC05', 'LH05', 12, N'Cái', 55000);

-- Chèn 5 bản ghi vào bảng CTDATHANG
INSERT INTO CTDATHANG (SOHOADON, MAHANG, GIABAN, SOLUONG, MUCGIAMGIA)
VALUES 
    ('DH01', 'MH01', 45000, 5, 0.1),
    ('DH02', 'MH02', 65000, 2, 0.05),
    ('DH03', 'MH03', 55000, 3, 0),
    ('DH04', 'MH04', 40000, 4, 0.15),
    ('DH05', 'MH05', 50000, 6, 0.2);

-- Bài tập QLHH(Bài tập chương 4 - Bài Tập 3)
-- Lệnh Select
-- Câu 1: Cho biết danh sách các đối tác cung cấp hàng cho công ty
Select MACONGTY, TENCONGTY
From NHACUNGCAP
-- Câu 2: Cho biết mã hàng hóa, tên hàng hóa, và số lượng của các mặt hàng hiện có trong công ty
SELECT MAHANG, TENHANG, SOLUONG
FROM MATHANG;
-- Câu 3: Cho biết họ tên và địa chỉ và năm bắt đầu làm việc của các nhân viên trong công ty.
SELECT HO + ' ' + TEN AS 'HO TEN' , DIACHI, YEAR(NGAYLAMVIEC) AS 'Năm băt đầu làm'
FROM NHANVIEN
-- Câu 4: Cho biết địa chỉ và điện thoại của nhà cung cấp có tên giao dịch VINAMILK
Select DIACHI, DIENTHOAI
From NHACUNGCAP
Where TENGIAODICH ='VINAMILK'
-- Câu 5:Cho biết mã và tên các mặt hàng có giá >100000 vá số lượng hiện có ít hơn 50
Select MAHANG 'Mã hàng', TENHANG 'Tên mặt hàng', GIAHANG 'Giá' , SOLUONG 'Số lượng'
From MATHANG
Where GIAHANG > 100000
-- Câu 6: Cho biết mỗi mặt hàng trong công ty do ai cung cấp
SELECT mh.TENHANG, ncc.TENCONGTY
FROM MatHang mh Join NhaCungCap ncc on mh.MACONGTY = ncc.MACONGTY
-- Câu 7: Công ty Việt Tiến đã cung cấp những mặt hàng nào
SELECT mh.TENHANG
FROM MatHang mh Join NhaCungCap ncc on mh.MACONGTY = ncc.MACONGTY
WHERE ncc.TENCONGTY = N'Việt Tiến'
-- Câu 8: Loại hàng thực phẩm do những công ty nào cung cấp và địa chỉ của các công ty đó
SELECT mh.MALOAIHANG, ncc.TENCONGTY, ncc.DIACHI
FROM MATHANG mh Join NHACUNGCAP ncc on mh.MACONGTY = ncc.MACONGTY
Join LOAIHANG lh on mh.MALOAIHANG = lh.MALOAIHANG 
WHERE lh.TENLOAIHANG = 'Thực phẩm'
-- Câu 9: Những khách hàng nào(Tên giao dịch) đã đặt mua mặt hàng sữa hộp XYZ
SELECT kh.TenGiaoDich
FROM KhachHang kh Join DonDatHang ddh on kh.MaKhachHang = ddh.MaKhachHang
Join CTDATHANG ctdh on ddh.SOHOADON = ctdh.SOHOADON
Join MatHang mh on ctdh.MAHANG = mh.MAHANG
WHERE mh.TENHANG = N'Sữa hộp XYZ'
-- Câu 10: Cho biết đơn đặt hàng số 1 do ai đặt và do nhân viên nào lặp, thời gian và địa điểm giao hàng là ở đâu
Select nv.MANHANVIEN, HO + ' ' +TEN 'Họ tên nhân viên',ddh.NGAYGIAOHANG, ddh.NOIGIAOHANG
From NHANVIEN nv, DONDATHANG ddh
Where nv.MANHANVIEN = ddh.MANHANVIEN and ddh.SOHOADON='DH01'
-- Câu 11 Cho biết số tiền lương mà công ty phải trả cho mỗi nhân viên là bao nhiêu (lương = lương cơ bản + phụ cấp)
Select MANHANVIEN, HO + ' ' + TEN as 'Họ tên nhân viên', (LUONGCOBAN + PHUCAP) as 'Lương'
From NHANVIEN 
/*Câu 12:Cho biết đơn đặt hàng số 3 đã đặt mua những mặt hàng nào và số tiền mà khách hàng phải trả cho mỗi mặt hàng là bao nhiêu 
(TIENPHAITRA = SOLUONGxGIABAN-SOLUONGxGIABANxMUCGIAMGIA/100):
*/
SELECT DH.SOHOADON,CT.MAHANG,MH.TENHANG,CT.SOLUONG,
    CT.GIABAN,CT.MUCGIAMGIA,
   (CT.SOLUONG * CT.GIABAN - CT.SOLUONG * CT.GIABAN * CT.MUCGIAMGIA / 100) AS TIENPHAITRA
FROM DONDATHANG DH INNER JOIN CTDATHANG CT ON DH.SOHOADON = CT.SOHOADON
	INNER JOIN MATHANG MH ON CT.MAHANG = MH.MAHANG
WHERE DH.SOHOADON = 'DH03'
-- Câu 13:  Hãy cho biết những khách hàng nào lại chính là đối tác cung cấp hàng cho công ty (tức là có cùng tên giao dịch).
Select kh.MAKHACHHANG,kh.TENGIAODICH, kh.TENCONGTY
From KHACHHANG kh Join NHACUNGCAP ncc on kh.TENCONGTY=ncc.TENCONGTY
-- Câu 14: Trong công ty có những nhân viên nào có cùng ngày sinh?
-- Cách 1:
SELECT  *
FROM NHANVIEN
WHERE DAY(NGAYSINH) IN  (
	SELECT DAY(NGAYSINH)
	FROM NHANVIEN
	GROUP BY DAY(NGAYSINH)
	HAVING COUNT(*) > 1
)
-- Cách 2:
Select nv1.HO + ' ' + nv1.TEN as HOTEN1, nv2.HO + ' ' + nv2.TEN as HOTEN2, nv1.NGAYSINH
From NHANVIEN nv1 join NHANVIEN nv2 on nv1.MANHANVIEN<>nv2.MANHANVIEN and nv1.NGAYSINH=nv2.NGAYSINH
-- Câu 15: Những đơn đặt hàng nào yêu cầu giao hàng ngay tại công ty đặt hàng và những đơn đó là của công ty nào
SELECT ddh.SOHOADON, ddh.MAKHACHHANG, kh.TENCONGTY AS 'Tên công ty'
FROM DONDATHANG ddh Join KHACHHANG kh on ddh.MAKHACHHANG = kh.MAKHACHHANG
WHERE ddh.NOIGIAOHANG = kh.DIACHI
-- Câu 16: Cho biết tên công ty, tên giao dịch, địa chỉ và điện thoại của các khách hàng và các nhà cung cấp hàng cho công ty
SELECT kh.TenCongTy, kh.TenGiaoDich, kh.DiaChi, kh.DIENTHOAI
FROM KhachHang kh
UNION
SELECT ncc.TenCongTy, ncc.TENGIAODICH, ncc.DIACHI, ncc.DIENTHOAI
FROM NhaCungCap ncc
-- Câu 17: Cho biết những mặt hàng nào chưa từng được khách hàng đặt mua
SELECT MH.TENHANG
FROM MATHANG MH
LEFT JOIN CTDATHANG CTDH ON MH.MAHANG = CTDH.MAHANG
WHERE CTDH.MAHANG IS NULL;
-- Câu 18: Những nhân viên nào của công ty chưa từng lập bất kì một hóa đơn nào
SELECT NHANVIEN.MANHANVIEN, NHANVIEN.HO, NHANVIEN.TEN
FROM NHANVIEN
LEFT JOIN DONDATHANG ON NHANVIEN.MANHANVIEN = DONDATHANG.MANHANVIEN
WHERE DONDATHANG.MANHANVIEN IS NULL
-- Câu 19: Những nhân viên có mức lương cơ bản cao nhất
-- Cách 1:
SELECT MANHANVIEN, HO + ' ' + TEN AS 'Họ tên nhân viên'
FROM NHANVIEN
WHERE LUONGCOBAN = (SELECT MAX(LUONGCOBAN) FROM NHANVIEN)
-- Cách 2:
SELECT TOP 1 MANHANVIEN, HO + ' ' + TEN AS 'Họ tên nhân viên'
FROM NHANVIEN
GROUP BY MANHANVIEN, HO + ' ' + TEN
ORDER BY MAX(LUONGCOBAN) DESC
-- Câu 20: Tổng số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng là bao nhiêu
SELECT D.SOHOADON, SUM(CTD.GIABAN * CTD.SOLUONG * (1 - CTD.MUCGIAMGIA)) AS TONGTIEN
FROM DONDATHANG D
JOIN CTDATHANG CTD ON D.SOHOADON = CTD.SOHOADON
GROUP BY D.SOHOADON;
-- Câu 21 Trong năm 2021, những mặt hàng nào chỉ được đặt đúng 1 lần
SELECT ctdh.MAHANG, mh.TENHANG
FROM CTDATHANG ctdh Join DonDatHang ddh on ctdh.SOHOADON = ddh.SOHOADON
Join MatHang mh on ctdh.MAHANG = mh.MAHANG
WHERE YEAR(ddh.NGAYDATHANG) = 2021
GROUP BY ctdh.MAHANG, mh.TENHANG
HAVING COUNT(*) = 1
-- Câu 22: Cho biết mỗi một khách hàng đã phải bỏ ra bao nhiêu tiền để đặt mua hàng
SELECT DONDATHANG.MAKHACHHANG, SUM(CTDATHANG.GIABAN * CTDATHANG.SOLUONG) AS TONGTIEN
FROM DONDATHANG
JOIN CTDATHANG ON DONDATHANG.SOHOADON = CTDATHANG.SOHOADON
GROUP BY DONDATHANG.MAKHACHHANG;
/*Câu 23: Mỗi một nhân viên của công ty đã lập bao nhiêu đơn đặt hàng 
(Nếu nhân viên chưa hề lập một hóa đơn nào  thì cho kết quả là 0)
*/
SELECT nv.MaNhanVien, nv.HO + ' ' + nv.TEN as 'Họ tên nhân viên', COUNT(ddh.SOHOADON) AS 'SoLuongDonDatHang'
FROM NhanVien nv
LEFT Join DonDatHang ddh on nv.MaNhanVien = ddh.MaNhanVien
GROUP BY nv.MaNhanVien, nv.HO+ ' ' + nv.TEN
-- Câu 24: Cho biết tổng số tiền hàng mà cửa hàng thu được trong mỗi tháng của năm 2021(thời gian được tính theo ngày đặt hàng)
SELECT MONTH(ddh.NGAYDATHANG) AS THANG,YEAR(ddh.NGAYDATHANG) AS NAM, SUM(ct.GIABAN * ct.SOLUONG) AS TONGTIEN
FROM DONDATHANG ddh
JOIN CTDATHANG ct ON ddh.SOHOADON = ct.SOHOADON
WHERE YEAR(ddh.NGAYDATHANG) = 2021
GROUP BY MONTH(ddh.NGAYDATHANG), YEAR(ddh.NGAYDATHANG)
ORDER BY NAM, THANG
-- Câu 25: Hãy cho biết tổng số tiền lời mà công ty thu được từ mỗi mặt hàng trong năm 2021
SELECT MATHANG.TENHANG AS TenMatHang,
       SUM((CTDATHANG.GIABAN - MATHANG.GIAHANG) * CTDATHANG.SOLUONG * (1 - CTDATHANG.MUCGIAMGIA / 100)) AS TongLoi
FROM CTDATHANG
JOIN MATHANG ON CTDATHANG.MAHANG = MATHANG.MAHANG
JOIN DONDATHANG ON CTDATHANG.SOHOADON = DONDATHANG.SOHOADON
WHERE YEAR(DONDATHANG.NGAYDATHANG) = 2021
GROUP BY MATHANG.TENHANG;
-- Câu 26: Hãy cho biết tổng số lượng hàng hiện có và đã bán
Select mh.MAHANG, sum(mh.SOLUONG) as 'Số lượng hiện có', sum(mh.SOLUONG - ct.SOLUONG) as [Số lượng đã bán]
From MATHANG mh Join CTDATHANG ct on mh.MAHANG=ct.MAHANG
Join DONDATHANG dh on ct.SOHOADON=dh.SOHOADON
Group by mh.MAHANG
-- Câu 27: Nhân viên nào của công ty bán được số lượng mặt hàng nhiều nhất và số lượng mặt hàng bán được của nhân viên là bao nhiêu
SELECT Top 1 NHANVIEN.MANHANVIEN 'Mã nhân viên', NHANVIEN.HO +' ' + NHANVIEN.TEN 'Họ tên nhân viên', SUM(CTDATHANG.SOLUONG) AS TONGSOLUONG
FROM NHANVIEN
JOIN DONDATHANG ON NHANVIEN.MANHANVIEN = DONDATHANG.MANHANVIEN
JOIN CTDATHANG ON DONDATHANG.SOHOADON = CTDATHANG.SOHOADON
GROUP BY NHANVIEN.MANHANVIEN, NHANVIEN.HO, NHANVIEN.TEN
ORDER BY TONGSOLUONG DESC
-- Câu 28: Đơn đặt hàng nào có số lượng mặt hàng được đặt mua ít nhất
-- Cách 1:
SELECT Top 1
  ddh.SOHOADON,
  kh.MAKHACHHANG,
  SUM(ctdh.SOLUONG) AS SOLUONG
FROM CTDATHANG ctdh
INNER JOIN DONDATHANG ddh ON CTDH.SOHOADON = ddh.SOHOADON
INNER JOIN KHACHHANG kh ON ddh.MAKHACHHANG = kh.MAKHACHHANG
GROUP BY ddh.SOHOADON, kh.MAKHACHHANG
ORDER BY SOLUONG ASC
-- Cách 2:
SELECT Top 1 DONDATHANG.SOHOADON, DONDATHANG.MAKHACHHANG
FROM DONDATHANG
JOIN CTDATHANG ON DONDATHANG.SOHOADON = CTDATHANG.SOHOADON
GROUP BY DONDATHANG.SOHOADON, DONDATHANG.MAKHACHHANG
ORDER BY SUM(CTDATHANG.SOLUONG) ASC
-- Câu 29: Số tiền nhiều nhất mà khách hàng đã bỏ ra để đặt hàng trong các đơn đặt hàng là bao nhiêu
Select Top 1 with ties Sum(ct.SOLUONG*ct.GIABAN-ct.SOLUONG*ct.GIABAN*ct.MUCGIAMGIA/100)as [MAX TIEN]
From DONDATHANG dh Join CTDatHang ct on dh.SOHOADON=ct.SOHOADON
Order by 1 DESC
-- Câu 30: Thống kê số lượng bán được của các mặt hàng theo từng tháng và cả năm vào năm 2021
SELECT C.MAHANG, C.TENHANG, 
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 1 THEN B.SOLUONG ELSE 0 END) THANG_1,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 2 THEN B.SOLUONG ELSE 0 END) THANG_2,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 3 THEN B.SOLUONG ELSE 0 END) THANG_3,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 4 THEN B.SOLUONG ELSE 0 END) THANG_4,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 5 THEN B.SOLUONG ELSE 0 END) THANG_5,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 6 THEN B.SOLUONG ELSE 0 END) THANG_6,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 7 THEN B.SOLUONG ELSE 0 END) THANG_7,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 8 THEN B.SOLUONG ELSE 0 END) THANG_8,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 9 THEN B.SOLUONG ELSE 0 END) THANG_9,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 10 THEN B.SOLUONG ELSE 0 END) THANG_10,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 11 THEN B.SOLUONG ELSE 0 END) THANG_11,
SUM(CASE WHEN MONTH(A.NGAYDATHANG) = 12 THEN B.SOLUONG ELSE 0 END) THANG_12
FROM DONDATHANG A Join CTDATHANG B on A.SOHOADON = B.SOHOADON
Join MATHANG C on B.MAHANG = C.MAHANG
WHERE YEAR(A.NGAYDATHANG) = 2021
GROUP BY C.MAHANG, C.TENHANG
-- Lệnh Update
/* Câu 31: Cập nhật lại giá trị thị trường NGAYCHUYENHANG của những bảng ghi có 
NGAYCHUYENHANG chưa xác định (NULL) trong bảng DONDATHANG  bằng với giá trị của trường NGAYDATHANG */
UPDATE DONDATHANG 
SET NGAYCHUYENHANG = NGAYDATHANG 
WHERE NGAYCHUYENHANG IS NULL
-- Câu 32: Tăng số lượng hàng của những mặt hàng do công ty VINAMILk cung cấp lên gấp đôi
UPDATE MATHANG 
SET SOLUONG = SOLUONG * 2
WHERE MACONGTY = ( 
	SELECT MACONGTY 
	FROM NHACUNGCAP 
	WHERE TENCONGTY = 'VINAMILK')
/* Câu 33: Cập nhập giá trị trường NOIGIAOHANG trong bảng DONDATHANG bằng địa chỉ của khách hàng
đối với những đơn đặt hàng chưa xác định được nơi đặt hàng(giá trị trường NOIGIAOHANG = NULL) */
UPDATE DONDATHANG
SET NOIGIAOHANG = KHACHHANG.DIACHI
FROM DONDATHANG
JOIN KHACHHANG ON DONDATHANG.MAKHACHHANG = KHACHHANG.MAKHACHHANG
WHERE DONDATHANG.NOIGIAOHANG IS NULL
/* Câu 34: Cập nhật lại dữ liệu bảng KHACHHANG sao cho 
nếu tên công ty và tên giao dịch của khách hàng trùng với tên công ty và tên giao dịch của một nhà cung cấp nào đó thì
địa chỉ, điện thoại, fax và e-mail phải giống nhau */
UPDATE KHACHHANG
SET KHACHHANG.DIACHI = e.DIACHI, KHACHHANG.DIENTHOAI = e.DIENTHOAI, KHACHHANG.FAX = e.FAX,
KHACHHANG.EMAIL = e.EMAIL
FROM KHACHHANG a Join DONDATHANG b on a.MAKHACHHANG = b.MAKHACHHANG
Join CTDATHANG c on b.SOHOADON = c.SOHOADON 
Join MATHANG d on c.MAHANG = d.MAHANG
Join NHACUNGCAP e on d.MACONGTY = e.MACONGTY AND a.TENCONGTY = e.TENCONGTY AND a.TENGIAODICH = e.TENGIAODICH
-- Câu 35: Tăng lương lên gấp rưỡi cho những nhân viên bán được số lượng hàng nhiều hơn 100 trong năm 2018
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 1.5
WHERE MANHANVIEN IN (
    SELECT MANHANVIEN
    FROM DONDATHANG ddh Join CTDATHANG ctdh on ddh.SOHOADON = ctdh.SOHOADON
    WHERE ctdh.SOLUONG > 100 AND YEAR(ddh.NGAYGIAOHANG) = 2018);
-- Câu 36: Tăng phụ cấp bằng 50% lương cho những nhân viên bán được hàng nhiều nhất
Update NhanVien
Set PhuCap=PhuCap+LuongCoBan*0.5
Where MaNhanVien In (
	Select Top 1 With ties nv.MaNhanVien
	From NhanVien nv Join DonDatHang d on nv.MaNhanVien=d.MaNhanVien 
		Join CTDatHang c on c.SoHoaDon=d.SoHoaDon
	Group by nv.MaNhanVien
	Order by sum(c.SoLuong) desc
)
-- Câu 37: Giảm 25% lương của những nhân viên trong năm 2018 không lập được bất kỳ đơn hàng nào
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 0.75
WHERE MANHANVIEN IN (
    SELECT MANHANVIEN
    FROM NHANVIEN
    LEFT JOIN DonDatHang ON NHANVIEN.MANHANVIEN = DonDatHang.MANHANVIEN
    WHERE YEAR(DonDatHang.NgayDatHang) = 2018 OR DonDatHang.MANHANVIEN IS NULL
);
/* Câu 38: Giả sử trong bảng DONDATHANG có thêm trường SOTIEN cho biết 
số tiền mà khách hàng phải trả cho mỗi đơn hàng. Hãy tính giá trị cho trường này */
SELECT *, (GIABAN *MUCGIAMGIA * SOLUONG) AS SOTIEN
FROM CTDATHANG
-- Lệnh Delete
-- Câu 39: Xóa khỏi bảng nhân viên những nhân viên đã làm việc trong công ty quá  40 năm
 DELETE FROM NHANVIEN
 WHERE DATEDIFF(YY,NGAYLAMVIEC,GETDATE()) > 40
 -- Câu 40: Xóa những đơn đặt hàng trước năm 2022 ra khỏi cơ sở dữ liệu
 DELETE FROM DONDATHANG
 WHERE NGAYDATHANG < '2022-01-01'
-- Câu 41: Xóa khỏi bảng LOAIHANG những loại hàng hiện không có mặt hàng
DELETE FROM LOAIHANG
WHERE MALOAIHANG NOT IN (
    SELECT MALOAIHANG
    FROM MATHANG
);
-- Câu 42: Xóa khỏi bảng KHACHHANG những khách hàng hiện không có bất kì đơn đặt hàng nào cho công ty
 DELETE FROM KHACHHANG
WHERE MAKHACHHANG NOT IN (SELECT MAKHACHHANG FROM DONDATHANG)
-- Câu 43: Xóa khỏi bảng MATHANG những mặt hàng có số lượng bằng 0 và không được đặt mua trong bất kỳ đơn hàng nào
Delete From MATHANG
Where MATHANG.SOLUONG =0 and MAHANG not in(
	Select MAHANG
	From CTDATHANG
)
--Bài tập chương 6-Bài tập 1
/* Tạo thủ tục lưu trữ để thông qua thủ tục này có thể bổ sung thêm một bản ghi mới cho bảng MATHANG
(thủ tục phải thực hiện kiểm tra tính hợp lệ của dữ liệu cần bổ sung: không trùng khoá chính và đảm bảo toàn vẹn tham chiếu) */
CREATE PROCEDURE sp_ThemMatHang
    @MaMatHang VARCHAR(10),
    @TenMatHang NVARCHAR(50),
    @MaDanhMuc INT,
    @DonGia DECIMAL(10,2)
AS
BEGIN
    -- Kiểm tra tính hợp lệ của dữ liệu
    IF EXISTS (SELECT 1 FROM MATHANG WHERE MAHANG = @MaMatHang)
    BEGIN
        Print('Mã mặt hàng đã tồn tại');
        RETURN;
    END

    -- Kiểm tra tham chiếu tới bảng LOAIHANG
    IF NOT EXISTS (SELECT 1 FROM LOAIHANG WHERE MALOAIHANG = @MaDanhMuc)
    BEGIN
        Print('Mã danh mục không hợp lệ');
        RETURN;
    END

    -- Thêm mới bản ghi
    INSERT INTO MATHANG (MAHANG, TENHANG, MALOAIHANG, GIAHANG)
    VALUES (@MaMatHang, @TenMatHang, @MaDanhMuc, @DonGia);
END
/* Câu 2: Tạo thủ tục lưu trữ có chức năng thống kê tổng số lượng hàng 
bán được của một mặt hàng có mã bất kỳ (mã mặt hàng cần thống kê là tham số của thủ tục) */
CREATE PROCEDURE sp_ThongKeSL
    @MaHang Varchar(10)
AS
BEGIN
    SELECT SUM(SOLUONG) 'Số lượng bán được'
    FROM CTDATHANG
    WHERE MAHANG = @MaHang;
END
/* Câu 3: Viết hàm trả về một bảng trong đó cho biết tổng số lượng hàng bán được của mỗi mặt hàng.
Sử dụng hàm này để thống kê xem tổng số lượng hàng (hiện có và đã bán) của mỗi mặt hàng là bao nhiêu*/
CREATE FUNCTION fun_ThongKeSLBan()
RETURNS TABLE
AS
RETURN
(
    SELECT MAHANG, SUM(SOLUONG) 'Tổng số lượng bán'
    FROM CTDATHANG
    GROUP BY MAHANG
)
--Sử dụng hàm để thống kê xem tổng số lượng hàng (hiện có và đã bán) của mỗi mặt hàng
SELECT 
    mh.MAHANG, 
    mh.TENHANG, 
    mh.SOLUONG AS 'Tồn kho', 
    ISNULL(t.[Tổng số lượng bán], 0)  'Tổng số lượng bán',
    (mh.SOLUONG + ISNULL(t.[Tổng số lượng bán], 0))  'Tổng số lượng'
FROM MATHANG mh
LEFT JOIN fun_ThongKeSLBan() t ON mh.MAHANG = t.MAHANG
/* Câu 4: Viết trigger cho bảng CTDATHANG thỏa:
- Khi bổ sung bản ghi thì giảm số lượng hàng hiện có nếu số lượng hàng hiện có >= số lượng hàng được bán ra, ngược lại thì hủy bỏ thao tác bổ sung
- khi cập nhật số lượng hàng được bán, kiểm tra số lượng hàng được cập nhật có phù hợp hay không (số lượng hàng bán ra ko đc quá số lượng hàng hiện có và không được nhỏ hơn 1). 
Nếu phù hợp thì tăng/giảm số lượng hàng hiện có, ngược lại thì hủy bỏ thao tác cập nhật
*/
CREATE TRIGGER TR_CTDATHANG_INSERT
ON CTDATHANG
FOR INSERT, UPDATE
AS BEGIN
	IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
		IF(UPDATE(SOLUONG))
			BEGIN
			IF((SELECT A.SOLUONG + C.SOLUONG SOLUONG
			FROM MATHANG A
			JOIN inserted B ON A.MAHANG = B.MAHANG
			JOIN deleted C ON B.MAHANG = C.MAHANG) >= 
			(SELECT SOLUONG FROM inserted) AND (SELECT SOLUONG FROM inserted) >= 1)
				UPDATE MATHANG
					SET SOLUONG = MATHANG.SOLUONG - (inserted.SOLUONG-deleted.SOLUONG)
					FROM inserted JOIN deleted ON inserted.MAHANG = deleted.MAHANG
					WHERE inserted.MAHANG = MATHANG.MAHANG
			ELSE
				ROLLBACK TRAN
		END
	IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
		BEGIN
			IF((SELECT A.SOLUONG 
			FROM MATHANG A
			JOIN inserted B ON A.MAHANG = B.MAHANG) >= 
			(SELECT SOLUONG FROM inserted) AND (SELECT SOLUONG FROM inserted) >= 1)
				BEGIN
					UPDATE MATHANG
						SET MATHANG.SOLUONG = MATHANG.SOLUONG - inserted.SOLUONG
						FROM inserted
						WHERE inserted.MAHANG = MATHANG.MAHANG
				END
			ELSE
				ROLLBACK TRAN
		END
END
/* Câu 5: Viết trigger cho bảng CHITIETDATHANG để sao cho 
chỉ chấp nhận giá hàng bán ra phải lớn hơn hoặc bằng giá gốc(giá của mặt hàng trong bảng MATHANG) */
CREATE TRIGGER CheckGia
ON CTDATHANG
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @giaBanRa MONEY;
    DECLARE @giaGoc MONEY;
    DECLARE @maMatHang
NVARCHAR(10);
SELECT @maMatHang = i.MAHANG, @giaBanRa = i.GIABAN
    FROM INSERTED i;
  SELECT @giaGoc = mh.GIAHANG
    FROM MATHANG mh
    WHERE mh.MAHANG = @maMatHang;
IF @giaBanRa < @giaGoc
    BEGIN
        Print ('Giá bán ra không thể nhỏ hơn giá gốc');
        ROLLBACK TRANSACTION;
    END
END;