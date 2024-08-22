using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Training.Data;
using System.Xml.Linq;

namespace Training.BusinessTripReport.PO
{
    internal class BusinessTripReportPO : Ede.Uof.Utility.Data.BasePersistentObject
    {
        internal DataTable GetListBT(string LNO, string Name, string Name_ID, string BTime1, string BTime2, string expert)
        {
            string conn = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn);
            string where = " and expert = '" + expert + "' ";
            if (LNO != "") where += " and LOWER(LNO) like LOWER('%" + LNO + "%') ";
            if (Name != "") where += " and LOWER(Name) like LOWER(N'%" + Name + "%') ";
            if (Name_ID != "") where += " and Name_ID like '" + Name_ID + "%' ";
            if (BTime1 != "") where += " and BTime >= '" + BTime1 + "' ";
            if (BTime2 != "") where += " and BTime <= '" + BTime2 + "' ";

            string SQL = @"SELECT LNO, MaPhieu, Name, Name_ID, Purpose, FLocation, BTime, ETime, USERID, USERDATE, TASK_ID 
                           FROM LYN_BusinessTrip_Templ LEFT JOIN TB_WKF_TASK on LYN_BusinessTrip_Templ.LNO=TB_WKF_TASK.DOC_NBR 
                           WHERE isnull(Days,2)>=2 and flowflag='Z' and LNO not in (select BLNO as LNO from LYN_BusinessTripReport where isnull(Cancel,0)<>1) " + where + @"
                           ORDER BY LYN_BusinessTrip_Templ.LNO desc ";

            DataTable dt = new DataTable();
            dt.Load(this.m_db.ExecuteReader(SQL));

            this.m_db.Dispose();

            return dt;
        }
        internal DataTable GetBusinessTripReport_BLNO(string BLNO)
        {
            string conn = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn);

            string SQL = @"SELECT LNO, MaPhieu, Name, Name_ID, Purpose, FLocation, BTime, ETime, USERID, USERDATE, TASK_ID 
                           FROM LYN_BusinessTrip_Templ LEFT JOIN TB_WKF_TASK on LYN_BusinessTrip_Templ.LNO=TB_WKF_TASK.DOC_NBR 
                           WHERE LNO = " + BLNO + @"
                           ORDER BY LYN_BusinessTrip_Templ.LNO desc ";

            DataTable dt = new DataTable();
            dt.Load(this.m_db.ExecuteReader(SQL));

            this.m_db.Dispose();

            return dt;
        }
        internal void InsertBusinessTripReportData(string LNO, string UserID, string Department, string Date, string Date1, string Name, string Destination, string Description, XElement xE)
        {
            string conn = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn);

            string BLNO = xE.Attribute("BLNO").Value;

            string cmdTxt = @"  INSERT INTO LYN_BusinessTripReport
                                (	 [LNO] ,  
                                     [Department] , 
                                     [Date] ,
                                     [Date1] ,
                                     [Name] ,
                                     [Destination] ,
                                     [Description] ,
                                     [BLNO] ,
                                     [USERID] ,
                                     [USERDATE] ,
                                     [flowflag]
                                ) 
                                 VALUES 
                                 (	
                                     @LNO,
                                     @Department,
                                     @Date,
                                     @Date1,
                                     @Name,
                                     @Destination,
                                     @Description,
                                     @BLNO,
                                     @UserID,
                                     getdate(),
                                     @flowflag
                                )  ";

            this.m_db.AddParameter("@LNO", LNO);
            this.m_db.AddParameter("@Department", Department);
            this.m_db.AddParameter("@Date", Date);
            this.m_db.AddParameter("@Date1", Date1);
            this.m_db.AddParameter("@Name", Name);
            this.m_db.AddParameter("@Destination", Destination);
            this.m_db.AddParameter("@Description", Description);
            this.m_db.AddParameter("@BLNO", BLNO);
            this.m_db.AddParameter("@UserID", UserID);
            this.m_db.AddParameter("@flowflag", "Z");

            this.m_db.ExecuteNonQuery(cmdTxt);

            this.m_db.Dispose();
        }
        internal string GetBusinessTripReport(string LNO)
        {
            string Status = "";
            string conn = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn);
            string cmdTxt = @"SELECT CASE WHEN CFMID IS NOT NULL THEN 'cfm' ELSE CASE WHEN Cancel = 1 THEN 'cancel' ELSE '' END END AS Status FROM LYN_BusinessTripReport
                              WHERE LNO = '" + LNO + "' ";

            DataTable dt = new DataTable();
            dt.Load(this.m_db.ExecuteReader(cmdTxt));

            this.m_db.Dispose();

            if (dt.Rows.Count > 0)
            Status = dt.Rows[0][0].ToString();

            return Status;

        }
        public void UpdateCancelReason(string LNO, string CancelReason)
        {
            string conn = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn);
            string cmdTxt = @"UPDATE LYN_BusinessTripReport SET Cancel = 1, CancelReason = '" + CancelReason + "' WHERE LNO = '" + LNO + "' ";
            this.m_db.ExecuteNonQuery(cmdTxt);
            this.m_db.Dispose();
        }
        public void Confirm(string LNO, string CFMID)
        {
            string conn = Training.Properties.Settings.Default.UOF.ToString();
            this.m_db = new Ede.Uof.Utility.Data.DatabaseHelper(conn);
            string cmdTxt = @"UPDATE LYN_BusinessTripReport SET CFMID = '" + CFMID + "', CFMDATE=getdate() WHERE LNO = '" + LNO + "' ";
            this.m_db.ExecuteNonQuery(cmdTxt);
            this.m_db.Dispose();
        }
    }
}
