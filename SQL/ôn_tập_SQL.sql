--ÔN TẬP SQL
--NGÔN NGỮ ĐỊNH NGHĨA DỮ LIỆU-- DDL(DATA DEFINITION LANGUAGE)
--GỒM CREATE , ALTER, DROP
--CREATE: TẠO MỚI ĐỐI TƯỢNG
--ALTER: CHỈNH SỬ ĐỐI TƯỢNG
--DROP: XÓA ĐỐI TƯỢNG

--TẠO CSDL
CREATE DATABASE TENCSDL

--TẠO CSDL VỚI YÊU CẦU
CREATE DATABASE TENCSDL ON
PRIMARY
(
NAME = TEN_FILE_LOGIC,
FILENAME=' TEN FILE VAT LY CỦA FILE.mdf',
SIZE = 10,
MAXSIZE = UNLIMITED,
FILEGROWTH = 10%

)
LOG ON
(
NAME = TEN_FILE_CUA_FILE_LOG,
FILENAME='TEN FILE VAT LY CUA FILE LOG.ldf',
SIZE =1,--KÍCH THƯỚC BAN ĐẦU CỦA FILE LOG
MAXSIZE=500,--KÍCH THƯỚC TỐI ĐA CỦA FILE LOG
FILEGROWTH = 10%--KÍCH THƯỚC SAU MỖI LẦN TĂNG TRƯỞNG
)

--SỬ DỤNG CSDL
USE TENCSDL

--XÓA DATABASE
DROP DATABASE TENCSDL


-- SỬA ĐỔI CSDL
ALTER DATABASE TENCSDL MODIFY FILE
(
NAME = TEN_FILE_LOGIC,
NEWNAME = TEN_FILE_LOGIC_SỬA_ĐỔI,
FILENAME='TEN_FILE_VAT_LY SUA DOI.MDF',
SIZE = 2,
MAXSIZE= 500,
FILEGROWTH = 10%


)
--TRONG TRƯỜNG HỢP MUỐN ĐỔI FILE VẬT LÝ(ĐỔI TÊN HOẶC DI CHUYỂN FILE) CẦN LÀM THEO CÁC BƯỚC SAU
--B1: SỬA ĐỔI CSDL NHƯ TRÊN
ALTER DATABASE TENCSDL MODIFY FILE
(
NAME = TEN_FILE_LOGIC,
NEWNAME= TEN_FILE_LOGIC_SỬA_ĐỔI,
FILENAME='TEN_FILE_VẬT_LÝ_SỬA_ĐỔI.MDF',
SIZE = 10,
MAXSIZE = 500,
FILEGROWTH = 10%,
)
--B2: NGẮT KẾT NỐI THIẾT LẬP OFFLINE
--NGẮT KẾT NỐI
ALTER DATABASE TENCSDL SET SINGLE_USER WITH ROLLBACK IMMEDIATE
--THIẾT LẬP OFFLINE
ALTER DATABASE TENCSDL SET OFFLINE
--SAU KHI THAY ĐỔI XONG THÌ CHUYỂN TRẠNG THÁI SANG ONLINE
ALTER DATABASE TENCSDL SET ONLINE
-- THIẾT LẬP KẾT NỐI ĐA NGƯỜI DÙNG
ALTER DATABASE TENCSDL SET MULTI_USER

--THU HẸP TOÀN BỘ CSDL
DBCC SHRINKDATABASE
(
TENCSDL|id_CSDL|0 -- 0 LÀ CSDL MẶC ĐỊNH
,TỈ LỆ
,{NOTRUNCATE,TRUNCATEONLY}

);

--THU HẸP FILE CSDU(CỤ THỂ)
USE DATABASE TENCSDL
DBCC SHRINKDATABASE
(
{TEN_FILE|id_FILE}
,EMPTYFILE|KÍCH THƯỚC FILE,
{NOTRUNCATE|TRUNCATEONLY}

);

--THÊM FILE VÀO CSDL
ALTER DATABASE TENCSDL
ADD FILE[TO FILEGROUP tên_nhóm]
	|LOG FILE
(
NAME,
FILENAME='.NDF',
SIZE,
MAXISZE,
FILEGROUP


);
--NẾU THÊM NHIỀU FILE THÌ CUỐI MỖI FILE PHẢI CÓ DẤU , VÀ FILE CUỐI CÙNG KẾT THÚC BẰNG DẤU ;  VÍ DỤ:(...),(...),(...);

--GỠ FILE KHỎI CSDL
--B1: LÀM TRỐNG FILE CẦN LOẠI BỎ
DBCC SHRINKDATABASE(TÊN_FILE,EMPTYFILE);
--B2: GỠ FILE KHỎI CSDL
ALTER DATABASE TENCSDL
REMOVE FILE TEN_FILE_LOGIC

