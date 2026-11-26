using Npgsql;
using ShoeStore.Models;

namespace ShoeStore.Data
{
    public static class UserRepository
    {
        private const string AuthenticateSql = @"
            SELECT u.id, u.full_name, r.name
            FROM users u
            JOIN roles r ON r.id = u.role_id
            WHERE u.login = @login AND u.password = @password";

        public static AppUser Authenticate(string login, string password)
        {
            using (NpgsqlConnection connection = Database.CreateConnection())
            {
                connection.Open();

                using (NpgsqlCommand command = new NpgsqlCommand(AuthenticateSql, connection))
                {
                    command.Parameters.AddWithValue("login", login);
                    command.Parameters.AddWithValue("password", password);

                    using (NpgsqlDataReader reader = command.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            return null;
                        }

                        return new AppUser
                        {
                            UserId = reader.GetInt32(0),
                            FullName = reader.GetString(1),
                            RoleName = reader.GetString(2)
                        };
                    }
                }
            }
        }
    }
}
