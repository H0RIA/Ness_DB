Use Ness

If Exists (Select * From sys.tables Where name = 'TiVo_Data')
Begin
	Drop Table TiVo_Data
	Print 'Dropped table TiVo_Data!'
End

If Exists (Select * From sys.tables Where name = 'Ness_Contract_Salaries')
Begin
	Drop Table Ness_Contract_Salaries
	Print 'Dropped table Ness_Contract_Salaries!'
End

If Exists (Select * From sys.tables Where name = 'Ness_Employee_Level')
Begin
	Drop Table Ness_Employee_Level
	Print 'Dropped table Ness_Employee_Level!'
End

If Exists (Select * From sys.tables Where name = 'Ness_Employee_Contract')
Begin
	Drop Table Ness_Employee_Contract
	Print 'Dropped table Ness_Employee_Contract!'
End

If Exists (Select * From sys.tables Where name = 'Ness_Employees')
Begin
	Drop Table Ness_Employees
	Print 'Dropped table Ness_Employees!'
End

If Exists (Select * From sys.tables Where name = 'Ness_EDC_Teams')
Begin
	Drop Table Ness_EDC_Teams
	Print 'Dropped table Ness_EDC_Teams!'
End

If Exists (Select * From sys.tables Where name = 'Ness_Levels')
Begin
	Drop Table Ness_Levels
	Print 'Dropped table Ness_Levels!'
End

If Exists (Select * From sys.tables Where name = 'Ness_EDC_Areas')
Begin
	Drop Table Ness_EDC_Areas
	Print 'Dropped table Ness_EDC_Areas!'
End

If Exists (Select * From sys.tables Where name = 'Ness_EDC')
Begin
	Drop Table Ness_EDC
	Print 'Dropped table Ness_EDC!'
End


Create Table Ness_EDC(
	Id int Identity Primary Key Not Null,
	EDCName NVarChar(50) Not Null,
	Index IDX_NESS_EDC_ID(Id)
)

Print 'Created table Ness_EDC!'

Print 'Populating table Ness_EDC...'
Insert Into Ness_EDC (EDCName) Values (N'SES_TiVo')
Insert Into Ness_EDC (EDCName) Values (N'Alfresco')


Print 'Created table Ness_EDC_Areas!'
Create Table Ness_EDC_Areas(
	Id int Identity Primary Key Not Null,
	EDCId int Not Null,
	AreaName NVarChar(50) Not Null,
	AreaDescription NVarChar(250) Not Null,
	Constraint FK_EDCId_Area Foreign Key (EDCId) References Ness_EDC(Id),
	Index IDX_NESS_EDC_AREAS(Id)
)

Print 'Populating table Ness_EDC_Areas...'

Insert Into Ness_EDC_Areas (EDCId, AreaName, AreaDescription)
	Values ((Select Id From Ness_EDC Where EDCName = N'SES_TiVo'), N'TVE', N'TV Everywhere')

Insert Into Ness_EDC_Areas (EDCId, AreaName, AreaDescription)
	Values ((Select Id From Ness_EDC Where EDCName = N'SES_TiVo'), N'QE', N'Quality Engineering')

Insert Into Ness_EDC_Areas (EDCId, AreaName, AreaDescription) 
	Values ((Select Id From Ness_EDC Where EDCName = N'SES_TiVo'), N'PS&S', N'Professional Services and Support')

Insert Into Ness_EDC_Areas (EDCId, AreaName, AreaDescription) 
	Values ((Select Id From Ness_EDC Where EDCName = N'SES_TiVo'), N'STB', N'Set Top Box')

Insert Into Ness_EDC_Areas (EDCId, AreaName, AreaDescription) 
	Values ((Select Id From Ness_EDC Where EDCName = N'SES_TiVo'), N'HPK', N'')

Insert Into Ness_EDC_Areas (EDCId, AreaName, AreaDescription) 
	Values ((Select Id From Ness_EDC Where EDCName = N'SES_TiVo'), N'APPS', N'3rd party applications')

