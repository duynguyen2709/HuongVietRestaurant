using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Entities
{
    public class MonAn
    {
        public int MaMonAn { get; set; }
        public string TenMonAn { get; set; }
        public string TenLoai { get; set; }
        public long Gia { get; set; }
        public string URLHinhMonAn { get; set; }
        public string MoTa { get; set; }
        public int SoLuong { get; set; }
    }
}
