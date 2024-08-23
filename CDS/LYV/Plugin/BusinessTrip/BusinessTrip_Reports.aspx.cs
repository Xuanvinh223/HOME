using System;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using LYV.BusinessTrip.UCO;

public partial class WKF_BusinessTrip_Reports : Ede.Uof.Utility.Page.BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            BusinessTripUCO uco = new BusinessTripUCO();
            ReportDocument rd = new ReportDocument();
            TableLogOnInfo connInfo = new TableLogOnInfo();

            string LYV = Request["LYV"];
            string Type = uco.GetType(hfLNO.Value);

            if (Type == "Trong nước")
            {
                rd.Load(Server.MapPath("~/CDS/LYV/Plugin/Report/BusinessTripTN.rpt"));
            }
            else
            {
                rd.Load(Server.MapPath("~/CDS/LYV/Plugin/Report/BusinessTripNN.rpt"));
            }

            connInfo.ConnectionInfo.ServerName = "192.168.23.11";
            connInfo.ConnectionInfo.DatabaseName = "UOF";
            connInfo.ConnectionInfo.UserID = "trinhky";
            connInfo.ConnectionInfo.Password = "It@123";

            for (int i = 0; i < rd.Database.Tables.Count; i++)
            {
                rd.Database.Tables[i].ApplyLogOnInfo(connInfo);
            }
            rd.SetParameterValue("LYV", LYV);

            crvBusinessTrip.ReportSource = rd;

            //Xuất báo cáo sang PDF
            rd.ExportToHttpResponse(ExportFormatType.PortableDocFormat, System.Web.HttpContext.Current.Response, false, LYV);
        }

        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton1").Visible = false;
        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton2").Visible = false;
    }
}