using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Entities
{
    public class ChuongTrinhKhuyenMai
    {
        public int MaKhuyenMai { get; set; }
        public string TenChuongTrinh { get; set; }
        public int SoLuong { get; set; }
        public int MaLoai { get; set; }
        public int DoiTuongApDung { get; set; }
        public long GiaTri { get; set; }
        public string NgayBatDau { get; set; }
        public string NgayKetThuc { get; set; }
        
    }
}
