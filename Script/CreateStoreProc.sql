use HuongVietRestaurant
go

drop procedure if exists DangNhap
go
create procedure DangNhap
	@TenDangNhap nvarchar(32),
	@MatKhau nvarchar(32)
as
	select MaNhanVien AS MaThanhVien, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, QuyenHan, '0' as DiemTichLuy
	from NhanVien
	where TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau
	UNION 
	select MaThanhVien, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, '0' as QuyenHan , DiemTichLuy
	from ThanhVien
	where TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau
go

-- Select 
drop procedure if exists XemThanhVien
go
create procedure XemThanhVien
as
select MaThanhVien, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy 
from ThanhVien
go

drop procedure if exists XemChuongTrinhKhuyenMai
go
create procedure XemChuongTrinhKhuyenMai
as
select MaKhuyenMai, TenChuongTrinh, MaLoai, DoiTuongApDung, GiaTri, NgayBatDau, NgayKetThuc, SoLuong
from ChuongTrinhKhuyenMai
go

drop procedure if exists XemMonAn
go
create procedure XemMonAn
as
select M.MaMonAn, M.TenMonAn, L.TenLoai, M.URLHinhMonAn, M.MoTa, M.Gia
from MonAn M left join LoaiMonAn L on M.MaLoai = L.MaLoai
go

drop procedure if exists XemDonHang
go
create procedure XemDonHang
as
select D.MaDonHang, M.TenMonAn, CT.SoLuong, CT.TongTien as Gia, C.TenChiNhanh, T.HoTen as TenThanhVien, D.ThoiGianTao, D.ThoiGianGiaoHang, TR.TenTrangThai, D.TongTien, D.PhiGiaoHang, D.PhuongThucThanhToan, D.DiaChiGiaoHang, K.TenKenhDatHang
from ChiTietGioHang CT left join MonAn M on CT.MaMonAn = M.MaMonAn
left join DonHang D on CT.MaDonHang = D.MaDonHang
left join ChiNhanh C on D.MaChiNhanh = C.MaChiNhanh
left join ThanhVien T on D.MaThanhVien = T.MaThanhVien
left join REF_TrangThaiDonHang TR on D.TrangThai = TR.MaTrangThai
left join REF_KenhDatHang K on D.KenhDatHang = K.MaKenh
order by D.MaDonHang
go

drop procedure if exists XemMotThanhVien
go
create procedure XemMotThanhVien
	@MaThanhVien int
as
	select HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy 
	from ThanhVien
	where MaThanhVien = @MaThanhVien
go

drop procedure if exists XemMotChuongTrinhKhuyenMai
go
create procedure XemMotChuongTrinhKhuyenMai
	@MaKhuyenMai int
as
	select MaKhuyenMai, TenChuongTrinh, MaLoai, DoiTuongApDung, GiaTri, NgayBatDau, NgayKetThuc, SoLuong
	from ChuongTrinhKhuyenMai
	where MaKhuyenMai = @MaKhuyenMai
go

drop procedure if exists XemMotMonAn
go
create procedure XemMotMonAn
	@MaMonAn int
as
	select M.MaMonAn, M.TenMonAn, L.TenLoai, M.URLHinhMonAn, M.MoTa, M.Gia
	from MonAn M left join LoaiMonAn L on M.MaLoai = L.MaLoai
	where M.MaMonAn = @MaMonAn
go

drop procedure if exists XemMotDonHang
go
create procedure XemMotDonHang
	@MaDonHang int
as
select D.MaDonHang, M.TenMonAn, CT.SoLuong, CT.TongTien as Gia, C.TenChiNhanh, T.HoTen as TenThanhVien, D.ThoiGianTao, D.ThoiGianGiaoHang, TR.TenTrangThai, D.TongTien, D.PhiGiaoHang, D.PhuongThucThanhToan, D.DiaChiGiaoHang, K.TenKenhDatHang
from ChiTietGioHang CT left join MonAn M on CT.MaMonAn = M.MaMonAn
left join DonHang D on CT.MaDonHang = D.MaDonHang
left join ChiNhanh C on D.MaChiNhanh = C.MaChiNhanh
left join ThanhVien T on D.MaThanhVien = T.MaThanhVien
left join REF_TrangThaiDonHang TR on D.TrangThai = TR.MaTrangThai
left join REF_KenhDatHang K on D.KenhDatHang = K.MaKenh
where D.MaDonHang = @MaDonHang
order by D.MaDonHang
go

--Unrepeatable read
--TRANSACTION 1
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
Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback

WaitFor Delay '00:00:5'

