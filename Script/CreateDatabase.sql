USE master ;  
GO  
IF EXISTS(select * from sys.databases where name='HuongVietRestaurant')
BEGIN
	ALTER DATABASE [HuongVietRestaurant] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [HuongVietRestaurant] ;  
END
GO  

CREATE DATABASE [HuongVietRestaurant];
GO
USE [HuongVietRestaurant];
GO

CREATE TABLE REF_KenhDatHang (
  [MaKenh] int NOT NULL IDENTITY,
  [TenKenhDatHang] nvarchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaKenh])
)  ;

CREATE TABLE REF_LoaiKhuyenMai (
  [MaLoai] int NOT NULL IDENTITY,
  [TenLoaiKhuyenMai] nvarchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaLoai])
)  ;

CREATE TABLE REF_QuyenHanNhanVien (
  [MaQuyenHan] int NOT NULL IDENTITY,
  [TenQuyenHan] nvarchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaQuyenHan])
)  ;

CREATE TABLE REF_TrangThaiDonHang (
  [MaTrangThai] int NOT NULL IDENTITY,
  [TenTrangThai] nvarchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaTrangThai])
)  ;

CREATE TABLE Tinh (
  [MaTinh] int NOT NULL IDENTITY,
  [TenTinh] nvarchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaTinh])
)  ;

CREATE TABLE ThanhPho (
  [MaThanhPho] int NOT NULL IDENTITY,
  [MaTinh] int NOT NULL,
  [TenThanhPho] nvarchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaThanhPho])
 ,
  CONSTRAINT [FK_ThanhPho_Tinh] FOREIGN KEY ([MaTinh]) REFERENCES Tinh ([MaTinh])
)  ;

CREATE INDEX [FK_ThanhPho_Tinh_idx] ON ThanhPho ([MaTinh]);

CREATE TABLE Quan (
  [MaQuan] int NOT NULL IDENTITY,
  [MaThanhPho] int NOT NULL,
  [TenQuan] nvarchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaQuan])
 ,
  CONSTRAINT [FK_Quan_ThanhPho] FOREIGN KEY ([MaThanhPho]) REFERENCES ThanhPho ([MaThanhPho])
)  ;

CREATE INDEX [FK_Quan_ThanhPho_idx] ON Quan ([MaThanhPho]);

CREATE TABLE Phuong (
  [MaPhuong] int NOT NULL IDENTITY,
  [MaQuan] int NOT NULL,
  [TenPhuong] nvarchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaPhuong])
 ,
  CONSTRAINT [FK_Phuong_Quan] FOREIGN KEY ([MaQuan]) REFERENCES Quan ([MaQuan])
)  ;

CREATE INDEX [FK_Phuong_Quan_idx] ON Phuong ([MaQuan]);

CREATE TABLE ChiNhanh (
  [MaChiNhanh] int NOT NULL IDENTITY,
  [TenChiNhanh] nvarchar(256) NOT NULL DEFAULT '',
  [MaPhuong] int NOT NULL,
  [DiaChi] nvarchar(256) NOT NULL DEFAULT '',
  [SoDienThoai] nvarchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaChiNhanh])
 ,
  CONSTRAINT [FK_ChiNhanh_Phuong] FOREIGN KEY ([MaPhuong]) REFERENCES Phuong ([MaPhuong])
)  ;

CREATE INDEX [FK_ChiNhanh_Phuong_idx] ON ChiNhanh ([MaPhuong]);

