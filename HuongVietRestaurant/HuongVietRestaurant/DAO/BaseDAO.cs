using HuongVietRestaurant.Entities;
using HuongVietRestaurant.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
        public static List<ThanhVien> XemThanhVien()
        {
            List<ThanhVien> result = new List<ThanhVien>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.XemThanhVien.ToString(), conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                        return result;

                    while (reader.Read())
                    {
                        ThanhVien row = new ThanhVien();
                        row.MaThanhVien = (int)reader["MaThanhVien"];
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

        public static List<ChuongTrinhKhuyenMai> XemChuongTrinhKhuyenMai()
        {
            List<ChuongTrinhKhuyenMai> result = new List<ChuongTrinhKhuyenMai>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.XemChuongTrinhKhuyenMai.ToString(), conn))
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

        public static List<MonAn> XemMonAn()
        {
            List<MonAn> result = new List<MonAn>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.XemMonAn.ToString(), conn))
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
                        row.TenLoai = (string)reader["TenLoai"];
                        row.URLHinhMonAn = (string)reader["URLHinhMonAn"];
                        row.MoTa = (string)reader["MoTa"];
                        row.Gia = (long)reader["Gia"];
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
                        result.TenLoai = (string)reader["TenLoai"];
                        result.URLHinhMonAn = (string)reader["URLHinhMonAn"];
                        result.MoTa = (string)reader["MoTa"];
                        result.Gia = (long)reader["Gia"];
                        break;
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static List<DonHang> XemDonHang()
        {
            List<DonHang> result = new List<DonHang>();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.XemDonHang.ToString(), conn))
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

                            var TenMonAn = (string)reader["TenMonAn"];
                            var SoLuong = (int)reader["SoLuong"];
                            var Gia = (long)reader["Gia"];

                            row.ChiTiet.Add(new DonHang.ChiTietDonHang(TenMonAn, SoLuong, Gia));
                            result.Add(row);
                        } else
                        {
                            var TenMonAn = (string)reader["TenMonAn"];
                            var SoLuong = (int)reader["SoLuong"];
                            var Gia = (long)reader["Gia"];
                            result[result.Count - 1].ChiTiet.Add(new DonHang.ChiTietDonHang(TenMonAn, SoLuong, Gia));
                        }
                    }
                    reader.Close();
                }
            }
            return result;
        }

        public static DonHang XemMotDonHang(int MaDonHang)
        {
            DonHang result = null;
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = connectionString;
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(StoreProcEnum.XemMotDonHang.ToString(), conn))
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

                            var TenMonAn = (string)reader["TenMonAn"];
                            var SoLuong = (int)reader["SoLuong"];
                            var Gia = (long)reader["Gia"];

                            result.ChiTiet.Add(new DonHang.ChiTietDonHang(TenMonAn, SoLuong, Gia));
                        }
                        else
                        {
                            var TenMonAn = (string)reader["TenMonAn"];
                            var SoLuong = (int)reader["SoLuong"];
                            var Gia = (long)reader["Gia"];
                            result.ChiTiet.Add(new DonHang.ChiTietDonHang(TenMonAn, SoLuong, Gia));
                        }
                    }
                    reader.Close();
                }
            }
            return result;
        }

        #endregion
    }
}
