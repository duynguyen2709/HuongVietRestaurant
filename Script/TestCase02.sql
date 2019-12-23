use HuongVietRestaurant
go

/*
1. Nội dung tình huống: 
	+ Quản lý thực hiện lọc danh sách món ăn theo giá trong khi chưa hoàn thành
	thì có một quản lý khác thêm món ăn vào cơ sở dữ liệu.
	=> gây ra tranh chấp đồng thời dẫn đến sai lệch về số lượng kết quả sau khi 2 giao tác được thực hiện.
2. Các bước thực hiện để xảy ra lỗi:
	+ Bước 1: Chạy Transaction 1 (Lọc món ăn theo giá)
	+ Bước 2: Trong vòng 10s từ khi Transaction 1 chạy ta chạy Transacion 2 (Thêm một món ăn vào cơ sở dữ liệu)
*/
/* PROCEDURE */
-- PROCEDURE 1
drop procedure if exists LocMonAnTheoGia_Phantom
go
create procedure LocMonAnTheoGia_Phantom
	@Gia bigint
as
begin tran
	select Count(*) from MonAn
	where Gia <= @Gia

	WaitFor Delay '00:00:10'

	select * from MonAn
	where Gia <= @Gia
commit
go

--PROCEDURE 2
drop procedure if exists ThemMotMonAn_Phantom_T2
go
create procedure ThemMotMonAn_Phantom_T2
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
commit tran
go

-- PROCEDURE 1 FIXED
drop procedure if exists LocMonAnTheoGia_Phantom_fixed
go
create procedure LocMonAnTheoGia_Phantom_fixed
	@Gia bigint
as
begin tran
	select Count(*) from MonAn with (Serializable) 
	where Gia <= @Gia

	WaitFor Delay '00:00:05'

	select * from MonAn
	where Gia <= @Gia
commit
go

/* TRANSACTION */
--T1
EXEC [dbo].LocMonAnTheoGia_Phantom @Gia = 30000;
--T2
EXEC [dbo].ThemMotMonAn_Phantom_T2 @TenMonAn = "Cơm chiên cá mặn", @MaLoai = 3, @URLHinhMonAn = " ", @MoTa="Hiện đang là best seller của cửa hàng",@Gia=45000,@SoLuong = 10;
--T1 Fixed
EXEC [dbo].LocMonAnTheoGia_Phantom_fixed @Gia = 30000;