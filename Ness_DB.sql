Use Ness

ALTER DATABASE Ness SET COMPATIBILITY_LEVEL = 130 

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

Print 'Populate table Ness_Employees...'
Insert Into Ness_Employees (FirstName, LastName, NessId, EDCId, IsTaxExempt, EDCPersonalNumber) 
Select FirstName, LastName, Case When Ness_ID Is Null Then 0 Else Cast(Cast(Ness_ID as int) as varchar(20)) End, 1, Case When Tax_ext = 'yes' Then 1 else 0 End, [New Tivo]  From Imported_Employees 
Where LastName Is Not Null And Ness_ID Is Not Null

Print 'Created table Ness_Employee_Contract!'
Create Table Ness_Employee_Contract(
	Id int Identity Primary Key Not Null,
	EmployeeId int Not Null,
	StartDate DateTime Not Null,
	EndDate DateTime,
	Rate Decimal(28,15) Null,
	IsFlex bit Not Null Default(0), 
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
	Declare @NeedToUpdate bit
	
	Set @CountInserted = (Select Count(*) from inserted)
	Set @NeedToUpdate = 0
	
	print 'Inserted Ids count: ' + Cast(@CountInserted as varchar)

	Select @NeedToUpdate = Case When inserted.EndDate Is Null Then 1 Else 0 End From inserted

	If @NeedToUpdate = 1
	Begin
		Update 
			Ness_Employee_Contract 
		Set 
			Ness_Employee_Contract.EndDate = GetDate() 
		Where 
			Ness_Employee_Contract.EmployeeId In (Select inserted.EmployeeId  From  inserted With(NoLock))
			And Ness_Employee_Contract.Id not in (Select inserted.Id  From  inserted With(NoLock))
	End
End

GO

Print 'Populate table Ness_Employee_Contract...'

Insert Into Ness_Employee_Contract (EmployeeId, StartDate, EndDate, Rate)
Select
	Ness_Employees.Id, [Start date], null, [Bill Rate]
From
	Ness_Employees
		Inner Join Imported_Employees On Ness_Employees.NessId = Ness_ID
Where 
	Imported_Employees.[Start date] Is Not Null


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

IF OBJECT_ID(N'dbo.ufnGetEmployeeHoursInMonth', N'FN') Is Not Null
    Drop Function dbo.ufnGetEmployeeHoursInMonth;
GO

Create Function dbo.ufnGetEmployeeHoursInMonth(@paramEmployeeId int, @InvoiceMonth int, @InvoiceYear int)
Returns int
As
Begin
	Declare @EmployeeHours int
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime
	Declare @ContractStart datetime
	Declare @ContractEnd datetime

	Set @EmployeeHours = 0

	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(@InvoiceYear as varchar(4)) + '-01-01' )
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

	Set @BeginingOfMonth = Case When @ContractStart >= @BeginingOfMonth And @ContractStart <= @EndOfMonth Then @ContractStart Else @BeginingOfMonth End
	Set @EndOfMonth = Case When @ContractEnd <= @EndOfMonth And @ContractEnd >= @BeginingOfMonth Then @ContractEnd Else @EndOfMonth End
	
	If @ContractEnd < @BeginingOfMonth
	Begin
		Set @EmployeeHours = 0
	End
	Else
	Begin
		-- Business days in month
		Set @EmployeeHours = (DateDiff(dd, @BeginingOfMonth, @EndOfMonth) + 1) 
		-- Subtract weekend days 
		Set @EmployeeHours -= (DateDiff(wk, @BeginingOfMonth, @EndOfMonth) * 2)
		-- Substract start / end days in case they are weekends
		Set @EmployeeHours -= (Case When DateName(dw, @BeginingOfMonth) = 'Sunday' Then 1 Else 0 End)
		Set @EmployeeHours -= (Case When DateName(dw, @EndOfMonth) = 'Saturday' Then 1 Else 0 End)

		Set @EmployeeHours *= 8
	End

	Return @EmployeeHours

End
Go

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
		@JoinedOn = Case When Ness_Employee_Contract.StartDate >= @BeginingOfMonth And Ness_Employee_Contract.StartDate <= @EndOfMonth Then DateDiff(dd, @BeginingOfMonth, Ness_Employee_Contract.StartDate) Else 0 End
		,@LeavingOn = Case When Ness_Employee_Contract.EndDate <= @EndOfMonth And Ness_Employee_Contract.EndDate >= @BeginingOfMonth Then DateDiff(dd, @BeginingOfMonth, Ness_Employee_Contract.EndDate) Else 100 End
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

	Set @AddComma = Case When @VacationDays > 0  Or @JoinedOn > 0 Then 1 Else 0 End

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

