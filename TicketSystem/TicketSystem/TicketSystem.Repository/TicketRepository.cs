using Calmo.Data;
using Calmo.Data.SQLServer;
using System.Collections.Generic;
using TicketSystem.Domain;
using TicketSystem.Domain.Repository;
using TicketSystem.Repository.DTO;

namespace TicketSystem.Repository
{
    public class TicketRepository : Calmo.Data.Repository, ITicketRepository
    {
        //------------------MÉTODOS DE LISTAR----------------------------------
        public IEnumerable<Ticket> List()
        {
            var result = this.Data.Db()
                .AsProcedure()
                .List<TicketDTO>("MAIKI_ListTickets");
            return result.ToDomain();
        }
        public IEnumerable<Ticket> List(long statusId)
        {
            { 
            var result = this.Data.Db()
                .AsProcedure()
                .WithParameters(new { statusId })
                .List<TicketDTO>("MAIKI_ListByStatus");

            return result.ToDomain();
            }
        }           
        public IEnumerable<Ticket> ListStatus()
        {
            var result = this.Data.Db()
                .AsProcedure()
                .List<TicketDTO>("MAIKI_ListTickets");
            return result.ToDomain();
        }
        //-------------------------------------------------------------------
        //------------------MÉTODOS RESTFULL---------------------------------
        public void Add (Ticket ticket)
        {
            var parameters = new
            {
                subject = ticket.Subject,
                attendantId = ticket.Attendant.Id,
                employeeId = ticket.Employee.Id,
                description = ticket.Description, 
                openness = ticket.Openness,
                statusId = ticket.Status.Id 
            };
            this.Data.Db() 
                .WithParameters(parameters)
                .Execute("MAIKI_InsertTicket");
        }
        public Ticket GetTicketById(long id)
        {
            var result = this.Data.Db()
                .AsProcedure()
                .WithParameters(new { id })
                .Get<TicketDTO>("MAIKI_GetTicketById");
               return result.ToDomain();
        }
        public long Delete(long id)
        {
            var result = this.Data.Db()
                        .AsProcedure()
                        .WithParameters(new { id })
                        .Get<TicketDTO>("MAIKI_DeleteTicket");
            return id;
        }
        public void Update(Ticket ticket)
        {
            var parameters = new
            {
                id = ticket.Id,
                subject = ticket.Subject,
                description = ticket.Description,
                employeeId = ticket.Employee.Id,
                statusId = ticket.Status.Id,
                openness = ticket.Openness

            };
            var id = this.Data.Db()
                .WithParameters(parameters)
                .Execute<long>("MAIKI_UpdateTicket");
        } 
    }
}
