using System.Data;
using System.Xml.Linq;
using Ede.Uof.EIP.SystemInfo;

namespace LYV.AcceptanceFA.PO
{
    internal class AcceptanceFAPO :Ede.Uof.Utility.Data.BasePersistentObject
    {
   
        internal DataTable GetData(string RKNO)
        {

            string connStr = Training.Properties.Settings.Default.LYV_ERP.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(connStr);
            string cmdTxt = @"  SELECT TSCD_KCRKS.RKNO, ROW_NUMBER() OVER(ORDER BY TSCD_KCRKS.SBBH) AS Seq, CASE WHEN ISNULL(TSCD_SB.HGPM, '') <> '' THEN TSCD_SB.HGPM ELSE TSCD_SB.VWPM END AS VWPM, TSCD_SB.DWBH, TSCD_KCRKS.Qty, TSCD_KCRKS.USPrice, 
                    TSCD_KCRKS.VNPrice, TSCD_KCRKS.USACC, TSCD_KCRKS.VNACC, TSCD_KCRKS.VNTax_HG, VNACC_Tax, TSCD_KCRK.ZSNO, TSCD_ZSZL.zsjc_yw FROM TSCD_KCRKS 
                    LEFT JOIN TSCD_SB ON TSCD_SB.SBBH = TSCD_KCRKS.SBBH 
                    LEFT JOIN TSCD_KCRK ON TSCD_KCRK.RKNO = TSCD_KCRKS.RKNO 
                    LEFT JOIN TSCD_ZSZL ON TSCD_ZSZL.ZSDH = TSCD_KCRK.ZSBH 
                    WHERE TSCD_KCRKS.RKNO = @RKNO
                                ";

            this.m_db.AddParameter("@RKNO", RKNO);

            DataTable dt = new DataTable();

            dt.Load(this.m_db.ExecuteReader(cmdTxt));

            return dt;

        }


        internal void InsertData_BeginForm(string LYV, string ListType, string AcceptanceDate, string Department, string Applicant, string Description, string PropertyNumbers, XElement xE)
        {
            string connStr = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(connStr);
            string PurNo = xE.Attribute("PurchaseRequestNo").Value;
            string RKNO = xE.Attribute("RKNO").Value;
            string LType = ListType.Substring(0, ListType.IndexOf('@'));
            string cmdTxt = @"  INSERT INTO [dbo].[LYV_AcceptanceFA]
                                   ([LYV]
                                   ,[ListType]
                                   ,[PurchaseRequestNo]
                                   ,[AcceptanceDate]
                                   ,[RKNO]
                                   ,[Department]
                                   ,[Applicant]
                                   ,[Description]
                                   ,[PropertyNumbers]
                                   ,[flowflag]
                                   ,[UserID]
                                   ,[UserDate])
                                 VALUES
                                 (	@LYV  
                                    ,@ListType  
                                    ,@PurchaseRequestNo  
                                    ,@AcceptanceDate  
                                    ,@RKNO  
                                    ,@Department  
                                    ,@Applicant  
                                    ,@Description  
                                    ,@PropertyNumbers  
                                    ,'N'
                                    ,@UserID  
                                    ,getdate() 
                                )";

            this.m_db.AddParameter("@LYV", LYV);
            this.m_db.AddParameter("@ListType", LType);
            this.m_db.AddParameter("@PurchaseRequestNo", PurNo);
            this.m_db.AddParameter("@AcceptanceDate", AcceptanceDate);
            this.m_db.AddParameter("@RKNO", RKNO);
            this.m_db.AddParameter("@Department", Department);
            this.m_db.AddParameter("@Applicant", Applicant);
            this.m_db.AddParameter("@Description", Description);
            this.m_db.AddParameter("@PropertyNumbers", PropertyNumbers);
            this.m_db.AddParameter("@UserID ", Current.Account);
            this.m_db.ExecuteNonQuery(cmdTxt);

        }

        //
        internal void UpdateFormStatus(string LYV, string SiteCode, string signStatus,string ListType, string AcceptanceDate, string Department, string Applicant, string Description, string PropertyNumbers, XElement xE)
        {
            string conn = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn);
            string cmdflowflag = @"SELECT flowflag, ListType FROM LYV_AcceptanceFA WHERE LYV = @LYV";

            DataTable dt = new DataTable();
            this.m_db.AddParameter("@LYV", LYV);
            dt.Load(this.m_db.ExecuteReader(cmdflowflag));

            string flowflag = dt.Rows[0][0].ToString(); //請假人工號
            string listtype = dt.Rows[0][1].ToString();
            
