﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ede.Uof.WKF.ExternalUtility;
using Training.BusinessTrip.UCO;

namespace Training.Trigger.BusinessTrip
{
    public class LYN_BusinessTrip_End : ICallbackTriggerPlugin
    {
        public void Finally()
        {
            //  throw new NotImplementedException();
        }

        public string GetFormResult(ApplyTask applyTask)
        {

            BusinessTripUCO uco = new BusinessTripUCO();
            string LNO = applyTask.FormNumber;
            string signStatus = applyTask.FormResult.ToString();

            uco.UpdateFormResult(LNO, signStatus);
            return "";
        }

        public void OnError(Exception errorException)
        {
            //  throw new NotImplementedException();
        }
    }
}
