create database QLDA

use QLDA

CREATE TABLE NHANVIEN
(
	MANV		varchar(5)		not null,
	HONV		nvarchar(20),
	TENLOT		nvarchar(20),
	TENNV		nvarchar(10),
	NGAYSINH	date,
	DIACHI		nvarchar(100),
	PHAI		varchar(5),
	LUONG		decimal(10,2),
	MAPB		varchar(5)

	PRIMARY KEY(MANV),
)

ALTER TABLE NHANVIEN
ADD CONSTRAINT fk_NV FOREIGN KEY(MAPB)  REFERENCES PHONGBAN(MAPB)

CREATE TABLE PHONGBAN
(
    MAPB            VARCHAR(5)      NOT NULL,
    TENPB           NVARCHAR(50),
    TRUONGPHONG     VARCHAR(5),
    NG_NHANCHUC     DATE

    PRIMARY KEY(MAPB),
	CONSTRAINT fk_pb FOREIGN KEY(TRUONGPHONG)  REFERENCES NHANVIEN(MANV)
)

CREATE TABLE THANNHAN
(
    MANV        VARCHAR(5)      NOT NULL,
    TENTN       NVARCHAR(30)    NOT NULL,
    PHAI        VARCHAR(5),
    NGAYSINH    DATE,
    QUANHE      NVARCHAR(20),
    PRIMARY KEY(MANV,TENTN),
    CONSTRAINT Fk_TN    FOREIGN KEY(MANV)   REFERENCES  NHANVIEN(MANV)
)

CREATE TABLE DEAN
(
    MADA        VARCHAR(5)      NOT NULL,
    TENDA       NVARCHAR(50),
    DDIEM_DA    NVARCHAR(100),
    MAPB        VARCHAR(5),

    PRIMARY KEY(MADA),
    CONSTRAINT Fk_DA    FOREIGN KEY(MAPB) REFERENCES  PHONGBAN(MAPB)
)

CREATE TABLE PHANCONG
(
    MANV    VARCHAR(5)  NOT NULL,
    MADA    VARCHAR(5)  NOT NULL,
    THOIGIAN DECIMAL(5,1)

    PRIMARY KEY (MANV,MADA),
    CONSTRAINT Fk_PC1 FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
	CONSTRAINT Fk_PC2 FOREIGN KEY(MADA) REFERENCES DEAN(MADA)
)

CREATE TABLE DDIEMPB
(
    MAPB VARCHAR(5) NOT NULL,
    DIADIEM NVARCHAR(100)  NOT NULL,
	PRIMARY KEY(MAPB, DIADIEM),
	CONSTRAINT Fk_DD FOREIGN KEY(MAPB) REFERENCES PHONGBAN(MAPB)
)
INSERT INTO NHANVIEN VALUES
('NV1','DINH','BA','TIEN','1985-1-9','731 Tran Hung Dao','NAM',30000,'P3'),
('NV2','VO','THANG','TUNG','1975-12-8','638 Tran Hung Dao','NAM',40000,'P3'),
('NV3','TRAN','THANH','TAM','1982-7-31','853 Mai Thi Luu, Q1, TPHCM','NAM',25000,'P2'),
('NV4','VO','MANH','HUNG','1972-9-15','975 Ba Ria, Vung Tau','NAM',38000,'P2'),
('NV5','LE','NGOC','QUYEN','1987-10-10','450 Trung Vuong, Ha Noi','NU',55000,'P1'),
('NV6','TRAN','MINH','KHANG','1982-6-24','Tran Binh Trong, TPHCM','NAM',58000,'P1'),
('NV7','LE','THI','NHAN','1981-6-20','291 Ho Van Huc, QPN, TPHCM','NU',43000,'P3'),
('NV8','TRAN','HONG','QUANG','1979-3-29','980 Le Hong Phong, Q10, TPHCM','NAM',25000,'P2'),
('NV9','BUI','THUY','VU','1978-7-19','332 Nguyen Thai Hoc, Q1, TPHCM','NU',25000,'P1')

