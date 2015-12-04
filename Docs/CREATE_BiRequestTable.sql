USE [Admin]
GO

/****** Object:  Table [dbo].[AppBiRequest]    Script Date: 12/4/2015 10:10:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppBiRequest](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestorName] [nchar](50) NULL,
	[DateRequested] [date] NULL,
	[DateRequired] [date] NULL,
	[ExecutiveSponsor] [nchar](50) NULL,
	[RequestName] [nchar](50) NULL,
	[RequestType] [int] NULL,
	[RequestNature] [nchar](500) NULL,
	[InformationRequired] [nchar](500) NULL,
	[ParametersRequired] [nchar](500) NULL,
	[GroupingRequirments] [nchar](500) NULL,
	[PeopleToShare] [nchar](500) NULL,
	[AdditionalComments] [nchar](500) NULL,
	[DateReviewed] [date] NULL,
	[EstimatedHours] [int] NULL,
	[BusinessCaseId] [int] NULL,
	[Comments] [nchar](500) NULL,
	[ApprovalStatus] [int] NULL,
 CONSTRAINT [PK_AppBiRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


