using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Windows;
using HuongVietRestaurant.DAO;
using HuongVietRestaurant.Entities;

namespace HuongVietRestaurant
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            List<MonAn> result = BaseDAO.XemMonAn();
            dataGrid.ItemsSource = ToDataTable<MonAn>(result).DefaultView;
            List<DonHang> result1 = BaseDAO.XemDonHang();
            dataGrid1.ItemsSource = ToDataTable<DonHang>(result1).DefaultView;
            List<ChuongTrinhKhuyenMai> result2 = BaseDAO.XemChuongTrinhKhuyenMai();
            dataGrid2.ItemsSource = ToDataTable<ChuongTrinhKhuyenMai>(result2).DefaultView;
            List<ThanhVien> result3 = BaseDAO.XemThanhVien();
            dataGrid_Member.ItemsSource = ToDataTable<ThanhVien>(result3).DefaultView;

        }
        public static DataTable ToDataTable<T>(IList<T> data)
        {
            PropertyDescriptorCollection properties =
                TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            foreach (PropertyDescriptor prop in properties)
                table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (T item in data)
            {
                DataRow row = table.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                table.Rows.Add(row);
            }
            return table;
        }
    }
}
