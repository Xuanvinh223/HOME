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

public partial class WKF_Supplier_List : Ede.Uof.Utility.Page.BasePage
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
        hfSiteName.Value = Request.ApplicationPath.Substring(1);
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        int pageSize;
        if (int.TryParse(ddlPageSize.SelectedValue, out pageSize))
        {
            gvSUP.PageSize = pageSize;
            gvSUP.DataSource = (DataTable)ViewState["formsDT"];
            gvSUP.DataBind();
        }
    }
    protected void gvSUP_BeforeExport(object sender, Ede.Uof.Utility.Component.BeforeExportEventArgs e)
    {
        LoadDataSUP();

        // Clone the original data source
        DataTable dtEXP = ((DataTable)gvSUP.DataSource).Clone();

        // Determine which columns to exclude from export
        List<string> excludedColumns = new List<string> { "TASK_ID" };

        foreach (DataRow dr in ((DataTable)gvSUP.DataSource).Rows)
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
        for (int c = 1; c <= gvSUP.Columns.Count; c++)
        {
            dtEXP.Columns[c - 1].ColumnName = gvSUP.Columns[c - 1].HeaderText.Replace("<br/>", "\n");
        }
        dtEXP.Columns.RemoveAt(dtEXP.Columns.Count - 1);
        dtEXP.AcceptChanges();

        // Set dtEXP as the DataSource for export
        e.Datasource = dtEXP;
    }
    protected void gvSUP_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSUP.DataSource = (DataTable)ViewState["formsDT"];
        gvSUP.DataBind();
        gvSUP.PageIndex = e.NewPageIndex;
        LoadDataSUP();
    }
    protected void gvSUP_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView row = (DataRowView)e.Row.DataItem;

            LYN.Supplier.UCO.SupplierUCO uco = new LYN.Supplier.UCO.SupplierUCO();
            DataTable dt = uco.GetWSSignNextInfo(row["LNO"].ToString(), hfSiteName.Value, Current.UserGUID);

            if (dt.Rows.Count > 0)
            {
                LinkButton btnLNO = (LinkButton)e.Row.FindControl("btnLNO");
                ExpandoObject param = new { TASK_ID = dt.Rows[0]["TASK_ID"].ToString(), SITE_ID = dt.Rows[0]["SITE_ID"].ToString(), NODE_SEQ = dt.Rows[0]["NODE_SEQ"].ToString() }.ToExpando();
                Dialog.Open2(btnLNO, "~/WKF/FormUse/FreeTask/SignNodeForm.aspx", "", 1500, 800, Dialog.PostBackType.AfterReturn, param);
            }
            else {
                LinkButton btnLNO = (LinkButton)e.Row.FindControl("btnLNO");
                ExpandoObject param = new { TASK_ID = row["TASK_ID"].ToString() }.ToExpando();
                //Grid開窗是用RowDataBound事件再開窗
                Dialog.Open2(btnLNO, "~/WKF/FormUse/ViewForm.aspx", "", 1500, 800, Dialog.PostBackType.None, param);
            }
        }
    }
    public void need_no_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindEmptyDataToGridView();
    }
    private void LoadDataSUP()
    {
        string Type = qType.SelectedValue;
        string SupplierID = qSupplierID.Text;
        string SupplierName = qSupplierName.Text;


        LYN.Supplier.UCO.SupplierUCO uco = new LYN.Supplier.UCO.SupplierUCO();

        DataTable dt = uco.GetListSUP(Type, SupplierID, SupplierName);
        ViewState["formsDT"] = dt;
        gvSUP.DataSource = dt;
        gvSUP.DataBind();
    }
    private void BindEmptyDataToGridView()
    {
        DataTable dtEmpty = new DataTable();
        ViewState["formsDT"] = dtEmpty;
        gvSUP.DataSource = dtEmpty;
        gvSUP.DataBind();
    }
    public void Query_Click(object sender, EventArgs e)
    {
        LoadDataSUP();
    }
    public void Clear_Click(object sender, EventArgs e)
    {
        qSupplierID.Text = "";
        qSupplierName.Text = "";
        qType.SelectedIndex = 0;
    }
}