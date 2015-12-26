USE [BIRequest]
GO

/****** Object:  Table [dbo].[Request]    Script Date: 12/27/2015 1:05:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Request](
	[RequestId] [bigint] IDENTITY(1,1) NOT NULL,
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
 CONSTRAINT [PK_Request] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_RequestType] FOREIGN KEY([RequestType])
REFERENCES [dbo].[RequestType] ([RequestTypeId])
GO

ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_RequestType]
GO