Create Function dbo.ufnGetInvoiceRawData(@HoursInMonth Int, @BillableHours int, @InvoiceMonth int, @InvoiceYear int)
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
	Comments VarChar(255) Null,
	OrganizationName nvarchar(255) Null
)
AS 
-- Returns the first name, last name, job title, and contact type for the specified contact.
Begin
	Declare @ShortText varchar(50)
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime

	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(@InvoiceYear as varchar(4)) + '-01-01' )
	Set @EndOfMonth = EOMonth(@BeginingOfMonth)
	Set @ShortText = 'Service Period ' + DateName(month , DateAdd( month , @InvoiceMonth - 1 , '1900-01-01' ) ) + ' ' + Cast(@InvoiceYear as varchar(4))

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
		,Max(TiVo_Data.[Organization Name]) As OrganizatioName
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

Create Function dbo.ufnGetMissingInvoiceInfo(@HoursInMonth Int, @InvoiceMonth int, @InvoiceYear int)
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
	LineAmount Decimal(28,15) Null,
	OrganizationName nvarchar(255) Null
)
AS 
Begin
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime
	Declare @LastName nvarchar(50)
	Declare @FirstName nvarchar(50)
	Declare @EDCPersonalNumber nvarchar(20)
	Declare @HourlyRate decimal (28,15)
	Declare @WorkedHours int


	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(@InvoiceYear as varchar(4)) + '-01-01' )
	Set @EndOfMonth = EOMonth(@BeginingOfMonth)

	-- Insert into the table the data "in raw mode" -> one entry for every employee with a valid contract during that month + all hours
	Insert Into @retMissingInvoiceData (
		LastName, 
		FirstName, 
		ContractorNumber, 
		HourlyRate, 
		HoursMissing)
	SELECT 
		Ness_Employees.LastName,
		Ness_Employees.FirstName,
		Ness_Employees.EDCPersonalNumber,
		(Case When Ness_Employee_Contract.Rate Is Null Then 0 Else Ness_Employee_Contract.Rate End) / @HoursInMonth As HourlyRate,
		dbo.ufnGetEmployeeHoursInMonth(Ness_Employees.Id, @InvoiceMonth, @InvoiceYear)
	From 
		Ness_Employees 
			Inner Join Ness_Employee_Contract On Ness_Employees.ID = Ness_Employee_Contract.EmployeeId
	Where 
		Ness_Employee_Contract.StartDate < @EndOfMonth
		And (Ness_Employee_Contract.EndDate > @BeginingOfMonth Or Ness_Employee_Contract.EndDate Is Null)

	-- Fetch data from the TiVo timesheet and update the data in the table
	Declare TiVoDataCursor Cursor For
	Select
		Cast(Cast([Contractor Number] as int) as varchar(20))
		,(Case When Sum(TiVo_Data.[Worked Hours]) Is Null Then 0 Else Sum(TiVo_Data.[Worked Hours]) End) As WorkedHours
	From 
		TiVo_Data With(NoLock)
	Where 
		TiVo_Data.[Time Entry Date] <= @EndOfMonth
		And TiVo_Data.[Time Entry Date] >= @BeginingOfMonth
	Group By
		[Contractor Number]

	Open TiVoDataCursor
	
	Fetch Next From TiVoDataCursor   
	Into @EDCPersonalNumber, @WorkedHours

	While @@FETCH_STATUS = 0
	Begin
		If @WorkedHours != 0
		Begin
			Update @retMissingInvoiceData Set HoursMissing = HoursMissing - @WorkedHours Where ContractorNumber = @EDCPersonalNumber
		End

		Fetch Next From TiVoDataCursor   
		Into @EDCPersonalNumber, @WorkedHours
	End

	Close TiVoDataCursor
	Deallocate TiVoDataCursor
	
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

If Object_Id(N'dbo.uspImportDataFromTiVoTimesheet', N'P') Is Not Null
    Drop Procedure dbo.uspImportDataFromTiVoTimesheet;
Go

Create Procedure dbo.uspImportDataFromTiVoTimesheet
	@SourceTable nvarchar(50),
	@Result int Out