Insert Into Ness_EDC_Areas (EDCId, AreaName, AreaDescription) 
	Values ((Select Id From Ness_EDC Where EDCName = N'SES_TiVo'), N'UX', N'User Experience')

Insert Into Ness_EDC_Areas (EDCId, AreaName, AreaDescription) 
	Values ((Select Id From Ness_EDC Where EDCName = N'SES_TiVo'), N'Services', N'Backend services')


Print 'Created table Ness_EDC_Teams!'
Create Table Ness_EDC_Teams(
	Id int Identity Primary Key Not Null,
	AreaId int Not Null,
	TeamName NVarChar(50) Not Null,
	TeamDescription NVarChar(250) Not Null,
	Constraint FK_EDCId_Team Foreign Key (AreaId) References Ness_EDC_Areas(Id),
	Index IDX_NESS_EDC_TEAMS(Id)
)

Print 'Populating table Ness_EDC_Teams...'

Insert Into Ness_EDC_Teams (AreaId, TeamName, TeamDescription) 
	Values ((Select Id From Ness_EDC_Areas Where AreaName = N'TVE'), N'Mojo Jojo', N'iOS Development')

Insert Into Ness_EDC_Teams (AreaId, TeamName, TeamDescription) 
	Values ((Select Id From Ness_EDC_Areas Where AreaName = N'TVE'), N'R2D2', N'Android Development')

Print 'Created table Ness_Levels!'
Create Table Ness_Levels(
	Id int Identity Primary Key Not Null,
	LevelName NVarChar(50) Not Null,
	LevelDescription NVarChar(250) Not Null,
	Index IDX_NESS_EDC_ID(Id)
)

Print 'Populating table Ness_Levels...'
Insert Into Ness_Levels (LevelName, LevelDescription) Values (N'L1', N'Junior SW Engineer')
Insert Into Ness_Levels (LevelName, LevelDescription) Values (N'L2', N'Mid SW Engineer')
Insert Into Ness_Levels (LevelName, LevelDescription) Values (N'L3', N'Senior SW Engineer')
Insert Into Ness_Levels (LevelName, LevelDescription) Values (N'L4', N'Architect')
Insert Into Ness_Levels (LevelName, LevelDescription) Values (N'L5', N'Manager')


Print 'Created table Ness_Employees!'
Create Table Ness_Employees(
	Id int Identity Primary Key Not Null, 
	FirstName NVarChar(50) Not Null,
	LastName NVarChar(50) Not Null,
	NessId NVarChar(20) Not Null,
	EDCId int Not Null,
	IsTaxExempt bit Not Null Default(0),
	EDCPersonalNumber NVarChar(20) Null,
	Constraint FK_EmployeeId_EDC Foreign Key (EDCId) References Ness_EDC(Id),
	Index IDX_NESS_EMPLOYEES_ID(Id)
)

Print 'Created table Ness_Employee_Contract!'
Create Table Ness_Employee_Contract(
	Id int Identity Primary Key Not Null,
	EmployeeId int Not Null,
	StartDate DateTime Not Null,
	EndDate DateTime,
	Rate Decimal(28,15) Null,
	Constraint FK_EmployeeId_Contract Foreign Key (EmployeeId) References Ness_Employees(Id),
	Index IDX_NESS_EMPLOYEE_CONTRACT_ID(Id)
)

IF OBJECT_ID ('Trigger_Contract_Validation_Prevent_Duplicate', 'TR') IS NOT NULL  
   DROP TRIGGER Trigger_Contract_Validation_Prevent_Duplicate;  

GO 

Create Trigger Trigger_Contract_Validation_Prevent_Duplicate On Ness_Employee_Contract
After Insert
As 
Begin
	Declare @CountInserted int
	Set @CountInserted = (Select Count(*) from inserted)

	print 'Inserted Ids count: ' + Cast(@CountInserted as varchar)

	Update 
		Ness_Employee_Contract 
	Set 
		Ness_Employee_Contract.EndDate = GetDate() 
	Where 
		Ness_Employee_Contract.EmployeeId In (Select inserted.EmployeeId  From  inserted With(NoLock))
		And Ness_Employee_Contract.Id not in (Select inserted.Id  From  inserted With(NoLock))
