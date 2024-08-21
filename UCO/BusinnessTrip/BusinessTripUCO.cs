using System.Data;
using Training.BusinessTrip.PO;
using System.Xml.Linq;

namespace Training.BusinessTrip.UCO
{
    public  class BusinessTripUCO
    {
        BusinessTripPO m_BusinessTripPO = new BusinessTripPO();

        public string GetLEV(string UserID, string groupID)
        {
            return m_BusinessTripPO.GetLEV(UserID, groupID);
        }
        public string GetMaPhieu(string Type)
        {
            return m_BusinessTripPO.GetMaPhieu(Type);
        }
        public DataTable GetDep()
        {
            return m_BusinessTripPO.GetDep();
        }
        public string GetEmployee(string UserID)
        {
            return m_BusinessTripPO.GetEmployee(UserID);
        }
        public void InsertBusinessTripFormData(string LNO, string employeeType, string RequestDate, string type, string DepID, string UserID, XElement xE)
        {
            m_BusinessTripPO.InsertBusinessTripFormData(LNO, employeeType, RequestDate, type, DepID, UserID, xE);
        }
        public void UpdateFormStatus(string LNO, string EmployeeType, string RequestDate, string Type, string SiteCode, string signStatus, XElement xE)
        {
            m_BusinessTripPO.UpdateFormStatus(LNO, EmployeeType, RequestDate,Type, SiteCode, signStatus, xE);
        }

        public void UpdateFormResult(string LNO, string formResult)
        {
            m_BusinessTripPO.UpdateFormResult(LNO, formResult);
        }
        public DataTable GetWSSignNextInfo(string DOC_NBR, string siteName, string UserGUID)
        {
            return m_BusinessTripPO.getWSSignNextInfo(DOC_NBR, UserGUID);
        }
        public DataTable GetListBT(string LNO, string Type, string RLNO, string Name, string Name_ID, string BTime1, string BTime2, string expert)
        {
            return m_BusinessTripPO.GetListBT(LNO, Type, RLNO, Name, Name_ID, BTime1, BTime2, expert);
        }
    }
}
