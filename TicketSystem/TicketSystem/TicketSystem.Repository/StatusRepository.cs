using Calmo.Data;
using Calmo.Data.SQLServer;
using System.Collections.Generic;
using TicketSystem.Domain;
using TicketSystem.Repository.DTO;

namespace TicketSystem.Repository
{
    public class StatusRepository : Calmo.Data.Repository
    {
        public IEnumerable<Status> List()
        {
            var result = this.Data.Db()
                            .AsProcedure()
                            .List<StatusDTO>("MAIKI_ListStatus");
            return result.ToDomain();
        }
    }
}
