using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Entities
{
    public class DonHang
    {
        public int MaDonHang;
        public string TenChiNhanh;
        public string TenThanhVien;
        public string ThoiGianTao;
        public string ThoiGianGiaoHang;
        public string TenTrangThai;
        public long TongTien;
        public long PhiGiaoHang;
        public string PhuongThucThanhToan;
        public string DiaChiGiaoHang;
        public string TenKenhDatHang;
        public List<ChiTietDonHang> ChiTiet = new List<ChiTietDonHang>();

        public class ChiTietDonHang
        {
            public string TenMonAn;
            public int SoLuong;
            public long Gia;

            public ChiTietDonHang(string _ten, int _soluong, long _gia)
            {
                this.TenMonAn = _ten;
                this.SoLuong = _soluong;
                this.Gia = _gia;
            }
        }
    }
}
