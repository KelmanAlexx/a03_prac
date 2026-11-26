using System;
using System.Windows;
using Npgsql;
using ShoeStore.Data;
using ShoeStore.Models;

namespace ShoeStore
{
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
            LoginTextBox.Focus();
        }

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            string login = LoginTextBox.Text.Trim();
            string password = PasswordBox.Password;

            if (login.Length == 0 || password.Length == 0)
            {
                MessageBox.Show("Заполните логин и пароль.", "Проверьте данные",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                AppUser user = UserRepository.Authenticate(login, password);

                if (user == null)
                {
                    MessageBox.Show("Неверный логин или пароль.", "Ошибка входа",
                        MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                Session.CurrentUser = user;
                OpenProductList();
            }
            catch (NpgsqlException)
            {
                MessageBox.Show("Не удалось подключиться к базе данных. Проверьте, запущен ли PostgreSQL и верны ли параметры подключения в App.config.",
                    "Ошибка подключения", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Непредвиденная ошибка: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void GuestButton_Click(object sender, RoutedEventArgs e)
        {
            Session.CurrentUser = null;
            OpenProductList();
        }

        private void OpenProductList()
        {
            ProductListWindow window = new ProductListWindow();
            window.Show();
            Close();
        }
    }
}
