using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using HuongVietRestaurant.DAO;
using HuongVietRestaurant.Entities;
using System.Web.Script.Serialization;
using static HuongVietRestaurant.Entities.DonHang;
using System.Windows.Controls;

namespace HuongVietRestaurant.Utilities
{
    public class ViewUtil
    {
        public static void loadView(ViewEnum view)
        {      
            switch (view)
            {
                case ViewEnum.MonAn:
                    List<MonAn> result = BaseDAO.XemMonAn();
                    MainWindow.dtgMonAn.ItemsSource = ToDataTable<MonAn>(result).DefaultView;
                    break;
                case ViewEnum.ChuongTrinhKhuyenMai:
                    List<ChuongTrinhKhuyenMai> result2 = BaseDAO.XemChuongTrinhKhuyenMai();
                    MainWindow.dtgKhuyenMai.ItemsSource = ToDataTable<ChuongTrinhKhuyenMai>(result2).DefaultView;
                    break;
                case ViewEnum.ThanhVien:
                    List<ThanhVien> result3 = BaseDAO.XemThanhVien();
                    MainWindow.dtgThanhVien.ItemsSource = ToDataTable<ThanhVien>(result3).DefaultView;
                    break;
                case ViewEnum.DonHang:
                    List<DonHang> listDonHang = BaseDAO.XemDonHang();
                    MainWindow.dtgDonHang.ItemsSource = ToDataTable<DonHang>(listDonHang).DefaultView;
                    break;
            }
            
        }
        private static DataTable ToDataTable<T>(IList<T> data)
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

        public static void GiamSoLuongMonAnUnrepeatableRead(int MaMonAn, int SoLuong)
        {
            BaseDAO.GiamSoLuongMonAn_UnrepeatableRead(MaMonAn, SoLuong);
        }

        public static void GiamSoLuongMonAnUnrepeatableRead_fixed(int MaMonAn, int SoLuong)
        {
            BaseDAO.GiamSoLuongMonAn_UnrepeatableRead_fixed(MaMonAn, SoLuong);
        }

        public static void CapNhapSoLuongMonAn(int MaMonAn, int SoLuong)
        {
            BaseDAO.CapNhapSoLuongMonAn(MaMonAn, SoLuong);
        }
    }

    public enum ViewEnum
    {
        MonAn,
        ChuongTrinhKhuyenMai,
        DonHang,
        ThanhVien
    }
}
