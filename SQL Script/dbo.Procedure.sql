CREATE PROCEDURE [dbo].[AccessRighst_Insert]
	@Role VARCHAR (50),
	@Dtable 
AS BEGIN
	Delete AccessRights where RoleID = (Select rid from role Where Role = @Role)
	Insert into AccessRights 
	(RoleID, ScreenID)	
	VALUES
	((Select rid from role Where Role = @Role),1)
END	
	
	CREATE TYPE AccessType AS TABLE(
      [AccessId] [int] NULL,
      [Name] [varchar](100) NULL,
      [Country] [varchar](50) NULL
)
GO