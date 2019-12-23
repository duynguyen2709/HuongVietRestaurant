use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện thêm một voucher với số lượng ít hơn 0 trong lúc đó
	một quản lý khác thực hiện xem danh sách tất cả các vuocher đang được áp dụng.
	=> trả về kết quả bao gồm món ăn 0đ (đáng lẽ không xuất hiện).
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Thêm một voucher không thỏa điều kiện số lượng > 0)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Xem danh sách voucher)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists ThemVoucher_DirtyRead_T1
go
create procedure ThemVoucher_DirtyRead_T1
	@TenChuongTrinh nvarchar(512),
	@MaLoai int,
	@DoiTuongApDung int,
	@GiaTri bigint,
	@NgayBatDat date,
	@NgayKetThuc date,
	@SoLuong int
as
begin tran
	insert into ChuongTrinhKhuyenMai (TenChuongTrinh, MaLoai, DoiTuongApDung, GiaTri, NgayBatDau, NgayKetThuc, SoLuong)
	values (@TenChuongTrinh, @MaLoai, @DoiTuongApDung, @GiaTri, @NgayBatDat, @NgayKetThuc, @SoLuong)

	waitfor delay '00:00:10'

	if(@SoLuong <= 0)
		rollback
commit
go

--PROCEDURE 2
drop procedure if exists XemVoucher_DirtRead_T2
go
create procedure XemVoucher_DirtRead_T2
as
begin tran
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select *
from ChuongTrinhKhuyenMai
commit tran
go

-- PROCEDURE 2 FIXED
drop procedure if exists XemVoucher_DirtRead_T2_fixed
go
create procedure XemVoucher_DirtRead_T2_fixed
as
begin tran
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
select *
from ChuongTrinhKhuyenMai
commit tran
go

/* TRANSACTION */
--T1
EXEC [dbo].ThemVoucher_Phantom_T2 @TenChuongTrinh = "Khai trương chi nhánh mới", @MaLoai = 1, @DoiTuongApDung = 1, @GiaTri = 30, @NgayBatDat = "2019-10-21" , @NgayKetThuc = "2019-12-21" , @SoLuong =0;
--T2
EXEC [dbo].XemVoucher_DirtRead_T2;
--T1 Fixed
EXEC [dbo].XemVoucher_DirtRead_T2_fixed;