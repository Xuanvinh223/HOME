using System.Data;
using LYV.AcceptanceFA.PO;
using System.Xml.Linq;

namespace LYV.AcceptanceFA.UCO
{
    public  class AcceptanceFAUCO
    {
        AcceptanceFAPO AcceptanceFAPO = new AcceptanceFAPO();


        public DataTable GetData(string RKNO)
        {
            return AcceptanceFAPO.GetData(RKNO);
        }
        public DataTable GetGridView_Close(string LNO, string RKNO, string ListType, string Sdate, string Edate, string status)
        {
            return AcceptanceFAPO.GetGridView_Close( LNO,  RKNO,  ListType,  Sdate,  Edate,status);
        }

        public void InsertData_BeginForm(string LNO, string ListType, string AcceptanceDate, string Department, string Applicant, string Description, string PropertyNumbers, XElement xE)
        {
            AcceptanceFAPO.InsertData_BeginForm(LNO, ListType, AcceptanceDate, Department, Applicant, Description, PropertyNumbers,xE);
        }
        public void UpdateFormStatus(string LNO, string SiteCode,string signStatus, string ListType, string AcceptanceDate, string Department, string Applicant, string Description, string PropertyNumbers,  XElement xE)
        {
            AcceptanceFAPO.UpdateFormStatus(LNO, SiteCode, signStatus, ListType, AcceptanceDate, Department, Applicant, Description, PropertyNumbers, xE);
        }
        public void UpdateFormResult(string LNO, string formResult)
        {
            AcceptanceFAPO.UpdateFormResult(LNO, formResult);
        }

        public string getFlowflag(string LNO)
        {
            return AcceptanceFAPO.getFlowflag(LNO);
        }

    }
}
