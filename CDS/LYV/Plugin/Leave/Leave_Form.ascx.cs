using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ede.Uof.WKF.Design;
using Ede.Uof.EIP.Organization.Util;
using Ede.Uof.EIP.SystemInfo;
using System.Xml.Linq;
using DocumentFormat.OpenXml.Spreadsheet;
using Ede.Uof.Utility.Page.Common;
using System.Dynamic;
using LYV.Leave.UCO;
public partial class CDS_LYV_Plugin_Leave_LYV_Leave_Form : WKF_FormManagement_VersionFieldUserControl_VersionFieldUC
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
            Year.Items.Add(new ListItem(String.Empty, String.Empty));

            for (int year = DateTime.Now.Year - 10; year <= DateTime.Now.Year; year++)
            {
                Year.Items.Add(new ListItem(year.ToString()));
            }
            DepartmentID.Attributes["DepID"] = "";
            StartTime.Text = DateTime.ParseExact("07:30", "HH:mm", null).ToString("HH:mm");
            EndTime.Text = DateTime.ParseExact("16:30", "HH:mm", null).ToString("HH:mm");
            SetField(m_versionField);

            if (LeaverID.Text != "")
            {
                ID.Text = LeaverID.Text;
            }

            int Month = DateTime.Now.Month;
            if (Month < 10)
            {
                Label_LeaveM.Text = "Số Ngày Nghỉ Phép Tháng 0" + Month.ToString() + " &nbsp;｜";
                Label_LeaveM1.Text = "0" + Month.ToString() + "月休假天數";
            }
            else
            {
                Label_LeaveM.Text = "Số Ngày Nghỉ Phép Tháng " + Month.ToString() + " &nbsp;｜";
                Label_LeaveM1.Text = Month.ToString() + "月休假天數";
            }
        }
    }

    public void Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Type.SelectedValue == "P" || Type.SelectedValue == "Po" || Type.SelectedValue == "Default")
        {
            Documents.Text = "N";
            LBNotify.Text = "";
        }
        else
        {
            Documents.Text = "Y";
            LBNotify.Text = "Cung cấp tài liệu giấy tờ có liên quan";
        }

        ResetDate();
    }
    public void ResetDate()
    {
        StartDate.Text = "";
        EndDate.Text = "";
        TotalDay.Text = "0";
        TotalHour.Text = "0";
        StartTime.Text = DateTime.ParseExact("07:30", "HH:mm", null).ToString("HH:mm");
        EndTime.Text = DateTime.ParseExact("16:30", "HH:mm", null).ToString("HH:mm");
    }
    public double DateDifference(string StartDate, string EndDate)
    {
        DateTime SDate = DateTime.ParseExact(StartDate, "yyyy-MM-dd", null);
        DateTime EDate = DateTime.ParseExact(EndDate, "yyyy-MM-dd", null);

        TimeSpan difference = EDate - SDate;
        return difference.TotalDays + 1;
    }
    public void Date_TextChanged(object sender, EventArgs e)
    {
        string SDate = StartDate.Text;
        string EDate = EndDate.Text;

        if (Type.SelectedValue == "P" && DateDifference(DateTime.Now.Date.ToString("yyyy-MM-dd"), SDate) - 1 >= 2)
        {
            Documents.Text = "N";
            LBNotify.Text = "";
        }
        //協助假提前2天申請不需提供證明
        else if (Type.SelectedValue == "Po" && DateDifference(DateTime.Now.Date.ToString("yyyy-MM-dd"), SDate) - 1 >= 2)
        {
            Documents.Text = "N";
            LBNotify.Text = "";
        }
        //事假提前1天申請不需提供證明
        else if (Type.SelectedValue == "RO" && DateDifference(DateTime.Now.Date.ToString("yyyy-MM-dd"), SDate) - 1 >= 1)
        {
            Documents.Text = "N";
            LBNotify.Text = "";
        }
        //選擇[請選擇]時重置
        else if (Type.SelectedValue == "Default")
        {
            Documents.Text = "N";
            LBNotify.Text = "";
        }
        else
        {
            Documents.Text = "Y";
            LBNotify.Text = "Cung cấp tài liệu giấy tờ có liên quan";
        }
        if (SDate != "" && EDate != "" && DateDifference(SDate, EDate) >= 1)
        {
            LYV.Leave.UCO.LeaveUCO uco = new LYV.Leave.UCO.LeaveUCO();
            string[] flagcheck = uco.CheckLeaveDate(LeaverID.Text, SDate, EDate, Type.SelectedValue).Split(";");
            //20230316 修改
            TotalDay.Text = flagcheck[3];
            LeaveDays.Text = flagcheck[2];

            if (flagcheck[0] == "YES")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Ngày đã đăng ký | 已申請過的日期')", true);
                ResetDate();
            }
            else if (flagcheck[1] == "YES")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Những ngày được yêu cầu bao gồm các ngày lễ khác | 申請的日期內包含其它假期')", true);
                ResetDate();
            }
            else if (int.Parse(flagcheck[2]) >= 10 && Type.SelectedValue != "P" && Type.SelectedValue != "No1")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage",
                    "alert('Đơn xin quá " + flagcheck[2] + " ngày, phải được Phó Giám đốc Việt Nam ký duyệt | 申請假期連續超過" + flagcheck[2] + "天需經過越方副總審核')", true);
            }
            //Lock.Text = uco.Check_KhoaSo(LeaverID.Text, SDate);
        }
        else
        {
            TotalDay.Text = "0";
            return;
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
            Leaver.Visible = false;
            Deputy.Visible = false;
        }
        else
            Dep.Visible = false;
    }
    public void gvDep_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvDep.PageIndex = e.NewPageIndex;
        LoadDataDep();
    }
    protected void gvDep_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gvDep.SelectedRow != null)
        {
            DepartmentID.Attributes["DepID"] = gvDep.SelectedRow.Cells[0].Text;
            DepartmentID.Text = System.Web.HttpUtility.HtmlDecode(gvDep.SelectedRow.Cells[1].Text); // Lấy giá trị từ cột đầu tiên
            LeaverID.Text = "";
            LeaverName.Text = "";
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
        LoadDataDep();
    }
    private void LoadDataDep()
    {
        LeaveUCO uco = new LeaveUCO();
        DataTable dt = uco.GetDep();

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
    public void SearchLeaver_Click(object sender, EventArgs e)
    {
        if (Leaver.Visible == false)
        {
            NV_Ma_Search.Text = "";
            NV_Ten_Search.Text = "";
            NV_Ma_Search1.Text = "";
            NV_Ten_Search1.Text = "";
            Leaver.Visible = true;
            LoadDataID();
            Dep.Visible = false;
            Deputy.Visible = false;
        }
        else
            Leaver.Visible = false;
    }
    public void gvLeaver_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLeaver.PageIndex = e.NewPageIndex;
        LoadDataID();
    }
    protected void gvLeaver_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gvLeaver.SelectedRow != null)
        {
            LeaverID.Text = gvLeaver.SelectedRow.Cells[0].Text; // Lấy giá trị từ cột đầu tiên
            LeaverName.Text = System.Web.HttpUtility.HtmlDecode(gvLeaver.SelectedRow.Cells[1].Text);
            Leaver.Visible = false;                                                     // Thêm các cột khác nếu cần
            LeaverID_TextChanged(sender, e);
        }
    }
    protected void gvLeaver_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvLeaver, "Select$" + e.Row.RowIndex);
            e.Row.Attributes["style"] = "cursor:pointer";
        }
    }
    public void NV_Search_TextChanged(object sender, EventArgs e)
    {
        LoadDataID();
    }
    private void LoadDataID()
    {
        LeaveUCO uco = new LeaveUCO();
        DataTable dt = uco.GetUser();

        if (!string.IsNullOrEmpty(NV_Ma_Search.Text))
        {
            DataView dv = new DataView(dt);
            dv.RowFilter = $"NV_Ma LIKE '%{NV_Ma_Search.Text}%'";
            gvLeaver.DataSource = dv;
        }
        else if (!string.IsNullOrEmpty(NV_Ten_Search.Text))
        {
            DataView dv = new DataView(dt);
            dv.RowFilter = $"NV_Ten LIKE '%{NV_Ten_Search.Text}%'";
            gvLeaver.DataSource = dv;
        }
        else if (!string.IsNullOrEmpty(NV_Ma_Search1.Text))
        {
            DataView dv = new DataView(dt);
            dv.RowFilter = $"NV_Ma LIKE '%{NV_Ma_Search1.Text}%'";
            gvDeputy.DataSource = dv;
        }
        else if (!string.IsNullOrEmpty(NV_Ten_Search1.Text))
        {
            DataView dv = new DataView(dt);
            dv.RowFilter = $"NV_Ten LIKE '%{NV_Ten_Search1.Text}%'";
            gvDeputy.DataSource = dv;
        }
        else
        {
            gvDeputy.DataSource = dt;
            gvLeaver.DataSource = dt;
        }
        gvDeputy.DataBind();
        gvLeaver.DataBind();
    }
    public void SearchDeputy_Click(object sender, EventArgs e)
    {
        if (Deputy.Visible == false)
        {
            NV_Ma_Search.Text = "";
            NV_Ten_Search.Text = "";
            NV_Ma_Search1.Text = "";
            NV_Ten_Search1.Text = "";
            Deputy.Visible = true;
            LoadDataID();
            Leaver.Visible = false;
            Dep.Visible = false;
        }
        else
            Deputy.Visible = false;
    }
    public void gvDeputy_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvDeputy.PageIndex = e.NewPageIndex;
        LoadDataID();
    }
    protected void gvDeputy_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gvDeputy.SelectedRow != null)
        {
            DeputyID.Text = gvDeputy.SelectedRow.Cells[0].Text; // Lấy giá trị từ cột đầu tiên
            DeputyName.Text = System.Web.HttpUtility.HtmlDecode(gvDeputy.SelectedRow.Cells[1].Text);
            Deputy.Visible = false;                                                     // Thêm các cột khác nếu cần
        }
    }
    protected void gvDeputy_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvDeputy, "Select$" + e.Row.RowIndex);
            e.Row.Attributes["style"] = "cursor:pointer";
        }
    }
    public void NV_Search1_TextChanged(object sender, EventArgs e)
    {
        LoadDataID();
    }

    public void ResetUser()
    {
        DepartmentID.Text = "";
        DepartmentID.Attributes["DepID"] = "";
        LeaverID.Text = "";
        LeaverName.Text = "";
        FactoryClosed.Text = "";
        Leave_No1.Text = "";
        Leave_Om.Text = "";
        Leave_ConOm.Text = "";
        Leave_Ro.Text = "";
        ID.Text = "";
        Name.Text = "";
        OnBoardDate.Text = "";
        LastYD.Text = "";
        ThisYD.Text = "";
        Year5.Text = "";
        DH.Text = "";
        NNDH.Text = "";
        LeaveYD.Text = "";
        TotalYD.Text = "";
        Total.Text = "";
        LeaveDays.Text = "";
        LeaveM.Text = "";
        LeaveM_RO.Text = "";
        LeaveM_OM.Text = "";
        LeaveM_CO.Text = "";
        DHMonth.Text = "";
        YDLeave.Text = "";
    }

    public void LeaverID_TextChanged(object sender, EventArgs e)
    {
        if (LeaverID.Text == "")
        {
            ResetUser();
            His.CssClass = "disabledPanel";
            His.Enabled = false;
            PHis.Visible = false;
            return;
        }
        if (Leaver.Visible == true)
        {
            Leaver.Visible = false;
        }

        LeaveUCO uco = new LeaveUCO();
        string data = uco.GetEmployee(LeaverID.Text);
        string UserName = data.Split(";")[0];
        string UserDep = data.Split(";")[1];
        string Flag = data.Split(";")[2];
        if (UserName == "")
        {
            ResetUser();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Nhân viên này không tồn tại | 此工號不在選擇的部門內或不存在')", true);
            His.CssClass = "disabledPanel";
            His.Enabled = false;
            PHis.Visible = false;
        }
        else if (Flag != "Employee")
        {
            ResetUser();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Nhân viên này đã nghỉ việc | 此員工已離職')", true);
            His.CssClass = "disabledPanel";
            His.Enabled = false;
            PHis.Visible = false;
        }
        else
        {
            ResetDate();
            DataTable dt = uco.GetDep();
            DataView dv = new DataView(dt);
            dv.RowFilter = $"DV_MA LIKE '%{UserDep}%'";
            gvDep.DataSource = dv;
            gvDep.DataBind();
            DepartmentID.Attributes["DepID"] = gvDep.Rows[0].Cells[0].Text;
            DepartmentID.Text = System.Web.HttpUtility.HtmlDecode(gvDep.Rows[0].Cells[1].Text);
            if (Year.Text == "") Year.Text = DateTime.Now.Year.ToString();
            LeaverName.Text = UserName;
            Name.Text = UserName;
            ID.Text = LeaverID.Text;
            His.CssClass = "enabledPanel";
            His.Enabled = true;
            string data1 = uco.GetLeaveData(LeaverID.Text, Year.Text);
            string[] LData = data1.Split(";");
            int TotalYD1;
            if (Convert.ToInt32(double.Parse(LData[1])) >= 0)
            {
                TotalYD1 = Convert.ToInt32(double.Parse(LData[6]));
            }
            else
            {
                TotalYD1 = Convert.ToInt32(double.Parse(LData[6])) - Convert.ToInt32(double.Parse(LData[1]));
            }
            var Total1 = Convert.ToInt32(double.Parse(LData[2])) + Convert.ToInt32(double.Parse(LData[3])) + Convert.ToInt32(double.Parse(LData[4])) - TotalYD1;

            OnBoardDate.Text = LData[0];
            LastYD.Text = LData[1];
            ThisYD.Text = LData[2];
            Year5.Text = LData[3];
            DH.Text = LData[4];
            NNDH.Text = LData[5];
            LeaveYD.Text = LData[6];
            LeaveM.Text = LData[7];
            TotalYD.Text = TotalYD1.ToString();
            Total.Text = Total1.ToString();
            LeaveM_RO.Text = LData[8];
            LeaveM_OM.Text = LData[9];
            LeaveM_CO.Text = LData[10];

            FactoryClosed.Text = LData[15];
            Leave_No1.Text = LData[11];
            Leave_Om.Text = LData[12];
            Leave_ConOm.Text = LData[13];
            Leave_Ro.Text = LData[14];

            DHMonth.Text = LData[5];
            YDLeave.Text = TotalYD1.ToString();
        }
    }
    public void DeputyID_TextChanged(object sender, EventArgs e)
    {
        if (DeputyID.Text == "")
        {
            DeputyID.Text = "";
            DeputyName.Text = "";
            return;
        }
        if (Deputy.Visible == true)
        {
            Deputy.Visible = false;
        }
        LeaveUCO uco = new LeaveUCO();
        string data = uco.GetEmployee(DeputyID.Text);
        string UserName = data.Split(";")[0];
        string Flag = data.Split(";")[2];
        if (UserName == "")
        {
            DeputyID.Text = "";
            DeputyName.Text = "";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Nhân viên này không tồn tại | 此工號不在選擇的部門內或不存在')", true);
        }
        else if (Flag != "Employee")
        {
            DeputyID.Text = "";
            DeputyName.Text = "";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Nhân viên này đã nghỉ việc | 此員工已離職')", true);
        }
        else
        {
            DeputyName.Text = UserName;
        }
    }
    public void SearchHis_Click(object sender, EventArgs e)
    {
        if (PHis.Visible == false)
        {
            if (LeaverID.Text == ID.Text)
            {
                LeaveUCO uco = new LeaveUCO();
                DataTable dt = uco.ST_NHANVIENNGHIPHEP(ID.Text);
                gvHis.DataSource = dt;
                gvHis.DataBind();
                HisName.Text = "請假紀錄 - " + Name.Text;
                PHis.Visible = true;
            }
            else
            {
                ResetUser();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Nhân viên này đã nghỉ việc | 此員工已離職')", true);
                His.CssClass = "disabledPanel";
                His.Enabled = false;
                PHis.Visible = false;
            }
        }
        else
        {
            if (LeaverID.Text != ID.Text)
            {
                ResetUser();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Nhân viên này đã nghỉ việc | 此員工已離職')", true);
                His.CssClass = "disabledPanel";
                His.Enabled = false;
            }
            PHis.Visible = false;
        }
    }
    public void Year_SelectedIndexChanged(object sender, EventArgs e)
    {
        LeaveUCO uco = new LeaveUCO();
        string selectedValue = Year.SelectedValue.ToString();
        string data1 = uco.GetLeaveData(ID.Text, selectedValue);
        string[] LData = data1.Split(";");
        int TotalYD1;
        if (int.Parse(LData[1]) >= 0)
        {
            TotalYD1 = int.Parse(LData[6]);
        }
        else
        {
            TotalYD1 = int.Parse(LData[6]) - int.Parse(LData[1]);
        }
        var Total1 = int.Parse(LData[2]) + int.Parse(LData[3]) + int.Parse(LData[4]) - TotalYD1;

        OnBoardDate.Text = LData[0];
        LastYD.Text = LData[1];
        ThisYD.Text = LData[2];
        Year5.Text = LData[3];
        DH.Text = LData[4];
        NNDH.Text = LData[5];
        LeaveYD.Text = LData[6];
        LeaveM.Text = LData[7];
        TotalYD.Text = TotalYD1.ToString();
        Total.Text = Total1.ToString();
        LeaveM_RO.Text = LData[8];
        LeaveM_OM.Text = LData[9];
        LeaveM_CO.Text = LData[10];

        FactoryClosed.Text = LData[15];
        Leave_No1.Text = LData[11];
        Leave_Om.Text = LData[12];
        Leave_ConOm.Text = LData[13];
        Leave_Ro.Text = LData[14];

        DHMonth.Text = LData[5];
        YDLeave.Text = TotalYD1.ToString();
    }
    public void Print_Click(object sender, EventArgs e)
    {
        ExpandoObject param = new { LYV = hfLYV.Value }.ToExpando();
        Dialog.Open2(Print, "~/CDS/LYV/Plugin/Leave/Leave_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
    }
    public void Disable_Click(object sender, EventArgs e)
    {
        LeaveUCO uco = new LeaveUCO();
        uco.DisableFlowflag(hfLYV.Value);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('" + hfLYV.Value + " has been disabled!')", true);
        pPrint.Visible = false;
        pDisable.Visible = false;
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
                if (Type.SelectedValue == "P" || Type.SelectedValue == "No1")
                {
                    return "0";
                }
                else
                {
                    return LeaveDays.Text;
                }
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
                XElement TPElement = new XElement("LYV_Leave_Form");
                TPElement.Add(new XAttribute("DepartmentID", DepartmentID.Attributes["DepID"].ToString()));
                TPElement.Add(new XAttribute("LeaverID", LeaverID.Text));
                TPElement.Add(new XAttribute("LeaverName", LeaverName.Text));
                TPElement.Add(new XAttribute("DeputyID", DeputyID.Text));
                TPElement.Add(new XAttribute("DeputyName", DeputyName.Text));
                TPElement.Add(new XAttribute("Type", Type.SelectedValue));

                TPElement.Add(new XAttribute("LeaveDays", LeaveDays.Text));
                TPElement.Add(new XAttribute("TotalDay", TotalDay.Text));
                TPElement.Add(new XAttribute("TotalHour", TotalHour.Text));
                TPElement.Add(new XAttribute("StartDate", StartDate.Text));
                TPElement.Add(new XAttribute("StartTime", StartTime.Text));
                TPElement.Add(new XAttribute("EndDate", EndDate.Text));
                TPElement.Add(new XAttribute("EndTime", EndTime.Text));
                TPElement.Add(new XAttribute("Reason", Reason.Text));
                TPElement.Add(new XAttribute("Remark", Remark.Text));

                TPElement.Add(new XAttribute("flowflag", flowflag.Text));
                TPElement.Add(new XAttribute("Documents", Documents.Text));
                TPElement.Add(new XAttribute("DHMonth", DHMonth.Text));
                TPElement.Add(new XAttribute("YDLeave", YDLeave.Text));
                TPElement.Add(new XAttribute("Total", Total.Text));
                TPElement.Add(new XAttribute("Lock", Lock.Text));

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
        SearchLeaver.Enabled = Enabled;
        SearchDeputy.Enabled = Enabled;
        LeaverID.Enabled = Enabled;
        DeputyID.Enabled = Enabled;
        Type.Enabled = Enabled;
        StartDate.Enabled = Enabled;
        StartTime.Enabled = Enabled;
        EndDate.Enabled = Enabled;
        EndTime.Enabled = Enabled;
        Reason.Enabled = Enabled;
        Remark.Enabled = Enabled;
    }
    private void SetCustomField(XElement xeTP)
    {
        LeaverID.Text = xeTP.Attribute("LeaverID").Value;
        LeaverName.Text = xeTP.Attribute("LeaverName").Value;
        DeputyID.Text = xeTP.Attribute("DeputyID").Value;
        DeputyName.Text = xeTP.Attribute("DeputyName").Value;
        Type.SelectedValue = xeTP.Attribute("Type").Value;

        LeaveDays.Text = xeTP.Attribute("LeaveDays").Value;
        TotalDay.Text = xeTP.Attribute("TotalDay").Value;
        TotalHour.Text = xeTP.Attribute("TotalHour").Value;
        StartDate.Text = xeTP.Attribute("StartDate").Value;
        StartTime.Text = xeTP.Attribute("StartTime").Value;
        EndDate.Text = xeTP.Attribute("EndDate").Value;
        EndTime.Text = xeTP.Attribute("EndTime").Value;
        Reason.Text = xeTP.Attribute("Reason").Value;
        Remark.Text = xeTP.Attribute("Remark").Value;

        flowflag.Text = xeTP.Attribute("flowflag").Value;
        Documents.Text = xeTP.Attribute("Documents").Value;
        Lock.Text = xeTP.Attribute("Lock").Value;

        LeaveUCO uco = new LeaveUCO();
        if (xeTP.Attribute("DepartmentID").Value.ToString() != "")
        {
            DataTable dt = uco.GetDep();
            DataView dv = new DataView(dt);
            dv.RowFilter = $"DV_MA LIKE '%{xeTP.Attribute("DepartmentID").Value}%'";
            gvDep.DataSource = dv;
            gvDep.DataBind();
            DepartmentID.Attributes["DepID"] = gvDep.Rows[0].Cells[0].Text;
            DepartmentID.Text = System.Web.HttpUtility.HtmlDecode(gvDep.Rows[0].Cells[1].Text);
        }
        else
        {
            DepartmentID.Text = xeTP.Attribute("DepartmentID").Value.ToString();
        }

        Year.Text = DateTime.Now.Year.ToString();
        Name.Text = LeaverName.Text;
        ID.Text = LeaverID.Text;
        His.CssClass = "enabledPanel";
        His.Enabled = true;
        string data1 = uco.GetLeaveData(LeaverID.Text, Year.Text);
        string[] LData = data1.Split(";");
        int TotalYD1;
        if (Convert.ToInt32(double.Parse(LData[1])) >= 0)
        {
            TotalYD1 = Convert.ToInt32(double.Parse(LData[6]));
        }
        else
        {
            TotalYD1 = Convert.ToInt32(double.Parse(LData[6])) - Convert.ToInt32(double.Parse(LData[1]));
        }
        var Total1 = Convert.ToInt32(double.Parse(LData[2])) + Convert.ToInt32(double.Parse(LData[3])) + Convert.ToInt32(double.Parse(LData[4])) - TotalYD1;

        OnBoardDate.Text = LData[0];
        LastYD.Text = LData[1];
        ThisYD.Text = LData[2];
        Year5.Text = LData[3];
        DH.Text = LData[4];
        NNDH.Text = LData[5];
        LeaveYD.Text = LData[6];
        LeaveM.Text = LData[7];
        TotalYD.Text = TotalYD1.ToString();
        Total.Text = Total1.ToString();
        LeaveM_RO.Text = LData[8];
        LeaveM_OM.Text = LData[9];
        LeaveM_CO.Text = LData[10];

        FactoryClosed.Text = LData[15];
        Leave_No1.Text = LData[11];
        Leave_Om.Text = LData[12];
        Leave_ConOm.Text = LData[13];
        Leave_Ro.Text = LData[14];

        DHMonth.Text = LData[5];
        YDLeave.Text = TotalYD1.ToString();

        if (hfTASK_RESULT.Value.ToString() == "Adopt")
        {
            ExpandoObject param = new { LYV = hfLYV.Value }.ToExpando();
            Dialog.Open2(Print, "~/CDS/LYV/Plugin/Leave/Leave_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
            pPrint.Visible = true;
            string groupName = Current.User.GroupName;
            string JobTitle = Current.User.JobTitle;
            if (groupName == "HR/CR" && JobTitle == "越籍人員")
            {
                pDisable.Visible = true;
            }
            else if (groupName == "行政事務" && JobTitle == "越籍人員")
            {
                pDisable.Visible = true;
            }
            else
            {
                pDisable.Visible = false;
            }
            string pflowflag = uco.getFlowflag(hfLYV.Value);
            if (pflowflag == "X")
            {
                pDisable.Visible = false;
                lDisable.Visible = true;
            }
        }
        else if (hfTASK_RESULT.Value.ToString() == "Reject" || hfTASK_RESULT.Value.ToString() == "Cancel")
        {
            lDisable.Visible = true;
            pPrint.Visible = true;
        }
        else
        {
            lDisable.Visible = false;
            pPrint.Visible = false;
            pDisable.Visible = false;
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