End

GO

Print 'Created table Ness_Employee_Level!'
Create Table Ness_Employee_Level(
	Id int Identity Primary Key Not Null,
	EmployeeId int Not Null,
	StartDate DateTime Null,
	EndDate DateTime Null,
	LevelId int Not Null,
	Constraint FK_Employee_EmployeeLevel_Id Foreign Key (EmployeeId) References Ness_Employees(Id),
	Constraint FK_Level_EmployeeLevel_id Foreign Key (LevelId) References Ness_Levels(Id),
	Index IDX_NESS_EMPLOYEE_CONTRACT_ID(Id)
)

Print 'Created table Ness_Contract_Salaries!'
Create Table Ness_Contract_Salaries(
	Id int Identity Primary Key Not Null,
	ContractId int Not Null,
	Salary_Net Decimal(28,4) Not Null,
	Salary_Gross Decimal(28,4) Not Null,
	StartDate Date Not Null,
	EndDate Date Null,
	Constraint FK_ContractSalary_EmployeeContract Foreign Key (ContractId) References Ness_Employee_Contract(Id),
	Index IDX_NESS_CONTRACT_SALARIES_ID(Id)
)

Delete From Ness_Employee_Contract

Insert Into Ness_Employee_Contract (EmployeeId, StartDate, EndDate, Rate)
Select 
	--,Ness_Employees.FirstName
	--,Ness_Employees.LastName
	Ness_Employees.Id
	,GetDate() As StartDate
	,Null As EndDate
	,F14 As Rate
From 
	Ness_GM_Import
		Inner Join Ness_Employees On Ness_Employees.NessId = F4
Where 
	F1 = 'SES_Tivo'
	Or F1 = 'SES_TIVO'


CREATE TABLE [dbo].[TiVo_Data](
	[Supplier Number] [float] NULL,
	[Supplier Name] [nvarchar](255) NULL,
	[Contractor Number] [float] NULL,
	[Contractor Name] [nvarchar](255) NULL,
	[Supervisor Name] [nvarchar](255) NULL,
	[Time Entry Date] [datetime] NULL,
	[Po Number] [float] NULL,
	[Project Number] [nvarchar](255) NULL,
	[Project Name] [nvarchar](255) NULL,
	[Task Number] [nvarchar](255) NULL,
	[Task Name] [nvarchar](255) NULL,
	[Approver Name] [nvarchar](255) NULL,
	[Approved Date] [nvarchar](255) NULL,
	[Contractor Start Date] [nvarchar](255) NULL,
	[Contractor End Date] [nvarchar](255) NULL,
	[Expenditure Type] [nvarchar](255) NULL,
	[Organization Name] [nvarchar](255) NULL,
	[Hours Type] [nvarchar](255) NULL,
	[Worked Hours] [float] NULL,
	[UOM] [nvarchar](255) NULL,
	[Contractor Rate] [nvarchar](255) NULL,
	[Invoice Number] [nvarchar](255) NULL,
	[Invoice Line Num] [nvarchar](255) NULL,
	[Invoice Line Date] [nvarchar](255) NULL,
	[Total Inv Amount] [nvarchar](255) NULL,
	[Comments] [nvarchar](255) NULL,
	[Actual Worked Hours (if different from Worked Hours)] [nvarchar](255) NULL
) ON [PRIMARY]
GO

IF OBJECT_ID(N'dbo.ufnGetEmployeeHoursInMonth', N'FN') Is Not Null
    Drop Function dbo.ufnGetEmployeeHoursInMonth;
GO

