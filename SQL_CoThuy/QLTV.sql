CREATE DATABASE QLTV

GO

USE QLTV

CREATE TABLE DocGia
(
    Ma_DocGia   VARCHAR(10) NOT NULL,
    Ho      NVARCHAR(20)    NOT NULL,
    TenLot  NVARCHAR(30)    NOT NULL,
    Ten     NVARCHAR(30)    NOT NULL,
    NgaySinh    DATETIME    NOT NULL

    PRIMARY KEY(Ma_DocGia)
)


CREATE TABLE NguoiLon
(
    Ma_DocGia   VARCHAR(10)     NOT NULL,
    SoNha       VARCHAR(30)     NOT NULL,
    Duong       NVARCHAR(100)   NOT NULL,
    Quan        NVARCHAR(100)   NOT NULL,
    DienThoai   NVARCHAR(20)    NOT NULL,
    HanSuDung   NVARCHAR(20)    NOT NULL

    PRIMARY KEY(Ma_DocGia),
    CONSTRAINT FK_NguoiLon_DocGia FOREIGN KEY(Ma_DocGia) REFERENCES DocGia(Ma_DocGia)

)


CREATE TABLE TreEm
(
    Ma_DocGia           VARCHAR(10) NOT NULL,
    Ma_DocGia_NguoiLon  VARCHAR(10)
    
    PRIMARY KEY(Ma_DocGia)
    CONSTRAINT FK_TreEM_NguoiLon FOREIGN KEY(Ma_DocGia_NguoiLon) REFERENCES NguoiLon(Ma_DocGia),
    CONSTRAINT FK_TreEm_DocGia  FOREIGN KEY(Ma_DocGia)  REFERENCES DocGia(Ma_DocGia)
) 

CREATE TABLE Muon
(
    ISBN            VARCHAR(10)     NOT NULL,
    Ma_CuonSach     VARCHAR(10)     NOT NULL,
    Ma_DocGia       VARCHAR(10)     NOT NULL,
    NgayMuon        DATETIME    NOT NULL,
    NgayHetHan      DATETIME    NOT NULL

    PRIMARY KEY(ISBN,Ma_CuonSach),
	CONSTRAINT FK_Muon_DocGia FOREIGN KEY(Ma_DocGia) REFERENCES DocGia(Ma_DocGia),	
)

 CREATE TABLE CuonSach
(
    ISBN            VARCHAR(10)		NOT NULL,
    Ma_CuonSach     VARCHAR(10)		NOT NULL,
    TinhTrang       BIT NOT NULL

    PRIMARY KEY (ISBN,Ma_CuonSach),    
)
ALTER TABLE Muon
ADD CONSTRAINT FK_CuonSach_Muon FOREIGN KEY (ISBN,Ma_CuonSach) REFERENCES Muon(ISBN,Ma_CuonSach)

CREATE TABLE DangKy
(
    ISBN        VARCHAR(10)     NOT NULL,
    Ma_DocGia   VARCHAR(10)     NOT NULL,
    NgayDK      DATETIME        NOT NULL,
    GhiChu      NVARCHAR(100)  

    PRIMARY KEY(ISBN,Ma_DocGia),
    CONSTRAINT FK_DangKy_DocGia FOREIGN KEY (Ma_DocGia) REFERENCES DocGia(Ma_DocGia)
)

CREATE TABLE DauSach
(
    ISBN        VARCHAR(10)     NOT NULL,
    Ma_TuaSach  VARCHAR(10)     NOT NULL,
    NgonNgu     NVARCHAR(20)    NOT NULL,
    Bia         NVARCHAR(50)    NOT NULL,
    TrangThai   BIT     NOT NULL

    PRIMARY KEY (ISBN)
)

ALTER TABLE CuonSach
ADD CONSTRAINT FK_CuonSach_DauSach FOREIGN KEY (ISBN) REFERENCES DauSach(ISBN)

CREATE TABLE TuaSach
(
    Ma_TuaSach  VARCHAR(10)     NOT NULL,
    TuaSach     NVARCHAR(50)    NOT NULL,
    TacGia  NVARCHAR(100)   NOT NULL,
    TomTat  NVARCHAR(100)

    PRIMARY KEY (Ma_TuaSach)  
)

ALTER TABLE DauSach
ADD CONSTRAINT FK_DauSach_TuaSach FOREIGN KEY (Ma_TuaSach) REFERENCES TuaSach(Ma_TuaSach)

