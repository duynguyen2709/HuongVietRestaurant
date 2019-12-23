use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện giảm số lượng món ăn trong 1 đơn hàng trong lúc thao tác chưa được hoàn tất 
	thì có một quản lý khác đồng thời cập nhật lại số lượng món ăn trong cùng đơn hàng
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng của món ăn khi 2 giao tác được thực hiện.
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Giảm số lượng môt món ăn trong đơn hàng)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Cập nhật số lượng món ăn trong đơn hàng)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead
go
create procedure GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietDonHang 
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SELECT SoLuong as SoLuongBanDau
FROM ChiTietDonHang 
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

--Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback
WaitFor Delay '00:00:05'

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietDonHang WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang



SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE ChiTietDonHang SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SELECT SoLuong as SoLuongSau
FROM ChiTietDonHang 
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

--Print @SoLuongHienTai
Commit Transaction
go

-- PROCEDURE 2
drop procedure if exists CapNhapSoLuongMonAnTrongChiTietDonHang
go
create procedure CapNhapSoLuongMonAnTrongChiTietDonHang
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
	update ChiTietDonHang set SoLuong = @SoLuong where  MaDonHang = @MaDonHang and MaMonAn = @MaMonAn
go

-- PROCEDURE 1 fixed
drop procedure if exists GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead_fixed
go
create procedure GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead_fixed
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietDonHang with (RepeatableRead) 
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SELECT SoLuong as SoLuongBanDau
FROM ChiTietDonHang with (RepeatableRead) 
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback
WaitFor Delay '00:00:05'

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietDonHang WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang



SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE ChiTietDonHang SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SELECT SoLuong as SoLuongSau
FROM ChiTietDonHang with (RepeatableRead) 
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

--Print @SoLuongHienTai
Commit Transaction
go


/* TRANSACTION */
--T1
EXEC [dbo].GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead @MaDonHang = 1, @MaMonAn = 3, @SoLuong =1;
GO
--T1 (FIXED)
EXEC [dbo].GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead_fixed @MaDonHang = 1, @MaMonAn = 3, @SoLuong =1;
GO
--T2
EXEC [dbo].CapNhapSoLuongMonAnTrongChiTietDonHang @MaDonHang = 1, @MaMonAn = 3, @SoLuong = 5;
GO