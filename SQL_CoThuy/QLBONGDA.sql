CREATE DATABASE QLBONGDA

USE QLBONGDA

CREATE TABLE CAUTHU
(
    MACT NUMERIC NOT NULL IDENTITY(1,1),
    HOTEN NVARCHAR(100) NOT NULL,
    VITRI NVARCHAR(20) NOT NULL,
    NGAYSINH DATETIME,
    DIACHI NVARCHAR(200),
    MACLB VARCHAR(5) NOT NULL,
    MAQG VARCHAR(5) NOT NULL,
    SO INT NOT NULL
    
	PRIMARY KEY(MACT),
	CONSTRAINT Fk_CT FOREIGN KEY(MAQG) REFERENCES QUOCGIA(MAQG)
)

ALTER TABLE CAUTHU
ADD CONSTRAINT Fk_CT2 FOREIGN KEY (MACLB) REFERENCES CAULACBO(MACLB)

CREATE TABLE CAULACBO
(
	MACLB VARCHAR(5) NOT NULL,
	TENCLB NVARCHAR(100),
	MASAN VARCHAR(5),
	MATINH VARCHAR(5),

	PRIMARY KEY(MACLB),

	CONSTRAINT Fk_CLB1 FOREIGN KEY (MATINH) REFERENCES TINH(MATINH)
)

ALTER TABLE CAULACBO
ADD CONSTRAINT Fk_CLB2 FOREIGN KEY(MASAN) REFERENCES SANVD(MASAN)

CREATE TABLE QUOCGIA
(
	MAQG VARCHAR(5) NOT NULL,
	TENQG NVARCHAR(60)
	
	PRIMARY KEY (MAQG)
)

CREATE TABLE TINH
(
	MATINH	VARCHAR(5) NOT NULL,
	TENTINH NVARCHAR(100)

	PRIMARY KEY (MATINH)
)

CREATE TABLE HUANLUYENVIEN
(
	MAHLV VARCHAR(5) NOT NULL,
	TENHLV NVARCHAR(100),
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	DIENTHOAI NVARCHAR(20),
	MAQG VARCHAR(5)

	PRIMARY KEY(MAHLV),
	CONSTRAINT Fk_HLV FOREIGN KEY (MAQG) REFERENCES QUOCGIA(MAQG)
)



CREATE TABLE HLV_CLB
(
	MAHLV VARCHAR(5) NOT NULL,
	MACLB VARCHAR(5) NOT NULL,
	VAITRO NVARCHAR(100)

	PRIMARY KEY(MAHLV,MACLB),

	CONSTRAINT Fk_HLV_CLB FOREIGN KEY(MAHLV) REFERENCES HUANLUYENVIEN(MAHLV) 
)

ALTER TABLE HLV_CLB
ADD CONSTRAINT Fk_HLV_CLB2 FOREIGN KEY (MACLB) REFERENCES CAULACBO(MACLB)

CREATE TABLE BANGXEPHANG
(
	MACLB	VARCHAR(5) NOT NULL,
	NAM		INT NOT NULL,
	VONG	INT NOT NULL,
	SOTRAN	INT,
	THANG	INT,
	HOA		INT,
	THUA	INT,
	HIEUSO	VARCHAR(5),
	DIEM	INT,
	HANG	INT

	PRIMARY KEY (MACLB,NAM,VONG),

	CONSTRAINT Fk_XH FOREIGN KEY(MACLB) REFERENCES CAULACBO(MACLB)
)

CREATE TABLE TRANDAU
(
	MATRAN	NUMERIC NOT NULL,
	NAM INT,
	VONG INT,
	NGAYTD DATETIME,
	MACLB1	VARCHAR(5),
	MACLB2	VARCHAR(5),
	MASAN	VARCHAR(5),
	KETQUA	VARCHAR(5)
	
	PRIMARY KEY (MATRAN),
	CONSTRAINT Fk_TD FOREIGN KEY(MACLB1) REFERENCES CAULACBO(MACLB),
	CONSTRAINT Fk_TD1 FOREIGN KEY(MACLB2) REFERENCES CAULACBO(MACLB),
)

