USE [BIRequest]
GO

/****** Object:  Table [dbo].[Request]    Script Date: 1/16/2016 2:54:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Request](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestorId] [int] NULL,
	[RequestorName] [nvarchar](50) NULL,
	[DateRequested] [date] NULL,
	[DateRequired] [date] NULL,
	[ExecutiveSponsorId] [int] NULL,
	[ExecutiveSponsor] [nvarchar](50) NULL,
	[RequestName] [nvarchar](50) NULL,
	[RequestTypeId] [int] NULL,
	[RequestNature] [nvarchar](4000) NULL,
	[InformationRequired] [nvarchar](4000) NULL,
	[ParametersRequired] [nvarchar](4000) NULL,
	[GroupingRequirements] [nvarchar](4000) NULL,
	[PeopleToShare] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL,
	[DateReviewed] [date] NULL,
	[EstimatedHours] [int] NULL,
	[BusinessCaseId] [nvarchar](50) NULL,
	[AdminComments] [nvarchar](4000) NULL,
	[ApprovedBySponsor] [bit] NULL,
	[SponsorComments] [nvarchar](4000) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_Request] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Request]  WITH CHECK ADD  CONSTRAINT [FK_Request_RequestType] FOREIGN KEY([RequestTypeId])
REFERENCES [dbo].[RequestType] ([Id])
GO

ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Request_RequestType]
GO

