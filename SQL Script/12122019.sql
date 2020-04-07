--USE [master]
--GO
--EXEC sp_dropserver
--@server = 'Excelserver',
--@droplogins='droplogins'
--GO
--EXEC master.dbo.sp_addlinkedserver @server = N'Excelserver', @srvproduct=N'Excel', @provider=N'Microsoft.ACE.OLEDB.12.0', @datasrc=N'F:\COS Files\Test Report.xlsx', @provstr=N'Excel 12.0;IMEX=1;HDR=YES;'
--EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'Excelserver',@useself=N'False',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
--EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'Excelserver',@useself=N'True',@locallogin=N'CALTEK\vikram.mgmt',@rmtuser=NULL,@rmtpassword=NULL
--GO
--SELECT * FROM OPENQUERY(Excelserver, 'SELECT * FROM [Sheet1$]')
--select * from FocusData
--Select * into Focusdata FROM OPENROWSET(Excelserver, 'SELECT * FROM [Sheet1$]')
--select * from sys.servers where name='Excelserver2'
--exec sp_addlinkedsrvlogin 'ExcelServer2', 'true'
--select uses_self_credential as delegation from sys.linked_logins as L, sys.servers as S where S.server_id=L.server_id and S.name=N'ExcelServer2'
--select * from ExcelServer2.master.dbo.sysdatabases
--INSERT INTO FocusData select * FROM OPENQUERY(Excelserver, 'SELECT * FROM [Sheet1$]')
--Delete from FocusData

--CREATE PROCEDURE FocusData_InsertOp
--AS
--BEGIN
--INSERT INTO FocusData SELECT * FROM OPENQUERY(ExcelServer, 'SELECT * FROM [Sheet1$]')
--EXEC master.dbo.sp_dropserver @server = @Servername, @droplogins='droplogins'
--END

--	DECLARE @SQL nvarchar(1000)
--	DECLARE @server nvarchar(1000)
--	DECLARE @srvproduct nvarchar(1000)
--	DECLARE @provider nvarchar(1000)
--	DECLARE @datasrc nvarchar(1000)
--	DECLARE @provstr nvarchar(1000)
--    SET @server = 'ExcelServe'
--    SET @srvproduct = 'Excel'
--    SET @provider = 'Microsoft.ACE.OLEDB.12.0'
--	SET @datasrc = 'C:\Users\User\source\repos\PriceCalc\Logistics\Files\Test Report.xlsx'
--	SET @provstr = 'Excel 12.0;IMEX=1;HDR=YES;'
--	EXEC sp_addlinkedserver
--	SELECT * FROM OPENQUERY(ExcelServe, 'SELECT * FROM [Sheet1$]')

--Insert into focusdata SELECT * FROM ExcelServer20191212_205436...[Sheet1$]


--Select Id as ID, CONVERT(Date, [Date Received]) as [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], [Delivery Date], Certification from FocusData ORDER by [Date Received] DESC

--SELECT  
--    name,
--    is_instead_of_trigger
--FROM 
--    sys.triggers  
--WHERE 
--    type = 'TR';

--Select Id as ID, CONVERT(Date, [Date Received]) as [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], CONVERT(Date, [Delivery Date]) as [Delivery Date], Certification from FocusData 
--Where Id NOT IN (Select ProductionID from ProductionPlan) ORDER by [Date Received] DESC 
--select count(*) as Count from FocusData Where ID NOT in (Select ProductionID from ProductionPlan)



--select count(*) as Count from FocusData Where ID in (Select ProductionID from ProductionPlan Where Status = 'Unassigned' And Status = '')

--Select Id as ID, CONVERT(Date, [Date Received]) as [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], CONVERT(Date, [Delivery Date]) as [Delivery Date], Certification from FocusData 
  --                                        Where Id IN (Select ProductionID from ProductionPlan Where Status = 'Unassigned' and Employee=NULL) ORDER by [Date Received] ASC
--DELETE ProductionPlan Where ProductionID = (Select ProductionID from ProductionPlan Where Status = 'Assigned')

--CREATE TABLE [dbo].[ProductionPlan] (
--    [ProductionID] INT NOT NULL,
--    [Date Planned] VARCHAR (50) NOT NULL,
--    PRIMARY KEY CLUSTERED ([ProductionID] ASC),
--    CONSTRAINT [FK_ProductionPlan_ProductionID] FOREIGN KEY ([ProductionID]) REFERENCES [dbo].[FocusData] ([Id])
--);

--CREATE PROCEDURE [dbo].[ProdAssign_Insert]
--	  @Dt ProdPlanType Readonly
--AS
--BEGIN
--		SET NOCOUNT ON;
--		INSERT INTO ProductionPlan(ProductionId, Status, Date)
--		Select ProductionID, Status, Date from @Dt
--		Update ProductionPlan
--		SET Employee = (Select EID from Employee Where concat(Eid,'-',FName,' ',LName) = @Employee) 
--		Where concat(ProductionID,Status,Date) = (Select CONCAT(ProductionID, Status, Date) from @Dt)
--END

