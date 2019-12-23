use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện thêm một thành viên với só CMND không hợp lệ trong lúc đó
	một quản lý khác thực hiện xem danh sách tất cả các thành viên
	=> trả về kết quả bao gồm thành viên có CMND không hợp lệ (đáng lẽ không xuất hiện).
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Thêm một thành viên có CMND không hợp lệ)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Xem danh sách thành viên)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists ThemThanhVien_DirtyRead_T1
go
create procedure ThemThanhVien_DirtyRead_T1
	@MaChiNhanh int,
	@HoTen nvarchar(256),
	@CMND nvarchar(12),
	@SoDienThoai nvarchar(10),
	@Email nvarchar(256),
	@NgaySinh date,
	@DiaChi nvarchar(256), 
	@DiemTichLuy bigint
as
begin tran
	insert into ThanhVien (MaChiNhanh, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy)
	values (@MaChiNhanh, @HoTen, @CMND, @SoDienThoai, @Email, @NgaySinh, @DiaChi, @DiemTichLuy)

	waitfor delay '00:00:10'

	if(len(@CMND) != 10)
		rollback
commit tran
go

--PROCEDURE 2
drop procedure if exists XemThanhVien_DirtRead_T2
go
create procedure XemThanhVien_DirtRead_T2
as
begin tran
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select MaThanhVien, MaChiNhanh, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy 
from ThanhVien
commit tran
go

-- PROCEDURE 2 FIXED
drop procedure if exists XemThanhVien_DirtRead_T2_fixed
go
create procedure XemThanhVien_DirtRead_T2_fixed
as
begin tran
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
select MaThanhVien, MaChiNhanh, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy 
from ThanhVien
commit tran
go

/* TRANSACTION */
--T1
EXEC [dbo].ThemThanhVien_DirtyRead_T1 @MaChiNhanh =1 , @HoTen = "Võ Văn A", @CMND="012345678", @SoDienThoai = "09312456789" ,@Email ="abc@gmail.com", @NgaySinh = "1998-07-08",@DiaChi = "abc def", @DiemTichLuy = 0;
--T2
EXEC [dbo].XemThanhVien_DirtRead_T2;
--T2 Fixed
EXEC [dbo].XemThanhVien_DirtRead_T2_fixed;