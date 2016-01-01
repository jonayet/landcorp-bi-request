USE [BIRequest]
GO

/****** Object:  Table [dbo].[RequestType]    Script Date: 1/1/2016 10:57:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RequestType](
	[RequestTypeId] [int] IDENTITY(1,1) NOT NULL,
	[RequestTypeTitle] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_RequestType] PRIMARY KEY CLUSTERED 
(
	[RequestTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