--Delete from ProductionPlan
--select * from ProductionPlan
--Delete from FocusData
--select * from FocusData

--select concat(Eid,'-',FName,' ',LName) as Name from Employee Where Department IN (Select DId from Department where Division = 'Technical')

--Select Id as ID, CONVERT(Date, [Date Received]) as [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], CONVERT(Date, [Delivery Date]) as [Delivery Date], Certification from FocusData 
--                                            Where Id IN (Select ProductionID from ProductionPlan) And Id NOT IN (Select ProductionID from ProductionAssigned) ORDER by [Date Received] ASC 
--Delete from ProductionPlan

--select * from ScreenList
--Select ParentName, Rights from ScreenList Where ScreenID NOT IN (select ScreenID from AccessRights Where RoleID IN (Select Role from Usertable Where Username = 'anoopummapilly'))
--select * from FocusData Where ID not in (select ProductionID from ProductionPlan)
--select * from ProductionPlan
--select * from ProductionAssigned
--select * from FocusData Where ID not in (select ProductionID from ProductionPlan)


--Select Id as ID, CONVERT(Date, [Date Received]) as [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], CONVERT(Date, [Delivery Date]) as [Delivery Date], Certification from FocusData 
--                                            Where Id IN (Select ProductionID from ProductionAssigned Where Employee = (select EmpID from Usertable Where Username = 'Vikramsanker')) and ID NOT IN (select ProductionID from Productionstatus where Status = 'Completed')
--                                            select * from ProductionStatus


--Select top 100
--Focusdata.Id, 
--FocusData.Instrument,  
--CONVERT(Date, FocusData.[Date Received]) as [Date Received], 
--FocusData.[Job Number], 
--FocusData.[Client Name], 
--FocusData.Quantity, 
--FocusData.Instrument, 
--FocusData.Department, 
--FocusData.[Serial No], 
--CONVERT(Date, FocusData.[Delivery Date]) as [Delivery Date], 
--FocusData.Certification,
--OVERALL.Status from FocusData JOIN 
--(Select ID AS ID, Status = 'Unplanned' from FocusData Where ID NOT IN (Select ProductionID from ProductionPlan)  UNION
--Select ProductionID as ID, Status = 'Unassigned' from ProductionPlan Where ProductionID NOT IN (Select ProductionID from ProductionAssigned) UNION
--Select ProductionID AS ID, Status = 'Assigned' from ProductionAssigned Where ProductionID NOT IN (Select ProductionID from ProductionStatus) UNION
--Select ProductionID AS ID, Status = 'Certificate' from ProductionStatus Where Status = 'Completed' UNION
--Select ProductionID AS ID, Status = 'On-hold' from ProductionStatus Where Status = 'On-hold') AS OVERALL
--ON FocusData.Id = Overall.ID

--Select Id as ID, CONVERT(Date, [Date Received]) as [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], CONVERT(Date, [Delivery Date]) as [Delivery Date], Certification from FocusData 
--                                            Where Id IN (Select ProductionID from Productionstatus Where Status = 'Completed') and ID NOT IN (select ProductionID from worksheetreception)
                                            
--                                            select count(*) as Count from FocusData Where Id IN (Select ProductionID from ProductionStatus Where Status = 'Completed') and ID NOT IN (select ProductionID from Worksheetreception)


--select * from WorksheetReception
--Delete from ProductionStatus
--select * from ProductionStatus
--Delete from ProductionAssigned
--select * from ProductionAssigned
--Delete from ProductionPlan
--select * from ProductionPlan
--Delete from FocusData
--select * from FocusData

--SELECT * FROM OPENQUERY(ExcelServer20191217_110343, 'SELECT * FROM [Sheet1$]')


--Select top 500 Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
--                                            Where Id NOT IN (Select ProductionID from ProductionPlan) ORDER by [TAT], [Date Received]

--select count(*) as Count from FocusData Where Id IN (Select ProductionID from worksheetreception Where [Allocated To] = (select EmpID from Usertable Where Username = 'Vikramsanker')) and ID NOT IN (select ProductionID from Certificatestatus)
--select * from WorksheetReception