CREATE TABLE ThanhVien (
  [MaThanhVien] int NOT NULL IDENTITY,
  [MaChiNhanh] int NOT NULL,
  [TenDangNhap] nvarchar(32) NOT NULL DEFAULT '',
  [MatKhau] nvarchar(32) NOT NULL DEFAULT '',
  [HoTen] nvarchar(256) NOT NULL DEFAULT '',
  [CMND] nvarchar(12) NOT NULL DEFAULT '',
  [SoDienThoai] nvarchar(10) NOT NULL DEFAULT '',
  [Email] nvarchar(256) NOT NULL DEFAULT '',
  [NgaySinh] date NOT NULL,
  [DiaChi] nvarchar(256) NOT NULL DEFAULT '',
  [DiemTichLuy] bigint NOT NULL DEFAULT '0',
  PRIMARY KEY ([MaThanhVien])
 ,
  CONSTRAINT [FK_ThanhVien_ChiNhanh] FOREIGN KEY ([MaChiNhanh]) REFERENCES ChiNhanh ([MaChiNhanh])
)  ;

CREATE INDEX [FK_ThanhVien_ChiNhanh_idx] ON ThanhVien ([MaChiNhanh]);

CREATE TABLE LoaiMonAn (
  [MaLoai] int NOT NULL IDENTITY,
  [TenLoai] nvarchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY ([MaLoai])
) ;

CREATE TABLE MonAn (
  [MaMonAn] int NOT NULL IDENTITY,
  [MaLoai] int NOT NULL,
  [TenMonAn] nvarchar(256) NOT NULL DEFAULT '',
  [URLHinhMonAn] nvarchar(256) NOT NULL DEFAULT '',
  [MoTa] nvarchar(2048) NOT NULL DEFAULT '',
  [Gia] bigint NOT NULL DEFAULT '0',
  [SoLuong] int NOT NULL DEFAULT '0',
  PRIMARY KEY ([MaMonAn])
 ,
  CONSTRAINT [FK_MonAn_Loai] FOREIGN KEY ([MaLoai]) REFERENCES LoaiMonAn ([MaLoai])
)  ;

CREATE INDEX [FK_MonAn_Loai_idx] ON MonAn ([MaLoai]);

CREATE TABLE ChuongTrinhKhuyenMai (
  [MaKhuyenMai] int NOT NULL IDENTITY,
  [TenChuongTrinh] nvarchar(512) NOT NULL DEFAULT '',
  [MaLoai] int NOT NULL,
  [DoiTuongApDung] int DEFAULT NULL,
  [LoaiGiamGia] smallint DEFAULT '0',
  [GiaTri] bigint DEFAULT '0',
  [NgayBatDau] date NOT NULL,
  [NgayKetThuc] date NOT NULL,
  [SoLuong] int NOT NULL DEFAULT '0',
  PRIMARY KEY ([MaKhuyenMai])
 ,
  CONSTRAINT [FK_ChuongTrinhKhuyenMai_REFLoaiKhuyenMai] FOREIGN KEY ([MaLoai]) REFERENCES REF_LoaiKhuyenMai ([MaLoai])
)  ;

CREATE INDEX [FK_ChuongTrinhKhuyenMai_REFLoaiKhuyenMai_idx] ON ChuongTrinhKhuyenMai ([MaLoai]);

create table GioHang(
	[MaGio] int IDENTITY(1,1),
	[MaThanhVien] int not null,
	[TinhTrang] nvarchar(256),
	PRIMARY KEY ([MaGio]),
	CONSTRAINT [FK_GioHang_ThanhVien] FOREIGN KEY ([MaThanhVien]) REFERENCES ThanhVien ([MaThanhVien])
);

