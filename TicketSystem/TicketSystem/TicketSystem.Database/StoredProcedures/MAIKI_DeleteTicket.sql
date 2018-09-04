CREATE PROCEDURE [dbo].[MAIKI_DeleteTicket]
	@id int
AS
	DELETE  FROM MAIKI_tickets WHERE id = @id
