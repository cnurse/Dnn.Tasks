/************************************************************/
/*****              Sql Script                          *****/
/*****                                                  *****/
/*****                                                  *****/
/***** Note: To manually execute this script you must   *****/
/*****       perform a search and replace operation     *****/
/*****       for {databaseOwner} and {objectQualifier}  *****/
/*****                                                  *****/
/************************************************************/


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}Tasks]') AND type in (N'U'))
	BEGIN
		CREATE TABLE {databaseOwner}{objectQualifier}Tasks
		(
			TaskID int IDENTITY(1,1) NOT NULL,
			ModuleID int NOT NULL,
			Name nvarchar(2000) NOT NULL,
			[Description] nvarchar(max) NOT NULL,
			IsComplete [bit] NOT NULL,
			CreatedOnDate [datetime] NOT NULL CONSTRAINT DF_{objectQualifier}Tasks_CreatedOnDate DEFAULT (getdate()),
			CONSTRAINT [PK_{objectQualifier}Tasks]
				PRIMARY KEY CLUSTERED ( [TaskID] ASC )
		)
	END

GO

/************************************************************/
/*****              Sql Script                          *****/
/************************************************************/