Create Function dbo.ufnGetEmployeeHoursInMonth(@paramEmployeeId int, @InvoiceMonth int)
Returns int
As
Begin
	Declare @EmployeeHours int
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime
	Declare @ContractStart datetime
	Declare @ContractEnd datetime

	Set @EmployeeHours = 0

	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(Year(GetDate()) as varchar(4)) + '-01-01' )
	Set @EndOfMonth = EOMonth(@BeginingOfMonth)
	Set @ContractStart = @BeginingOfMonth
	Set @ContractEnd = @EndOfMonth
	
	Select 
		@ContractStart = Case When Ness_Employee_Contract.StartDate Is Null Then @BeginingOfMonth Else Ness_Employee_Contract.StartDate End,
		@ContractEnd = Case When Ness_Employee_Contract.EndDate Is Null Then @EndOfMonth Else Ness_Employee_Contract.EndDate End
	From 
		Ness_Employees
			Left Outer Join Ness_Employee_Contract On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
	Where
		Ness_Employee_Contract.EmployeeId = @paramEmployeeId

	Set @BeginingOfMonth = Case When @ContractStart > @BeginingOfMonth Then @ContractStart Else @BeginingOfMonth End
	Set @EndOfMonth = Case When @ContractEnd < @EndOfMonth Then @ContractEnd Else @EndOfMonth End
	
	-- Business days in month
	Set @EmployeeHours = (DateDiff(dd, @BeginingOfMonth, @EndOfMonth) + 1) 
	-- Subtract weekend days 
	Set @EmployeeHours -= (DateDiff(wk, @BeginingOfMonth, @EndOfMonth) * 2)
	-- Substract start / end days in case they are weekends
	Set @EmployeeHours -= (Case When DateName(dw, @BeginingOfMonth) = 'Sunday' Then 1 Else 0 End)
	Set @EmployeeHours -= (Case When DateName(dw, @EndOfMonth) = 'Saturday' Then 1 Else 0 End)

	Set @EmployeeHours *= 8

	Return @EmployeeHours

End
Go


IF OBJECT_ID(N'dbo.ufnGetEmployeeBillableLoggedHoursInMonth', N'FN') Is Not Null
    Drop Function dbo.ufnGetEmployeeBillableLoggedHoursInMonth;
GO

Create Function dbo.ufnGetEmployeeBillableLoggedHoursInMonth(@paramEmployeeId int, @InvoiceMonth int)
Returns int
As
Begin
	Declare @BillableHours int
	Declare @BeginingOfMonth datetime

	Set @BillableHours = 0
	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(Year(GetDate()) as varchar(4)) + '-01-01' )

	Select 
		@BillableHours = Case When Sum(TiVo_Data.[Worked Hours]) Is Null Then 0 Else Sum(TiVo_Data.[Worked Hours]) End
	From 
		Ness_Employees
			Left Join Ness_Employee_Contract on Ness_Employee_Contract.EmployeeId = Ness_Employees.Id
			Left Join TiVo_Data On TiVo_Data.[Contractor Number] = Ness_Employees.EDCPersonalNumber
			Left Join Ness_Contract_Salaries On Ness_Contract_Salaries.ContractId = Ness_Employee_Contract.Id
	Where
		Ness_Employees.Id = @paramEmployeeId
		And Ness_Employee_Contract.EndDate >= @BeginingOfMonth
		Or Ness_Employee_Contract.EndDate Is Null
		And ([Project Number] Not In ('SAP 1082') or [Project Number] Is Null)
		And ([Task Number] Not In ('003') Or [Task Number] Is Null)
	Group By
		Ness_Employees.Id
		,Ness.dbo.TiVo_Data.[Contractor Number]
		,TiVo_Data.[Project Number]
		,TiVo_Data.[Task Number]
	Order By
		Max(LastName)

	Return @BillableHours
End

Go

If Object_Id(N'dbo.ufnGetEmployeeComments', N'FN') Is Not Null
    Drop Function dbo.ufnGetEmployeeComments;
Go

