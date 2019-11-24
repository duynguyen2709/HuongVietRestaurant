using System.Windows;
using HuongVietRestaurant.Utilities;
using System.Windows.Controls;
using HuongVietRestaurant.DAO;
using System;
using System.Data;
using System.Collections.Generic;
using HuongVietRestaurant.Entities;
using System.ComponentModel;

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
        public static ChiTietDonHang _selectedItem = null;
        public static ChiTietDonHang selectedChiTietDonHang
        {
            get
            {
                return _selectedItem;
            }
            set
            {
                _selectedItem = value;
            }
        }
        public static void PropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            selectedChiTietDonHang = sender as ChiTietDonHang;
        }
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
            txtResult.Text = "Số lượng kết quả: ";
            textbox_Gia.Text= "Giá...";
        }

        private void btnReloadView_Member_Click(object sender, RoutedEventArgs e)
        {
            ViewUtil.loadView(ViewEnum.ThanhVien);
        }

        private void btnReloadView_Voucher_Click(object sender, RoutedEventArgs e)
        {
            ViewUtil.loadView(ViewEnum.ChuongTrinhKhuyenMai);
        }

        private void btnReloadView_Basket_Click(object sender, RoutedEventArgs e)
        {
            ViewUtil.loadView(ViewEnum.DonHang);
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
            BaseDAO.ThemMotMonAn_DirtyRead_T1(Convert.ToInt32(dataRow.Row[2]), Convert.ToString(dataRow.Row[1]), Convert.ToString(dataRow.Row[6]), Convert.ToString(dataRow.Row[7]), Convert.ToInt64(dataRow.Row[5]), Convert.ToInt32(dataRow.Row[4]));
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
            if (textbox_Gia.Text == "") {
                ViewUtil.loadView(ViewEnum.MonAn);
                txtResult.Text = "Số lượng kết quả: ";
            }
            else
            {
                List<DataTable> result = BaseDAO.LocMonAnTheoGia_Phantom(Convert.ToDouble(textbox_Gia.Text));
                txtResult.Text = "Số lượng kết quả: " + Convert.ToString(result[0].Rows[0][0]);
                dtgMonAn.ItemsSource = result[1].DefaultView;
            }
        }

        private void BtnThemMotMonAn_Phantom_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgMonAn.SelectedItem as DataRowView;
            BaseDAO.ThemMotMonAn_Phantom_T2(Convert.ToInt32(dataRow.Row[2]), Convert.ToString(dataRow.Row[1]), Convert.ToString(dataRow.Row[6]), Convert.ToString(dataRow.Row[7]), Convert.ToInt64(dataRow.Row[5]), Convert.ToInt32(dataRow.Row[4]));
        }

        private void BtnLocMonAnTheoGia_Phantom_fixed_Click(object sender, RoutedEventArgs e)
        {
            if (textbox_Gia.Text == "")
            {
                ViewUtil.loadView(ViewEnum.MonAn);
                txtResult.Text = "Số lượng kết quả: ";
            }
            else
            {
                List<DataTable> result = BaseDAO.LocMonAnTheoGia_Phantom_fixed(Convert.ToDouble(textbox_Gia.Text));
                txtResult.Text = "Số lượng kết quả: " + Convert.ToString(result[0].Rows[0][0]);
                dtgMonAn.ItemsSource = result[1].DefaultView;
            }
        }

        private void BtnGiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgDonHang.SelectedItem as DataRowView;
            BaseDAO.GiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead(Convert.ToInt32(dataRow.Row[0]),selectedChiTietDonHang.MaMonAn, Convert.ToInt32(txtSoLuong3.Text));
        }

        private void BtnCapNhatSoLuongMonAnTrongChiTietDonHang_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgDonHang.SelectedItem as DataRowView;
            BaseDAO.CapNhatSoLuongMonAnTrongChiTietGioHang(Convert.ToInt32(dataRow.Row[0]),selectedChiTietDonHang.MaMonAn, Convert.ToInt32(txtSoLuong3.Text));
        }


        private void GridChild_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            selectedChiTietDonHang = (sender as DataGrid).SelectedItem as ChiTietDonHang;
        }

        private void BtnGiamSoLuongMonAnTrongChiTietGioHangUnrepeatableRead_fixed_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgDonHang.SelectedItem as DataRowView;
            BaseDAO.GiamSoLuongMonAnTrongChiTietGioHang_UnrepeatableRead_fixed(Convert.ToInt32(dataRow.Row[0]), selectedChiTietDonHang.MaMonAn, Convert.ToInt32(txtSoLuong3.Text));
        }

        private void BtnGiamSoLuongMonAnTrongChiTietGioHang_LostUpdate_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgDonHang.SelectedItem as DataRowView;
            BaseDAO.GiamSoLuongMonAnTrongChiTietGioHang_LostUpdate(Convert.ToInt32(dataRow.Row[0]), selectedChiTietDonHang.MaMonAn, Convert.ToInt32(txtSoLuong3.Text));
        }

        private void BtnGiamSoLuongMonAnTrongChiTietGioHang_LostUpdate_fixed_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgDonHang.SelectedItem as DataRowView;
            BaseDAO.GiamSoLuongMonAnTrongChiTietGioHang_LostUpdate_fixed(Convert.ToInt32(dataRow.Row[0]), selectedChiTietDonHang.MaMonAn, Convert.ToInt32(txtSoLuong3.Text));
        }

        private void BtnCapNhapThanhVien_Deadlock_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgThanhVien.SelectedItem as DataRowView;
            BaseDAO.CapNhapThanhVien_Deadlock(Convert.ToInt32(dataRow.Row[0]), Convert.ToInt32(dataRow.Row[9]), Convert.ToString(dataRow.Row[1]), Convert.ToString(dataRow.Row[3]), Convert.ToString(dataRow.Row[4]), Convert.ToString(dataRow.Row[5]), Convert.ToString(dataRow.Row[6]), Convert.ToString(dataRow.Row[7]), Convert.ToInt64(dataRow.Row[2]));
        }

        private void BtnCapNhapThanhVien_Deadlock_fixed_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRow = dtgThanhVien.SelectedItem as DataRowView;
            BaseDAO.CapNhapThanhVien_Deadlock_fixed(Convert.ToInt32(dataRow.Row[0]), Convert.ToInt32(dataRow.Row[9]),  Convert.ToString(dataRow.Row[1]), Convert.ToString(dataRow.Row[3]), Convert.ToString(dataRow.Row[4]), Convert.ToString(dataRow.Row[5]), Convert.ToString(dataRow.Row[6]), Convert.ToString(dataRow.Row[7]), Convert.ToInt64(dataRow.Row[2]));
        }
    }
}
