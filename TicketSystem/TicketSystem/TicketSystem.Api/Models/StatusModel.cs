using System.Collections.Generic;
using System.Linq;
using TicketSystem.Domain;

namespace TicketSystem.Api.Models
{
    public class StatusModel
    {
        public long Id { get; set; }
        public string State { get; set; }
    }

    public static class StatusModelExtensions
    {
        public static StatusModel ToModel(this Status domain)
        {
            return new StatusModel
            {
                Id = domain.Id,
                State = domain.State
            };
        }
        public static IEnumerable<StatusModel> ToModel(this IEnumerable<Status> statuses)
        {
            return statuses.Select(status => status.ToModel()).ToList(); 
        }
    }
}