As
SET NOCOUNT ON
Begin
	Declare @SupplierNumber float
	Declare @SupplierName nvarchar(255)
	Declare @ContractorNumber nvarchar(255)
	Declare @ContractorName nvarchar(255)
	Declare @SupervisorName nvarchar(255)
	Declare @TimeEntryDate datetime
	Declare @PONumber float
	Declare @ProjectNumber nvarchar(255)
	Declare @ProjectName nvarchar(255)
	Declare @TaskNumber nvarchar(255)
	Declare @TaskName nvarchar(255)
	Declare @ApproverName nvarchar(255)
	Declare @ApproverDate nvarchar(255)
	Declare @ContractorStartDate nvarchar(255)
	Declare @ContractorEndDate nvarchar(255)
	Declare @ExpenditureType nvarchar(255)
	Declare @OrgName nvarchar(255)
	Declare @HoursType nvarchar(255)
	Declare @WorkedHours float
	Declare @UOM nvarchar(255)

	--Declare @Quantity float
	Declare @RecordCount int
	Declare @SourceSQL nvarchar(2000)
	Declare @TiVoDataCursor Cursor

	Set @Result = 0
	Set @RecordCount = 0

	Set @SourceSQL = N'Set @TiVoDataCursor = Cursor Local Read_Only Forward_Only Static For Select \
			[Supplier Number],		 \
			[Supplier Name],		 \
			[Contractor Number],	 \
			[Contractor Name],		 \
			[Supervisor Name],		 \
			[Time Entry Date],		 \
			[Po Number],			 \
			[Project Number],		 \
			[Project Name],			 \
			[Task Number],			 \
			[Task Name],			 \
			[Approver Name],		 \
			[Approved Date],		 \
			[Contractor Start Date], \
			[Contractor End Date],	 \
			[Expenditure Type],		 \
			[Organization Name],	 \
			[Hours Type],			 \
			[Worked Hours],			 \
			[UOM]					 \
			From ' + @SourceTable;
	Set @SourceSQL += N'; \
	Open @TiVoDataCursor;'
	Execute sp_executesql @SourceSQL, N'@TiVoDataCursor CURSOR OUTPUT', @TiVoDataCursor Output
	
	Fetch Next From @TiVoDataCursor   
	Into  
		@SupplierNumber,
		@SupplierName,
		@ContractorNumber,
		@ContractorName,
		@SupervisorName,
		@TimeEntryDate,
		@PONumber,
		@ProjectNumber,
		@ProjectName,
		@TaskNumber,
		@TaskName,
		@ApproverName,
		@ApproverDate,
		@ContractorStartDate,
		@ContractorEndDate,
		@ExpenditureType,
		@OrgName,
		@HoursType,
		@WorkedHours,
		@UOM

	While @@FETCH_STATUS = 0  
	Begin
		Select @RecordCount = Count(*) From TiVo_Data 
		Where 
			[Contractor Number] = @ContractorNumber
			And [Time Entry Date] = @TimeEntryDate
			And [Project Number] = @ProjectNumber
			And [Task Number] = @TaskNumber
			And [Worked Hours] = @WorkedHours

		If @RecordCount > 1
		Begin
			Print 'Warning: For ' + @ContractorNumber + ' on ' + Cast(@TimeEntryDate as varchar(50)) + ' logged ' + Cast(@WorkedHours as varchar(10)) + ' hours for project ' + @ProjectNumber + ' and task ' + @TaskNumber + ' there are ' + Cast(@RecordCount as varchar(10)) + ' entries in TiVo_Data'
		End

		If @RecordCount = 0
		Begin
			Print 'Adding data for user ' + @ContractorNumber + ' on '  + Cast(@TimeEntryDate as varchar(50)) + ' for project ' + @ProjectNumber + ' and task ' + @TaskNumber 

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
			Values( 
				@SupplierNumber,
				@SupplierName,
				@ContractorNumber,
				@ContractorName,
				@SupervisorName,
				@TimeEntryDate,
				@PONumber,
				@ProjectNumber,
				@ProjectName,
				@TaskNumber,
				@TaskName,
				@ApproverName,
				@ApproverDate,
				@ContractorStartDate,
				@ContractorEndDate,
				@ExpenditureType,
				@OrgName,
				@HoursType,
				@WorkedHours,
				@UOM,
				Null,					-- [Contractor Rate]
				Null,
				Null, -- Invoice line num
				Null, -- Invoice line date
				Null, -- total invoice amount
				Null, -- comments
				Null -- Actual worked hours
				)
		End

		Fetch Next From @TiVoDataCursor   
		Into  
			@SupplierNumber,
			@SupplierName,
			@ContractorNumber,
			@ContractorName,
			@SupervisorName,
			@TimeEntryDate,
			@PONumber,
			@ProjectNumber,
			@ProjectName,
			@TaskNumber,
			@TaskName,
			@ApproverName,
			@ApproverDate,
			@ContractorStartDate,
			@ContractorEndDate,
			@ExpenditureType,
			@OrgName,
			@HoursType,
			@WorkedHours,
			@UOM
		End

	Close @TiVoDataCursor
	Deallocate @TiVoDataCursor

