using System.Collections.Generic;

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
    }
}
