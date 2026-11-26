namespace ShoeStore.Models
{
    public static class Session
    {
        public static AppUser CurrentUser { get; set; }

        public static UserRole CurrentRole
        {
            get
            {
                if (CurrentUser == null)
                {
                    return UserRole.Guest;
                }

                return CurrentUser.Role;
            }
        }
    }
}
