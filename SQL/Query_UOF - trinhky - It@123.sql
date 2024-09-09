USE UOF

SELECT * FROM dbo.TB_WKF_TASK
ORDER BY BEGIN_TIME DESC

SELECT CURRENT_DOC FROM dbo.TB_WKF_TASK
ORDER BY BEGIN_TIME DESC

SELECT *FROM dbo.LYV_BusinessTripReport
SELECT * FROM dbo.LYV_BusinessTripOD
SELECT * FROM dbo.LYV_BusinessTrip
SELECT * FROM [dbo].[LYV_Supplier]
SELECT * FROM [LYV_BoSungNhanSu]
SELECT * FROM [LYV_BoSungNhanSus]
select * from [dbo].[LYV_AcceptanceFA]
select * from [dbo].[LYV_Leave]