SELECT @SoLuongHienTai = SoLuong 
FROM MonAn WHERE MaMonAn = @MaMonAn

SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE MonAn SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

Print @SoLuongHienTai
Commit Transaction
go

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

Print @SoLuongHienTai
Commit Transaction
go

drop procedure if exists GiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead
go
create procedure GiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietGioHang 
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang
Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback
WaitFor Delay '00:00:05'

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietGioHang WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE ChiTietGioHang SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

Print @SoLuongHienTai
Commit Transaction
go

--TRANSACTION 1 fixed
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
Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback

WaitFor Delay '00:00:5'

SELECT @SoLuongHienTai = SoLuong 
FROM MonAn WHERE MaMonAn = @MaMonAn

SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE MonAn SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

Print @SoLuongHienTai
Commit Transaction
go

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

Print @SoLuongHienTai
Commit Transaction
go

drop procedure if exists GiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead_fixed
go
create procedure GiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead_fixed
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietGioHang with (RepeatableRead) 
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang
Print @SoLuongHienTai
if(@SoLuongHienTai = 0)
	rollback
WaitFor Delay '00:00:05'

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietGioHang WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE ChiTietGioHang SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

Print @SoLuongHienTai
Commit Transaction
go

--TRANSACTION 2
drop procedure if exists CapNhapSoLuongMonAn
go
create procedure CapNhapSoLuongMonAn
	@MaMonAn int,
	@SoLuong int
as
	update MonAn set SoLuong = @SoLuong where  MaMonAn = @MaMonAn
go

drop procedure if exists CapNhapSoLuongVoucher
go
create procedure CapNhapSoLuongVoucher
	@MaVoucher int,
	@SoLuong int
as
	update ChuongTrinhKhuyenMai set SoLuong = @SoLuong where MaKhuyenMai = @MaVoucher
go

drop procedure if exists CapNhapSoLuongMonAnTrongChiTietGioHang
go
create procedure CapNhapSoLuongMonAnTrongChiTietGioHang
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
	update ChiTietGioHang set SoLuong = @SoLuong where  MaDonHang = @MaDonHang and MaMonAn = @MaMonAn
go

--phantom
--TRANSACTION 1
drop procedure if exists LocMonAnTheoGia_Phantom
go
create procedure LocMonAnTheoGia_Phantom
	@Gia bigint
as
begin tran
	select Count(*) from MonAn
	where Gia <= @Gia

	WaitFor Delay '00:00:05'

	select * from MonAn
	where Gia <= @Gia
commit
go

drop procedure if exists LocThanhVienTheoDiem_Phantom
go
create procedure LocThanhVienTheoDiem_Phantom
	@Diem bigint
as
begin tran
	select Count(*) from ThanhVien
	where DiemTichLuy <= @Diem

	WaitFor Delay '00:00:05'

	select * from ThanhVien
	where DiemTichLuy <= @Diem
commit
go

drop procedure if exists LocVoucherTheoGiaTri_Phantom
go
create procedure LocVoucherTheoGiaTri_Phantom
	@GiaTri bigint
as
begin tran
	select Count(*) from ChuongTrinhKhuyenMai
	where GiaTri <= @GiaTri

	WaitFor Delay '00:00:05'

	select * from ChuongTrinhKhuyenMai
	where GiaTri <= @GiaTri
commit
go

--TRANSACTION 1 fixed
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

drop procedure if exists LocThanhVienTheoDiem_fixed
go
create procedure LocThanhVienTheoDiem_fixed
	@Diem bigint
as
begin tran
	select Count(*) from ThanhVien with (Serializable) 
	where DiemTichLuy <= @Diem

	WaitFor Delay '00:00:05'

	select * from ThanhVien
	where DiemTichLuy <= @Diem
commit
go

drop procedure if exists LocVoucherTheoGiaTri_fixed
go
create procedure LocVoucherTheoGiaTri_fixed
	@GiaTri bigint
as
begin tran
	select Count(*) from ChuongTrinhKhuyenMai with (Serializable) 
	where GiaTri <= @GiaTri

	WaitFor Delay '00:00:05'

	select * from ChuongTrinhKhuyenMai
	where GiaTri <= @GiaTri
commit
go
--TRANSACTION 2--
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

drop procedure if exists ThemThanhVien_Phantom_T2
go
create procedure ThemThanhVien_Phantom_T2
	@MaChiNhanh int,
	@HoTen nvarchar(256),
	@CMND nvarchar(12),
	@SoDienThoai nvarchar(10),
	@Email nvarchar(256),
	@NgaySinh date,
	@DiaChi nvarchar(256), 
	@DiemTichLuy bigint
