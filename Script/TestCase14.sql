use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện giảm số lượng món ăn trong chi tiết một đơn hàng chưa commit thì
	một quản lý khác thực hiện giảm số lượng cùng một món ăn trong cùng một đơn hàng
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng của món ăn
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Giảm số lượng món ăn trong chi tiết đơn hàng)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Giảm số lượng món ăn trong chi tiết đơn hàng)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate
go
create procedure GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietDonHang WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SELECT SoLuong 
FROM ChiTietDonHang WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

WaitFor Delay '00:00:10'
SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE ChiTietDonHang SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SELECT SoLuong 
FROM ChiTietDonHang WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang
--Print @SoLuongHienTai
Commit Transaction
go


-- PROCEDURE FIXED
drop procedure if exists GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate_fixed
go
create procedure GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate_fixed
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietDonHang with (updlock) WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SELECT SoLuong 
FROM ChiTietDonHang with (updlock) WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

WaitFor Delay '00:00:10'
SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE ChiTietDonHang SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SELECT SoLuong 
FROM ChiTietDonHang with (updlock) WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang
--Print @SoLuongHienTai
Commit Transaction
go
/* TRANSACTION */
--T1
EXEC [dbo].GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate @MaDonHang =1 , @MaMonAn =3 ,@SoLuong =1;
--T2
EXEC [dbo].GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate @MaDonHang =1 , @MaMonAn =3 ,@SoLuong =1;
--T1 Fixed
EXEC [dbo].GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate_fixed @MaDonHang =1 , @MaMonAn =3 ,@SoLuong =1;