CREATE TABLE DonHang (
  [MaDonHang] int NOT NULL IDENTITY,
  [MaChiNhanh] int NOT NULL,
  [MaGio] int DEFAULT NULL,
  [ThoiGianTao] datetime2(0) NOT NULL,
  [ThoiGianGiaoHang] datetime2(0) NOT NULL,
  [TrangThai] int NOT NULL,
  [TongTien] bigint NOT NULL DEFAULT '0',
  [PhiGiaoHang] bigint NOT NULL,
  [PhuongThucThanhToan] smallint NOT NULL,
  [DiaChiGiaoHang] nvarchar(256) NOT NULL DEFAULT '',
  [KenhDatHang] int NOT NULL,
  [MaGiamGia] nvarchar(16) DEFAULT NULL,
  [ThoiGianCapNhat] datetime2(0) NOT NULL DEFAULT GETDATE(),
  PRIMARY KEY ([MaDonHang])
 ,
  CONSTRAINT [FK_DonHang_ChiNhanh] FOREIGN KEY ([MaChiNhanh]) REFERENCES ChiNhanh ([MaChiNhanh]),
  CONSTRAINT [FK_DonHang_KenhDatHang] FOREIGN KEY ([KenhDatHang]) REFERENCES REF_KenhDatHang ([MaKenh]),
  CONSTRAINT [FK_DonHang_GioHang] FOREIGN KEY ([MaGio]) REFERENCES GioHang ([MaGio]),
  CONSTRAINT [FK_DonHang_TrangThai] FOREIGN KEY ([TrangThai]) REFERENCES REF_TrangThaiDonHang ([MaTrangThai])
)  ;

CREATE INDEX [FK_DonHang_ChiNhanh_idx] ON DonHang ([MaChiNhanh]);
CREATE INDEX [FK_DonHang_GioHang_idx] ON DonHang ([MaGio]);
CREATE INDEX [FK_DonHang_TrangThai_idx] ON DonHang ([TrangThai]);
CREATE INDEX [FK_DonHang_KenhDatHang_idx] ON DonHang ([KenhDatHang]);



CREATE TABLE ChiTietGioHang (
  [MaGio] int NOT NULL,
  [MaMonAn] int NOT NULL,
  [SoLuong] int NOT NULL DEFAULT '0',
  [TongTien] bigint NOT NULL DEFAULT '0',
  PRIMARY KEY ([MaGio],[MaMonAn])
 ,
  CONSTRAINT [FK_ChiTietGioHang_GioHang] FOREIGN KEY ([MaGio]) REFERENCES GioHang ([MaGio]),
  CONSTRAINT [FK_ChiTietGioHang_MonAn] FOREIGN KEY ([MaMonAn]) REFERENCES MonAn ([MaMonAn])
)  ;

CREATE INDEX [FK_ChiTietGioHang_MonAn_idx] ON ChiTietGioHang ([MaMonAn]);

CREATE TABLE NhanVien (
  [MaNhanVien] int NOT NULL IDENTITY,
  [MaChiNhanh] int NOT NULL,
  [TenDangNhap] nvarchar(32) NOT NULL DEFAULT '',
  [MatKhau] nvarchar(32) NOT NULL DEFAULT '',
  [HoTen] nvarchar(256) NOT NULL DEFAULT '',
  [CMND] nvarchar(12) NOT NULL DEFAULT '',
  [SoDienThoai] nvarchar(10) NOT NULL DEFAULT '',
  [Email] nvarchar(256) NOT NULL DEFAULT '',
  [NgaySinh] date NOT NULL,
  [DiaChi] nvarchar(256) NOT NULL DEFAULT '',
  [QuyenHan] int NOT NULL DEFAULT '0',
  PRIMARY KEY ([MaNhanVien])
 ,
  CONSTRAINT [FK_NhanVien_ChiNhanh] FOREIGN KEY ([MaChiNhanh]) REFERENCES ChiNhanh ([MaChiNhanh]),
  CONSTRAINT [FK_NhanVien_QuyenHan] FOREIGN KEY ([QuyenHan]) REFERENCES REF_QuyenHanNhanVien ([MaQuyenHan])
)  ;

CREATE INDEX [FK_ThanhVien_ChiNhanh_idx] ON NhanVien ([MaChiNhanh]);
CREATE INDEX [FK_NhanVien_QuyenHan_idx] ON NhanVien ([QuyenHan]);

