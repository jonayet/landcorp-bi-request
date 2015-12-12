USE [Admin]
GO

/****** Object:  Table [dbo].[AppBiRequest]    Script Date: 12/12/2015 2:21:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppBiRequest](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestorName] [nvarchar](50) NULL,
	[DateRequested] [date] NULL,
	[DateRequired] [date] NULL,
	[ExecutiveSponsor] [nvarchar](50) NULL,
	[RequestName] [nvarchar](50) NULL,
	[RequestType] [int] NULL,
	[RequestNature] [nvarchar](500) NULL,
	[InformationRequired] [nvarchar](500) NULL,
	[ParametersRequired] [nvarchar](500) NULL,
	[GroupingRequirments] [nvarchar](500) NULL,
	[PeopleToShare] [nvarchar](500) NULL,
	[AdditionalComments] [nvarchar](500) NULL,
	[DateReviewed] [datetime2](7) NULL,
	[EstimatedHours] [int] NULL,
	[BusinessCaseId] [int] NULL,
	[Comments] [nvarchar](500) NULL,
	[ApprovalStatus] [int] NULL,
 CONSTRAINT [PK_AppBiRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AppBiRequest]  WITH CHECK ADD  CONSTRAINT [FK_AppBiRequest_BiRequestType] FOREIGN KEY([RequestType])
REFERENCES [dbo].[BiRequestType] ([Id])
GO

ALTER TABLE [dbo].[AppBiRequest] CHECK CONSTRAINT [FK_AppBiRequest_BiRequestType]
GO