ALTER TABLE TRANDAU
ADD CONSTRAINT Fk_TD2 FOREIGN KEY(MASAN) REFERENCES SANVD(MASAN)

CREATE TABLE SANVD
(
	MASAN VARCHAR(5) NOT NULL,
	TENSAN NVARCHAR(100),
	DIACHI NVARCHAR(200)

	PRIMARY KEY(MASAN),
)

INSERT INTO SANVD VALUES 
('GD',N'Gò Đậu',N'123 QL1, TX Thủ Dầu Một, Bình Dương'),
('PL',N'Pleiku',N'22 Hồ Tùng Mậu, Thống Nhất, Nha Trang, Khánh Hòa'),
('CL',N'Chi Lăng',N'127 Võ Văn Tần, Đà Nẵng'),
('NT',N'Nha Trang',N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa'),
('TH',N'Tuy Hòa',N'57 Trường Chinh, Tuy Hòa, Phú Yên'),
('LA',N'Long An',N'102 Hùng Vương, Tp Tân An, Long An')

INSERT INTO QUOCGIA VALUES
('VN',N'Việt Nam'),
('ANH',N'Anh Quốc'),
('TBN',N'Tây Ban Nha'),
('BDN',N'Bồ Đào Nha'),
('BRA','Bra-xin'),
('ITA',N'Ý'),
('THA',N'Thái Lan')

INSERT INTO TINH VALUES
('BD',N'Bình Dương'),
('GL','Gia Lai'),
('DN',N'Đà Nẵng'),
('KH',N'Khánh Hòa'),
('PY',N'Phú Yên'),
('LA','Long An')

INSERT INTO CAULACBO VALUES
('BBD',N'BECAMEX BÌNH DƯƠNG','GD','BD'),
('HAGL',N'HOÀNG ANH GIA LAI','PL','GL'),
('SDN',N'SHB ĐÀ NẴNG','CL','DN'),
('KKH',N'KHATOCO KHÁNH HÒA','NT','KH'),
('TPY',N'THÉP PHÚ YÊN','TH','PY'),
('GDT',N'GẠCH ĐỒNG TÂM LONG','LA','LA')

INSERT INTO CAUTHU VALUES
(N'Nguyễn Phong Vũ',N'Tiền vệ','1990/02/20',null,'BBD','VN',17),
(N'Nguyễn Công Vinh',N'Tiền đạo','1992/03/10',null,'HAGL','VN',9),
(N'Trần Tấn Tài',N'Tiền vệ','1999/11/12',null,'BBD','VN',8),
(N'Phan Hồng Sơn',N'Thủ môn','1991/06/10',null,'HAGL','VN',1),
('Ronaldo',N'Tiền vệ','1989/12/12',null,'SDN','BRA',7),
('Robinho',N'Tiên vệ','1989/10/12',null,'SDN','BRA',8),
(N'Vidic',N'Hậu vệ','1987/10/15',null,'HAGL','ANH',3),
(N'Trần Văn Santos',N'Thủ môn','1990/10/21',null,'BBD','BRA',1),
(N'Nguyễn Trường Sơn',N'Hậu vệ','1993/8/26',null,'BBD','VN',4)

INSERT INTO HUANLUYENVIEN VALUES
('HLV01','Vital','1975/10/15',null,'0918011075','BDN'),
('HLV02',N'Lê Huỳnh Đức','1972/05/20',null,'01223456789','VN'),
('HLV03','Kiatisuk','1970/12/11',null,'01990123456','THA'),
('HLV04',N'Hoàng Anh Tuấn','1970/06/10',null,'0989112233','VN'),
('HLV05',N'Trần Công Minh','1973/07/07',null,'0909099990','VN'),
('HLV06',N'Trần Văn Phúc','1975/03/02',null,'01650101234','VN')

INSERT INTO HLV_CLB VALUES
('HLV01','BBD',N'HLV Chính'),
('HLV02','SDN',N'HLV Chính'),
('HLV03','HAGL',N'HLV Chính'),
('HLV04','KKH',N'HLV Chính'),
('HLV05','GDT',N'HLV Chính'),
('HLV06','BBD',N'HLV thủ môn')

INSERT INTO TRANDAU VALUES
('1',2023,1,'2023/2/7','BBD','SDN','GD','3-0'),
('2',2023,1,'2023/2/7','KKH','GDT','NT','1-1'),
('3',2023,2,'2023/2/16','SDN','KKH','CL','2-2'),
('4',2023,2,'2023/2/16','TPY','BBD','TH','5-0'),
('5',2023,3,'2023/3/1','TPY','GDT','TH','0-2'),
('6',2023,3,'2023/3/1','KKH','BBD','NT','0-1'),
('7',2023,4,'2023/3/7','KKH','TPY','NT','1-0'),
('8',2023,4,'2023/3/7','BBD','GDT','GD','2-2')

INSERT INTO BANGXEPHANG VALUES
('BBD',2023,1,1,1,0,0,'3-0',3,1),
('KKH',2023,1,1,0,1,0,'1-1',1,2),
('GDT',2023,1,1,0,1,0,'1-1',1,3),
('TPY',2023,1,0,0,0,0,'0-0',0,4),
('SDN',2023,1,1,0,0,1,'0-3',0,5),
('TPY',2023,2,1,1,0,0,'5-0',3,1),
('BBD',2023,2,2,1,0,1,'3-5',3,2),
('KKH',2023,2,2,0,2,0,'3-3',2,3),
('GDT',2023,2,1,0,1,0,'1-1',1,4),
('SDN',2023,2,2,1,1,0,'2-5',1,5),
('BBD',2023,3,3,2,0,1,'4-5',6,1),
('GDT',2023,3,2,1,1,0,'3-1',4,2),
('TPY',2023,3,2,1,0,1,'5-2',3,3),
('KKH',2023,3,3,0,2,1,'3-4',2,4),
('SDN',2023,3,2,1,1,0,'2-5',1,5),
('BBD',2023,4,4,2,1,1,'6-7',7,1),
('GDT',2023,4,3,1,2,0,'5-1',5,2),
('KKH',2023,4,4,1,2,1,'4-4',5,3),
('TPY',2023,4,3,1,0,2,'5-3',3,4),
('SDN',2023,4,2,1,1,0,'2-5',1,5)

-- Bài tập QLBONGDA(Bài tập chương 4 - Bài tập 4)
-- Truy vấn cơ bản
-- Câu 1: Cho biết thông tin Mã cầu thủ, họ tên, số áo ,vị trí, ngày sinh, địa chỉ của tất cả các cầu thủ
Select MACT, HOTEN,SO, VITRI,NGAYSINH,DIACHI
From CAUTHU
-- Câu 2: Hiển thị tất cả các cầu thủ có số áo là 7 chơi ở bị trí tiền vệ
SELECT HOTEN, VITRI
FROM CAUTHU
WHERE SO = 7 AND VITRI = N'Tiền vệ'
-- Câu 3: Cho biết tên, ngày sinh, địa chỉ, điện thoại của các huấn luyện viên
Select TENHLV, NGAYSINH, DIACHI, DIENTHOAI 
From HUANLUYENVIEN
-- Câu 4: Hiện thị thông tin các cầu thủ có quốc tich Việt Nam và đang chơi ở CLB Becamex Bình Dương
SELECT CT.MACT, HOTEN, CONVERT(VARCHAR, NGAYSINH, 103) AS NGAYSINH, DIACHI, VITRI, SO
FROM CAUTHU CT INNER JOIN QUOCGIA QG ON CT.MAQG = QG.MAQG
			   INNER JOIN CAULACBO CLB ON CT.MACLB = CLB.MACLB
WHERE TENQG = N'VIỆT NAM' AND TENCLB = N'BECAMEX BÌNH DƯƠNG'
/* Câu 5: Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí các cầu thủ 
thuộc đội bóng 'SHB Đà Nẵng' có quốc gia là Bra-Xin */
SELECT ct.MACT, ct.HOTEN, ct.NGAYSINH, ct.DIACHI, ct.VITRI
FROM CAUTHU ct
JOIN CAULACBO clb ON ct.MACLB = clb.MACLB
JOIN QUOCGIA qg ON ct.MAQG = qg.MAQG
WHERE clb.TENCLB = N'SHB Đà Nẵng' AND qg.TENQG = 'Bra-Xin'
-- Câu 6: Hiển thị thông tin các cầu thủ đang thi đấu trong câu lạc bộ sân nhà 'Long An'
SELECT ct.MACT, ct.HOTEN, ct.NGAYSINH, ct.DIACHI, ct.VITRI
FROM CAUTHU ct
JOIN CAULACBO clb ON ct.MACLB = clb.MACLB
JOIN SANVD s ON clb.MASAN = s.MASAN
WHERE s.TENSAN = 'Long An'
-- Câu 7: Cho biết kết quả ( MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 2 của mùa bóng năm 2021.
SELECT td.MATRAN,td.NGAYTD,s.TENSAN,clb.TENCLB AS TENCLB1,CLB2.TENCLB AS TENCLB2,td.KETQUA
FROM TRANDAU td INNER JOIN SANVD s ON td.MASAN = s.MASAN
INNER JOIN CAULACBO clb ON td.MACLB1 = clb.MACLB
INNER JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE td.VONG = 2 AND YEAR(td.NGAYTD) = 2021
/* Câu 8: Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB
đang làm việc của các huấn luyện viên có quốc tịch 'Việt Nam' */
SELECT hlv.MAHLV,hlv.TENHLV,hlv.NGAYSINH,hlv.DIACHI,hlv_clb.VAITRO,clb.TENCLB
FROM HUANLUYENVIEN hlv
JOIN HLV_CLB hlv_clb on hlv.MAHLV = hlv_clb.MAHLV
Join CAULACBO clb on hlv_clb.MACLB = clb.MACLB
WHERE hlv.MAQG = 'VN'
-- Câu 9: Lấy tên 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2023
SELECT TOP 3 TENCLB
FROM CAULACBO clb
JOIN BANGXEPHANG bxh ON clb.MACLB = bxh.MACLB
WHERE NAM = 2023 AND VONG > 3
ORDER BY DIEM DESC
/* Câu 10: Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB 
đang làm việc mà câu lạc bộ đó đóng ở tỉnh Bình Dương */
SELECT hlv.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, HLV_CLB.VAITRO, clb.TENCLB
FROM HUANLUYENVIEN hlv
JOIN HLV_CLB ON hlv.MAHLV = HLV_CLB.MAHLV
JOIN CAULACBO clb ON HLV_CLB.MACLB = clb.MACLB
JOIN TINH ON clb.MATINH = TINH.MATINH
WHERE TINH.TENTINH = N'Bình Dương'
-- Các phép toán trên nhóm
-- Câu 11: Thống kế số lượng cầu thủ của mỗi câu lạc bộ
SELECT clb.MACLB, clb.TENCLB, COUNT(ct.MACT) 'Số lượng cầu thủ' 
FROM CAUTHU ct JOIN CAULACBO clb ON ct.MACLB = ct.MACLB
GROUP BY clb.MACLB, clb.TENCLB
-- Câu 12 Thống kê số lượng cầu thủ nước ngoài của mỗi câu lạc bộ
SELECT clb.MACLB, clb.TENCLB, COUNT(ct.MACT) AS 'Số lượng cầu thủ ở nước ngoài'
FROM CAUTHU ct JOIN CAULACBO clb  ON ct.MACLB = clb.MACLB 
WHERE ct.MAQG <> 'VN'
GROUP BY clb.MACLB, clb.TENCLB
/* Câu 13 Cho biết mã CLB, tên CLB, tên sân vận động, 
địa chỉ và số lượng cầu thủ nước ngoài của các CLB có nhiều hơn 2 cầu thủ nước ngoài */
SELECT CLB.MACLB, TENCLB, TENSAN, SAN.DIACHI, COUNT(MACT) N'Số cầu thủ nước ngoài'
FROM CAULACBO CLB JOIN SANVD SAN ON CLB.MASAN = SAN.MASAN
				  JOIN CAUTHU CT ON CLB.MACLB = CT.MACLB
				  JOIN QUOCGIA QG ON CT.MAQG = QG.MAQG
WHERE TENQG <> N'VIET NAM'
GROUP BY CLB.MACLB, TENCLB, TENSAN, SAN.DIACHI
HAVING COUNT(MACT) > 2
-- Câu 14: Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý
SELECT t.TENTINH, COUNT(ct.MACT) AS SOLUONGTIENDAO 
FROM TINH t JOIN CAULACBO clb ON t.MATINH = clb.MATINH
JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
WHERE ct.VITRI = N'Tiền đạo'
GROUP BY t.TENTINH
-- Câu 15: Tìm tên câu lạc bộ và tên tỉnh của CLB đứng đầu bảng xếp hạng trong vòng 3, năm 2023
SELECT TOP 1 clb.TENCLB, t.TENTINH
FROM BANGXEPHANG bxh
INNER JOIN CAULACBO clb ON bxh.MACLB = clb.MACLB
INNER JOIN TINH t ON clb.MATINH = t.MATINH
WHERE bxh.NAM = 2023 AND bxh.VONG = 3
ORDER BY bxh.HANG ASC
-- Các toán tử nâng cao
-- Câu 16: Tìm tên huấn luyện viên của CLB mà không có số điện thoại
SELECT hlv.TENHLV
FROM HUANLUYENVIEN hlv LEFT JOIN HLV_CLB hlv_clb ON hlv.MAHLV = hlv_clb.MAHLV
LEFT JOIN CAULACBO clb ON hlv_clb.MACLB = clb.MACLB
WHERE hlv_clb.MAHLV is not null AND hlv.DIENTHOAI is null
-- Câu 17: Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác  huấn luyện tại bất kì câu lạc bộ nào.
SELECT hlv.TENHLV
FROM HUANLUYENVIEN hlv JOIN QUOCGIA qg ON hlv.MAQG=qg.MAQG
WHERE qg.TENQG LIKE N'VIET NAM' AND hlv.MAHLV NOT IN (SELECT MAHLV FROM HLV_CLB)
-- Câu 18:  Liệt kê các cầu thủ đang thi đấu trong các CLB có thứ hạng ở vòng 3 năm 2019 lớn hơn 6 hoặc nhỏ hơn 3
SELECT ct.MACT, ct.HOTEN, ct.NGAYSINH, ct.VITRI,clb.TENCLB
FROM CAUTHU ct JOIN CAULACBO clb ON clb.MACLB = ct.MACLB 
	JOIN BANGXEPHANG bxh ON bxh.MACLB = ct.MACLB
WHERE (bxh.VONG = 3 AND bxh.NAM = 2019) AND (bxh.HANG < 3 or bxh.HANG > 6)
/* Câu 19: Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA)
các CLB đang xếp hạng cao nhất tính hết vòng 3 năm 2019 */
SELECT CONVERT(VARCHAR, NGAYTD, 103) AS NGAYTD, TENSAN, CLB1.TENCLB AS [CLB 1], 
   CLB2.TENCLB AS [CLB 2], KETQUA
FROM TRANDAU TD JOIN SANVD SAN ON TD.MASAN = SAN.MASAN
				JOIN CAULACBO CLB1 ON TD.MACLB1 = CLB1.MACLB
				JOIN CAULACBO CLB2 ON TD.MACLB2 = CLB2.MACLB
WHERE TD.MACLB1 IN (SELECT MACLB FROM BANGXEPHANG WHERE VONG = 3 AND NAM = 2019 
   AND DIEM >= ALL (SELECT DIEM FROM BANGXEPHANG WHERE VONG = 3 AND NAM = 2019))
   OR TD.MACLB2 IN (SELECT MACLB FROM BANGXEPHANG WHERE VONG = 3 AND NAM = 2019 
   AND DIEM >= ALL (SELECT DIEM FROM BANGXEPHANG WHERE VONG = 3 AND NAM = 2019))
-- Xử lý chuỗi, ngày giờ
-- Câu 20: Cho biết NGAYTD,TENCLB1,TENCLB2,KETQUA các trận đáu diễn ra vào tháng 3 trên sn nhà mà không bị thủng lưới
SELECT td.NGAYTD AS 'Ngày thi đấu', clb1.TENCLB AS 'Câu lạc bộ 1', clb2.TENCLB AS 'Câu lạc bộ 2',td.KETQUA 'Kết quả'
FROM TRANDAU td JOIN CAULACBO clb1 ON td.MACLB1 = clb1.MACLB
JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
JOIN SANVD sv ON td.MASAN = sv.MASAN AND sv.MASAN = clb1.MASAN
WHERE MONTH(td.NGAYTD) = 3 AND SUBSTRING(td.KETQUA, 3, 1) = '0'
ORDER BY td.NGAYTD
-- Câu 21: Cho biết mã số, tên, ngày sinh của những cầu thủ có họ lót là 'Công'
SELECT MACT, HOTEN, CONVERT(VARCHAR, NGAYSINH, 103) AS 'Ngày sinh'
FROM CAUTHU
WHERE HOTEN LIKE N'%CÔNG%'
-- Câu 22: Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ "Nguyễn" */
SELECT MACT, HOTEN, NGAYSINH, DIACHI
FROM CAUTHU
WHERE HOTEN not like N'Nguyễn%'
-- Câu 23: Cho biết mã huấn luyện viên họ tên ngày sinh địa chỉ của những huấn luyện viên Việt Nam có độ tuổi nằm trong khoảng 35-40
SELECT MAHLV, TENHLV, NGAYSINH, DIACHI
FROM HUANLUYENVIEN
WHERE MAQG = 'VN' AND NGAYSINH BETWEEN DATEADD(year,-40, GETDATE()) AND DATEADD(year,-35, GETDATE())
-- Câu 24: Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 5
SELECT clb.TENCLB
FROM CAULACBO clb JOIN HLV_CLB ON clb.MACLB = HLV_CLB.MACLB
JOIN HUANLUYENVIEN hlv ON hlv.MAHLV = HLV_CLB.MAHLV
WHERE DATEPART(day, hlv.NGAYSINH) = 20 and DATEPART(month, hlv.NGAYSINH) = 5 AND HLV_CLB.VAITRO = 'HLV Trưởng';
-- Câu 25: Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tính đến vòng 3 năm 2023
SELECT clb.TENCLB, tinh.TENTINH
FROM CAULACBO clb JOIN TINH tinh ON clb.MATINH = tinh.MATINH
JOIN BANGXEPHANG bxh ON clb.MACLB = bxh.MACLB
WHERE bxh.VONG <= 3 AND bxh.NAM = 2023
GROUP BY clb.TENCLB, tinh.TENTINH
HAVING SUM(bxh.THANG) = (
    SELECT MAX(goal_count)
    FROM (
        SELECT clb.MACLB, SUM(bxh.THANG) AS goal_count
        FROM CAULACBO clb
        JOIN BANGXEPHANG bxh ON clb.MACLB = bxh.MACLB
        WHERE bxh.VONG <= 3 AND bxh.NAM = 2023
        GROUP BY clb.MACLB
    ) AS subquery
)
-- Truy vấn con
/* Câu 26: Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài 
tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài */
SELECT clb.MACLB, clb.TENCLB, san.TENSAN, san.DIACHI, COUNT(ct.MACT) AS 'Số lượng cầu thủ nước ngoài'
FROM CAULACBO clb JOIN SANVD san ON clb.MASAN = san.MASAN
JOIN CAUTHU ct ON clb.MACLB = ct.MACLB
WHERE ct.MAQG <> 'VN'
GROUP BY clb.MACLB, clb.TENCLB, san.TENSAN, san.DIACHI
HAVING COUNT(ct.MACT) > 2
-- Câu 27: Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất năm 2021
SELECT clb.TENCLB, tinh.TENTINH
FROM CAULACBO clb JOIN TINH tinh ON clb.MATINH = tinh.MATINH
JOIN BANGXEPHANG bxh ON clb.MACLB = bxh.MACLB
WHERE bxh.NAM = 2021
GROUP BY clb.TENCLB, tinh.TENTINH
HAVING MAX(bxh.HIEUSO) = (
    SELECT MAX(HieuSoBanThang)
    FROM (
        SELECT clb.MACLB, (SUM(bxh.THANG) - SUM(bxh.THUA)) AS HieuSoBanThang
        FROM CAULACBO clb
        JOIN BANGXEPHANG bxh ON clb.MACLB = bxh.MACLB
        WHERE bxh.NAM = 2021
        GROUP BY clb.MACLB
    ) AS subquery
)
/* Câu 28: Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) 
của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2021 */
SELECT Top 1 td.NGAYTD, san.TENSAN, clb1.TENCLB 'Câu lạc bộ 1', clb2.TENCLB 'Câu lạc bộ 2', td.KETQUA
FROM TRANDAU td JOIN SANVD san ON td.MASAN = san.MASAN
JOIN CAULACBO clb1 ON td.MACLB1 = clb1.MACLB
JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
JOIN BANGXEPHANG bxh ON clb1.MACLB = bxh.MACLB
WHERE bxh.VONG = 3 AND bxh.NAM = 2021
ORDER BY bxh.HANG
/* Câu 29:Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu 
với tất cả các câu lạc bộ còn lại (kể cả sân nhà và sân khách) trong  mùa giải năm 2021 */
SELECT DISTINCT clb1.MACLB, clb1.TENCLB
FROM CAULACBO clb1
JOIN TRANDAU td ON clb1.MACLB = td.MACLB1
JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE td.NAM = 2023
UNION
SELECT DISTINCT clb2.MACLB, clb2.TENCLB
FROM CAULACBO clb1
JOIN TRANDAU td ON clb1.MACLB = td.MACLB1
JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE td.NAM = 2023
/* Câu 30: cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu 
với tất cả các câu lạc bộ còn lại (chỉ tính sân nhà) trong mùa giải năm 2021 */
SELECT DISTINCT clb1.MACLB, clb1.TENCLB
FROM CAULACBO clb1
JOIN TRANDAU td ON clb1.MACLB = td.MACLB1
JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE td.NAM = 2023 AND clb1.MASAN = td.MASAN
-- Bài tập về rule 
/* Câu 31: Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cầu thủ chỉ thuộc
một trong các vị trí sau: Thủ môn, Tiền đạo, Tiền vệ, Trung vệ, Hậu vệ */
ALTER TABLE CAUTHU
ADD CHECK (VITRI IN (N'Thủ môn', N'Tiền đạo', N'Tiền vệ', N'Trung vệ', N'Hậu vệ'))
/* Câu 32: Khi phân công huấn luyện viên, kiểm tra vai trò của huấn luyện viên 
chỉ thuộc một trong các vai trò sau: HLV chính, HLV phụ, HLV thể lực, HLV thủ môn */
ALTER TABLE HLV_CLB
ADD CHECK(VAITRO IN(N'HLV chính',N'HLV phụ',N'HLV thể lực',N'HLV thủ môn'))
-- Câu 33: Khi thêm cầu thủ mới, kiểm tra cầu thủ đó có tuổi phải đủ 18 trở lên (chỉ tính năm sinh)
ALTER TABLE CAUTHU
ADD CHECK (DATEDIFF(YEAR, NGAYSINH, GETDATE()) >= 18)
-- Câu 34: Kiểm tra kết quả trận đấu: số bàn thắng - số bàn thu
ALTER TABLE TRANDAU
ADD CONSTRAINT CK_KETQUA CHECK (KETQUA LIKE '%-%')



