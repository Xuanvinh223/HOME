using System;
using System.Xml;
using Ede.Uof.WKF.ExternalUtility;
using LYV.BusinessTripOD.UCO;
using System.Xml.Linq;

namespace LYV.Trigger.BusinessTripOD
{
    public class BusinessTripOD_Flow : ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(ApplyTask applyTask)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(applyTask.CurrentDocXML);
            string SiteCode = applyTask.SiteCode;
            string signStatus = applyTask.SignResult.ToString();

            string LNO = applyTask.Task.CurrentDocument.Fields["LYV"].FieldValue.ToString();
            //string Area = applyTask.Task.CurrentDocument.Fields["Area"] == null ? "" : applyTask.Task.CurrentDocument.Fields["Area"].FieldValue.ToString();
            string MaPhieu = applyTask.Task.CurrentDocument.Fields["MaPhieu"].FieldValue.ToString();

            XElement xE = XElement.Parse(applyTask.Task.CurrentDocument.Fields["Form"].FieldValue.ToString());

            BusinessTripODUCO uco = new BusinessTripODUCO();

            uco.UpdateFormStatus(LNO, "Area", SiteCode, signStatus, MaPhieu, xE);
            return "";
        }

        public void OnError(Exception errorException)
        {

        }
    }
}
