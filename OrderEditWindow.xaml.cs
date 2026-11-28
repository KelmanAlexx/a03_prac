using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using ShoeStore.Data;
using ShoeStore.Models;

namespace ShoeStore
{
    public partial class OrderEditWindow : Window
    {
        private readonly int? _orderId;
        private readonly List<OrderLine> _lines = new List<OrderLine>();
        private DateTime _orderDate;

        public OrderEditWindow(int? orderId)
        {
            InitializeComponent();
            _orderId = orderId;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                ClientComboBox.ItemsSource = LookupRepository.GetClients();
                PickupComboBox.ItemsSource = LookupRepository.GetPickupPoints();
                StatusComboBox.ItemsSource = LookupRepository.GetStatuses();

                if (_orderId.HasValue)
                {
                    LoadOrder(_orderId.Value);
                }
                else
                {
                    PrepareNewOrder();
                }

                LinesDataGrid.ItemsSource = _lines;
                UpdateTotal();
            }
            catch (Exception ex)
            {
                ShowError(ex);
                DialogResult = false;
            }
        }

        private void PrepareNewOrder()
        {
            Title = "Оформление заказа — Магазин электроники";
            HeaderTextBlock.Text = "Оформление заказа";
            _orderDate = DateTime.Today;
            OrderDateTextBox.Text = _orderDate.ToString("dd.MM.yyyy");
            DeliveryDatePicker.DisplayDateStart = _orderDate;
            DeliveryDatePicker.SelectedDate = _orderDate.AddDays(3);
            CodeTextBlock.Text = "Будет назначен автоматически";
            ProductComboBox.ItemsSource = ProductRepository.GetAll()
                .Where(product => product.StockQuantity > 0).ToList();

            if (Session.CurrentRole == UserRole.Client)
            {
                ClientComboBox.SelectedValue = Session.CurrentUser.UserId;
                ClientComboBox.IsEnabled = false;
            }

            LookupItem newStatus = StatusComboBox.Items.Cast<LookupItem>()
                .FirstOrDefault(item => item.Name.Trim() == "Новый");

            if (newStatus != null)
            {
                StatusComboBox.SelectedValue = newStatus.Id;
            }
            else if (StatusComboBox.Items.Count > 0)
            {
                StatusComboBox.SelectedIndex = 0;
            }
        }

        private void LoadOrder(int orderId)
        {
            OrderView order = OrderRepository.GetAll(null).FirstOrDefault(item => item.OrderId == orderId);

            if (order == null)
            {
                MessageBox.Show("Заказ не найден.", "Заказ не найден",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                DialogResult = false;
                return;
            }

            Title = "Редактирование заказа — Магазин электроники";
            HeaderTextBlock.Text = "Редактирование заказа №" + order.OrderId;
            _orderDate = order.OrderDate;
            ClientComboBox.SelectedValue = order.UserId;
            ClientComboBox.IsEnabled = false;
            PickupComboBox.SelectedValue = order.PickupPointId;
            StatusComboBox.SelectedValue = order.OrderStatusId;
            OrderDateTextBox.Text = order.OrderDate.ToString("dd.MM.yyyy");
            DeliveryDatePicker.DisplayDateStart = order.OrderDate;
            DeliveryDatePicker.SelectedDate = order.DeliveryDate;
            CodeTextBlock.Text = order.ReceiveCode.ToString();
            AddLinePanel.Visibility = Visibility.Collapsed;

            _lines.AddRange(OrderRepository.GetLines(orderId));
        }

        private void AddLineButton_Click(object sender, RoutedEventArgs e)
        {
            Product product = ProductComboBox.SelectedItem as Product;

            if (product == null)
            {
                ShowWarning("Выберите товар из списка.", "Товар не выбран");
                return;
            }

            int quantity;
            if (!int.TryParse(QuantityTextBox.Text.Trim(), out quantity) || quantity <= 0)
            {
                ShowWarning("Количество должно быть целым числом больше 0.", "Проверьте данные");
                return;
            }

            OrderLine existingLine = _lines.FirstOrDefault(line => line.Article == product.Article);
            int alreadyAdded = existingLine == null ? 0 : existingLine.Quantity;

            if (alreadyAdded + quantity > product.StockQuantity)
            {
                ShowWarning("Недостаточно товара на складе. Остаток: " + product.StockQuantity +
                    ", уже добавлено: " + alreadyAdded + ".", "Недостаточно товара");
                return;
            }

            if (existingLine == null)
            {
                _lines.Add(new OrderLine
                {
                    Article = product.Article,
                    ProductName = product.ProductName,
                    Quantity = quantity,
                    UnitPrice = product.FinalPrice
                });
            }
            else
            {
                existingLine.Quantity += quantity;
            }

            LinesDataGrid.Items.Refresh();
            QuantityTextBox.Text = "1";
            UpdateTotal();
        }

        private void RemoveLineButton_Click(object sender, RoutedEventArgs e)
        {
            OrderLine selectedLine = LinesDataGrid.SelectedItem as OrderLine;

            if (selectedLine == null)
            {
                ShowWarning("Выберите позицию в таблице.", "Позиция не выбрана");
                return;
            }

            _lines.Remove(selectedLine);
            LinesDataGrid.Items.Refresh();
            UpdateTotal();
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (ClientComboBox.SelectedValue == null ||
                PickupComboBox.SelectedValue == null ||
                StatusComboBox.SelectedValue == null ||
                !DeliveryDatePicker.SelectedDate.HasValue)
            {
                ShowWarning("Заполните клиента, пункт выдачи, дату доставки и статус.", "Проверьте данные");
                return;
            }

            DateTime deliveryDate = DeliveryDatePicker.SelectedDate.Value.Date;

            if (deliveryDate < _orderDate.Date)
            {
                ShowWarning("Дата доставки не может быть раньше даты заказа.", "Проверьте дату");
                return;
            }

            if (!_orderId.HasValue && _lines.Count == 0)
            {
                ShowWarning("Добавьте в заказ хотя бы один товар.", "Пустой заказ");
                return;
            }

            try
            {
                int pickupPointId = (int)PickupComboBox.SelectedValue;
                int statusId = (int)StatusComboBox.SelectedValue;

                if (_orderId.HasValue)
                {
                    OrderRepository.Update(_orderId.Value, pickupPointId, statusId, deliveryDate);
                }
                else
                {
                    int userId = (int)ClientComboBox.SelectedValue;
                    OrderRepository.Create(userId, pickupPointId, statusId,
                        _orderDate, deliveryDate, _lines.ToList());

                    MessageBox.Show("Заказ успешно оформлен.", "Информация",
                        MessageBoxButton.OK, MessageBoxImage.Information);
                }

                DialogResult = true;
            }
            catch (InvalidOperationException ex)
            {
                ShowWarning(ex.Message, "Недостаточно товара");
            }
            catch (Exception ex)
            {
                ShowError(ex);
            }
        }

        private void UpdateTotal()
        {
            decimal total = _lines.Sum(line => line.Sum);
            TotalTextBlock.Text = "Итого: " + total.ToString("N2") + " руб.";
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
        }

        private static void ShowWarning(string message, string title)
        {
            MessageBox.Show(message, title, MessageBoxButton.OK, MessageBoxImage.Warning);
        }

        private void ShowError(Exception ex)
        {
            string message = ex is Npgsql.NpgsqlException
                ? "Не удалось выполнить операцию с базой данных. Проверьте подключение к PostgreSQL."
                : "Непредвиденная ошибка: " + ex.Message;

            MessageBox.Show(message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }
}