--Select Id as ID, TAT, [Delivery Type], CONVERT(Date, [Date Received]) as [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification, [Certificate To], [Certificate Address] from FocusData 
--                                            Where Id IN (Select ProductionID from worksheetreception Where [Allocated To] = (select EmpID from Usertable Where Username = 'Vikramsanker')) and ID NOT IN (select ProductionID from Certificatestatus) ORDER by [TAT], [Date Received] ASC

--Insert into Sessionlog Select UID from Usertable Where UserName = 'Vikramsanker'


--sELECT * FROM WorksheetReception Where ProductionID = '167'
--Select * from Employee Where Eid = '1030'

--Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Department, [Deliver To], [Delivery Address] from FocusData 
--                                            Where [Delivery Type] = 'Delivery' And Id IN (Select ProductionID from CertificateStatus) And Id NOT IN (Select ProductionID from Deliveryplan) ORDER by [TAT], [Date Received] ASC 



--select count(*) as Count from FocusData Where [Delivery Type] = 'Delivery' And ID in (Select ProductionID from CertificateStatus) And Id NOT IN (Select ProductionID from Deliveryplan)


--Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], CertificateStatus.[Certificate Status], (Select Vendor from Vendor Where VId = Agent) As Agent, [Deliver To], [Delivery Address], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID Join CertificateStatus on FocusData.Id=CertificateStatus.ProductionID Where FocusData.Id IN (Select ProductionID from Deliveryplan)

--Select * from (Select CollectionID, Concat(DAY(DOC),'-',CONVERT(VARCHAR(3),Datename(month, DOC)),'-',YEAR(DOC)) As [Collection Date], Client, CONCAT([Address Line 1], ' ', [Address Line 2], ' ',[Address Line 3], ' ',(Select Country from Countries Where CountryId=Collection.Country), ' ', PostalCode) as Address from Collection) As Temp 
--Where [Collection Date] > GETDATE()


--Update CertificateStatus Set [Certificate Status] = 'Incomplete' Where [Certificate Status] = 'Partial'



--Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID


--Select * from CertificateStatus Where ProductionID = '198'
--Select * from Deliveryplan

--Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], T.[Certificate Status], (Select Vendor from Vendor Where VId = Agent) As Agent, [Deliver To], [Delivery Address], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] 
--                                from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID 
--                                Join (Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID)) as T on FocusData.Id=T.ProductionID 
--                                Where FocusData.Id IN (Select ProductionID from Deliveryplan)

--(Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID))

--Delete ProductionAssigned Where ProductionID IN (Select ProductionID from ProductionAssigned Where ProductionID NOT in (Select ProductionID from WorksheetReception))

--Delete from ProductionStatus Where ProductionID ='158'

--Select * from FocusData
--Select * from ProductionPlan
--Select * from ProductionAssigned 
--Select * from ProductionStatus 
--select * from WorksheetReception 
--Select * From CertificateStatus 
--Select * from Deliveryplan

--Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], T.[Certificate Status], (Select Vendor from Vendor Where VID = Deliveryplan.Agent) As Agent, [Deliver To], [Delivery Address], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] 
--                                from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID 
--                                Join (Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID)) as T on FocusData.Id=T.ProductionID 
--                                Where FocusData.Id IN (Select ProductionID from Deliveryplan)

--Select CollectionID, Concat(DAY(DOC),'-',CONVERT(VARCHAR(3),Datename(month, DOC)),'-',YEAR(DOC)) As [Collection Date], (Select Vendor from Vendor Where VID = Collection.Transporter) As Agent, Client, CONCAT([Address Line 1], ' ', [Address Line 2], ' ',[Address Line 3], ' ',(Select Country from Countries Where CountryId=Collection.Country), ' ', PostalCode) as Address, Note from Collection

--Select 
--Focusdata.Id, 
--FocusData.Instrument, 
--FocusData.[Delivery Type],
--Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received],
--FocusData.[Job Number], 
--FocusData.[Client Name], 
--FocusData.Quantity, 
--FocusData.Department, 
--FocusData.[Serial No], 
--CONVERT(Date, FocusData.[Delivery Date]) as [Delivery Date], 
--FocusData.Certification,
--OVERALL.Status, OVERALL.[With] from FocusData JOIN 
--(Select ID AS ID, Status = 'Unplanned', [With] = 'Logistics Coordinator' from FocusData Where ID NOT IN (Select ProductionID from ProductionPlan)  UNION
--Select ProductionID as ID, Status = 'Planned but unassigned', [With] = 'Tech Mgmt.' from ProductionPlan Where ProductionID NOT IN (Select ProductionID from ProductionAssigned) UNION
--Select ProductionID AS ID, Status = 'Assigned', (Select concat (FName, ' ', LName) from Employee where Eid = ProductionAssigned.Employee) as [With] from ProductionAssigned Where ProductionID NOT IN (Select ProductionID from ProductionStatus) UNION
--Select ProductionID AS ID, Status = 'Calibrated', [With] = 'Logistics Coordinator' from ProductionStatus Where Status = 'Completed' And ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
--Select ProductionID AS ID, Status = ' Calibration On-hold', (Select (Select concat (FName, ' ', LName) from Employee where Eid = ProductionAssigned.Employee) from ProductionAssigned Where ProductionID = ProductionStatus.ProductionID) as [With] from ProductionStatus Where Status = 'On-hold' And ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
--Select ProductionID AS ID, Status = 'Certificate Completed', [With] = 'Signature In-Progress' from CertificateStatus Where [Certificate Status] = 'Completed' And ProductionID NOT IN (Select ProductionID from Deliveryplan) UNION
----Select ProductionID AS ID, Status = 'Certificate Incomplete', (Select (Select concat (FName, ' ', LName) from Employee where Eid = WorksheetReception.[Allocated To]) from WorksheetReception Where ProductionID = CertificateStatus.ProductionID) as [With] from CertificateStatus Where [Certificate Status] = 'Incomplete' And ProductionID IN (Select ProductionID from WorksheetReception) And ProductionID NOT IN (Select ProductionID from Deliveryplan) UNION
--Select ProductionID AS ID, Status = 'Certificate Incomplete', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
--Select ProductionID AS ID, Status = 'Delivery Planned', [With] = 'Ready for Delivery' from Deliveryplan) AS OVERALL
--ON FocusData.Id = Overall.ID Where FocusData.[Job Number] = 'JobRCT:CTJ19-1100'