End

Go

If Object_Id(N'dbo.ufnGetNameSubstring', N'FN') Is Not Null
    Drop Function dbo.ufnGetNameSubstring;
Go

-- If firstName = 1 returns thre first name, otherwise the last name
Create Function dbo.ufnGetNameSubstring(@sourceString nvarchar(255), @token char, @firstName bit)
Returns nvarchar(255)
As
Begin
	Declare @Result nvarchar(255)
	Declare @varFirstName nvarchar(255)
	Declare @varLastName nvarchar(255)

	DECLARE @SubStrings table 
	( 
		part nvarchar(255)
	)

	Insert Into @SubStrings (part)
	Select value From STRING_SPLIT(@sourceString, @token)

	Set @varFirstName = (Select Top 1 part from @SubStrings)
	Set @varLastName = SUBSTRING(@sourceString, len(@varFirstName) + 2, len(@sourceString) - len(@varFirstName) - 1)

	Set @Result = Case When @firstName = 1 Then @varFirstName Else @varLastName End

	Return @Result
End

Go

If Object_Id(N'dbo.uspImportEmployeesFromNessGM', N'P') Is Not Null
    Drop Procedure dbo.uspImportEmployeesFromNessGM;
Go

Create Procedure dbo.uspImportEmployeesFromNessGM
	@SourceTable nvarchar(50),
	@Result int Out
As
SET NOCOUNT ON
Begin
	
	Declare @FirstName nvarchar(255)
	Declare @LastName nvarchar(255)
	Declare @NessId nvarchar(50)
	Declare @EDCId int
	Declare @IsTaxExempt bit
	Declare @RecordCount int
	Declare @EDCPersonallNumber nvarchar(50)
	Declare @SourceSQL nvarchar(500)
	Declare @NessGMDataCursor Cursor

	Set @Result = 0
	Set @RecordCount = 0

	Set @SourceSQL = N'Set @NessGMDataCursor = Cursor Local Read_Only Forward_Only Static For Select '
	Set @SourceSQL += N'dbo.ufnGetNameSubstring(F5, '' '', 0) As FirstName, '
	Set @SourceSQL += N'dbo.ufnGetNameSubstring(F5, '' '', 1) As LastName, '
	Set @SourceSQL += N'Cast(Cast(F4 as int) as nvarchar(10)), '
	Set @SourceSQL += N'1, 1, Null From ' + @SourceTable 
	Set @SourceSQL += N' Where F1 = ''SES_TIVO'' Or F1 = ''SES_TIVO'' ';
	Set @SourceSQL += N'; \
	Open @NessGMDataCursor;'

	Execute sp_executesql @SourceSQL, N'@NessGMDataCursor CURSOR OUTPUT', @NessGMDataCursor Output
	
	Fetch Next From @NessGMDataCursor   
	Into @FirstName, @LastName, @NessId, @EDCId, @IsTaxExempt, @EDCPersonallNumber

	While @@FETCH_STATUS = 0  
	Begin
		Select @RecordCount = Count(*) From Ness_Employees 
		Where 
			NessId = @NessId

		If @RecordCount > 1
		Begin
			Print 'Warning: For ' + @NessId + ' there are ' + Cast(@RecordCount as varchar(10)) + ' entries in Ness_Employees'
		End

		If @RecordCount = 0
		Begin
			Print 'Adding data for user ' + @FirstName + ' ' + @LastName

			Insert Into Ness_Employees (FirstName, LastName, NessId, EDCId, IsTaxExempt, EDCPersonalNumber)
			Values(@FirstName, @LastName, @NessId, @EDCId, @IsTaxExempt, @EDCPersonallNumber)
		End

		Fetch Next From @NessGMDataCursor   
		Into @FirstName, @LastName, @NessId, @EDCId, @IsTaxExempt, @EDCPersonallNumber
	End

	Close @NessGMDataCursor
	Deallocate @NessGMDataCursor

End

Go


If Object_Id(N'dbo.uspImportEmployeeContractsFromNessGM', N'P') Is Not Null
    Drop Procedure dbo.uspImportEmployeeContractsFromNessGM;
Go

