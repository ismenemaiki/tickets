CREATE PROCEDURE [dbo].[MAIKI_ListTickets]
	
AS

SELECT
		Ti.id as id,
		Ti.[subject] as [subject],
		A.[name] as attendantName,
		e.[name] as employeeName,
		Ti.[description] as [description],
		St.id as [statusId],
		St.[state] as [state],
		Ti.openness as openness
		FROM MAIKI_tickets as Ti
		INNER JOIN MAIKI_status as St ON (Ti.statusId = St.id)
		INNER JOIN [User] as E ON E.id = Ti.employeeId 
		INNER JOIN [User] as A ON A.id = Ti.attendantId