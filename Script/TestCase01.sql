use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện giảm số lượng một món ăn trong lúc thao tác chưa được hoàn tất 
	thì có một quản lý khác đồng thời cập nhật lại số lượng của cùng món ăn 
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng của món ăn sau khi 2 giao tác được thực hiện.
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Giảm số lượng món ăn)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Cập nhật số lượng món ăn)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists GiamSoLuongMonAn_UnrepeatableRead
go
create procedure GiamSoLuongMonAn_UnrepeatableRead
	@MaMonAn int,
	@SoLuong int
as
	BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM MonAn WHERE MaMonAn = @MaMonAn

SELECT SoLuong as SoLuongBanDau
FROM MonAn WHERE MaMonAn = @MaMonAn

--Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback

WaitFor Delay '00:00:5'

SELECT @SoLuongHienTai = SoLuong 
FROM MonAn WHERE MaMonAn = @MaMonAn

SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE MonAn SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

SELECT SoLuong as SoLuongSau
FROM MonAn WHERE MaMonAn = @MaMonAn

--Print @SoLuongHienTai
Commit Transaction
go

-- PROCEDURE 2
drop procedure if exists CapNhapSoLuongMonAn
go
create procedure CapNhapSoLuongMonAn
	@MaMonAn int,
	@SoLuong int
as
	update MonAn set SoLuong = @SoLuong where  MaMonAn = @MaMonAn
go

-- PROCEDURE 1 - FIXED
drop procedure if exists GiamSoLuongMonAn_UnrepeatableRead_fixed
go
create procedure GiamSoLuongMonAn_UnrepeatableRead_fixed
	@MaMonAn int,
	@SoLuong int
as
	
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM MonAn with (RepeatableRead) WHERE MaMonAn = @MaMonAn

SELECT SoLuong as SoLuongBanDau
FROM MonAn with (RepeatableRead) WHERE MaMonAn = @MaMonAn

--Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback

WaitFor Delay '00:00:10'

SELECT @SoLuongHienTai = SoLuong 
FROM MonAn WHERE MaMonAn = @MaMonAn



SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE MonAn SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

SELECT SoLuong as SoLuongSau
FROM MonAn with (RepeatableRead) WHERE MaMonAn = @MaMonAn

--Print @SoLuongHienTai
Commit Transaction
go


/* TRANSACTION */
--T1
EXEC [dbo].GiamSoLuongMonAn_UnrepeatableRead @MaMonAn = 1, @SoLuong = 2;
GO
--T1 (FIXED)
EXEC [dbo].GiamSoLuongMonAn_UnrepeatableRead_fixed @MaMonAn = 1, @SoLuong = 2;
GO
--T2
EXEC [dbo].CapNhapSoLuongMonAn @MaMonAn = 1, @SoLuong =1;
GO
