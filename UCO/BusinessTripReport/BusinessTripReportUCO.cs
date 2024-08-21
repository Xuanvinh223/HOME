using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Training.BusinessTripReport.PO;
using Training.Data;
using System.Xml.Linq;

namespace Training.BusinessTripReport.UCO
{
    public  class BusinessTripReportUCO
    {
        BusinessTripReportPO m_BusinessTripReportPO = new BusinessTripReportPO();

        public DataTable GetListBT(string LNO, string Name, string Name_ID, string BTime1, string BTime2, string expert)
        {
            return m_BusinessTripReportPO.GetListBT(LNO, Name, Name_ID, BTime1, BTime2, expert);
        }
        public DataTable GetBusinessTripReport_BLNO(string BLNO)
        {
            return m_BusinessTripReportPO.GetBusinessTripReport_BLNO(BLNO);
        }
        public void InsertBusinessTripReportData(string LNO, string UserID, string Department, string Date, string Date1, string Name, string Destination, string Description, XElement xE)
        {
            m_BusinessTripReportPO.InsertBusinessTripReportData(LNO, UserID, Department, Date, Date1, Name, Destination, Description, xE);
        }
        public string GetBusinessTripReport(string LNO)
        {
            return m_BusinessTripReportPO.GetBusinessTripReport(LNO);
        }
        public void UpdateCancelReason(string LNO, string CancelReason)
        {
            m_BusinessTripReportPO.UpdateCancelReason(LNO, CancelReason);
        }
        public void Confirm(string LNO, string CFMID)
        {
            m_BusinessTripReportPO.Confirm(LNO, CFMID);
        }
    }
}
