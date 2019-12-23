use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện dùng một voucher chưa commit thì
	một quản lý khác cũng thực hiện dùng cùng một voucher
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng còn lại của voucher
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Dùng voucher)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Dùng voucher)
*/
/* PROCEDURE */
-- PROCEDURE 
drop procedure if exists DungVoucher_LostUpdate
go
create procedure DungVoucher_LostUpdate
	@MaKhuyenMai int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChuongTrinhKhuyenMai WHERE MaKhuyenMai = @MaKhuyenMai 
SELECT SoLuong 
FROM ChuongTrinhKhuyenMai WHERE MaKhuyenMai = @MaKhuyenMai 

SET @SoLuongHienTai = @SoLuongHienTai - 1
WaitFor Delay '00:00:05'
UPDATE ChuongTrinhKhuyenMai SET SoLuong = @SoLuongHienTai
WHERE MaKhuyenMai = @MaKhuyenMai

SELECT SoLuong 
FROM ChuongTrinhKhuyenMai WHERE MaKhuyenMai = @MaKhuyenMai 
--Print @SoLuongHienTai
Commit Transaction
go

-- PROCEDURE FIXED
drop procedure if exists DungVoucher_LostUpdate_fixed
go
create procedure DungVoucher_LostUpdate_fixed
	@MaKhuyenMai int
as
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChuongTrinhKhuyenMai with (updlock) WHERE MaKhuyenMai = @MaKhuyenMai 

SELECT SoLuong 
FROM ChuongTrinhKhuyenMai with (updlock) WHERE MaKhuyenMai = @MaKhuyenMai 

SET @SoLuongHienTai = @SoLuongHienTai - 1
WaitFor Delay '00:00:05'
UPDATE ChuongTrinhKhuyenMai SET SoLuong = @SoLuongHienTai
WHERE MaKhuyenMai = @MaKhuyenMai

SELECT SoLuong 
FROM ChuongTrinhKhuyenMai with (updlock) WHERE MaKhuyenMai = @MaKhuyenMai 
--Print @SoLuongHienTai
Commit Transaction
go
/* TRANSACTION */
--T1
EXEC [dbo].DungVoucher_LostUpdate @MaKhuyenMai =1;
--T2
EXEC [dbo].DungVoucher_LostUpdate @MaKhuyenMai =1;
--T1 Fixed
EXEC [dbo].DungVoucher_LostUpdate_fixed @MaKhuyenMai =1;