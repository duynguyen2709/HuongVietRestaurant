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

        private void dataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //Trace.WriteLine("ID: " + dataGrid.GetValue();
            //Trace.WriteLine();

            /*int rowindex = dataGrid.;
            int columnindex = dataGrid.CurrentCell;

            dataGrid.Rows[rowindex].Cells[columnindex].Value.ToString();*/

            if (dataGrid.SelectedItems.Count > 0)
            {
                DataRowView row = (DataRowView)dataGrid.SelectedItems[0];
                //MonAn dgvrows = (MonAn)dataGrid.SelectedItems[0];
                //Trace.WriteLine(row.Row.ItemArray[0]);

                selectedMonAn.MaMonAn = System.Convert.ToInt32(row.Row.ItemArray[0].ToString());
                selectedMonAn.TenMonAn = row.Row.ItemArray[1].ToString();
                selectedMonAn.Gia = System.Convert.ToInt64(row.Row.ItemArray[3].ToString());
                selectedMonAn.URLHinhMonAn = row.Row.ItemArray[4].ToString();
                selectedMonAn.MoTa = row.Row.ItemArray[5].ToString();
                selectedMonAn.SoLuong = System.Convert.ToInt32(row.Row.ItemArray[6].ToString());
            }

        }

        private void btnGiamSoLuongMonAnUnrepeatableRead_Click(object sender, RoutedEventArgs e)
        {
            //SoLuong = System.Convert.ToInt32(txtSoLuong.Text);
            ViewUtil.GiamSoLuongMonAnUnrepeatableRead(selectedMonAn.MaMonAn, SoLuong);
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
            //int soLuong = Int32.Parse(txtSoLuong.Text);
            DataRowView dataRow = dtgMonAn.SelectedItem as DataRowView;
            BaseDAO.ThemMotMonAn_DirtyRead_T1(1, Convert.ToString(dataRow.Row[1]), Convert.ToString(dataRow.Row[4]), Convert.ToString(dataRow.Row[5]), Convert.ToInt64(dataRow.Row[3]), Convert.ToInt32(dataRow.Row[6]));
        }
}
