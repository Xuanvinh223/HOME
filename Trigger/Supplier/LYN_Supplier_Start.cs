using Ede.Uof.EIP.Organization.Util;
using Ede.Uof.EIP.SystemInfo;
using Ede.Uof.WKF.ExternalUtility;
using System;
using System.Xml;
using Training.Supplier.UCO;

namespace Training.Trigger.Supplier
{
    public class LYN_Supplier_Start : Ede.Uof.WKF.ExternalUtility.ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(Ede.Uof.WKF.ExternalUtility.ApplyTask applyTask)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(applyTask.CurrentDocXML);
            string USERID = applyTask.Task.CurrentDocument.Fields["USERID"].FieldValue.ToString();
            USERID = USERID.Substring(USERID.IndexOf('(') + 4, USERID.IndexOf(')') - USERID.IndexOf('(') - 4);
            SupplierUCO uco = new SupplierUCO();
            uco.InsertTaskData(applyTask, USERID);
            return "";
        }

     
        public void OnError(Exception errorException)
        {

        }
    }
}
