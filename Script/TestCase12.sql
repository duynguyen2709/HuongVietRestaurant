use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện lọc danh sách voucher theo giá rị % khuyến mãi trong khi chưa hoàn thành
	thì có một quản lý khác thêm mjt voucher có giá trị thỏa điều kiện lọc vào cơ sở dữ liệu.
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng kết quả sau khi 2 giao tác được thực hiện.
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Lọc món voucher theo giá trị)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Thêm một voucher vào cơ sở dữ liệu)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists LocVoucherTheoGiaTri_Phantom
go
create procedure LocVoucherTheoGiaTri_Phantom
	@GiaTri bigint
as
begin tran
	select Count(*) from ChuongTrinhKhuyenMai
	where GiaTri <= @GiaTri

	WaitFor Delay '00:00:10'

	select * from ChuongTrinhKhuyenMai
	where GiaTri <= @GiaTri
commit
go

--PROCEDURE 2
drop procedure if exists ThemVoucher_Phantom_T2
go
create procedure ThemVoucher_Phantom_T2
	@TenChuongTrinh nvarchar(512),
	@MaLoai int,
	@DoiTuongApDung int,	
	@GiaTri bigint,
	@NgayBatDat date,
	@NgayKetThuc date,
	@SoLuong int
as
begin tran
	insert into ChuongTrinhKhuyenMai (TenChuongTrinh, MaLoai, DoiTuongApDung,  GiaTri, NgayBatDau, NgayKetThuc, SoLuong)
	values (@TenChuongTrinh, @MaLoai, @DoiTuongApDung,  @GiaTri, @NgayBatDat, @NgayKetThuc, @SoLuong)
commit
go

-- PROCEDURE 1 FIXED
drop procedure if exists LocVoucherTheoGiaTri_fixed
go
create procedure LocVoucherTheoGiaTri_fixed
	@GiaTri bigint
as
begin tran
	select Count(*) from ChuongTrinhKhuyenMai with (Serializable) 
	where GiaTri <= @GiaTri

	WaitFor Delay '00:00:10'

	select * from ChuongTrinhKhuyenMai
	where GiaTri <= @GiaTri
commit
go

/* TRANSACTION */
--T1
EXEC [dbo].LocVoucherTheoGiaTri_Phantom @GiaTri= 10;
--T2
EXEC [dbo].ThemVoucher_Phantom_T2 @TenChuongTrinh = "Khai trương chi nhánh mới", @MaLoai = 1, @DoiTuongApDung = 1, @GiaTri = 30, @NgayBatDat = "2019-10-21" , @NgayKetThuc = "2019-12-21" , @SoLuong =100;

--T1 Fixed
EXEC [dbo].LocVoucherTheoGiaTri_fixed @GiaTri =10;