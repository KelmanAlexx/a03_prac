using System;

namespace ShoeStore.Models
{
    public class OrderView
    {
        public int OrderId { get; set; }
        public DateTime OrderDate { get; set; }
        public DateTime DeliveryDate { get; set; }
        public int PickupPointId { get; set; }
        public string PickupAddress { get; set; }
        public int UserId { get; set; }
        public string ClientName { get; set; }
        public int ReceiveCode { get; set; }
        public int OrderStatusId { get; set; }
        public string StatusName { get; set; }
        public string ItemsText { get; set; }
        public decimal TotalAmount { get; set; }
    }
}
