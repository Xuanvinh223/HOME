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
//[System.Web.Script.Services.ScriptService]
public class WebServiceLYN : System.Web.Services.WebService
{

    public WebServiceLYN()
    {

    }

    [WebMethod]
    public string CheckBusinessTrip(string formInfo)
    {
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
            // Giải mã thông tin từ URL
            formInfo = HttpUtility.UrlDecode(formInfo);

            // Tạo đối tượng XmlDocument và tải XML từ formInfo
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(formInfo);

            // Lấy dữ liệu từ XML
            string Name_ID = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Name_ID"].Value;
            string Agent_ID = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Agent_ID"].Value;
            string Purpose = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Purpose"].Value;
            string FLocation = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["FLocation"].Value;
            string Journey = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Journey"].Value;
            string Days = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Days"].Value;
            string ETime = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["ETime"].Value;
            string TransportType = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["TransportType"].Value;
            string SelectType = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["SelectType"].Value;

            // Kiểm tra và thiết lập thông báo lỗi
            if (string.IsNullOrEmpty(Name_ID))
            {
                statusElement.InnerText = "0";
                messageElement.InnerText = "Please select the ID user!";
            }
            else if (string.IsNullOrEmpty(Agent_ID))
            {
                statusElement.InnerText = "0";
                messageElement.InnerText = "Please select the ID user!";
            }
            else if (Name_ID == Agent_ID)
            {
                statusElement.InnerText = "0";
                messageElement.InnerText = "ID No duplicates!";
            }
            else if (string.IsNullOrEmpty(Purpose))
            {
                statusElement.InnerText = "0";
                messageElement.InnerText = "Please select the Purpose!";
            }
            else if (string.IsNullOrEmpty(FLocation))
            {
                statusElement.InnerText = "0";
                messageElement.InnerText = "Please select the Location!";
            }
            else if (string.IsNullOrEmpty(Journey))
            {
                statusElement.InnerText = "0";
                messageElement.InnerText = "Please select the Journey!";
            }
            else if (Days == "0" || (string.IsNullOrWhiteSpace(Days) && !string.IsNullOrEmpty(ETime)))
            {
                statusElement.InnerText = "0";
                messageElement.InnerText = "Please select the correct Date Time!";
            }
            else if (TransportType == "Default")
            {
                statusElement.InnerText = "0";
                messageElement.InnerText = "Please select the TransportType!";
            }
            else if (SelectType == "5")
            {
                if (string.IsNullOrEmpty(TransportType))
                {
                    statusElement.InnerText = "0";
                    messageElement.InnerText = "Please input the TransportType!";
                }
                else
                {
                    statusElement.InnerText = "1";
                }
            }
            else if (TransportType == "Máy bay" || TransportType == "Thuyền")
            {
                string rmk = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYV_BusinessTrip_Form").Attributes["Remark"].Value;
                if (string.IsNullOrEmpty(rmk))
                {
                    statusElement.InnerText = "0";
                    messageElement.InnerText = "Please input the Remark!";
                }
                else
                {
                    statusElement.InnerText = "1";
                }
            }
            else
            {
                statusElement.InnerText = "1";
            }

        }
        catch (Exception ex)
        {
            statusElement.InnerText = "0";
            messageElement.InnerText = ex.Message;
        }

        return returnValueElement.OuterXml;
    }

}

