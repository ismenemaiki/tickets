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
PRINT N'Dropping unnamed constraint on [dbo].[MAIKI_tickets]...';


GO
ALTER TABLE [dbo].[MAIKI_tickets] DROP CONSTRAINT [FK__MAIKI_tic__statu__2097C3F2];


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
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_MAIKI_tickets] ON;
        INSERT INTO [dbo].[tmp_ms_xx_MAIKI_tickets] ([cod], [subject], [attendant], [description], [status], [openness])
        SELECT   [cod],
                 [subject],
                 [attendant],
                 [description],
                 [status],
                 [openness]
        FROM     [dbo].[MAIKI_tickets]
        ORDER BY [cod] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_MAIKI_tickets] OFF;
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
PRINT N'Creating [dbo].[MAIKI_InsertTicket]...';


GO
CREATE PROCEDURE [dbo].[MAIKI_InsertTicket]
@Cod bigint, 
@Subject varchar(50), 
@Attendant varchar(50),
@Description varchar(MAX), 
@Status int

AS
INSERT INTO [dbo].[MAIKI_tickets]
           ([Cod]
           ,[Subject]
           ,[Attendant]
           ,[Description]
           ,[Status])
     VALUES
           (@Cod
           ,@Subject
           ,@Attendant
           ,@Description
           ,@Status)
GO
PRINT N'Refreshing [dbo].[MAIKI_GetTicketsLikeSubject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[MAIKI_GetTicketsLikeSubject]';


GO
PRINT N'Refreshing [dbo].[MAIKI_listTickets]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[MAIKI_listTickets]';


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[MAIKI_tickets] WITH CHECK CHECK CONSTRAINT [FK_MAIKI_tickets_MAIKI_tickets];


GO
PRINT N'Update complete.';


GO