Create Function dbo.ufnGetEmployeeComments(@paramEmployeeId int, @InvoiceMonth int, @HoursInMonth Int, @BillableHours int)
Returns varchar(255)
As
Begin
	Declare @ResultData varchar(255)
	Declare @VacationDays int
	Declare @JoinedOn int	-- what day of month (if zero => no additional comment)
	Declare @LeavingOn int	-- what day of month (if 100 => no additional comment)
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime
	Declare @HolidayHours int
	Declare @AddComma bit

	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(Year(GetDate()) as varchar(4)) + '-01-01' )
	Set @EndOfMonth = EOMonth(@BeginingOfMonth)
	Set @ResultData = ''
	Set @VacationDays = 0
	Set @JoinedOn = 0
	Set @LeavingOn = 100
	Set @HolidayHours = @HoursInMonth - @BillableHours
	Set @AddComma = 0

	Select
		@VacationDays = (LoggedHours - @HolidayHours) / 8
	From 
		(Select 
			Ness_Employees.Id As EmployeeId
			,Sum(TiVo_Data.[Worked Hours]) As LoggedHours
			,TiVo_Data.[Project Number] As Project
			,TiVo_Data.[Task Number] As Task
		From 
			Ness_Employees
				Left Join Ness_Employee_Contract on Ness_Employee_Contract.EmployeeId = Ness_Employees.Id
				Left Join TiVo_Data On TiVo_Data.[Contractor Number] = Ness_Employees.EDCPersonalNumber
		Where
			(Ness_Employee_Contract.EndDate >= @BeginingOfMonth Or Ness_Employee_Contract.EndDate Is Null)
			And ([Time Entry Date] >= @BeginingOfMonth And [Time Entry Date] <= @EndOfMonth)
		Group By
			Ness_Employees.Id
			,Ness.dbo.TiVo_Data.[Contractor Number]
			,TiVo_Data.[Project Number]
			,TiVo_Data.[Task Number]) As RawData
	Where
		RawData.EmployeeId = @paramEmployeeId
		And ((RawData.Project = 'SAP 1082' And RawData.Task = '003') Or (RawData.Project = 'SAP 1173' And RawData.Task = '003'))


	Select
		@JoinedOn = Case When Ness_Employee_Contract.StartDate >= @BeginingOfMonth Then DateDiff(dd, @BeginingOfMonth, Ness_Employee_Contract.StartDate) Else 0 End
		,@LeavingOn = Case When Ness_Employee_Contract.EndDate <= @EndOfMonth Then DateDiff(dd, @BeginingOfMonth, Ness_Employee_Contract.EndDate) Else 100 End
	From
		Ness_Employees With(NoLock)
			Inner Join Ness_Employee_Contract With(NoLock) On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
	Where
		Ness_Employees.Id = @paramEmployeeId

	If @JoinedOn > 0
	Begin
		Set @JoinedOn += 1
	End

	If @LeavingOn != 100
	Begin
		Set @LeavingOn += 1
	End

	Set @ResultData = Case When @VacationDays > 0 Then Cast(@VacationDays as varchar(10)) + ' vacation day' Else '' End
	Set @ResultData += Case When @VacationDays > 1 Then 's' Else '' End
	Set @AddComma = Case When @VacationDays > 0  Then 1 Else 0 End

	If @AddComma = 1
	Begin
		Set @ResultData = @ResultData + Case When @JoinedOn > 0 Then ', joined on ' + Cast(@JoinedOn as varchar(10)) Else '' End
		If @JoinedOn = 0
			Set @AddComma = 0
	End
	Else
	Begin
		Set @ResultData = @ResultData + Case When @JoinedOn > 0 Then 'joined on ' + Cast(@JoinedOn as varchar(10)) Else '' End
		If @JoinedOn = 0
			Set @AddComma = 0
	End

	If @JoinedOn > 0
	Begin
		Set @ResultData += Case
			When @JoinedOn % 100 in (11, 12, 13) Then 'th'
			When @JoinedOn % 10 = 1 Then 'st'
			When @JoinedOn % 10 = 2 Then 'nd'
			When @JoinedOn % 10 = 3 Then 'rd'
			Else 'th'
		End
	End

	If @AddComma = 1
	Begin
		Set @ResultData = @ResultData + Case When @LeavingOn != 100 Then ', last day on ' + Cast(@LeavingOn as varchar(10)) Else '' End
		If @LeavingOn = 100
			Set @AddComma = 0
	End
	Else
	Begin
		Set @ResultData = @ResultData + Case When @LeavingOn != 100 Then 'last day on ' + Cast(@LeavingOn as varchar(10)) Else '' End
		If @LeavingOn = 100
			Set @AddComma = 0
	End
	
	If @LeavingOn != 100
	Begin
		Set @ResultData += Case
			When @LeavingOn % 100 in (11, 12, 13) Then 'th'
			When @LeavingOn % 10 = 1 Then 'st'
			When @LeavingOn % 10 = 2 Then 'nd'
			When @LeavingOn % 10 = 3 Then 'rd'
			Else 'th'
		End
	End

	Return @ResultData
