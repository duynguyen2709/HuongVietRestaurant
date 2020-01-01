use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Hai quản lý cùng cập nhật thông tin 1 chương trình khuyến mãi
	=> gây ra deadlock dẫn đến treo giao tác
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Cập nhật thông tin một chương trình khuyến mãi)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Cập nhật thông tin cùng một chương trình khuyến mãi)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists CapNhapVoucher_Deadlock
go
create procedure CapNhapVoucher_Deadlock
	@MaKhuyenMai int,
	@GiaTri nvarchar(256)
as
begin tran
	set tran isolation level repeatable read
	select * from ChuongTrinhKhuyenMai where MaKhuyenMai = @MaKhuyenMai

	WaitFor Delay '00:00:10'

	update ChuongTrinhKhuyenMai
	set GiaTri = @GiaTri
	where MaKhuyenMai = @MaKhuyenMai
commit
go


-- PROCEDURE 1 FIXED
drop procedure if exists CapNhapVoucher_Deadlock_fixed
go
create procedure CapNhapVoucher_Deadlock_fixed
	@MaKhuyenMai int,
	@GiaTri nvarchar(256)
as
begin tran
	set tran isolation level repeatable read
	select * from ChuongTrinhKhuyenMai with (updlock) where MaKhuyenMai = @MaKhuyenMai

	WaitFor Delay '00:00:10'

	update ChuongTrinhKhuyenMai
	set GiaTri = @GiaTri
	where MaKhuyenMai = @MaKhuyenMai
commit
go

/* TRANSACTION */
--T1
EXEC [dbo].CapNhapVoucher_Deadlock @MaKhuyenMai =1, @GiaTri =15;
--T2
EXEC [dbo].CapNhapVoucher_Deadlock @MaKhuyenMai =1, @GiaTri =15;
--T1 Fixed
EXEC [dbo].CapNhapVoucher_Deadlock_fixed @MaKhuyenMai =1, @GiaTri =15;