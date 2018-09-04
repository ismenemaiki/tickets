CREATE TABLE [dbo].[MAIKI_tickets] (
    [id]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [subject]     VARCHAR (50)  NULL,
    [attendantId] BIGINT        NULL,
    [employeeId]  BIGINT        NULL,
    [description] VARCHAR (MAX) NULL,
    [statusId]    BIGINT        NULL,
    [openness]    DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    FOREIGN KEY ([employeeId]) REFERENCES [dbo].[User] ([id]),
    FOREIGN KEY ([statusId]) REFERENCES [dbo].[MAIKI_status] ([id])
);