--Select ProductionID AS ID, Status = 'Certificate Incomplete', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID NOT IN (Select ProductionID from CertificateStatus)

--Select ProductionID from CertificateStatus Where ProductionID NOT IN (Select ProductionID from CertificateStatus Where MidState = '0')

--Select ProductionID AS ID, Status = 'Cert. Incomp. Del. Planned', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID IN (Select ProductionID from CertificateStatus Where ProductionID NOT IN (Select ProductionID from CertificateStatus Where MidState = '0'))



--Select [Job Number], Department, SUM(CAST(Quantity AS int)) as [Instruments] from FocusData Where [Job Number] IN (Select [Job Number] from FocusData Where ID in (Select ProductionID from Deliveryplan)) GROUP By [Job Number], Department

--Select TOP 50 [Job Number], Department, SUM(CAST(Quantity AS int)) as [Instruments] from FocusData Where NOT Department = '-' GROUP BY [Job Number], Department ORDER BY [Job Number]

--Select * from FocusData Where Id = '13775'

--Select [Job Number], [Client Name], [Salesperson], (Select Vendor from Vendor Where VID = Deliveryplan.Agent) as [Agent], [TAT], Department, SUM(CAST(Quantity AS int)) as [Instruments] from FocusData Where [Job Number] IN (Select [Job Number] from FocusData 
--                                Where ID in (Select ProductionID from Deliveryplan)) GROUP By [Job Number], [Client Name], [Salesperson], [Agent], [TAT], Department

--Delete FocusData Where Id < 23000 And ID NOT In (Select ProductionID from ProductionPlan)

--Select count(*) from FocusData

--Select top 100 Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Received Date], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
--                                            Where Id NOT IN (Select ProductionID from ProductionPlan) ORDER by [TAT], [Date Received] DESC

--(Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, CAST(SUM(CAST(Quantity AS int)) As varchar) as [Count], Remarks from FocusData LEFT JOIN DeliveryRemarks on FocusData.[Job Number]=DeliveryRemarks.JobID Where [Job Number] IN (Select [Job Number] from FocusData 
--                                Where ID in (Select ProductionID from Deliveryplan)) GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson, Remarks) 
--                                UNION
--(Select Cast(CollectionId As VARCHAR) As RefID, 'Collection' as Type, Client, CONCAT([Address Line 1], ', ', [Address Line 2], ', ', [Address Line 3], ', ', (Select Country from Countries Where CountryId = Collection.Country), ' ', PostalCode) As Address, CONCAT(Salutation, ' ', Contact) as Attention, 
--            CONCAT(Telephone, '/', Handphone) as Telephone, (select CONCAT(FName, ' ', LName) from Employee Where Eid = Collection.[Caltek Sales]) as Salesperson, '-' as [Count], Note as Remarks from Collection)
--ORDER BY Client

--(Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, CAST(SUM(CAST(Quantity AS int)) As varchar) as [Count] from FocusData Where [Job Number] IN (Select [Job Number] from FocusData 
--                                Where ID in (Select ProductionID from Deliveryplan Where DDate = '" + TxtDDate.Text + "' And Agent = (Select Vid from Vendor Where Vendor = '" + TxtAgent.Text + "'))) GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson) 
--                                UNION
--(Select Cast(CollectionId As VARCHAR) As RefID, 'Collection' as Type, Client, CONCAT([Address Line 1], ', ', [Address Line 2], ', ', [Address Line 3], ', ', (Select Country from Countries Where CountryId = Collection.Country), ' ', PostalCode) As Address, CONCAT(Salutation, ' ', Contact) as Attention, 
--            CONCAT(Telephone, '/', Handphone) as Telephone, (select CONCAT(FName, ' ', LName) from Employee Where Eid = Collection.[Caltek Sales]) as Salesperson, '-' as [Count] from Collection Where DOC = '" + TxtDDate.Text + "')
--ORDER BY Client

