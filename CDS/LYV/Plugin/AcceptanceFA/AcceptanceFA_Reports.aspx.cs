using System;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class LYN_AcceptanceFA_Reports : Ede.Uof.Utility.Page.BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string LYV = Request["LYV"];
            hfLYV.Value = LYV;

            ReportDocument rd = new ReportDocument();
            TableLogOnInfo connInfo = new TableLogOnInfo();
            rd.Load(Server.MapPath("~/CDS/LYV/Plugin/Report/AcceptanceFA.rpt"));
            connInfo.ConnectionInfo.ServerName = "192.168.23.11";
            connInfo.ConnectionInfo.DatabaseName = "UOF";
            connInfo.ConnectionInfo.UserID = "trinhky";
            connInfo.ConnectionInfo.Password = "It@123";

            for (int i = 0; i < rd.Database.Tables.Count; i++)
            {
                rd.Database.Tables[i].ApplyLogOnInfo(connInfo);
            }
            rd.SetParameterValue("LYV", hfLYV.Value);
            //xuất file định dạng pdf hoặc định dạng khác khi người dùng nhấn button download
            //định dạng mặc định trên chrome là .pdf

            rd.ExportToHttpResponse(ExportFormatType.PortableDocFormat, System.Web.HttpContext.Current.Response, false, hfLYV.Value);
        }

        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton1").Visible = false;
        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton2").Visible = false;
    }
}