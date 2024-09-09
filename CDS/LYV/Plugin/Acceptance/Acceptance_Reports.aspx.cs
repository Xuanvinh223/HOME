using System;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class LYV_Acceptance_Reports : Ede.Uof.Utility.Page.BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string LYV = Request["LYV"];
            hfLYV.Value = LYV;

            ReportDocument rd = new ReportDocument();
            TableLogOnInfo connInfoUOF = new TableLogOnInfo();
            TableLogOnInfo connInfoERP = new TableLogOnInfo();
            rd.Load(Server.MapPath("~/CDS/LYV/Plugin/Report/Acceptance.rpt"));
            connInfoUOF.ConnectionInfo.ServerName = "192.168.23.11";
            connInfoUOF.ConnectionInfo.DatabaseName = "UOF";
            connInfoUOF.ConnectionInfo.UserID = "trinhky";
            connInfoUOF.ConnectionInfo.Password = "It@123";

            rd.Load(Server.MapPath("~/CDS/LYV/Plugin/Report/Acceptance.rpt"));
            connInfoERP.ConnectionInfo.ServerName = "192.168.40.37";
            connInfoERP.ConnectionInfo.DatabaseName = "TB_ERP";
            connInfoERP.ConnectionInfo.UserID = "sa";
            connInfoERP.ConnectionInfo.Password = "jack";

            for (int i = 0; i < 1; i++)
            {
                rd.Database.Tables[i].ApplyLogOnInfo(connInfoUOF);
            }

            for (int i = 1; i < rd.Database.Tables.Count; i++)
            {
                rd.Database.Tables[i].ApplyLogOnInfo(connInfoERP);
            }

            rd.SetParameterValue("LYV", hfLYV.Value);
            //xuất file định dạng pdf hoặc định dạng khác khi người dùng nhấn button download
            //định dạng mặc định trên chrome là .pdf

            rd.ExportToHttpResponse(ExportFormatType.PortableDocFormat, System.Web.HttpContext.Current.Response, false, hfLYV.Value);
        }

        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton1").Visible = false;
        //((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton2").Visible = false;
    }
}