--ĐỔI TÊN CSDL
--Có 2 cách đổi tên csdl
--c1: dùng modify name
alter database TENCSDL
modify name= tên_CSDL_mới;
--c2:dùng thủ tục sp_renamedb
sp_renamedb'tên_csdl_cũ','tên_csdl_mới'
--lưu ý: csdl phải ở chế độ 1 người dùng
-- phải làm việc trong csdl chính để thực thi thủ tục

--gỡ bỏ csdl
drop database TENCSDL
--bản chụp csdl
create database tên_bản_chụp on
(
name= tên_file_logic,
filename='file_vật_lý.ndf'
),(các bản chụp khác nếu có)
as snapshot tên_csdl_gốc;

--ưu điểm của bản chụp csdl
/*
là bản copy chỉ đọc của csdl
khi bản chụp được truy vấn thì sẽ không làm giảm hiểu xuất của đối tượng được quan sát
các file dữ liệu trong bản chụp rất nhỏ và đươc tạo rất nhanh, nó chỉ lớn dữ liệu trong csdl thay đổi thường xuyên
bản chụp được sử dụng trong các mục đích báo cáo,bảo vệ dữ liệu khỏi các lỗi quản trị, lỗi người dùng và quản lý các dữ liệu thử nghiệm
*/
/*
nhược điểm
bản chụp không thể tạo ra bản sao
bản chụp phải cùng tồn tại trên 1 máy chủ csdl với csdl gốc
một người dùng mới không có quyền truy cập bản chụp mà quyền truy cập được kế thừa từ csdl gốc tại thời điểm tạo ra bản chup
*/

--filegroup
--là một tập tin chứa các file dữ liệu chứ không chứa dữ liệu
--filegroup không thể chứa file log
--file group mặt định là primary
--file group có thể tạo cùng với csdl hoặc thêm vào sau
-- một file không thể thuộc nhiều hơn 1 filegroup tại cùng 1 thời điểm
--không thẻ thay đổi file group của 1 file trong csdl

--thêm file group khi tạo csdl
create database tencsdl
on primary
(
--định nghĩa cho file
),
filegroup
(
--định nghĩa file group

),
log on
(

--định nghĩa file log
);

--thêm file group vào csdl đã có
alter database tencsdl
add filegroup ten_filegroup

--thêm file vào file group
alter database tencsdl
add filegroup ten_file_group
--thêm file
alter database tencsdl
add file
(
--định nghĩa file
)
to filegroup ten_file_group;

--schema
/*
thuận lợi để để tách, quản lý, quyền sở hữu đối tượng CSDL, nâng cao quản trị an ning của đối tượng

schema mặt định là dbo
tên của schema là duy nhất luôn có tên với trường đầy đủ dạng sever.database.schema.object
ưu điểm
nhóm các đối tượng lại với nhau cho dễ quản lý
cho phép phân quyền ở schema tăng tính bảo mật

*/
create schema tenschema
--xóa schema
drop schema tenschema;

--thay đổi schema
--đối với kiêu dữ liệu người dùng định nghĩa
alter schema tên_schema_mới
transfer type:: tên_schema_cũ.usertype
--đối với đối tượng người dùng định nghĩa
create schema tên_schema_mới
transfer object tên_schema_cũ.đối tượng

/*
kiểu dữ liệu
số nguyên
BigInt		8 byte
Int			4 byte
smallInt	2 byte
TinyInt		1 byte
Bit			1 byte

số thực
decemar(p,s)	5-17 byte
Dec(p,s)		5-17 byte
Numeric(p,s)	5-17 byte
p:tổng số chữ số mặc định là 18
s:tổng số chữ số thập phân mặc định là 0

float	4-8 byte
real	tương đương với float(24)

kiểu tiền tệ
money		8 byte
SmallMoney	4 byte

kiểu ký tự
char	tối đa 8000 kí tự mỗi ký tự là 1 byte
Nchar	tối đa 4000 kí tự mỗi kí tự là 2 byte chứa các ký tự unicode
varchar tối đa 8000 ký tự ...................
nvarchar tối đa 4000 ký tự.................... chứa các ký tự unicode
binary tối đa 8000 ký tự mỗi kí tự là 1 byte và dùng để chứ các giá trị nhị phân
Nbinary tương tự nhi binary

kiêu ngày giờ
date				yyyy-mm-dd
datetime			yyyy-mm-dd hh:mm:ss
datetime2(ps)
smalldatetime
Time(ps)
datetimeofset(ps)(múi giờ)

*/
--tạo kiểu dữ liệu
create type [tenschema].tênkieudulieu from kiểu_dữ_liệu_gốc [null| not null]

--tạo kiểu dữ liệu kiểu bảng
create type [tenschema].tenkieudulieu
as table
(
định nghĩa table
,primary key|unique(
các khóa [asc|desc]
)
,
index  tenindex
(

cột index[asc,desc]
)
check(điều kiện)
)



--xóa kiểu dữ liệu
drop type [schema].tên_schema;
-- muốn thay đổi csdl thì phải thay đổi không thể dùng alter mà phải xóa kiểu dữ liệu và tạo lại kiểu dữ liêu với các thông số mới

