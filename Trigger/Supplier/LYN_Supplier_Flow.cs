using Ede.Uof.WKF.ExternalUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using Training.Supplier.UCO;

namespace Training.Trigger.Supplier
{
    public class LYN_Supplier_Flow : ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(ApplyTask applyTask)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(applyTask.CurrentDocXML);
            SupplierUCO uco = new SupplierUCO();
            uco.UpdateFormStatus(applyTask);
            return "";
        }

        public void OnError(Exception errorException)
        {

        }
    }
}
