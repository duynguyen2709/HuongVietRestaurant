use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện lọc danh sách thành viên theo điểm tích lũy trong khi chưa hoàn thành
	thì có một quản lý khác thêm thành viên vào cơ sở dữ liệu.
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng kết quả sau khi 2 giao tác được thực hiện.
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Lọc món ăn theo giá)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Thêm một món ăn vào cơ sở dữ liệu)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists LocThanhVienTheoDiem_Phantom
go
create procedure LocThanhVienTheoDiem_Phantom
	@Diem bigint
as
begin tran
	select Count(*) from ThanhVien
	where DiemTichLuy <= @Diem

	WaitFor Delay '00:00:10'

	select * from ThanhVien
	where DiemTichLuy <= @Diem
commit
go
--PROCEDURE 2
drop procedure if exists ThemThanhVien_Phantom_T2
go
create procedure ThemThanhVien_Phantom_T2
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
commit tran
go

-- PROCEDURE 1 FIXED
drop procedure if exists LocThanhVienTheoDiem_fixed
go
create procedure LocThanhVienTheoDiem_fixed
	@Diem bigint
as
begin tran
	select Count(*) from ThanhVien with (Serializable) 
	where DiemTichLuy <= @Diem

	WaitFor Delay '00:00:10'

	select * from ThanhVien
	where DiemTichLuy <= @Diem
commit
go

/* TRANSACTION */
--T1
EXEC [dbo].LocThanhVienTheoDiem_Phantom @Diem =1000;
--T2
EXEC [dbo].ThemThanhVien_Phantom_T2 @MaChiNhanh =1 , @HoTen = "Võ Văn A", @CMND="012345678", @SoDienThoai = "09312456789" ,@Email ="abc@gmail.com", @NgaySinh = "1998-07-08",@DiaChi = "abc def", @DiemTichLuy = 0;
--T1 Fixed
EXEC [dbo].LocThanhVienTheoDiem_fixed @Diem =1000;