            if (flowflag == "NP" || flowflag == "N")
            {
                string flag = "N";
                if (!string.IsNullOrEmpty(SiteCode))
                {
                    flag = "P";
                }
                string PurNo = xE.Attribute("PurchaseRequestNo").Value;
                string RKNO = xE.Attribute("RKNO").Value;
                string LType = ListType.Substring(0, ListType.IndexOf('@'));
                string cmdTxt = @" Update [dbo].[LYV_AcceptanceFA]   set     
                                     [ListType] = @ListType  ,                          
                                     [PurchaseRequestNo] = @PurchaseRequestNo  ,  
                                     [AcceptanceDate] = @AcceptanceDate ,
                                     [RKNO] = @RKNO,
                                     [Department] = @Department,
                                     [Applicant] =  @Applicant,
                                     [Description] = @Description,
                                     [PropertyNumbers] = @PropertyNumbers,
                                     [flowflag] =  @flowflag
                                     WHERE
                                     LYV=@LYV
                                ";

                this.m_db.AddParameter("@LYV", LYV);
                this.m_db.AddParameter("@ListType", LType);
                this.m_db.AddParameter("@PurchaseRequestNo", PurNo);
                this.m_db.AddParameter("@AcceptanceDate", AcceptanceDate);
                this.m_db.AddParameter("@RKNO", RKNO);
                this.m_db.AddParameter("@Department", Department);
                this.m_db.AddParameter("@Applicant", Applicant);
                this.m_db.AddParameter("@Description", Description);
                this.m_db.AddParameter("@PropertyNumbers", PropertyNumbers);
                this.m_db.AddParameter("@flowflag", flag);
                this.m_db.ExecuteNonQuery(cmdTxt);
            }
            
            if (SiteCode == "ReturnToApplicant")
            {
                string conn1 = Training.Properties.Settings.Default.UOF.ToString();
                this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn1);
                string cmdTxt = "UPDATE LYV_AcceptanceFA SET flowflag = 'NP' WHERE LYV = @LYV ";
                this.m_db.AddParameter("@LYV", LYV);
                this.m_db.ExecuteNonQuery(cmdTxt);
                this.m_db.Dispose();
            }
            else if (SiteCode == "總務最高主管_Director_General" && signStatus == "Approve")
            {

                string cmdTxt = @"UPDATE LYV_AcceptanceFA SET flowflag='Z' WHERE LYV = @LYV AND flowflag IN ('N','P')";
                this.m_db.AddParameter("@LYV", LYV);
                this.m_db.ExecuteNonQuery(cmdTxt);
            }
            else if (signStatus == "Disapprove")
            {
                string cmdTxt = @"UPDATE LYV_AcceptanceFA SET flowflag='X' WHERE LYV = @LYV ";
                this.m_db.AddParameter("@LYV", LYV);
                this.m_db.ExecuteNonQuery(cmdTxt);
            }

            this.m_db.Dispose();
        }

        //
        internal void UpdateFormResult(string LYV, string formResult)
        {
            if (formResult == "Adopt")
            {

                string conn1 = Training.Properties.Settings.Default.UOF.ToString();
                this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn1);
                string cmdTxt = @"UPDATE LYV_AcceptanceFA SET flowflag='Z' WHERE LYV = @LYV AND flowflag IN ('N','P')";
                this.m_db.AddParameter("@LYV", LYV);
                this.m_db.ExecuteNonQuery(cmdTxt);
            }
            else if (formResult == "Reject" || formResult == "Cancel")
            {
                string conn1 = Training.Properties.Settings.Default.UOF.ToString();
                this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn1);
                string cmdTxt = @"UPDATE LYV_AcceptanceFA SET flowflag='X' WHERE LYV = @LYV AND flowflag IN ('N','P')";
                this.m_db.AddParameter("@LYV", LYV);
                this.m_db.ExecuteNonQuery(cmdTxt);
            }
            else
            {
                string conn1 = Training.Properties.Settings.Default.UOF.ToString();
                this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn1);
                string cmdTxt = @"UPDATE LYV_AcceptanceFA SET flowflag='NP' WHERE LYV = @LYV AND flowflag IN ('N','P')";
                this.m_db.AddParameter("@LYV", LYV);
                this.m_db.ExecuteNonQuery(cmdTxt);
            }
        }

        internal string getFlowflag(string LYV)
        {

            string conn = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn);
            string cmdflowflag = @"SELECT flowflag FROM LYV_AcceptanceFA WHERE LYV = @LYV";

            DataTable dt = new DataTable();
            this.m_db.AddParameter("@LYV", LYV);
            dt.Load(this.m_db.ExecuteReader(cmdflowflag));

            this.m_db.Dispose();

            string flowflag = dt.Rows[0][0].ToString(); //請假人工號

            return flowflag;

        }

        internal DataTable GetGridView_Close(string LYV, string RKNO, string ListType, string Sdate, string Edate,string status)
        {

            string connStr = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(connStr);
            string cmdTxt = @"select LYV, ListType, PurchaseRequestNo, AcceptanceDate, RKNO, Department, Applicant, Description, PropertyNumbers, UserID, UserDate, TB_WKF_TASK.TASK_ID   from LYV_AcceptanceFA 
                            LEFT JOIN TB_WKF_TASK ON TB_WKF_TASK.DOC_NBR = LYV_AcceptanceFA.LYV
                            where LYV like '%" + LYV + @"%' and  RKNO like '%" + RKNO + @"%' and LYV_AcceptanceFA.flowflag like '%" + status + "%' and ListType like N'%" + ListType + @"%'";
            if(Sdate != "")
            {
                cmdTxt += @" and convert(smalldatetime,convert(varchar,UserDate,111))  >= '" + Sdate + @"'"; 
            }
            if (Edate != "")
            {
                cmdTxt += @" and  convert(smalldatetime,convert(varchar,UserDate,111))  <= '" + Edate + @"'  ";
            }


            DataTable dt = new DataTable();

            dt.Load(this.m_db.ExecuteReader(cmdTxt));

            return dt;

        }



    }
}
