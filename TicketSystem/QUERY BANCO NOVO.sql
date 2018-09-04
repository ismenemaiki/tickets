CREATE TABLE [dbo].[User]
(
	[id] BIGINT NOT NULL PRIMARY KEY IDENTITY,
	[name] VARCHAR(25) NOT NULL, 
	[username] VARCHAR(30) NOT NULL,
	[password] VARCHAR(40) NOT NULL,
    [type] INT NULL
)  
----------------------------------------------------------------------------------------
CREATE TABLE [dbo].[MAIKI_status] (
    [id]    BIGINT        NOT NULL,
    [state] VARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
)
----------------------------------------------------------------------------------------
  INSERT INTO MAIKI_status VALUES 
  (1, 'NEW'),
  (2, 'IN PROGRESS'),
  (3, 'FINISHED')
----------------------------------------------------------------------------------------
CREATE TABLE [dbo].[MAIKI_tickets] (
    [id]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [subject]     VARCHAR (50)  NULL,
    [attendantId] BIGINT        NULL,
    [employeeId]  BIGINT        NULL,
    [description] VARCHAR (MAX) NULL,
    [statusId]    BIGINT        NULL,
    [openness]    DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    FOREIGN KEY ([employeeId]) REFERENCES [User] ([id]),
    FOREIGN KEY ([statusId]) REFERENCES MAIKI_status ([id])
	)
----------------------------------------------------------------------------------------
INSERT INTO MAIKI_tickets
VALUES( 'Monitor quebrado',2,1,'Quebrou sozinho', 1, '28/08/2018')
----------------------------------------------------------------------------------------
INSERT INTO [User]
VALUES ('Felipe Rugai',	'gordo', 'gordoMonstro', 1) ,
	   ('Rafael Sousa',	'rafao', 'rafaoTroxa', 2)		 
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GetUser]
	@username VARCHAR(30),
	@password VARCHAR(40)
AS
	SELECT [id] as [Id],
		   [name] as [Name],
		   [type] as [Type]

    FROM [User]

	WHERE [password] = @password 
	  AND [username] = @username		   							
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[MAIKI_DeleteTicket]
	@id int
AS
	DELETE  FROM MAIKI_tickets WHERE id = @id  
----------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------
CREATE PROCEDURE MAIKI_ListByStatus
	@statusId bigint
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

	WHERE statusId = @statusId
RETURN
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[MAIKI_ListStatus]

AS
	SELECT * FROM  MAIKI_status
----------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------
sp_help MAIKI_tickets
