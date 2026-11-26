using System.Configuration;
using Npgsql;

namespace ShoeStore.Data
{
    public static class Database
    {
        public static NpgsqlConnection CreateConnection()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ShoeStore"].ConnectionString;
            return new NpgsqlConnection(connectionString);
        }
    }
}
