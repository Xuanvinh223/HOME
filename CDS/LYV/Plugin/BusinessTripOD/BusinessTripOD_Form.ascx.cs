using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Ede.Uof.WKF.Design;
using Ede.Uof.EIP.Organization.Util;
using Ede.Uof.EIP.SystemInfo;
using System.Xml.Linq;
using DocumentFormat.OpenXml.Spreadsheet;
using Ede.Uof.Utility.Page.Common;
using System.Dynamic;
using System.Net;

public partial class WKF_BusinessTripOD_Form : WKF_FormManagement_VersionFieldUserControl_VersionFieldUC
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
            Name_DepID.Attributes["DepID"] = "";
            DateTime today = DateTime.Today;
            DateTime defaultStartTime = new DateTime(today.Year, today.Month, today.Day, 7, 30, 0);
            DateTime defaultEndTime = new DateTime(today.Year, today.Month, today.Day, 16, 30, 0);
            STime.Text = DateTime.ParseExact("07:30", "HH:mm", null).ToString("HH:mm");
            ETime.Text = DateTime.ParseExact("16:30", "HH:mm", null).ToString("HH:mm");

            Time.Text = defaultStartTime.ToString("yyyy-MM-dd");
            SetField(m_versionField);
        }
    }
    protected void TransportTypeChanged(object sender, EventArgs e)
    {
        if (TransportType.SelectedValue == "Xe hơi")
        {
            ApplyCar.Checked = true;
        }
        else
        {
            ApplyCar.Checked = false;
        }
    }
    protected void TransportTypeSelect(object sender, EventArgs e)
    {
        if (TransportType.SelectedValue == "5")
        {
            ptkhac.Text = "";
            ptkhac.Visible = true;
        }
        else
        {
            ptkhac.Visible = false;
        }
    }
    public void SearchDep_Click(object sender, EventArgs e)
    {
        if (Dep.Visible == false)
        {
            DV_MA_Search.Text = "";
            DV_TEN_Search.Text = "";
            Dep.Visible = true;
            LoadDataDep();
        }
        else
            Dep.Visible = false;
    }
    public void gvDep_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvDep.DataSource = (DataTable)ViewState["formsDT"];
        gvDep.DataBind();
        gvDep.PageIndex = e.NewPageIndex;
        gvDep.DataBind();
    }
    protected void gvDep_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gvDep.SelectedRow != null)
        {
            Name_DepID.Attributes["DepID"] = gvDep.SelectedRow.Cells[0].Text;
            Name_DepID.Text = System.Web.HttpUtility.HtmlDecode(gvDep.SelectedRow.Cells[1].Text); // Lấy giá trị từ cột đầu tiên
            Name_ID.Text = "";
            Name.Text = "";
            Dep.Visible = false;                                                     // Thêm các cột khác nếu cần
        }
    }
    protected void gvDep_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvDep, "Select$" + e.Row.RowIndex);
            e.Row.Attributes["style"] = "cursor:pointer";
        }
    }
    public void DV_Search_TextChanged(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)ViewState["formsDT"];
        if (!string.IsNullOrEmpty(DV_MA_Search.Text))
        {
            DataView dv = new DataView(dt);
            dv.RowFilter = $"DV_MA LIKE '%{DV_MA_Search.Text}%'";
            gvDep.DataSource = dv;
        }
        else if (!string.IsNullOrEmpty(DV_TEN_Search.Text))
        {
            DataView dv = new DataView(dt);
            dv.RowFilter = $"DV_TEN LIKE '%{DV_TEN_Search.Text}%'";
            gvDep.DataSource = dv;
        }
        else
        {
            gvDep.DataSource = dt;
        }
        gvDep.DataBind();
    }
    private void LoadDataDep()
    {
        LYV.BusinessTripOD.UCO.BusinessTripODUCO uco = new LYV.BusinessTripOD.UCO.BusinessTripODUCO();
        DataTable dt = uco.GetDep();
        gvDep.DataSource = dt;
        ViewState["formsDT"] = dt;
        gvDep.DataBind();
    }
    public void Name_ID_TextChanged(object sender, EventArgs e)
    {
        if (Name_ID.Text == "")
        {
            Name_DepID.Text = "";
            Name_DepID.Attributes["DepID"] = "";
            Name_ID.Text = "";
            Name.Text = "";
            return;
        }
        LYV.BusinessTripOD.UCO.BusinessTripODUCO uco = new LYV.BusinessTripOD.UCO.BusinessTripODUCO();
        string data = uco.GetEmployee(Name_ID.Text);
        string UserName = data.Split(";")[0];
        string UserDep = data.Split(";")[1];
        string qexpert = data.Split(";")[2];
        if (UserName == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Nhân viên này không tồn tại | 此工號不在選擇的部門內或不存在')", true);
            Name_DepID.Text = "";
            Name_DepID.Attributes["DepID"] = "";
            Name_ID.Text = "";
            Name.Text = "";
        }
        else
        {
            DataTable dt = uco.GetDep();
            DataView dv = new DataView(dt);
            dv.RowFilter = $"DV_MA LIKE '%{UserDep}%'";
            gvDep.DataSource = dv;
            gvDep.DataBind();
            Name_DepID.Attributes["DepID"] = gvDep.Rows[0].Cells[0].Text;
            Name_DepID.Text = System.Web.HttpUtility.HtmlDecode(gvDep.Rows[0].Cells[1].Text);
            Name.Text = UserName;
        }
    }
    public void Agent_ID_TextChanged(object sender, EventArgs e)
    {
        if (Agent_ID.Text == "")
        {
            Agent_ID.Text = "";
            Agent.Text = "";
            return;
        }
        LYV.BusinessTripOD.UCO.BusinessTripODUCO uco = new LYV.BusinessTripOD.UCO.BusinessTripODUCO();
        string data = uco.GetEmployee(Agent_ID.Text);
        string UserName = data.Split(";")[0];
        string Flag = data.Split(";")[2];
        if (UserName == "")
        {
            Agent_ID.Text = "";
            Agent.Text = "";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Nhân viên này không tồn tại | 此工號不在選擇的部門內或不存在')", true);
        }
        else
        {
            Agent.Text = UserName;
        }
    }
    public double DateDifference(string StartDate, string EndDate)
    {
        DateTime SDate = DateTime.ParseExact(StartDate, "yyyy-MM-dd HH:mm", null).Date;
        DateTime EDate = DateTime.ParseExact(EndDate, "yyyy-MM-dd HH:mm", null).Date;

        TimeSpan difference = EDate - SDate;
        double totalDays = difference.TotalDays + 1; // Số ngày giữa hai ngày

        // Kiểm tra từng ngày trong khoảng thời gian
        for (DateTime date = SDate; date <= EDate; date = date.AddDays(1))
        {
            // Nếu ngày là cuối tuần (thứ 7 hoặc chủ nhật) hoặc là ngày nghỉ (có thể tùy chỉnh)
            if (date.DayOfWeek == DayOfWeek.Sunday)
            {
                totalDays--; // Loại bỏ ngày cuối tuần
            }
            // Nếu ngày là ngày nghỉ khác (có thể thêm các điều kiện kiểm tra khác tại đây)
        }

        return totalDays;
    }
    public void Time_TextChanged(object sender, EventArgs e)
    {
        string Date = Time.Text;
        if (Date != "")
        {
            Days.Text = "1";
        }
        else
        {
            Days.Text = "0";
        }
    }
    public void Print_Click(object sender, EventArgs e)
    {
        ExpandoObject param = new { LYV = hfLYV.Value }.ToExpando();
        Dialog.Open2(Print, "~/CDS/LYV/Plugin/BusinessTripOD/BusinessTripOD_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
    }
    /// <summary>
    /// 外掛欄位的條件值
    /// </summary>
    public override string ConditionValue
    {
        get
        {
            if ("Applicant,ReturnToApplicant,ReturnApplicant".IndexOf((string)ViewState["fieldMode"]) == -1)
            {
                return (string)ViewState["customCondition"];
            }
            else
            {
                string account = Current.UserGUID;
                string group = ApplicantGroupId;
                LYV.BusinessTripOD.UCO.BusinessTripODUCO uco = new LYV.BusinessTripOD.UCO.BusinessTripODUCO();
                string LEV = uco.GetLEV(account, group);
                string Expert = "N";
                return LEV + Expert;
            }
        }
        set
        {
            base.ConditionValue = value;
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
            if ("Applicant,ReturnToApplicant,ReturnApplicant".IndexOf((string)ViewState["fieldMode"]) == -1)
            {
                return (string)ViewState["customField"];
            }
            else
            {
                XElement TPElement = new XElement("LYV_BusinessTripOD_Form");

                TPElement.Add(new XAttribute("Name_ID", Name_ID.Text));
                TPElement.Add(new XAttribute("Name", Name.Text));
                TPElement.Add(new XAttribute("Name_DepID", Name_DepID.Attributes["DepID"].ToString()));
                TPElement.Add(new XAttribute("Name_DepName", Name_DepID.Text));
                TPElement.Add(new XAttribute("Agent_ID", Agent_ID.Text));
                TPElement.Add(new XAttribute("Agent", Agent.Text));
                TPElement.Add(new XAttribute("Purpose", Purpose.Text));
                TPElement.Add(new XAttribute("FLocation", FLocation.Text));
                TPElement.Add(new XAttribute("Journey", Journey.Text));
                TPElement.Add(new XAttribute("STime", STime.Text));
                TPElement.Add(new XAttribute("ETime", ETime.Text));
                TPElement.Add(new XAttribute("Days", Days.Text));
                TPElement.Add(new XAttribute("documents", documents.Text));
                TPElement.Add(new XAttribute("Time", Time.Text));
                TPElement.Add(new XAttribute("SelectType", TransportType.SelectedValue));


                // nếu bằng phương tiện khác lấy dữ liệu phương tiện đó
                if (TransportType.SelectedValue == "5")
                {
                    TPElement.Add(new XAttribute("TransportType", ptkhac.Text));
                }
                else
                {
                    TPElement.Add(new XAttribute("TransportType", TransportType.SelectedValue));
                }

                if (ApplyCar.Checked == true)
                {
                    TPElement.Add(new XAttribute("ApplyCar", "1"));
                }
                else
                {
                    TPElement.Add(new XAttribute("ApplyCar", "0"));
                }

                TPElement.Add(new XAttribute("Remark", Remark.Text));

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
        SearchDep.Enabled = Enabled;
        Name_ID.Enabled = Enabled;
        Agent_ID.Enabled = Enabled;
        Purpose.Enabled = Enabled;
        FLocation.Enabled = Enabled;
        Journey.Enabled = Enabled;
        Time.Enabled = Enabled;
        Days.Enabled = Enabled;
        TransportType.Enabled = Enabled;
        ApplyCar.Enabled = Enabled;
        Remark.Enabled = Enabled;
        STime.Enabled = Enabled;
        ETime.Enabled = Enabled;

        ptkhac.Enabled = Enabled;
        documents.Enabled = Enabled;
        ptkhac.Visible = false;
    }
    private void SetCustomField(XElement xeTP)
    {
        Name_ID.Text = xeTP.Attribute("Name_ID").Value;
        Name.Text = xeTP.Attribute("Name").Value;
        Name_DepID.Attributes["DepID"] = xeTP.Attribute("Name_DepID").Value;
        Name_DepID.Text = xeTP.Attribute("Name_DepName").Value;
        Agent_ID.Text = xeTP.Attribute("Agent_ID").Value;
        Agent.Text = xeTP.Attribute("Agent").Value;
        Purpose.Text = xeTP.Attribute("Purpose").Value;
        FLocation.Text = xeTP.Attribute("FLocation").Value;
        Journey.Text = xeTP.Attribute("Journey").Value;
        Days.Text = xeTP.Attribute("Days").Value;
       
        Time.Text = xeTP.Attribute("Time").Value;
        if (xeTP.Attribute("STime") != null)
        {
            STime.Text = xeTP.Attribute("STime").Value;
        }
        if (xeTP.Attribute("ETime") != null)
        {
            ETime.Text = xeTP.Attribute("ETime").Value;
        }

        AnTransportType.SelectedValue = xeTP.Attribute("TransportType").Value;
        if (AnTransportType.SelectedValue == "Xe hơi" || AnTransportType.SelectedValue == "Máy bay" ||
                AnTransportType.SelectedValue == "Thuyền" || AnTransportType.SelectedValue == "Xe buýt")
        {
            ptkhac.Visible = false;
            TransportType.SelectedValue = xeTP.Attribute("TransportType").Value;
        }
        else
        {
            ptkhac.Visible = true;
            TransportType.SelectedValue = xeTP.Attribute("SelectType").Value;
            ptkhac.Text = xeTP.Attribute("TransportType").Value;
        }

        TransportType.SelectedValue = xeTP.Attribute("TransportType").Value;
        if (xeTP.Attribute("ApplyCar").Value == "1")
        {
            ApplyCar.Checked = true;
        }
        else
        {
            ApplyCar.Checked = false;
        }

        Remark.Text = xeTP.Attribute("Remark").Value;
        if (hfTASK_RESULT.Value.ToString() == "Reject" || hfTASK_RESULT.Value.ToString() == "Cancel")
        {
            pPrint.Visible = false;
        }
        else
        {
            ExpandoObject param = new { LYV = hfLYV.Value }.ToExpando();
            Dialog.Open2(Print, "~/CDS/LYV/Plugin/BusinessTripOD/BusinessTripOD_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
            pPrint.Visible = true;
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
            ViewState["customCondition"] = fieldOptional.ConditionValue;
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
                    hfLYV.Value = base.taskObj.FormNumber;
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
                //己送出

                //有填過
                if (fieldOptional.Filler != null)
                {
                    //判斷填寫的站點和當前是否相同
                    if (base.taskObj != null && base.taskObj.CurrentSite != null &&
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

            switch (fieldOptional.FieldMode)
            {
                case FieldMode.Print:
                case FieldMode.View:
                    //觀看和列印都需作沒有權限的處理
                    EnabledControl(false);
                    break;
                case FieldMode.Signin:
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