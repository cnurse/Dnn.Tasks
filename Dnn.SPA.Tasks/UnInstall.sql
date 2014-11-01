/************************************************************/
/*****              Sql Script                          *****/
/*****                                                  *****/
/*****                                                  *****/
/***** Note: To manually execute this script you must   *****/
/*****       perform a search and replace operation     *****/
/*****       for {databaseOwner} and {objectQualifier}  *****/
/*****                                                  *****/
/************************************************************/


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}Tasks]') AND type in (N'U'))
	DROP TABLE {databaseOwner}{objectQualifier}Tasks

GO

/************************************************************/
/*****              Sql Script                          *****/
/************************************************************/
