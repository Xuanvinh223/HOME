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
public class WebServiceLYV : System.Web.Services.WebService
{

    public WebServiceLYV()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string CheckOutData(string formInfo)
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

        // Lấy giá trị từ XML
        try
        {
            // Lấy giá trị từ các node XML
            XmlNode lynOutNode = xmlDoc.SelectSingleNode("/Form/FormFieldValue/FieldItem[@fieldId='Form']/LYN_Out");

            if (lynOutNode == null)
            {
                throw new Exception("Node LYN_Out không tồn tại.");
            }

            string leaveTimeString = lynOutNode.Attributes["LeaveTime"]?.Value;
            string returnTimeString = lynOutNode.Attributes["ReturnTime"]?.Value;
            string type = lynOutNode.Attributes["Type"]?.Value;
            string category = lynOutNode.Attributes["Category"]?.Value;
            string item = lynOutNode.Attributes["Item"]?.Value;
            string reason = lynOutNode.Attributes["Reason"]?.Value;
            string account = lynOutNode.Attributes["Account"]?.Value;
            string person = lynOutNode.Attributes["Person"]?.Value;

            // Kiểm tra các giá trị bắt buộc
            if (string.IsNullOrEmpty(leaveTimeString) || string.IsNullOrEmpty(returnTimeString) ||
                string.IsNullOrEmpty(category) || string.IsNullOrEmpty(item) || string.IsNullOrEmpty(person))
            {
                throw new Exception("Một hoặc nhiều trường bắt buộc đang thiếu hoặc trống.");
            }

            if (!DateTime.TryParse(leaveTimeString, out DateTime leaveTime))
            {
                throw new Exception("Định dạng Giờ ra không hợp lệ.");
            }

            if (!DateTime.TryParse(returnTimeString, out DateTime returnTime))
            {
                throw new Exception("Định dạng Giờ vào không hợp lệ.");
            }

            if (returnTime < leaveTime)
            {
                throw new Exception("Giờ vào không thể sớm hơn Giờ ra.");
            }

            // Chuyển đổi Person thành số nguyên và khởi tạo Dictionary
            int personCount = Convert.ToInt32(person);

            for (int i = 0; i < personCount; i++)
            {
                XmlNode node = lynOutNode.SelectSingleNode($"LYN_Out_{i}");

                if (node == null)
                {
                    throw new Exception($"Node LYN_Out_{i} không tồn tại.");
                }

                var id = node.Attributes["ID"]?.Value;
                var name = node.Attributes["Name"]?.Value;
                var factory = node.Attributes["Factory"]?.Value;
                var department = node.Attributes["Department"]?.Value;

                if (string.IsNullOrEmpty(name))
                {
                    throw new Exception($"Vui lòng nhập tên người ra cổng thứ {i + 1}");
                }
                // Viết bắt lỗi thêm ở đây :)))))
            }

            // Thực hiện xử lý sau khi kiểm tra thành công
            returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "1";
        }
        catch (Exception ex)
        {
            // Xử lý lỗi và trả về kết quả thất bại
            returnValueElement.SelectSingleNode("/ReturnValue/Exception/Message").InnerText = ex.Message;
            returnValueElement.SelectSingleNode("/ReturnValue/Status").InnerText = "0";
        }

        return returnValueElement.OuterXml;
    }

}

