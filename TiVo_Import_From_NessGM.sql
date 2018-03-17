-- Select * From TiVo_Data_Raw Where [Personnel Id] = '3952' Order By [Expenditure Date]
-- Select * From TiVo_Data Where [Contractor Number] = '3952' Order By [Time Entry Date]
-- Select * From Ness_EDC
Select * From Ness_GM_Import_December 
Where
(F1 = 'SES_TIVO' Or F1 = 'SES_Tivo')
-- F15 > F14

Select * From Ness_Employee_Contract

/*
Insert Into Ness_Employees (FirstName, LastName, NessId, EDCId, IsTaxExempt, EDCPersonalNumber)
Select 
	value as tag,
	*
From
	Ness_GM_Import_December CROSS APPLY  STRING_SPLIT(F5, ' ')
	*/

