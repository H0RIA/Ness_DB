-- Most used queries
Use Ness

-- 1 Get current rate card for employee
Declare @LastName varchar(50)
Set @LastName = 'Tabaranu'

Select 
	LastName, FirstName, Rate
From
	Ness_Employees
		Inner Join Ness_Employee_Contract On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where
	Ness_Employees.LastName = @LastName