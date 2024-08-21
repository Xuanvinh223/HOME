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

public partial class WKF_Out_List : Ede.Uof.Utility.Page.BasePage
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
        }
    }
    protected void gvOut_BeforeExport(object sender, Ede.Uof.Utility.Component.BeforeExportEventArgs e)
    {
        LoadDataOut();

        // Clone the original data source
        DataTable dtEXP = ((DataTable)gvOut.DataSource).Clone();

        // Determine which columns to exclude from export
        List<string> excludedColumns = new List<string> { "TASK_ID" };
        foreach (DataRow dr in ((DataTable)gvOut.DataSource).Rows)
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
        for (int c = 1; c <= gvOut.Columns.Count; c++)
        {
            dtEXP.Columns[c - 1].ColumnName = gvOut.Columns[c -1].HeaderText.Replace("<br/>", "\n");
        }
        dtEXP.Columns.RemoveAt(dtEXP.Columns.Count - 1);
        if (qD_STEP_DESC.SelectedValue == "ALL")
        {
            dtEXP.Columns.RemoveAt(1);
            dtEXP.Columns.RemoveAt(0);
        }
        dtEXP.AcceptChanges();

        // Set dtEXP as the DataSource for export
        e.Datasource = dtEXP;
    }
    protected void gvOut_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOut.DataSource = (DataTable)ViewState["formsDT"];
        gvOut.DataBind();
        gvOut.PageIndex = e.NewPageIndex;
        gvOut.DataBind();
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        int pageSize;
        if (int.TryParse(ddlPageSize.SelectedValue, out pageSize))
        {
            gvOut.PageSize = pageSize;
            gvOut.DataSource = (DataTable)ViewState["formsDT"];
            gvOut.DataBind();
        }
    }
    protected void gvOut_SelectedIndexChanged(object sender, EventArgs e)
    {
        hfLNO.Value = gvOut.SelectedDataKey.Value.ToString();
    }
    protected void gvOut_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView row = (DataRowView)e.Row.DataItem;

            int statusColumnIndex = gvOut.Columns.IndexOf(gvOut.Columns.Cast<DataControlField>()
            .FirstOrDefault(field => field.HeaderText == "狀態"));

            // Lấy index của cột CancelReason
            int cancelReasonColumnIndex = gvOut.Columns.IndexOf(gvOut.Columns.Cast<DataControlField>()
                .FirstOrDefault(field => field.HeaderText == "註銷原因"));
            if (qD_STEP_DESC.SelectedValue == "Cancel")
            {
                gvOut.SelectedIndex = -1;
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvOut, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
                gvOut.Columns[statusColumnIndex].Visible = true;
                gvOut.Columns[cancelReasonColumnIndex].Visible = true;
            }
            else
            {
                gvOut.SelectedIndex = -1;
                e.Row.Attributes["onclick"] = "";
                e.Row.ToolTip = "";
                gvOut.Columns[statusColumnIndex].Visible = false;
                gvOut.Columns[cancelReasonColumnIndex].Visible = false;
            }
            LinkButton btnLNO = (LinkButton)e.Row.FindControl("btnLNO");
            if (row["TASK_ID"].ToString() != "")
            {
                ExpandoObject param = new { TASK_ID = row["TASK_ID"].ToString() }.ToExpando();
                //Grid開窗是用RowDataBound事件再開窗
                Dialog.Open2(btnLNO, "~/WKF/FormUse/ViewForm.aspx", "", 1500, 800, Dialog.PostBackType.None, param);
            }
            else
            {
                Training.Out.UCO.OutUCO uco = new Training.Out.UCO.OutUCO();
                string Status = uco.GetOut(row["LNO"].ToString());
                if (Status != "cancel")
                {
                    ExpandoObject param = new { LNO = row["LNO"].ToString() }.ToExpando();
                    Dialog.Open2(btnLNO, "~/CDS/LYN/Plugin/Out/LYN_Out_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
                }
                else
                {
                    btnLNO.Enabled = false;
                }
            }
        }
    }
    public void D_STEP_DESC_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindEmptyDataToGridView();
        if (qD_STEP_DESC.SelectedValue == "Cancel")
        {
            pLNO.Visible = false;
            pOutID.Visible = false;
            pOutCheck.Visible = false;
            pOnNO.Visible = true;
            LoadDataOut();
        }
        else
        {
            pLNO.Visible = true;
            pOutID.Visible = true;
            pOutCheck.Visible = true;
            pOnNO.Visible = false;
        }
    }
    private void LoadDataOut()
    {
        string D_STEP_DESC = qD_STEP_DESC.SelectedValue;
        string Type = "";
        string LNO = qLNO.Text;
        string OutID = qOutID.Text;
        string LeaveTime = qLeaveTime.Text;
        string ReturnTime = qReturnTime.Text;
        string UserDate1 = qUserDate1.Text;
        string UserDate2 = qUserDate2.Text;
        string OutCheck = "IsNull(OutCheck,'')=''";
        if (qOutCheck.Checked)
        {
            OutCheck = "IsNull(OutCheck,'')<>''";
        }
        if(qType.SelectedValue != "ALL")
        {
            Type=qType.SelectedValue;
        }

        Training.Out.UCO.OutUCO uco = new Training.Out.UCO.OutUCO();

        DataTable dt = uco.GetListOut(D_STEP_DESC, Type, LNO, OutID, LeaveTime, ReturnTime, UserDate1, UserDate2, OutCheck, Current.Account.Replace("LYN",""));
        ViewState["formsDT"] = dt;
        gvOut.DataSource = dt;
        gvOut.DataBind();
    }
    private void BindEmptyDataToGridView()
    {
        DataTable dtEmpty = new DataTable();
        ViewState["formsDT"] = dtEmpty;
        gvOut.DataSource = dtEmpty;
        gvOut.DataBind();
    }
    public void Query_Click(object sender, EventArgs e)
    {
        LoadDataOut();
    }
    public void Clear_Click(object sender, EventArgs e)
    {
        qLNO.Text = "";
        qOutID.Text = "";
        qLeaveTime.Text = "";
        qReturnTime.Text = "";
        qUserDate1.Text = "";
        qUserDate2.Text = "";
        qOutCheck.Checked = false;
        qD_STEP_DESC.SelectedIndex = 0;
        qType.SelectedIndex = 0;
    }
    public void OnNO_Click(object sender, EventArgs e)
    {
        string key = hfLNO.Value;
        if (key == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('Please select at least 1 data!')", true);
        }
        else
        {
            string LNO = hfLNO.Value.ToString();
            Training.Out.UCO.OutUCO uco = new Training.Out.UCO.OutUCO();
            string Status = uco.GetOut(LNO);
            if (Status == "out")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('該外出單已有外出記錄，無法註銷 This out-of-office order already has an out-of-office record and cannot be canceled.')", true);
            }
            else if (Status == "cancel")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('該外出單已註銷過 This outbound order has been canceled')", true);
            }
            else
            {
                ExpandoObject param = new { LNO = hfLNO.Value }.ToExpando();
                Dialog.Open2(OnNO, "~/CDS/LYN/Plugin/Out/LYN_Out_Modal.aspx", "註銷外出單", 950, 600, Dialog.PostBackType.None, param);
            }
        }
    }
}