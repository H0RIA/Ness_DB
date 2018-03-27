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
Declare @HoursInMonth int

Set @BillableHours = 160
Set @HoursInMonth = 160
Set @TimesheetHours = 160
Set @InvoiceMonth = 2
Set @InvoiceYear = 2018
Set @BeginingOfMonth = DateAdd( month , @InvoiceMonth - 1 , Cast(@InvoiceYear as varchar(4)) + '-01-01' )
Set @EndOfMonth = EOMonth(@BeginingOfMonth)


-- Select * From TiVo_Data Where [Contractor Number] = '4035' Order By [Time Entry Date]
-- First tab (invoice data)

Select 
	Ness_Employees.NessId,
	Smen.EmployeeId, 
	Smen.ShortText, 
	Smen.PoNumber, 
	Smen.LastName, 
	Smen.FirstName, 
	Smen.ContractorNumber, 
	Smen.HourlyRate, 
	Smen.HoursLogged, 
	Smen.LineAmount, 
	Smen.Project, 
	Smen.Task, 
	Smen.Comments
from 
	dbo.ufnGetInvoiceRawData(@TimesheetHours, @BillableHours, @InvoiceMonth, @InvoiceYear)  As Smen
		Inner Join Ness_Employees On Ness_Employees.EDCPersonalNumber = ContractorNumber
Where 
	Not (Project = 'SAP 1082' And Task = '003')
	And Not (Project = 'SAP 1173' And Task = '003')
Order By 
	LastName


-- Second tab - missing hours
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
Order By LastName
*/

-- Third tab - TiVo timesheet checked
/*
Select 
	ContractorNumberText, 
	ContractorName, 
    EntryDate ,
	PONumber ,
	ProjectNumber ,
	TaskNumber ,
	HoursLogged,
	IsMissingOrIncomplete
From 
	dbo.ufnMonthlyTimesheetDetails(@BillableHours, @InvoiceMonth, @InvoiceYear)
		Left Join Ness_Employees With(NoLock) On Ness_Employees.EDCPersonalNumber = ContractorNumber
Where IsWeekend = 0
Order By 
	Ness_Employees.LastName

*/
-- Third tab - TiVo timesheet checked - only missing hours - Nu merge cum trebuie
/*
Select 
	ContractorNumber, 
	ContractorName, 
    EntryDate
From 
	dbo.ufnMonthlyTimesheetDetails(@BillableHours, @InvoiceMonth, @InvoiceYear)
		Left Join Ness_Employees With(NoLock) On Ness_Employees.EDCPersonalNumber = ContractorNumber
Where 
	IsWeekend = 0
	And IsMissing = 1
	And EntryDate iS not null
Order By 
	Ness_Employees.LastName
*/

/*
-- Fourth tab - Subsidy discount (pro rated)
Select 
	Max(OrganizationName) As Area,
	Max(Ness_Employees.LastName) As [Last Name], 
	Max(Ness_Employees.FirstName) As [First Name],
	'' As Position,
	Max(Ness_Employee_Contract.StartDate) As [Start date],
	'350940' As PO,
	Max(Ness_Employee_Contract.Rate) As [Bill rate],
	Max(Ness_Employees.EDCPersonalNumber) As TiVo_ID,
	--Case When Ness_Employee_Contract.IsFlex = 0 Then 1 Else 0 End As Core,
	Sum(HoursLogged)
From
	Ness_Employees
		inner Join Ness_Employee_Contract on Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
		inner join dbo.ufnGetInvoiceRawData(@TimesheetHours, @BillableHours, @InvoiceMonth, @InvoiceYear) On Ness_Employees.EDCPersonalNumber = ContractorNumber
		--Inner Join TiVo_Data On Cast(cast(TiVo_Data.[Contractor Number] as int) as varchar(20)) = Ness_Employees.EDCPersonalNumber
--Where
	--(TiVo_Data.[Time Entry Date] >= @BeginingOfMonth And TiVo_Data.[Time Entry Date] <= @EndOfMonth)
	--And (Ness_Employee_Contract.EndDate > @BeginingOfMonth Or Ness_Employee_Contract.EndDate Is Null)

Group By
	Ness_Employees.Id
Order By
	Max(OrganizationName)
	,Max(Ness_Employees.LastName)

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

-- Contracts that are active during @InvoiceMonth

/*
Select 
	LastName, FirstName, EDCPersonalNumber, Rate
From
	Ness_Employees
		inner Join Ness_Employee_Contract on Ness_Employees.Id = Ness_Employee_Contract.EmployeeId
Where
	Ness_Employee_Contract.EndDate > @BeginingOfMonth Or Ness_Employee_Contract.EndDate Is Null
Order By
	LastName
	*/

