﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;
using Ede.Uof.WKF.ExternalUtility;
using LYV.BusinessTrip.UCO;
using LYV.BusinessTripOD.UCO;

namespace LYV.Trigger.BusinessTripOD
{
    public class BusinessTripOD_Start : Ede.Uof.WKF.ExternalUtility.ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(Ede.Uof.WKF.ExternalUtility.ApplyTask applyTask)
        {
            BusinessTripODUCO uco = new BusinessTripODUCO();
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(applyTask.CurrentDocXML);

            string LYV = applyTask.Task.CurrentDocument.Fields["LYV"].FieldValue.ToString();
            string EmployeeType = applyTask.Task.CurrentDocument.Fields["EmployeeType"].FieldValue.ToString();
            string RequestDate = applyTask.Task.CurrentDocument.Fields["RequestDate"].FieldValue.ToString();
            string Type = applyTask.Task.CurrentDocument.Fields["Type"].FieldValue.ToString();
            string DepID = applyTask.Task.CurrentDocument.Fields["DepID"].FieldValue.ToString();
            string UserID = applyTask.Task.CurrentDocument.Fields["UserID"].FieldValue.ToString();
            UserID = UserID.Substring(UserID.IndexOf('(') + 4, UserID.IndexOf(')') - UserID.IndexOf('(') - 4);
            XElement xE = XElement.Parse(applyTask.Task.CurrentDocument.Fields["Form"].FieldValue.ToString());

            uco.InsertBusinessTripODFormData(LYV, EmployeeType, RequestDate, Type, DepID, UserID, xE);
            return "";

        }

        public void OnError(Exception errorException)
        {

        }
    }
}
