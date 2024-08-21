<%@ WebService Language="C#" Class="WebServiceLYV" %>

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
public class WebServiceLYV  : System.Web.Services.WebService {

    public WebServiceLYV()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string CheckLeaveData(string formInfo)
    {
        /*<Form formVersionId="93b660c4-b8a6-496b-8597-65525cfd186e">
            <FormFieldValue>
            <FieldItem fieldId="LYV" fieldValue="" realValue="" enableSearch="True" />
            <FieldItem fieldId="UserID" fieldValue="Tony(Tony)" realValue="&lt;UserSet&gt;&lt;Element type='user'&gt; &lt;userId&gt;c496e32b-0968-4de5-95fc-acf7e5a561c0&lt;/userId&gt;&lt;/Element&gt;&lt;/UserSet&gt;&#xD;&#xA;" enableSearch="True" />
            <FieldItem fieldId="Factory" fieldValue="A" realValue="" enableSearch="True" customValue="@null" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
            <FieldItem fieldId="DepID" fieldValue="研發一部" realValue="2c3feec0-c47e-b3d2-9b62-053be7cac613,研發一部,False" enableSearch="True" />
            <FieldItem fieldId="Form" ConditionValue="" realValue="">
                <LYN_Leave_Form DepartmentID="VP.ITPM-ERP" 
					            LeaverID="111404" 
					            LeaverName="HUỲNH TRUNG TÍN" 
					            DeputyID="105540" 
					            DeputyName="LÊ TRẦN TRƯỜNG THANH" 
					            Type="P" 
					            TotalDay="1" 
					            TotalHour="0" 
					            StartDate="2023-11-30" 
					            StartTime="07:30" 
					            EndDate="2023-11-30" 
					            EndTime="16:30" 
					            Reason="123" 
					            Remark="" />
            </FieldItem>
            </FormFieldValue>
        </Form>*/
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
            if (xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["DepartmentID"].Value == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng chọn phòng ban của nhân viên!";
            }
            else if (xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["LeaverID"].Value == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng chọn mã nhân viên!";
            }
            else if (xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["Type"].Value == "Default")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng chọn loại nghỉ phép!";
            }
            else if (xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["Reason"].Value == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng nhập lý do!";
            }
            else if (xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["StartDate"].Value == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng chọn ngày bắt đầu nghỉ phép!";
            }
            else if (xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["EndDate"].Value == "")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng chọn ngày kết thúc nghỉ phép!";
            }
            else if (Convert.ToDateTime(xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["StartDate"].Value) > Convert.ToDateTime(xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["EndDate"].Value))
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Vui lòng chọn đúng ngày nghỉ phép!";
            }
            else if (xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["Lock"].Value == "true")
            {
                returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
                returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Nhân viên đã bị khóa chấm công!";
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

    [WebMethod]
    public string IfElseCheck_KhoaSo(string formInfo)
    {
        /*<Form formVersionId="93b660c4-b8a6-496b-8597-65525cfd186e">
            <FormFieldValue>
            <FieldItem fieldId="LYV" fieldValue="" realValue="" enableSearch="True" />
            <FieldItem fieldId="UserID" fieldValue="Tony(Tony)" realValue="&lt;UserSet&gt;&lt;Element type='user'&gt; &lt;userId&gt;c496e32b-0968-4de5-95fc-acf7e5a561c0&lt;/userId&gt;&lt;/Element&gt;&lt;/UserSet&gt;&#xD;&#xA;" enableSearch="True" />
            <FieldItem fieldId="Factory" fieldValue="A" realValue="" enableSearch="True" customValue="@null" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
            <FieldItem fieldId="DepID" fieldValue="研發一部" realValue="2c3feec0-c47e-b3d2-9b62-053be7cac613,研發一部,False" enableSearch="True" />
            <FieldItem fieldId="Form" ConditionValue="" realValue="">
                <LYN_Leave_Form DepartmentID="VP.ITPM-ERP" 
					            LeaverID="111404" 
					            LeaverName="HUỲNH TRUNG TÍN" 
					            DeputyID="105540" 
					            DeputyName="LÊ TRẦN TRƯỜNG THANH" 
					            Type="P" 
					            TotalDay="1" 
					            TotalHour="0" 
					            StartDate="2023-11-30" 
					            StartTime="07:30" 
					            EndDate="2023-11-30" 
					            EndTime="16:30" 
					            Reason="123" 
					            Remark="" />
            </FieldItem>
            </FormFieldValue>
        </Form>*/
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
            Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();
            string ID = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["LeaverID"].Value;
            string SDate = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Leave_Form").Attributes["StartDate"].Value;

            //string Lock = uco.Check_KhoaSo(ID, SDate);

            //string result=xmlDoc.SelectSingleNode("/Form/SignInfo").Attributes["SignResult"].Value.ToString();
            //if (result == "Approve")
            //{
            //    if (Lock == "true")
            //    {
            //        returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
            //        returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "Employee has been locked out of timekeeping!";
            //    }
            //    else
            //    {
            //        returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
            //    }
            //}else
            //{
            //    returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
            //}

        }
        catch (Exception ce)
        {
            returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
            returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = ce.Message;
        }

        return returnValueElement.OuterXml;
    }

    [WebMethod]
    public string CheckHRMData(string formInfo)
    {

        formInfo = HttpUtility.UrlDecode(formInfo);

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
            Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(formInfo);

            string LYV = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='LYV']").Attributes["fieldValue"].Value;

            //string CheckHRM= uco.CheckHRMData(LYV);

            //string result=xmlDoc.SelectSingleNode("/Form/SignInfo").Attributes["SignResult"].Value.ToString();
            //if (result == "Approve")
            //{
            //    if (CheckHRM == "false")
            //    {
            //        returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
            //        returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = "相關日期有請假資料則不通過檢核，退回上一關!";
            //    }
            //    else
            //    {
            //        returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
            //    }
            //}else
            //{
            //    returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
            //}
        }
        catch (Exception ce)
        {
            returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
            returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = ce.Message;
        }

        return returnValueElement.OuterXml;
    }
}

