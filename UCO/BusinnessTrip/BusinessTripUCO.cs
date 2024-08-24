using System.Data;
using LYV.BusinessTrip.PO;
using System.Xml.Linq;

namespace LYV.BusinessTrip.UCO
{
    public  class BusinessTripUCO
    {
        BusinessTripPO m_BusinessTripPO = new BusinessTripPO();

        public string GetType(string LYV)
        {
            return m_BusinessTripPO.GetType(LYV);
        }

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
        public void InsertBusinessTripFormData(string LYV, string employeeType, string RequestDate, string type, string DepID, string UserID, XElement xE)
        {
            m_BusinessTripPO.InsertBusinessTripFormData(LYV, employeeType, RequestDate, type, DepID, UserID, xE);
        }
        public void UpdateFormStatus(string LYV, string EmployeeType, string RequestDate, string Type, string SiteCode, string signStatus, XElement xE)
        {
            m_BusinessTripPO.UpdateFormStatus(LYV, EmployeeType, RequestDate,Type, SiteCode, signStatus, xE);
        }

        public void UpdateFormResult(string LNO, string formResult)
        {
            m_BusinessTripPO.UpdateFormResult(LNO, formResult);
        }
        public DataTable GetWSSignNextInfo(string DOC_NBR, string siteName, string UserGUID)
        {
            return m_BusinessTripPO.getWSSignNextInfo(DOC_NBR, UserGUID);
        }
        public DataTable GetListBT(string LNO, string Type, string RLNO, string Name, string Name_ID, string BTime1, string BTime2)
        {
            return m_BusinessTripPO.GetListBT( LNO,  Type,  RLNO,  Name,  Name_ID,  BTime1,  BTime2);
        }
    }
}
