use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện giảm số lượng một voucher trong lúc thao tác chưa được hoàn tất 
	thì có một quản lý khác đồng thời cập nhật lại số lượng voucher
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng của voucher khi 2 giao tác được thực hiện.
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Dùng 1 voucher)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Cập nhật số lượng voucher)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists DungVoucher_UnrepeatableRead
go
create procedure DungVoucher_UnrepeatableRead
	@MaKhuyenMai int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChuongTrinhKhuyenMai 
WHERE MaKhuyenMai = @MaKhuyenMai

SELECT SoLuong as SoLuongBanDau
FROM ChuongTrinhKhuyenMai 
WHERE MaKhuyenMai = @MaKhuyenMai

--Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback

WaitFor Delay '00:00:10'

SELECT @SoLuongHienTai = SoLuong 
FROM ChuongTrinhKhuyenMai
WHERE MaKhuyenMai = @MaKhuyenMai



SET @SoLuongHienTai = @SoLuongHienTai - 1

UPDATE ChuongTrinhKhuyenMai SET SoLuong = @SoLuongHienTai
WHERE MaKhuyenMai = @MaKhuyenMai

SELECT SoLuong as SoLuongSau
FROM ChuongTrinhKhuyenMai 
WHERE MaKhuyenMai = @MaKhuyenMai

--Print @SoLuongHienTai
Commit Transaction
go

-- PROCEDURE 2
drop procedure if exists CapNhapSoLuongVoucher
go
create procedure CapNhapSoLuongVoucher
	@MaVoucher int,
	@SoLuong int
as
	update ChuongTrinhKhuyenMai set SoLuong = @SoLuong where MaKhuyenMai = @MaVoucher
go

-- PROCEDURE 1 fixed
drop procedure if exists DungVoucher_UnrepeatableRead_fixed
go
create procedure DungVoucher_UnrepeatableRead_fixed
	@MaKhuyenMai int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChuongTrinhKhuyenMai with (RepeatableRead) 
WHERE MaKhuyenMai = @MaKhuyenMai 

SELECT SoLuong as SoLuongBanDau
FROM ChuongTrinhKhuyenMai with (RepeatableRead) 
WHERE MaKhuyenMai = @MaKhuyenMai 

Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback

WaitFor Delay '00:00:05'

SELECT @SoLuongHienTai = SoLuong 
FROM ChuongTrinhKhuyenMai
WHERE MaKhuyenMai = @MaKhuyenMai


SET @SoLuongHienTai = @SoLuongHienTai - 1

UPDATE ChuongTrinhKhuyenMai SET SoLuong = @SoLuongHienTai
WHERE MaKhuyenMai = @MaKhuyenMai

SELECT SoLuong as SoLuongSau
FROM ChuongTrinhKhuyenMai
WHERE MaKhuyenMai = @MaKhuyenMai 

--Print @SoLuongHienTai
Commit Transaction
go

/* TRANSACTION */
--T1
EXEC [dbo].DungVoucher_UnrepeatableRead @MaKhuyenMai = 1;
GO
--T1 (FIXED)
EXEC [dbo].DungVoucher_UnrepeatableRead_fixed @MaKhuyenMai =1;
GO
--T2
EXEC [dbo].CapNhapSoLuongVoucher @MaVoucher=1, @SoLuong =10;
GO