as
begin tran
	insert into ThanhVien (MaChiNhanh, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy)
	values (@MaChiNhanh, @HoTen, @CMND, @SoDienThoai, @Email, @NgaySinh, @DiaChi, @DiemTichLuy)
commit tran
go

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

--dirty read
--TRANSACTION 1--
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

	waitfor delay '00:00:05'

	if(@gia = 0)
		rollback
commit tran
go

drop procedure if exists ThemThanhVien_DirtyRead_T1
go
create procedure ThemThanhVien_DirtyRead_T1
	@MaChiNhanh int,
	@HoTen nvarchar(256),
	@CMND nvarchar(12),
	@SoDienThoai nvarchar(10),
	@Email nvarchar(256),
	@NgaySinh date,
	@DiaChi nvarchar(256), 
	@DiemTichLuy bigint
as
begin tran
	insert into ThanhVien (MaChiNhanh, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy)
	values (@MaChiNhanh, @HoTen, @CMND, @SoDienThoai, @Email, @NgaySinh, @DiaChi, @DiemTichLuy)

	waitfor delay '00:00:05'

	if(len(@CMND) != 10)
		rollback
commit tran
go

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

	waitfor delay '00:00:05'

	if(@SoLuong <= 0)
		rollback
commit
go
--TRANSACTION 2--
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

drop procedure if exists XemThanhVien_DirtRead_T2
go
create procedure XemThanhVien_DirtRead_T2
as
begin tran
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select MaThanhVien, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy 
from ThanhVien
commit tran
go

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

--TRANSACTION 2 fixed
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

drop procedure if exists XemThanhVien_DirtRead_T2_fixed
go
create procedure XemThanhVien_DirtRead_T2_fixed
as
begin tran
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
select MaThanhVien, HoTen, CMND, SoDienThoai, Email, NgaySinh, DiaChi, DiemTichLuy 
from ThanhVien
commit tran
go

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

--Lost update
--TRANSACTION 1 2
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

WaitFor Delay '00:00:05'
SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE MonAn SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

Print @SoLuongHienTai
Commit Transaction
go

drop procedure if exists DungVoucher_LostUpdate
go
create procedure DungVoucher_LostUpdate
	@MaKhuyenMai int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChuongTrinhKhuyenMai WHERE MaKhuyenMai = @MaKhuyenMai 

SET @SoLuongHienTai = @SoLuongHienTai - 1
WaitFor Delay '00:00:05'
UPDATE ChuongTrinhKhuyenMai SET SoLuong = @SoLuongHienTai
WHERE MaKhuyenMai = @MaKhuyenMai

Print @SoLuongHienTai
Commit Transaction
go

drop procedure if exists GiamSoLuongMonAnTrongChiTietGioHang_LostUpdate
go
create procedure GiamSoLuongMonAnTrongChiTietGioHang_LostUpdate
	@MaMonAn int,
	@SoLuong int
as
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietGioHang WHERE MaMonAn = @MaMonAn 

WaitFor Delay '00:00:05'
SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE ChiTietGioHang SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

Print @SoLuongHienTai
Commit Transaction
go

--TRANSACTION 1 2 fixed
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

WaitFor Delay '00:00:05'
SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE MonAn SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn

Print @SoLuongHienTai
Commit Transaction
go

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

SET @SoLuongHienTai = @SoLuongHienTai - 1
WaitFor Delay '00:00:05'
UPDATE ChuongTrinhKhuyenMai SET SoLuong = @SoLuongHienTai
WHERE MaKhuyenMai = @MaKhuyenMai

Print @SoLuongHienTai
Commit Transaction
go

drop procedure if exists GiamSoLuongMonAnTrongChiTietGioHang_LostUpdate_fixed
go
create procedure GiamSoLuongMonAnTrongChiTietGioHang_LostUpdate_fixed
	@MaDonHang int,
	@MaMonAn int,
	@SoLuong int
as
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
DECLARE @SoLuongHienTai INT

SELECT @SoLuongHienTai = SoLuong 
FROM ChiTietGioHang with (updlock) WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

WaitFor Delay '00:00:05'
SET @SoLuongHienTai = @SoLuongHienTai - @SoLuong

UPDATE ChiTietGioHang SET SoLuong = @SoLuongHienTai
WHERE MaMonAn = @MaMonAn and MaDonHang = @MaDonHang

Print @SoLuongHienTai
Commit Transaction
go