INSERT INTO PHONGBAN VALUES
('P1','QUANLY','NV5','2016-6-19'),
('P2','DIEUHANH','NV8','2018-1-1'),
('P3','NGHIENCUU','NV2','2017-5-22')

INSERT INTO DDIEMPB VALUES
('P1','TPHCM'),
('P2','HA NOI'),
('P3','NHA TRANG'),
('P3','TPHCM'),
('P3','VUNG TAU')

INSERT INTO DEAN VALUES
('DA1','San pham X','VUNG TAU','P3'),
('DA2','San pham Y','NHA TRANG','P3'),
('DA3','San pham Z','TPHCM','P3'),
('DA4','Tin hoc hoa','HA NOI','P2'),
('DA5','Cap quang','TPHCM','P1'),
('DA6','Dao tao','HA NOI','P2')

INSERT INTO PHANCONG VALUES
('NV1','DA1',32.5),('NV1','DA2',7.5),('NV1','DA3',10),
('NV2','DA3',40),('NV2','DA4',20),('NV2','DA5',20),
('NV3','DA1',20),('NV3','DA2',20),('NV4','DA3',10),
('NV5','DA4',10),('NV5','DA5',10),('NV7','DA6',30),
('NV8','DA4',10),('NV8','DA6',20),('NV9','DA4',15)

INSERT INTO THANNHAN VALUES
('NV1','DINH BA KIEN','NAM','1995-07-15','CON TRAI'),
('NV1','NGUYEN THANH THAO','NU','1988-04-08',N'VỢ'),
('NV2','VO THANH SON','NAM','1950-09-23','CHA'),
('NV3','LE THI HUONG','NU','1984-01-09',N'VỢ'),
('NV3','TRAN LE NGOC HOA','NU','2017-09-12',N'CON GÁI'),
('NV6','TRAN MINH AN','NAM','1980-08-05','ANH TRAI'),
('NV7','LE THI NGAN','NU','1980-06-07',N'EM GÁI'),
('NV9','TRAN QUOC VUONG','NAM','1975-05-05',N'CHỒNG')

--Bài tập QLDA(Bài tập chương 4-Bài Tập 2)
-- Câu 1: Cho biết tên tuổi của từng nhân viên
SELECT TENNV 'Tên nhân viên', YEAR(GETDATE()) - YEAR(NGAYSINH) 'Tuổi'
FROM NHANVIEN
-- Câu 2: Cho biết thông tin về những người có phái là nam và địa chỉ trên đường "Tran Hung Dao"
SELECT *
FROM NHANVIEN
WHERE PHAI = 'NAM' AND DIACHI LIKE '%Tran Hung Dao%'
-- Câu 3: Cho biết những người có họ là 'Le' và tên bắt đầu bằng ký tự 'N'
SELECT HONV,TENLOT ,TENNV
FROM NHANVIEN
WHERE HONV = 'Le' AND LEFT(TENNV, 1) = 'N';
-- Câu 4: Cho biết những người có ngày sinh trong tháng 7 năm 1987
SELECT* 
FROM NHANVIEN
WHERE MONTH(NGAYSINH)=7 AND YEAR(NGAYSINH) = 1978
-- Câu 5: Cho biết những người có ngày sinh trong quý 3
SELECT *
FROM NHANVIEN
WHERE MONTH(NGAYSINH) BETWEEN 7 AND 9
-- Câu 6: Cho biết số đề án được phân công của từng nhân viên (gồm mã số, tên, số lượng đề án được phân công).
SELECT NV.MANV, NV.TENNV, COUNT(PC.MADA) AS SoDeAnPhanCong
FROM NHANVIEN NV
LEFT JOIN PHANCONG PC ON NV.MANV = PC.MANV
GROUP BY NV.MANV, NV.TENNV
-- Câu 7: Cho biết tên nhân viên có từ 2 thân nhân trở lên
Select nv.MANV, nv.TENNV
From NHANVIEN nv, THANNHAN tn
Where nv.MANV = tn.MANV
Group by nv.MANV, nv.TENNV
Having COUNT(tn.MANV)>=2
-- Câu 8: Cho biết tên nhân viên >= 30 tuổi được phân công làm việc cho đề án ở TPHCM
SELECT DISTINCT * FROM(
	SELECT TENNV, (YEAR(GETDATE()) - YEAR(NGAYSINH)) TUOINV
	FROM NHANVIEN A JOIN PHANCONG B ON A.MANV = B.MANV JOIN DEAN C ON B.MADA = C.MADA AND C.DDIEM_DA = 'TPHCM' ) D
