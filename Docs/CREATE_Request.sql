USE [BIRequest]
GO

/****** Object:  Table [dbo].[Request]    Script Date: 1/1/2016 10:57:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Request](
	[RequestId] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestorId] [int] NULL,
	[RequestorName] [nvarchar](50) NULL,
	[DateRequested] [date] NULL,
	[DateRequired] [date] NULL,
	[ExecutiveSponsorId] [int] NULL,
	[ExecutiveSponsor] [nvarchar](50) NULL,
	[RequestName] [nvarchar](50) NULL,
	[RequestType] [int] NULL,
	[RequestNature] [nvarchar](4000) NULL,
	[InformationRequired] [nvarchar](4000) NULL,
	[ParametersRequired] [nvarchar](4000) NULL,
	[GroupingRequirments] [nvarchar](4000) NULL,
	[PeopleToShare] [nvarchar](4000) NULL,
	[AdditionalComments] [nvarchar](4000) NULL,
	[DateReviewed] [datetime2](7) NULL,
	[EstimatedHours] [int] NULL,
	[BusinessCaseId] [int] NULL,
	[Comments] [nvarchar](4000) NULL,
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

