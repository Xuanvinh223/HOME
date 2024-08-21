<%@ WebService Language="C#" Class="WebServiceLYV_Acceptance" %>

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
public class WebServiceLYV_Acceptance : System.Web.Services.WebService
{

    [WebMethod]
    public string Checked_Null(string formInfo)
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
        Training.LYVAcceptance.UCO.AccpetanceUCO uco = new Training.LYVAcceptance.UCO.AccpetanceUCO();
        DataTable dt = new DataTable();

        try
        {
            string PurchaseRequestNo = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Acceptance']/LYN_AcceptancePlugin").Attributes["PurchaseRequestNo"].Value.ToString();
            string RKNO = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Acceptance']/LYN_AcceptancePlugin").Attributes["RKNO"].Value.ToString();
            dt = uco.GetData(RKNO);

            if (PurchaseRequestNo.Equals(""))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng nhập Số phiếu đơn xin đặt mua! 請購單單號!";
            }
            else if (RKNO.Equals(""))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng nhập Số phiếu nhập kho! 入庫單單號!";
            }
            else if (dt is null || dt.Rows.Count == 0)
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Không tìm thấy mã : " + RKNO;
            }
            else
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
            }

        }
        catch (Exception ce)
        {
            returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
            returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = ce.Message;
        }
        return returnValueElement.OuterXml;


    }

}

