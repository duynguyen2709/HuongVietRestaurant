using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Utilities
{
    public enum StoreProcEnum
    {
        DangNhap,
        XemThanhVien,
        XemChuongTrinhKhuyenMai,
        XemMonAn,
        XemDonHang,
        XemMotThanhVien,
        XemMotChuongTrinhKhuyenMai,
        XemMotMonAn,
        XemMotDonHang,
        CapNhapSoLuongMonAn,
        CapNhapSoLuongVoucher,
        CapNhapSoLuongMonAnTrongChiTietGioHang,
        GiamSoLuongMonAn_UnrepeatableRead,
        DungVoucher_UnrepeatableRead,
        GiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead,
        GiamSoLuongMonAn_UnrepeatableRead_fixed,
        DungVoucher_UnrepeatableRead_fixed,
        GiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead_fixed,
        LocMonAnTheoGia_Phantom,
        LocThanhVienTheoDiem_Phantom,
        LocVoucherTheoGiaTri_Phantom,
        ThemMotMonAn_Phantom_T2,
        ThemThanhVien_Phantom_T2,
        ThemVoucher_Phantom_T2,
        LocMonAnTheoGia_Phantom_fixed,
        LocThanhVienTheoDiem_fixed,
        LocVoucherTheoGiaTri_fixed,
        ThemMotMonAn_DirtyRead_T1,
        ThemThanhVien_DirtyRead_T1,
        ThemVoucher_DirtyRead_T1,
        XemMonAn_DirtRead_T2,
        XemThanhVien_DirtRead_T2,
        XemVoucher_DirtRead_T2,
        XemMonAn_DirtRead_T2_fixed,
        XemThanhVien_DirtRead_T2_fixed,
        XemVoucher_DirtRead_T2_fixed,
        GiamSoLuongMonAn_LostUpdate,
        DungVoucher_LostUpdate,
        GiamSoLuongMonAnTrongChiTietGioHang_LostUpdate,
        GiamSoLuongMonAn_LostUpdate_fixed,
        DungVoucher_LostUpdate_fixed,
        GiamSoLuongMonAnTrongChiTietGioHang_LostUpdate_fixed,
        CapNhapMonAn_Deadlock,
        CapNhapThanhVien_Deadlock,
        CapNhapVoucher_Deadlock,
        CapNhapMonAn_Deadlock_fixed,
        CapNhapThanhVien_Deadlock_fixed,
        CapNhapVoucher_Deadlock_fixed,
    }
}
