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



SELECT LYV_BoSungNhanSu.*, Applicant,ApplicantDate, Supervisor, SupervisorDate, Supervisor1, SupervisorDate1,  Manager , 
	   ISNull (ManagerDate,SupervisorDate) as ManagerDate, HR, HRDate,HRSupervisor, HRSupervisorDate, HRManager, HRManagerDate
FROM LYV_BoSungNhanSu
LEFT JOIN TB_WKF_TASK on LYV_BoSungNhanSu.LYV=TB_WKF_TASK.DOC_NBR
LEFT JOIN (
   SELECT 
                MAX(APPNAME) AS Applicant, 
                MAX(CAST(BEGIN_TIME AS DATE)) AS ApplicantDate,  
                MAX(CASE WHEN SITE_CODE='S1' THEN NAME END) AS Supervisor, 
                MAX(CASE WHEN SITE_CODE='S1' THEN FINISH_TIME END) AS SupervisorDate,  
                MAX(CASE WHEN SITE_CODE='S2' THEN NAME END) AS Supervisor1, 
                MAX(CASE WHEN SITE_CODE='S2' THEN FINISH_TIME END) AS SupervisorDate1,  
                MAX(CASE WHEN SITE_CODE='S3' THEN NAME END) AS Manager, 
                MAX(CASE WHEN SITE_CODE='S3' THEN FINISH_TIME END) AS ManagerDate, 
                MAX(CASE WHEN SITE_CODE='HR' THEN NAME END) AS HR, 
                MAX(CASE WHEN SITE_CODE='HR' THEN FINISH_TIME END) AS HRDate,
				MAX(CASE WHEN SITE_CODE='HRSupervisor' THEN NAME END) AS HRSupervisor, 
                MAX(CASE WHEN SITE_CODE='HRSupervisor' THEN FINISH_TIME END) AS HRSupervisorDate,
				MAX(CASE WHEN SITE_CODE='HRManager' THEN NAME END) AS HRManager, 
                MAX(CASE WHEN SITE_CODE='HRManager' THEN FINISH_TIME END) AS HRManagerDate, 
				MAX(CASE WHEN SITE_CODE='GD' THEN NAME END) AS GD, 
                MAX(CASE WHEN SITE_CODE='GD' THEN FINISH_TIME END) AS GDDate
				
	FROM ( 
		SELECT 
                        case when TB_WKF_TASK_NODE.ACTUAL_SIGNER<>TB_WKF_TASK_NODE.ORIGINAL_SIGNER then TB_EB_USER.NAME + '(*)' else TB_EB_USER.NAME end as NAME, 
                        CAST(FINISH_TIME AS DATE) FINISH_TIME, 
                        US.NAME AS APPNAME, 
                        TB_WKF_TASK.BEGIN_TIME,
                        ROW_NUMBER() OVER (PARTITION BY FINISH_TIME ORDER BY FINISH_TIME DESC) AS RowID, 
                        TB_WKF_TASK_TRIGGER_RECORD.SITE_CODE
                    FROM 
                        TB_WKF_TASK
                    LEFT JOIN 
                        TB_WKF_TASK_NODE ON TB_WKF_TASK.TASK_ID = TB_WKF_TASK_NODE.TASK_ID
                    LEFT JOIN 
                        TB_WKF_TASK_TRIGGER_RECORD ON TB_WKF_TASK_TRIGGER_RECORD.SITE_ID = TB_WKF_TASK_NODE.SITE_ID AND TB_WKF_TASK_NODE.TASK_ID = TB_WKF_TASK_TRIGGER_RECORD.TASK_ID
                    LEFT JOIN 
                        TB_EB_USER ON TB_EB_USER.USER_GUID = TB_WKF_TASK_NODE.ACTUAL_SIGNER
                    LEFT JOIN 
                        TB_EB_USER US ON US.USER_GUID = TB_WKF_TASK.AGENT_USER
                    WHERE 
                        ACTUAL_SIGNER IS NOT NULL AND 
                        SITE_CODE NOT IN ('Applicant','END_FORM') AND 
                        TB_WKF_TASK.DOC_NBR = 'LYV240800245'
                ) AS ApproveData 
  WHERE RowID = 1 
 ) AS ApproveData ON 1 = 1 
 WHERE LYV='LYV240800245'





