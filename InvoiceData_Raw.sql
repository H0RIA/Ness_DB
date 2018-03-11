--Select Ness.dbo.ufnGetEmployeeHoursInMonth(33, 1)
select 
Max(Ness.dbo.Ness_Employees.LastName) as LastName
		,Max(Ness.dbo.Ness_Employees.FirstName) as FirstName
 from 
ness_employees 
	left join Ness_Employee_Contract on Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
	left join TiVo_Data on TiVo_Data.[Contractor Number] = Ness_Employees.EDCPersonalNumber
where 
		(Ness_Employee_Contract.EndDate >= Cast('2018-01-01 00:00:00.000' as datetime) Or Ness_Employee_Contract.EndDate Is Null)
		And ([Time Entry Date] >= Cast('2018-01-01 00:00:00.000' as datetime) And [Time Entry Date] <= Cast('2018-01-31 00:00:00.000' as datetime))
		Or Ness_Employees.EDCPersonalNumber Is Null 
		Or Ness_Employees.EDCPersonalNumber Is Not Null
		--And lastname = 'Anuta'
		--And ([Project Number] Not In ('SAP 1082') or [Project Number] Is Null)
		--And ([Task Number] Not In ('003') Or [Task Number] Is Null)
	Group By
		Ness_Employees.Id
		,Ness.dbo.TiVo_Data.[Contractor Number]

Select 
	EmployeeId, ShortText, OldPONumber, LastName, FirstName, ContractorNumber, HourlyRate, HoursLogged, LineAmount, Project, Task, Comments
from dbo.ufnGetInvoiceRawData(184, 160, 1) 
Where 
	Not (Project = 'SAP 1082' And Task = '003')
	And Not (Project = 'SAP 1173' And Task = '003')
--	Or Project Is Null
Order By LastName
--Where LastName = 'Antohi'
Select * from dbo.ufnGetMissingInvoiceInfo(184, 1) 
Where 
HoursMissing != 0 or 
HoursMissing is null

-- Select dbo.ufnGetEmployeeComments(18, 1, 184, 160)
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
	Ness_Employees.LastName = 'Lescai'
Order By Ness_Employee_Contract.EndDate
*/

--Update Ness_Employees set EDCPersonalNumber = 5197 where id = 79
--Update Ness_Employee_Contract set StartDate = Cast('2018-01-15 01:0:00.000' as datetime) where id = 1216
