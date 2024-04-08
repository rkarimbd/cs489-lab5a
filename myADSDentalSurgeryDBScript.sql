
-- Drop the database if it exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = N'ADSDB')
BEGIN
    
	    DROP DATABASE ADSDB;
END;
GO

-- Create the database if it does not exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'ADSDB')
BEGIN
    CREATE DATABASE ADSDB;
END;
GO

USE ADSDB

CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[StreetAddress] [varchar](255) NOT NULL,
	[City] [varchar](100) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[ZipCode] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 4/7/2024 6:42:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Appointments](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[DentistID] [int] NULL,
	[PatientID] [int] NULL,
	[AppointmentDateTime] [datetime] NOT NULL,
	[SurgeryLocation] [int] NULL,
	[Status] [varchar](20) NULL DEFAULT ('Scheduled'),
PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Dentists]    Script Date: 4/7/2024 6:42:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dentists](
	[DentistID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[ContactPhone] [varchar](15) NULL,
	[Email] [varchar](100) NULL,
	[Specialization] [varchar](100) NULL,
	[AddressID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DentistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 4/7/2024 6:42:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patients](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[ContactPhone] [varchar](15) NULL,
	[Email] [varchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[AddressID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Surgeries]    Script Date: 4/7/2024 6:42:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Surgeries](
	[SurgeryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[AddressID] [int] NULL,
	[TelephoneNumber] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[SurgeryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([DentistID])
REFERENCES [dbo].[Dentists] ([DentistID])
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patients] ([PatientID])
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([SurgeryLocation])
REFERENCES [dbo].[Surgeries] ([SurgeryID])
GO
ALTER TABLE [dbo].[Dentists]  WITH CHECK ADD FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[Patients]  WITH CHECK ADD FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[Surgeries]  WITH CHECK ADD FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO








	---------------------------- dummy data input---------------------------------------------------------------------
	
	INSERT INTO Addresses (StreetAddress, City, State, ZipCode)
VALUES
    ('123 Dhaka Road', 'Dhaka', 'Dhaka', '1000'),
    ('456 Chittagong Avenue', 'Chittagong', 'Chittagong', '2000'),
    ('789 Sylhet Street', 'Sylhet', 'Sylhet', '3000');


INSERT INTO Dentists (FirstName, LastName, ContactPhone, Email, Specialization, AddressID)
VALUES
    ('Ahmed', 'Khan', '01710001234', 'ahmed.khan@example.com', 'General Dentistry', 1),
    ('Farah', 'Islam', '01820002345', 'farah.islam@example.com', 'Orthodontics', 2),
    ('Kamal', 'Ahmed', '01930003456', 'kamal.ahmed@example.com', 'Endodontics', 3);


INSERT INTO Patients (FirstName, LastName, ContactPhone, Email, DateOfBirth, AddressID)
VALUES
    ('Rahim', 'Ali', '01640004567', 'rahim.ali@example.com', '1990-05-15', 2),
    ('Ayesha', 'Rahman', '01750005678', 'ayesha.rahman@example.com', '1985-08-20', 3),
    ('Nazrul', 'Islam', '01860006789', 'nazrul.islam@example.com', '2000-12-10', 1);


INSERT INTO Surgeries (Name, AddressID, TelephoneNumber)
VALUES
    ('Dhaka Dental Care', 1, '02-12345678'),
    ('Chittagong Dental Center', 2, '031-23456789'),
    ('Sylhet Family Dentistry', 3, '081-34567890');


INSERT INTO Appointments (DentistID, PatientID, AppointmentDateTime, SurgeryLocation, Status)
VALUES
    (1, 1, '2024-04-10 09:00:00', 1, 'Scheduled'),
    (2, 2, '2024-04-11 14:30:00', 2, 'Scheduled'),
    (3, 3, '2024-04-12 10:15:00', 3, 'Scheduled');





-- Display the list of ALL Dentists registered in the system, sorted in ascending  order of their lastNames 

SELECT * FROM Dentists ORDER BY LastName ASC;


--Display the list of ALL Appointments for a given Dentist by their dentist_Id  number. Include in the result, the Patient information.


SELECT 
    A.AppointmentID,
    A.AppointmentDateTime,
    P.PatientID,
    P.FirstName AS PatientFirstName,
    P.LastName AS PatientLastName,
    P.ContactPhone AS PatientContactPhone,
    P.Email AS PatientEmail,
    P.DateOfBirth AS PatientDateOfBirth
FROM 
    Appointments AS A
JOIN 
    Dentists AS D ON A.DentistID = D.DentistID
JOIN 
    Patients AS P ON A.PatientID = P.PatientID
WHERE 
    D.DentistID = 1;

-- Display the list of ALL Appointments that have been scheduled at a Surgery  Location 

SELECT 
    A.AppointmentID,
    A.AppointmentDateTime,
    A.Status,
    D.FirstName AS DentistFirstName,
    D.LastName AS DentistLastName,
    P.FirstName AS PatientFirstName,
    P.LastName AS PatientLastName
FROM 
    Appointments A
INNER JOIN 
    Dentists D ON A.DentistID = D.DentistID
INNER JOIN 
    Patients P ON A.PatientID = P.PatientID
WHERE 
    A.SurgeryLocation = 1;

-- Display the list of the Appointments booked for a given Patient on a given Date. 

SELECT
    A.AppointmentID,
    A.AppointmentDateTime,
    D.FirstName AS DentistFirstName,
    D.LastName AS DentistLastName,
    S.Name AS SurgeryLocationName,
    A.Status
FROM
    Appointments AS A
JOIN
    Patients AS P ON A.PatientID = P.PatientID
JOIN
    Dentists AS D ON A.DentistID = D.DentistID
JOIN
    Surgeries AS S ON A.SurgeryLocation = S.SurgeryID
WHERE
    P.PatientID = 3
    AND CONVERT(DATE, A.AppointmentDateTime) = '2024-04-12';  


