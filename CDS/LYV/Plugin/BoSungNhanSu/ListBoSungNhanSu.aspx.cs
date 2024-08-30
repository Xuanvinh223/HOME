using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ede.Uof.Utility.Page.Common;
using System.Data;
using System.Dynamic;
using System.Web.UI.HtmlControls;

public partial class LYV_ListBoSungNhanSu : Ede.Uof.Utility.Page.BasePage
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
            //userdate_start.Text = DateTime.Now.AddDays(0).ToString("yyyy-MM-dd");
            //userdate_end.Text = DateTime.Now.AddDays(0).ToString("yyyy-MM-dd");
            string LYV = tbLYV.Text;
            string MaPhieu = tbMaPhieu.Text;
            string startDate = userdate_start.Text;
            string endDate = userdate_end.Text;
            string NoiNhan = rbNoiNhan.Text;
            string LyDoBS = DrLyDoBS.SelectedValue;
            string flowflag = Drflowflag.SelectedValue;

            LoadGridView(LYV, MaPhieu, NoiNhan, LyDoBS, startDate, endDate, flowflag);
        }

    }


    private void LoadGridView(string LYV, string MaPhieu, string NoiNhan, string LyDoBS, string Sdate,string Edate, string flowflag)
    {
        LYV.BoSungNhanSu.UCO.BoSungNhanSuUCO uco = new LYV.BoSungNhanSu.UCO.BoSungNhanSuUCO();
        DataTable dt = uco.GetGridView_Close(LYV, MaPhieu,NoiNhan, LyDoBS, Sdate, Edate, flowflag);
        gvList.DataSource = dt;
        gvList.DataBind();

    }
    //
    //Click query
    protected void btnQuery_OnClick(object sender, EventArgs e)
    {
        string LYV = tbLYV.Text;
        string MaPhieu = tbMaPhieu.Text;
        string startDate = userdate_start.Text;
        string endDate = userdate_end.Text;
        string NoiNhan = rbNoiNhan.Text;
        string LyDoBS = DrLyDoBS.SelectedValue;
        string flowflag = Drflowflag.SelectedValue;
        LoadGridView(LYV, MaPhieu, NoiNhan, LyDoBS, startDate, endDate, flowflag);
    }
    public void btClear_OnClick(object sender, EventArgs e)
    {
        tbLYV.Text = "";
        tbMaPhieu.Text = "";
        userdate_start.Text = "";
        userdate_end.Text = "";
        DrLyDoBS.SelectedIndex = 0;
        Drflowflag.SelectedIndex = 0;
    }

    //
    protected void gvList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {     
        gvList.PageIndex = e.NewPageIndex;
        gvList.DataBind();
    }
    //
    protected void gvList_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            HtmlInputCheckBox cb = (HtmlInputCheckBox)e.Row.FindControl("CheckBox");
            cb.Visible = false;

        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView row = (DataRowView)e.Row.DataItem;
            HtmlInputCheckBox cb = (HtmlInputCheckBox)e.Row.FindControl("CheckBox");
            cb.Visible = false;

            LinkButton btnLYV = (LinkButton)e.Row.FindControl("btnLYV");
            ExpandoObject param = new { TASK_ID = row["TASK_ID"].ToString() }.ToExpando();
            //Grid開窗是用RowDataBound事件再開窗
            Dialog.Open2(btnLYV, "~/WKF/FormUse/ViewForm.aspx", "", 1500, 800, Dialog.PostBackType.None, param);

        }
    }

    protected void gvList_BeforeExport(object sender, Ede.Uof.Utility.Component.BeforeExportEventArgs e)
    {
        string LYV = tbLYV.Text;
        string MaPhieu = tbMaPhieu.Text;
        string startDate = userdate_start.Text;
        string endDate = userdate_end.Text;
        string NoiNhan = rbNoiNhan.Text;
        string LyDoBS = DrLyDoBS.SelectedValue;
        string flowflag = Drflowflag.SelectedValue;
        LoadGridView(LYV, MaPhieu, NoiNhan, LyDoBS, startDate, endDate, flowflag);
        // Clone the original data source
        DataTable dtEXP = ((DataTable)gvList.DataSource).Clone();

        // Determine which columns to exclude from export
        List<string> excludedColumns = new List<string> { "TASK_ID" };

        foreach (DataRow dr in ((DataTable)gvList.DataSource).Rows)
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
        for (int c = 1; c < gvList.Columns.Count; c++)
        {
            dtEXP.Columns[c - 1].ColumnName = gvList.Columns[c].HeaderText.Replace("<br/>", "\n");
        }
        dtEXP.Columns.RemoveAt(dtEXP.Columns.Count - 1);
        dtEXP.AcceptChanges();

        // Set dtEXP as the DataSource for export
        e.Datasource = dtEXP;
    }

}