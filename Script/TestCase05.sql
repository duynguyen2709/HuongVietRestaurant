use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Hai quản lý cùng cập nhật món ăn
	=> gây ra deadlock dẫn đến treo giao tác
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Cập nhật món ăn)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Cập nhật món ăn)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists CapNhapMonAn_Deadlock
go
create procedure CapNhapMonAn_Deadlock
	@MaMonAn int,
	@TenMonAn nvarchar(256),
	@URLHinhMonAn nvarchar(256),
	@MoTa nvarchar(2048), 
	@Gia bigint
as
begin tran
	set tran isolation level repeatable read
	select * from  MonAn  where MaMonAn = @MaMonAn 
	WaitFor Delay '00:00:10'
	update MonAn
	set TenMonAn = @TenMonAn,
	URLHinhMonAn = @URLHinhMonAn,
	MoTa = @MoTa,
	Gia = @Gia
	where MaMonAn = @MaMonAn
commit
go


-- PROCEDURE 1 FIXED
drop procedure if exists CapNhapMonAn_Deadlock_fixed
go
create procedure CapNhapMonAn_Deadlock_fixed
	@MaMonAn int,
	@TenMonAn nvarchar(256),
	@URLHinhMonAn nvarchar(256),
	@MoTa nvarchar(2048), 
	@Gia bigint
as
begin tran
	set tran isolation level repeatable read
	select * from MonAn with (updlock) where MaMonAn = @MaMonAn 

	WaitFor Delay '00:00:10'

	update MonAn
	set TenMonAn = @TenMonAn,
	URLHinhMonAn = @URLHinhMonAn,
	MoTa = @MoTa,
	Gia = @Gia
	where MaMonAn = @MaMonAn
commit
go

/* TRANSACTION */
--T1
EXEC [dbo].CapNhapMonAn_Deadlock @MaMonAn = 1, @TenMonAn="Cơm gà Hải Nam", @URLHinhMonAn = "  ",@MoTa= "abc", @Gia= 35000;
--T2
EXEC [dbo].CapNhapMonAn_Deadlock @MaMonAn = 1, @TenMonAn="Cơm gà Hải Nam", @URLHinhMonAn = "  ",@MoTa= "abc", @Gia= 35000;
--T1 Fixed
EXEC [dbo].CapNhapMonAn_Deadlock_fixed @MaMonAn = 1, @TenMonAn="Cơm gà Hải Nam", @URLHinhMonAn = "  ",@MoTa= "abc", @Gia= 35000;