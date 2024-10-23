CREATE DATABASE QL_BANVE
go
Use QL_BANVE
--I Thiết kết cơ sở dữ liệu
CREATE TABLE KHACHHANG
(
    MaKH VARCHAR(10) NOT NULL PRIMARY KEY,
    HoKH NVARCHAR(20) NOT NULL,
    TenKh NVARCHAR(50) NOT NULL,
    Phai NVARCHAR(5) NOT NULL,
	SDT VARCHAR(20),
    Email VARCHAR(30),
    NgaySinh DATE NOT NULL,	
)

CREATE TABLE NHANVIEN
(
    MaNV VARCHAR(10) NOT NULL PRIMARY KEY,
    HoNV NVARCHAR(20) NOT NULL,
    TenNV NVARCHAR(50) NOT NULL,
    SDT VARCHAR(20) NOT NULL,
    Phai NVARCHAR(5) NOT NULL,
    NgaySinh DATE NOT NULL 
)

CREATE TABLE LOAIVE
(
    MaLV VARCHAR(10) NOT NULL PRIMARY KEY,
    TenLoaiVe NVARCHAR(30) NOT NULL,
	GiaLoaiVe	INT NOT NULL, 
)

CREATE TABLE LOAIPHIM
(
    MaLP VARCHAR(10) NOT NULL PRIMARY KEY,
    LoaiPhim NVARCHAR(50) NOT NULL
)

CREATE TABLE DANGPHIM
(
    MaDP VARCHAR(10) NOT NULL PRIMARY KEY,
    DangPhim NVARCHAR(50) NOT NULL 
)

CREATE TABLE DSDIENVIEN
(
    MaDSDV VARCHAR(10) NOT NULL PRIMARY KEY,
    DanhSachDienVien NVARCHAR(100) NOT NULL   
)

CREATE TABLE PHIM
(
    MaPhim  VARCHAR(10) NOT NULL PRIMARY KEY,
    MaLP VARCHAR(10) NOT NULL,-- 1.
    MaDP VARCHAR(10) NOT NULL, -- 2.
    TenPhim NVARCHAR(100) NOT NULL,
    DaoDien NVARCHAR(100) NOT NULL,
    NgayKhoiChieu DATE NOT NULL,
    MaDSDV VARCHAR(10) NOT NULL, --3.
    ThoiLuong NVARCHAR(20) NOT NULL,
	MoTaPhim NVARCHAR(MAX) NOT NULL,
    TinhTrang BIT NOT NULL,
	DoTuoi INT NOT NULL,
	AnhPhim VARCHAR(100)

    CONSTRAINT FK_PHIM_LOAIPHIM FOREIGN KEY (MaLP) REFERENCES LOAIPHIM(MaLP),
	CONSTRAINT FK_PHIM_DANGPHIM FOREIGN KEY (MaDP) REFERENCES DANGPHIM(MaDP),
	CONSTRAINT FK_PHIM_DIENVIEN FOREIGN KEY (MaDSDV) REFERENCES DSDIENVIEN(MaDSDV)
)

CREATE TABLE HINHTHUCCHIEU
(
    MaHinhThucChieu VARCHAR(10) NOT NULL PRIMARY KEY,
	MaPhim VARCHAR(10) NOT NULL, 
	TenHinhThucChieu NVARCHAR(50) NOT NULL,
	NgonNgu NVARCHAR(50) NOT NULL,
	CONSTRAINT FK_HTC_PHIM FOREIGN KEY (MaPhim) REFERENCES PHIM(MaPhim)
)

CREATE TABLE XUATCHIEU
(
    MaXuatChieu VARCHAR(10) NOT NULL PRIMARY KEY,
    MaPhim VARCHAR(10) NOT NULL,
	MaHinhThucChieu VARCHAR(10) NOT NULL,
    TenXuatChieu NVARCHAR(50) NOT NULL,
    GioBatDau TIME,
	CONSTRAINT FK_XUATCHIEU_PHIM FOREIGN KEY (MaPhim) REFERENCES PHIM(MaPhim),
	CONSTRAINT FK_XUATCHIEU_HTC FOREIGN KEY (MaHinhThucChieu) REFERENCES HINHTHUCCHIEU(MaHinhThucChieu)
)

CREATE TABLE PHONGCHIEU
(
    MaPhong VARCHAR(10) NOT NULL PRIMARY KEY,
    TenPhong NVARCHAR(100) NOT NULL,
	SoLuongGhe INT NOT NULL,
	GioBatDau TIME NOT NULL,
	GioKetThuc TIME NOT NULL,
)

CREATE TABLE GHE
(
    MaGhe VARCHAR(10) NOT NULL PRIMARY KEY,
	TenGhe VARCHAR(10) NOT NULL,
	MaPhong VARCHAR(10) NOT NULL, 
	LoaiGhe NVARCHAR(30) NOT NULL,
	GiaLoaiGhe INT NOT NULL,
	TrangThai BIT
    CONSTRAINT FK_GHE_PHONGCHIEU FOREIGN KEY (MaPhong) REFERENCES PHONGCHIEU(MaPhong)
)

CREATE TABLE VEPHIM
(
    MaVe VARCHAR(10) NOT NULL PRIMARY KEY,
    MaNV VARCHAR(10) NOT NULL, --1.
    MaKH VARCHAR(10) NOT NULL,   --2
    MaLoaiVe VARCHAR(10) NOT NULL, --3
    MaPhim VARCHAR(10) NOT NULL, --4
    MaPhong VARCHAR(10) NOT NULL, --5
    Ghe VARCHAR(10) NOT NULL, --6
	XuatChieu VARCHAR(10) NOT NULL, --7
	GiaVe INT NOT NULL,
    NgayBan DATE NOT NULL, 

	CONSTRAINT FK_VEPHIM_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
	CONSTRAINT FK_VEPHIM_KHACHHANG FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
	CONSTRAINT FK_VEPHIM_LOAIVE FOREIGN KEY (MaLoaiVe) REFERENCES LOAIVE(MaLV),
	CONSTRAINT FK_VEPHIM_PHIM FOREIGN KEY (MaPhim) REFERENCES PHIM(MaPhim),
	CONSTRAINT FK_VEPHIM_PHONGCHIEU FOREIGN KEY (MaPhong) REFERENCES PHONGCHIEU(MaPhong),
	CONSTRAINT FK_VEPHIM_GHE FOREIGN KEY (Ghe) REFERENCES GHE(MaGhe),
	CONSTRAINT FK_VEPHIM_XUATCHIEU FOREIGN KEY (XuatChieu) REFERENCES XUATCHIEU(MaXuatChieu)
)

--II. Truyền Dữ liệu vào bảng
INSERT INTO KHACHHANG(MaKH,HoKH,TenKh,Phai,SDT,Email,NgaySinh)
VALUES
('KH001',N'Lê',N'Thanh Tùng','Nam','09177440287','thanhtung@gmail.com','2005-02-20'),
('KH002',N'Nguyễn',N'Quang Đạt','Nam' ,'09148547482','quangdat@gmail.com','2007-08-11'),
('KH003',N'Trần',N'Anh Khoa','Nam' ,'0867210281','anhkhoa@gmail.com','2006-04-15'),
('KH004',N'Nguyễn',N'Thành Nhân','Nam' ,'09271442584','thanhnhan@gmail.com','2010-03-12'),
('KH005',N'Trần',N'Thanh Thảo','Nữ' ,'08924710721','thanhthao@gmail.com','2003-06-01'),
('KH007',N'Nguyễn',N'Thảo Trang','Nữ' ,'09145247159','thaotrang@gmail.com','2005-01-11'),
('KH008',N'Phạm',N'Thị Thùy Trang','Nữ' ,'01472589125','thuytrang@gmail.com','2004-02-25')