CREATE TABLE QuaTrinhMuon
(
    ISBN    VARCHAR(10) NOT NULL,
    Ma_CuonSach VARCHAR(10) NOT NULL,
    NgayMuon    DATETIME    NOT NULL,
    Ma_DocGia   VARCHAR(10) NOT NULL,
    NgayHetHan  DATETIME    NOT NULL,
    NgayTra     DATETIME    NOT NULL,
    TienMuon    INT     NOT NULL,
    TienDatra   INT,
    TienDatCoc  INT     NOT NULL,
    GhiChu  NVARCHAR(100)

    PRIMARY KEY(ISBN,Ma_CuonSach,NgayMuon),
    CONSTRAINT FK_QTMuon_DocGia FOREIGN KEY (Ma_DocGia) REFERENCES DocGia(Ma_DocGia),
    CONSTRAINT FK_QTMuon_CuonSach FOREIGN KEY (ISBN,Ma_CuonSach) REFERENCES CuonSach(ISBN,Ma_CuonSach)
)

ALTER TABLE DangKy
ADD CONSTRAINT FK_DangKy_DauSach FOREIGN KEY (ISBN) REFERENCES DauSach(ISBN)


--THEM DU LIEU
INSERT INTO DocGia
( 
 Ma_DocGia, Ho, TenLot,Ten,NgaySinh
)
VALUES
(
 '1', 'NGUYEN', 'THE','ANH','2003/12/02'
),
( 
 '2', 'LE','CHI','TAI','2002/02/11'
),
(
 '3' ,'PHAM','THANH','HUYEN','2004/01/11'
),
(
 '4','TRAN','THANH','NHA','2001/02/11'
),
(
 '5','PHAM','THE','VINH','2002/12/02'
),
(
 '6','NGUYEN','HOA','QUANG','2010/12/02'
),
(
 '7','PHAM','THANH','THAO','2012/09/02'
 ),
 (
  '8','LE','VAN','HOA','2012/06/09'
 ),
 (
  '9','TRAN','CHI','THANH','2011/11/09'
 ),
 (
  '10','PHAM','TRUC','VI','2012/05/15'
 )

INSERT INTO NguoiLon
( 
 Ma_DocGia, SoNha, Duong,Quan,DienThoai,HanSuDung
)
VALUES
(
 '1', '25B', N'LÊ LỢI',N'QUẬN 1','025891100',N'3 THÁNG'
),
(
 '2', '36',N'NGUYỄN ĐÌNH CHIỂU',N'QUẬN 2','067794255',N'5 THÁNG'
),
(
 '3' ,'01',N'NGUYỄN TRÃI',N'QUẬN 10','098727110',N'1 THÁNG'
),
(
 '4','12A',N'TRẦN PHÚ',N'QUẬN 12','079210796',N'12 THÁNG'
),
(
 '5','26B',N'PHẠM VĂN ĐỒNG',N'QUẬN 6','071268702',N'2 THÁNG'
)

INSERT INTO TreEm
( 
 Ma_DocGia,Ma_DocGia_NguoiLon
)
VALUES
(
 '6', '1'
),
(
 '7','3'
),
(
 '8','2'
),
(
 '9','4'
),
(
 '10','5'
)

INSERT INTO TuaSach
( 
 Ma_TuaSach, TuaSach, TacGia,TomTat
)
VALUES
(
'1',N'Chú Thuật Hồi Chiến','Gege Akutami',''
),
(
 '2','Dragon Ball Super','Akira Toriyama, Toyotarou',''
),
(
 '3','Dr.STONE','Riichiro Inagaki, Boichi',''
),
(
 '4',N'Bocchi The Rock','Aki Hamazi',''
),
(
'5',N'Học Viện Siêu Anh Hùng','Kohei Horikoshi',''
)

INSERT INTO DauSach
( 
 ISBN,Ma_TuaSach,NgonNgu,Bia,TrangThai
)
VALUES
(
 '1','1',N'Tiếng Việt',N'Bìa mền','1'
),
(
 '2','2',N'Tiếng Việt',N'Bìa mền','1'
),
(
 '3','3',N'Tiếng Việt',N'Bìa mền','1'
),
(
 '4','4',N'Tiếng Việt',N'Bìa mền','1'
),
(
'5','5',N'Tiếng Việt',N'Bìa mền','1'
)

INSERT INTO CuonSach
( 
 ISBN, Ma_CuonSach,TinhTrang
)
VALUES
(
'1','1','1'
),
(
'2','2','0'
),
(
'3','3','1'
),
(
'4','4','1'
),
(
'5','5','1'
)

