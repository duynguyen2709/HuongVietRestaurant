use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện giảm số lượng món ăn chưa commit thì
	một quản lý khác thực hiện giảm số lượng cùng một món ăn
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng của món ăn
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Giảm số lượng món ăn)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Giảm số lượng món ăn)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists GiamSoLuongMonAn_LostUpdate
go
create procedure GiamSoLuongMonAn_LostUpdate
	@MaMonAn int,
	@SoLuong int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM MonAn WHERE MaMonAn = @MaMonAn 

SELECT SoLuong 
FROM MonAn WHERE MaMonAn = @MaMonAn 

WaitFor Delay '00:00:10'
SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE MonAn SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

SELECT SoLuong 
FROM MonAn WHERE MaMonAn = @MaMonAn 

--Print @SoLuongHienTai
Commit Transaction
go


-- PROCEDURE 1 FIXED
drop procedure if exists GiamSoLuongMonAn_LostUpdate_fixed
go
create procedure GiamSoLuongMonAn_LostUpdate_fixed
	@MaMonAn int,
	@SoLuong int
as
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM MonAn with (updlock) WHERE MaMonAn = @MaMonAn 

SELECT SoLuong 
FROM MonAn with (updlock) WHERE MaMonAn = @MaMonAn

WaitFor Delay '00:00:10'
SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE MonAn SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

SELECT SoLuong 
FROM MonAn with (updlock) WHERE MaMonAn = @MaMonAn
--Print @SoLuongHienTai
Commit Transaction
go

/* TRANSACTION */
--T1
EXEC [dbo].GiamSoLuongMonAn_LostUpdate @MaMonAn = 1, @SoLuong =1;
--T2
EXEC [dbo].GiamSoLuongMonAn_LostUpdate @MaMonAn = 1, @SoLuong =1;
--T1 Fixed
EXEC [dbo].GiamSoLuongMonAn_LostUpdate_fixed @MaMonAn = 1, @SoLuong =1;