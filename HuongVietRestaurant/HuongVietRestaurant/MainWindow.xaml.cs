using System.Windows;
using HuongVietRestaurant.Utilities;
using System.Windows.Controls;
using HuongVietRestaurant.DAO;
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

        public static MonAn selectedMonAn = null;
        public static int SoLuong { get; set; }
        public MainWindow()
        {
            InitializeComponent();
            dtgMonAn = dataGrid;
            dtgKhuyenMai = dataGrid2;
            dtgThanhVien = dataGrid_Member;
            dtgDonHang = dataGrid1;
            selectedMonAn = new MonAn();
            SoLuong = 0;


            ViewUtil.loadView(ViewEnum.MonAn);
            ViewUtil.loadView(ViewEnum.ChuongTrinhKhuyenMai);
            ViewUtil.loadView(ViewEnum.ThanhVien);
            ViewUtil.loadView(ViewEnum.DonHang);
        }      

        private void btnReloadView_Food_Click(object sender, RoutedEventArgs e)
        {
            ViewUtil.loadView(ViewEnum.MonAn);
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

        private void btnLocMonAnTheoGia_Phantom_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnCapNhatSoLuongMonAn_Click(object sender, RoutedEventArgs e)
        {
            //SoLuong = System.Convert.ToInt32(txtSoLuong.Text);
            Trace.WriteLine(SoLuong);
            ViewUtil.CapNhapSoLuongMonAn(selectedMonAn.MaMonAn, SoLuong);
        }

        private void btnGiamSoLuongMonAnUnrepeatableRead_fixed_Click(object sender, RoutedEventArgs e)
        {
            //SoLuong = System.Convert.ToInt32(txtSoLuong.Text);
            ViewUtil.GiamSoLuongMonAnUnrepeatableRead_fixed(selectedMonAn.MaMonAn, SoLuong);
        }

        private void onTextChanged(object sender, RoutedEventArgs e)
        {
            //Trace.WriteLine("123");
            try { 
            SoLuong = System.Convert.ToInt32(txtSoLuong.Text);
            }
            catch
            {
                return;
            }
        }
    }
}