End

Go

IF OBJECT_ID(N'dbo.ufnGetInvoiceRawData', N'TF') Is Not Null
    Drop Function dbo.ufnGetInvoiceRawData;
GO

Create Function dbo.ufnGetInvoiceRawData(@HoursInMonth Int, @BillableHours int, @InvoiceMonth int)
Returns @retInvoiceRawData Table
(
    -- Columns returned by the function
    Id int Identity Primary Key Not Null, 
	EmployeeId Int Not Null,
	ShortText VarChar(50) Null,
    OldPONumber VarChar(50) Null, 
    TiVo_Contractor_Name NVarChar(50) Null, 
	LastName NVarChar(50) Null, 
	FirstName NVarChar(50) Null, 
    ContractorNumber VarChar(20) Null, 
    HourlyRate Decimal(28,15) Null,
	HoursLogged Int Null,
	LineAmount Decimal(28,15) Null,
	Project VarChar(50) Null,
	Task VarChar(50) Null,
	Comments VarChar(255) Null
)
AS 
-- Returns the first name, last name, job title, and contact type for the specified contact.
Begin
	Declare @ShortText varchar(50)
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime

	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(Year(GetDate()) as varchar(4)) + '-01-01' )
	Set @EndOfMonth = EOMonth(@BeginingOfMonth)
	Set @ShortText = 'Service Period ' + DateName(month , DateAdd( month , @InvoiceMonth - 1 , '1900-01-01' ) ) + ' ' + Cast(Year(GetDate()) as varchar(4))

	Insert Into @retInvoiceRawData
	Select 
		Ness_Employees.Id
		,@ShortText
		,349926 As OldPONumber
		,Max(Ness.dbo.TiVo_Data.[Contractor Name]) As [Contractor Name]
		,Max(Ness.dbo.Ness_Employees.LastName) as LastName
		,Max(Ness.dbo.Ness_Employees.FirstName) as FirstName
		,Ness.dbo.TiVo_Data.[Contractor Number]
		,(Case 
			When Max(Ness_Employee_Contract.Rate) Is Null 
			Then 0 
			Else Max(Ness_Employee_Contract.Rate) End / dbo.ufnGetEmployeeBillableLoggedHoursInMonth(Ness_Employees.Id, @InvoiceMonth)) As [Hourly Rate]
		,Sum(TiVo_Data.[Worked Hours]) As [Logged Hours]
		,Case 
			When Max(Ness_Employee_Contract.Rate) Is Null 
			Then 0 
			Else (Max(Ness_Employee_Contract.Rate) * Sum(TiVo_Data.[Worked Hours])) / @BillableHours End As LineAmount
		,TiVo_Data.[Project Number] As Project
		,TiVo_Data.[Task Number] As Task
		,dbo.ufnGetEmployeeComments(Ness_Employees.Id, @InvoiceMonth, @HoursInMonth, @BillableHours)
	From 
		Ness_Employees
			Left Join Ness_Employee_Contract on Ness_Employee_Contract.EmployeeId = Ness_Employees.Id
			Left Join TiVo_Data On TiVo_Data.[Contractor Number] = Ness_Employees.EDCPersonalNumber
	Where
		(Ness_Employee_Contract.EndDate >= @BeginingOfMonth Or Ness_Employee_Contract.EndDate Is Null)
		And ([Time Entry Date] >= @BeginingOfMonth And [Time Entry Date] <= @EndOfMonth)
	Group By
		Ness_Employees.Id
		,Ness.dbo.TiVo_Data.[Contractor Number]
		,TiVo_Data.[Project Number]
		,TiVo_Data.[Task Number]
	Order By
		Max(LastName)

	Return;
