using HuongVietRestaurant.Entities;
using HuongVietRestaurant.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace HuongVietRestaurant.DAO
{
    public class BaseDAO
    {
        private static string connectionString = "Server=(local);Database=HuongVietRestaurant;Integrated Security = SSPI";

        public static ThanhVien DangNhap(string TenDangNhap, string MatKhau)
        {
            ThanhVien result = null;
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.DangNhap.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TenDangNhap", TenDangNhap);
                    cmd.Parameters.AddWithValue("@MatKhau", MatKhau);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    result = new ThanhVien();
                    while (reader.Read())
                    {
                        result.MaThanhVien = (int)reader["MaThanhVien"];
                        result.HoTen = (string)reader["HoTen"];
                        result.CMND = (string)reader["CMND"];
                        result.SoDienThoai = (string)reader["SoDienThoai"];
                        result.Email = (string)reader["Email"];
                        result.NgaySinh = reader["NgaySinh"].ToString();
                        result.DiaChi = (string)reader["DiaChi"];
                        result.QuyenHan = (int)reader["QuyenHan"];
                        result.DiemTichLuy = (long)reader["DiemTichLuy"];
                        break;
                    }
                    reader.Close();
                }
            }
            return result;
        }

        #region SELECT 
        public static List<ThanhVien> XemThanhVien(StoreProcEnum type=StoreProcEnum.XemThanhVien)
        {
            List<ThanhVien> result = new List<ThanhVien>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    while (reader.Read())
                    {
                        ThanhVien row = new ThanhVien();
                        row.MaThanhVien = (int)reader["MaThanhVien"];
                        row.MaChiNhanh = (int)reader["MaChiNhanh"];
                        row.HoTen = (string)reader["HoTen"];
                        row.CMND = (string)reader["CMND"];
                        row.SoDienThoai = (string)reader["SoDienThoai"];
                        row.Email = (string)reader["Email"];
                        row.NgaySinh = reader["NgaySinh"].ToString();
                        row.DiaChi = (string)reader["DiaChi"];
                        row.QuyenHan = 0;
                        row.DiemTichLuy = (long)reader["DiemTichLuy"];
                        result.Add(row);
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static ThanhVien XemMotThanhVien(int MaThanhVien)
        {
            ThanhVien result = null;
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.XemMotThanhVien.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaThanhVien", MaThanhVien);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    result = new ThanhVien();
                    while (reader.Read())
                    {
                        result.MaThanhVien = MaThanhVien;
                        result.MaChiNhanh = (int)reader["MaChiNhanh"];
                        result.HoTen = (string)reader["HoTen"];
                        result.CMND = (string)reader["CMND"];
                        result.SoDienThoai = (string)reader["SoDienThoai"];
                        result.Email = (string)reader["Email"];
                        result.NgaySinh = reader["NgaySinh"].ToString();
                        result.DiaChi = (string)reader["DiaChi"];
                        result.QuyenHan = 0;
                        result.DiemTichLuy = (long)reader["DiemTichLuy"];
                        break;
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static List<ChuongTrinhKhuyenMai> XemChuongTrinhKhuyenMai(StoreProcEnum type=StoreProcEnum.XemChuongTrinhKhuyenMai)
        {
            List<ChuongTrinhKhuyenMai> result = new List<ChuongTrinhKhuyenMai>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    while (reader.Read())
                    {
                        ChuongTrinhKhuyenMai row = new ChuongTrinhKhuyenMai();
                        row.MaKhuyenMai = (int)reader["MaKhuyenMai"];
                        row.TenChuongTrinh = (string)reader["TenChuongTrinh"];
                        row.MaLoai = (int)reader["MaLoai"];
                        row.DoiTuongApDung = (int)reader["DoiTuongApDung"];
                        row.GiaTri = (long)reader["GiaTri"];
                        row.NgayBatDau = reader["NgayBatDau"].ToString();
                        row.NgayKetThuc = reader["NgayKetThuc"].ToString();
                        row.SoLuong = (int)reader["SoLuong"];
                        result.Add(row);
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static ChuongTrinhKhuyenMai XemMotChuongTrinhKhuyenMai(int MaKhuyenMai)
        {
            ChuongTrinhKhuyenMai result = null;
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.XemMotChuongTrinhKhuyenMai.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaKhuyenMai", MaKhuyenMai);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    result = new ChuongTrinhKhuyenMai();
                    while (reader.Read())
                    {
                        result.MaKhuyenMai = MaKhuyenMai;
                        result.TenChuongTrinh = (string)reader["TenChuongTrinh"];
                        result.MaLoai = (int)reader["MaLoai"];
                        result.DoiTuongApDung = (int)reader["DoiTuongApDung"];
                        result.GiaTri = (long)reader["GiaTri"];
                        result.NgayBatDau = reader["NgayBatDau"].ToString();
                        result.NgayKetThuc = reader["NgayKetThuc"].ToString();
                        result.SoLuong = (int)reader["SoLuong"];
                        break;
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static List<MonAn> XemMonAn(StoreProcEnum type=StoreProcEnum.XemMonAn)
        {
            List<MonAn> result = new List<MonAn>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    while (reader.Read())
                    {
                        MonAn row = new MonAn();
                        row.MaMonAn = (int)reader["MaMonAn"];
                        row.TenMonAn = (string)reader["TenMonAn"];
                        row.MaLoai = (int)reader["MaLoai"];
                        row.TenLoai = (string)reader["TenLoai"];
                        row.URLHinhMonAn = (string)reader["URLHinhMonAn"];
                        row.MoTa = (string)reader["MoTa"];
                        row.Gia = (long)reader["Gia"];
                        row.SoLuong = (int)reader["SoLuong"];
                        result.Add(row);
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static MonAn XemMotMonAn(int MaMonAn)
        {
            MonAn result = null;
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.XemMotMonAn.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaMonAn", MaMonAn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    result = new MonAn();
                    while (reader.Read())
                    {
                        result.MaMonAn = (int)reader["MaMonAn"];
                        result.TenMonAn = (string)reader["TenMonAn"];
                        result.MaLoai = (int)reader["MaLoai"];
                        result.TenLoai = (string)reader["TenLoai"];
                        result.URLHinhMonAn = (string)reader["URLHinhMonAn"];
                        result.MoTa = (string)reader["MoTa"];
                        result.Gia = (long)reader["Gia"];
                        result.SoLuong = (int)reader["SoLuong"];
                        break;
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static List<DonHang> XemDonHang(StoreProcEnum type=StoreProcEnum.XemDonHang)
        {
            List<DonHang> result = new List<DonHang>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    int lastMaDonHang = -1;
                    while (reader.Read())
                    {
                        DonHang row = new DonHang();
                        row.MaDonHang = (int)reader["MaDonHang"];
                        if (row.MaDonHang != lastMaDonHang)
                        {
                            lastMaDonHang = row.MaDonHang;

                            row.TenChiNhanh = (string)reader["TenChiNhanh"];
                            row.TenThanhVien = (string)reader["TenThanhVien"];
                            row.ThoiGianTao = reader["ThoiGianTao"].ToString();
                            row.ThoiGianGiaoHang = reader["ThoiGianGiaoHang"].ToString();
                            row.TenTrangThai = (string)reader["TenTrangThai"];
                            row.TongTien = (long)reader["TongTien"];
                            row.PhiGiaoHang = (long)reader["PhiGiaoHang"];
                            row.PhuongThucThanhToan = reader["PhuongThucThanhToan"].ToString();
                            row.DiaChiGiaoHang = (string)reader["DiaChiGiaoHang"];
                            row.TenKenhDatHang = (string)reader["TenKenhDatHang"];

                            var MaMonAn = (int)reader["MaMonAn"];
                            var TenMonAn = (string)reader["TenMonAn"];
                            var SoLuong = (int)reader["SoLuong"];
                            var Gia = (long)reader["Gia"];
                            ChiTietDonHang donHang = new ChiTietDonHang(MaMonAn, TenMonAn, SoLuong, Gia);
                            donHang.PropertyChanged += MainWindow.PropertyChanged;
                            row.ChiTiet.Add(donHang);
                            result.Add(row);
                        }
                        else
                        {
                            var MaMonAn = (int)reader["MaMonAn"];
                            var TenMonAn = (string)reader["TenMonAn"];
                            var SoLuong = (int)reader["SoLuong"];
                            var Gia = (long)reader["Gia"];
                            ChiTietDonHang donHang = new ChiTietDonHang(MaMonAn, TenMonAn, SoLuong, Gia);
                            donHang.PropertyChanged += MainWindow.PropertyChanged;
                            result[result.Count - 1].ChiTiet.Add(donHang);
                        }
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static DonHang XemMotDonHang(int MaDonHang,StoreProcEnum type=StoreProcEnum.XemMotDonHang)
        {
            DonHang result = null;
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaDonHang", MaDonHang);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    int lastMaDonHang = -1;
                    result = new DonHang();
                    while (reader.Read())
                    {
                        result.MaDonHang = (int)reader["MaDonHang"];
                        if (result.MaDonHang != lastMaDonHang)
                        {
                            lastMaDonHang = result.MaDonHang;

                            result.TenChiNhanh = (string)reader["TenChiNhanh"];
                            result.TenThanhVien = (string)reader["TenThanhVien"];
                            result.ThoiGianTao = reader["ThoiGianTao"].ToString();
                            result.ThoiGianGiaoHang = reader["ThoiGianGiaoHang"].ToString();
                            result.TenTrangThai = (string)reader["TenTrangThai"];
                            result.TongTien = (long)reader["TongTien"];
                            result.PhiGiaoHang = (long)reader["PhiGiaoHang"];
                            result.PhuongThucThanhToan = reader["PhuongThucThanhToan"].ToString();
                            result.DiaChiGiaoHang = (string)reader["DiaChiGiaoHang"];
                            result.TenKenhDatHang = (string)reader["TenKenhDatHang"];

                            var MaMonAn = (int)reader["MaMonAn"];
                            var TenMonAn = (string)reader["TenMonAn"];
                            var SoLuong = (int)reader["SoLuong"];
                            var Gia = (long)reader["Gia"];

                            result.ChiTiet.Add(new ChiTietDonHang(MaMonAn, TenMonAn, SoLuong, Gia));
                        }
                        else
                        {
                            var MaMonAn = (int)reader["MaMonAn"];
                            var TenMonAn = (string)reader["TenMonAn"];
                            var SoLuong = (int)reader["SoLuong"];
                            var Gia = (long)reader["Gia"];
                            result.ChiTiet.Add(new ChiTietDonHang(MaMonAn, TenMonAn, SoLuong, Gia));
                        }
                    }
                    reader.Close();
                }
            }
            return result;
        }

        #endregion
        #region FOODTAB
        public static void GiamSoLuongMonAn_UnrepeatableRead(int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAn(MaMonAn, SoLuong, StoreProcEnum.GiamSoLuongMonAn_UnrepeatableRead);
        }

        public static void GiamSoLuongMonAn_UnrepeatableRead_fixed(int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAn(MaMonAn, SoLuong, StoreProcEnum.GiamSoLuongMonAn_UnrepeatableRead_fixed);
        }

        public static void CapNhapSoLuongMonAn(int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAn(MaMonAn, SoLuong, StoreProcEnum.CapNhapSoLuongMonAn);
        }

        public static void CapNhapMonAn_Deadlock(int MaMonAn, string TenMonAn, string URLHinhMonAn, string MoTa, long Gia)
        {
            DoCommandOnFood(MaMonAn, TenMonAn, URLHinhMonAn, MoTa, Gia, StoreProcEnum.CapNhapMonAn_Deadlock);
        }

        public static void CapNhapMonAn_Deadlock_fixed(int MaMonAn, string TenMonAn, string URLHinhMonAn, string MoTa, long Gia)
        {
            DoCommandOnFood(MaMonAn, TenMonAn, URLHinhMonAn, MoTa, Gia, StoreProcEnum.CapNhapMonAn_Deadlock_fixed);
        }

        public static void ThemMotMonAn_DirtyRead_T1(int MaLoai, string TenMonAn, string URLHinhMonAn, string MoTa, long Gia, int SoLuong)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.ThemMotMonAn_DirtyRead_T1.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaLoai", MaLoai);
                    cmd.Parameters.AddWithValue("@TenMonAn", TenMonAn);
                    cmd.Parameters.AddWithValue("@URLHinhMonAn", URLHinhMonAn);
                    cmd.Parameters.AddWithValue("@MoTa", MoTa);
                    cmd.Parameters.AddWithValue("@Gia", Gia);
                    cmd.Parameters.AddWithValue("@SoLuong", SoLuong);
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch
                    {
                        MessageBox.Show("Không thể thêm sản phẩm với giá 0đ");
                    }
                }
            }
        }

        public static List<MonAn> XemMonAn_DirtRead_T2()
        {
            return XemMonAn(StoreProcEnum.XemMonAn_DirtRead_T2);
        }

        public static List<MonAn> XemMonAn_DirtRead_T2_fixed()
        {
            return XemMonAn(StoreProcEnum.XemMonAn_DirtRead_T2_fixed);
        }

        public static void GiamSoLuongMonAn_LostUpdate(int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAn(MaMonAn, SoLuong, StoreProcEnum.GiamSoLuongMonAn_LostUpdate);
        }


        public static void GiamSoLuongMonAn_LostUpdate_fixed(int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAn(MaMonAn, SoLuong, StoreProcEnum.GiamSoLuongMonAn_LostUpdate_fixed);
        }

        public static void ThemMotMonAn_Phantom_T2(int @MaLoai, string TenMonAn, string URLHinhMonAn, string MoTa, long Gia, int SoLuong)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.ThemMotMonAn_Phantom_T2.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@@MaLoai", @MaLoai);
                    cmd.Parameters.AddWithValue("@TenMonAn", TenMonAn);
                    cmd.Parameters.AddWithValue("@URLHinhMonAn", URLHinhMonAn);
                    cmd.Parameters.AddWithValue("@MoTa", MoTa);
                    cmd.Parameters.AddWithValue("@Gia", Gia);
                    cmd.Parameters.AddWithValue("@SoLuong", SoLuong);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public static List<DataTable> LocMonAnTheoGia_Phantom(double Gia)
        {
            return LocMonAn(Gia,StoreProcEnum.LocMonAnTheoGia_Phantom);
        }

        public static List<DataTable> LocMonAnTheoGia_Phantom_fixed(double Gia)
        {
            return LocMonAn(Gia, StoreProcEnum.LocMonAnTheoGia_Phantom_fixed);
        }

        private static void UpdateSoLuongMonAn(int MaMonAn, int SoLuong, StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaMonAn", MaMonAn);
                    cmd.Parameters.AddWithValue("@SoLuong", SoLuong);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private static void DoCommandOnFood(int MaMonAn = 0, string TenMonAn = "", string URLHinhMonAn = "", string MoTa = "", long Gia = 0, StoreProcEnum type = StoreProcEnum.CapNhapMonAn_Deadlock)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaMonAn", MaMonAn);
                    cmd.Parameters.AddWithValue("@TenMonAn", TenMonAn);
                    cmd.Parameters.AddWithValue("@URLHinhMonAn", URLHinhMonAn);
                    cmd.Parameters.AddWithValue("@MoTa", MoTa);
                    cmd.Parameters.AddWithValue("@Gia", Gia);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private static List<DataTable> LocMonAn(double Gia, StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Gia", Gia);
                    SqlDataAdapter da = new SqlDataAdapter();
                    DataSet ds = new DataSet();
                    da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    List<DataTable> result = new List<DataTable>();
                    foreach (DataTable element in ds.Tables)
                    {
                        result.Add(element);
                    }
                    return result;
                }
            }
        }
        #endregion
        #region BASKET_TAB
        public static void GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead(int MaDonHang, int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAnTrongChiTietDonHang(MaDonHang, MaMonAn, SoLuong,StoreProcEnum.GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead);
        }
        public static void GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead_fixed(int MaDonHang, int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAnTrongChiTietDonHang(MaDonHang, MaMonAn, SoLuong, StoreProcEnum.GiamSoLuongMonAnTrongChiTietDonHang_UnrepeatableRead_fixed);
        }
        public static void GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate(int MaDonHang, int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAnTrongChiTietDonHang(MaDonHang, MaMonAn, SoLuong, StoreProcEnum.GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate);
        }
        public static void GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate_fixed(int MaDonHang, int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAnTrongChiTietDonHang(MaDonHang, MaMonAn, SoLuong, StoreProcEnum.GiamSoLuongMonAnTrongChiTietDonHang_LostUpdate_fixed);
        }
        public static void CapNhatSoLuongMonAnTrongChiTietDonHang(int MaDonHang, int MaMonAn, int SoLuong)
        {
            UpdateSoLuongMonAnTrongChiTietDonHang(MaDonHang, MaMonAn, SoLuong, StoreProcEnum.CapNhapSoLuongMonAnTrongChiTietDonHang);
        }
        private static void UpdateSoLuongMonAnTrongChiTietDonHang(int MaDonHang, int MaMonAn, int SoLuong, StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaDonHang", MaDonHang);
                    cmd.Parameters.AddWithValue("@MaMonAn", MaMonAn);
                    cmd.Parameters.AddWithValue("@SoLuong", SoLuong);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        #endregion
        #region MEMBER_TAB
        public static void CapNhapThanhVien_Deadlock(int MaThanhVien, int MaChiNhanh, string TenThanhVien, string CMND, string SDT, string Email, string NgaySinh, string DiaChi, long DiemTichLuy)
        {
            CapNhatThanhVien(MaThanhVien, MaChiNhanh, TenThanhVien, CMND, SDT, Email, NgaySinh, DiaChi, DiemTichLuy, StoreProcEnum.CapNhapThanhVien_Deadlock);
        }

        public static void CapNhapThanhVien_Deadlock_fixed(int MaThanhVien, int MaChiNhanh, string TenThanhVien, string CMND, string SDT, string Email, string NgaySinh, string DiaChi, long DiemTichLuy)
        {
            CapNhatThanhVien(MaThanhVien, MaChiNhanh, TenThanhVien, CMND, SDT, Email, NgaySinh, DiaChi, DiemTichLuy, StoreProcEnum.CapNhapThanhVien_Deadlock_fixed);
        }

        private static void CapNhatThanhVien(int MaThanhVien, int MaChiNhanh, string TenThanhVien, string CMND, string SDT, string Email, string NgaySinh, string DiaChi, long DiemTichLuy, StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaThanhVien", MaThanhVien);
                    cmd.Parameters.AddWithValue("@MaChiNhanh", MaChiNhanh);
                    cmd.Parameters.AddWithValue("@TenThanhVien", TenThanhVien);
                    cmd.Parameters.AddWithValue("@CMND", CMND);
                    cmd.Parameters.AddWithValue("@SoDienThoai", SDT);
                    cmd.Parameters.AddWithValue("@Email", Email);
                    cmd.Parameters.AddWithValue("@NgaySinh", NgaySinh);
                    cmd.Parameters.AddWithValue("@DiaChi", DiaChi);
                    cmd.Parameters.AddWithValue("@DiemTichLuy", DiemTichLuy);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public static void ThemThanhVien_DirtyRead(int MaChiNhanh, string TenThanhVien, string CMND, string SDT, string Email, string NgaySinh, string DiaChi, long DiemTichLuy)
        {
            ThemThanhVien(MaChiNhanh, TenThanhVien, CMND, SDT, Email, NgaySinh, DiaChi, DiemTichLuy,StoreProcEnum.ThemThanhVien_DirtyRead_T1);
        }
        public static void ThemThanhVien_Phantom(int MaChiNhanh, string TenThanhVien, string CMND, string SDT, string Email, string NgaySinh, string DiaChi, long DiemTichLuy)
        {
            ThemThanhVien(MaChiNhanh, TenThanhVien, CMND, SDT, Email, NgaySinh, DiaChi, DiemTichLuy, StoreProcEnum.ThemThanhVien_Phantom_T2);
        }
        private static void ThemThanhVien(int MaChiNhanh, string TenThanhVien, string CMND, string SDT, string Email, string NgaySinh, string DiaChi, long DiemTichLuy,StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaChiNhanh", MaChiNhanh);
                    cmd.Parameters.AddWithValue("@HoTen", TenThanhVien);
                    cmd.Parameters.AddWithValue("@CMND", CMND);
                    cmd.Parameters.AddWithValue("@SoDienThoai", SDT);
                    cmd.Parameters.AddWithValue("@Email", Email);
                    cmd.Parameters.AddWithValue("@NgaySinh", DateTime.ParseExact(NgaySinh, "dd/MM/yyyy", null));
                    cmd.Parameters.AddWithValue("@DiaChi", DiaChi);
                    cmd.Parameters.AddWithValue("@DiemTichLuy", DiemTichLuy);
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch
                    {
                        MessageBox.Show("Số CMND không hợp lệ");
                    }
                }
            }
        }

        
        public static List<ThanhVien> XemThanhVien_DirtRead_T2()
        {
            return XemThanhVien(StoreProcEnum.XemThanhVien_DirtRead_T2);
        }
        public static List<ThanhVien> XemThanhVien_DirtRead_T2_Fixed()
        {
            return XemThanhVien(StoreProcEnum.XemThanhVien_DirtRead_T2_fixed);
        }
        public static List<DataTable> LocThanhVienTheoDiem(long Diem)
        {
            return LocThanhVien(Diem,StoreProcEnum.LocThanhVienTheoDiem_Phantom);
        }
        public static List<DataTable> LocThanhVienTheoDiem_fixed(long Diem)
        {
            return LocThanhVien(Diem, StoreProcEnum.LocThanhVienTheoDiem_fixed);
        }

        private static List<DataTable> LocThanhVien(long Diem, StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Diem", Diem);
                    SqlDataAdapter da = new SqlDataAdapter();
                    DataSet ds = new DataSet();
                    da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    List<DataTable> result = new List<DataTable>();
                    foreach (DataTable element in ds.Tables)
                    {
                        result.Add(element);
                    }
                    return result;
                }
            }
        }

        
        #endregion
        #region VOUCHER
        public static List<DataTable> DungVoucher_UnrepeatableRead(int MaKhuyenMai)
        {
            return DungVoucher(MaKhuyenMai,StoreProcEnum.DungVoucher_UnrepeatableRead);
        }

        public static List<DataTable> DungVoucher_UnrepeatableRead_fixed(int MaKhuyenMai)
        {
            return DungVoucher(MaKhuyenMai, StoreProcEnum.DungVoucher_UnrepeatableRead_fixed);
        }

        private static List<DataTable> DungVoucher(int MaKhuyenMai,StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaKhuyenMai", MaKhuyenMai);
                    SqlDataAdapter da = new SqlDataAdapter();
                    DataSet ds = new DataSet();
                    da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    List<DataTable> result = new List<DataTable>();
                    foreach (DataTable element in ds.Tables)
                    {
                        result.Add(element);
                    }
                    return result;
                }
            }
        }

        
        public static void CapNhatSoLuongVoucher(int MaVoucher,int SoLuong)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.CapNhapSoLuongVoucher.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaVoucher", MaVoucher);
                    cmd.Parameters.AddWithValue("@SoLuong", SoLuong);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public static void CapNhatVoucher_Deadlock(int MaVoucher, String GiaTri)
        {
            CapNhatVoucher(MaVoucher, GiaTri,StoreProcEnum.CapNhapVoucher_Deadlock);
        }

        private static void CapNhatVoucher(int MaVoucher, string GiaTri, StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaKhuyenMai", MaVoucher);
                    cmd.Parameters.AddWithValue("@GiaTri", GiaTri);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public static void CapNhatVoucher_Deadlock_fixed(int MaVoucher, String GiaTri)
        {
            CapNhatVoucher(MaVoucher, GiaTri, StoreProcEnum.CapNhapVoucher_Deadlock_fixed);
        }
        public static List<ChuongTrinhKhuyenMai> XemChuongTrinhKhuyenMai_DirtyRead()
        {
            return XemChuongTrinhKhuyenMai(StoreProcEnum.XemVoucher_DirtRead_T2);
        }
        public static List<ChuongTrinhKhuyenMai> XemChuongTrinhKhuyenMai_DirtyRead_fixed()
        {
            return XemChuongTrinhKhuyenMai(StoreProcEnum.XemVoucher_DirtRead_T2_fixed);
        }
        public static List<DataTable> DungVoucher_LostUpdate(int MaKhuyenMai)
        {
            return DungVoucher(MaKhuyenMai, StoreProcEnum.DungVoucher_LostUpdate);
        }
        public static List<DataTable> DungVoucher_LostUpdate_fixed(int MaKhuyenMai)
        {
            return DungVoucher(MaKhuyenMai, StoreProcEnum.DungVoucher_LostUpdate_fixed);
        }
        public static void ThemVoucher_DirtyRead_T1(int MaLoai, string TenChuongTrinh, int DoiTuongApDung, int GiaTri, string NgayBatDau, string NgayKetThuc, int SoLuong)
        {
            ThemVoucher(MaLoai, TenChuongTrinh, DoiTuongApDung, GiaTri, NgayBatDau, NgayKetThuc, SoLuong,StoreProcEnum.ThemMotMonAn_DirtyRead_T1);
        }

        private static void ThemVoucher(int MaLoai, string TenChuongTrinh, int DoiTuongApDung, int GiaTri, string NgayBatDau, string NgayKetThuc, int SoLuong, StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TenChuongTrinh", TenChuongTrinh);
                    cmd.Parameters.AddWithValue("@MaLoai", MaLoai);
                    cmd.Parameters.AddWithValue("@DoiTuongApDung", DoiTuongApDung);
                    cmd.Parameters.AddWithValue("@GiaTri", GiaTri);
                    cmd.Parameters.AddWithValue("@NgayBatDat", DateTime.ParseExact(NgayBatDau, "dd/MM/yyyy", null));
                    cmd.Parameters.AddWithValue("@NgayKetThuc", DateTime.ParseExact(NgayKetThuc, "dd/MM/yyyy", null));
                    cmd.Parameters.AddWithValue("@SoLuong", SoLuong);
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch
                    {
                        MessageBox.Show("Không thể thêm chương trình khuyến mãi có số lượng nhỏ hơn hoặc bằng 0");
                    }
                }
            }
        }

        public static void ThemVoucher_Phantom(int MaLoai, string TenChuongTrinh, int DoiTuongApDung, int GiaTri, string NgayBatDau, string NgayKetThuc, int SoLuong)
        {
            ThemVoucher(MaLoai, TenChuongTrinh, DoiTuongApDung, GiaTri, NgayBatDau, NgayKetThuc, SoLuong, StoreProcEnum.ThemMotMonAn_Phantom_T2);
        }
        public static List<DataTable> LocVoucherTheoGiaTri_Phantom(int GiaTri)
        {
            return LocVoucher(GiaTri,StoreProcEnum.LocVoucherTheoGiaTri_Phantom);
        }

        private static List<DataTable> LocVoucher(int GiaTri,StoreProcEnum type)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(type.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@GiaTri", GiaTri);
                    SqlDataAdapter da = new SqlDataAdapter();
                    DataSet ds = new DataSet();
                    da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    List<DataTable> result = new List<DataTable>();
                    foreach (DataTable element in ds.Tables)
                    {
                        result.Add(element);
                    }
                    return result;
                }
            }
        }

        public static List<DataTable> LocVoucherTheoGiaTri_Phantom_fixed(int GiaTri)
        {
            return LocVoucher(GiaTri, StoreProcEnum.LocVoucherTheoGiaTri_fixed);
        }
        #endregion
    }
}
