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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}Tasks]') AND type in (N'U'))
	DROP TABLE {databaseOwner}{objectQualifier}Tasks
GO

/*  AddTask  */
/*************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}AddTask]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}AddTask
GO

/*  DeleteTask  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}DeleteTask]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}DeleteTask
GO

/*  GetTask  */
/*************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}GetTask]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}GetTask
GO

/*  GetTasks  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}GetTasks]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}GetTasks
GO

/*  UpdateTask  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}UpdateTask]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}UpdateTask
GO


/************************************************************/
/*****              Sql Script                          *****/
/************************************************************/