--Deadlock
--TRANSACTION 1 2
drop procedure if exists CapNhapMonAn_Deadlock
go
create procedure CapNhapMonAn_Deadlock
	@MaMonAn int,
	@TenMonAn nvarchar(256),
	@URLHinhMonAn nvarchar(256),
	@MoTa nvarchar(2048), 
	@Gia bigint
as
begin tran
	set tran isolation level repeatable read
	select * from  MonAn  where MaMonAn = @MaMonAn 
	WaitFor Delay '00:00:05'
	update MonAn
	set TenMonAn = @TenMonAn,
	URLHinhMonAn = @URLHinhMonAn,
	MoTa = @MoTa,
	Gia = @Gia
	where MaMonAn = @MaMonAn
commit
go

drop procedure if exists CapNhapThanhVien_Deadlock
go
create procedure CapNhapThanhVien_Deadlock
	@MaThanhVien int,
	@TenThanhVien nvarchar(256),
	@CMND nvarchar(12),
	@SoDienThoai nvarchar(10),
	@Email nvarchar(256),
	@NgaySinh date,
	@DiaChi nvarchar(256), 
	@DiemTichLuy bigint
as
begin tran
	set tran isolation level repeatable read
	select * from ThanhVien where MaThanhVien = @MaThanhVien

	WaitFor Delay '00:00:05'

	update ThanhVien
	set HoTen = @TenThanhVien,
	CMND = @CMND,
	SoDienThoai = @SoDienThoai,
	Email = @Email,
	NgaySinh = @NgaySinh,
	DiaChi = @DiaChi, 
	DiemTichLuy = @DiemTichLuy
	where MaThanhVien = @MaThanhVien
commit
go

drop procedure if exists CapNhapVoucher_Deadlock
go
create procedure CapNhapVoucher_Deadlock
	@MaKhuyenMai int,
	@GiaTri nvarchar(256)
as
begin tran
	set tran isolation level repeatable read
	select * from ChuongTrinhKhuyenMai where MaKhuyenMai = @MaKhuyenMai

	WaitFor Delay '00:00:05'

	update ChuongTrinhKhuyenMai
	set GiaTri = @GiaTri
	where MaKhuyenMai = @MaKhuyenMai
commit
go

--TRANSACTION 1 2 fixed
drop procedure if exists CapNhapMonAn_Deadlock_fixed
go
create procedure CapNhapMonAn_Deadlock_fixed
	@MaMonAn int,
	@TenMonAn nvarchar(256),
	@URLHinhMonAn nvarchar(256),
	@MoTa nvarchar(2048), 
	@Gia bigint
as
begin tran
	set tran isolation level repeatable read
	select * from MonAn with (updlock) where MaMonAn = @MaMonAn 

	WaitFor Delay '00:00:05'

	update MonAn
	set TenMonAn = @TenMonAn,
	URLHinhMonAn = @URLHinhMonAn,
	MoTa = @MoTa,
	Gia = @Gia
	where MaMonAn = @MaMonAn
commit
go

drop procedure if exists CapNhapThanhVien_Deadlock_fixed
go
create procedure CapNhapThanhVien_Deadlock_fixed
	@MaThanhVien int,
	@TenThanhVien nvarchar(256),
	@CMND nvarchar(12),
	@SoDienThoai nvarchar(10),
	@Email nvarchar(256),
	@NgaySinh date,
	@DiaChi nvarchar(256), 
	@DiemTichLuy bigint
as
begin tran
	set tran isolation level repeatable read
	select * from ThanhVien with (updlock) where MaThanhVien = @MaThanhVien

	WaitFor Delay '00:00:05'

	update ThanhVien
	set HoTen = @TenThanhVien,
	CMND = @CMND,
	SoDienThoai = @SoDienThoai,
	Email = @Email,
	NgaySinh = @NgaySinh,
	DiaChi = @DiaChi, 
	DiemTichLuy = @DiemTichLuy
	where MaThanhVien = @MaThanhVien
commit
go

drop procedure if exists CapNhapVoucher_Deadlock_fixed
go
create procedure CapNhapVoucher_Deadlock_fixed
	@MaKhuyenMai int,
	@GiaTri nvarchar(256)
as
begin tran
	set tran isolation level repeatable read
	select * from ChuongTrinhKhuyenMai with (updlock) where MaKhuyenMai = @MaKhuyenMai

	WaitFor Delay '00:00:05'

	update ChuongTrinhKhuyenMai
	set GiaTri = @GiaTri
	where MaKhuyenMai = @MaKhuyenMai
commit
go