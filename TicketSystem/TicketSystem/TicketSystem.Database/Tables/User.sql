﻿CREATE TABLE [dbo].[User]
(
	[id] BIGINT NOT NULL PRIMARY KEY IDENTITY,
	[name] VARCHAR(25) NOT NULL, 
	[username] VARCHAR(30) NOT NULL,
	[password] VARCHAR(40) NOT NULL,
    [type] INT NULL
)
