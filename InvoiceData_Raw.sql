--Select Ness.dbo.ufnGetEmployeeHoursInMonth(33, 1)

Select 
	ShortText, OldPONumber, LastName, FirstName, ContractorNumber, HourlyRate, HoursLogged, LineAmount, Project, Task
from dbo.ufnGetInvoiceRawData(184, 160, 1) 
Where 
	(Project != 'SAP 1082' or Project Is Null)
	And (Task != '003' or Task Is Null)
Order By LastName
--Where LastName = 'Antohi'
Select * from dbo.ufnGetMissingInvoiceInfo(184, 1) 
Where HoursMissing != 0 
or HoursMissing is null

-- Select dbo.ufnGetEmployeeHoursInMonth(75, 1) as mata




Select * From TiVo_Data 
Where 
	[Contractor Name] like '%Zaha%' 
	And [Time Entry Date] >= '2018-01-01 00:00:00.000'
	And [Time Entry Date] <= '2018-01-31 00:00:00.000'
Order By [Time Entry Date]
/*
Select * from ness_employees
left outer join Ness_Employee_Contract on Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where 
	--Ness_Employee_Contract.EndDate Is Not Null
	Ness_Employees.LastName = 'Streba'
Order By Ness_Employee_Contract.EndDate
*/

--Update Ness_Employees set EDCPersonalNumber = 5130 where id = 73
--Update Ness_Employee_Contract set StartDate = Cast('2018-01-15 01:0:00.000' as datetime) where id = 1216