Create Procedure dbo.uspImportEmployeeContractsFromNessGM
	@SourceTable nvarchar(50),
	@Result int Out
As
SET NOCOUNT ON
Begin

	Declare @FirstName nvarchar(255)
	Declare @LastName nvarchar(255)
	Declare @NessId nvarchar(50)
	Declare @EmployeeId int
	Declare @EDCId int
	Declare @IsTaxExempt bit
	Declare @RecordCount int
	Declare @EDCPersonallNumber nvarchar(50)
	Declare @SourceSQL nvarchar(500)
	Declare @NessGMDataCursor Cursor
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime
	Declare @JoinDate datetime
	Declare @InvoiceMonth int
	Declare @EndDate datetime
	Declare @BillingStartDate datetime
	Declare @BillingEndDate datetime
	Declare @Rate decimal(28,15)

	Set @Result = 0
	Set @RecordCount = 0
	
	Set @JoinDate = @BeginingOfMonth 
	Set @SourceSQL = N'Set @NessGMDataCursor = Cursor Local Read_Only Forward_Only Static For Select '
	Set @SourceSQL += N'dbo.ufnGetNameSubstring(F5, '' '', 0) As FirstName, '
	Set @SourceSQL += N'dbo.ufnGetNameSubstring(F5, '' '', 1) As LastName, '
	Set @SourceSQL += N'F9 As JoinDate, '
	Set @SourceSQL += N'F10 As BillingStartDate, '
	Set @SourceSQL += N'F11 As BillingEndDate, '
	Set @SourceSQL += N'F15 As BillRateUSD, '
	Set @SourceSQL += N'Cast(Cast(F4 as int) as nvarchar(10)) As NessId '
	Set @SourceSQL += N'From ' + @SourceTable 
	Set @SourceSQL += N' Where F1 = ''SES_TIVO'' Or F1 = ''SES_TIVO'' ';
	Set @SourceSQL += N'; \
	Open @NessGMDataCursor;'

	Execute sp_executesql @SourceSQL, N'@NessGMDataCursor CURSOR OUTPUT', @NessGMDataCursor Output
	
	Fetch Next From @NessGMDataCursor   
	Into @FirstName, @LastName, @JoinDate, @BillingStartDate, @BillingEndDate, @Rate, @NessId

	While @@FETCH_STATUS = 0  
	Begin
		
		If @LastName = 'Buleu' And @FirstName = 'Daniel'
		Begin
			Fetch Next From @NessGMDataCursor   
			Into @FirstName, @LastName, @JoinDate, @BillingStartDate, @BillingEndDate, @Rate, @NessId
			Continue;
		End

		Select @EmployeeId = Id From Ness_Employees Where Ness_Employees.NessId = @NessId

		Select @RecordCount = Count(*) From Ness_Employee_Contract
		Where
			Ness_Employee_Contract.EmployeeId = @EmployeeId 
			And (EndDate > GetDate() Or EndDate Is Null)

		Set @InvoiceMonth = Month(@BillingStartDate)
		Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(Year(@BillingStartDate) as varchar(4)) + '-01-01' )
		Set @EndOfMonth = EOMonth(@BeginingOfMonth)

		If @BillingEndDate <= @BeginingOfMonth
		Begin
			-- We don't have billing info for this month...
			Fetch Next From @NessGMDataCursor   
			Into @FirstName, @LastName, @JoinDate, @BillingStartDate, @BillingEndDate, @Rate, @NessId
			Continue;
		End

		If @RecordCount = 0
		Begin
			Print 'Adding contract for user ' + @LastName + ' ' + @FirstName + '(' + @NessId + ')'
			Set @EndDate = Null

			If @BillingEndDate < @EndOfMonth	-- the user will leave during this month
			Begin
				Print 'Contract for user ' + @LastName + ' ' + @FirstName + '(' + @NessId + ') will end on ' + Cast(@BillingEndDate as nvarchar(20))
				Set @EndDate = @BillingEndDate
			End

			If @BillingStartDate > @BeginingOfMonth -- the user joined this month
			Begin
				Print 'Contract for user ' + @LastName + ' ' + @FirstName + '(' + @NessId + ') will start on ' + Cast(@BillingStartDate as nvarchar(20)) 
				Set @JoinDate = Case When @JoinDate Is Null Then @BillingStartDate Else @JoinDate End
			End

			Set @JoinDate = Case When @JoinDate Is Null Then @BillingStartDate Else @JoinDate End
			If Exists (	Select * 
						From 
							Ness_Employees
								Inner Join Ness_Employee_Contract On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
						Where
							Ness_Employees.NessId = @NessId)
			Begin
				-- An update is required
				Print 'Updating contract information for ' +  @LastName + ' ' + @FirstName + '...'
				Update Ness_Employee_Contract
				Set 
					StartDate = @JoinDate,
					EndDate = @EndDate, 
					Rate = @Rate
				Where
					Ness_Employee_Contract.EmployeeId = @EmployeeId
			End
			Else
			Begin
				-- Insert is required
				Insert Into Ness_Employee_Contract (EmployeeId, StartDate, EndDate, Rate)
				Values(@EmployeeId, @JoinDate, @EndDate, @Rate)
			End
		End

		Fetch Next From @NessGMDataCursor   
		Into @FirstName, @LastName, @JoinDate, @BillingStartDate, @BillingEndDate, @Rate, @NessId
	End

	Close @NessGMDataCursor
	Deallocate @NessGMDataCursor
		
