--Select Ness.dbo.ufnGetEmployeeHoursInMonth(33, 1)
-- Select * From Ness_Employees

--Select * From TiVo_Data Where [Time Entry Date] >= Cast('2018-02-01 00:00:01.00' as datetime)
-- Select X = dbo.ufnGetEmployeeHoursInMonth(2, 2, 2018)

Declare @InvoiceMonth int
Declare @InvoiceYear int
Declare @BillableHours int
Declare @TimesheetHours int
Declare @BeginingOfMonth datetime
Declare @EndOfMonth datetime

Set @BillableHours = 160
Set @TimesheetHours = 160
Set @InvoiceMonth = 2
Set @InvoiceYear = 2018
Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(@InvoiceYear as varchar(4)) + '-01-01' )
Set @EndOfMonth = EOMonth(@BeginingOfMonth)

/*
Select 
	EmployeeId, ShortText, OldPONumber, LastName, FirstName, ContractorNumber, HourlyRate, HoursLogged, LineAmount, Project, Task, Comments
from dbo.ufnGetInvoiceRawData(@TimesheetHours, @BillableHours, @InvoiceMonth, @InvoiceYear) 
Where 
	Not (Project = 'SAP 1082' And Task = '003')
	And Not (Project = 'SAP 1173' And Task = '003')
Order By LastName

*/

/*
Select 
	LastName, FirstName, ContractorNumber, HourlyRate, HoursMissing, 
	--HoursWorked, 
	Case When LineAmount Is Null Then (SELECT Min(a) FROM (VALUES (HoursMissing), (@BillableHours)) as myTable(a)) * HourlyRate Else LineAmount End
from 
	dbo.ufnGetMissingInvoiceInfo(@BillableHours, @InvoiceMonth, @InvoiceYear) 
Where 
	HoursMissing != 0 or 
	HoursMissing is null

*/

-- Contracts that expire during the @InvoiceMonth
/*
Select * 
From
	Ness_Employees
		inner join Ness_Employee_Contract on Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where
	Ness_Employee_Contract.EndDate <= @EndOfMonth And Ness_Employee_Contract.EndDate >= @BeginingOfMonth
*/


/*
Select 
	ContractorNumber, 
    EntryDate ,
	PONumber ,
	ProjectNumber ,
	TaskNumber ,
	HoursLogged,
	IsMissing
From dbo.ufnEmployeeTimesheetDetails('4040', @BillableHours, @InvoiceMonth, @InvoiceYear)
Where IsWeekend = 0
*/
Select 
	ContractorNumberText, 
	ContractorName, 
    EntryDate ,
	PONumber ,
	ProjectNumber ,
	TaskNumber ,
	HoursLogged,
	IsMissing
From 
	dbo.ufnMonthlyTimesheetDetails(@BillableHours, @InvoiceMonth, @InvoiceYear)
		Left Join Ness_Employees With(NoLock) On Ness_Employees.EDCPersonalNumber = ContractorNumber
Where IsWeekend = 0
Order By 
	Ness_Employees.LastName

-- Contracts that are active during @InvoiceMonth
/*
Select * 
From
	Ness_Employees
		inner Join Ness_Employee_Contract on Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where
	Ness_Employee_Contract.EndDate > @EndOfMonth Or Ness_Employee_Contract.EndDate Is Null
Order By
	LastName
*/