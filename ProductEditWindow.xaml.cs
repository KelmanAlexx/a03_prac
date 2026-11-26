using System;
using System.Globalization;
using System.IO;
using System.Windows;
using Microsoft.Win32;
using Npgsql;
using ShoeStore.Data;
using ShoeStore.Helpers;
using ShoeStore.Models;

namespace ShoeStore
{
    public partial class ProductEditWindow : Window
    {
        private readonly string _oldArticle;
        private string _oldPhotoName;
        private string _selectedImagePath;

        public ProductEditWindow(string article)
        {
            InitializeComponent();
            _oldArticle = article;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                CategoryComboBox.ItemsSource = LookupRepository.GetCategories();
                ManufacturerComboBox.ItemsSource = LookupRepository.GetManufacturers();
                SupplierComboBox.ItemsSource = LookupRepository.GetSuppliers();
                UnitComboBox.ItemsSource = LookupRepository.GetUnits();

                if (_oldArticle == null)
                {
                    Title = "Добавление товара — Магазин обуви";
                    IdInfoTextBlock.Text = "Артикул должен быть уникальным.";
                    DeleteButton.Visibility = Visibility.Collapsed;
                    PhotoImage.Source = ImageLoader.Load(null);
                    DiscountTextBox.Text = "0";
                    StockTextBox.Text = "0";
                }
                else
                {
                    Title = "Редактирование товара — Магазин обуви";
                    LoadProduct();
                }
            }
            catch (Exception ex)
            {
                ShowDatabaseError(ex);
                DialogResult = false;
            }
        }