End

Go

Declare @SourceTable nvarchar(50)
Declare @ResultValue int

Set @SourceTable = N'TiVo_Data_Raw'
Set @ResultValue = 0

Execute dbo.uspImportDataFromTiVoRaw @SourceTable, @ResultValue;

Set @SourceTable = N'Ness_GM_Import_December'
Set @ResultValue = 0

Execute dbo.uspImportEmployeesFromNessGM @SourceTable, @ResultValue;
Execute dbo.uspImportEmployeeContractsFromNessGM @SourceTable, @ResultValue;


If Object_Id(N'dbo.uspImportEmployeeData_FromMonthlyNessHeadCountReport', N'P') Is Not Null
    Drop Procedure dbo.uspImportEmployeeData_FromMonthlyNessHeadCountReport;
Go

Create Procedure dbo.uspImportEmployeeData_FromMonthlyNessHeadCountReport
	@SourceTable nvarchar(50),
	@Overwrite bit,
	@Result int Out
As
SET NOCOUNT ON
Begin

	Declare @LastName nvarchar(50)
	Declare @FirstName nvarchar(50)
	Declare @Rate Decimal(28,15)
	Declare @NessId nvarchar(10)
	Declare @TaxExempt bit
	Declare @EDCPersonalNumber varchar(20)
	Declare @SourceSQL nvarchar(500)
	Declare @MonthlyDataCursor Cursor
	
	Set @Result = 0
	
	Set @SourceSQL = N'Set @MonthlyDataCursor = Cursor Local Read_Only Forward_Only Static For Select '
	Set @SourceSQL += N'F3, '
	Set @SourceSQL += N'F4, '
	Set @SourceSQL += N'F10 As Rate, '
	Set @SourceSQL += N'Cast(Cast(F11 as int) as varchar(10)) As NessId, '
	Set @SourceSQL += N'Case When F12 = ''yes'' then 1 else 0 End As IsTaxExempt, '
	Set @SourceSQL += N'F13 As EDCPersonalNumber '
	Set @SourceSQL += N'From ' + @SourceTable 
	Set @SourceSQL += N'; \
	Open @MonthlyDataCursor;'

	Execute sp_executesql @SourceSQL, N'@MonthlyDataCursor CURSOR OUTPUT', @MonthlyDataCursor Output
	
	Fetch Next From @MonthlyDataCursor   
	Into @LastName, @FirstName, @Rate, @NessId, @TaxExempt, @EDCPersonalNumber

	While @@FETCH_STATUS = 0  
	Begin
		Declare @RecordCount int

		Set @RecordCount = 0

		Select @RecordCount = Count(*) From Imported_Employees Where Ness_ID = @NessId
		
		If @RecordCount = 0
		Begin
			Print 'Adding user ' + @LastName + ' ' + @FirstName + '(' + @NessId + ')'
			
			Insert Into Imported_Employees (LastName, FirstName, [Bill Rate], Ness_ID, Tax_ext, [New Tivo])
			Values(@LastName, @FirstName, @Rate, @NessId, @TaxExempt, @EDCPersonalNumber)
		End
		Else
		Begin
			Set @Result = 1
		End

		Fetch Next From @MonthlyDataCursor   
		Into @LastName, @FirstName, @Rate, @NessId, @TaxExempt, @EDCPersonalNumber
	End

	Close @MonthlyDataCursor
	Deallocate @MonthlyDataCursor
		
End

Go


If Object_Id(N'dbo.ufnEmployeeTimesheetDetails', N'TF') Is Not Null
    Drop Function dbo.ufnEmployeeTimesheetDetails;
Go

