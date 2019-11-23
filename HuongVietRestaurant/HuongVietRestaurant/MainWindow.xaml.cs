using System.Windows;
using HuongVietRestaurant.Utilities;
using System.Windows.Controls;
using HuongVietRestaurant.DAO;
using HuongVietRestaurant.Entities;
using System;
using System.Diagnostics;
using HuongVietRestaurant.Entities;
using System.Data;

namespace HuongVietRestaurant
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public static DataGrid dtgMonAn = null;
        public static DataGrid dtgKhuyenMai = null;
        public static DataGrid dtgThanhVien = null;
        public static DataGrid dtgDonHang = null;
        public MainWindow()
        {
            InitializeComponent();
            dtgMonAn = dataGrid;
            dtgKhuyenMai = dataGrid2;
            dtgThanhVien = dataGrid_Member;
            dtgDonHang = dataGrid1;
            ViewUtil.loadView(ViewEnum.MonAn);
            ViewUtil.loadView(ViewEnum.ChuongTrinhKhuyenMai);
            ViewUtil.loadView(ViewEnum.ThanhVien);
            ViewUtil.loadView(ViewEnum.DonHang);
        }

        private void btnReloadView_Food_Click(object sender, RoutedEventArgs e)
        {
            ViewUtil.loadView(ViewEnum.MonAn);
        }


        private void BtnGiamSoLuongMonAnUnrepeatableRead_Click(object sender, RoutedEventArgs e)
        {
            int maMonAn = Convert.ToInt32((dtgMonAn.SelectedItem as DataRowView).Row[0]);
            int soLuong = Int32.Parse(txtSoLuong.Text);
            BaseDAO.GiamSoLuongMonAn_UnrepeatableRead(maMonAn, soLuong);
        }

        private void BtnCapNhatSoLuongMonAn_Click(object sender, RoutedEventArgs e)
        {
            int maMonAn = Convert.ToInt32((dtgMonAn.SelectedItem as DataRowView).Row[0]);
            int soLuong = Int32.Parse(txtSoLuong.Text);
            BaseDAO.CapNhapSoLuongMonAn(maMonAn, soLuong);
        }

        private void BtnThemMotMonAn_DirtyRead_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgMonAn.SelectedItem as DataRowView;
            BaseDAO.ThemMotMonAn_DirtyRead_T1(1, Convert.ToString(dataRow.Row[1]), Convert.ToString(dataRow.Row[4]), Convert.ToString(dataRow.Row[5]), Convert.ToInt64(dataRow.Row[3]), Convert.ToInt32(dataRow.Row[6]));

        }

        private void btnGiamSoLuongMonAnUnrepeatableRead_fixed_Click(object sender, RoutedEventArgs e)
        {
            int maMonAn = Convert.ToInt32((dtgMonAn.SelectedItem as DataRowView).Row[0]);
            int soLuong = Int32.Parse(txtSoLuong.Text);
            BaseDAO.GiamSoLuongMonAn_UnrepeatableRead_fixed(maMonAn, soLuong);
        }

        private void BtnCapNhapMonAn_Deadlock_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgMonAn.SelectedItem as DataRowView;
            BaseDAO.CapNhapMonAn_Deadlock(Convert.ToInt32(dataRow.Row[0]), Convert.ToString(dataRow.Row[1]), Convert.ToString(dataRow.Row[4]), Convert.ToString(dataRow.Row[5]), Convert.ToInt64(dataRow.Row[3]));
        }

        private void BtnCapNhapMonAn_Deadlock_fixed_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgMonAn.SelectedItem as DataRowView;
            BaseDAO.CapNhapMonAn_Deadlock_fixed(Convert.ToInt32(dataRow.Row[0]), Convert.ToString(dataRow.Row[1]), Convert.ToString(dataRow.Row[4]), Convert.ToString(dataRow.Row[5]), Convert.ToInt64(dataRow.Row[3]));
        }

        private void BtnXemMonAn_DirtRead_Click(object sender, RoutedEventArgs e)
        {
            ViewUtil.loadView(ViewEnum.MonAnDirtyRead);
        }

        private void BtnXemMonAn_DirtRead_fixed_Click(object sender, RoutedEventArgs e)
        {
            ViewUtil.loadView(ViewEnum.MonAn);
        }

        private void BtnLocMonAnTheoGia_Phantom_Click(object sender, RoutedEventArgs e)
        {
        }
    }
}
