using System;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class LYV_Leave_Reports : Ede.Uof.Utility.Page.BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string LNO = Request["LNO"];
            hfLNO.Value = LNO;

            ReportDocument rd = new ReportDocument();
            TableLogOnInfo connInfo = new TableLogOnInfo();
            rd.Load(Server.MapPath("~/CDS/LYV/Plugin/Report/rptLeave.rpt"));
            connInfo.ConnectionInfo.ServerName = "192.168.23.11";
            connInfo.ConnectionInfo.DatabaseName = "UOF";
            connInfo.ConnectionInfo.UserID = "trinhky";
            connInfo.ConnectionInfo.Password = "It@123";

            for (int i = 0; i < rd.Database.Tables.Count; i++)
            {
                rd.Database.Tables[i].ApplyLogOnInfo(connInfo);
            }
            rd.SetParameterValue("LNO", hfLNO.Value);
            //xuất file định dạng pdf hoặc định dạng khác khi người dùng nhấn button download
            //định dạng mặc định trên chrome là .pdf

            //crvLeave.ReportSource = rd;
            rd.ExportToHttpResponse(ExportFormatType.PortableDocFormat, System.Web.HttpContext.Current.Response, false, hfLNO.Value);
        }

        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton1").Visible = false;
        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton2").Visible = false;
    }
}