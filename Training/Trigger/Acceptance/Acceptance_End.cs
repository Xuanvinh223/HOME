using Ede.Uof.WKF.ExternalUtility;
using System;
using LYV.Acceptance.UCO;
namespace LYV.Trigger.Acceptance
{
    internal class Acceptance_End : ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(ApplyTask applyTask)
        {

            AccpetanceUCO uco = new AccpetanceUCO();
            string LNO = applyTask.FormNumber;
            string signStatus = applyTask.FormResult.ToString();

            uco.UpdateFormResult(LNO, signStatus);
            return "";
        }

        public void OnError(Exception errorException)
        {

        }
    }
}
