namespace ShoeStore.Models
{
    public class OrderLine
    {
        public string Article { get; set; }
        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }

        public decimal Sum
        {
            get { return UnitPrice * Quantity; }
        }
    }
}
