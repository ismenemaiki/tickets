using System;
using TicketSystem.Domain.Repository;
using TicketSystem.Domain.Users;

namespace TicketSystem.Domain
{
    public class Ticket
    {
        public long Id { get; set; }
        public string Subject { get; set; }
        public string Description { get; set; }
        public User Attendant { get; set; }
        public User Employee { get; set; }
        public DateTime Openness { get; set; }
        public Status Status { get; set; }
        public ITicketRepository Repository { get; set; }

        public void Save()
        {
            if (Repository == null)
                throw new ArgumentNullException("Repositorio no dominio de ticket nao referenciado.");
            Repository.Add(this);
        }
        public void Update()
        {
            if (Repository == null)
                throw new ArgumentNullException("Repository in the unreferenced ticket domain.");
            Repository.Update(this);
        }
        public void Delete()
        {
            if (Repository == null)
                throw new ArgumentNullException("Repository in the unreferenced ticket domain.");
            Repository.Delete(this.Id);
        }
    }
}
