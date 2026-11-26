using System.Collections.Generic;
using Npgsql;
using ShoeStore.Models;

namespace ShoeStore.Data
{
    public static class LookupRepository
    {
        public static List<LookupItem> GetCategories()
        {
            return GetItems("SELECT id, name FROM category ORDER BY name");
        }

        public static List<LookupItem> GetManufacturers()
        {
            return GetItems("SELECT id, name FROM manufacturer ORDER BY name");
        }

        public static List<LookupItem> GetSuppliers()
        {
            return GetItems("SELECT id, name FROM supplyers ORDER BY name");
        }

        public static List<LookupItem> GetUnits()
        {
            return GetItems("SELECT id, name FROM units ORDER BY name");
        }

        public static List<LookupItem> GetStatuses()
        {
            return GetItems("SELECT id, name FROM status ORDER BY id");
        }

        public static List<LookupItem> GetPickupPoints()
        {
            return GetItems("SELECT id, adress FROM pickup_points ORDER BY id");
        }

        public static List<LookupItem> GetClients()
        {
            List<LookupItem> items = new List<LookupItem>();

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                const string sql = @"
                    SELECT u.id, u.full_name
                    FROM users u
                    JOIN roles r ON r.id = u.role_id
                    WHERE r.name ILIKE '%клиент%'
                    ORDER BY u.full_name";

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                using (NpgsqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        items.Add(new LookupItem
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.GetString(1)
                        });
                    }
                }
            }

            return items;
        }

        private static List<LookupItem> GetItems(string sql)
        {
            List<LookupItem> items = new List<LookupItem>();

            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(sql, connection))
                using (NpgsqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        items.Add(new LookupItem
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.GetString(1)
                        });
                    }
                }
            }

            return items;
        }
    }
}
