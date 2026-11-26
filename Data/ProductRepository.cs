using System;
using System.Collections.Generic;
using Npgsql;
using ShoeStore.Models;

namespace ShoeStore.Data
{
    public static class ProductRepository
    {
        private const string SelectAllSql = @"
            SELECT p.articule, p.name, u.name, p.price,
                   s.name, m.name, c.name, p.discount, p.count,
                   p.description, p.photo,
                   p.fk_category_id, p.fk_manufacturer_id,
                   p.fk_supplyer_id, p.fk_unit_id
            FROM products p
            JOIN units u ON u.id = p.fk_unit_id
            JOIN supplyers s ON s.id = p.fk_supplyer_id
            JOIN manufacturer m ON m.id = p.fk_manufacturer_id
            JOIN category c ON c.id = p.fk_category_id
            ORDER BY p.name, p.articule";

        public static List<Product> GetAll()
        {
            List<Product> products = new List<Product>();

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(SelectAllSql, connection))
                using (NpgsqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        products.Add(ReadProduct(reader));
                    }
                }
            }

            return products;
        }

        public static Product GetByArticle(string article)
        {
            const string sql = @"
                SELECT p.articule, p.name, u.name, p.price,
                       s.name, m.name, c.name, p.discount, p.count,
                       p.description, p.photo,
                       p.fk_category_id, p.fk_manufacturer_id,
                       p.fk_supplyer_id, p.fk_unit_id
                FROM products p
                JOIN units u ON u.id = p.fk_unit_id
                JOIN supplyers s ON s.id = p.fk_supplyer_id
                JOIN manufacturer m ON m.id = p.fk_manufacturer_id
                JOIN category c ON c.id = p.fk_category_id
                WHERE p.articule = @article";

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("article", article);

                    using (NpgsqlDataReader reader = command.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            return null;
                        }

                        return ReadProduct(reader);
                    }
                }
            }
        }

        public static void Insert(Product product)
        {
            const string sql = @"
                INSERT INTO products
                (articule, name, fk_unit_id, price, fk_supplyer_id,
                 fk_manufacturer_id, fk_category_id, discount, count, description, photo)
                VALUES
                (@article, @name, @unit, @price, @supplier,
                 @manufacturer, @category, @discount, @count, @description, @photo)";

            ExecuteProductCommand(sql, product, null);
        }

        public static void Update(string oldArticle, Product product)
        {
            const string sql = @"
                UPDATE products SET
                    articule = @article,
                    name = @name,
                    fk_unit_id = @unit,
                    price = @price,
                    fk_supplyer_id = @supplier,
                    fk_manufacturer_id = @manufacturer,
                    fk_category_id = @category,
                    discount = @discount,
                    count = @count,
                    description = @description,
                    photo = @photo
                WHERE articule = @oldArticle";

            ExecuteProductCommand(sql, product, oldArticle);
        }

        public static bool IsProductInOrder(string article)
        {
            const string sql = "SELECT EXISTS(SELECT 1 FROM orders_item WHERE fk_product_articule = @article)";

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("article", article);
                    return (bool)command.ExecuteScalar();
                }
            }
        }

        public static void Delete(string article)
        {
            const string sql = "DELETE FROM products WHERE articule = @article";

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("article", article);
                    command.ExecuteNonQuery();
                }
            }
        }

        private static void ExecuteProductCommand(string sql, Product product, string oldArticle)
        {
            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("article", product.Article);
                    command.Parameters.AddWithValue("name", product.ProductName);
                    command.Parameters.AddWithValue("unit", product.UnitId);
                    command.Parameters.AddWithValue("price", (int)product.Price);
                    command.Parameters.AddWithValue("supplier", product.SupplierId);
                    command.Parameters.AddWithValue("manufacturer", product.ManufacturerId);
                    command.Parameters.AddWithValue("category", product.CategoryId);
                    command.Parameters.AddWithValue("discount", product.Discount);
                    command.Parameters.AddWithValue("count", product.StockQuantity);
                    command.Parameters.AddWithValue("description", product.Description ?? string.Empty);
                    command.Parameters.AddWithValue("photo", (object)product.PhotoPath ?? System.DBNull.Value);

                    if (oldArticle != null)
                    {
                        command.Parameters.AddWithValue("oldArticle", oldArticle);
                    }

                    command.ExecuteNonQuery();
                }
            }
        }

        private static Product ReadProduct(NpgsqlDataReader reader)
        {
            return new Product
            {
                Article = reader.GetString(0),
                ProductName = reader.GetString(1),
                UnitName = reader.GetString(2),
                Price = Convert.ToDecimal(reader.GetValue(3)),
                SupplierName = reader.GetString(4),
                ManufacturerName = reader.GetString(5),
                CategoryName = reader.GetString(6),
                Discount = reader.GetInt32(7),
                StockQuantity = reader.GetInt32(8),
                Description = reader.IsDBNull(9) ? string.Empty : reader.GetString(9),
                PhotoPath = reader.IsDBNull(10) ? null : reader.GetString(10),
                CategoryId = reader.GetInt32(11),
                ManufacturerId = reader.GetInt32(12),
                SupplierId = reader.GetInt32(13),
                UnitId = reader.GetInt32(14)
            };
        }
    }
}
