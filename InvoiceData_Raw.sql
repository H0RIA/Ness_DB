Select Ness.dbo.ufnGetEmployeeHoursInMonth(33, 1)
Select * from dbo.ufnGetInvoiceRawData(184, 1) 
--Where LastName = 'Antohi'
Select * from dbo.ufnGetMissingInvoiceInfo(184, 1) 
Where HoursMissing > 0 or HoursMissing is null

Select * from ness_employees
left outer join Ness_Employee_Contract on Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where 
	--Ness_Employee_Contract.EndDate Is Not Null
	Ness_Employees.LastName = 'Abramiuc'
Order By Ness_Employee_Contract.EndDate


--Update Ness_Employee_Contract set EndDate = Cast('2018-03-22 01:0:00.000' as datetime) where id = 1178