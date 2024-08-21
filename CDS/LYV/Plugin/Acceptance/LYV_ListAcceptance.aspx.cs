using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ede.Uof.Utility.Page.Common;
using System.Data;
using System.Dynamic;
using System.Web.UI.HtmlControls;

public partial class LYV_ListAcceptance : Ede.Uof.Utility.Page.BasePage
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
            string LNO = tbLNO.Text;
            string startDate = userdate_start.Text;
            string endDate = userdate_end.Text;
            string RKNO = tbRKNO.Text;
            string type = DrListType.SelectedValue;

            LoadGridView(LNO, RKNO, type, startDate, endDate);
            

        }

    }


    private void LoadGridView(string LNO, string RKNO, string ListType,string Sdate,string Edate)
    {

        Training.LYVAcceptance.UCO.AccpetanceUCO uco = new Training.LYVAcceptance.UCO.AccpetanceUCO();
        DataTable dt = uco.GetGridView_Close(LNO, RKNO, ListType, Sdate, Edate);
        ViewState["fomrsdt"] = dt;
        gvList.DataSource = dt;
        gvList.DataBind();

    }
    //
    //Click query
    protected void btnQuery_OnClick(object sender, EventArgs e)
    {
        string LNO = tbLNO.Text;
        string startDate = userdate_start.Text;
        string endDate = userdate_end.Text;
        string RKNO = tbRKNO.Text;
        string type = DrListType.SelectedValue;
        LoadGridView(LNO, RKNO, type, startDate, endDate);
    }
    public void btClear_OnClick(object sender, EventArgs e)
    {
        tbLNO.Text = "";
        tbRKNO.Text = "";
        userdate_start.Text = "";
        userdate_end.Text = "";
        DrListType.SelectedIndex = 0;
    }

    //
    protected void gvList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvList.DataSource = ViewState["fomrsdt"];
        gvList.DataBind();
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

            LinkButton btnLNO = (LinkButton)e.Row.FindControl("btnLNO");
            ExpandoObject param = new { TASK_ID = row["TASK_ID"].ToString() }.ToExpando();
            //Grid開窗是用RowDataBound事件再開窗
            Dialog.Open2(btnLNO, "~/WKF/FormUse/ViewForm.aspx", "", 1500, 800, Dialog.PostBackType.None, param);

        }
    }

    protected void gvList_BeforeExport(object sender, Ede.Uof.Utility.Component.BeforeExportEventArgs e)
    {
        LoadGridView(tbLNO.Text, tbRKNO.Text, DrListType.SelectedValue, userdate_start.Text, userdate_end.Text);
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

    protected void gvList_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataTable dt = (DataTable)ViewState["fomrsdt"];

        if (dt.Rows.Count > 0)
        {
            string sortExpression = e.SortExpression;
            DataView dv = new DataView(dt);
            dv.Sort = sortExpression + " " + GetSortDirection(sortExpression);

            // Cập nhật DataTable với dữ liệu đã được sắp xếp
            ViewState["fomrsdt"] = dv.ToTable();
            gvList.DataSource = (DataTable)ViewState["fomrsdt"];
            gvList.DataBind();
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

}