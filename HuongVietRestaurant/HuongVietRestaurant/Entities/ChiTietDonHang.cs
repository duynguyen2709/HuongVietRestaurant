using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace HuongVietRestaurant.Entities
{
    public class ChiTietDonHang : INotifyPropertyChanged
    {
        private int _maMonAn;
        private int _soLuong;
        public string TenMonAn { get; set; }
        public long Gia { get; set; }
        public int MaMonAn {
            get
            {
                return _maMonAn;
            }
            set {
                _maMonAn = value;
                NotifyPropertyChanged();
            }
        }
        public int SoLuong
        {
            get
            {
                return _soLuong;
            }
            set
            {
                _soLuong = value;
                NotifyPropertyChanged();
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        private void NotifyPropertyChanged([CallerMemberName] String propertyName = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        public ChiTietDonHang(int _ma, string _ten, int _soluong, long _gia)
        {
            this.MaMonAn = _ma;
            this.TenMonAn = _ten;
            this.SoLuong = _soluong;
            this.Gia = _gia;
        }
    }
}
