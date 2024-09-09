using System;
using System.Xml;
using System.Xml.Linq;
using Ede.Uof.WKF.ExternalUtility;
using LYV.AcceptanceFA.UCO;

namespace LYV.Trigger.AcceptanceFA
{
    public class AcceptanceFA_Flow : ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(ApplyTask applyTask)
        {
            
            AcceptanceFAUCO uco = new AcceptanceFAUCO();

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(applyTask.CurrentDocXML);
            string SiteCode = applyTask.SiteCode;
            string signStatus = applyTask.SignResult.ToString();

            string LYV = applyTask.Task.CurrentDocument.Fields["LYV"].FieldValue.ToString();
            string ListType = applyTask.Task.CurrentDocument.Fields["ListType"].FieldValue.ToString();
            string AcceptanceFADate = applyTask.Task.CurrentDocument.Fields["AcceptanceDate"].FieldValue.ToString();
            string Department = applyTask.Task.CurrentDocument.Fields["Department"].FieldValue.ToString();
            string Applicant = applyTask.Task.CurrentDocument.Fields["Applicant"].FieldValue.ToString();
            string Description = applyTask.Task.CurrentDocument.Fields["Description"].FieldValue.ToString();
            string PropertyNumbers = applyTask.Task.CurrentDocument.Fields["PropertyNumbers"].FieldValue.ToString();
         


            XElement xE = XElement.Parse(applyTask.Task.CurrentDocument.Fields["AcceptanceFA"].FieldValue.ToString());

            uco.UpdateFormStatus( LYV,  SiteCode, signStatus, ListType, AcceptanceFADate, Department, Applicant, Description, PropertyNumbers,  xE);
            return "";
        }

        public void OnError(Exception errorException)
        {

        }
    }
}