End

Go


If Object_Id(N'dbo.ufnGetMissingInvoiceInfo', N'TF') Is Not Null
    Drop Function dbo.ufnGetMissingInvoiceInfo;
Go

Create Function dbo.ufnGetMissingInvoiceInfo(@HoursInMonth Int, @InvoiceMonth int = 1)
Returns @retMissingInvoiceData Table
(
    -- Columns returned by the function
    Id int Identity Primary Key Not Null, 
	LastName NVarChar(50) Null, 
	FirstName NVarChar(50) Null, 
    ContractorNumber VarChar(20) Null, 
    HourlyRate Decimal(28,15) Null,
	HoursMissing Int Null,
	HoursWorked Int Null,
	LineAmount Decimal(28,15) Null
)
AS 
Begin
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime

	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(Year(GetDate()) as varchar(4)) + '-01-01' )
	Set @EndOfMonth = EOMonth(@BeginingOfMonth)
	
	Insert Into @retMissingInvoiceData
	Select 
		Max(Ness.dbo.Ness_Employees.LastName) as LastName
		,Max(Ness.dbo.Ness_Employees.FirstName) as FirstName
		,Max(Ness.dbo.Ness_Employees.EDCPersonalNumber)
		,(Case When Max(Ness_Employee_Contract.Rate) Is Null Then 0 Else Max(Ness_Employee_Contract.Rate) End / @HoursInMonth) As [Hourly Rate]
		,dbo.ufnGetEmployeeHoursInMonth(Ness_Employees.Id, @InvoiceMonth) - (Case When Sum(TiVo_Data.[Worked Hours]) Is Null Then 0 Else Sum(TiVo_Data.[Worked Hours]) End) As [Hours Missing]
		,Sum(TiVo_Data.[Worked Hours]) As [Hours Worked]
		,Case When Max(Ness_Employee_Contract.Rate) Is Null Then 0 Else (Max(Ness_Employee_Contract.Rate) * (dbo.ufnGetEmployeeHoursInMonth(Ness_Employees.Id, @InvoiceMonth) - Sum(TiVo_Data.[Worked Hours]))) / @HoursInMonth End As LineAmount
	From 
		Ness_Employees
			Left Join Ness_Employee_Contract on Ness_Employee_Contract.EmployeeId = Ness_Employees.Id
			Left Join TiVo_Data On TiVo_Data.[Contractor Number] = Ness_Employees.EDCPersonalNumber
	Where
		(Ness_Employee_Contract.EndDate >= @BeginingOfMonth Or Ness_Employee_Contract.EndDate Is Null)
		And ([Time Entry Date] >= @BeginingOfMonth And [Time Entry Date] <= @EndOfMonth)
		Or TiVo_Data.[Contractor Number] Is Null
	Group By
		Ness_Employees.Id
		,Ness.dbo.TiVo_Data.[Contractor Number]
	Order By
		Max(LastName)

	Return;
End

Go

If Object_Id(N'dbo.uspImportDataFromTiVoRaw', N'P') Is Not Null
    Drop Procedure dbo.uspImportDataFromTiVoRaw;
Go

Create Procedure dbo.uspImportDataFromTiVoRaw
	@SourceTable nvarchar(50),
	@Result int Out
