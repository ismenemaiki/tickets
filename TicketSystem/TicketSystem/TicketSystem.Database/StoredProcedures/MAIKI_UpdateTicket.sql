CREATE PROCEDURE [dbo].[MAIKI_UpdateTicket]
	@id BIGINT,
	@Subject VARCHAR (50),
	@Description VARCHAR(500),
	@employeeId BIGINT,
	@StatusId BIGINT,
	@openness DATETIME
AS
	
UPDATE [dbo].[MAIKI_tickets] 
	SET
		[subject] = @Subject, 
		[description] = @Description,
		employeeId = @employeeId,
		[statusId] = @StatusId,
		openness = @openness
		WHERE id = @id;