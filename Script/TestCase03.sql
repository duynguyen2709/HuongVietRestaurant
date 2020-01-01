use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện thêm một món ăn với giá 0đ trong lúc đó
	một quản lý khác thực hiện xem danh sách tất cả các món ăn
	=> trả về kết quả bao gồm món ăn 0đ (đáng lẽ không xuất hiện).
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Thêm một món ăn không thỏa điều kiện giá > 0)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Xem danh sách món ăn)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists ThemMotMonAn_DirtyRead_T1
go
create procedure ThemMotMonAn_DirtyRead_T1
	@TenMonAn nvarchar(256),
	@MaLoai int,
	@URLHinhMonAn nvarchar(256),
	@MoTa nvarchar(2048),
	@Gia bigint,
	@SoLuong int
as
begin tran
	insert into MonAn(TenMonAn, MaLoai, URLHinhMonAn, MoTa, Gia, SoLuong)
	values (@TenMonAn, @MaLoai, @URLHinhMonAn, @MoTa, @Gia, @SoLuong)

	waitfor delay '00:00:10'

	if(@gia = 0)
		rollback
commit tran
go

--PROCEDURE 2
drop procedure if exists XemMonAn_DirtRead_T2
go
create procedure XemMonAn_DirtRead_T2
as
 
begin tran
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select M.MaMonAn, M.TenMonAn, L.TenLoai, M.URLHinhMonAn, M.MoTa, M.Gia
from MonAn M left join LoaiMonAn L on M.MaLoai = L.MaLoai
commit tran
go
-- PROCEDURE 2 FIXED
drop procedure if exists XemMonAn_DirtRead_T2_fixed
go
create procedure XemMonAn_DirtRead_T2_fixed
as
 
begin tran
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
select M.MaMonAn, M.TenMonAn, L.TenLoai, M.URLHinhMonAn, M.MoTa, M.Gia
from MonAn M left join LoaiMonAn L on M.MaLoai = L.MaLoai
commit tran
go

/* TRANSACTION */
--T1
EXEC [dbo].ThemMotMonAn_DirtyRead_T1 @TenMonAn = "Cơm chiên hải sản", @MaLoai = 3, @URLHinhMonAn=" " ,@MoTa = " AbCXYZ" ,@Gia= 0, @SoLuong = 50;
--T2
EXEC [dbo].XemMonAn_DirtRead_T2;
--T1 Fixed
EXEC [dbo].XemMonAn_DirtRead_T2_fixed;