INSERT INTO Muon
( 
 ISBN,Ma_CuonSach,Ma_DocGia,NgayMuon,NgayHetHan 
)
VALUES
(
'1','1','1','2023/12/02','2024/01/17'
),
(
'2','2','5','2022/11/01','2022/12/16'
),
(
'3','3','7','2021/12/01','2022/01/16'
),
(
'4','4','4','2020/01/15','2020/03/01'
),
(
'5','5','8','2021/09/01','2021/10/16'
)

INSERT INTO DangKy
( 
 ISBN,Ma_DocGia,NgayDK
)
VALUES
(
'1','1','2021/12/01'
),
(
'2','5','2022/12/01'
),
(
'3','7','2023/11/22'
),
(
 '4','4','2019/05/19'
),
(
'5','8','2021/10/20'
)

INSERT INTO QuaTrinhMuon 
(
ISBN, Ma_CuonSach, NgayMuon, Ma_DocGia, NgayHetHan, NgayTra, TienMuon, TienDatra, TienDatCoc, GhiChu
)
VALUES
    ('1', '1', '2023/12/02', '1', '2024/01/17', '2024/01/17', 40000, NULL, 2000, NULL),
    ('2', '2', '2022/11/01', '5', '2022/12/16', '2022/12/16', 35000, NULL, 15000, NULL),
    ('3', '3', '2021/12/01', '7', '2022/01/16', '2022/01/16', 40000, NULL, 20000,NULL),
    ('4', '4', '2020/01/15', '4', '2020/03/01', '2020/03/01', 45000, NULL, 25000, NULL),
    ('5', '5', '2021/09/01', '8', '2021/10/16', '2021/10/16', 35000, NULL, 15000, NULL)


--BÀI TẬP(Bài tập chương 4-Bài Tập 5)
-- Câu 1: Có bao nhiêu phiếu mượn sách thư viện trong năm vừa qua
SELECT COUNT(*) AS IBSN
FROM QUATRINHMUON
WHERE YEAR(NgayMuon) = YEAR(GETDATE()) - 1
-- Câu 2: Cho biết danh sách số ngày mượn sách của các lần đã mượn sách
SELECT DATEDIFF(DAY,NgayTra, NgayMuon) AS SoNgayMuon
FROM QUATRINHMUON;
-- Câu 3: Cho biết danh sách số ngày mượn sách trung bình của các lần đã mượn sách
SELECT ISBN, Ma_CuonSach, AVG(DATEDIFF(day, NgayMuon, NgayTra)) AS SoNgayMuonTrungBinh
FROM QuaTrinhMuon
WHERE NgayTra IS NOT NULL
GROUP BY ISBN, Ma_CuonSach
-- Câu 4: Cho biết danh sách những phiếu mượn trả sách quá hạn
SELECT *
FROM QuaTrinhMuon
WHERE NgayTra IS NULL AND GETDATE() > NgayHetHan
-- Câu 5: Cho biết danh sách(độc giả, sách đã mượn) những độc giả đã được mượn quá hạn
SELECT DISTINCT DocGia.Ma_DocGia, DocGia.Ho, DocGia.TenLot, DocGia.Ten
FROM DocGia
INNER JOIN QuaTrinhMuon ON DocGia.Ma_DocGia = QuaTrinhMuon.Ma_DocGia
INNER JOIN Muon ON QuaTrinhMuon.ISBN = Muon.ISBN AND 
QuaTrinhMuon.Ma_CuonSach = Muon.Ma_CuonSach AND QuaTrinhMuon.NgayMuon = Muon.NgayMuon
WHERE GETDATE() > QuaTrinhMuon.NgayHetHan;
-- Câu 6:Cho biết danh sách (độc giả, sách được mượn) những độc giả đã và đang được mượn quá hạn
SELECT DISTINCT DocGia.Ma_DocGia, DocGia.Ho, DocGia.TenLot, DocGia.Ten, DS.ISBN, TS.TuaSach, Muon.NgayMuon, QuaTrinhMuon.NgayHetHan
FROM DocGia
INNER JOIN QuaTrinhMuon ON DocGia.Ma_DocGia = QuaTrinhMuon.Ma_DocGia
INNER JOIN Muon ON QuaTrinhMuon.ISBN = Muon.ISBN AND QuaTrinhMuon.Ma_CuonSach = Muon.Ma_CuonSach AND QuaTrinhMuon.NgayMuon = Muon.NgayMuon
INNER JOIN DauSach DS ON Muon.ISBN = DS.ISBN
INNER JOIN TuaSach TS ON DS.Ma_TuaSach = TS.Ma_TuaSach
WHERE GETDATE() > QuaTrinhMuon.NgayHetHan;
-- Câu 7: Số lượng sách nhiều nhất mà một người đã mượn
SELECT Top 1 COUNT(*) AS SoLuongSachMuon
FROM QUATRINHMUON
GROUP BY Ma_DocGia
ORDER BY SoLuongSachMuon DESC
-- Câu 8: Bạn đọc mượn sách nhiều nhất là ngày nào
SELECT Top 1 Ma_DocGia,NgayMuon, COUNT(*) as SoLuongSachMuon
FROM QUATRINHMUON
GROUP BY Ma_DocGia, NgayMuon
ORDER BY SoLuongSachMuon  DESC
-- Bài tập chương 6 - bài tập 4
-- Tạo các Store procedure
-- Câu 4.1: Xem thông tin độc giả có tên:sp_ThongtinDocGia
CREATE PROCEDURE sp_ThongTinDocGia
    @MaDG VARCHAR(10)
