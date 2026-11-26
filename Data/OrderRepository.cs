using System;
using System.Collections.Generic;
using System.Linq;
using Npgsql;
using ShoeStore.Models;

namespace ShoeStore.Data
{
    public static class OrderRepository
    {
        public static List<OrderView> GetAll(int? userId)
        {
            List<OrderView> orders = new List<OrderView>();

            const string sql = @"
                SELECT o.id, o.order_date, o.delivery_date, o.fk_pickup_point_id,
                       pp.adress, o.fk_user_id, u.full_name, o.code,
                       o.fk_status_id, st.name,
                       COALESCE((
                           SELECT string_agg(p.name || ' x' || oi.count, ', ')
                           FROM orders_item oi
                           JOIN products p ON p.articule = oi.fk_product_articule
                           WHERE oi.fk_order_id = o.id
                       ), '') AS items_text,
                       COALESCE((
                           SELECT SUM(p.price * (100 - p.discount) / 100.0 * oi.count)
                           FROM orders_item oi
                           JOIN products p ON p.articule = oi.fk_product_articule
                           WHERE oi.fk_order_id = o.id
                       ), 0) AS total_amount
                FROM orders o
                JOIN pickup_points pp ON pp.id = o.fk_pickup_point_id
                JOIN users u ON u.id = o.fk_user_id
                JOIN status st ON st.id = o.fk_status_id
                WHERE (@userId IS NULL OR o.fk_user_id = @userId)
                ORDER BY o.id DESC";

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.Add("userId", NpgsqlTypes.NpgsqlDbType.Integer).Value =
                        (object)userId ?? DBNull.Value;

                    using (NpgsqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orders.Add(new OrderView
                            {
                                OrderId = reader.GetInt32(0),
                                OrderDate = reader.GetDateTime(1),
                                DeliveryDate = reader.GetDateTime(2),
                                PickupPointId = reader.GetInt32(3),
                                PickupAddress = reader.GetString(4),
                                UserId = reader.GetInt32(5),
                                ClientName = reader.GetString(6),
                                ReceiveCode = reader.GetInt32(7),
                                OrderStatusId = reader.GetInt32(8),
                                StatusName = reader.GetString(9),
                                ItemsText = reader.GetString(10),
                                TotalAmount = reader.GetDecimal(11)
                            });
                        }
                    }
                }
            }

            return orders;
        }

        public static List<OrderLine> GetLines(int orderId)
        {
            List<OrderLine> lines = new List<OrderLine>();

            const string sql = @"
                SELECT p.articule, p.name, oi.count,
                       p.price * (100 - p.discount) / 100.0
                FROM orders_item oi
                JOIN products p ON p.articule = oi.fk_product_articule
                WHERE oi.fk_order_id = @orderId";

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("orderId", orderId);

                    using (NpgsqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            lines.Add(new OrderLine
                            {
                                Article = reader.GetString(0),
                                ProductName = reader.GetString(1),
                                Quantity = reader.GetInt32(2),
                                UnitPrice = reader.GetDecimal(3)
                            });
                        }
                    }
                }
            }

            return lines;
        }

        public static void Create(int userId, int pickupPointId, int statusId,
            DateTime orderDate, DateTime deliveryDate, List<OrderLine> lines)
        {
            if (lines == null || lines.Count == 0)
            {
                throw new InvalidOperationException("Добавьте в заказ хотя бы один товар.");
            }

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlTransaction transaction = connection.BeginTransaction())
                {
                    try
                    {
                        const string insertOrderSql = @"
                            INSERT INTO orders
                            (order_date, delivery_date, fk_pickup_point_id, fk_user_id, code, fk_status_id)
                            VALUES
                            (@orderDate, @deliveryDate, @pickupPointId, @userId,
                             nextval('order_code_seq'), @statusId)
                            RETURNING id";

                        int orderId;

                        using (NpgsqlCommand command = new NpgsqlCommand(insertOrderSql, connection, transaction))
                        {
                            command.Parameters.AddWithValue("orderDate", orderDate.Date);
                            command.Parameters.AddWithValue("deliveryDate", deliveryDate.Date);
                            command.Parameters.AddWithValue("pickupPointId", pickupPointId);
                            command.Parameters.AddWithValue("userId", userId);
                            command.Parameters.AddWithValue("statusId", statusId);
                            orderId = Convert.ToInt32(command.ExecuteScalar());
                        }

                        foreach (OrderLine line in lines)
                        {
                            const string updateStockSql = @"
                                UPDATE products
                                SET count = count - @quantity
                                WHERE articule = @article AND count >= @quantity";

                            using (NpgsqlCommand command = new NpgsqlCommand(updateStockSql, connection, transaction))
                            {
                                command.Parameters.AddWithValue("quantity", line.Quantity);
                                command.Parameters.AddWithValue("article", line.Article);

                                if (command.ExecuteNonQuery() == 0)
                                {
                                    throw new InvalidOperationException(
                                        "Недостаточно товара на складе: " + line.ProductName +
                                        ". Обновите список товаров и проверьте остаток.");
                                }
                            }

                            const string insertLineSql = @"
                                INSERT INTO orders_item (fk_order_id, fk_product_articule, count)
                                VALUES (@orderId, @article, @quantity)";

                            using (NpgsqlCommand command = new NpgsqlCommand(insertLineSql, connection, transaction))
                            {
                                command.Parameters.AddWithValue("orderId", orderId);
                                command.Parameters.AddWithValue("article", line.Article);
                                command.Parameters.AddWithValue("quantity", line.Quantity);
                                command.ExecuteNonQuery();
                            }
                        }

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

        public static void Update(int orderId, int pickupPointId, int statusId, DateTime deliveryDate)
        {
            const string sql = @"
                UPDATE orders
                SET fk_pickup_point_id = @pickupPointId,
                    fk_status_id = @statusId,
                    delivery_date = @deliveryDate
                WHERE id = @orderId";

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("pickupPointId", pickupPointId);
                    command.Parameters.AddWithValue("statusId", statusId);
                    command.Parameters.AddWithValue("deliveryDate", deliveryDate.Date);
                    command.Parameters.AddWithValue("orderId", orderId);
                    command.ExecuteNonQuery();
                }
            }
        }

        public static void Delete(int orderId)
        {
            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(
                    "DELETE FROM orders WHERE id = @orderId", connection))
                {
                    command.Parameters.AddWithValue("orderId", orderId);
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