WHERE TUOINV >= 30 ;
-- Câu 9: Cho biết có bao nhiêu đề án ở TPHCM
Select COUNT(MADA) 'Số lượng đề án'
From DEAN
Where DDIEM_DA ='TPHCM'
-- Câu 10: Đối với mỗi thành phố, cho biết tên và số lượng đề án được thực hiện ở đó
SELECT DDIEMPB.DIADIEM AS TenThanhPho, COUNT(PHANCONG.MADA) AS SoLuongDeAn
FROM DEAN
JOIN DDIEMPB ON DEAN.DDIEM_DA = DDIEMPB.DIADIEM
LEFT JOIN PHANCONG ON DEAN.MADA = PHANCONG.MADA
GROUP BY DDIEMPB.DIADIEM;
-- Câu 11: Cho biết số năm thân nhiên (số năm làm việc) của từng trưởng phòng
Select MANV, HONV, TENLOT, TENNV, TENPB, (YEAR(GETDATE())- YEAR(NG_NHANCHUC)) as 'Số năm thân niên'
From NHANVIEN nv
Join PHONGBAN pb on nv.MAPB = pb.MAPB
Where nv.MANV = pb.TRUONGPHONG;
-- Câu 12: Cho biết số lượng địa điểm phòng ban
SELECT pb.MAPB, pb.TENPB, COUNT(dd.DIADIEM) AS SoLuongDiaDiem
FROM PHONGBAN pb
LEFT JOIN DDIEMPB dd ON pb.MAPB = dd.MAPB
GROUP BY pb.MAPB, pb.TENPB;
-- Câu 13: Cho biết có bao nhiêu tên đề án là 'Sản phẩm'
Select COUNT(MADA) 'Số lượng đề án'
From DEAN
Where TENDA like 'San Pham%'
/* Câu 14: Cho biết tên phòng, địa điểm phòng , tên đề án, địa điểm đề án, của những đề án 
có địa điểm của đề án trùng với địa điểm của phòng
*/
SELECT pb.TENPB AS 'Tên phòng',dd.DIADIEM AS 'Địa điểm phòng',
	da.TENDA AS 'Tên đề án',da.DDIEM_DA AS 'Địa điểm đề án'
FROM DEAN da JOIN DDIEMPB dd ON da.DDIEM_DA = dd.DIADIEM
	Join PHONGBAN pb on da.MAPB = pb.MAPB and pb.MAPB = dd.MAPB
-- Câu 15: Tên các nhân viên quản lý có mức lương thấp hơn mức lương trung bình nhân viên họ quản lý
Select a.MANV, a.LUONG
From NHANVIEN a join PHONGBAN b on a.MANV=b.TRUONGPHONG
Group by a.MANV, a.LUONG, b.MAPB
Having a.LUONG < all(
Select AVG(LUONG)
From NHANVIEN
Where MAPB=b.MAPB and MANV <> a.MANV
)
-- Câu 16: Xóa các nhân viên có số thân nhân >=3
Delete From NHANVIEN
Where (Select COUNT(MANV) From THANNHAN Where THANNHAN.MANV = NHANVIEN.MANV) >=3
-- Câu 17: Mã nhân viên 'NV5' có mức lương cao nhất hay không (Trả lời có/ không)
SELECT CASE 
    WHEN COUNT(*) > 0 THEN 'Có'
    ELSE 'Không'
