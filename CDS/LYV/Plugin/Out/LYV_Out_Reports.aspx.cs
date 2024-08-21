using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class LYV_Out_Reports : Ede.Uof.Utility.Page.BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string LNO = Request["LNO"];
            hfLNO.Value = LNO;

            ReportDocument rd = new ReportDocument();
            TableLogOnInfo connInfo = new TableLogOnInfo();
            rd.Load(Server.MapPath("~/CDS/LYV/Plugin/Report/rptOut.rpt"));
            connInfo.ConnectionInfo.ServerName = "192.168.40.37";
            connInfo.ConnectionInfo.DatabaseName = "TB_ERP";
            connInfo.ConnectionInfo.UserID = "sa";
            connInfo.ConnectionInfo.Password = "jack";

            for (int i = 0; i < rd.Database.Tables.Count; i++)
            {
                rd.Database.Tables[i].ApplyLogOnInfo(connInfo);
            }
            rd.SetParameterValue("LNO", hfLNO.Value);
            //xuất file định dạng pdf hoặc định dạng khác khi người dùng nhấn button download
            //định dạng mặc định trên chrome là .pdf

            //crvOut.ReportSource = rd;
            rd.ExportToHttpResponse(ExportFormatType.PortableDocFormat, System.Web.HttpContext.Current.Response, false, hfLNO.Value);
        }

        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton1").Visible = false;
        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton2").Visible = false;
    }
}