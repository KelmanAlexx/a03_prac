using System;

namespace ShoeStore.Models
{
    public class AppUser
    {
        public int UserId { get; set; }
        public string FullName { get; set; }
        public string RoleName { get; set; }

        public UserRole Role
        {
            get
            {
                if (RoleName == null)
                {
                    return UserRole.Client;
                }

                if (RoleName.IndexOf("Администратор", StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    return UserRole.Administrator;
                }

                if (RoleName.IndexOf("Менеджер", StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    return UserRole.Manager;
                }

                return UserRole.Client;
            }
        }
    }
}
