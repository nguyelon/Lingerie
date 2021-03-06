
/* Drop Foreign Key Constraints */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_Media_MediaType]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [lego].[Media] DROP CONSTRAINT [FK_Media_MediaType]
GO

/* Drop Tables */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[lego].[Media]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [lego].[Media]
GO


/* Create Tables */
CREATE TABLE [lego].[Media]
(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[Url] [nvarchar](max) NULL,
	[MediaTypeId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ViewCount] [int] NOT NULL
)
GO


/* Create Primary Keys, Indexes, Uniques, Checks */
ALTER TABLE [lego].[Media] 
 ADD CONSTRAINT [PK_Media]
	PRIMARY KEY CLUSTERED ([Id])
GO

CREATE INDEX [IXFK_Media_MediaType] 
 ON [lego].[Media] ([MediaTypeId] ASC)
GO

/* Create Foreign Key Constraints */
ALTER TABLE [lego].[Media] ADD CONSTRAINT [FK_Media_MediaType]
	FOREIGN KEY ([MediaTypeId]) REFERENCES [lego].[MediaType] ([Id]) ON DELETE No Action ON UPDATE No Action
GO

/* Default values */
ALTER TABLE [lego].[Media] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [lego].[Media] ADD  DEFAULT ((10)) FOR [ViewCount]
GO