--Select (Select Vendor from vendor Where VID = Deliveryplan.Agent) As Agent, [Job Number], [Client Name], Department, SUM(CAST(Quantity AS int)) as [Instruments] from FocusData Join Deliveryplan on FocusData.Id=Deliveryplan.ProductionID Where [Job Number] IN (Select [Job Number] from FocusData 
--                                Where ID in (Select ProductionID from Deliveryplan)) GROUP By [Job Number], [Client Name], Department, Agent

--Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, SUM(CAST(Quantity AS int)) as [Count] from FocusData Where ID in (Select ProductionID from Deliveryplan Where DDate = '2019-12-25' And Agent = (Select Vid from Vendor Where Vendor = 'Praveena Transports')) GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson

--Select (Select Vendor from vendor Where VID = Deliveryplan.Agent) As Agent, [Job Number], [Client Name], Department, SUM(CAST(Quantity AS int)) as [Instruments] from FocusData Join Deliveryplan on FocusData.Id=Deliveryplan.ProductionID Where [Job Number] IN (Select [Job Number] from FocusData 
--                                Where ID in (Select ProductionID from Deliveryplan Where DDate = '2019-12-25')) GROUP By [Job Number], [Client Name], Department, Agent

--Select DISTINCT ([Job Number]) from FocusData Where Id in (Select ProductionID from Deliveryplan)

--Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], T.[Certificate Status], (Select Vendor from Vendor Where VID = Deliveryplan.Agent) As Agent, [Deliver To], [Delivery Address], DeliveryRemarks.Remarks, Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] 
--                                from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID LEFT Join DeliveryRemarks on FocusData.[Job Number] = DeliveryRemarks.JobID
--                                Join (Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID)) as T on FocusData.Id=T.ProductionID 
--                                Where FocusData.Id IN (Select ProductionID from Deliveryplan)

--Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], T.[Certificate Status], (Select Vendor from Vendor Where VID = Deliveryplan.Agent) As Agent, [Deliver To], [Delivery Address], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] 
--                                from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID 
--                                Join (Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID)) as T on FocusData.Id=T.ProductionID 
--                                Where FocusData.Id IN (Select ProductionID from Deliveryplan)

--Select DISTINCT [Job Number] from FocusData Where Id in (Select ProductionID from Deliveryplan) and [Job Number] NOT IN (Select JobID from DeliveryRemarks)

--Select * from (Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], T.[Certificate Status], (Select Vendor from Vendor Where VID = Deliveryplan.Agent) As Agent, [Deliver To], [Delivery Address], DeliveryRemarks.Remarks, Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] 
--                                from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID LEFT Join DeliveryRemarks on FocusData.[Job Number] = DeliveryRemarks.JobID
--                                Join (Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID)) as T on FocusData.Id=T.ProductionID 
--                                Where FocusData.Id IN (Select ProductionID from Deliveryplan)) AS OVERALL Where OVERALL.[ID] Like '4726'

--Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, CAST(SUM(CAST(Quantity AS int)) As varchar) as [Count], Status, Remarks As [Driver Remarks] from FocusData LEFT JOIN Agentupdate on FocusData.[Job Number]=Agentupdate.ID
--Where FocusData.ID in (Select ProductionID from Deliveryplan) And RIGHT([Job Number],4) = '' GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson, Status, Remarks
--UNION
--Select Cast(CollectionId As VARCHAR) As RefID, 'Collection' as Type, Client, CONCAT([Address Line 1], ', ', [Address Line 2], ', ', [Address Line 3], ', ', (Select Country from Countries Where CountryId = Collection.Country), ' ', PostalCode) As Address, CONCAT(Salutation, ' ', Contact) as Attention, 
--CONCAT(Telephone, ' / ', Handphone) as Telephone, (select CONCAT(FName, ' ', LName) from Employee Where Eid = Collection.[Caltek Sales]) as Salesperson, '-' as [Count], AgentUpdate.Status As Status, Remarks as [Driver Remarks] from Collection LEFT JOIN AgentUpdate on Cast(Collection.CollectionId As VARCHAR) = Agentupdate.ID Where CollectionId = '5'

--Select (Select MAX(CollectionId) from Collection) as ID, * from Client

