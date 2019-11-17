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
    }
}