As
SET NOCOUNT ON
Begin
	Declare @PersonnelId nvarchar(255)
	Declare @ExpenditureDate datetime
	Declare @ProjectNumber nvarchar(255)
	Declare @TaskNumber nvarchar(255)
	Declare @Quantity float
	Declare @RecordCount int
	Declare @SourceSQL nvarchar(255)
	Declare @TiVoDataCursor Cursor

	Set @Result = 0
	Set @RecordCount = 0

	Set @SourceSQL = N'Set @TiVoDataCursor = Cursor Local Read_Only Forward_Only Static For Select [Personnel Id], [Expenditure Date], [Project Number], [Task Number], [Quantity] From ' + @SourceTable;
	Set @SourceSQL += N'; \
	Open @TiVoDataCursor;'
	Execute sp_executesql @SourceSQL, N'@TiVoDataCursor CURSOR OUTPUT', @TiVoDataCursor Output
	
	Fetch Next From @TiVoDataCursor   
	Into @PersonnelId, @ExpenditureDate, @ProjectNumber, @TaskNumber, @Quantity

	While @@FETCH_STATUS = 0  
	Begin
		Select @RecordCount = Count(*) From TiVo_Data 
		Where 
			[Contractor Number] = @PersonnelId
			And [Time Entry Date] = @ExpenditureDate
			And [Project Number] = @ProjectNumber
			And [Task Number] = @TaskNumber
			And [Worked Hours] = @Quantity

		If @RecordCount > 1
		Begin
			Print 'Warning: For ' + @PersonnelId + ' on ' + Cast(@ExpenditureDate as varchar(50)) + ' logged ' + Cast(@Quantity as varchar(10)) + ' hours for project ' + @ProjectNumber + ' and task ' + @TaskNumber + ' there are ' + Cast(@RecordCount as varchar(10)) + ' entries in TiVo_Data'
		End

		If @RecordCount = 0
		Begin
			Print 'Adding data for user ' + @PersonnelId + ' on '  + Cast(@ExpenditureDate as varchar(50)) + ' for project ' + @ProjectNumber + ' and task ' + @TaskNumber 

			Insert Into TiVo_Data (
				[Supplier Number],		-- ok
				[Supplier Name],		-- ok
				[Contractor Number],	-- ok
				[Contractor Name],		-- ok
				[Supervisor Name],		-- ok
				[Time Entry Date],		-- ok
				[Po Number],			-- ok
				[Project Number],		-- ok
				[Project Name],			-- ok
				[Task Number],			-- ok
				[Task Name],			-- ok
				[Approver Name],		-- ok
				[Approved Date],		-- ok
				[Contractor Start Date],-- ok
				[Contractor End Date],	-- ok
				[Expenditure Type],		-- ok
				[Organization Name],	-- ok
				[Hours Type],			-- ok
				[Worked Hours],			-- ok
				[UOM],					-- ok
				[Contractor Rate],		-- ok
				[Invoice Number],		-- ok
				[Invoice Line Num],
				[Invoice Line Date],
				[Total Inv Amount],
				[Comments],
				[Actual Worked Hours (if different from Worked Hours)])
			Select 
				[Vendor Number],		-- [Supplier Number]
				[Vendor Name],			-- [Supplier Name]
				[Personnel Id],			-- [Contractor Number]
				[Personnel Name],		-- [Contractor Name]
				Null,					-- [Supervisor Name]
				[Expenditure Date],		-- [Time Entry Date]
				[PO Number],			-- [Po Number]
				[Project Number],		-- [Project Number]
				[Project Name],			-- [Project Name]
				[Task Number],			-- [Task Number]
				[Task Name],			-- [Task Name]
				Null,					-- [Approver Name]
				Null,					-- [Approved Date]
				Null,					-- [Contractor Start Date]
				Null,					-- [Contractor End Date]
				[Expenditure Type],		-- [Expenditure Type]
				[Project Organization],	-- [Organization Name]
				Null,					-- [Hours Type]
				[Quantity],				-- [Worked Hours]
				[UOM],					-- [UOM]
				Null,					-- [Contractor Rate]
				[Invoice Number],		-- [Invoice Number]
				Null, -- Invoice line num
				Null, -- Invoice line date
				Null, -- total invoice amount
				Null, -- comments
				Null -- Actual worked hours
			From 
				TiVo_Data_Raw
			Where
				[Personnel Id] = @PersonnelId
				And [Expenditure Date] = @ExpenditureDate
				And [Project Number] = @ProjectNumber
				And [Task Number] = @TaskNumber
				And [Quantity] = @Quantity
		End

		Fetch Next From @TiVoDataCursor   
		Into @PersonnelId, @ExpenditureDate, @ProjectNumber, @TaskNumber, @Quantity
	End

	Close @TiVoDataCursor
	Deallocate @TiVoDataCursor

End

Go