--CREATE PROCEDURE [dbo].[JobRequest_Insert]
--	@CId INT,
--    @Remarks NVARCHAR (250),
--    @DOR VARCHAR (50),
--    @JobNo NVARCHAR (50),
--    @PPE VARCHAR (150),
--    @RA VARCHAR (3),
--    @Salesperson VARCHAR (100),
--    @Createduser VARCHAR (50),
--    @Created VARCHAR (50),
--    @Modifieduser VARCHAR (50),
--    @Modified VARCHAR (50),
--    @Status VARCHAR (50),
--    @dt SiteInstrumentsType ReadOnly
--AS BEGIN
--		INSERT INTO JobRequest VALUES (@CId, @Remarks, @DOR, @JobNo, @PPE, @RA, (Select Eid from Employee Where concat(FName,' ',LName) = @Salesperson), @Createduser, @Created, @Modifieduser, @Modified, @Status)
--		INSERT INTO JobRequestInstruments Select (Select MAX(Id) from JobRequest) as JRID, * from @dt
--END

Select * from JobRequest
Select * from JobRequestInstruments



Select Id as Ref#, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest


Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, DOR, JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where ID = '3'

SELECT COALESCE(CAST(EmpID AS VARCHAR) + ', ', '') + CAST(EmpID AS VARCHAR) from Sitejobassmtteam

Select EmpID from Sitejobassmtteam; 
 
Select Id, Client, [Requested Date], PPE, Salesperson, Status, Members from (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where Status <> 'Cancelled') As Job
LEFT JOIN
(Select DISTINCT [Job ID], SUBSTRING((SELECT ',' + (Select concat (FName, ' ', LName) from Employee Where Eid = Sitejobassmtteam.EmpID) AS 'data()' FROM Sitejobassmtteam FOR XML PATH('')), 2 , 9999) As Members FROM Sitejobassmtteam) as Team
on Job.Id = Team.[Job ID]

Select * from (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo as [Job No.], PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest) As T Where [" + TxtSearch.Text + "] Like '%" & TxtKeyword.Text & "%'

Select DISTINCT [Requested Date] from (Select Id, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo from JobRequest Where Status <> 'Cancelled') As Job

Select [Job ID], Members, DOR from (Select DISTINCT [Job ID], SUBSTRING((SELECT ',' + (Select concat (FName, ' ', LName) from Employee Where Eid = Sitejobassmtteam.EmpID) AS 'data()' FROM Sitejobassmtteam FOR XML PATH('')), 2 , 9999) 
As Members FROM Sitejobassmtteam) As Team LEFT JOIN (Select Id, DOR from JobRequest Where Status <> 'Cancelled') As Job ON Team.[Job ID] = Job.Id

Select * from (Select Id, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date] from JobRequest Where Status <> 'Cancelled') As Job

Update JobRequest Set DOR = '2020-02-05' Where Id = '8'

Select Id, Client, [Requested Date], PPE, Salesperson, Status, Members from (Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where Status <> 'Cancelled') As Job
LEFT JOIN
(Select DISTINCT [Job ID], SUBSTRING((SELECT ',' + (Select concat (FName, ' ', LName) from Employee Where Eid = Sitejobassmtteam.EmpID) AS 'data()' FROM Sitejobassmtteam FOR XML PATH('')), 2 , 9999) As Members FROM Sitejobassmtteam GROUP By [Job ID], Sitejobassmtteam.EmpID) as Team
on Job.Id = Team.[Job ID]

Select [Job ID], EmpID, DOR from (Select [Job Id], EmpID from Sitejobassmtteam) As A JOIN (Select Id, DOR from JobRequest) As B ON A.[Job ID] = B.Id

Select Id, Client, [Requested Date], PPE, Salesperson, Status, Employee from 
(Select Id, (Select Client from Client Where CId = JobRequest.CId) as Client, Concat(DAY([DOR]),'-',CONVERT(VARCHAR(3),Datename(month, [DOR])),'-',YEAR([DOR])) As [Requested Date], JobNo, PPE, [Risk Assessment], (Select concat (FName, ' ', LName) from Employee Where Eid = JobRequest.Salesperson) as Salesperson, Remarks, Status from JobRequest Where Status <> 'Cancelled') 
As Job
LEFT JOIN
(Select [Job ID], STUFF((SELECT ', ' + (Select concat (FName, ' ', LName) from Employee Where Eid = EmpID) FROM Sitejobassmtteam WHERE ([Job ID] = Results.[Job ID]) 
FOR XML PATH(''),TYPE).value('(./text())[1]','VARCHAR(MAX)'),1,2,'') AS Employee FROM Sitejobassmtteam Results GROUP BY [Job ID]) 
As Team 
on Team.[Job ID] = Job.Id


Select * from Sitejobassmtteam

Select * from Deliveryplan


