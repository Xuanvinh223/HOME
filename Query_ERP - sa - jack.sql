USE TB_ERP

SELECT TSCD_KCRKS.RKNO, ROW_NUMBER() OVER(ORDER BY TSCD_KCRKS.SBBH) AS Seq, CASE WHEN ISNULL(TSCD_SB.HGPM, '') <> '' THEN TSCD_SB.HGPM ELSE TSCD_SB.VWPM END AS VWPM, TSCD_SB.DWBH, TSCD_KCRKS.Qty, TSCD_KCRKS.USPrice, 
                    TSCD_KCRKS.VNPrice, TSCD_KCRKS.USACC, TSCD_KCRKS.VNACC, TSCD_KCRKS.VNTax_HG, VNACC_Tax, TSCD_KCRK.ZSNO, TSCD_ZSZL.zsjc_yw 
					FROM TSCD_KCRKS 
                    LEFT JOIN TSCD_SB ON TSCD_SB.SBBH = TSCD_KCRKS.SBBH 
                    LEFT JOIN TSCD_KCRK ON TSCD_KCRK.RKNO = TSCD_KCRKS.RKNO 
                    LEFT JOIN TSCD_ZSZL ON TSCD_ZSZL.ZSDH = TSCD_KCRK.ZSBH 
					INNER JOIN BPM.UOF.dbo.LYN_AcceptanceFA LYN_AcceptanceFA ON LYN_AcceptanceFA.RKNO COLLATE Chinese_Taiwan_Stroke_CI_AS = TSCD_KCRK.RKNO COLLATE Chinese_Taiwan_Stroke_CI_AS
                    WHERE LYN_AcceptanceFA.LNO = 'LYV240800017';

--------------------------------------------------------------------
SELECT TSCD_KCRKS.RKNO, ROW_NUMBER() OVER(ORDER BY TSCD_KCRKS.SBBH) AS Seq, CASE WHEN ISNULL(TSCD_SB.HGPM, '') <> '' THEN TSCD_SB.HGPM ELSE TSCD_SB.VWPM END AS VWPM, TSCD_SB.DWBH, TSCD_KCRKS.Qty, TSCD_KCRKS.USPrice, 
                    TSCD_KCRKS.VNPrice, TSCD_KCRKS.USACC, TSCD_KCRKS.VNACC, TSCD_KCRKS.VNTax_HG, VNACC_Tax, TSCD_KCRK.ZSNO, TSCD_ZSZL.zsjc_yw 
					FROM TSCD_KCRKS 
                    LEFT JOIN TSCD_SB ON TSCD_SB.SBBH = TSCD_KCRKS.SBBH 
                    LEFT JOIN TSCD_KCRK ON TSCD_KCRK.RKNO = TSCD_KCRKS.RKNO 
                    LEFT JOIN TSCD_ZSZL ON TSCD_ZSZL.ZSDH = TSCD_KCRK.ZSBH 
                    WHERE TSCD_KCRKS.RKNO = '20230800006'

SELECT * FROM dbo.TSCD_KCRKS 
SELECT * FROM TSCD_SB
SELECT * FROM dbo.TSCD_KCRK
SELECT * FROM TSCD_ZSZL -- nhà cung ứng

SELECT * FROM dbo.WF_Out 
WHERE LNO = 'LYV240800050'
ORDER BY LeaveTime DESC

SELECT * FROM dbo.WF_Outs
WHERE LNO = 'LYV240800050'




--------------------
DECLARE @LNO NVARCHAR(100);
DECLARE @pCNT INT;

SET @LNO = '{LYV240800050}';
SELECT @pCNT = (SELECT COUNT(*) FROM WF_OutS WHERE LNO = @LNO)


