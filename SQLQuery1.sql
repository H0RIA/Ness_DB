/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT * FROM [Ness].[dbo].['TREC-empls$']
-- Select * From 	[Ness].[dbo].['TREC-empls$'] where LastName = 'Popa'
--SELECT * FROM [Ness].[dbo].[TiVo_Data]
-- Select * From Ness_Employees

/*
Delete From Ness.dbo.Ness_Employees

Insert Into Ness.dbo.Ness_Employees (
	FirstName, 
	LastName, 
	NessId,
	IsTaxExempt, 
	EDCPersonalNumber,
	EDCId)
Select 
	FirstName, 
	LastName, 
	Cast(Cast(Ness_ID as int) as nvarchar(20)),
	Taxat = Case Tax_ext when 'yes' then 1 else 0 end,
	[New Tivo],
	EDC_Id = (Select Id From Ness_EDC Where EDCName = N'SES_TiVo')
From 
	[Ness].[dbo].['TREC-empls$']

Delete From Ness.dbo.Ness_Employee_Level

Insert Into Ness.dbo.Ness_Employee_Level (
	EmployeeId, 
	StartDate, 
	EndDate,
	LevelId)
Select 
	(Select Id From Ness_Employees Where Ness_Employees.FirstName = Source.FirstName and Ness_Employees.LastName = Source.LastName), 
	GETDATE(), 
	Null,
	(Select Id From Ness_Levels Where Ness_Levels.LevelName = Source.Level)
From 
	[Ness].[dbo].['TREC-empls$'] As Source


*/

Declare @HoursInMonth Decimal(28,15)
Set @HoursInMonth = 160

Declare @ShortText varchar(50)
Set @ShortText = 'Service Period Jan 18'

Select 
	@ShortText
	,349926 As OldPONumber
	,Max(Ness.dbo.TiVo_Data.[Contractor Name])
	,Max(Ness.dbo.Ness_Employees.LastName) as LastName
	,Max(Ness.dbo.Ness_Employees.FirstName) as FirstName
	,Ness.dbo.TiVo_Data.[Contractor Number]
	,(Case When Max(Ness_Employee_Contract.Rate) Is Null Then 0 Else Max(Ness_Employee_Contract.Rate) End / @HoursInMonth) As [Hourly Rate]
	,Sum(TiVo_Data.[Worked Hours]) As [Hours Worked]
	,Case When Max(Ness_Employee_Contract.Rate) Is Null Then 0 Else Max(Ness_Employee_Contract.Rate) End As [Monthly Rate]
	,TiVo_Data.[Project Number] As Project
	,TiVo_Data.[Task Number] As Task
	
From Ness.dbo.TiVo_Data
	Left Join Ness_Employees On TiVo_Data.[Contractor Number] = Ness_Employees.EDCPersonalNumber
	Left Join Ness_Employee_Contract On Ness_Employee_Contract.EmployeeId = Ness_Employees.Id
	Left Join Ness_Contract_Salaries On Ness_Contract_Salaries.ContractId = Ness_Employee_Contract.Id
Where
	--[Project Number] != 'SAP 1082'
	--And [Task Number] != '003'
	(Ness_Employee_Contract.EndDate Is Null Or Ness_Employee_Contract.EndDate > GetDate())
Group By
	Ness.dbo.TiVo_Data.[Contractor Number]
	,TiVo_Data.[Project Number]
	,TiVo_Data.[Task Number]
Order By
	Max(LastName)
	--, FirstName