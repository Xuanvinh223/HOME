using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using Ede.Uof.WKF.ExternalUtility;
using Training.BusinessTrip.UCO;
using System.Xml.Linq;
using Ede.Uof.EIP.Organization.Util;

namespace Training.Trigger.BusinessTrip
{
    public class LYN_BusinessTrip_Flow : ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(ApplyTask applyTask)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(applyTask.CurrentDocXML);
            BusinessTripUCO uco = new BusinessTripUCO();
            string SiteCode = applyTask.SiteCode;
            string signStatus = applyTask.SignResult.ToString();

            string LNO = applyTask.Task.CurrentDocument.Fields["LYV"].FieldValue.ToString();
            string EmployeeType = applyTask.Task.CurrentDocument.Fields["EmployeeType"].FieldValue.ToString();
            string RequestDate = applyTask.Task.CurrentDocument.Fields["RequestDate"].FieldValue.ToString();
            string Type = applyTask.Task.CurrentDocument.Fields["Type"].FieldValue.ToString();
            XElement xE = XElement.Parse(applyTask.Task.CurrentDocument.Fields["Form"].FieldValue.ToString());

            uco.UpdateFormStatus(LNO, EmployeeType, RequestDate, Type, SiteCode, signStatus, xE);
            return "";
        }

        public void OnError(Exception errorException)
        {

        }
    }
}
