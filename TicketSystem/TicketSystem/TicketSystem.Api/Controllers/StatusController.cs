using Swashbuckle.Swagger.Annotations;
using System.Net;
using System.Web.Http;
using TicketSystem.Api.Models;
using TicketSystem.Repository;

namespace TicketSystem.Api.Controllers
{
    [RoutePrefix("api/status")]
    public class StatusController : BaseController
    {
        [HttpGet]
        [Route("list")]
        [SwaggerResponse(HttpStatusCode.OK)]
        [SwaggerResponse(HttpStatusCode.NoContent)]

        public IHttpActionResult List()
        {
            var repository = new StatusRepository();
            var statuses = repository.List();
            var models = statuses.ToModel();
            return Ok(models);
        }
    }
}