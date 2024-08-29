<%@ WebService Language="C#" Class="SupplierService" %>

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
public class SupplierService : System.Web.Services.WebService
{


    [WebMethod]
    public string Validation(string formInfo)
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
            string Type = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["Type"].Value;
            string SupplierID = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["SupplierID"].Value;
            string SupplierName = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["SupplierName"].Value;
            string CompanyAddress = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["CompanyAddress"].Value;
            string FactoryAddress = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["FactoryAddress"].Value;
            string Product = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["Product"].Value;
            string Established = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["Established"].Value;
            string License = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["License"].Value;
            string PersonInCharge = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["PersonInCharge"].Value;
            string ContactPerson = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["ContactPerson"].Value;
            string Tel = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["Tel"].Value;
            string Fax = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["Fax"].Value;
            string Email = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/Supplier").Attributes["Email"].Value;
            if (Type == "default")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入公司類型 Vui lòng chọn loại!";

            }
            else if (String.IsNullOrEmpty(SupplierID))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入公司代號 Vui lòng nhập mã số công ty";

            }
            else if (String.IsNullOrEmpty(SupplierName))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入公司名稱 Vui lòng nhập tên công ty";

            }
            else if (String.IsNullOrEmpty(CompanyAddress))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入公司地址 Vui lòng nhập địa chỉ công ty";

            }
            else if (String.IsNullOrEmpty(FactoryAddress))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入工廠地址 Vui lòng nhập địa chỉ nhà máy";

            }
            else if (String.IsNullOrEmpty(Product))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入主要產品 Vui lòng nhập sản phẩm chủ yếu";

            }
            else if (String.IsNullOrEmpty(Established))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入創業時間 Vui lòng nhập thời gian thành lập";

            }
            else if (String.IsNullOrEmpty(License))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入營業執照 Vui lòng nhập giấy đăng ký kinh doanh!";

            }
            else if (String.IsNullOrEmpty(PersonInCharge))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "請輸入負責人 Vui lòng nhập đầy người phụ trách!";

            }
            else
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";

            }
            return returnValueElement.OuterXml;
        }
        catch (Exception ce)
        {
            returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
            returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = ce.Message;
            return returnValueElement.OuterXml;
        }


    }




}

