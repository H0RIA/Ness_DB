--Select Ness.dbo.ufnGetEmployeeHoursInMonth(33, 1)
-- Select * From TiVo_Timesheet_February
Select
*
From
	Ness_Employees
		Left Join Ness_Employee_Contract On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where
	Ness_Employees.LastName = 'Lazar-Zahacinschi'

Select 
	EmployeeId, ShortText, OldPONumber, LastName, FirstName, ContractorNumber, HourlyRate, HoursLogged, LineAmount, Project, Task, Comments
from dbo.ufnGetInvoiceRawData(160, 160, 1) 
Where 
	Not (Project = 'SAP 1082' And Task = '003')
	And Not (Project = 'SAP 1173' And Task = '003')
Order By LastName


Declare @BillableHours int
Set @BillableHours = 160

Select 
	LastName, FirstName, ContractorNumber, HourlyRate, HoursMissing, 
	--HoursWorked, 
	Case When LineAmount Is Null Then (SELECT Min(a) FROM (VALUES (HoursMissing), (@BillableHours)) as myTable(a)) * HourlyRate Else LineAmount End
from 
	dbo.ufnGetMissingInvoiceInfo(184, 1, 2018) 
Where 
	HoursMissing != 0 or 
	HoursMissing is null

-- Select dbo.ufnGetEmployeeComments(18, 1, 184, 160)
-- Select dbo.ufnGetEmployeeHoursInMonth(75, 1) as mata

/*
Select * from ness_employees
left outer join Ness_Employee_Contract on Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where 
	--Ness_Employee_Contract.EndDate Is Not Null
	Ness_Employees.LastName = 'Lescai'
Order By Ness_Employee_Contract.EndDate
*/
