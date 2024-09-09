using System;
using System.Xml;
using System.Xml.Linq;
using LYV.AcceptanceFA.UCO;

namespace LYV.Trigger.AcceptanceFA

{
    public class AcceptanceFA_Start : Ede.Uof.WKF.ExternalUtility.ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(Ede.Uof.WKF.ExternalUtility.ApplyTask applyTask)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(applyTask.CurrentDocXML);
            string LYV = applyTask.FormNumber;
            string ListType = applyTask.Task.CurrentDocument.Fields["ListType"].FieldValue.ToString();
            string AcceptanceFADate = applyTask.Task.CurrentDocument.Fields["AcceptanceDate"].FieldValue.ToString();
            string Department = applyTask.Task.CurrentDocument.Fields["Department"].FieldValue.ToString();
            string Applicant = applyTask.Task.CurrentDocument.Fields["Applicant"].FieldValue.ToString();
            string Description = applyTask.Task.CurrentDocument.Fields["Description"].FieldValue.ToString();
            string PropertyNumbers = applyTask.Task.CurrentDocument.Fields["PropertyNumbers"].FieldValue.ToString();
            
           
            string SIGN_STATIS = applyTask.SiteCode;
            XElement xE = XElement.Parse(applyTask.Task.CurrentDocument.Fields["AcceptanceFA"].FieldValue.ToString());
            AcceptanceFAUCO uco = new AcceptanceFAUCO();

            uco.InsertData_BeginForm(LYV, ListType, AcceptanceFADate, Department, Applicant, Description, PropertyNumbers, xE);

            return "";
        }

        public void OnError(Exception errorException)
        {

        }
    }
}
