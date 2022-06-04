create table xyz( foo int)

/****** Object:  Table [dbo].[xyz]    Script Date: 3/28/2022 10:57:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[xyz](
	[foo] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[xyz] ALTER COLUMN [foo] [int] NOT NULL
