-- This inert will "convert" data used by TiVo finance to the "standard" used in this DB

Delete from TiVo_Data

Insert Into TiVo_Data (
	[Supplier Number],		-- ok
	[Supplier Name],		-- ok
	[Contractor Number],	-- ok
	[Contractor Name],		-- ok
	[Supervisor Name],		-- ok
	[Time Entry Date],		-- ok
	[Po Number],			-- ok
	[Project Number],		-- ok
	[Project Name],			-- ok
	[Task Number],			-- ok
	[Task Name],			-- ok
	[Approver Name],		-- ok
	[Approved Date],		-- ok
	[Contractor Start Date],-- ok
	[Contractor End Date],	-- ok
	[Expenditure Type],		-- ok
	[Organization Name],	-- ok
	[Hours Type],			-- ok
	[Worked Hours],			-- ok
	[UOM],					-- ok
	[Contractor Rate],		-- ok
	[Invoice Number],		-- ok
	[Invoice Line Num],
	[Invoice Line Date],
	[Total Inv Amount],
	[Comments],
	[Actual Worked Hours (if different from Worked Hours)])

	Select 
	[Vendor Number],		-- [Supplier Number]
	[Vendor Name],			-- [Supplier Name]
	[Personnel Id],			-- [Contractor Number]
	[Personnel Name],		-- [Contractor Name]
	Null,					-- [Supervisor Name]
	[Expenditure Date],		-- [Time Entry Date]
	[PO Number],			-- [Po Number]
	[Project Number],		-- [Project Number]
	[Project Name],			-- [Project Name]
	[Task Number],			-- [Task Number]
	[Task Name],			-- [Task Name]
	Null,					-- [Approver Name]
	Null,					-- [Approved Date]
	Null,					-- [Contractor Start Date]
	Null,					-- [Contractor End Date]
	[Expenditure Type],		-- [Expenditure Type]
	[Project Organization],	-- [Organization Name]
	Null,					-- [Hours Type]
	[Quantity],				-- [Worked Hours]
	[UOM],					-- [UOM]
	Null,					-- [Contractor Rate]
	[Invoice Number],		-- [Invoice Number]
	Null, -- Invoice line num
	Null, -- Invoice line date
	Null, -- total invoice amount
	Null, -- comments
	Null -- Actual worked hours
	From 
	TiVo_Data_Raw