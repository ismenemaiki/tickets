using System.Collections.Generic;

namespace TicketSystem.Domain.Repository
{
    public interface ITicketRepository
    {
        IEnumerable<Ticket> List();
        void Add(Ticket ticket);
        void Update(Ticket ticket);
        long Delete(long id);
    }
}
