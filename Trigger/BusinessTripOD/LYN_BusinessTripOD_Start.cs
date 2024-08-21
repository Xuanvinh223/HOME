using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;
using Ede.Uof.WKF.ExternalUtility;
using Training.BusinessTripOD.UCO;

namespace Training.Trigger.BusinessTripOD
{
    public class LYN_BusinessTripOD_Start : Ede.Uof.WKF.ExternalUtility.ICallbackTriggerPlugin
    {
        public void Finally()
        {

        }

        public string GetFormResult(Ede.Uof.WKF.ExternalUtility.ApplyTask applyTask)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(applyTask.CurrentDocXML);

            string LNO = applyTask.Task.CurrentDocument.Fields["LNO"].FieldValue.ToString();
            string Area = applyTask.Task.CurrentDocument.Fields["Area"] == null ? "" : applyTask.Task.CurrentDocument.Fields["Area"].FieldValue.ToString();
            string UserID = applyTask.Task.CurrentDocument.Fields["UserID"].FieldValue.ToString();
            UserID= UserID.Substring(UserID.IndexOf('(')+4, UserID.IndexOf(')')- UserID.IndexOf('(')-4);

            XElement xE = XElement.Parse(applyTask.Task.CurrentDocument.Fields["Form"].FieldValue.ToString());

            BusinessTripODUCO uco = new BusinessTripODUCO();

            TaskUtility taskUtility = new TaskUtility();
            string taskID = applyTask.TaskId;
            string expert = xE.Attribute("expert").Value;
            string MaPhieu = "";
            if (expert == "N")
            {
                MaPhieu=uco.GetMaPhieu();
                taskUtility.UpdateTaskContent(false, taskID, "MaPhieu", MaPhieu, "");
            }
            /// <summary>
            /// 修改目前表單內容
            /// </summary> 
            /// <param name="IsOptionalField">是否為外掛欄位</param>
            /// <param name="taskId">表單TASK_ID</param>
            /// <param name="fieldId">欄位代號</param>
            /// <param name="fieldValue">欄位內容(新的內容)</param>
            /// <param name="realValue">表單真實的值(for欄位式站點,傳入NULL代表不變動)</param> 
            /// 更新C23888資料
            taskUtility.UpdateTaskContent(false, taskID, "expert", expert, "");
            uco.InsertBusinessTripODFormData(LNO, Area, UserID, xE, MaPhieu);

            return "";
        }

        public void OnError(Exception errorException)
        {

        }
    }
}
