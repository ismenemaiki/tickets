using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketSystem.Domain;
using TicketSystem.Domain.Users;

namespace TicketSystem.Repository.DTO
{
    public class TicketDTO
    {
        public long Id { get; set; }
        public string Subject { get; set; }
        public string Description { get; set; }
        public DateTime Openness { get; set; }

        public long AttendantId { get; set; }
        public string AttendantName { get; set; }
        public long AttendantType { get; set; }

        public long EmployeeId { get; set; }
        public string EmployeeName { get; set; }
        public long EmployeeType { get; set; }

        public long StatusId { get; set; }
        public string State { get; set; }


        public Ticket ToDomain()
        {
            return new Ticket
            {
                Id = this.Id,
                Subject = this.Subject,
                Description = this.Description,
                Openness = this.Openness,
                Status = new Status
                {
                    Id = this.StatusId, 
                    State = this.State

                },
                Employee = new User
                {
                    Id = this.EmployeeId,
                    Name = this.EmployeeName,
                    Type = (UserType)EmployeeType
                },
                Attendant = new User
                {
                    Id = this.AttendantId,
                    Name = this.AttendantName,
                    Type = (UserType)AttendantType
                }
            };
        }
    }

    public static class TicketDTOExtensions
    {
        public static IEnumerable<Ticket> ToDomain(this IEnumerable<TicketDTO> dtos)
        {
            return dtos.Select(d => d.ToDomain());
        }
    }
}
