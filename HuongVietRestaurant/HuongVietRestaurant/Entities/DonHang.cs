using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Entities
{
    class DonHang
    {
        public int MaDonHang;
        public string TenChiNhanh;
        public string TenThanhVien;
        public DateTime ThoiGianTao;
        public DateTime ThoiGianGiaoHang;
        public string TenTrangThai;
        public long TongTien;
        public long PhiGiaoHang;
        public string PhuongThucThanhToan;
        public string DiaChiGiaoHang;
        public string TenKenhDatHang;
        public List<ChiTietDonHang> ChiTiet;

        public class ChiTietDonHang
        {
            public string TenMonAn;
            public int SoLuong;
            public long Gia;
        }
    }
}