END AS CoMaNhanVienCaoNhat
FROM NHANVIEN
WHERE LUONG = (SELECT MAX(LUONG) FROM NHANVIEN)
    AND MANV = 'NV05'
-- Câu 18: Tên nhân viên đã có gia đình (thân nhân) nhưng chưa có con
SELECT DISTINCT (NV.HONV +' '+ NV.TENLOT +' '+ NV.TENNV) 
AS 'Họ Tên Nhân Viên'
FROM NHANVIEN NV INNER JOIN THANNHAN TN ON NV.MANV = TN.MANV
WHERE TN.QUANHE IN (N'VỢ', N'CHỒNG') 
AND TN.MANV NOT IN (
    SELECT DISTINCT MANV 
    FROM THANNHAN 
    WHERE QUANHE LIKE N'CON%'
);
-- Câu 19: Đối với từng đề án, cho biết tên nhân viên,tên đề án, số giờ làm việc nhiều nhất
Select a.TENNV, c.TENDA, MAX(b.THOIGIAN) as [So gio lam viec nhieu nhat]
From NHANVIEN a Join PHANCONG b on a.MANV=b.MANV
	Join DEAN c on b.MADA=c.MADA
Group by c.TENDA, a.TENNV
-- Câu 20: Tên những nhân viên được phân công làm việc cho tất cả các đề án ở Hà Nội
-- Cách 1
SELECT DISTINCT NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV AS N'Tên Nhân Viên'
FROM NHANVIEN NV
WHERE NOT EXISTS (
    SELECT *
    FROM DEAN DA
    WHERE NOT EXISTS (
        SELECT *
        FROM PHANCONG PC
        WHERE PC.MANV = NV.MANV AND PC.MADA = DA.MADA
    )
    AND DA.DDIEM_DA = 'HA NOI'
)
-- Cách 2
SELECT distinct a.HONV+' '+a.TENLOT+' '+a.TENNV as Hoten
FROM PHANCONG R1 join NHANVIEN a on R1.MANV=a.MANV
WHERE NOT EXISTS (
	SELECT S.MADA
	FROM DEAN S
	WHERE DDIEM_DA='HA NOI' AND NOT EXISTS (
		SELECT R2.MANV
		FROM PHANCONG R2
		WHERE R2.MADA=S.MADA AND R1.MANV=R2.MANV))
-- Câu 21: Tên phòng ban có trưởng phòng là nhân viên nữ
SELECT PB.TENPB
FROM PHONGBAN PB
JOIN NHANVIEN NV ON PB.MAPB = NV.MAPB
WHERE PB.TRUONGPHONG = NV.MANV AND NV.PHAI = 'NU'
-- Câu 22: Đối với từng đề án ,cho biết số lượng nhân viên tham gia đề án, tổng giờ làm việc của đề án
SELECT MADA, COUNT(MANV) AS 'SoLuongNhanVien', SUM(THOIGIAN) AS 'TongGioLamViec'
FROM PHANCONG
GROUP BY MADA;
-- Câu 23:  Đối với từng phòng ban, cho biết tên phòng ban, tổng số nam, tổng số nữ
SELECT PB.TENPB, SUM(CASE WHEN NV.PHAI = 'Nam' THEN 1 ELSE 0 END) AS SoNam, 
SUM(CASE WHEN NV.PHAI = 'Nu' THEN 1 ELSE 0 END) AS SoNu
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MAPB = PB.MAPB
GROUP BY PB.TENPB;
-- Câu 24: Tên phòng ban có nữ nhiều nhất
-- Cách 1
Select b.TENPB, count(a.PHAI) as [SL Nhan vien nu]
From NHANVIEN a Join PHONGBAN b on a.MAPB=b.MAPB
Where a.PHAI='NU'
Group by b.MAPB,b.TENPB
Having count (a.PHAI) >=all(
	Select count(PHAI)
	From NHANVIEN
	Where PHAI='NU'
	Group by MAPB
	)
