using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using Npgsql;
using ShoeStore.Data;
using ShoeStore.Models;

namespace ShoeStore
{
    public partial class ProductListWindow : Window
    {
        private const int AllSuppliersId = 0;
        private List<Product> _allProducts = new List<Product>();
        private bool _isReady;

        public ProductListWindow()
        {
            InitializeComponent();
            ShowUserInfo();
            ApplyRolePermissions();
            LoadSuppliers();
            LoadProducts();
            _isReady = true;
            ApplyFilters();
        }

        private void ShowUserInfo()
        {
            if (Session.CurrentUser == null)
            {
                UserNameTextBlock.Text = "Гость";
                RoleTextBlock.Text = "Просмотр товаров";
                return;
            }

            UserNameTextBlock.Text = Session.CurrentUser.FullName;
            RoleTextBlock.Text = Session.CurrentUser.RoleName;
        }

        private void ApplyRolePermissions()
        {
            UserRole role = Session.CurrentRole;
            bool isAdministrator = role == UserRole.Administrator;
            bool isManager = role == UserRole.Manager;

            FilterPanel.Visibility = (isAdministrator || isManager) ? Visibility.Visible : Visibility.Collapsed;
            AddProductButton.Visibility = isAdministrator ? Visibility.Visible : Visibility.Collapsed;
            OrdersButton.Visibility = role == UserRole.Guest ? Visibility.Collapsed : Visibility.Visible;

            if (role == UserRole.Client)
            {
                OrdersButton.Content = "Мои заказы";
            }
        }

        private void LoadSuppliers()
        {
            try
            {
                List<LookupItem> suppliers = new List<LookupItem>();
                suppliers.Add(new LookupItem { Id = AllSuppliersId, Name = "Все поставщики" });
                suppliers.AddRange(LookupRepository.GetSuppliers());
                SupplierComboBox.ItemsSource = suppliers;
                SupplierComboBox.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                ShowLoadError(ex);
            }
        }

        private void LoadProducts()
        {
            try
            {
                _allProducts = ProductRepository.GetAll();
            }
            catch (Exception ex)
            {
                _allProducts = new List<Product>();
                ShowLoadError(ex);
            }
        }

        private void ApplyFilters()
        {
            if (!_isReady)
            {
                return;
            }

            IEnumerable<Product> result = _allProducts;
            int supplierId = SupplierComboBox.SelectedValue == null
                ? AllSuppliersId
                : (int)SupplierComboBox.SelectedValue;

            if (supplierId != AllSuppliersId)
            {
                result = result.Where(product => product.SupplierId == supplierId);
            }

            string[] words = SearchTextBox.Text.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string word in words)
            {
                string currentWord = word;
                result = result.Where(product => ContainsText(product, currentWord));
            }

            if (SortComboBox.SelectedIndex == 1)
            {
                result = result.OrderBy(product => product.StockQuantity);
            }
            else if (SortComboBox.SelectedIndex == 2)
            {
                result = result.OrderByDescending(product => product.StockQuantity);
            }

            List<Product> filteredProducts = result.ToList();
            ProductsListBox.ItemsSource = filteredProducts;
            CountTextBlock.Text = "Найдено: " + filteredProducts.Count + " из " + _allProducts.Count;
        }

        private static bool ContainsText(Product product, string word)
        {
            string[] fields =
            {
                product.Article,
                product.ProductName,
                product.CategoryName,
                product.Description,
                product.ManufacturerName,
                product.SupplierName,
                product.UnitName
            };

            return fields.Any(field =>
                !string.IsNullOrEmpty(field) &&
                field.IndexOf(word, StringComparison.CurrentCultureIgnoreCase) >= 0);
        }

        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            ApplyFilters();
        }

        private void FilterControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ApplyFilters();
        }

        private void ProductsListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Product selectedProduct = ProductsListBox.SelectedItem as Product;

            if (selectedProduct == null)
            {
                return;
            }

            if (Session.CurrentRole == UserRole.Administrator)
            {
                OpenEditWindow(selectedProduct.Article);
            }

            ProductsListBox.SelectedItem = null;
        }

        private void AddProductButton_Click(object sender, RoutedEventArgs e)
        {
            if (Session.CurrentRole != UserRole.Administrator)
            {
                return;
            }

            OpenEditWindow(null);
        }

        private void OpenEditWindow(string article)
        {
            ProductEditWindow editWindow = new ProductEditWindow(article);
            editWindow.Owner = this;

            bool? result = editWindow.ShowDialog();

            if (result == true)
            {
                LoadProducts();
                ApplyFilters();
            }
        }

        private void OrdersButton_Click(object sender, RoutedEventArgs e)
        {
            if (Session.CurrentRole == UserRole.Guest)
            {
                return;
            }

            OrdersWindow ordersWindow = new OrdersWindow();
            ordersWindow.Owner = this;
            ordersWindow.ShowDialog();

            LoadProducts();
            ApplyFilters();
        }

        private void LogoutButton_Click(object sender, RoutedEventArgs e)
        {
            Session.CurrentUser = null;
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
            Close();
        }

        private void ShowLoadError(Exception ex)
        {
            string message = ex is NpgsqlException
                ? "Не удалось загрузить данные. Проверьте подключение к PostgreSQL."
                : "Непредвиденная ошибка: " + ex.Message;

            MessageBox.Show(message, "Ошибка загрузки данных",
                MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }
}