AS
BEGIN
    SELECT DG.Ma_DocGia,DG.Ho+' '+DG.TenLot+' '+DG.Ten 'Họ tên độc  giả',DG.NgaySinh
    FROM DocGia DG
    WHERE DG.Ma_DocGia = @MaDG
END
-- Câu 4.2: Xem thông tin đầu sách có tên: sp_ThongtinDausach
CREATE PROC sp_ThongtinDausach
@ISBN VARCHAR(50)
AS
BEGIN
SELECT ds.ISBN,ds.Ma_TuaSach,ts.TuaSach,ts.TacGia,ts.TomTat,ds. NgonNgu,ds.Bia,ds.TrangThai,COUNT(cs.Ma_CuonSach) AS TongSoLuong
FROM DauSach ds JOIN TuaSach ts ON ds.Ma_TuaSach = ts.Ma_TuaSach 
LEFT JOIN CuonSach cs ON ds.ISBN = cs.ISBN
WHERE ds.ISBN = @ISBN
GROUP BY ds.ISBN, ds.Ma_TuaSach, ts.TuaSach, ts.TacGia, ts.TomTat, ds.NgonNgu, ds.Bia, ds.TrangThai
END
-- Câu 4.3: Liệt kê những độc giả người lớn đang mượn sách có tên: sp_ThongTinNguoiLonDangmuon
CREATE PROCEDURE sp_ThongTinNguoiLonDangmuon
AS
BEGIN
    SELECT DG.Ma_DocGia,DG.Ho+' '+DG.TenLot+' '+DG.Ten 'Họ tên độc  giả',DG.NgaySinh,M.NgayMuon,M.NgayHetHan
    FROM DocGia DG
    JOIN Muon M ON DG.Ma_DocGia = M.Ma_DocGia
	JOIN NguoiLon NL ON DG.Ma_DocGia = NL.Ma_DocGia
    WHERE M.NgayHetHan >= GETDATE()
END
-- Câu 4.4: Liệt kê những độc giả người lớn đang mượn sách quá hạn có tên: sp_LietKeDGMuonQuaHan
CREATE PROCEDURE sp_LietKeDGMuonQuaHan
AS
BEGIN
    SELECT DG.Ma_DocGia, DG.Ho +' '+ DG.TenLot+' '+ DG.Ten 'Họ tên độc giả', 
		DG.NgaySinh,M.NgayMuon, M.NgayHetHan
    FROM DocGia DG
    JOIN Muon M ON DG.Ma_DocGia = M.Ma_DocGia
	JOIN QuaTrinhMuon QTM On QTM.Ma_DocGia = DG.Ma_DocGia
    WHERE     QTM.NgayTra > M.NgayHetHan
END
/* Câu 4.5: Liệt Kê Những Đọc Giả Người Lớn Đang Trong Tình Trạng Mượn Sách Và Có Trẻ Em 
Đang Bảo Lãnh Cũng Đang Trong Tình Trạng Mượn Sách có tên: sp_DocGiaCoTreEmMuon */
CREATE PROCEDURE sp_DocGiaCoTreEmMuon
    @MaDocGia VARCHAR(10),
    @ISBN VARCHAR(10),
    @MaCuonSach VARCHAR(10),
    @TuoiDocGia VARCHAR(10)
AS 
BEGIN 
 IF EXISTS (
    SELECT 1
    FROM QuaTrinhMuon QTM
    INNER JOIN Muon M ON QTM.Ma_DocGia = M.Ma_DocGia AND QTM.Ma_CuonSach = M.Ma_CuonSach
    WHERE QTM.Ma_DocGia = @MaDocGia AND M.Ma_CuonSach = @MaCuonSach
	)
    SELECT 1
    FROM DocGia DG
    WHERE DG.Ma_DocGia = @MaDocGia AND DATEDIFF(YEAR,DG.NgaySinh,GeTdate())<18 

    SELECT 1
    FROM QuaTrinhMuon QTM JOIN TreEm TE ON QTM.Ma_DocGia = TE.Ma_DocGia
    WHERE TE.Ma_DocGia = @MaDocGia;