INSERT INTO NHANVIEN(MaNV,HoNV,TenNV,Phai,SDT,NgaySinh)
VALUES
('NV001',N'Nguyễn',N'Thị Hoàng Anh',N'Nữ','0892178912','2002-12-01'),
('NV002',N'Nguyễn',N'Kiều Vân',N'Nữ','09172819995','2003-09-12'),
('NV003',N'Trần',N'Tiến Thanh','Nam','09271462541','2004-03-02'),
('NV004',N'Nguyễn',N'Hoàng Dương','Nam','0291717856','2005-05-12')

INSERT INTO LOAIVE(MaLV,TenLoaiVe, GiaLoaiVe)
VALUES
('LV01',N'Trẻ Em-2D',40000),
('LV02',N'Người Lớn-2D',55000),
('LV03',N'Người Cao Tuổi-2D',40000),
('LV04',N'Trẻ Em-3D',70000),
('LV05',N'Người Lớn-3D',85000),
('LV06',N'Học Sinh - Sinh Viên',55000),
('LV07',N'Người Cao Tuổi-3D',70000)

INSERT INTO LOAIPHIM(MaLP,LOAIPHIM)
VALUES
('LP001',N'Kinh dị'),
('LP002',N'Hành động'),
('LP003',N'Tình cảm'),
('LP004',N'Khoa học viễn tưởng'),
('LP005',N'Hài'),
('LP006',N'Tài liệu'),
('LP007','Anime'),
('LP008',N'Phiêu lưu')

INSERT INTO DANGPHIM(MaDP,DangPhim)
VALUES
('DP01','2D'),
('DP02','3D')

INSERT INTO DSDIENVIEN(MaDSDV,DanhSachDienVien)
VALUES
('DS01',N'Phương Anh Đào, Tuấn Trần, Trấn Thành, Uyển Ân, Hồng Đào, NSND Việt Anh, NSND Ngọc Giàu, Khả Như, Quốc Khánh, Anh Thư, Lý Hạo Mạnh Quỳnh, Anh Đức, Anh Phạm, Lộ Lộ, Kiều Linh, Ngọc Nga, Thanh Hằng, Ngọc Nguyễn, Hoàng Mèo, Mạnh Lân'),
('DS02',N'Sōichirō Hoshi, Rie Tanaka, Akira Ishida'),--Mobile Suit Gundam SEED FREEDOM
('DS03','Rebecca Hall; Brian Tyree Henry; Dan Stevens; Kaylee Hottle; Alex Ferns; Fala Chen,...'),
('DS04','Choi Min Sik, Yoo Hai Jin, Kim Go Eun, Lee Do Hyun,...'), --EXHUMA: QUẬT MỘ TRÙNG MA
('DS05',' Kaito Ishikawa, Asami Seto, Yurika Kubo, Nao Tōyama, Atsumi Tanezaki, Maaya Uchida, Sora Amamiya'),
('DS06','Shunsuke Takeuchi, Banjo Ginga, Kento Kaku, Tomoya Nakamura, Kenichirou Matsuda'),
('DS07','Jack Black, Dustin Hoffman, James Hong, Awkwafina,.')