CREATE TABLE ThucDon (
  [MaMonAn] int NOT NULL,
  [MaChiNhanh] int NOT NULL,
  [Ngay] date NOT NULL,
  [SoLuong] int NOT NULL DEFAULT '0',
  PRIMARY KEY ([MaMonAn],[MaChiNhanh],[Ngay])
 ,
  CONSTRAINT [FK_ThucDon_ChiNhanh] FOREIGN KEY ([MaChiNhanh]) REFERENCES ChiNhanh ([MaChiNhanh]),
  CONSTRAINT [FK_ThucDon_MonAn] FOREIGN KEY ([MaMonAn]) REFERENCES MonAn ([MaMonAn])
)  ;

CREATE INDEX [FK_ThucDon_ChiNhanh_idx] ON ThucDon ([MaChiNhanh]);
GO

SET IDENTITY_INSERT REF_KenhDatHang ON
INSERT INTO REF_KenhDatHang (MaKenh,TenKenhDatHang) VALUES (1,'Online'),(2,'DienThoai'),(3,'TrucTiep');
SET IDENTITY_INSERT REF_KenhDatHang OFF

SET IDENTITY_INSERT REF_LoaiKhuyenMai ON
INSERT INTO REF_LoaiKhuyenMai (MaLoai,TenLoaiKhuyenMai) VALUES (1,'MonAn'),(2,'LoaiMonAn'),(3,'ChiNhanh'),(4,'TatCa');
SET IDENTITY_INSERT REF_LoaiKhuyenMai OFF

SET IDENTITY_INSERT REF_QuyenHanNhanVien ON
INSERT INTO REF_QuyenHanNhanVien (MaQuyenHan,TenQuyenHan) VALUES (1,'NhanVienLeTan'),(2,'NhanVienPhucVu'),(3,'QuanLyChiNhanh'),(4,'QuanLyChung');
SET IDENTITY_INSERT REF_QuyenHanNhanVien OFF

SET IDENTITY_INSERT REF_TrangThaiDonHang ON
INSERT INTO REF_TrangThaiDonHang (MaTrangThai,TenTrangThai) VALUES (1,'TiepNhan'),(2,'DangChuanBi'),(3,'DangGiao'),(4,'ChoThanhToan'),(5,'DaHuy'),(6,'HoanTat');
SET IDENTITY_INSERT REF_TrangThaiDonHang OFF

SET IDENTITY_INSERT Tinh ON
INSERT INTO Tinh (MaTinh,TenTinh) VALUES (1,'An Giang'),(2,'Bà Rịa - Vũng Tàu'),(3,'Bắc Giang'),(4,'Bắc Kạn'),(5,'Bạc Liêu'),(6,'Bắc Ninh'),(7,'Bến Tre'),(8,'Bình Ðịnh'),(9,'Bình Dương'),(10,'Bình Phước'),(11,'Bình Thuận'),(12,'Cà Mau'),(13,'Cao Bằng'),(14,'Ðắk Lắk'),(15,'Ðắk Nông'),(16,'Ðiện Biên'),(17,'Ðồng Nai'),(18,'Ðồng Tháp'),(19,'Gia Lai'),(20,'Hà Giang'),(21,'Hà Nam'),(22,'Hà Tĩnh'),(23,'Hải Duong'),(24,'Hậu Giang'),(25,'Hòa Bình'),(26,'Hưng Yên'),(27,'Khánh Hòa'),(28,'Kiên Giang'),(29,'Kon Tum'),(30,'Lai Châu'),(31,'Lâm Ðồng'),(32,'Lạng Sơn'),(33,'Lào Cai'),(34,'Long An'),(35,'Nam Ðịnh'),(36,'Nghệ An'),(37,'Ninh Bình'),(38,'Ninh Thuận'),(39,'Phú Thọ'),(40,'Quảng Bình'),(41,'Quảng Nam'),(42,'Quảng Ngãi'),(43,'Quảng Ninh'),(44,'Quảng Trị'),(45,'Sóc Trăng'),(46,'Sơn La'),(47,'Tây Ninh'),(48,'Thái Bình'),(49,'Thái Nguyên'),(50,'Thanh Hóa'),(51,'Thừa Thiên Huế'),(52,'Tiền Giang'),(53,'Trà Vinh'),(54,'Tuyên Quang'),(55,'Vĩnh Long'),(56,'Vĩnh Phúc'),(57,'Yên Bái'),(58,'Phú Yên'),(59,'Cần Thơ'),(60,'Ðà Nẵng'),(61,'Hải Phòng'),(62,'Hà Nội'),(63,'TP HCM');
SET IDENTITY_INSERT Tinh OFF

