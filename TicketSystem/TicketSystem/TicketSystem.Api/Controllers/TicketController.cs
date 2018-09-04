using Swashbuckle.Swagger.Annotations;
using System;
using System.Net;
using System.Web.Http;
using TicketSystem.Api.Models;
using TicketSystem.Domain;
using TicketSystem.Repository;

namespace TicketSystem.Api.Controllers
{
    [RoutePrefix("api/tickets")]
    public class TicketController : BaseController
    {
        [HttpGet]
        [Route("listall")]
        [SwaggerResponse(HttpStatusCode.OK)]
        [SwaggerResponse(HttpStatusCode.NoContent)]

        public IHttpActionResult List()
        {
            var repository = new TicketRepository();
            var tickets = repository.List();
            var models = tickets.ToModel();
            return Ok(models);
        }
        [HttpGet]
        [Route("getStatus")]
        [SwaggerResponse(HttpStatusCode.OK, "Success")]
        public IHttpActionResult GetTickets(long statusId)
        {
            try
            {
                var repository = new TicketRepository();
                var tickets = repository.List(statusId);
                return this.Ok(tickets.ToModel());
            }
            catch (Exception exception)
            {
                return BadRequest(exception.Message);
            }
        }
        
        [HttpGet]
        [Route("getTicket")]
        [SwaggerResponse(HttpStatusCode.OK)]
        public IHttpActionResult Get(long id)
        {
            var repository = new TicketRepository();
            var ticket = repository.GetTicketById(id);
            return Ok(new
            {
                ticket = ticket.ToModel(),
            });
        }
        [HttpPost]
        [Route("delete")]
        [SwaggerResponse(HttpStatusCode.OK)]
        public IHttpActionResult Del(long id)
        {
            var repository = new TicketRepository();
            var ticket = repository.Delete(id);
            return Ok();
        }
        [HttpPost]
        [Route("newticket")]
        [SwaggerResponse(HttpStatusCode.OK)]

        public IHttpActionResult Add(TicketModel model)
        {
            try
            {
                var ticket = model.ToDomain();
                ticket.Repository = new TicketRepository();
                ticket.Save();
                return Ok();
            }
            catch (ArgumentNullException)
            {
                return InternalServerError();
            }
            catch (Exception exception)
            {
                return BadRequest(exception.Message);
            }
        }
        [HttpPost]
        [Route("update")]
        [SwaggerResponse(HttpStatusCode.NoContent)]
        public IHttpActionResult Update(TicketModel model)
        {
            try
            {
                var ticket = model.ToDomain();
                ticket.Repository = new TicketRepository();
                ticket.Update();
                return Ok();
            }
            catch (ArgumentNullException)
            {
                return InternalServerError();
            }
            catch (Exception exception)
            {
                return BadRequest(exception.Message);
            }
        }

    }
}