INSERT INTO PHIM(MaPhim,MaLP,MaDP,TenPhim,DaoDien,NgayKhoiChieu,MaDSDV,ThoiLuong,MoTaPhim,TinhTrang,DoTuoi)
VALUES
('MP001','LP003','DP01','Mai',N'Trấn Thành','2024/02/10','DS01','131 Phút',
N' Mai xoay quanh câu chuyện về tình chị em “dở khóc dở cười” của Mai (Phương Anh Đào) và Dương (Tuấn Trần),
cùng sự giao thoa bí ẩn giữa câu chuyện quá khứ - tương lai liên tục được nhắc đến.',1,18),

('MP002','LP007','DP01','Mobile Suit Gundam SEED FREEDOM','Mitsuo Fukuda','2024/05/04','DS02','125 phút',
N'C.E 75, ngọn lửa xung đột vẫn không dừng. Trong đó là những phong trào giành độc lập,
và những cuộc kích động vũ trang gây ra bởi Blue Cosmos…
',1,13),

('MP003','LP002','DP01',N'GODZILLA X KONG: ĐẾ CHẾ MỚI','Adam Wingard','2024/03/29','DS03','115 phút',
N'Kong và Godzilla - hai sinh vật vĩ đại huyền thoại,
hai kẻ thủ truyền kiếp sẽ cùng bắt tay thực thi một sứ mệnh chung mang tính sống còn để bảo vệ nhân loại,
và trận chiến gắn kết chúng với loài người mãi mãi sẽ bắt đầu.
',1,0),

('MP004','LP002','DP02',N'GODZILLA X KONG: ĐẾ CHẾ MỚI','Adam Wingard','2024/03/29','DS03','115 phút',
N'Kong và Godzilla - hai sinh vật vĩ đại huyền thoại,
hai kẻ thủ truyền kiếp sẽ cùng bắt tay thực thi một sứ mệnh chung mang tính sống còn để bảo vệ nhân loại,
và trận chiến gắn kết chúng với loài người mãi mãi sẽ bắt đầu.',1,0),

('MP005','LP001','DP01',N'EXHUMA: QUẬT MỘ TRÙNG MA','Jang Jae Hyun','2024/03/15','DS04','133 phút',
N'Hai pháp sư, một thầy phong thuỷ và một chuyên gia khâm liệm cùng hợp lực khai quật ngôi mộ bị nguyền rủa của một gia đình giàu có,
nhằm cứu lấy sinh mạng hậu duệ cuối cùng trong dòng tộc.Bí mật hắc ám của tổ tiên được đánh thức.',1,16),

('MP006','LP007','DP01',N'Hội Chứng Tuổi Thanh Xuân: Em Gái Xuất Hành','Sōichi Masui','2023/10/06','DS05',N'74 phút',
N' Sau khi bị đe dọa tính mạng và những hành vi bắt nạt khác trên mạng, Kaede Azusagawa đã có một phá vỡ phân ly dẫn đến mất trí 
nhớ hoàn toàn...',0,13),

('MP007','LP007','DP01',N'Gia Đình x Điệp Viên Mã: Trắng','Kazuhiro Furuhashi','2024/02/10','DS06',N'111 phút',
N'Bộ phim là phần phim điện ảnh của series anime nổi tiếng Spy x Family. Trong bộ phim lần này, sau khi nhận được yêu cầu thay thế mình 
trong Chiến dịch Strix...',1,13),

('MP008','LP007','DP01','Kung Fu Panda 4','Mike Mitchell','2023/03/08','DS07',N'94 phút',
N'Sau khi Po được chọn trở thành Thủ lĩnh tinh thần của Thung lũng Bình Yên, Po cần tìm và huấn luyện một Chiến binh Rồng mới...',1,0)

INSERT INTO HINHTHUCCHIEU(MaHinhThucChieu,MaPhim,TenHinhThucChieu,NgonNgu)
VALUES
('HC01','MP001',N'Phụ đề Tiếng Anh' ,N'Tiếng Việt' ),
('HC02','MP002',N'Phụ đề Tiếng Việt, Tiếng Anh' ,N'Tiếng Nhật'),
('HC03','MP003',N'Phụ đề Tiếng Việt, Tiếng Hàn' ,N'Tiếng Anh'),
('HC04','MP004',N'Phụ đề Tiếng Việt, Tiếng Hàn' ,N'Tiếng Anh'),
('HC05','MP005',N'Phụ đề Tiếng Anh & Tiếng Việt',N'Tiếng Hàn'),
('HC06','MP006',N'Phụ đề Tiếng Việt, tiếng Anh' ,N'Tiếng Nhật'),
('HC07','MP007',N' Phụ đề Tiếng Việt;Lồng tiếng' ,N'Tiếng Nhật'),
('HC08','MP008',N'Phụ đề Tiếng Việt; Lồng tiếng' ,N'Tiếng Anh' )

INSERT INTO XUATCHIEU(MaXuatChieu,TenXuatChieu,MaPhim,MaHinhThucChieu,GioBatDau)
VALUES
('XC01',N'Xuất Chiếu 1','MP001','HC01','09:00'),
('XC02',N'Xuất Chiếu 2','MP002','HC02','10:30'),
('XC03',N'Xuất Chiếu 3','MP001','HC01','12:30'),
('XC04',N'Xuất Chiếu 4','MP002','HC02','14:20'),
('XC05',N'Xuất Chiếu 5','MP004','HC04','16:00'),
('XC06',N'Xuất Chiếu 6','MP003','HC03','17:30'),
('XC07',N'Xuất Chiếu 7','MP003','HC03','19:20'),
('XC08',N'Xuất Chiếu 8','MP003','HC03','20:40'),
('XC09',N'Xuất Chiếu 9','MP001','HC01','21:30'),
('XC10',N'Xuất Chiếu 10','MP005','HC05','22:00')

INSERT INTO PHONGCHIEU(MaPhong,TenPhong,SoLuongGhe,GioBatDau,GioKetThuc)
VALUES
('PC01',N'Phòng chiếu 1',50,'08:00','22:00'),
('PC02',N'Phòng chiếu 2',45,'08:00','22:00'),
('PC03',N'Phòng chiếu 3',55,'08:00','22:00'),
('PC04',N'Phòng chiếu 4',40,'09:00','23:30'),
('PC05',N'Phòng chiếu 3D',40,'08:00','21:00')

--Ghế Phòng chiếu 1
INSERT INTO GHE (MaGhe,TenGhe, MaPhong, LoaiGhe, GiaLoaiGhe)
VALUES
('GA1-PC1','A1', 'PC01', N'Thường', 0),('GA2-PC1','A2', 'PC01', N'Thường', 0),('GA3-PC1','A3', 'PC01', N'Thường', 0),('GA4-PC1','A4', 'PC01', N'Thường', 0),
('GA5-PC1','A5', 'PC01', N'Thường', 0),('GA6-PC1','A6', 'PC01', N'Thường', 0),('GA7-PC1','A7', 'PC01', N'Thường', 0),('GA8-PC1','A8', 'PC01', N'Thường', 0),
('GA9-PC1','A9', 'PC01', N'Thường', 0),('GA10-PC1','A10', 'PC01',N'Thường', 0),('GB1-PC1','B1', 'PC01', N'Thường', 0),('GB2-PC1','B2', 'PC01', N'Thường', 0),
('GB3-PC1','B3', 'PC01', N'Thường', 0),('GB4-PC1','B4', 'PC01', N'Thường', 0),('GB5-PC1','B5', 'PC01', N'Thường', 0),('GB6-PC1','B6', 'PC01', N'Thường', 0),
('GB7-PC1','B7', 'PC01', N'Thường', 0),('GB8-PC1','B8', 'PC01', N'Thường', 0),('GB9-PC1','B9', 'PC01', N'Thường', 0),('GB10-PC1','B10', 'PC01',N'Thường', 0),
('GC1-PC1','C1', 'PC01', 'VIP', 10000),('GC2-PC1','C2', 'PC01', 'VIP', 10000),('GC3-PC1','C3', 'PC01', 'VIP', 10000),('GC4-PC1','C4', 'PC01', 'VIP', 10000),
('GC5-PC1','C5', 'PC01', 'VIP', 10000),('GC6-PC1','C6', 'PC01', 'VIP', 10000),('GC7-PC1','C7', 'PC01', 'VIP', 10000),('GC8-PC1','C8', 'PC01', 'VIP', 10000),
('GC9-PC1','C9', 'PC01', 'VIP', 10000),('GC10-PC1','C10', 'PC01', 'VIP', 10000),('GD1-PC1','D1', 'PC01', 'VIP', 10000),('GD2-PC1','D2', 'PC01', 'VIP', 10000),
('GD3-PC1','D3', 'PC01', 'VIP', 10000),('GD4-PC1','D4', 'PC01', 'VIP', 10000),('GD5-PC1','D5', 'PC01', 'VIP', 10000),('GD6-PC1','D6', 'PC01', 'VIP', 10000),
('GD7-PC1','D7', 'PC01', 'VIP', 10000),('GD8-PC1','D8', 'PC01', 'VIP', 10000),('GD9-PC1','D9', 'PC01', 'VIP', 10000),('GD10-PC1','D10', 'PC01', 'VIP', 10000),
('GE1-PC1','E1', 'PC01', 'VIP', 10000),('GE2-PC1','E2', 'PC01', 'VIP', 10000),('GE3-PC1','E3', 'PC01', 'VIP', 10000),('GE4-PC1','E4', 'PC01', 'VIP', 10000),
('GE5-PC1','E5', 'PC01', 'VIP', 10000),('GE6-PC1','E6', 'PC01', 'VIP', 10000),('GE7-PC1','E7', 'PC01', 'VIP', 10000),('GE8-PC1','E8', 'PC01', 'VIP', 10000),
('GE9-PC1','E9', 'PC01', 'VIP', 10000),('GE10-PC1','E10', 'PC01', 'VIP', 10000);

--Ghế Phòng chiếu 2
INSERT INTO GHE (MaGhe,TenGhe, MaPhong, LoaiGhe, GiaLoaiGhe)
VALUES
('GA1-PC2','A1', 'PC02', N'Thường', 0),('GA2-PC2','A2', 'PC02', N'Thường', 0),('GA3-PC2','A3', 'PC02', N'Thường', 0),('GA4-PC2','A4', 'PC02', N'Thường', 0),
('GA5-PC2','A5', 'PC02', N'Thường', 0),('GA6-PC2','A6', 'PC02', N'Thường', 0),('GA7-PC2','A7', 'PC02', N'Thường', 0),('GA8-PC2','A8', 'PC02', N'Thường', 0),
('GA9-PC2','A9', 'PC02', N'Thường', 0),('GA10-PC2','A10', 'PC02',N'Thường', 0),('GB1-PC2','B1', 'PC02', N'Thường', 0),('GB2-PC2','B2', 'PC02', N'Thường', 0),
('GB3-PC2','B3', 'PC02', N'Thường', 0),('GB4-PC2','B4', 'PC02', N'Thường', 0),('GB5-PC2','B5', 'PC02', N'Thường', 0),('GB6-PC2','B6', 'PC02', N'Thường', 0),
('GB7-PC2','B7', 'PC02', N'Thường', 0),('GB8-PC2','B8', 'PC02', N'Thường', 0),('GB9-PC2','B9', 'PC02', N'Thường', 0),('GB10-PC2','B10', 'PC02',N'Thường', 0),
('GC1-PC2','C1', 'PC02', 'VIP', 10000),('GC2-PC2','C2', 'PC02', 'VIP', 10000),('GC3-PC2','C3', 'PC02', 'VIP', 10000),('GC4-PC2','C4', 'PC02', 'VIP', 10000),
('GC5-PC2','C5', 'PC02', 'VIP', 10000),('GC6-PC2','C6', 'PC02', 'VIP', 10000),('GC7-PC2','C7', 'PC02', 'VIP', 10000),('GC8-PC2','C8', 'PC02', 'VIP', 10000),
('GC9-PC2','C9', 'PC02', 'VIP', 10000),('GC10-PC2','C10', 'PC02', 'VIP', 10000),('GD1-PC2','D1', 'PC02', 'VIP', 10000),('GD2-PC2','D2', 'PC02', 'VIP', 10000),
('GD3-PC2','D3', 'PC02', 'VIP', 10000),('GD4-PC2','D4', 'PC02', 'VIP', 10000),('GD5-PC2','D5', 'PC02', 'VIP', 10000),('GD6-PC2','D6', 'PC02', 'VIP', 10000),
('GD7-PC2','D7', 'PC02', 'VIP', 10000),('GD8-PC2','D8', 'PC02', 'VIP', 10000),('GD9-PC2','D9', 'PC02', 'VIP', 10000),('GD10-PC2','D10', 'PC02', 'VIP', 10000),
('GE1-PC2','E1', 'PC02', N'Đôi', 20000),('GE2-PC2','E2', 'PC02', N'Đôi', 20000),('GE3-PC2','E3', 'PC02', N'Đôi', 20000),('GE4-PC2','E4', 'PC02', N'Đôi', 20000),
('GE5-PC2','E5', 'PC02', N'Đôi', 20000);

--Ghế Phòng chiếu 3
INSERT INTO GHE (MaGhe,TenGhe, MaPhong, LoaiGhe, GiaLoaiGhe)
VALUES
('GA1-PC3','A1', 'PC03', N'Thường', 0),('GA2-PC3','A2', 'PC03', N'Thường', 0),('GA3-PC3','A3', 'PC03', N'Thường', 0),('GA4-PC3','A4', 'PC03', N'Thường', 0),
('GA5-PC3','A5', 'PC03', N'Thường', 0),('GA6-PC3','A6', 'PC03', N'Thường', 0),('GA7-PC3','A7', 'PC03', N'Thường', 0),('GA8-PC3','A8', 'PC03', N'Thường', 0),
('GA9-PC3','A9', 'PC03', N'Thường', 0),('GA10-PC3','A10', 'PC03',N'Thường', 0),('GB1-PC3','B1', 'PC03', N'Thường', 0),('GB2-PC3','B2', 'PC03', N'Thường', 0),
('GB3-PC3','B3', 'PC03', N'Thường', 0),('GB4-PC3','B4', 'PC03', N'Thường', 0),('GB5-PC3','B5', 'PC03', N'Thường', 0),('GB6-PC3','B6', 'PC03', N'Thường', 0),
('GB7-PC3','B7', 'PC03', N'Thường', 0),('GB8-PC3','B8', 'PC03', N'Thường', 0),('GB9-PC3','B9', 'PC03', N'Thường', 0),('GB10-PC3','B10', 'PC03',N'Thường', 0),
('GC1-PC3','C1', 'PC03', 'VIP', 10000),('GC2-PC3','C2', 'PC03', 'VIP', 10000),('GC3-PC3','C3', 'PC03', 'VIP', 10000),('GC4-PC3','C4', 'PC03', 'VIP', 10000),
('GC5-PC3','C5', 'PC03', 'VIP', 10000),('GC6-PC3','C6', 'PC03', 'VIP', 10000),('GC7-PC3','C7', 'PC03', 'VIP', 10000),('GC8-PC3','C8', 'PC03', 'VIP', 10000),
('GC9-PC3','C9', 'PC03', 'VIP', 10000),('GC10-PC3','C10', 'PC03', 'VIP', 10000),('GD1-PC3','D1', 'PC03', 'VIP', 10000),('GD2-PC3','D2', 'PC03', 'VIP', 10000),
('GD3-PC3','D3', 'PC03', 'VIP', 10000),('GD4-PC3','D4', 'PC03', 'VIP', 10000),('GD5-PC3','D5', 'PC03', 'VIP', 10000),('GD6-PC3','D6', 'PC03', 'VIP', 10000),
('GD7-PC3','D7', 'PC03', 'VIP', 10000),('GD8-PC3','D8', 'PC03', 'VIP', 10000),('GD9-PC3','D9', 'PC03', 'VIP', 10000),('GD10-PC3','D10', 'PC03', 'VIP', 10000),
('GE1-PC3','E1', 'PC03', 'VIP', 10000),('GE2-PC3','E2', 'PC03', 'VIP', 10000),('GE3-PC3','E3', 'PC03', 'VIP', 10000),('GE4-PC3','E4', 'PC03', 'VIP', 10000),
('GE5-PC3','E5', 'PC03', 'VIP', 10000),('GE6-PC3','E6', 'PC03', 'VIP', 10000),('GE7-PC3','E7', 'PC03', 'VIP', 10000),('GE8-PC3','E8', 'PC03', 'VIP', 10000),
('GE9-PC3','E9', 'PC03', 'VIP', 10000),('GE10-PC3','E10', 'PC03', 'VIP', 10000),('GG1-PC3','G1', 'PC03', N'Đôi', 20000),('GG2-PC3','G2', 'PC03', N'Đôi', 20000),
('GG3-PC3','G3', 'PC03', N'Đôi', 20000),('GG4-PC3','G4', 'PC03', N'Đôi', 20000),('GG5-PC3','G5', 'PC03', N'Đôi', 20000);

--Ghế Phòng chiếu 4
INSERT INTO GHE (MaGhe,TenGhe, MaPhong, LoaiGhe, GiaLoaiGhe)
VALUES
('GA1-PC4','A1', 'PC04', N'Thường', 0),('GA2-PC4','A2', 'PC04', N'Thường', 0),('GA3-PC4','A3', 'PC04', N'Thường', 0),('GA4-PC4','A4', 'PC04', N'Thường', 0),
('GA5-PC4','A5', 'PC04', N'Thường', 0),('GA6-PC4','A6', 'PC04', N'Thường', 0),('GA7-PC4','A7', 'PC04', N'Thường', 0),('GA8-PC4','A8', 'PC04', N'Thường', 0),
('GA9-PC4','A9', 'PC04', N'Thường', 0),('GA10-PC4','A10', 'PC04',N'Thường', 0),('GB1-PC4','B1', 'PC04', N'Thường', 0),('GB2-PC4','B2', 'PC04', N'Thường', 0),
('GB3-PC4','B3', 'PC04', N'Thường', 0),('GB4-PC4','B4', 'PC04', N'Thường', 0),('GB5-PC4','B5', 'PC04', N'Thường', 0),('GB6-PC4','B6', 'PC04', N'Thường', 0),
('GB7-PC4','B7', 'PC04', N'Thường', 0),('GB8-PC4','B8', 'PC04', N'Thường', 0),('GB9-PC4','B9', 'PC04', N'Thường', 0),('GB10-PC4','B10', 'PC04',N'Thường', 0),
('GC1-PC4','C1', 'PC04', 'VIP', 10000),('GC2-PC4','C2', 'PC04', 'VIP', 10000),('GC3-PC4','C3', 'PC04', 'VIP', 10000),('GC4-PC4','C4', 'PC04', 'VIP', 10000),
('GC5-PC4','C5', 'PC04', 'VIP', 10000),('GC6-PC4','C6', 'PC04', 'VIP', 10000),('GC7-PC4','C7', 'PC04', 'VIP', 10000),('GC8-PC4','C8', 'PC04', 'VIP', 10000),
('GC9-PC4','C9', 'PC04', 'VIP', 10000),('GC10-PC4','C10', 'PC04', 'VIP', 10000),('GD1-PC4','D1', 'PC04', 'VIP', 10000),('GD2-PC4','D2', 'PC04', 'VIP', 10000),
('GD3-PC4','D3', 'PC04', 'VIP', 10000),('GD4-PC4','D4', 'PC04', 'VIP', 10000),('GD5-PC4','D5', 'PC04', 'VIP', 10000),('GD6-PC4','D6', 'PC04', 'VIP', 10000),
('GD7-PC4','D7', 'PC04', 'VIP', 10000),('GD8-PC4','D8', 'PC04', 'VIP', 10000),('GD9-PC4','D9', 'PC04', 'VIP', 10000),('GD10-PC4','D10', 'PC04', 'VIP', 10000);

-- Ghế Phòng Chiếu 3D
INSERT INTO GHE (MaGhe,TenGhe, MaPhong, LoaiGhe, GiaLoaiGhe)
VALUES
('GA1-PC3D','A1', 'PC05', '3D', 0),('GA2-PC3D','A2', 'PC05', '3D', 0),('GA3-PC3D','A3', 'PC05', '3D', 0),('GA4-PC3D','A4', 'PC05', '3D', 0),
('GA5-PC3D','A5', 'PC05', '3D', 0),('GA6-PC3D','A6', 'PC05', '3D', 0),('GA7-PC3D','A7', 'PC05', '3D', 0),('GA8-PC3D','A8', 'PC05', '3D', 0),
('GA9-PC3D','A9', 'PC05', '3D', 0),('GA10-PC3D','A10', 'PC05','3D', 0),('GB1-PC3D','B1', 'PC05', N'3D', 0),('GB2-PC3D','B2', 'PC05', '3D', 0),
('GB3-PC3D','B3', 'PC05', '3D', 0),('GB4-PC3D','B4', 'PC05', '3D', 0),('GB5-PC3D','B5', 'PC05', N'3D', 0),('GB6-PC3D','B6', 'PC05', '3D', 0),
('GB7-PC3D','B7', 'PC05', '3D', 0),('GB8-PC3D','B8', 'PC05', '3D', 0),('GB9-PC3D','B9', 'PC05', N'3D', 0),('GB10-PC3D','B10', 'PC05','3D', 0),
('GC1-PC3D','C1', 'PC05', '3D', 0),('GC2-PC3D','C2', 'PC05', '3D', 0),('GC3-PC3D','C3', 'PC05', '3D', 0),('GC4-PC3D','C4', 'PC05', '3D', 0),
('GC5-PC3D','C5', 'PC05', '3D', 0),('GC6-PC3D','C6', 'PC05', '3D', 0),('GC7-PC3D','C7', 'PC05', '3D', 0),('GC8-PC3D','C8', 'PC05', '3D', 0),
('GC9-PC3D','C9', 'PC05', '3D', 0),('GC10-PC3D','C10', 'PC05', '3D', 0),('GD1-PC3D','D1', 'PC05', '3D', 0),('GD2-PC3D','D2', 'PC05', '3D', 0),
('GD3-PC3D','D3', 'PC05', '3D-VIP', 10000),('GD4-PC3D','D4', 'PC05', '3D', 10000),('GD5-PC3D','D5', 'PC05', '3D-VIP', 10000),('GD6-PC3D','D6', 'PC05', '3D-VIP', 10000),
('GD7-PC3D','D7', 'PC05', '3D-VIP', 10000),('GD8-PC3D','D8', 'PC05', '3D', 10000),('GD9-PC3D','D9', 'PC05', '3D-VIP', 10000),('GD10-PC3D','D10', 'PC05', '3D-VIP', 10000);

--vé
INSERT INTO VEPHIM(MaVe,MaNV,MaKH,MaLoaiVe,MaPhim,MaPhong,Ghe,XuatChieu,GiaVe,NgayBan)
VALUES
( 'MV001','NV001' ,'KH002' ,'LV06','MP001','PC01','GB3-PC1','XC01' , 55000,'2024/03/11' ),
( 'MV002','NV003' ,'KH004' ,'LV01','MP002','PC04','GD5-PC4','XC04' , 45000,'2024/03/25' ),
( 'MV003','NV002' ,'KH005' ,'LV02','MP003','PC02','GB3-PC2','XC07' , 55000,'2024/01/12' ),
( 'MV004','NV001' ,'KH007' ,'LV06','MP005','PC04','GD4-PC4','XC10' , 60000,'2024/04/10' ),
('MV005','NV003' ,'KH008' ,'LV06','MP005','PC03','GD3-PC3','XC10' , 60000,'2024/04/10' );

--III. Phần truy vấn
--A.Truy vấn đơn giản: 3 câu
--1. Hiển thị thông tin của tất cả các phim đang được chiếu:
SELECT P.MaPhim, P.TenPhim, P.DaoDien,DSDV.DanhSachDienVien,P.NgayKhoiChieu,LP.LoaiPhim,DP.DangPhim,P.DoTuoi,P.MoTaPhim
FROM PHIM P, LOAIPHIM LP , DANGPHIM DP, DSDIENVIEN DSDV
WHERE P.MaLP = LP.MaLP AND P.MaDP = DP.MaDP AND  TinhTrang = 1 AND P.MaDSDV = DSDV.MaDSDV

--2. Hiển thị danh sách các phòng chiếu đang hoạt động trong thời gian hiện tại:
SELECT *
FROM PHONGCHIEU
WHERE GioBatDau <= CAST(GETDATE() AS TIME)
AND GioKetThuc >= CAST(GETDATE() AS TIME);

--3 Cho biết danh sách các phim được chiếu trong năm 2024
SELECT DISTINCT P.TenPhim 'Tên Phim', Year(p.NgayKhoiChieu) 'Năm Khởi Chiếu'
FROM PHIM P
WHERE YEAR(p.NgayKhoiChieu) = 2024

--B.Truy vấn với Aggregate Functions: 7 câu
--1. Đếm số lượng vé bán được trong ngày bất kì
SELECT COUNT(MaVe) AS 'Số lượng vé bán'
FROM VEPHIM
WHERE NgayBan = '2024/03/11';
--2. Tính tổng doanh thu từ bán vé trong tháng hiện tại:
SELECT SUM(GiaVe) AS 'Tổng danh thu'
FROM VEPHIM
WHERE MONTH(NgayBan) = MONTH(GETDATE())
AND YEAR(NgayBan) = YEAR(GETDATE());
--3. Tính trung bình số lượng vé bán được mỗi ngày trong tuần qua:

SELECT AVG(Ve_Ban_Hang_Ngay) AS N'Trung bình số lượng vé bán được mỗi ngày trong tuần qua'
FROM (
    SELECT COUNT(*) AS Ve_Ban_Hang_Ngay
    FROM VEPHIM
    WHERE NgayBan BETWEEN DATEADD(day, -6, GETDATE()) AND GETDATE()
    GROUP BY CONVERT(DATE, NgayBan)
) AS subquery;
--4. Tìm phim có số lượng vé bán nhiều nhất trong tháng này:
SELECT TOP 1 MaPhim, COUNT(*) AS 'Số lượng vé bán'
FROM VEPHIM
WHERE MONTH(NgayBan) = MONTH(GETDATE())
AND YEAR(NgayBan) = YEAR(GETDATE())
GROUP BY MaPhim
ORDER BY [Số lượng vé bán] DESC;
--5. Tính số lượng vé bán được cho mỗi loại ghế trong ngày hôm nay:
SELECT LoaiGhe 'Loại Ghế', COUNT(*) AS 'Số lượng ghế'
FROM VEPHIM
JOIN GHE ON VEPHIM.Ghe = GHE.MaGhe
WHERE NgayBan = CAST(GETDATE() AS DATE)
GROUP BY LoaiGhe;
--6. Tính tổng doanh thu từ bán vé trong tháng trước:
SELECT SUM(GiaVe) AS 'Tổng doanh thu'
FROM VEPHIM
WHERE MONTH(NgayBan) = MONTH(DATEADD(month, -1, GETDATE()))
AND YEAR(NgayBan) = YEAR(DATEADD(month, -1, GETDATE()));
--7.Tính số lượng vé bán được cho mỗi giờ trong ngày hôm nay:
SELECT DATEPART(hour, NgayBan) AS gio_trong_ngay, COUNT(*) AS so_luong_ve_ban
FROM VEPHIM
WHERE CAST(NgayBan AS DATE) = CAST(GETDATE() AS DATE)
GROUP BY DATEPART(hour, NgayBan);

--C. Truy vấn với mệnh đề having: 5 câu
--1. Tổng số lượng vé đã bán cho mỗi loại vé và tính trung bình giá vé của mỗi loại vé
SELECT MaLoaiVe 'Mã loại vé', COUNT(*) AS 'Số lượng vé', AVG(GiaVe) AS 'Trung bình giá vé'
FROM VEPHIM
GROUP BY MaLoaiVe
HAVING COUNT(*) >= 1
--2. Cho biết họ tên khách hàng xem phim nhiều hơn 1 phòng chiếu
SELECT KH.HoKH + ' ' + KH.TenKh AS 'Tên Khách Hàng', COUNT(DISTINCT VP.MaPhong) AS 'Số phòng chiếu xem'
FROM KHACHHANG KH
JOIN VEPHIM VP ON KH.MaKH = VP.MaKH
GROUP BY KH.MaKH, KH.HoKH, KH.TenKh
HAVING COUNT(DISTINCT VP.MaPhong) >1
--3. Cho biết họ tên khách hàng có tổng số tiền vé lớn hơn 100000.
SELECT KH.HoKH + ' ' + KH.TenKh AS 'Họ tên khách hàng',
       SUM(V.GiaVe) AS 'Tổng tiền vé'
FROM KHACHHANG KH
JOIN VEPHIM V ON KH.MaKH = V.MaKH
GROUP BY KH.HoKH, KH.TenKh
HAVING SUM(V.GiaVe) > 100000
--4. Cho biết họ tên khách hàng chỉ mua duy nhất 1 vé
SELECT KH.HoKH + ' ' + KH.TenKh AS HoTen
FROM KHACHHANG KH
JOIN VEPHIM V ON KH.MaKH = V.MaKH
GROUP BY KH.HoKH, KH.TenKh
HAVING COUNT(V.MaVe) = 1
--5 Số lượng vé đã bán cho mỗi ngày chiếu có trên 1 vé được bán và trung bình giá vé không dưới 50000:
SELECT v.NgayBan AS NgayBan, COUNT(*) AS SoLuongVe, AVG(v.GiaVe) AS TrungBinhGiaVe
FROM VEPHIM v
WHERE v.GiaVe >= 50000
GROUP BY v.NgayBan
HAVING COUNT(*) >= 1 AND AVG(GiaVe) >= 50000;

--D. Truy vấn lớn nhất, nhỏ nhất: 3 câu
--1. Cho biết họ tên số điện thoại khách hàng có số tiền mua vé cao nhất
SELECT TOP 1 KH.HoKH + ' ' + KH.TenKh AS HoTen,
KH.SDT AS SoDienThoai,
Total.TongTienMuaVe AS TongTienMuaVe
FROM KHACHHANG KH
JOIN VEPHIM V ON KH.MaKH = V.MaKH
JOIN (SELECT MaKH, SUM(GiaVe) AS TongTienMuaVe
FROM VEPHIM
GROUP BY MaKH
HAVING SUM(GiaVe) = (SELECT MAX(TongTienMuaVe) FROM (SELECT SUM(GiaVe) AS TongTienMuaVe FROM VEPHIM GROUP BY MaKH) AS MaxTotal)
) AS Total ON KH.MaKH = Total.MaKH

--2. Cho biết tên nhân viên ,số vé và số tiền bán vé ít nhất 
SELECT TOP 1 NV.HoNV + ' ' + NV.TenNV AS TenNhanVien,
       Total.SoLuongVeBanDuoc AS SoLuongVeBanDuoc,
       Total.TongTienBanVe AS TongTienBanVe
FROM NHANVIEN NV
JOIN (
    SELECT MaNV,
           COUNT(*) AS SoLuongVeBanDuoc,
           SUM(GiaVe) AS TongTienBanVe
    FROM VEPHIM
    GROUP BY MaNV
    HAVING COUNT(*) = (SELECT MIN(SoLuongVeBanDuoc) FROM (SELECT COUNT(*) AS SoLuongVeBanDuoc FROM VEPHIM GROUP BY MaNV) AS MinCount)
) AS Total ON NV.MaNV = Total.MaNV
ORDER BY Total.SoLuongVeBanDuoc ASC;

--3.Cho biết tên bộ phim, Danh sách tên diễn viên bán nhiều vé nhất
SELECT TOP 1 P.TenPhim AS 'Tên Bộ Phim', DSDV.DanhSachDienVien AS 'Danh sách Diễn Viên', COUNT(*) AS 'Số Lượng Vé'
FROM PHIM P
JOIN VEPHIM V ON P.MaPhim = V.MaPhim
JOIN DSDIENVIEN DSDV ON P.MaDSDV = DSDV.MaDSDV
GROUP BY P.TenPhim, DSDV.DanhSachDienVien
ORDER BY COUNT(*) DESC

/*
E. TRUY VẤN NOT IN VÀ LEFT/RIGHT JOIN
7 câu truy vấn NOT IN, LEFT/RIGHT JOIN
*/
--1.Liệt kê các phim không được xem
select DISTINCT  TenPhim 'Tên Phim'
from Phim
where MaPhim NOT IN (SELECT MaPhim FROM VEPHIM)

--2.Liệt kê ra những nhân viên không bán được vé.
Select  MaNV 'Mã nhân viên', HoNV +' ' + TenNV 'Họ tên', SDT 'Số điện thoại'
From NhanVien 
Where MaNV NOT IN(
Select  a.MaNV
From VEPHIM a Join NhanVien b on a.MaNV = b.MaNV
)

--3.Liệt kê Các phim không chiếu dưới dạng 3D
SELECT DISTINCT P.TenPhim 'Tên phim', dp.DangPhim
fROM PHIM P JOIN DANGPHIM DP ON P.MaDP = DP.MaDP
Where DP.DangPhim NOT IN ('3D')

--4.Liệt kê các khách hàng không xem phim trong năm 2024
Select kh.HoKH + ' '+ kh.TenKh 'Họ tên khách hàng'
From KHACHHANG kh
Where kh.MaKH not in
(
Select Vp.MaKH
From VEPHIM vp
Where YEAR(Vp.NgayBan) = 2024
)

--5.Liệt kê tất cả khách hàng đã mua vé nếu có
SELECT KH.MaKH, KH.HoKH, KH.TenKh, vp.MaVe
FROM KHACHHANG KH
LEFT JOIN VEPHIM VP ON KH.MaKH = VP.MaKH

--6.Liệt kê tất cả các phim và danh sách tên diễn viên của phim đó.
SELECT DISTINCT P.TenPhim 'Tên Phim', D.DanhSachDienVien 'Tên Diễn Viên'
FROM PHIM P
LEFT JOIN DSDIENVIEN D ON P.MaDSDV = D.MaDSDV;

--7.Liệt kê tên của tất cả các phim và loại phim của chúng (nếu có).
SELECT P.TenPhim 'Tên Phim', LP.LoaiPhim 'Loại Phim'
FROM PHIM P RIGHT JOIN LOAIPHIM LP ON P.MaLP = LP.MaLP

--F.Truy vấn Hợp/Giao/Trừ: 3 câu
--1.Liệt kê tên và số điện thoại của tất cả khách hàng cùng với tên và số điện thoại của nhân viên đã bán vé cho khách hàng đó.
SELECT HoKH AS 'Họ Tên', TenKh AS 'Thông Tin', SDT 'Số Điện Thoại'
FROM KHACHHANG
UNION
SELECT HoNV AS HoTen, TenNV AS ThongTin, SDT
FROM NHANVIEN
WHERE MaNV IN (
    SELECT DISTINCT MaNV
    FROM VEPHIM
);

--2 Liệt kê các thông tin có trong bảng HINHTHUCCHIEU và XUATCHIEU 
select MaPhim, MaHinhThucChieu 
from HINHTHUCCHIEU 
intersect 
select MaPhim, MaHinhThucChieu 
from XUATCHIEU

--3. Liệt kê danh sách khách hàng chưa mua vé trong tháng này
SELECT MaKH, HoKH+ ' ' + TenKh 'Họ tên khách hàng'
FROM KHACHHANG
EXCEPT
SELECT DISTINCT v.MaKH, kh.HoKH +' '+ kh.TenKh 'Họ tên khách hàng' 
FROM VEPHIM v
JOIN KHACHHANG kh ON v.MaKH = kh.MaKH
WHERE MONTH(NgayBan) = MONTH(GETDATE());

--G. Truy vấn Update, Delete: 7 câu
--1. Cập nhật phòng chiếu bất kỳ -- 
UPDATE PHONGCHIEU
SET TenPhong = N'Phòng chiếu 2'
WHERE MaPhong = 'PC02'
--2. Cập nhật giờ bắt đầu xuất chiếu với mã phim bất kỳ --
UPDATE XUATCHIEU
SET GioBatDau = '8:30'
WHERE MaPhim = 'MP001'
--3-- Cập nhật phim bất kỳ -- 
UPDATE PHIM
SET TenPhim = N'Tiệc Trăng Máu' , DaoDien = N'Nguyễn Quang Dũng'
WHERE MaPhim = 'MP006'
--4. Cập nhật ghế bất kỳ --
UPDATE GHE
SET LoaiGhe = 'B1'
WHERE MaGhe = 'LG017'
--5. Xóa tất cả các thông tin của các loại vé từ 1 đến 5 -- 
DELETE FROM VEPHIM
WHERE MaVe < 'MV002'
--6. Xóa tất cả các thông tin của nhân viên NV003 -- 
DELETE FROM NHANVIEN
WHERE manv = 'NV003'
--7.Xóa tât cả các thông tin 20 ghế đầu với loại ghế là ghế thường của phòng chiếu 1
DELETE Top(20)
From GHE
Where MaPhong = 'PC01' and LoaiGhe ='Thường'


--IV. THỦ TỤC/HÀM và TRIGGER
--A. Thủ tục/hàm: 5 Câu
--1. Tạo thủ tục có chức năng thêm Khách hàng vào bảng Khách Hàng
Create proc ThemKhachHang
@MaKH VARCHAR(10),
@HoKH NVARCHAR(20),
@TenKh NVARCHAR(50),
@Phai NVARCHAR(5),
@SDT VARCHAR(20),
@Email VARCHAR(30),
@NgaySinh DATE
AS
BEGIN
INSERT INTO KHACHHANG Values
(@MaKH,@HoKH,@TenKh,@Phai,@SDT,@Email,@NgaySinh)
END
EXec ThemKhachHang 'KH003',N'Lê',N'Thanh QUANG','Nam','0299836243',null,'2002/12/02'

--2. Tạo thủ tục có chức năng sửa thông tin Nhân viên bất kỳ
Create proc SuaNhanVien
@MaNV VARCHAR(10),
@HoNV NVARCHAR(20),
@TenNV NVARCHAR(50),
@Phai NVARCHAR(5),
@SDT VARCHAR(20),
@NgaySinh DATE
AS
BEGIN
	UPDATE NHANVIEN SET
HoNV = @HoNV, TenNV = @TenNV, Phai=@Phai,SDT = @SDT,NgaySinh=@NgaySinh
	FROM NHANVIEN
	WHERE MaNV = @MaNV
END
EXEC SuaNhanVien'Kh003',N'Nguyễn','Thanh Quang','nam','1111',null,'2003/12/12'

--3. Tạo thủ tục có chức năng xóa thông tin của một phim bất kỳ
Create proc XoaPhim
@MaPhim Varchar(10)
AS
BEGIN
Delete From PHIM
Where MaPhim = @MaPhim
END
EXEC XoaPhim 'MP001'

--4. Tạo thủ tục có chức năng cập nhập giá vé với loại vé bất kỳ
Create Proc CapNhapGiaLoaiVe
@TenLoaiVe Nvarchar(30),
@tile float
AS
BEGIN
	Update LOAIVE Set GiaLoaiVe = GiaLoaiVe * @tile
	Where TenLoaiVe Like '%'+@TenLoaiVe +'%'
END
Exec CapNhapGiaLoaiVe N'3D',1.1

--Câu 5 Tạo thủ tục: Liệt kê những nhân viên bán được vé và những nhân viên không bán được vé. Nhập vào Bán được sẽ Xuất ra danh sách những 
--Nhân viên bán được vé. Ngược lại thì sẽ xuất ra danh sách nhân viên không bán được vé
Create proc QlNhanVienBanVe
@YeuCau Nvarchar(50)
as
If(@YeuCau =N'Bán được')
	Begin
	Select MaNV,TenNV
	From NHANVIEN
	Where MaNV in (select MaNV from VEPHIM )
	End
Else
	Begin
	Select MaNV,TenNV
	From NHANVIEN
	Where MaNV not in (select MaNV from VEPHIM )
	End

Exec QlNhanVienBanVe N'Bán được'

--B. Trigger: 3 Câu
--1.Trigger kiểm tra số lượng vé còn lại cho mỗi xuất chiếu:
CREATE OR ALTER TRIGGER TRIGGER_KIEMTRA_LUOTMUAVE
ON VEPHIM
AFTER INSERT
AS
BEGIN
DECLARE @MaXuatChieu VARCHAR(10)
DECLARE @SoVeDaBan INT

-- Lấy thông tin mã xuất chiếu và số vé đã bán từ bảng VEPHIM
SELECT @MaXuatChieu = inserted.XuatChieu, @SoVeDaBan = COUNT(*)
FROM inserted
WHERE XUATCHIEU IN (SELECT DISTINCT XuatChieu FROM VEPHIM)
GROUP BY inserted.XuatChieu

-- Lấy số lượng ghế trong phòng chiếu
DECLARE @SoGhe INT
SELECT @SoGhe = COUNT(*)
FROM GHE
WHERE MaPhong = (SELECT MaPhong FROM XUATCHIEU WHERE MaXuatChieu = @MaXuatChieu)

-- Kiểm tra số lượng vé đã bán so với số lượng ghế
IF @SoVeDaBan >= @SoGhe
BEGIN
-- Nếu số lượng vé đã bán vượt quá số lượng ghế
Print(N'Đã hết vé cho xuất chiếu này! Vui lòng chọn xuất chiếu khác')
ROLLBACK TRANSACTION
END
	ELSE
	BEGIN
		PRINT 'Số vé còn lại cho xuất chiếu này: ' + CAST(@SoGhe - @SoVeDaBan AS VARCHAR(10))
	END
END

--2. Trigger để kiểm tra tính hợp lệ của thông tin khi khách hàng thêm mới 1 khách hàng vào bảng 
CREATE OR ALTER TRIGGER Tr_KiemTraThongTinDangKy
ON KHACHHANG
INSTEAD OF INSERT
AS
BEGIN
    IF (SELECT COUNT(*) FROM inserted WHERE MaKH IS NULL OR HoKH IS NULL OR TenKh IS NULL OR Email IS NULL OR SDT IS NULL OR NgaySinh IS NULL OR Phai IS NULL) > 0
    BEGIN
        PRINT N'Không thể thêm vào bảng vì thiếu thông tin.Vui lòng nhập đầy đủ thông tin';
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO KHACHHANG (MaKH,HoKH,TenKh,Phai,SDT,Email,NgaySinh)
        SELECT MaKH,HoKH,TenKh,Phai,NgaySinh, Email, SDT FROM inserted;
    END;
END;

--3. Tạo Trigger kiểm tra tự động việc thêm bản ghi vào bản VEPHIM
CREATE OR ALTER TRIGGER Tr_ThemVePhim
ON VEPHIM
INSTEAD OF INSERT
AS
BEGIN
    -- Bước 1: Kiểm tra trùng lặp trường NgayBan
    IF NOT EXISTS (
        SELECT 1
        FROM VEPHIM v
        JOIN inserted i ON v.NgayBan = i.NgayBan
    )
    BEGIN
        -- Bước 1.1: Thêm bản ghi
        INSERT INTO VEPHIM (MaVe, MaNV, MaKH, MaLoaiVe, MaPhim, MaPhong, Ghe, XuatChieu, GiaVe, NgayBan)
        SELECT MaVe, MaNV, MaKH, MaLoaiVe, MaPhim, MaPhong, Ghe, XuatChieu, GiaVe, NgayBan
        FROM inserted
        -- Bước 1.2: In thông báo thành công và kết thúc trigger
        PRINT N'Thêm thành công'
        RETURN;
    END
    -- Bước 2: Kiểm tra trùng lặp trường MaPhong
    ELSE IF NOT EXISTS (
        SELECT 1
        FROM VEPHIM v
        JOIN inserted i ON v.MaPhong = i.MaPhong
    )
    BEGIN
        -- Bước 2.1: Thêm bản ghi
        INSERT INTO VEPHIM (MaVe, MaNV, MaKH, MaLoaiVe, MaPhim, MaPhong, Ghe, XuatChieu, GiaVe, NgayBan)
        SELECT MaVe, MaNV, MaKH, MaLoaiVe, MaPhim, MaPhong, Ghe, XuatChieu, GiaVe, NgayBan
        FROM inserted
        -- Bước 2.2: In thông báo thành công và kết thúc trigger
        PRINT N'Thêm thành công'
        RETURN;
    END
    -- Bước 3: Kiểm tra trùng lặp trường XuatChieu
    ELSE IF NOT EXISTS (
        SELECT 1
        FROM VEPHIM v
        JOIN inserted i ON v.XuatChieu = i.XuatChieu
    )
    BEGIN
        -- Bước 3.1: Thêm bản ghi
        INSERT INTO VEPHIM (MaVe, MaNV, MaKH, MaLoaiVe, MaPhim, MaPhong, Ghe, XuatChieu, GiaVe, NgayBan)
        SELECT MaVe, MaNV, MaKH, MaLoaiVe, MaPhim, MaPhong, Ghe, XuatChieu, GiaVe, NgayBan
        FROM inserted
        -- Bước 3.2: In thông báo thành công và kết thúc trigger
        PRINT N'Thêm thành công'
        RETURN;
    END
    -- Bước 4: Kiểm tra trùng lặp trường Ghe
    ELSE IF NOT EXISTS (
        SELECT 1
        FROM VEPHIM v
        JOIN inserted i ON v.Ghe = i.Ghe
    )
    BEGIN
        -- Bước 4.1: Thêm bản ghi
        INSERT INTO VEPHIM (MaVe, MaNV, MaKH, MaLoaiVe, MaPhim, MaPhong, Ghe, XuatChieu, GiaVe, NgayBan)
        SELECT MaVe, MaNV, MaKH, MaLoaiVe, MaPhim, MaPhong, Ghe, XuatChieu, GiaVe, NgayBan
        FROM inserted
        -- Bước 4.2: In thông báo thành công và kết thúc trigger
        PRINT N'Thêm thành công'
        RETURN;
    END
    -- Bước 5: Ghế bị trùng lặp
    ELSE
    BEGIN
        -- Rollback và in thông báo lỗi
        ROLLBACK TRANSACTION
        PRINT N'Ghế đã bị đặt trước. Vui lòng chọn ghế khác.'
    END
END

INSERT INTO VEPHIM(MaVe,MaNV,MaKH,MaLoaiVe,MaPhim,MaPhong,Ghe,XuatChieu,GiaVe,NgayBan)
VALUES
( 'MV008','NV001' ,'KH002' ,'LV06','MP001','PC01','GB3-PC1','XC02' , 55000,'2024/03/11')

delete VEPHIM
where MaVe = 'MV007'

--V. Tạo 3 người dùng và cấp quyền cho mỗi người dùng với các quyền khác nhau.
--Tạo Login cho 3 nhóm người dùng
CREATE LOGIN KhachHang WITH PASSWORD = '123';
CREATE LOGIN NhanVien WITH PASSWORD = '456';
CREATE LOGIN QuanLy WITH PASSWORD = '789';
--Tạo user cho 3 nhóm người dùng
CREATE USER KhachHang FOR LOGIN KhachHang;
CREATE USER NhanVien FOR LOGIN NhanVien;
CREATE USER QuanLy FOR LOGIN QuanLy;

-- Gán quyền cho các nhóm người dùng
--Người dùng admin
Grant All On DangPhim To QuanLy
Grant All On DSDIENVIEN To QuanLy 
Grant All On GHE To QuanLy 
Grant All On HINHTHUCCHIEU To QuanLy 
Grant All On KHACHHANG To QuanLy 
Grant All On LOAIPHIM To QuanLy 
Grant All On LOAIVE To QuanLy 
Grant All On NHANVIEN To QuanLy 
Grant All On PHIM To QuanLy 
Grant All On PHONGCHIEU To QuanLy 
Grant All On VEPHIM To QuanLy
Grant All On XUATCHIEU To QuanLy
--Người dùng Nhân Viên
Grant SELECT, UPDATE On NHANVIEN To NhanVien
Grant SELECT,INSERT,UPDATE,Delete On VEPHIM To NhanVien
Grant SELECT, UPDATE, Delete On KHACHHANG To NhanVien
Grant SELECT On XUATCHIEU  To NhanVien
Grant SELECT ON PHIM To NhanVien
Grant SELECT on PHONGCHIEU To NhanVien
Grant SELECT On GHE To NhanVien
--Người dùng Khách Hàng
Grant SELECT,INSERT On VEPHIM To KhachHang
Grant SELECT, UPDATE, Delete On KHACHHANG To KhachHang
Grant SELECT On GHE To KhachHang
Grant SELECT On PHIM To KhachHang
Grant SELECT On XUATCHIEU To KhachHang
Grant SELECT On DANGPHIM To KhachHang
Grant SELECT On LOAIPHIM To KhachHang
Grant SELECT On DSDIENVIEN To KhachHang
Grant SELECT On LOAIVE To KhachHang
Grant SELECT on PHONGCHIEU To KhachHang