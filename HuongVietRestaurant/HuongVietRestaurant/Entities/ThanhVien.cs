using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Entities
{
    public class ThanhVien
    {
        public int MaThanhVien { get; set; }
        public string HoTen { get; set; }
        public long DiemTichLuy { get; set; }
        public string CMND { get; set; }
        public string SoDienThoai { get; set; }
        public string Email { get; set; }
        public String NgaySinh { get; set; }
        public String DiaChi { get; set; }
        public int QuyenHan { get; set; }
       
    }
}