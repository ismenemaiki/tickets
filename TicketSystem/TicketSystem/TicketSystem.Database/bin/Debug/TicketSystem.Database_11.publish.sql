﻿/*
Deployment script for CRUJ

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "CRUJ"
:setvar DefaultFilePrefix "CRUJ"
:setvar DefaultDataPath "E:\SQL\Data\"
:setvar DefaultLogPath "E:\SQL\Logs\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[MAIKI_tickets].[attendantId] is being dropped, data loss could occur.

The column [dbo].[MAIKI_tickets].[employeeId] is being dropped, data loss could occur.

The column [dbo].[MAIKI_tickets].[statusId] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[MAIKI_tickets])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping unnamed constraint on [dbo].[MAIKI_tickets]...';


GO
ALTER TABLE [dbo].[MAIKI_tickets] DROP CONSTRAINT [FK__MAIKI_tic__statu__5CACADF9];


GO
PRINT N'Dropping unnamed constraint on [dbo].[MAIKI_tickets]...';


GO
ALTER TABLE [dbo].[MAIKI_tickets] DROP CONSTRAINT [FK__MAIKI_tic__atten__5DA0D232];


GO
PRINT N'Dropping unnamed constraint on [dbo].[MAIKI_tickets]...';


GO
ALTER TABLE [dbo].[MAIKI_tickets] DROP CONSTRAINT [FK__MAIKI_tic__emplo__5E94F66B];


GO
PRINT N'Starting rebuilding table [dbo].[MAIKI_tickets]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_MAIKI_tickets] (
    [cod]         BIGINT        IDENTITY (1, 1) NOT NULL,
    [subject]     VARCHAR (50)  NULL,
    [attendant]   VARCHAR (25)  NULL,
    [description] VARCHAR (MAX) NULL,
    [status]      INT           NULL,
    [openness]    DATETIME      NULL,
    [id]          BIGINT        NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK__MAIKI_ti__D8360F7B4907994B1] PRIMARY KEY CLUSTERED ([cod] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[MAIKI_tickets])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_MAIKI_tickets] ([id], [subject], [description], [openness])
        SELECT [id],
               [subject],
               [description],
               [openness]
        FROM   [dbo].[MAIKI_tickets];
    END

DROP TABLE [dbo].[MAIKI_tickets];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_MAIKI_tickets]', N'MAIKI_tickets';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK__MAIKI_ti__D8360F7B4907994B1]', N'PK__MAIKI_ti__D8360F7B4907994B', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[FK_MAIKI_tickets_MAIKI_tickets]...';


GO
ALTER TABLE [dbo].[MAIKI_tickets] WITH NOCHECK
    ADD CONSTRAINT [FK_MAIKI_tickets_MAIKI_tickets] FOREIGN KEY ([cod]) REFERENCES [dbo].[MAIKI_tickets] ([cod]);


GO
PRINT N'Altering [dbo].[MAIKI_InsertTicket]...';


GO

ALTER PROCEDURE [dbo].[MAIKI_InsertTicket]
       @subject VARCHAR(50) = NULL, 
       @attendantId VARCHAR(50), 
	   @description varchar(MAX), 
	   @openness datetime,
	   @statusId int             
AS 
BEGIN 
     SET NOCOUNT ON 
INSERT INTO dbo.MAIKI_tickets
        ([subject]
        ,attendant
        ,[description]
		,[openness]
        ,[status])             
          
     VALUES 
        (@subject
        ,@attendantId
        ,@description
		,@openness
        ,@statusId) 
END
GO
PRINT N'Altering [dbo].[MAIKI_listTickets]...';


GO
ALTER PROCEDURE [dbo].[MAIKI_listTickets]
AS
	SELECT
		Ti.id as id,
		Ti.[subject] as [subject],
		Ti.attendant as attendantId,
		Ti.[description] as [description],
		St.[State] as [state]
		FROM MAIKI_tickets as Ti
		INNER JOIN MAIKI_status as St
		ON (Ti.id = St.id)
GO
PRINT N'Refreshing [dbo].[MAIKI_GetTicketsLikeSubject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[MAIKI_GetTicketsLikeSubject]';


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[MAIKI_tickets] WITH CHECK CHECK CONSTRAINT [FK_MAIKI_tickets_MAIKI_tickets];


GO
PRINT N'Update complete.';


GO
