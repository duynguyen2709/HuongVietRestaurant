use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Hai quản lý cùng cập nhật thông tin của một thành viên
	=> gây ra deadlock dẫn đến treo giao tác
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Cập nhật thông tin thành viên)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Cập nhật thông tin cùng một nhân viên)
*/
/* PROCEDURE */
-- PROCEDURE 
drop procedure if exists CapNhapThanhVien_Deadlock
go
create procedure CapNhapThanhVien_Deadlock
	@MaThanhVien int,
	@MaChiNhanh int,
	@TenThanhVien nvarchar(256),
	@CMND nvarchar(12),
	@SoDienThoai nvarchar(10),
	@Email nvarchar(256),
	@NgaySinh date,
	@DiaChi nvarchar(256), 
	@DiemTichLuy bigint
as
begin tran
	set tran isolation level repeatable read
	select * from ThanhVien where MaThanhVien = @MaThanhVien

	WaitFor Delay '00:00:05'

	update ThanhVien
	set MaChiNhanh = @MaChiNhanh,
	HoTen = @TenThanhVien,
	CMND = @CMND,
	SoDienThoai = @SoDienThoai,
	Email = @Email,
	NgaySinh = @NgaySinh,
	DiaChi = @DiaChi, 
	DiemTichLuy = @DiemTichLuy
	where MaThanhVien = @MaThanhVien
commit
go


-- PROCEDURE FIXED
drop procedure if exists CapNhapThanhVien_Deadlock_fixed
go
create procedure CapNhapThanhVien_Deadlock_fixed
	@MaThanhVien int,
	@MaChiNhanh int,
	@TenThanhVien nvarchar(256),
	@CMND nvarchar(12),
	@SoDienThoai nvarchar(10),
	@Email nvarchar(256),
	@NgaySinh date,
	@DiaChi nvarchar(256), 
	@DiemTichLuy bigint
as
begin tran
	set tran isolation level repeatable read
	select * from ThanhVien with (updlock) where MaThanhVien = @MaThanhVien

	WaitFor Delay '00:00:10'

	update ThanhVien
	set HoTen = @TenThanhVien,
	MaChiNhanh = @MaChiNhanh,
	CMND = @CMND,
	SoDienThoai = @SoDienThoai,
	Email = @Email,
	NgaySinh = @NgaySinh,
	DiaChi = @DiaChi, 
	DiemTichLuy = @DiemTichLuy
	where MaThanhVien = @MaThanhVien
commit
go

/* TRANSACTION */
--T1
EXEC [dbo].CapNhapThanhVien_Deadlock @MaThanhVien =1 , @MaChiNhanh =1, @TenThanhVien  = "Võ Văn T", @CMND="0912345567" , @SoDienThoai = "0123345667", @Email = "shdk@gmail.com", @NgaySinh="1995-12-10", @DiaChi= "sjfkhsjkd", @DiemTichLuy = 100000;
--T2
EXEC [dbo].CapNhapThanhVien_Deadlock @MaThanhVien =1 , @MaChiNhanh =1, @TenThanhVien  = "Võ Văn T", @CMND="0912345567" , @SoDienThoai = "0123345667", @Email = "shdk@gmail.com", @NgaySinh="1995-12-10", @DiaChi= "sjfkhsjkd", @DiemTichLuy = 100000;
--T1 Fixed
EXEC [dbo].CapNhapThanhVien_Deadlock_fixed @MaThanhVien =1 , @MaChiNhanh =1, @TenThanhVien  = "Võ Văn T", @CMND="0912345567" , @SoDienThoai = "0123345667", @Email = "shdk@gmail.com", @NgaySinh="1995-12-10", @DiaChi= "sjfkhsjkd", @DiemTichLuy = 100000;