End
-- Câu 4.6: Cập nhập trạng thái đầu sách có tên: sp_CapnhatTrangthaiDausach
CREATE PROCEDURE sp_CapnhatTrangthaiDausach
    @isbn VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Bước 1: Xác định số cuốn sách hiện giờ còn trong thư viện của đầu sách có isbn
    DECLARE @soluong INT;
    SELECT @soluong = COUNT(*) 
    FROM DauSach
    WHERE isbn = @isbn;

    -- Bước 2: Nếu không còn quyển nào
    IF @soluong = 0
    BEGIN
        -- Bước 2.1: Cập nhật tình trạng sách là 'no'
        UPDATE Dausach
        SET TrangThai = 'no'
        WHERE isbn = @isbn;
    END
    -- Bước 3: Nếu còn ít nhất là 1 quyển
    ELSE
    BEGIN
        -- Bước 3.1: Cập nhật tình trạng sách là 'Y'
        UPDATE Dausach
        SET TrangThai = 'Y' 
        WHERE isbn = @isbn;
    END
END
-- Câu 4.7: Thêm tựa sách mới có tên: sp_ThemTuaSach
CREATE PROCEDURE sp_ThemTuaSach
    @TenTuaSach NVARCHAR(100),
    @TacGia NVARCHAR(50),
    @TomTat NVARCHAR(500)
AS
BEGIN
    DECLARE @MaTuaSach VARCHAR(10)
    -- Kiểm tra phải có ít nhất 1 trong 3 thuộc tính tựa sách, tác giả, tóm tắt khác với các bộ trong bảng tựa sách đã có
    IF NOT EXISTS (
        SELECT 1 
        FROM TuaSach
        WHERE TuaSach = @TenTuaSach 
           OR TacGia = @TacGia
           OR TomTat = @TomTat
    )
    BEGIN
        -- Thêm vào tựa sách
        INSERT INTO TuaSach (Ma_TuaSach, TuaSach, TacGia, TomTat)
        VALUES (@MaTuaSach, @TenTuaSach, @TacGia, @TomTat)
        PRINT 'Thêm tựa sách thành công.'
    END
    ELSE
    BEGIN
        -- Thông báo lỗi
        PRINT 'Không thể thêm tựa sách vì đã có tựa sách tương tự trong hệ thống.'
        -- Chấm dứt stored procedure
        RETURN
    END
END
-- Câu 4.8: Thêm cuốn sách mới có tên sp_ThemCuonSach
CREATE PROCEDURE sp_ThemCuonSach
    @ISBN VARCHAR(13),
    @TenSach NVARCHAR(100),
    @TacGia NVARCHAR(50),
    @NhaXuatBan NVARCHAR(50),
    @NamXuatBan INT,
	@TinhTrang BIT
AS
BEGIN
    DECLARE @MaCuonSach VARCHAR(10)
    -- Bước 1: Kiểm tra mã ISBN nếu không tồn tại thì thông báo & return
    IF NOT EXISTS (
        SELECT 1 FROM DauSach WHERE ISBN = @ISBN
    )
    BEGIN
        PRINT 'Mã ISBN không tồn tại trong hệ thống. Không thể thêm cuốn sách.'
        RETURN
    END
    -- Bước 3: Thêm cuốn sách mới với mã cuốn sách đã xác định và tình trạng là 'yes'
    INSERT INTO CuonSach (Ma_CuonSach, ISBN,TinhTrang)
    VALUES (@MaCuonSach, @ISBN,@TinhTrang)
    -- Bước 4: Thay đổi trạng thái của đầu sách là 'yes'
    UPDATE DauSach
    SET TrangThai = 'Yes'
    WHERE ISBN = @ISBN
    PRINT 'Thêm cuốn sách thành công.'
END
-- Câu 4.9: Thêm độc giả người lớn có tên: sp_ThemNguoiLon
CREATE PROCEDURE sp_ThemNguoiLon
    @Ho NVARCHAR(50),
    @NgaySinh DATE,
	@TenLot NVARCHAR(30),
	@Ten NVARCHAR(30),
	@SoNha VARCHAR(30),
	@Duong NVARCHAR(100),
	@Quan NVARCHAR(100),
	@DienThoai VARCHAR(20),
	@HanSuDung VARCHAR(20)
  
