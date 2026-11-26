using System;
using System.Collections.Generic;
using System.Windows;
using ShoeStore.Data;
using ShoeStore.Models;

namespace ShoeStore
{
    public partial class OrdersWindow : Window
    {
        public OrdersWindow()
        {
            InitializeComponent();
            ApplyPermissions();
            LoadOrders();
        }

        private void ApplyPermissions()
        {
            UserRole role = Session.CurrentRole;
            bool isAdministrator = role == UserRole.Administrator;
            bool canCreate = role == UserRole.Administrator || role == UserRole.Manager;

            RoleInfoTextBlock.Text = Session.CurrentUser == null
                ? "Гость"
                : Session.CurrentUser.FullName + " — " + Session.CurrentUser.RoleName;

            CreateOrderButton.Visibility = canCreate ? Visibility.Visible : Visibility.Collapsed;
            EditOrderButton.Visibility = isAdministrator ? Visibility.Visible : Visibility.Collapsed;
            DeleteOrderButton.Visibility = isAdministrator ? Visibility.Visible : Visibility.Collapsed;
        }

        private void LoadOrders()
        {
            try
            {
                int? userId = Session.CurrentRole == UserRole.Client
                    ? (int?)Session.CurrentUser.UserId
                    : null;

                List<OrderView> orders = OrderRepository.GetAll(userId);
                OrdersDataGrid.ItemsSource = orders;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex is Npgsql.NpgsqlException
                    ? "Не удалось загрузить заказы. Проверьте подключение к PostgreSQL."
                    : "Ошибка загрузки заказов: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void CreateOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (Session.CurrentRole != UserRole.Administrator && Session.CurrentRole != UserRole.Manager)
            {
                return;
            }

            OrderEditWindow window = new OrderEditWindow(null);
            window.Owner = this;

            if (window.ShowDialog() == true)
            {
                LoadOrders();
            }
        }

        private void EditOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (Session.CurrentRole != UserRole.Administrator)
            {
                return;
            }

            OrderView selectedOrder = OrdersDataGrid.SelectedItem as OrderView;

            if (selectedOrder == null)
            {
                MessageBox.Show("Выберите заказ для редактирования.", "Заказ не выбран",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            OrderEditWindow window = new OrderEditWindow(selectedOrder.OrderId);
            window.Owner = this;

            if (window.ShowDialog() == true)
            {
                LoadOrders();
            }
        }

        private void DeleteOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (Session.CurrentRole != UserRole.Administrator)
            {
                return;
            }

            OrderView selectedOrder = OrdersDataGrid.SelectedItem as OrderView;

            if (selectedOrder == null)
            {
                MessageBox.Show("Выберите заказ для удаления.", "Заказ не выбран",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            MessageBoxResult answer = MessageBox.Show(
                "Удалить заказ №" + selectedOrder.OrderId + "? Это действие нельзя отменить.",
                "Подтверждение удаления", MessageBoxButton.YesNo, MessageBoxImage.Warning);

            if (answer != MessageBoxResult.Yes)
            {
                return;
            }

            try
            {
                OrderRepository.Delete(selectedOrder.OrderId);
                LoadOrders();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Не удалось удалить заказ: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
