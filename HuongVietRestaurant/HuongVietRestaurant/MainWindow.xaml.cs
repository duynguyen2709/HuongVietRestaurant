using System;
using System.Windows;
using HuongVietRestaurant.DAO;

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
            var u = BaseDAO.XemMotDonHang(1);
            Console.Write(u);
        }
    }
}