AS
BEGIN
    DECLARE @MaDocGia VARCHAR(10)
    -- Thêm một bộ dữ liệu vào bảng độc giả
    INSERT INTO DocGia (Ma_DocGia, Ho,TenLot,Ten, NgaySinh)
    VALUES (@MaDocGia, @Ho,@TenLot,@Ten, @NgaySinh)
    -- Kiểm tra tuổi của độc giả này có đủ 18 tuổi
    DECLARE @Tuoi INT = DATEDIFF(YEAR, @NgaySinh, GETDATE())
    IF @Tuoi < 18
    BEGIN
    -- Thông báo lỗi
        PRINT 'Độc giả phải từ 18 tuổi trở lên.'
        RETURN
    END
    -- Thêm một bộ dữ liệu vào bảng người lớn
    INSERT INTO NguoiLon (Ma_DocGia,SoNha,Duong,Quan,DienThoai,HanSuDung)
    VALUES (@MaDocGia, @SoNha,@Duong,@Quan,@DienThoai,@HanSuDung)
    PRINT 'Thêm độc giả người lớn thành công.'
END
-- Câu 4.10: Thêm độc giả trẻ em có tên: sp_ThemTreEm
CREATE PROCEDURE sp_ThemTreEm
    @Ho NVARCHAR(20),
	@TenLot NVARCHAR(30),
	@Ten NVARCHAR(30),
    @NgaySinh DATE,
    @MaDocGiaLonBaoLanh VARCHAR(10)
AS
BEGIN
    DECLARE @MaDocGia VARCHAR(10)
    -- Thêm một bộ dữ liệu vào bảng độc giả
    INSERT INTO DocGia (Ma_DocGia, Ho,TenLot,Ten, NgaySinh)
    VALUES (@MaDocGia, @Ho,@TenLot,@Ten, @NgaySinh)
    -- Đếm số trẻ em của độc giả người lớn bảo lãnh trẻ em mới này
    DECLARE @SoTreEm INT
    SELECT @SoTreEm = COUNT(*) 
    FROM TreEm
    WHERE Ma_DocGia_NguoiLon = @MaDocGiaLonBaoLanh
    -- Kiểm tra, nếu không thỏa thì thông báo lỗi và kết thúc proc
    IF @SoTreEm >= 3
    BEGIN
        PRINT 'Không thể thêm trẻ em do vượt quá số lượng cho phép.'
        RETURN
    END
    -- Thêm một bộ dữ liệu vào bảng trẻ em
    INSERT INTO TreEm (Ma_DocGia, Ma_DocGia_NguoiLon)
    VALUES (@MaDocGia, @MaDocGiaLonBaoLanh)
    PRINT 'Thêm độc giả trẻ em thành công.'
END
-- Câu 4.13:Tạo store procedure mượn sách có tên: sp_MuonSach
CREATE PROCEDURE sp_MuonSach
    @MaDocGia VARCHAR(10),
    @ISBN VARCHAR(10),
    @MaCuonSach VARCHAR(10),
    @NgayMuon DATETIME,
    @NgayHetHan DATETIME
