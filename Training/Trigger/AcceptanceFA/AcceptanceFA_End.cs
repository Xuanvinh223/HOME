using System;
using Ede.Uof.WKF.ExternalUtility;
using LYV.AcceptanceFA.UCO;

namespace LYV.Trigger.AcceptanceFA
{
    public class AcceptanceFA_End : ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(ApplyTask applyTask)
        {
           
            AcceptanceFAUCO uco = new AcceptanceFAUCO();
            string LYV = applyTask.FormNumber;
            string signStatus = applyTask.FormResult.ToString();

            uco.UpdateFormResult(LYV, signStatus);
            return "";
        }

        public void OnError(Exception errorException)
        {

        }
    }
}
 