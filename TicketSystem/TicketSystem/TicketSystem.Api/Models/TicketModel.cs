using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TicketSystem.Api;
using TicketSystem.Domain;
using TicketSystem.Domain.Users;

namespace TicketSystem.Api.Models
{
    public class TicketModel
    {
        public long Id { get; set; }
        public string Subject { get; set; }
        public string Description { get; set; }
        public UserModel Employee { get; set; }
        public UserModel Attendant { get; set; }
        public DateTime Openness { get; set; }
        public StatusModel Status { get; set; }

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
                    Id = this.Status.Id,
                    State = this.Status.State
                },
                Employee = new User
                {
                    Id = Employee.Id,
                    Name = Employee.Name
                },
                Attendant = new User
                {
                    Id = Attendant.Id
                },
            };
        }
    }
    public static class TicketModelExtensions
    {
        public static TicketModel ToModel(this Ticket domain)
        {
            return new TicketModel
            {
                Id = domain.Id,
                Subject = domain.Subject,
                Attendant = new UserModel
                {
                    Id = domain.Attendant.Id,
                    Name = domain.Attendant.Name,
                    Type = domain.Attendant.Type.ToString(),
                    TypeId = (int)domain.Attendant.Type
                },
                Employee = new UserModel
                {
                    Id = domain.Employee.Id,
                    Name = domain.Employee.Name,
                    Type = domain.Employee.Type.ToString(),
                    TypeId = (int)domain.Employee.Type

                },
                Description = domain.Description,
                Openness = domain.Openness,
                Status = new StatusModel
                {
                    Id = domain.Status.Id,
                    State = domain.Status.State
                }
            };
        }
        public static IEnumerable<TicketModel> ToModel(this IEnumerable<Ticket> tickets)
        {
            return tickets.Select(ticket => ticket.ToModel()).ToList();
        }
    }
}