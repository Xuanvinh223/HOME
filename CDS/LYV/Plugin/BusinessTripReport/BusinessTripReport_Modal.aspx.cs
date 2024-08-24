using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ede.Uof.Utility.Page.Common;
using System.Data;
using System.Security.Cryptography;
using Ede.Uof.WKF.Utility;
using Ede.Uof.EIP.Organization.Util;
using Ede.Uof.EIP.SystemInfo;
using System.Text;
using System.Dynamic;
using System.Web.UI.HtmlControls;
using System.Xml;

public partial class WKF_BusinessTripReport_Modal : Ede.Uof.Utility.Page.BasePage
{

	#region ==============公開方法及屬性==============
    //表單設計時
	//如果為False時,表示是在表單設計時
    private bool m_ShowGetValueButton = true;
    public bool ShowGetValueButton
    {
        get { return this.m_ShowGetValueButton; }
        set { this.m_ShowGetValueButton = value; }
    }

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string LYV = Request["LYV"];
            ViewState["LYV"] = LYV;
            lbLNO.Text = LYV;
        }
        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton2").Visible = false;
        ((Master_DialogMasterPage)this.Master).Button1OnClick += CDS_WebPage_Dialog_Button1OnClick;
    }
    void CDS_WebPage_Dialog_Button1OnClick()
    {
        string LYV = ViewState["LYV"].ToString();
        LYV.BusinessTripReport.UCO.BusinessTripReportUCO uco = new LYV.BusinessTripReport.UCO.BusinessTripReportUCO();
        if (CancelReason.Text.Trim() == "")
        {
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert('請輸入註銷原因 Please enter the reason for cancellation')", true);
        }
        else
        {
            uco.UpdateCancelReason(LYV, CancelReason.Text);
        }
        Dialog.SetReturnValue2("OK");
        Dialog.Close(this);
    }
}