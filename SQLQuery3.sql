-- Use Ness

Create Or Alter Function Generate_Invoice_Table(@TableName nvarchar(50))
Returns Table
With Execute As Caller
As
Begin
Return (
	Select 
		349926 As OldPONumber,
		Ness.dbo.Ness_Employees.FirstName, 
		Ness.dbo.Ness_Employees.LastName,
		Ness.dbo.Ness_Employees.NessId,
		Ness.dbo.Ness_Employees.EDCPersonalNumber,
		LevelName,
		LevelDescription
	From Ness.dbo.Ness_Employees
		Left Join Ness_Employee_Level On Ness_Employee_Level.EmployeeId = Ness.dbo.Ness_Employees.Id
		Left Join Ness_Levels On Ness_Levels.Id = Ness.dbo.Ness_Employee_Level.LevelId)
End