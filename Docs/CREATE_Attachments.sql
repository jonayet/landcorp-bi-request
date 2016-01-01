USE [BIRequest]
GO

/****** Object:  Table [dbo].[Attachments]    Script Date: 1/1/2016 10:55:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Attachments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](50) NULL,
	[ContentType] [nvarchar](50) NOT NULL,
	[ContentLength] [bigint] NOT NULL,
	[FileContent] [varbinary](max) NOT NULL,
	[RequestId] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_Attachments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Attachments]  WITH CHECK ADD  CONSTRAINT [FK_Attachments_Request] FOREIGN KEY([RequestId])
REFERENCES [dbo].[Request] ([Id])
GO

ALTER TABLE [dbo].[Attachments] CHECK CONSTRAINT [FK_Attachments_Request]
GO

