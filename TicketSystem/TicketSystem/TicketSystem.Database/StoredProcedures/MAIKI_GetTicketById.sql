CREATE PROCEDURE [dbo].[MAIKI_GetTicketById]
	@id INT
AS
	SELECT 
		Ti.id as 'Id',
		Ti.[subject] as 'Subject',
		Ti.attendantId as 'AttendantId',
		Ti.employeeId as 'EmployeeId',
		A.[name] as attendantName,
		E.[name] as employeeName,
		Ti.[description] as 'Description',
		Ti.openness as 'Openness',
		St.id as statusId,
		St.[state] as [state]
		FROM MAIKI_tickets as Ti
		INNER JOIN MAIKI_status as St ON (Ti.statusId = St.id)
		INNER JOIN [User] as E ON E.id = Ti.employeeId 
		INNER JOIN [User] as A ON A.id = Ti.attendantId
		WHERE Ti.id = @id

		