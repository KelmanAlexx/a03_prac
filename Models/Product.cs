using System;
using System.Windows.Media;
using ShoeStore.Helpers;

namespace ShoeStore.Models
{
    public class Product
    {
        private ImageSource _photo;

        public string Article { get; set; }
        public string ProductName { get; set; }
        public string UnitName { get; set; }
        public decimal Price { get; set; }
        public string SupplierName { get; set; }
        public string ManufacturerName { get; set; }
        public string CategoryName { get; set; }
        public int Discount { get; set; }
        public int StockQuantity { get; set; }
        public string Description { get; set; }
        public string PhotoPath { get; set; }

        public int CategoryId { get; set; }
        public int ManufacturerId { get; set; }
        public int SupplierId { get; set; }
        public int UnitId { get; set; }

        public bool HasDiscount
        {
            get { return Discount > 0; }
        }

        public bool IsBigDiscount
        {
            get { return Discount > 15; }
        }

        public bool IsOutOfStock
        {
            get { return StockQuantity <= 0; }
        }

        public bool IsLowStock
        {
            get { return StockQuantity > 0 && StockQuantity <= 3; }
        }

        public decimal FinalPrice
        {
            get { return Math.Round(Price * (100 - Discount) / 100m, 2); }
        }

        public ImageSource Photo
        {
            get
            {
                if (_photo == null)
                {
                    _photo = ImageLoader.Load(PhotoPath);
                }

                return _photo;
            }
        }
    }
}
