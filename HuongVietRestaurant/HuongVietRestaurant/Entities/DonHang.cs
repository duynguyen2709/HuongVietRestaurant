using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Entities
{
    public class DonHang
    {
        public int MaDonHang { get; set; }
        public string TenChiNhanh { get; set; }
        public string TenThanhVien { get; set; }
        public string ThoiGianTao { get; set; }
        public string ThoiGianGiaoHang { get; set; }
        public string TenTrangThai { get; set; }
        public long TongTien { get; set; }
        public long PhiGiaoHang { get; set; }
        public string PhuongThucThanhToan { get; set; }
        public string DiaChiGiaoHang { get; set; }
        public string TenKenhDatHang { get; set; }
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
