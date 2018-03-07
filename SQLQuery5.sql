-- Select * From Ness_Employees Where LastName = 'Anuta'
-- Select * From Ness_Employee_Contract Where EmployeeId = 12

Declare @HoursInMonth Decimal(28,15)
Set @HoursInMonth = 160

Declare @ShortText varchar(50)
Set @ShortText = 'Service Period Jan 18'

Select 
	@ShortText
	,349926 As OldPONumber
	,Max(Ness.dbo.TiVo_Data.[Contractor Name]) As [Contractor Name]
	,Max(Ness.dbo.Ness_Employees.LastName) as LastName
	,Max(Ness.dbo.Ness_Employees.FirstName) as FirstName
	,Ness.dbo.TiVo_Data.[Contractor Number]
	,(Case When Max(Ness_Employee_Contract.Rate) Is Null Then 0 Else Max(Ness_Employee_Contract.Rate) End / @HoursInMonth) As [Hourly Rate]
	,Sum(TiVo_Data.[Worked Hours]) As [Hours Worked]
	,Case When Max(Ness_Employee_Contract.Rate) Is Null Then 0 Else (Max(Ness_Employee_Contract.Rate) * Sum(TiVo_Data.[Worked Hours])) / @HoursInMonth End As LineAmount
	,TiVo_Data.[Project Number] As Project
	,TiVo_Data.[Task Number] As Task
From 
	Ness_Employees
		Left Join Ness_Employee_Contract on Ness_Employee_Contract.EmployeeId = Ness_Employees.Id
		Left Join TiVo_Data On TiVo_Data.[Contractor Number] = Ness_Employees.EDCPersonalNumber
		Left Join Ness_Contract_Salaries On Ness_Contract_Salaries.ContractId = Ness_Employee_Contract.Id
Where
	Ness_Employee_Contract.EndDate Is Null
	And ([Project Number] Not In ('SAP 1082') or [Project Number] Is Null)
	And ([Task Number] Not In ('003') Or [Task Number] Is Null)
Group By
	Ness_Employees.Id
	,Ness.dbo.TiVo_Data.[Contractor Number]
	,TiVo_Data.[Project Number]
	,TiVo_Data.[Task Number]
Order By
	Max(LastName)