Create Function dbo.ufnEmployeeTimesheetDetails(@EmployeeTiVoID nvarchar(20), @HoursInMonth Int, @InvoiceMonth int, @InvoiceYear int)
Returns @retTimesheetDetails Table
(
    -- Columns returned by the function
    Id int Identity Primary Key Not Null, 
	ContractorNumber nVarChar(20) Null, 
    EntryDate datetime null,
	PONumber float null,
	ProjectNumber nvarchar(255) null,
	TaskNumber nvarchar(255) null,
	HoursLogged float null,
	IsWeekend bit null,
	IsMissing bit not null default(1)
)
AS 
Begin
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime
	Declare @CurrentDay datetime
	Declare @IsWeekend bit
	Declare @MonthDays int
	Declare @ContractorNumber nVarChar(20)
	Declare @EntryDate datetime
	Declare @PoNumber float
	Declare @ProjectNumber nvarchar(255)
	Declare @TaskNumber nvarchar(255)
	Declare @WorkedHours float
	Declare @TotalHours float

	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(@InvoiceYear as varchar(4)) + '-01-01' )
	Set @EndOfMonth = EOMonth(@BeginingOfMonth)
	Set @MonthDays = DATEDIFF(day, @BeginingOfMonth, @EndOfMonth)
	Set @CurrentDay = @BeginingOfMonth
	Set @IsWeekend = Case When (DateName(Weekday, @CurrentDay) = 'Saturday' Or DateName(Weekday, @CurrentDay) = 'Sunday') Then 1 Else 0 End

	-- Create entries for all the days in the month
	While @MonthDays >= 0
	Begin

		Insert into @retTimesheetDetails (EntryDate, IsWeekend) Values(@CurrentDay, @IsWeekend)

		Set @CurrentDay = DateAdd(day, 1, @CurrentDay)
		Set @IsWeekend = Case When (DateName(Weekday, @CurrentDay) = 'Saturday' Or DateName(Weekday, @CurrentDay) = 'Sunday') Then 1 Else 0 End
		Set @MonthDays = @MonthDays - 1
	End

	-- Update the timesheet
	DECLARE TiVoTimesheetCursor CURSOR FOR   
	SELECT 
		Cast(Cast([Contractor Number] as int) as nvarchar(20)), 
		--Max([Contractor Name]), 
		[Time Entry Date], 
		Max([Po Number]), 
		[Project Number], 
		[Task Number], 
		Sum([Worked Hours])
	From 
		TiVo_Data
	Where 
		Cast(Cast([Contractor Number] as int) as nvarchar(20)) = @EmployeeTiVoID
		And [Time Entry Date] >= @BeginingOfMonth
		And [Time Entry Date] <= @EndOfMonth
	Group By
		[Time Entry Date], [Contractor Number], [Project Number], [Task Number]

	Open TiVoTimesheetCursor
	
	Fetch Next From TiVoTimesheetCursor   
	Into @ContractorNumber, @EntryDate, @PoNumber, @ProjectNumber, @TaskNumber, @WorkedHours

	While @@FETCH_STATUS = 0
	Begin
		Update @retTimesheetDetails Set 
			ContractorNumber = @ContractorNumber,
			PONumber = @PoNumber, 
			ProjectNumber =  @ProjectNumber,
			TaskNumber = @TaskNumber,
			HoursLogged = @WorkedHours,
			IsMissing = 0
		Where 
			EntryDate = @EntryDate
	
		Fetch Next From TiVoTimesheetCursor   
		Into @ContractorNumber, @EntryDate, @PoNumber, @ProjectNumber, @TaskNumber, @WorkedHours
	End

	CLOSE TiVoTimesheetCursor;  
	DEALLOCATE TiVoTimesheetCursor; 
	
	Select @TotalHours = Sum(HoursLogged) 
	From @retTimesheetDetails 
	Group By ContractorNumber
	Insert into @retTimesheetDetails (ContractorNumber, HoursLogged, IsWeekend) Values(N'Total ' + @ContractorNumber, @TotalHours, 0)

	Return;
End

Go

If Object_Id(N'dbo.ufnMonthlyTimesheetDetails', N'TF') Is Not Null
    Drop Function dbo.ufnMonthlyTimesheetDetails;
Go

