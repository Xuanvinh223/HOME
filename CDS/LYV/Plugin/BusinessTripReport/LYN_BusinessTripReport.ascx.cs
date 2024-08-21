using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Ede.Uof.WKF.Design;
using System.Collections.Generic;
using Ede.Uof.WKF.Utility;
using Ede.Uof.EIP.Organization.Util;
using Ede.Uof.WKF.Design.Data;
using Ede.Uof.WKF.VersionFields;
using System.Xml;
using System.Linq;
using Ede.Uof.EIP.SystemInfo;
using System.Xml.Linq;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Runtime.InteropServices;
using System.ComponentModel;
using System.Text;
using System.Globalization;
using DocumentFormat.OpenXml.Spreadsheet;
using Ede.Uof.Utility.Page.Common;
using System.Dynamic;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class WKF_BusinessTripReport : WKF_FormManagement_VersionFieldUserControl_VersionFieldUC
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
		//這裡不用修改
		//欄位的初始化資料都到SetField Method去做
        if (!Page.IsPostBack)
        {
            BindEmptyDataToGridView();
            SetField(m_versionField);
        }
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        int pageSize;
        if (int.TryParse(ddlPageSize.SelectedValue, out pageSize))
        {
            gvBT.PageSize = pageSize;
            gvBT.DataSource = (DataTable)ViewState["formsDT"];
            gvBT.DataBind();
        }
    }
    private void BindEmptyDataToGridView()
    {
        DataTable dtEmpty = new DataTable();
        ViewState["formsDT"] = dtEmpty;
        gvBT.DataSource = dtEmpty;
        gvBT.DataBind();
    }
    private void LoadDataBT()
    {
        string LNO = qLNO.Text;
        string Name = qName.Text;
        string Name_ID = qName_ID.Text;
        string BTime1 = qBTime1.Text;
        string BTime2 = qBTime2.Text;
        string expert = "N";

        if (qexpert.Checked)
        {
            expert = "Y";
        }

        LYN.BusinessTripReport.UCO.BusinessTripReportUCO uco = new LYN.BusinessTripReport.UCO.BusinessTripReportUCO();

        DataTable dt = uco.GetListBT(LNO, Name, Name_ID, BTime1, BTime2, expert);
        ViewState["formsDT"] = dt;
        gvBT.DataSource = dt;
        gvBT.DataBind();
    }
    protected void gvBT_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //show the checkbox only when "pending" mode
            HtmlInputCheckBox cb = (HtmlInputCheckBox)e.Row.FindControl("CheckBox");
            cb.Visible = false;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView row = (DataRowView)e.Row.DataItem;

            LinkButton btnLNO = (LinkButton)e.Row.FindControl("btnLNO");
            ExpandoObject param = new { TASK_ID = row["TASK_ID"].ToString() }.ToExpando();
            //Grid開窗是用RowDataBound事件再開窗
            Dialog.Open2(btnLNO, "~/WKF/FormUse/ViewForm.aspx", "", 1500, 800, Dialog.PostBackType.None, param);

            HtmlInputCheckBox cb = (HtmlInputCheckBox)e.Row.FindControl("CheckBox");
            if (!pnQuery.Visible)
            {
                cb.Visible = false;
            }
            else
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvBT, "Select$" + e.Row.RowIndex);

                // Lấy giá trị của thuộc tính DataKey từ GridView
                string dataKey = gvBT.DataKeys[e.Row.RowIndex].Values["LNO"].ToString();

                // Lấy danh sách đã chọn từ ViewState
                List<string> checkedGUIDs = ViewState["CheckedGUIDs"] as List<string> ?? new List<string>();

                // Kiểm tra xem giá trị "LNO" có nằm trong danh sách đã chọn hay không
                bool isChecked = checkedGUIDs.Contains(dataKey);

                // Tìm ô checkbox trong dòng hiện tại

                // Đặt thuộc tính Checked cho ô checkbox
                if (cb != null)
                {
                    cb.Checked = isChecked;
                }
            }
        }
    }
    protected void gvBT_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvBT.DataSource = (DataTable)ViewState["formsDT"];
        gvBT.DataBind();
        gvBT.PageIndex = e.NewPageIndex;
        gvBT.DataBind();
    }
    protected void gvBT_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        // Lấy danh sách các "LLNO" đã chọn từ ViewState
        List<string> checkedGUIDs = ViewState["CheckedGUIDs"] as List<string> ?? new List<string>();
        if (e.NewSelectedIndex >= 0)
        {
            HtmlInputCheckBox chkBox = (HtmlInputCheckBox)gvBT.Rows[e.NewSelectedIndex].FindControl("CheckBox");
            // Lấy giá trị của thuộc tính DataKey từ GridView
            string dataKey = gvBT.DataKeys[e.NewSelectedIndex].Values["LNO"].ToString();

            // Kiểm tra xem đã chọn hay chưa
            bool isChecked = checkedGUIDs.Contains(dataKey);

            // Thực hiện các thao tác cần thiết dựa trên giá trị isChecked
            if (isChecked && chkBox != null && !chkBox.Checked)
            {
                checkedGUIDs.Remove(dataKey);
                // Ô checkbox đã được chọn, thực hiện xử lý
            }
            else if (!isChecked && chkBox != null && chkBox.Checked)
            {
                checkedGUIDs.Add(dataKey);
                // Ô checkbox không được chọn, thực hiện xử lý
            }
        }
        else
        {
            HtmlInputCheckBox chkBox = (HtmlInputCheckBox)gvBT.HeaderRow.FindControl("CheckBox");
            if (ViewState["formsDT"] is DataTable dataTable)
            {
                foreach (DataRow row in dataTable.Rows)
                {
                    // Lấy giá trị của thuộc tính DataKey từ GridView
                    string dataKey = row["LNO"].ToString();

                    bool isChecked = checkedGUIDs.Contains(dataKey);

                    // Thực hiện các thao tác cần thiết dựa trên giá trị isChecked
                    if (isChecked && chkBox != null && !chkBox.Checked)
                    {
                        checkedGUIDs.Remove(dataKey);
                        // Ô checkbox đã được chọn, thực hiện xử lý
                    }
                    else if (!isChecked && chkBox != null && chkBox.Checked)
                    {
                        checkedGUIDs.Add(dataKey);
                        // Ô checkbox không được chọn, thực hiện xử lý
                    }
                }
            }

        }
        ViewState["CheckedGUIDs"] = checkedGUIDs;
    }
    public void Query_Click(object sender, EventArgs e)
    {
        List<string> checkedGUIDs = new List<string>();
        ViewState["CheckedGUIDs"] = checkedGUIDs;
        LoadDataBT();
    }
    public void Clear_Click(object sender, EventArgs e)
    {
        qLNO.Text = "";
        qName.Text = "";
        qName_ID.Text = "";
        qBTime1.Text = "";
        qBTime2.Text = "";
        qexpert.Checked = false;
    }
    protected string GetGridViewChecked()
    {
        string result = "";
        string checkedGUID = "";

        List<string> checkedGUIDs = ViewState["CheckedGUIDs"] as List<string> ?? new List<string>();

        if (checkedGUIDs.Count > 0)
        {
            for (int i = 0; i < checkedGUIDs.Count; i++)
            {
                string dataKey = checkedGUIDs[i].ToString();
                checkedGUID += "," + dataKey;
            }
        }

        // Xử lý kết quả và trả về
        if (checkedGUID.Length > 0)
            result = checkedGUID.Substring(1);

        return result;
    }
    public void Print_Click(object sender, EventArgs e)
    {
        ExpandoObject param = new { LNO = hfLNO.Value }.ToExpando();
        Dialog.Open2(Print, "~/CDS/LYN/Plugin/BusinessTripReport/LYN_BusinessTripReport_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
    }
    public void Disable_Click(object sender, EventArgs e)
    {
        string LNO = hfLNO.Value.ToString();
        LYN.BusinessTripReport.UCO.BusinessTripReportUCO uco = new LYN.BusinessTripReport.UCO.BusinessTripReportUCO();
        string Status = uco.GetBusinessTripReport(LNO);
        if (Status == "cfm")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('This BusinessTripReport has been confirm.')", true);
        }
        else if (Status == "cancel")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('This BusinessTripReport has been canceled')", true);
        }
        else
        {
            ExpandoObject param = new { LNO = hfLNO.Value }.ToExpando();
            Dialog.Open2(Disable, "~/CDS/LYN/Plugin/BusinessTripReport/LYN_BusinessTripReport_Modal.aspx", "註銷外出單", 950, 600, Dialog.PostBackType.None, param);
        }
    }
    public void Approve_Click(object sender, EventArgs e)
    {
        string LNO = hfLNO.Value.ToString();
        LYN.BusinessTripReport.UCO.BusinessTripReportUCO uco = new LYN.BusinessTripReport.UCO.BusinessTripReportUCO();
        string Status = uco.GetBusinessTripReport(LNO);
        if (Status == "cfm")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('This BusinessTripReport has been confirm.')", true);
        }
        else if (Status == "cancel")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('This BusinessTripReport has been canceled')", true);
        }
        else
        {
            uco.Confirm(LNO, Current.Account.Replace("LYN", ""));
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('This BusinessTripReport has confirm')", true);
        }
    }

    /// <summary>
    /// 外掛欄位的條件值
    /// </summary>
    public override string ConditionValue
    {
        get
        {
			//回傳字串
			//此字串的內容將會被表單拿來當做條件判斷的值
			return String.Empty;
        }
    }

    /// <summary>
    /// 是否被修改
    /// </summary>
    public override bool IsModified
    {
        get
        {
			//請自行判斷欄位內容是否有被修改
			//有修改回傳True
			//沒有修改回傳False
            //若實作產品標準的控制修改權限必需實作
            //一般是用 m_versionField.FieldValue (表單開啟前的值)
            //      和this.FieldValue (當前的值) 作比對
			return false;
        }
    }

    /// <summary>
    /// 查詢顯示的標題
    /// </summary>
    public override string DisplayTitle
    {
        get
        {
            //表單查詢或WebPart顯示的標題
            //回傳字串
            return String.Empty;
            //return "<table><tr><td>balabala</td></tr></table>";
        }
    }

    /// <summary>
    /// 訊息通知的內容
    /// </summary>
    public override string Message
    {
        get
        {
			//表單訊息通知顯示的內容
			//回傳字串
            return String.Empty;
            //return "<table><tr><td>123456</td></tr></table>";
        }
    }


    /// <summary>
    /// 真實的值
    /// </summary>
    public override string RealValue
    {
        get
        {
            //回傳字串
			//取得表單欄位簽核者的UsetSet字串
            //內容必須符合EB UserSet的格式
			return String.Empty;
        }
        set
        {
			//這個屬性不用修改
            base.m_fieldValue = value;
        }
    }


    /// <summary>
    /// 欄位的內容
    /// </summary>
    public override string FieldValue
    {
        get
        {
            if ("Applicant".IndexOf((string)ViewState["fieldMode"]) == -1)
            {
                return (string)ViewState["customField"];
            }
            else
            {
                XElement TPElement = new XElement("LYN_BusinessTripReport");
                string key = GetGridViewChecked();
                TPElement.Add(new XAttribute("Account", Current.Account));
                TPElement.Add(new XAttribute("BLNO", key));
                return TPElement.ToString();
            }
            
        }
        set
        {
			//這個屬性不用修改
            base.m_fieldValue = value;
        }
    }

    /// <summary>
    /// 是否為第一次填寫
    /// </summary>
    public override bool IsFirstTimeWrite
    {
        get
        {
            //這裡請自行判斷是否為第一次填寫
            //若實作產品標準的控制修改權限必需實作
            //實作此屬性填寫者可修改也才會生效
            //一般是用 m_versionField.Filler == null(沒有記錄填寫者代表沒填過)
            //      和this.FieldValue (當前的值是否為預設的空白) 作比對
            return false;
        }
        set
        {
            //這個屬性不用修改
            base.IsFirstTimeWrite = value;
        }
    }

    /// <summary>
    /// 設定元件狀態
    /// </summary>
    /// <param name="Enabled">是否啟用輸入元件</param>
    public void EnabledControl(bool Enabled)
    {
    }
   private void SetCustomField(XElement xeTP)
    {
        //< FieldItem fieldId = "C99" ConditionValue = "" realValue = "" >
        //  < TestPlugin Type = "456" />
        //</ FieldItem >
        string key = xeTP.Attribute("BLNO").Value;
        LYN.BusinessTripReport.UCO.BusinessTripReportUCO uco = new LYN.BusinessTripReport.UCO.BusinessTripReportUCO();
        if (key != "")
        {
            pnQuery.Visible = false;
            string[] dsBLNO = key.Split(",");
            string BLNO = "'" + dsBLNO[0] + "'";
            if (dsBLNO.Length > 1)
            {
                for (int i = 1; i < dsBLNO.Length; i++)
                {
                    BLNO += ", '" + dsBLNO[i] + "'";
                }
            }
            DataTable dt = uco.GetBusinessTripReport_BLNO(BLNO);
            ViewState["formsDT"] = dt;
            gvBT.DataSource = dt;
            gvBT.DataBind();
        }

        string Account = xeTP.Attribute("Account").Value;
        string LNO = hfLNO.Value.ToString();
        string Status = uco.GetBusinessTripReport(LNO);
        if (Status == "cancel")
        {
            pPrint.Visible = false;
            pDisable.Visible = false;
            pApprove.Visible = false;
            lTitle.Text = "Cancel";
            lTitle.ForeColor = System.Drawing.Color.Red;
            lTitle.Visible = true;
        }
        else if (Status == "cfm")
        {
            pPrint.Visible = true;
            pDisable.Visible = false;
            pApprove.Visible = false;
            lTitle.Text = "Confirm";
            lTitle.ForeColor = System.Drawing.Color.Blue;
            lTitle.Visible = true;
        }
        else
        {
            lTitle.Visible = false;
            if (Account == Current.Account)
            {
                pPrint.Visible = true;
                ExpandoObject param1 = new { LNO = hfLNO.Value }.ToExpando();
                Dialog.Open2(Print, "~/CDS/LYN/Plugin/BusinessTripReport/LYN_BusinessTripReport_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param1);
                pDisable.Visible = true;
                pApprove.Visible = false;
            }
            else if (Current.Account == "LYN07713")
            {
                pPrint.Visible = true;
                ExpandoObject param1 = new { LNO = hfLNO.Value }.ToExpando();
                Dialog.Open2(Print, "~/CDS/LYN/Plugin/BusinessTripReport/LYN_BusinessTripReport_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param1);
                pDisable.Visible = false;
                pApprove.Visible = true;
            }
            else
            {
                pPrint.Visible = true;
                pDisable.Visible = false;
                pApprove.Visible = false;
            }
        }
    }
    /// <summary>
    /// 顯示時欄位初始值
    /// </summary>
    /// <param name="versionField">欄位集合</param>
    public override void SetField(Ede.Uof.WKF.Design.VersionField versionField)
    {
        FieldOptional fieldOptional = versionField as FieldOptional;
        ViewState["fieldMode"] = fieldOptional.FieldMode.ToString();
        
        switch (fieldOptional.FieldMode)
        {
            case FieldMode.Design:
                break;
            default:

                break;
        }
        //lbPath.Text = base.taskObj.CurrentSite.SiteId;
        if (fieldOptional != null)
        {
            UserUCO userUco = new UserUCO();
            EBUser ebuser = userUco.GetEBUser(Current.UserGUID);
            string userAccount = ebuser.Account;
            ViewState["customField"] = fieldOptional.FieldValue;
            //判斷FieldValue是否有值
            if (!string.IsNullOrEmpty(fieldOptional.FieldValue))
            {
                //get value from xml(非申請模式下，抓XML的值，因為匯率有可能會改變，要保持原有的資料)
                //如果要抓即時的匯率計算，就不要call SetCustomField()
                switch (fieldOptional.FieldMode)
                {
                    case FieldMode.Signin:
                    case FieldMode.Print:
                    case FieldMode.View:
                        break;
                }
                if (base.taskObj != null)
                {
                    hfLNO.Value = base.taskObj.FormNumber;
                    hfTASK_RESULT.Value = base.taskObj.TaskResult.ToString();
                }
                SetCustomField(XElement.Parse(fieldOptional.FieldValue));
            }
            else
            {
                
                //沒有申請資料，第一次載入

            }
            //草稿
            if (!fieldOptional.IsAudit)
            {
                if(fieldOptional.HasAuthority)
                {
                    //有填寫權限的處理
                    EnabledControl(true);
                }
                else
                {
                    //沒填寫權限的處理
                    EnabledControl(false);
                }
            }
            else
            {
                //己送出

                //有填過
                if(fieldOptional.Filler != null)
                {
                    //判斷填寫的站點和當前是否相同
                    if(base.taskObj != null && base.taskObj.CurrentSite != null &&
                        base.taskObj.CurrentSite.SiteId == fieldOptional.FillSiteId && fieldOptional.Filler.UserGUID == Ede.Uof.EIP.SystemInfo.Current.UserGUID)
                    {
                        //判斷填寫權限
                        if (fieldOptional.HasAuthority)
                        {
                            //有填寫權限的處理
                            EnabledControl(true);
                        }
                        else
                        {
                            //沒填寫權限的處理
                            EnabledControl(false);
                        }
                    }
                    else
                    {
        
                            //沒修改權限的處理
                            EnabledControl(false);

                    }
                }
                else
                {
                    //判斷填寫權限
                    if (fieldOptional.HasAuthority)
                    {
                        //有填寫權限的處理
                        EnabledControl(true);
                    }
                    else
                    {
                        //沒填寫權限的處理
                        EnabledControl(false);
                    }

                }
            }

            switch(fieldOptional.FieldMode)
            {
                case FieldMode.Print:
                case FieldMode.View:
                    //觀看和列印都需作沒有權限的處理
                    EnabledControl(false);
                    break;

            }
            
            #region ==============屬性說明==============『』
			//fieldOptional.IsRequiredField『是否為必填欄位,如果是必填(True),如果不是必填(False)』
			//fieldOptional.DisplayOnly『是否為純顯示,如果是(True),如果不是(False),一般在觀看表單及列印表單時,屬性為True』
			//fieldOptional.HasAuthority『是否有填寫權限,如果有填寫權限(True),如果沒有填寫權限(False)』
			//fieldOptional.FieldValue『如果已有人填寫過欄位,則此屬性為記錄其內容』
			//fieldOptional.FieldDefault『如果欄位有預設值,則此屬性為記錄其內容』
			//fieldOptional.FieldModify『是否允許修改,如果允許(fieldOptional.FieldModify=FieldModifyType.yes),如果不允許(fieldOptional.FieldModify=FieldModifyType.no)』
			//fieldOptional.Modifier『如果欄位有被修改過,則Modifier的內容為EBUser,如果沒有被修改過,則會等於Null』
            #endregion

            //#region ==============如果沒有填寫權限時,就要顯示有填寫權限人員的清單,只要把以下註解拿掉即可==============
            //if (!fieldOptional.HasAuthority『是否有填寫權限)
            //{
            //    string strItemName = String.Empty;
            //    Ede.Uof.EIP.Organization.Util.UserSet userSet = ((FieldOptional)versionField).FieldControlData;

            //    for (int i = 0; i < userSet.Items.Count; i++)
            //    {
            //        if (i == userSet.Items.Count - 1)
            //        {
            //            strItemName += userSet.Items[i].Name;
            //        }
            //        else
            //        {
            //            strItemName += userSet.Items[i].Name + "、";
            //        }
            //    }

            //    lblHasNoAuthority.ToolTip = lblAuthorityMsg.Text + "：" + strItemName;
            //}
            //#endregion

            #region ==============如果有修改，要顯示修改者資訊==============
            if (fieldOptional.Modifier != null)
            {
                lblModifier.Visible = true;
                lblModifier.ForeColor = System.Drawing.Color.FromArgb(0x52, 0x52, 0x52);
                lblModifier.Text = System.Web.Security.AntiXss.AntiXssEncoder.HtmlEncode(fieldOptional.Modifier.Name, true);
            } 
            #endregion
        }
    }

}