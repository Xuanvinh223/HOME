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

public partial class WKF_Leave_ListHR : Ede.Uof.Utility.Page.BasePage
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
            BindEmptyDataToGridView();
            string groupName = Current.User.GroupName;
            string JobTitle = Current.User.JobTitle;
            if (groupName == "HR/CR")
            {
                pOnOK.Visible = true;
                pOnNO.Visible = true;
                qD_STEP_DESC.Items[1].Enabled = true;
            }
            else if (groupName == "行政事務")
            {
                pOnOK.Visible = true;
                pOnNO.Visible = true;
                qD_STEP_DESC.Items[1].Enabled = true;
            }
            else
            {
                pOnOK.Visible = false;
                pOnNO.Visible = false;
                pApprove.Visible = false;
                qD_STEP_DESC.Items[1].Enabled = false;
            }
        }
        hfSiteName.Value = Request.ApplicationPath.Substring(1);
        LoadDataFirstLeave();
    }
    protected void gvLeave_BeforeExport(object sender, Ede.Uof.Utility.Component.BeforeExportEventArgs e)
    {
        LoadDataLeave();

        // Clone the original data source
        DataTable dtEXP = ((DataTable)gvLeave.DataSource).Clone();

        // Determine which columns to exclude from export
        List<string> excludedColumns = new List<string> { "TASK_ID", "ATTACH_ID", "Documents" };

        foreach (DataRow dr in ((DataTable)gvLeave.DataSource).Rows)
        {
            DataRow newDataRow = dtEXP.NewRow();

            foreach (DataColumn dc in dtEXP.Columns)
            {
                if (!excludedColumns.Contains(dc.ColumnName))
                {
                    newDataRow[dc.ColumnName] = dr[dc.ColumnName];
                }
            }

            dtEXP.Rows.Add(newDataRow);
        }
        for (int c = 1; c < gvLeave.Columns.Count; c++)
        {
            dtEXP.Columns[c - 1].ColumnName = gvLeave.Columns[c].HeaderText.Replace("<br/>", "\n");
        }
        dtEXP.Columns.RemoveAt(dtEXP.Columns.Count - 3);
        dtEXP.Columns.RemoveAt(dtEXP.Columns.Count - 2);
        dtEXP.Columns.RemoveAt(dtEXP.Columns.Count - 1);
        dtEXP.AcceptChanges();

        // Set dtEXP as the DataSource for export
        e.Datasource = dtEXP;
    }
    protected void gvLeave_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataTable dt = (DataTable)ViewState["formsDT"];

        if (dt.Rows.Count > 0)
        {
            string sortExpression = e.SortExpression;
            DataView dv = new DataView(dt);
            dv.Sort = sortExpression + " " + GetSortDirection(sortExpression);

            // Cập nhật DataTable với dữ liệu đã được sắp xếp
            ViewState["formsDT"] = dv.ToTable();
            gvLeave.DataSource = (DataTable)ViewState["formsDT"];
            gvLeave.DataBind();
        }
    }
    private string GetSortDirection(string column)
    {
        // Kiểm tra trạng thái hiện tại của sắp xếp và trả về hướng mới
        string currentDirection = "ASC"; // Hướng mặc định nếu chưa có sắp xếp trước đó
        if (ViewState["SortExpression"] != null && ViewState["SortExpression"].ToString() == column)
        {
            currentDirection = ViewState["SortDirection"].ToString();
            currentDirection = (currentDirection == "ASC") ? "DESC" : "ASC";
        }

        // Lưu thông tin về sắp xếp vào ViewState
        ViewState["SortDirection"] = currentDirection;
        ViewState["SortExpression"] = column;

        return currentDirection;
    }
    protected void gvLeave_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLeave.DataSource = (DataTable)ViewState["formsDT"];
        gvLeave.DataBind();
        gvLeave.PageIndex = e.NewPageIndex;
        gvLeave.DataBind();
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        int pageSize;
        if (int.TryParse(ddlPageSize.SelectedValue, out pageSize))
        {
            gvLeave.PageSize = pageSize;
            gvLeave.DataSource = (DataTable)ViewState["formsDT"];
            gvLeave.DataBind();
        }
    }
    protected void gvLeave_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvLeave, "Select$" + e.Row.RowIndex);
            HtmlInputCheckBox chkBox = (HtmlInputCheckBox)e.Row.FindControl("CheckBox");
            List<string> checkedGUIDs = ViewState["CheckedGUIDs"] as List<string> ?? new List<string>();
            DataTable dt = (DataTable)ViewState["formsDT"];
            if (dt.Rows.Count > 0 && dt.Rows.Count == checkedGUIDs.Count)
            {
                chkBox.Checked = true;
            }
            else
            {
                chkBox.Checked = false;
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView row = (DataRowView)e.Row.DataItem;

            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvLeave, "Select$" + e.Row.RowIndex);
            HtmlInputCheckBox chkBox = (HtmlInputCheckBox)e.Row.FindControl("CheckBox");

            // Lấy giá trị của thuộc tính DataKey từ GridView
            string dataKey = gvLeave.DataKeys[e.Row.RowIndex].Values["LNO"].ToString();

            // Lấy danh sách đã chọn từ ViewState
            List<string> checkedGUIDs = ViewState["CheckedGUIDs"] as List<string> ?? new List<string>();

            // Kiểm tra xem giá trị "LNO" có nằm trong danh sách đã chọn hay không
            bool isChecked = checkedGUIDs.Contains(dataKey);

            // Tìm ô checkbox trong dòng hiện tại

            // Đặt thuộc tính Checked cho ô checkbox
            if (chkBox != null)
            {
                chkBox.Checked = isChecked;
            }

            if (row["Documents"].ToString() == "Y" && row["ATTACH_ID"].ToString() == "")
            {
                e.Row.ForeColor = System.Drawing.Color.Red;
            }

            Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();
            DataTable dt = uco.GetWSSignNextInfo(row["LNO"].ToString(), hfSiteName.Value, Current.UserGUID);

            if (dt.Rows.Count > 0)
            {
                LinkButton btnLNO = (LinkButton)e.Row.FindControl("btnLNO");
                ExpandoObject param = new { TASK_ID = dt.Rows[0]["TASK_ID"].ToString(), SITE_ID = dt.Rows[0]["SITE_ID"].ToString(), NODE_SEQ = dt.Rows[0]["NODE_SEQ"].ToString() }.ToExpando();
                Dialog.Open2(btnLNO, "~/WKF/FormUse/FreeTask/SignNodeForm.aspx", "", 1500, 800, Dialog.PostBackType.AfterReturn, param);
            }
            else
            {
                LinkButton btnLNO = (LinkButton)e.Row.FindControl("btnLNO");
                ExpandoObject param = new { TASK_ID = row["TASK_ID"].ToString() }.ToExpando();
                //Grid開窗是用RowDataBound事件再開窗
                Dialog.Open2(btnLNO, "~/WKF/FormUse/ViewForm.aspx", "", 1500, 800, Dialog.PostBackType.None, param);
            }
        }
    }
    protected void gvLeave_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        // Lấy danh sách các "LNO" đã chọn từ ViewState
        List<string> checkedGUIDs = ViewState["CheckedGUIDs"] as List<string> ?? new List<string>();
        if (e.NewSelectedIndex >= 0)
        {
            HtmlInputCheckBox chkBox = (HtmlInputCheckBox)gvLeave.Rows[e.NewSelectedIndex].FindControl("CheckBox");
            // Lấy giá trị của thuộc tính DataKey từ GridView
            string dataKey = gvLeave.DataKeys[e.NewSelectedIndex].Values["LNO"].ToString();

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
            HtmlInputCheckBox chkBox = (HtmlInputCheckBox)gvLeave.HeaderRow.FindControl("CheckBox");
            int currentPageIndex = gvLeave.PageIndex;
            int pageSize = gvLeave.PageSize;
            if (ViewState["formsDT"] is DataTable dataTable)
            {
                int startIndex = currentPageIndex * pageSize;
                int endIndex = Math.Min((currentPageIndex + 1) * pageSize, dataTable.Rows.Count);

                for (int i = startIndex; i < endIndex; i++)
                {
                    DataRow row = dataTable.Rows[i];

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
            /*HtmlInputCheckBox chkBox = (HtmlInputCheckBox)gvLeave.HeaderRow.FindControl("CheckBox");
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
                    else if(!isChecked && chkBox != null && chkBox.Checked)
                    {
                        checkedGUIDs.Add(dataKey);
                        // Ô checkbox không được chọn, thực hiện xử lý
                    }
                }
            }*/
        }
        ViewState["CheckedGUIDs"] = checkedGUIDs;
        string key = GetGridViewChecked();
        ExpandoObject param = new { LNO = key, SiteName = hfSiteName.Value, Account = Current.Account }.ToExpando();
        if (key == "")
        {
            Approve.Attributes.Remove("onclick");
            Approve.Attributes.Add("onclick", "Approve_Click");
        }
        else
        {
            Dialog.Open2(Approve, "~/CDS/LYV/Plugin/Leave/LYN_Leave_Modal.aspx", "Approve All", 600, 300, Dialog.PostBackType.AfterReturn, param);
        }
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
    public void D_STEP_DESC_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindEmptyDataToGridView();
        if (qD_STEP_DESC.SelectedValue == "人事")
        {
            pDocuments.Visible = false;
            pflowflag.Visible = false;
        }
        else
        {
            pDocuments.Visible = true;
            pflowflag.Visible = true;
        }
    }
    private void LoadDataLeave()
    {
        string D_STEP_DESC = qD_STEP_DESC.SelectedValue;
        string flowflag = qflowflag.SelectedValue;
        string DV_MA_ = qDV_MA_.Text;
        string LNO = qLNO.Text;
        string LeaverID = qLeaverID.Text;
        string StartDate = qStartDate.Text;
        string EndDate = qEndDate.Text;
        string Documents = "0";
        string Factory = "";
        string groupName = Current.User.GroupName;
        string Account = Current.Account;
        if (groupName == "HR/CR")
        {
            Factory = "A";
        }
        else if (groupName == "行政事務")
        {
            Factory = "GC";
        }

        if (qDocuments.Checked)
        {
            Documents = "1";
        }

        Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();

        DataTable dt = uco.GetListLeave(D_STEP_DESC, flowflag, DV_MA_, LNO, LeaverID, StartDate, EndDate, Documents, Factory, Account);
        ViewState["formsDT"] = dt;
        gvLeave.DataSource = dt;
        gvLeave.DataBind();
    }
    private void LoadDataFirstLeave()
    {
        string D_STEP_DESC = qD_STEP_DESC.SelectedValue;
        string flowflag = qflowflag.SelectedValue;
        string DV_MA_ = qDV_MA_.Text;
        string LNO = qLNO.Text;
        string LeaverID = qLeaverID.Text;
        string StartDate = qStartDate.Text;
        string EndDate = qEndDate.Text;
        string Documents = "1";
        string Factory = "";
        string groupName = Current.User.GroupName;
        string Account = Current.Account;
        if (groupName == "HR/CR")
        {
            Factory = "A";
        }
        else if (groupName == "行政事務")
        {
            Factory = "GC";
        }

        if (qDocuments.Checked)
        {
            Documents = "1";
        }

        Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();

        DataTable dt = uco.GetListLeave(D_STEP_DESC, flowflag, DV_MA_, LNO, LeaverID, StartDate, EndDate, Documents, Factory, Account);
        ViewState["formsDT"] = dt;
        gvLeave.DataSource = dt;
        gvLeave.DataBind();
    }
    private void BindEmptyDataToGridView()
    {
        DataTable dtEmpty = new DataTable();
        ViewState["formsDT"] = dtEmpty;
        gvLeave.DataSource = dtEmpty;
        gvLeave.DataBind();
    }
    public void Query_Click(object sender, EventArgs e)
    {
        string Documents = "0";
        List<string> checkedGUIDs = new List<string>();
        ViewState["CheckedGUIDs"] = checkedGUIDs;
        if (qD_STEP_DESC.SelectedValue == "人事" && gvLeave.Rows.Count > 0)
        {
            pApprove.Visible = true;
        }
        else
        {
            pApprove.Visible = false;
        }
        if (qDocuments.Checked)
        {
            Documents = "1";
            LoadDataLeave();
        }
        else
        {
            LoadDataFirstLeave();
        }
        
    }
    public void Clear_Click(object sender, EventArgs e)
    {
        qDV_MA_.Text = "";
        qLNO.Text = "";
        qLeaverID.Text = "";
        qStartDate.Text = "";
        qEndDate.Text = "";
        qDocuments.Checked = false;
        qflowflag.SelectedIndex = 0;
    }
    public void Approve_Click(object sender, EventArgs e)
    {
        string key = GetGridViewChecked();
        if (key == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Please select a data first!')", true);
        }
        if (Dialog.GetReturnValue() == "OK") Query_Click(sender, e);
    }
    public void OnOK_Click(object sender, EventArgs e)
    {
        string key = GetGridViewChecked();
        if (key == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Please select at least 1 data!')", true);
        }
        else
        {
            string[] dsLNO = key.Split(",");
            string where = "LNO in ('" + dsLNO[0] + "'";
            if (dsLNO.Length > 1)
            {
                for (int i = 1; i < dsLNO.Length; i++)
                {
                    where += ",'" + dsLNO[i] + "'";
                }
            }
            where += ")";
            Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();
            uco.UpdateWFLeave("N", where);
            Query_Click(sender, e);
        }
    }
    public void OnNO_Click(object sender, EventArgs e)
    {
        string key = GetGridViewChecked();
        if (key == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Please select at least 1 data!')", true);
        }
        else
        {
            string[] dsLNO = key.Split(",");
            string where = "LNO in ('" + dsLNO[0] + "'";
            for (int i = 1; i < dsLNO.Length; i++)
            {
                where += ",'" + dsLNO[i] + "'";
            }
            where += ")";
            Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();
            uco.UpdateWFLeave("Y", where);
            Query_Click(sender, e);
        }
    }

}