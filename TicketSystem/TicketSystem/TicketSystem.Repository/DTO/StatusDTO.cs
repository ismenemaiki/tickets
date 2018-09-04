using System.Collections.Generic;
using System.Linq;
using TicketSystem.Domain;

namespace TicketSystem.Repository.DTO
{
    public class StatusDTO
    {
        public long id { get; set; }
        public string state { get; set; }

        public Status ToDomain()
        {
            return new Status
            {
                Id = this.id,
                State = this.state
            };
        }
    }

    public static class StatusDTOExtensions
    {
        public static IEnumerable<Status> ToDomain(this IEnumerable<StatusDTO> dtos)
        {
            return dtos.Select(d => d.ToDomain());
        }
    }
}