SELECT WFOUT.LNO, ISNULL(WFOUT.Type,'') Type, ISNULL(WFOUT.Category,'') Category, ISNULL(WFOUT.Item,'') Item, ISNULL(WFOUT.Reason,'') Reason,
WFOUTS.ID, WFOUTS.Name, WFOUTS.Factory, WFOUTS.Department AS Dept, ST_NHANVIEN.CVU_MA, CVU_Ten , @pCNT AS pCNT, 
ISNULL(REPLACE(CONVERT(VARCHAR, LeaveTime, 120),'-','/'),'') AS 'LeaveTime_Str', ISNULL(REPLACE(CONVERT(VARCHAR, ReturnTime, 120),'-','/'),'') AS 'ReturnTime_Str'
FROM wf_out WFOUT LEFT JOIN WF_OutS WFOUTS ON WFOUT.LNO = WFOUTS.LNO
left join [HRM].[dbo].[ST_NHANVIEN] ST_NHANVIEN on ID = NV_Ma COLLATE database_default
left join [HRM].[dbo].[ST_CHUCVU] ST_CHUCVU  on ST_CHUCVU.CVU_Ma = ST_NHANVIEN.CVU_Ma COLLATE database_default
WHERE WFOUT.LNO = 'LYV240800050' 

-------------------------------------------
 SELECT CASE WHEN WF_Out.CheckDate IS NOT NULL THEN '已外出' ELSE CASE WHEN WF_Out.Cancel = 1 THEN '已註銷' ELSE '未外出' END END AS Status, WF_Out.CancelReason, WF_Out.LNO, WF_Out.Department, WF_OutS.People, 
                                   CONVERT(VARCHAR,WF_Out.LeaveTime,120) LeaveTime, CONVERT(VARCHAR,WF_Out.ReturnTime,120) ReturnTime, WF_Out.Type, WF_Out.Category, WF_Out.Item, WF_Out.Reason, WF_Out.UserID, 
                                   CONVERT(VARCHAR,WF_Out.UserDate,120) UserDate, BPM.TASK_ID 
                            FROM WF_Out 
                            LEFT JOIN (SELECT LNO AS ListNo, COUNT(ID) AS People FROM WF_OutS GROUP BY LNO) AS WF_OutS ON WF_OutS.ListNo = WF_Out.LNO 
                            LEFT JOIN (SELECT LNO AS ListNo,ID FROM WF_OutS) AS WF_OutS1 ON WF_OutS1.ListNo = WF_Out.LNO 
                            LEFT JOIN (SELECT TASK_ID, DOC_NBR FROM OPENQUERY([UOFWEB],'SELECT TASK_ID, DOC_NBR FROM [UOF].[dbo].[TB_WKF_TASK] TB_WKF_TASK ') AS SYS_TODOHIS 
                                        )AS BPM on BPM.DOC_NBR COLLATE Chinese_Taiwan_Stroke_CS_AS=WF_Out.LNO COLLATE Chinese_Taiwan_Stroke_CS_AS 
                            LEFT JOIN BUSERS ON BUSERS.UserID = WF_Out.UserID 
                            WHERE 1=1  and IsNull(OutCheck,'')='' 
                            ORDER BY WF_Out.LNO desc 

 Select Certificate.ID, Certificate.Name,Directory.DID, Directory_Department.Name as DepName, Resigned 
 FROM [LIY_TYXUAN].[dbo].[Certificate] Certificate	
 LEFT join [LIY_TYXUAN].[dbo].[Directory] Directory on Directory.ID = Certificate.ID   
 LEFT join [LIY_TYXUAN].[dbo].[Directory_Department] Directory_Department on Directory_Department.DID = Directory.DID  
 WHERE Certificate.ID = '000008'

 SELECT ST_NHANVIEN.NV_Ma, ST_NHANVIEN.NV_Ten, ST_NHANVIEN.DV_MA_, ISNULL(ST_NHANVIENTHOIVIEC.NV_Ma, 'Employee') AS Flag, ST_DONVI.KHU 
                              FROM ST_NHANVIEN 
                              LEFT JOIN ST_NHANVIENTHOIVIEC ON ST_NHANVIENTHOIVIEC.NV_Ma = ST_NHANVIEN.NV_Ma 
                              LEFT JOIN ST_DONVI ON ST_DONVI.DV_MA = ST_NHANVIEN.DV_MA 
                              WHERE ST_NHANVIEN.NV_Ma = @UserID