Select CollectionID, Concat(DAY(DOC),'-',CONVERT(VARCHAR(3),Datename(month, DOC)),'-',YEAR(DOC)) As [Collection Date], (Select Vendor from Vendor Where VID = Collection.Transporter) As Agent, Client, CONCAT([Address Line 1], ' ', [Address Line 2], ' ',[Address Line 3], ' ',(Select Country from Countries Where CountryId=Collection.Country), ' ', PostalCode) as Address, Note from Collection Where NOT [Status]='Deleted'
And CollectionId NOT IN (Select ID from Agentupdate Where Type = 'Collection' and Status = 'Completed')

Select Id as ID, Concat(DAY([DDate]),'-',CONVERT(VARCHAR(3),Datename(month, [DDate])),'-',YEAR([DDate])) As [Delivery date], T.[Certificate Status], (Select Vendor from Vendor Where VID = Deliveryplan.Agent) As Agent, [Deliver To], [Delivery Address], DeliveryRemarks.Remarks, Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name] 
                                from FocusData Join Deliveryplan on FocusData.Id = Deliveryplan.ProductionID LEFT Join DeliveryRemarks on FocusData.[Job Number] = DeliveryRemarks.JobID
                                Join (Select * from CertificateStatus Where CONCAT(ProductionID, '-', MidState) IN (Select CONCAT(ProductionID, '-', MIN(MidState)) from CertificateStatus GROUP by ProductionID)) as T on FocusData.Id=T.ProductionID 
                                Where FocusData.Id IN (Select ProductionID from Deliveryplan) And FocusData.[Job Number] NOT IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed')

                                Select 
                Focusdata.Id, 
                FocusData.Instrument, 
                FocusData.[Delivery Type],
                Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received],
                FocusData.[Job Number], 
                FocusData.[Client Name], 
                FocusData.Quantity, 
                FocusData.Department, 
                FocusData.[Serial No],
                Concat(DAY([Delivery Date]),'-',CONVERT(VARCHAR(3),Datename(month, [Delivery Date])),'-',YEAR([Delivery Date])) As [Delivery Date],
                FocusData.Certification,
                OVERALL.Status, OVERALL.[With] from FocusData JOIN 
                (Select ID AS ID, Status = 'Unplanned', [With] = 'Logistics Coordinator' from FocusData Where ID NOT IN (Select ProductionID from ProductionPlan)  UNION
                Select ProductionID as ID, Status = 'Planned but unassigned', [With] = 'Tech Mgmt.' from ProductionPlan Where ProductionID NOT IN (Select ProductionID from ProductionAssigned) UNION
                Select ProductionID AS ID, Status = 'Assigned', (Select concat (FName, ' ', LName) from Employee where Eid = ProductionAssigned.Employee) as [With] from ProductionAssigned Where ProductionID NOT IN (Select ProductionID from ProductionStatus) UNION
                Select ProductionID AS ID, Status = 'Calibrated', [With] = 'Logistics Coordinator' from ProductionStatus Where Status = 'Completed' And ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                Select ProductionID AS ID, Status = ' Calibration On-hold', (Select (Select concat (FName, ' ', LName) from Employee where Eid = ProductionAssigned.Employee) from ProductionAssigned Where ProductionID = ProductionStatus.ProductionID) as [With] from ProductionStatus Where Status = 'On-hold' And ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                Select ProductionID AS ID, Status = 'Certificate Completed', [With] = 'Signature In-Progress' from CertificateStatus Where [Certificate Status] = 'Completed' And ProductionID NOT IN (Select ProductionID from Deliveryplan) UNION
                Select ProductionID AS ID, Status = 'Certificate Incomplete', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID NOT IN (Select ProductionID from CertificateStatus) UNION
                Select ProductionID AS ID, Status = 'Cert. Incomp. Del. Planned', (Select concat (FName, ' ', LName) from Employee where Eid = [Allocated To]) as [With] from WorksheetReception Where ProductionID IN (Select ProductionID from CertificateStatus Where ProductionID NOT IN (Select ProductionID from CertificateStatus Where MidState = '0')) UNION
                Select ProductionID AS ID, Status = 'Delivery Planned', [With] = 'Ready for Delivery' from Deliveryplan Where ProductionID NOT IN (Select Id from FocusData Where [Job Number] NOT IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed')) UNION
                Select Id As ID, Status = 'Delivered', [With] = 'Customer' from FocusData Where [Job Number] IN (Select DISTINCT [Job Number] from FocusData Where [Job Number] IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed'))) AS OVERALL
                ON FocusData.Id = Overall.ID

                Select * from Agentupdate

                Select Id As ID, Status = 'Delivered', [With] = 'Customer' from FocusData Where [Job Number] IN (Select DISTINCT [Job Number] from FocusData Where [Job Number] IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed'))

Select ProductionID AS ID, Status = 'Delivered', [With] = 'Reached Customer' from Deliveryplan Where ProductionID NOT IN (Select Id from FocusData Where [Job Number] NOT IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed'))

Select ProductionID AS ID, Status = 'Delivery Planned', [With] = 'Ready for Delivery' from Deliveryplan Where ProductionID NOT IN (Select Id from FocusData Where [Job Number] IN (Select ID from Agentupdate Where Type = 'Delivery' and status = 'completed'))



Delete Sitejobassmtteam Where [Job ID] = '6'

Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where Id NOT IN (Select ProductionID from ProductionPlan) AND TAT = 'Express' UNION
Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where Id NOT IN (Select ProductionID from ProductionPlan) AND TAT = 'Semi Express' UNION
Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where Id NOT IN (Select ProductionID from ProductionPlan) AND TAT = 'Normal'

Select * from (Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where TAT = 'Express' UNION
Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where TAT = 'Semi Express' UNION
Select Id as ID, TAT, [Delivery Type], Concat(DAY([Date Received]),'-',CONVERT(VARCHAR(3),Datename(month, [Date Received])),'-',YEAR([Date Received])) As [Date Received], [Job Number], [Client Name], Quantity, Instrument, Department, [Serial No], Certification from FocusData 
Where TAT = 'Normal') As OVERALL Where OVERALL.Id NOT IN (Select ProductionID from ProductionPlan)

Select [Job ID], (Select Client from Client Where CId = (Select CId from JobRequest Where Id = [Job ID])) AS Client, (Select concat(FName,' ',LName) from Employee Where Eid = EmpID) As Name, DOR from (Select [Job Id], EmpID from Sitejobassmtteam) As A JOIN (Select Id, DOR from JobRequest) As B ON A.[Job ID] = B.Id

Select * from Collection Where CollectionId NOT IN (Select ID from Agentupdate Where Type = 'Collection' And Status = 'Completed')
select CollectionID, Client, [Address Line 1], [Address Line 2], [Address Line 3], (select Country from Countries where CountryID = Collection.Country) as Country, PostalCode as [Postal Code], concat(Salutation, Contact) as Contact, Telephone, Handphone, Concat(DAY([DOC]),'-',CONVERT(VARCHAR(3),Datename(month, [DOC])),'-',YEAR([DOC])) As [Collection Date], [Caltek Sales] as Salesperson, (select Vendor from Vendor where VID = Collection.Transporter) as Transporter, Note as [Note to Driver], Collection.Status, AG.Status As [Agent Status], AG.Remarks As [Reason] from Collection LEFT JOIN (Select * from Agentupdate Where Type <> 'Delivery') AS AG on CollectionId=AG.ID Where CollectionId NOT IN (Select ID from Agentupdate Where Type = 'Collection' And Status = 'Completed');

Select * from Agentupdate
delete from SessionLog


Select [Job Number] as RefID, 'Delivery' as Type, [Deliver To] as Client, [Delivery Address] As Address, Attention, Telephone, Salesperson, CAST(SUM(CAST(Quantity AS int)) As varchar) as [Count], Status, Remarks As [Driver Remarks] from FocusData LEFT JOIN Agentupdate on FocusData.[Job Number]=Agentupdate.ID
Where FocusData.Id in (Select ProductionID from Deliveryplan Where Agent = (Select Vid from Vendor Where Vendor = 'Praveena Transports'))
And [Job Number] IN (Select Id from Agentupdate Where Type = 'Delivery') GROUP By [Job Number], [Deliver To], [Delivery Address], Attention, Telephone, Salesperson, Status, Remarks
UNION
Select Cast(CollectionId As VARCHAR) As RefID, 'Collection' as Type, Client, CONCAT([Address Line 1], ', ', [Address Line 2], ', ', [Address Line 3], ', ', (Select Country from Countries Where CountryId = Collection.Country), ' ', PostalCode) As Address, CONCAT(Salutation, ' ', Contact) as Attention, 
CONCAT(Telephone, ' / ', Handphone) as Telephone, (select CONCAT(FName, ' ', LName) from Employee Where Eid = Collection.[Caltek Sales]) as Salesperson, '-' as [Count], AgentUpdate.Status As Status, Remarks as [Driver Remarks] from Collection LEFT JOIN AgentUpdate on Cast(Collection.CollectionId As VARCHAR) = Agentupdate.ID
Where DOC = '06/01/2020' And Transporter = (Select Vid from Vendor Where Vendor = 'Praveena Transports') And
CollectionId IN (Select Id from Agentupdate Where Type = 'Collection')


Select * from Collection
Select * from FocusData Where [Job Number] IN (Select Id from Agentupdate Where Type = 'Delivery')

SELECT * FROM OPENQUERY(ExcelServer20200107_093922, 'SELECT * FROM [Sheet1$]') As T Where T.Dept# =  'Sub Contract'