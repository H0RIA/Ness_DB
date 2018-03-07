-- Most used queries
Use Ness

-- 1 Get current rate card for employee
Declare @LastName varchar(50)
Set @LastName = 'Adomnicai'

Select 
	LastName, FirstName, Rate, *
From
	Ness_Employees
		Left Join Ness_Employee_Contract On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where
	Ness_Employees.LastName = @LastName

-- 2 Get all employees in TREC
Declare @IsActive bit

Set @IsActive = 1

Select * 
From
	Ness_Employees With(NoLock)
		Inner Join Ness_Employee_Contract With(NoLock) On Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where
	--Case When @IsActive = 1 
	--Then (
	Ness_Employee_Contract.EndDate > GetDate() Or Ness_Employee_Contract.EndDate Is Null
	--Else (Ness_Employee_Contract.EndDate Is Null or  Ness_Employee_Contract.EndDate Is Not Null) End