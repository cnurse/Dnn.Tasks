/************************************************************/
/*****              Sql Script                          *****/
/*****                                                  *****/
/*****                                                  *****/
/***** Note: To manually execute this script you must   *****/
/*****       perform a search and replace operation     *****/
/*****       for {databaseOwner} and {objectQualifier}  *****/
/*****                                                  *****/
/************************************************************/

/*  Tasks Table  */
/*****************/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}Tasks]') AND type in (N'U'))
	BEGIN
		CREATE TABLE {databaseOwner}{objectQualifier}Tasks
		(
			TaskID int IDENTITY(1,1) NOT NULL,
			ModuleID int NOT NULL,
			Name nvarchar(2000) NOT NULL,
			[Description] nvarchar(max) NULL,
			IsComplete [bit] NOT NULL,
			CreatedOnDate [datetime] NOT NULL CONSTRAINT DF_{objectQualifier}Tasks_CreatedOnDate DEFAULT (getdate()),
			CONSTRAINT [PK_{objectQualifier}Tasks]
				PRIMARY KEY CLUSTERED ( [TaskID] ASC )
		)
	END
GO

/*  AddTask  */
/*************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}AddTask]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}AddTask
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}AddTask
	@ModuleID			int,
	@Name				NVARCHAR(50),
	@Description		nvarchar(max),
	@IsComplete 		bit
AS
	INSERT INTO {databaseOwner}{objectQualifier}Tasks (
	  ModuleID,
	  Name,
	  Description,
	  IsComplete
	)
	VALUES (
	  @ModuleID,
	  @Name,
	  @Description,
	  @IsComplete
	)
	SELECT SCOPE_IDENTITY()
GO

/*  DeleteTask  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}DeleteTask]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}DeleteTask
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}DeleteTask
	@TaskID	int
AS
	DELETE FROM {databaseOwner}{objectQualifier}Tasks
	WHERE TaskID = @TaskID
GO

/*  GetTask  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}GetTask]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}GetTask
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}GetTask
	@TaskID	int
AS
	SELECT * FROM {databaseOwner}{objectQualifier}Tasks
	WHERE TaskID = @TaskID

GO

/*  GetTasks  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}GetTasks]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}GetTasks
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}GetTasks
	@ModuleID	int
AS
	SELECT * FROM {databaseOwner}{objectQualifier}Tasks
	WHERE ModuleID = @ModuleID OR @ModuleID IS NULL

GO

/*  UpdateTask  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}UpdateTask]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}UpdateTask
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}UpdateTask
	@TaskID				int,
	@Name				NVARCHAR(50),
	@Description		nvarchar(max),
	@IsComplete 		bit
AS
	UPDATE {databaseOwner}{objectQualifier}Tasks
		SET 
			Name = @Name,
			Description = @Description,
			IsComplete = @IsComplete
		WHERE TaskID = @TaskID
GO

/************************************************************/
/*****              Sql Script                          *****/
/************************************************************/
