USE UOF

SELECT * FROM dbo.TB_WKF_TASK
ORDER BY BEGIN_TIME DESC

SELECT CURRENT_DOC FROM dbo.TB_WKF_TASK
ORDER BY BEGIN_TIME DESC

SELECT *FROM dbo.LYV_BusinessTripReport
SELECT * FROM dbo.LYV_BusinessTripOD
SELECT * FROM dbo.LYV_BusinessTrip
SELECT * FROM [dbo].[LYV_Supplier]


 DECLARE @SNO NVARCHAR(100);
-- Giả sử {?PNO} là một giá trị thay thế cho giá trị thực của LNO
SET @SNO = '{?SNO}';

SELECT LYN_SkillAssement.SNO, LYN_SkillAssement.UserID,LYN_SkillAssement.UserDate,LYN_SkillAssement.DepID,LYN_SkillAssement.ID,LYN_SkillAssement.Name,
LYN_SkillAssement.Dep,LYN_SkillAssement.JoinDate,LYN_SkillAssement.Position,LYN_SkillAssement.Promotion,LYN_SkillAssement.Specialize,LYN_SkillAssement.Comment,
Supervisor1, SupervisorDate1,Supervisor2, SupervisorDate2,Manager,ManagerDate from LYN_SkillAssement
LEFT JOIN 
        (
            -- Truy vấn con để lấy dữ liệu phê duyệt
            SELECT 
                MAX(CASE WHEN SITE_CODE='S1' THEN NAME END) AS Supervisor1, 
                MAX(CASE WHEN SITE_CODE='S1' THEN FINISH_TIME END) AS SupervisorDate1,  
                MAX(CASE WHEN SITE_CODE='S2' THEN NAME END) AS Supervisor2, 
                MAX(CASE WHEN SITE_CODE='S2' THEN FINISH_TIME END) AS SupervisorDate2,  
                MAX(CASE WHEN SITE_CODE='SE' THEN NAME END) AS Manager, 
                MAX(CASE WHEN SITE_CODE='SE' THEN FINISH_TIME END) AS  ManagerDate 
            FROM 
                ( 
                    SELECT 
                        TB_EB_USER.NAME, 
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
                        SITE_CODE <> 'Applicant' AND SITE_CODE NOT IN ('Applicant','END_FORM') AND 
                        TB_WKF_TASK.DOC_NBR = @SNO 
                ) AS ApproveData 
            WHERE 
                RowID = 1 
        ) AS ApproveData ON 1 = 1 
where LYN_SkillAssement.SNO=@SNO