SET IDENTITY_INSERT ThanhPho ON
INSERT INTO ThanhPho (MaThanhPho,MaTinh,TenThanhPho) VALUES (1,17,'Biên Hòa'),(2,31,'Đà Lạt'),(3,14,'Buôn Mê Thuột'),(4,38,'Phan Rang'),(5,63,'TP HCM'),(6,59,'Cần Thơ'),(7,60,'Đà Nẵng');
SET IDENTITY_INSERT ThanhPho OFF

SET IDENTITY_INSERT Quan ON
INSERT INTO Quan (MaQuan,MaThanhPho,TenQuan) VALUES (1,5,'Bình Thạnh'),(2,6,'Cái Răng'),(3,7,'Sơn Trà');
SET IDENTITY_INSERT Quan OFF

SET IDENTITY_INSERT Phuong ON
INSERT INTO Phuong (MaPhuong,MaQuan,TenPhuong) VALUES (1,2,'Thường Thạnh'),(2,2,'Phú Thứ'),(3,3,'Phước Mỹ');
SET IDENTITY_INSERT Phuong OFF

SET IDENTITY_INSERT ChiNhanh ON
INSERT INTO ChiNhanh (MaChiNhanh,TenChiNhanh,MaPhuong,DiaChi,SoDienThoai) VALUES (1,'Chi Nhánh 1',1,'123 Thường Thạnh','0123456789'),(2,'Chi Nhánh 2',2,'456 Phú Thứ','0987654321'),(3,'Chi Nhánh 3',3,'789 Phước Mỹ','0988776655');
SET IDENTITY_INSERT ChiNhanh OFF

SET IDENTITY_INSERT NhanVien ON
INSERT INTO NhanVien (MaNhanVien,MaChiNhanh,TenDangNhap,MatKhau,HoTen,CMND,SoDienThoai,Email,NgaySinh,DiaChi,QuyenHan) VALUES (1,1,'admin','123','Trần Văn C','272683901','0948202709','tranvanc@gmail.com','1992-07-21','qewqeqwqw',4),(2,2,'staff','123','Nguyễn Văn C','211728191','0911923131','nguyenvand@gmail.com','1993-03-03','1111',2);
SET IDENTITY_INSERT NhanVien OFF

SET IDENTITY_INSERT ThanhVien ON
INSERT INTO ThanhVien (MaThanhVien,MaChiNhanh,TenDangNhap,MatKhau,HoTen,CMND,SoDienThoai,Email,NgaySinh,DiaChi,DiemTichLuy) VALUES (1,1,'test','123','NGUYỄN VĂN A','123456789','0909808707','nguyenvana@gmail.com','1996-10-05','abc',80000),(2,2,'user','123','Trần Thị B','113446779','0382726830','tranthib@gmail.com','1990-01-15','xyz',40000);
SET IDENTITY_INSERT ThanhVien OFF

SET IDENTITY_INSERT GioHang ON
INSERT INTO GioHang(MaGio,MaThanhVien,TinhTrang) VALUES (1,1,'Chưa thanh toán'),(2,2,'Đã thanh toán');
SET IDENTITY_INSERT GioHang OFF

