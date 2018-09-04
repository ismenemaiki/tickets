
CREATE PROCEDURE [dbo].MAIKI_InsertTicket
	@subject VARCHAR(50),
	@employeeId BIGINT,
	@attendantId BIGINT,
	@description VARCHAR(500),
	@openness DATETIME,
	@statusId BIGINT
AS
	
	INSERT INTO [dbo].MAIKI_tickets 
	([subject],
	employeeId,
	attendantId,
	[description], 
	openness, 
	statusId)

	VALUES 
	(@subject,
	@attendantId,
	@employeeId, 
	@description,
	@openness,
	@statusId 
	)

SELECT @@IDENTITY