AS
BEGIN
    -- 1 Kiểm tra độc giả có đang mượn quyển sách cùng loại không?
    IF EXISTS (
        SELECT 1
        FROM QuaTrinhMuon qtm
        INNER JOIN Muon m ON qtm.ISBN = m.ISBN AND qtm.Ma_CuonSach = m.Ma_CuonSach
        WHERE qtm.Ma_DocGia = @MaDocGia AND m.ISBN = @ISBN
    )
    BEGIN
        -- 1.1 Thông báo lỗi
        PRINT N'Độc giả đang mượn quyển sách cùng loại';
        RETURN;
    END;
    -- [2] Kiểm tra số lượng sách độc giả đang mượn:
    DECLARE @SoLuongMuon INT;

    SELECT @SoLuongMuon = COUNT(*)
    FROM QuaTrinhMuon
    WHERE Ma_DocGia = @MaDocGia;
    -- 2.1 Kiểm tra độc giả là người lớn hay trẻ em
    IF EXISTS 
	(
	SELECT 1
	FROM DocGia dg, TreEm te
	WHERE dg.Ma_DocGia = @MaDocGia AND dg.Ma_DocGia = te.Ma_DocGia_NguoiLon
	)
    BEGIN
        -- 2.1. Nếu độc giả là người lớn: Tính tổng số sách độc giả đang mượn và trẻ em do độc giả bảo lãnh mượn(nếu có).
        DECLARE @SoSachTreEmMuon INT;
        SELECT @SoSachTreEmMuon = COUNT(*)
        FROM QuaTrinhMuon qtm
        INNER JOIN TreEm te ON qtm.Ma_DocGia = te.Ma_DocGia
        WHERE te.Ma_DocGia_NguoiLon = @MaDocGia;
        IF (@SoLuongMuon + @SoSachTreEmMuon >= 5)
        BEGIN
            -- 2.1 Báo lỗi & return.
            PRINT N'Độc giả đã mượn quá số lượng sách cho phép';
            RETURN;
        END;
    END
    ELSE
    BEGIN
        -- 2.2 Nếu là trẻ em: Tính số sách trẻ em đang mượn:
        SELECT @SoSachTreEmMuon = COUNT(*)
        FROM QuaTrinhMuon qtm
        INNER JOIN TreEm te ON qtm.Ma_DocGia = te.Ma_DocGia
        WHERE te.Ma_DocGia = @MaDocGia;
		IF (@SoSachTreEmMuon <1)
        BEGIN
            -- 2.2.1 Nếu <1: tính số sách người lớn bảo lãnh cho trẻ em này:
            DECLARE @SoSachBaoLanh INT;
            SELECT @SoSachBaoLanh = COUNT(*)
            FROM QuaTrinhMuon qtm
            INNER JOIN TreEm te ON qtm.Ma_DocGia = te.Ma_DocGia
            WHERE te.Ma_DocGia = @MaDocGia;
            IF @SoSachBaoLanh = 5
            BEGIN
                -- 2.2.1 Báo lỗi và return.
                PRINT N'Lỗi mượn sách';
                RETURN;
            END;
            IF @SoSachBaoLanh = 1
            BEGIN
                -- 2.2.1 Nếu = 1 thì báo lỗi và return.
                PRINT N'Lỗi mượn sách';
                RETURN;
            END;
        END;
    END;
    -- 3 Kiểm tra có còn sách trong thư viện không?
    DECLARE @SoLuongSachTrongThuVien INT;
    SELECT @SoLuongSachTrongThuVien = COUNT(*)
    FROM CuonSach
    WHERE ISBN = @ISBN AND TinhTrang = 1;
    IF @SoLuongSachTrongThuVien > 0
    BEGIN
        -- 3.1 Nếu còn:
        -- 3.1.1 Thêm một record vào bảng mượn
        INSERT INTO Muon (ISBN, Ma_CuonSach, Ma_DocGia, NgayMuon, NgayHetHan)
        VALUES (@ISBN, @MaCuonSach, @MaDocGia, @NgayMuon, @NgayHetHan);
        -- 3.1.2 Cập nhật tình trạng cuốn sách
        UPDATE CuonSach
        SET TinhTrang = 0
        WHERE ISBN = @ISBN AND Ma_CuonSach = @MaCuonSach;
        -- 3.1.3 Cập nhật trạng thái đầu sách (nếu cần)
		UPDATE DauSach
		SET TrangThai = 0
		WHERE ISBN =@ISBN;
        -- 3.1.4 Thông báo mượn sách thành công
        PRINT N'Mượn sách thành công';
    END
    ELSE
    BEGIN
        -- 3.2 Nếu không còn:
        -- 3.2.1 Thông báo cho độc giả chờ
        PRINT N'Hiện không còn sách trong thư viện';
        -- 3.2.2 Thêm một record vào bảng DangKy
        INSERT INTO DangKy (ISBN, Ma_DocGia, NgayDK)
        VALUES (@ISBN, @MaDocGia, GETDATE());
    END;
END;
--Cách thực thi proc
--Cách 1:
EXEC sp_MuonSach '1', '1', '1', '2024-03-19', '2024-04-19';
--Cách 2:
EXEC sp_MuonSach @ISBN = '1', @MaCuonSach = '1', @MaDocGia = '1', @NgayMuon = '2024-03-19', @NgayHetHan = '2024-04-19';
DROP PROCEDURE IF EXISTS sp_MuonSach;
-- Câu 4.14 Trả sách có tên: sp_TraSach
CREATE PROCEDURE sp_TraSach
    @MaDocGia VARCHAR(10),
    @MaSach VARCHAR(10),
    @NgayTra DATE