        private void LoadProduct()
        {
            Product product = ProductRepository.GetByArticle(_oldArticle);

            if (product == null)
            {
                MessageBox.Show("Товар не найден. Возможно, он был удалён.", "Товар не найден",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                DialogResult = false;
                return;
            }

            ArticleTextBox.Text = product.Article;
            NameTextBox.Text = product.ProductName;
            DescriptionTextBox.Text = product.Description;
            PriceTextBox.Text = product.Price.ToString("0.##", CultureInfo.CurrentCulture);
            StockTextBox.Text = product.StockQuantity.ToString();
            DiscountTextBox.Text = product.Discount.ToString();
            CategoryComboBox.SelectedValue = product.CategoryId;
            ManufacturerComboBox.SelectedValue = product.ManufacturerId;
            SupplierComboBox.SelectedValue = product.SupplierId;
            UnitComboBox.SelectedValue = product.UnitId;
            _oldPhotoName = product.PhotoPath;
            PhotoImage.Source = ImageLoader.Load(_oldPhotoName);
            IdInfoTextBlock.Text = "Артикул товара используется как первичный ключ.";
        }

        private void ChoosePhotoButton_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Filter = "Изображения (*.png;*.jpg;*.jpeg)|*.png;*.jpg;*.jpeg";

            if (dialog.ShowDialog() == true)
            {
                try
                {
                    _selectedImagePath = dialog.FileName;
                    PhotoImage.Source = ImageLoader.LoadFromFile(_selectedImagePath);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Не удалось открыть изображение: " + ex.Message,
                        "Ошибка изображения", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            Product product;
            string errorMessage;

            if (!TryReadForm(out product, out errorMessage))
            {
                MessageBox.Show(errorMessage, "Проверьте данные",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            string newPhotoName = null;

            try
            {
                if (!string.IsNullOrWhiteSpace(_selectedImagePath))
                {
                    newPhotoName = ImageService.SaveResizedCopy(_selectedImagePath);
                    product.PhotoPath = newPhotoName;
                }
                else
                {
                    product.PhotoPath = _oldPhotoName;
                }

                if (_oldArticle == null)
                {
                    ProductRepository.Insert(product);
                }
                else
                {
                    ProductRepository.Update(_oldArticle, product);
                }

                if (newPhotoName != null)
                {
                    ImageService.DeleteImage(_oldPhotoName);
                }

                MessageBox.Show("Товар сохранён.", "Информация",
                    MessageBoxButton.OK, MessageBoxImage.Information);
                DialogResult = true;
            }
            catch (PostgresException ex) when (ex.SqlState == "23505")
            {
                ImageService.DeleteImage(newPhotoName);
                MessageBox.Show("Товар с таким артикулом уже существует. Введите другой артикул.",
                    "Повторяющийся артикул", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            catch (PostgresException ex) when (ex.SqlState == "23503")
            {
                ImageService.DeleteImage(newPhotoName);
                MessageBox.Show("Нельзя изменить артикул: товар используется в заказе. Проверьте связанные заказы.",
                    "Нарушение связи", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            catch (Exception ex)
            {
                ImageService.DeleteImage(newPhotoName);
                ShowDatabaseError(ex);
            }
        }

        private bool TryReadForm(out Product product, out string errorMessage)
        {
            product = new Product();
            errorMessage = string.Empty;

            string article = ArticleTextBox.Text.Trim();
            string name = NameTextBox.Text.Trim();

            if (article.Length == 0 || name.Length == 0)
            {
                errorMessage = "Заполните артикул и наименование товара.";
                return false;
            }

            if (CategoryComboBox.SelectedValue == null ||
                ManufacturerComboBox.SelectedValue == null ||
                SupplierComboBox.SelectedValue == null ||
                UnitComboBox.SelectedValue == null)
            {
                errorMessage = "Выберите категорию, производителя, поставщика и единицу измерения.";
                return false;
            }

            decimal price;
            if (!TryParsePrice(PriceTextBox.Text, out price) || price < 0 || price > int.MaxValue ||
                Math.Round(price, 0) != price)
            {
                errorMessage = "Цена должна быть целым неотрицательным числом, так как в базе она хранится как integer.";
                return false;
            }

            int stock;
            if (!int.TryParse(StockTextBox.Text.Trim(), out stock) || stock < 0)
            {
                errorMessage = "Количество на складе должно быть целым числом не меньше 0.";
                return false;
            }

            int discount;
            if (!int.TryParse(DiscountTextBox.Text.Trim(), out discount) || discount < 0 || discount > 100)
            {
                errorMessage = "Скидка должна быть целым числом от 0 до 100.";
                return false;
            }

            product.Article = article;
            product.ProductName = name;
            product.CategoryId = (int)CategoryComboBox.SelectedValue;
            product.ManufacturerId = (int)ManufacturerComboBox.SelectedValue;
            product.SupplierId = (int)SupplierComboBox.SelectedValue;
            product.UnitId = (int)UnitComboBox.SelectedValue;
            product.Description = DescriptionTextBox.Text.Trim();
            product.Price = price;
            product.StockQuantity = stock;
            product.Discount = discount;

            return true;
        }

        private static bool TryParsePrice(string text, out decimal price)
        {
            string normalized = text.Trim().Replace(" ", string.Empty).Replace(",", ".");
            return decimal.TryParse(normalized, NumberStyles.AllowDecimalPoint,
                CultureInfo.InvariantCulture, out price);
        }

        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            if (_oldArticle == null || Session.CurrentRole != UserRole.Administrator)
            {
                return;
            }

            try
            {
                if (ProductRepository.IsProductInOrder(_oldArticle))
                {
                    MessageBox.Show("Товар присутствует в заказе, поэтому его нельзя удалить.",
                        "Удаление невозможно", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                MessageBoxResult answer = MessageBox.Show(
                    "Удалить товар «" + NameTextBox.Text + "»? Это действие нельзя отменить.",
                    "Подтверждение удаления", MessageBoxButton.YesNo, MessageBoxImage.Warning);

                if (answer != MessageBoxResult.Yes)
                {
                    return;
                }

                ProductRepository.Delete(_oldArticle);
                ImageService.DeleteImage(_oldPhotoName);
                DialogResult = true;
            }
            catch (Exception ex)
            {
                ShowDatabaseError(ex);
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
        }

        private void ShowDatabaseError(Exception ex)
        {
            string message = ex is NpgsqlException
                ? "Не удалось выполнить операцию с базой данных. Проверьте подключение к PostgreSQL."
                : "Непредвиденная ошибка: " + ex.Message;

            MessageBox.Show(message, "Ошибка базы данных",
                MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }
}
