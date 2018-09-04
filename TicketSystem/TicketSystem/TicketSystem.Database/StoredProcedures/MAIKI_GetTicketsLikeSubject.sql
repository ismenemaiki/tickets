CREATE PROCEDURE [dbo].[MAIKI_GetTicketsLikeSubject]
	@subject VARCHAR(50)
AS
	SELECT * FROM [dbo].MAIKI_tickets WHERE [subject] LIKE '%' + @subject + '%' ORDER BY [subject];
RETURN 0