Create Function dbo.ufnMonthlyTimesheetDetails(@HoursInMonth Int, @InvoiceMonth int, @InvoiceYear int)
Returns @retTimesheetDetailsGlobal Table
(
    -- Columns returned by the function
    Id int Identity Primary Key Not Null, 
	ContractorNumber nVarChar(20) Null, 
	ContractorNumberText nVarChar(20) Null, 
	ContractorName nvarchar(255) null,
    EntryDate datetime null,
	PONumber float null,
	ProjectNumber nvarchar(255) null,
	TaskNumber nvarchar(255) null,
	HoursLogged float null,
	IsWeekend bit null,
	IsMissing bit not null default(1)
)
AS 
Begin
	Declare @CurrentEmployeeId float
	Declare @ContractorName nvarchar(255)
	Declare @BeginingOfMonth datetime
	Declare @EndOfMonth datetime

	Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(@InvoiceYear as varchar(4)) + '-01-01' )
	Set @EndOfMonth = EOMonth(@BeginingOfMonth)

	DECLARE TiVoTimesheetCursorGlobal CURSOR FOR   
	SELECT [Contractor Number], Max([Contractor Name])
	From 
		TiVo_Data With(NoLock)
			Inner Join Ness_Employees With(NoLock) On Cast(Cast(TiVo_Data.[Contractor Number] as int) as varchar(20)) = Ness_Employees.EDCPersonalNumber
			Inner Join Ness_Employee_Contract With(NoLock) On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
	Where
		Ness_Employee_Contract.StartDate <= @EndOfMonth
		And (Ness_Employee_Contract.EndDate Is Null Or Ness_Employee_Contract.EndDate > @BeginingOfMonth)
	Group By 
		[Contractor Number]

	Open TiVoTimesheetCursorGlobal
	
	Fetch Next From TiVoTimesheetCursorGlobal Into @CurrentEmployeeId, @ContractorName

	While @@FETCH_STATUS = 0
	Begin
		Insert Into @retTimesheetDetailsGlobal (
			ContractorNumber, 
			ContractorNumberText,
			ContractorName,
			EntryDate ,
			PONumber ,
			ProjectNumber ,
			TaskNumber ,
			HoursLogged,
			IsWeekend,
			IsMissing)
		Select 
			Cast(Cast(@CurrentEmployeeId as int) as varchar(20)),
			Case WHen ContractorNumber Is Null Then Cast(Cast(@CurrentEmployeeId as int) as varchar(20)) Else ContractorNumber End,
			Case When ContractorNumber = 'Total ' + Cast(Cast(@CurrentEmployeeId as int) as varchar(20)) Then '' Else @ContractorName End,
			EntryDate,
			PONumber,
			ProjectNumber,
			TaskNumber,
			HoursLogged,
			IsWeekend,
			IsMissing 
		From 
			dbo.ufnEmployeeTimesheetDetails(Cast(Cast(@CurrentEmployeeId as int) as varchar(20)), @HoursInMonth, @InvoiceMonth, @InvoiceYear)
		Where 
			IsWeekend = 0
		
		Fetch Next From TiVoTimesheetCursorGlobal Into @CurrentEmployeeId, @ContractorName
	End

	Close TiVoTimesheetCursorGlobal
	Deallocate TiVoTimesheetCursorGlobal

	return;
End

Go

Print 'MUST IMPORT THE FILES THAT ARE NAMED LIKE THIS TREC-HC-16Jan18-salarii'
Print 'After that operation is done execute the script uspImportEmployeeData_FromMonthlyNessHeadCountReport as many times as it is necessary.'
Print 'Bellow you have an example that WILL NOT WORK unless data is imported'

Begin
Declare @SourceTable nvarchar(50)
Declare @ResultValue int

Set @SourceTable = N'TREC_HC_Feb18'
Set @ResultValue = 0

Execute dbo.uspImportEmployeeData_FromMonthlyNessHeadCountReport @SourceTable, 1, @ResultValue;

Set @SourceTable = N'TREC_HC_Jan18'
Set @ResultValue = 0

Execute dbo.uspImportEmployeeData_FromMonthlyNessHeadCountReport @SourceTable, 1, @ResultValue;

Set @SourceTable = N'TREC_HC_Dec17'
Set @ResultValue = 0

Execute dbo.uspImportEmployeeData_FromMonthlyNessHeadCountReport @SourceTable, 1, @ResultValue;

Set @SourceTable = N'TREC_HC_Nov17'
Set @ResultValue = 0

Execute dbo.uspImportEmployeeData_FromMonthlyNessHeadCountReport @SourceTable, 1, @ResultValue;

Set @SourceTable = N'TiVo_Timesheet_February'
Set @ResultValue = 0

Execute dbo.uspImportDataFromTiVoTimesheet @SourceTable, @ResultValue;
End