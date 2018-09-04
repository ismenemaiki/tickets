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
PRINT N'Altering [dbo].[MAIKI_GetTicketById]...';


GO
ALTER PROCEDURE [dbo].[MAIKI_GetTicketById]
	@id INT
AS
	SELECT 
		Ti.id as 'Id',
		Ti.[subject] as 'Subject',
		Ti.attendantId as 'AttendantId',
		Ti.employeeId as 'EmployeeId',
		Ti.[description] as 'Description',
		Ti.openness as 'Openness',
		St.Id as statusId,
		St.[state] as [state]
		FROM MAIKI_tickets as Ti
		INNER JOIN MAIKI_status as St ON (Ti.statusId = St.id)
		WHERE Ti.id = @id
GO
PRINT N'Update complete.';


GO