AS
BEGIN
    DECLARE @NgayMuon DATE, @SoNgayTre INT, @TienPhat DECIMAL(10,2)
    -- Bước 1: Xác định tiền phạt nếu trà quá hạn
    SELECT @NgayMuon = NgayMuon 
    FROM Muon
    WHERE Ma_DocGia = @MaDocGia AND Ma_CuonSach = @MaSach
    SET @SoNgayTre = DATEDIFF(day, @NgayMuon, @NgayTra)
    IF @SoNgayTre > 0
        SET @TienPhat = 1000 * @SoNgayTre
    ELSE
        SET @TienPhat = 0
    -- Thêm vào bảng quá trình mượn
    INSERT INTO QuaTrinhMuon(Ma_CuonSach, Ma_DocGia, NgayMuon, NgayTra,TienMuon)
    VALUES (@MaDocGia, @MaSach, @NgayMuon, @NgayTra, @TienPhat)
    -- Bước 3: Xóa dữ liệu trong bảng mượn
    DELETE FROM Muon
    WHERE Ma_DocGia = @MaDocGia AND Ma_CuonSach = @MaSach
    PRINT 'Trả sách thành công.'
END
-- Câu 4.15 Tạo các Trigger
-- a. Cập nhập tình trạng của cuốn sách là 'yes' có tên: tg_delMuon
CREATE TRIGGER tg_delMuon
ON Muon
AFTER DELETE
AS
BEGIN
    UPDATE CuonSach
    SET TinhTrang = 'Yes'
    FROM deleted d
    WHERE CuonSach.Ma_CuonSach = d.Ma_CuonSach
END
-- b. Cập nhật tình trạng của cuốn sách là 'no' có tên: tg_insMuon
CREATE TRIGGER tg_insMuon
ON Muon
AFTER INSERT
AS
BEGIN
    UPDATE CuonSach
    SET TinhTrang = 'No'
    FROM inserted i
    WHERE CuonSach.Ma_CuonSach = i.Ma_CuonSach
END
/* c. Khi thuộc tính tình trạng trên bảng cuốn sách được cập nhật thì 
trạng thái của đầu sách cũng được cập nhật theo có tên: tg_updCuonSach */
CREATE TRIGGER tg_updCuonSach
ON CuonSach
AFTER UPDATE
AS
BEGIN
    DECLARE @ISNB VARCHAR(10), @TinhTrang VARCHAR(10)
    -- Lấy thông tin về cuốn sách đã được cập nhật
    SELECT @ISNB =i.ISBN, @TinhTrang = i.TinhTrang
    FROM inserted i
    -- Cập nhật thông tin đầu sách
    UPDATE DauSach
    SET TrangThai = @TinhTrang
    WHERE DauSach.ISBN = @ISNB
END
/* d. Khi thêm mới hoặc sửa tên tác giả hoặc thêm sửa một tựa sách thì 
in ra câu thông bằng Tiếng Việt 'Đã thêm mới' có tên: Tg_themmoi */
CREATE TRIGGER tg_themmoi
ON TuaSach
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @TacGia NVARCHAR(50), @TenSach NVARCHAR(100)

    SELECT @TacGia = i.TacGia, @TenSach = i.TuaSach
    FROM inserted i

    PRINT N'Đã thêm mới :Tác giả: ' + @TacGia + N', Tên tựa sách: ' + @TenSach
END
-- Kiểm tra trigger
BEGIN TRAN
-- Thực hiện các thao tác thêm, sửa, xóa dữ liệu ở đây
INSERT INTO TuaSach(Ma_TuaSach,TacGia,TuaSach,TomTat) VALUES ('6',N'Tác Giả Mới',N'Sách Mới',N'TÓM TẮT MỚI')
UPDATE TuaSach SET TacGia = N'Tác Giả Cập Nhật' WHERE TuaSach = N'Sách Mới'
-- Kiểm tra xem trigger đã hoạt động đúng chưa
SELECT * FROM TuaSach WHERE TuaSach = N'Sách Mới'
ROLLBACK TRAN
-- 4.16: Thêm mới tựa sách có tên: tg_themtuasach
CREATE TRIGGER tg_themtuasach
ON TuaSach
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @Count INT
    -- Kiểm tra xem tựa sách đã tồn tại hay chưa
    SELECT @Count = COUNT(*)
    FROM TuaSach
    WHERE TuaSach IN (SELECT TuaSach FROM inserted)

    IF @Count > 0
    BEGIN
        -- Nếu tựa sách đã tồn tại, đưa ra thông báo lỗi và không cho insert
        Print ('TuaSach đã tồn tại. Không thể thêm.')
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        -- Nếu tựa sách không tồn tại, cho phép insert bình thường
        INSERT INTO TuaSach (Ma_TuaSach, TuaSach, TacGia, TomTat)
        SELECT Ma_TuaSach, TuaSach, TacGia, TomTat
        FROM inserted
    END
END
