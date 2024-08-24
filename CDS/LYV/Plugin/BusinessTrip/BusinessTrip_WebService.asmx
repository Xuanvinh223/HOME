<%@ WebService Language="C#" Class="WebServiceLYN" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Xml;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
// [System.Web.Script.Services.ScriptService]
public class WebServiceLYN  : System.Web.Services.WebService {

    public WebServiceLYN()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string CheckBusinessTrip(string formInfo)
    {
        formInfo = HttpUtility.UrlDecode(formInfo);

        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.LoadXml(formInfo);

        XmlDocument returnXmlDoc = new XmlDocument();
        XmlElement returnValueElement = returnXmlDoc.CreateElement("ReturnValue");
        XmlElement statusElement = returnXmlDoc.CreateElement("Status");
        XmlElement exceptionElement = returnXmlDoc.CreateElement("Exception");
        XmlElement messageElement = returnXmlDoc.CreateElement("Message");

        returnValueElement.AppendChild(statusElement);
        exceptionElement.AppendChild(messageElement);
        returnValueElement.AppendChild(exceptionElement);
        returnXmlDoc.AppendChild(returnValueElement);

        try
        {
            string Name_ID = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Name_ID"].Value.ToString();
            string Agent_ID = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Agent_ID"].Value.ToString();

            string Purpose = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Purpose"].Value.ToString();
            string FLocation = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["FLocation"].Value.ToString();
            string Journey = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Journey"].Value.ToString();

            string Days = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Days"].Value.ToString();
            string ETime = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["ETime"].Value.ToString();

            string TransportType = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["TransportType"].Value.ToString();
            string SelectType = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["SelectType"].Value.ToString();

            if (Name_ID == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please select the ID user !";
            }
            else if (Agent_ID == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please select the ID user !";
            }else if (Name_ID == Agent_ID)
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "ID No duplicates !";
            }
            else if (Purpose == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please select the Purpose !";
            }
            else if (FLocation == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please select the Location !";
            }
            else if (Journey == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please select the Journey !";
            }
            else if (Days == "0" || (Days.Trim() == "" && ETime != ""))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please select the correct Date Time !";
            }
            else if (TransportType == "Default")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please select the TransportType !";
            }
            else if (SelectType == "5")
            {
                if (TransportType == "")
                {
                    returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                    returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please input the TransportType !";
                }
                else
                {
                    returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
                }
            }
            else if (TransportType == "Máy bay" || TransportType == "Thuyền")
            {
                string rmk = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_LYV_BusinessTrip_Form").Attributes["Remark"].Value.ToString();
                if (rmk == "")
                {
                    returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                    returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Please input the Remark !";
                }
                else
                {
                    returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
                }
            }
            else
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
            }

        }
        catch (Exception ce)
        {
            returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
            //returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = ce.Message;
            returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = formInfo;
        }
        return returnValueElement.OuterXml;
    }
}

