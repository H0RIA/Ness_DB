--Select Ness.dbo.ufnGetEmployeeHoursInMonth(33, 1)

Select 
	EmployeeId, ShortText, OldPONumber, LastName, FirstName, ContractorNumber, HourlyRate, HoursLogged, LineAmount, Project, Task, Comments
from dbo.ufnGetInvoiceRawData(184, 160, 1) 
Where 
	Not (Project = 'SAP 1082' And Task = '003')
	And Not (Project = 'SAP 1173' And Task = '003')
Order By LastName

Select * 
From Ness_Employees 
	Inner Join Ness_Employee_Contract On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where
	Ness_Employees.Id = 45
Order By LastName

Declare @BillableHours int
Set @BillableHours = 160

Select 
	LastName, FirstName, ContractorNumber, HourlyRate, HoursMissing, HoursWorked, 
	Case When LineAmount Is Null Then (SELECT Min(a) FROM (VALUES (HoursMissing), (@BillableHours)) as myTable(a)) * HourlyRate Else LineAmount End
from 
	dbo.ufnGetMissingInvoiceInfo(184, 1) 
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

--Update Ness_Employees set EDCPersonalNumber = 5197 where id = 79
--Update Ness_Employee_Contract set StartDate = Cast('2018-01-15 01:0:00.000' as datetime) where id = 1216
