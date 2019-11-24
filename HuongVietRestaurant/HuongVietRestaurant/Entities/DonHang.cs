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
        public long TongTien { get; set; }
        public long PhiGiaoHang { get; set; }
        public string ThoiGianTao { get; set; }
        public string ThoiGianGiaoHang { get; set; }
        public string TenTrangThai { get; set; }
        public string PhuongThucThanhToan { get; set; }
        public string DiaChiGiaoHang { get; set; }
        public string TenKenhDatHang { get; set; }
        public List<ChiTietDonHang> ChiTiet
        {
            get
            {
                return chiTiet;
            }
            set
            {
                chiTiet = value;
            }
        }

        private List<ChiTietDonHang> chiTiet = new List<ChiTietDonHang>();

        public class ChiTietDonHang
        {
            public int MaMonAn { get; set; }
            public string TenMonAn { get; set; }
            public int SoLuong { get; set; }
            public long Gia { get; set; }

            public ChiTietDonHang(int _ma, string _ten, int _soluong, long _gia)
            {
                this.MaMonAn = _ma;
                this.TenMonAn = _ten;
                this.SoLuong = _soluong;
                this.Gia = _gia;
            }
        }
    }
}