-- Cách 2
SELECT TENPB
FROM (SELECT MAX(A.PHAI_NU) MAX_NU
FROM (SELECT COUNT(PHAI) PHAI_NU
   FROM NHANVIEN
   WHERE PHAI = 'NU'
   GROUP BY MAPB) A
   ) A,
 (SELECT COUNT(PHAI) PHAI_NU, TENPB
  FROM NHANVIEN A
  JOIN PHONGBAN B ON A.MAPB = B.MAPB
  WHERE PHAI = 'NU'
  GROUP BY B.MAPB,B.TENPB) B
WHERE B.PHAI_NU = A.MAX_NU
-- Câu 25 Nhân viên có mã số là "NV4" lớn  tuổi nhất hay không?(Trả lời "Có " hoặc Không?
-- Cách 1
SELECT CASE
           WHEN NV.MANV = 'NV4' THEN 'Có'
           ELSE 'Không'
       END AS Lonnhat
FROM NHANVIEN NV
WHERE DATEDIFF(year, NV.NGAYSINH,GETDATE()) = (SELECT MAX(DATEDIFF(YEAR,NGAYSINH,GETDATE())) FROM NHANVIEN);
-- Cách 2:
If (
select DATEDIFF(year, NGAYSINH, GETDATE()) from NHANVIEN where MANV='NV4'
) = (select MAX(DATEDIFF(year, NGAYSINH, GETDATE())) from NHANVIEN)
	select 'Có' as [Nhân viên NV4 lớn tuổi nhất];
else
	select 'Không' as [Nhân viên NV4 lớn tuổi nhất];
-- Câu 26: Đối với từng phòng ban, cho biết tên phòng ban, lương trung bình của nữ, lương trung bình của nam
SELECT PB.MAPB, TENPB,  
CASE WHEN [LUONG TB NU] IS NULL THEN 0 
ELSE [LUONG TB NU] 
END AS [LUONG TB NU], 
CASE WHEN [LUONG TB NAM] IS NULL THEN 0 
ELSE [LUONG TB NAM] END AS [LUONG TB NAM]
FROM PHONGBAN PB JOIN (SELECT MAPB, AVG(LUONG) AS [LUONG TB NU] 
FROM NHANVIEN WHERE PHAI = 'Nu' GROUP BY MAPB) as NU ON PB.MAPB = NU.MAPB
JOIN (SELECT MAPB, AVG(LUONG) AS [LUONG TB NAM] 
FROM NHANVIEN WHERE PHAI = 'Nam' GROUP BY MAPB) as NAM ON PB.MAPB = NAM.MAPB
-- Câu 27: Tăng 10% lương đối với các nhân viên là nữ và được phân công làm việc cho đề án ở Vũng Tàu hay Nha Trang
UPDATE NHANVIEN
SET LUONG = LUONG * 1.1
WHERE PHAI = 'NU' AND MANV IN 
     (SELECT MANV 
	 FROM DEAN JOIN PHANCONG ON DEAN.MADA = PHANCONG.MADA 
	 WHERE DDIEM_DA IN ('VUNG TAU', 'NHA TRANG'))
-- Câu 28: Tên và địa chỉ các nhân viên làm việc cho một đề án ở thành phố nhưng phòng ban của họ không thuộc thành phố đó
Select Distinct nv.TENNV 'Tên nhân viên', nv.DIACHI 'Địa chỉ nhân viên'
From NHANVIEN nv Join DDIEMPB pb on nv.MAPB = pb.MAPB
Join DEAN da on pb.MAPB = da.MAPB and nv.MAPB = da.MAPB
Where da.DDIEM_DA != pb.DIADIEM
-- Câu 29 Tên các đề án thuộc phòng ban có địa điểm ở Hà Nội
SELECT DEAN.TENDA AS TenDeAn
FROM DEAN
INNER JOIN DDIEMPB ON DEAN.MAPB = DDIEMPB.MAPB
WHERE DDIEMPB.DIADIEM = N'HA NOI';
-- Câu 30: Tên những nhân viên là trưởng phòng và cư ngụ tại TPHCM
SELECT NV.HONV, NV.TENLOT, NV.TENNV
FROM PHONGBAN PB
JOIN NHANVIEN NV ON PB.TRUONGPHONG = NV.MANV
WHERE NV.DIACHI LIKE '%TPHCM%';
-- Câu 31: Tên nhân viên là trưởng phòng có ngày nhận chức sau cùng (mới nhất)
SELECT HONV + ' ' + TENLOT + ' ' + TENNV AS [HO TEN TRUONG PHONG], NG_NHANCHUC
FROM NHANVIEN NV JOIN PHONGBAN PB ON NV.MANV = PB.TRUONGPHONG
WHERE NG_NHANCHUC >= ALL (SELECT NG_NHANCHUC FROM PHONGBAN)
-- Câu 32: Phòng ban nào chỉ phụ trách các đề án ở Hà Nội
Select Distinct MAPB as [PB chỉ phụ trách đề án ở Hà Nội]
From DEAN
Except
Select Distinct MAPB
From DEAN
Where MADA not in(
	Select MADA
	From DEAN
	Where DDIEM_DA='HA NOI'
	Group by MADA)
Group by MAPB
-- Câu 33: Thêm vào quan hệ PHANCONG các bộ là đề án mà NV3 chưa được phân công
Insert into PHANCONG
Select 'NV3',a.MADA, sum(a.THOIGIAN)
From PHANCONG a join DEAN b on a.MADA=b.MADA
Where b.MADA not in(
	Select a.MADA
	From PHANCONG a
	Where a.MANV='NV3')
Group by a.MADA
-- Câu 34: Liệt kê tên phòng ban, tên trưởng phòng của các phòng ban có nhiều nhân viên nữ nhất
SELECT PB.TENPB, NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV AS TEN_TRUONGPHONG
FROM PHONGBAN PB
JOIN NHANVIEN NV ON PB.TRUONGPHONG = NV.MANV
WHERE PB.MAPB IN (
    SELECT TOP 1 NV.MAPB
    FROM NHANVIEN NV
    WHERE NV.PHAI = 'Nu'
    GROUP BY NV.MAPB
    ORDER BY COUNT(*) DESC
);
-- Câu 35: Tên nhân viên được phân công làm việc cho tất cả các đề án của phòng P2
Select nv.TENNV
From NHANVIEN nv
Where not exists(
	Select *
	From DEAN da
	Where MAPB='P2' and not exists(
		Select *
		From PHANCONG pc
		Where pc.MADA=da.MADA and pc.MANV=nv.MANV))
-- Câu 36: Cho biết tên đề án, tên nhân viên, số giờ của từng để ăn được phân công và số giờ làm việc nhiều nhất
SELECT TENDA, HONV + ' ' + TENLOT + ' ' + TENNV AS [HO TEN NV], THOIGIAN
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
	JOIN DEAN DA ON PC.MADA = DA.MADA
WHERE THOIGIAN >= ALL (SELECT MAX(THOIGIAN) FROM PHANCONG WHERE MADA = PC.MADA)
-- Câu 37: Đối với từng nhân viên:cho biết tên nhân viên,mã phòng ban và tên của trưởng phòng
SELECT NV.TENNV, NV.MAPB, TP.TENNV AS TEN_TRUONGPHONG
FROM NHANVIEN NV JOIN PHONGBAN PB ON NV.MAPB = PB.MAPB
	JOIN NHANVIEN TP ON PB.TRUONGPHONG = TP.MANV
