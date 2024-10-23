
create procrdure dsnv (@dc nvarchar(50) as
begin 
declare @contro cursor;

set @contro = cursor for
select HONV +' ' +TENNV
from NHANVIEN
where DCHI like N'%'+@dc+N'%';
open @contro;
declare @hoten nvarchar(50);
declare @i int= 0;
fetch next from @contro into @hoten;
while (@@FETCH_STATUS = 0)
begin
declare @i = i+1;
print convert(varchar(4),@i) + '.'+ @hoten;

end;
close @contro;
deallocare @contro;

end;




--Câu 26
select nv.HONV+ ' ' + nv.TENNV, COUNT(pc.soda)
from NHANVIEN nv
left join Phancong pc on nv.MANV = pc.ma_nvien
where nv.MANV = '001'
group by nv.HONV,nv.TENNV


create procedure cau26(@manv varchar(99),@hoten nvarchar(50) output, @sl int output)
as 
begin

select @hoten=nv.HONV+ ' ' + nv.TENNV,@sl = COUNT(pc.soda)
from NHANVIEN nv
left join Phancong pc on nv.MANV = pc.ma_nvien
where nv.MANV = @manv
group by nv.HONV,nv.TENNV




end;


--sử dụng procedure

begin

declare @ht nvarchar(50);
declare @S int;

exec dbo.cau26 '001' @ht @s;
print @ht
print @s;

end;

-------------------------------------------------------------------------------

create function cau26(@manv varchar(9)) return int )
as 
begin
declare @soluong int;

select nv.MANV ,@soluong = COUNT(pc.soda)
from NHANVIEN nv
left join Phancong pc on nv.MANV = pc.ma_nvien
where nv.MANV = @manv
group by nv.MANV;

return @soluong;



end;

----------------------
sử dụng hàm
print dbo.cau26f('001');