SET IDENTITY_INSERT DonHang ON
INSERT INTO DonHang (MaDonHang,MaChiNhanh,MaGio,ThoiGianTao,ThoiGianGiaoHang,TrangThai,TongTien,PhiGiaoHang,PhuongThucThanhToan,DiaChiGiaoHang,KenhDatHang,MaGiamGia,ThoiGianCapNhat) VALUES (1,1,1,'2019-10-21 15:30:00.000','2019-10-21 18:30:00.000',6,80000,20000,1,'abc',1,NULL,'2019-10-21 18:30:00.000'),(2,2,2,'2019-10-22 10:30:00.000','2019-10-22 13:30:00.000',2,40000,50000,1,'xyz',1,NULL,'2019-10-22 10:35:00.000');
SET IDENTITY_INSERT DonHang OFF

SET IDENTITY_INSERT ChuongTrinhKhuyenMai ON
INSERT INTO ChuongTrinhKhuyenMai (MaKhuyenMai,TenChuongTrinh,MaLoai,DoiTuongApDung,LoaiGiamGia,GiaTri,NgayBatDau,NgayKetThuc, SoLuong) VALUES 
		(1,'Khuyến mãi món nước',1,1,1,10,'2019-10-21','2019-10-25', 10),
		(2,'Khuyến mãi chi nhánh',3,1,1,15,'2019-10-21','2019-10-25', 10);
SET IDENTITY_INSERT ChuongTrinhKhuyenMai OFF

SET IDENTITY_INSERT LoaiMonAn ON
INSERT INTO LoaiMonAn (MaLoai,TenLoai) VALUES (1,'Món Nước'),(2,'Cơm'),(3,'Món Canh'),(4,'Tráng Miệng'),(5,'Món Xào');
SET IDENTITY_INSERT LoaiMonAn OFF

SET IDENTITY_INSERT MonAn ON
INSERT INTO MonAn (MaMonAn,MaLoai,TenMonAn,URLHinhMonAn,MoTa,Gia,SoLuong) VALUES 
		(1,1,
		'Hủ tiếu',
		'http://www.savourydays.com/wp-content/uploads/2019/03/c%C3%A1ch-n%E1%BA%A5u-h%E1%BB%A7-ti%C3%AAu-banner.jpg',
		'Hủ tiếu là món ngon cuối tuần đáng để nấu cho gia đình. Hủ tiếu là món ăn đơn giản, dễ ăn, thích hợp để thay đổi khẩu vị cho bữa cơm hằng ngày đấy!',
		40000,
		10),
		(2,2,
		'Cơm chiên dương châu',
		'https://ameovat.com/wp-content/uploads/2016/05/cach-lam-com-chien-duong-chau-600x481.jpg',
		'Cơm chiên dương châu là món ăn ngon có xuất xứ từ thời nhà thanh của Trung Quốc và nhanh chóng nổi tiếng trên khắp thế giới. Món cơm chiên dương châu này vừa thơm ngon lại vừa có rất nhiều màu sắc bắt nữa, đậm đà và giàu chất dinh dưỡng, rất dễ dàng để chế biến.'
		,70000,
		10),
		(3,3,
		'Canh chua cá lóc',
		'https://i.ytimg.com/vi/E-NNlA6yg8Q/hqdefault.jpg',
		'Là món canh truyền thống của người Nam bộ, mang vị chua ngọt đậm đà nhưng không bị bốc mùi tanh của cá, có sự hòa quyện của thịt cá và các loại rau dân dã, thích hợp ăn nóng kèm với cơm trong bữa ăn hàng ngày.',
		80000,
		10);
SET IDENTITY_INSERT MonAn OFF

INSERT INTO ChiTietGioHang (MaGio,MaMonAn,SoLuong,TongTien) VALUES (1,3,1,80000),(2,1,1,40000);

INSERT INTO ThucDon (MaMonAn,MaChiNhanh,Ngay,SoLuong) VALUES (1,1,'2019-10-21',5),(1,2,'2019-10-21',7),(1,3,'2019-10-21',10),(2,1,'2019-10-21',7),(2,2,'2019-10-21',5);


