using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ede.Uof.WKF.Design;
using Ede.Uof.EIP.Organization.Util;
using System.Linq;
using Ede.Uof.EIP.SystemInfo;
using System.Xml.Linq;
using DocumentFormat.OpenXml.Spreadsheet;
using Ede.Uof.Utility.Page.Common;
using System.Dynamic;

public partial class LYV_Out : WKF_FormManagement_VersionFieldUserControl_VersionFieldUC
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
            InitializeDataTable();
            SetField(m_versionField);
        }
    }
    private void InitializeDataTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("listLine", typeof(int));
        dt.Columns.Add("Name", typeof(string));
        dt.Columns.Add("ID", typeof(string));
        dt.Columns.Add("Factory", typeof(string));
        dt.Columns.Add("Department", typeof(string));

        // Thêm dòng mẫu với listLine bằng 1
        DataRow newRow = dt.NewRow();
        newRow["listLine"] = 1;
        newRow["Name"] = "";
        newRow["ID"] = "";
        newRow["Factory"] = "";
        newRow["Department"] = "";
        dt.Rows.Add(newRow);

        ViewState["formsDT"] = dt; // Lưu DataTable vào ViewState
        gvMB.DataSource = dt;
        gvMB.DataBind();
        gvMB.SetEditRow(0);
    }
    private void BindGrid()
    {
        DataTable dt = ViewState["formsDT"] as DataTable;
        int listLine = 1;
        foreach (DataRow row in dt.Rows)
        {
            row["listLine"] = listLine++;
        }
        ViewState["formsDT"] = dt;
        gvMB.DataSource = dt;
        gvMB.DataBind();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        DataTable dt = ViewState["formsDT"] as DataTable;

        // Thêm một dòng mới với ListLine tăng dần
        int nextListLine = dt.Rows.Count + 1;

        DataRow newRow = dt.NewRow();
        newRow["listLine"] = nextListLine;
        dt.Rows.Add(newRow);
        
        ViewState["formsDT"] = dt;
        if(gvMB.EditIndex >=0) gvMB.UpdateRow(gvMB.EditIndex, false);
        BindGrid();
        if (nextListLine>=1) gvMB.SetEditRow(nextListLine-1);
    }
    protected void gvMB_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (gvMB.EditIndex >= 0) gvMB.UpdateRow(gvMB.EditIndex, false);
        gvMB.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void gvMB_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        DataTable dt = ViewState["formsDT"] as DataTable;

        GridViewRow row = gvMB.Rows[e.RowIndex];
        int listLine = Convert.ToInt32((row.FindControl("lblListLine") as Label).Text);
        TextBox txtName = row.FindControl("txtNameEdit") as TextBox;
        TextBox txtID = row.FindControl("txtIDEdit") as TextBox;
        TextBox txtFactory = row.FindControl("txtFactoryEdit") as TextBox;
        TextBox txtDepartment = row.FindControl("txtDepartmentEdit") as TextBox;

        DataRow updatedRow = dt.Rows.Cast<DataRow>().FirstOrDefault(r => (int)r["listLine"] == listLine);
        if (updatedRow != null)
        {
            updatedRow["Name"] = txtName.Text;
            updatedRow["ID"] = txtID.Text;
            updatedRow["Factory"] = txtFactory.Text;
            updatedRow["Department"] = txtDepartment.Text;
        }
        ViewState["formsDT"] = dt;
        gvMB.EditIndex = -1;
        BindGrid();
    }

    protected void gvMB_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvMB.EditIndex = -1;
        BindGrid();
    }

    protected void gvMB_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DataTable dt = ViewState["formsDT"] as DataTable;

        // Xóa dòng đã chọn
        dt.Rows.RemoveAt(e.RowIndex);
        ViewState["formsDT"] = dt;
        gvMB.EditIndex = -1;
        BindGrid();
    }
    protected void gvMB_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView row = (DataRowView)e.Row.DataItem;
            if (hfLNO.Value.ToString() == "")
            {
                gvMB.Columns[gvMB.Columns.Count - 1].Visible = true;
            }
            else
            {
                gvMB.Columns[gvMB.Columns.Count - 1].Visible = false;
            }
        }
    }
    protected void txtIDEdit_TextChanged(object sender, EventArgs e)
    {
        // Xử lý sự kiện khi nội dung của TextBox trong cột ID thay đổi
        TextBox txtIDEdit = sender as TextBox;
        GridViewRow row = txtIDEdit.NamingContainer as GridViewRow;
        int rowIndex = row.RowIndex;
        TextBox txtNameEdit = row.FindControl("txtNameEdit") as TextBox;
        TextBox txtID = row.FindControl("txtIDEdit") as TextBox;
        TextBox txtFactoryEdit = row.FindControl("txtFactoryEdit") as TextBox;
        TextBox txtDepartmentEdit = row.FindControl("txtDepartmentEdit") as TextBox;

        // Lấy giá trị mới từ TextBox
        string newIDValue = txtIDEdit.Text;
        if (newIDValue != "")
        {
            Training.Out.UCO.OutUCO uco = new Training.Out.UCO.OutUCO();
            string data = uco.GetEmployee(newIDValue);
            string Name = data.Split(";")[0];
            string Department = data.Split(";")[1];
            string Factory = data.Split(";")[3];
            if (data == "")
            {
                txtNameEdit.Text = "";
                txtID.Text = "";
                txtFactoryEdit.Text = "";
                txtDepartmentEdit.Text = "";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('There is no information of user " + newIDValue + "')", true);
            }
            else
            {
                txtNameEdit.Text = Name;
                txtFactoryEdit.Text = Factory;
                txtDepartmentEdit.Text = Department;
            }
        }
        else
        {
            txtNameEdit.Text = "";
            txtFactoryEdit.Text = "";
            txtDepartmentEdit.Text = "";
        }
    }
    public void Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Type.SelectedValue == "C.物品外出-其他類(Vat pham Khac)" || Type.SelectedValue == "D.物品外出-資產類(Vat pham tai san)")
        {
            pCD.Visible = true;
        }
        else
        {
            pCD.Visible = false;
        }
    }
    protected void SearchCategory_Click(object sender, EventArgs e)
    {
        if (pCategory.Visible == false)
        {
            pCategory.Visible = true;
        }
        else
        {
            pCategory.Visible = false;
        }
    }
    protected void CategoryList_SelectedIndexChanged(object sender, EventArgs e)
    {
        string category = "";
        foreach (ListItem item in cbCategory.Items)
        {
            if (item.Selected)
            {
                // Xử lý tùy thuộc vào ô kiểm đã chọn
                category = category + "," + item.Value;
                // Thêm mã xử lý của bạn ở đây
            }
        }
        if (category != "") category = category.Substring(1);
        Category.Text = category;
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        string category = "";
        foreach (ListItem item in cbCategory.Items)
        {
            if (item.Selected)
            {
                // Xử lý tùy thuộc vào ô kiểm đã chọn
                category = category +","+ item.Value;
                // Thêm mã xử lý của bạn ở đây
            }
        }
        if(category != "") category=category.Substring(1);
        Category.Text = category;
        pCategory.Visible = false;
    }
    public void Print_Click(object sender, EventArgs e)
    {
        ExpandoObject param = new { LNO = hfLNO.Value }.ToExpando();
        string url = "~/CDS/LYV/Plugin/Out/LYV_Out_Reports.aspx";
        Dialog.Open2(Print, url, "", 950, 600, Dialog.PostBackType.None, param);
    }
    public void Disable_Click(object sender, EventArgs e)
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
            Dialog.Open2(Disable, "~/CDS/LYV/Plugin/Out/LYN_Out_Modal.aspx", "註銷外出單", 950, 600, Dialog.PostBackType.None, param);
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
            XElement xE = new XElement("LYN_Out");
            
            xE.Add(new XAttribute("LeaveTime", LeaveTime.Text));
            xE.Add(new XAttribute("ReturnTime", ReturnTime.Text));
            if (Type.SelectedValue == "Default")
            {
                xE.Add(new XAttribute("Type", ""));
            }
            else
            {
                xE.Add(new XAttribute("Type", Type.SelectedValue));
            }
            xE.Add(new XAttribute("Category", Category.Text));
            xE.Add(new XAttribute("Item", Item.Text));
            xE.Add(new XAttribute("Reason", Reason.Text));
            xE.Add(new XAttribute("Account", Current.Account));

            DataTable dt = ViewState["formsDT"] as DataTable;
            if (gvMB.EditIndex >= 0)  gvMB.UpdateRow(gvMB.EditIndex, false);
            int k = 0;
            for (int i = 0; i < gvMB.Rows.Count; i++)
            {
                if (dt.Rows[i]["ID"].ToString() != "" || dt.Rows[i]["Name"].ToString() != "" || dt.Rows[i]["Factory"].ToString() != "" || dt.Rows[i]["Department"].ToString() != "")
                {
                    XElement xE1 = new XElement("LYN_Out_" + k.ToString());
                    xE1.Add(new XAttribute("ID", dt.Rows[i]["ID"].ToString()));
                    xE1.Add(new XAttribute("Name", dt.Rows[i]["Name"].ToString()));
                    xE1.Add(new XAttribute("Factory", dt.Rows[i]["Factory"].ToString()));
                    xE1.Add(new XAttribute("Department", dt.Rows[i]["Department"].ToString()));
                    xE.Add(xE1);
                    k++;
                }
            }
            xE.Add(new XAttribute("Person", k));

            return xE.ToString();

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
        pTable.Enabled = Enabled;
        btnAdd.Visible = Enabled;
    }
   private void SetCustomField(XElement xeTP)
    {
        //< FieldItem fieldId = "C99" ConditionValue = "" realValue = "" >
        //  < TestPlugin Type = "456" />
        //</ FieldItem >
        LeaveTime.Text = xeTP.Attribute("LeaveTime").Value;
        ReturnTime.Text = xeTP.Attribute("ReturnTime").Value;
        if (xeTP.Attribute("Type").Value == "")
        {
            Type.SelectedValue = "Default";
        }
        else
        {
            Type.SelectedValue = xeTP.Attribute("Type").Value;
        }
        if (Type.SelectedValue == "C.物品外出-其他類(Vat pham Khac)" || Type.SelectedValue == "D.物品外出-資產類(Vat pham tai san)")
        {
            pCD.Visible = true;
        }
        else
        {
            pCD.Visible = false;
        }
        Category.Text = xeTP.Attribute("Category").Value;
        Item.Text = xeTP.Attribute("Item").Value;
        Reason.Text = xeTP.Attribute("Reason").Value;
        int count = Convert.ToInt32(xeTP.Attribute("Person").Value);
        DataTable dt = new DataTable();
        dt.Columns.Add("listLine", typeof(int));
        dt.Columns.Add("Name", typeof(string));
        dt.Columns.Add("ID", typeof(string));
        dt.Columns.Add("Factory", typeof(string));
        dt.Columns.Add("Department", typeof(string));

        for (int i = 0; i < count; i++)
        {
            XElement xE_1 = xeTP.Element("LYN_Out_" + i.ToString());
            DataRow newRow = dt.NewRow();
            newRow["listLine"] = i+1;
            newRow["Name"] = xE_1.Attribute("Name").Value;
            newRow["ID"] = xE_1.Attribute("ID").Value;
            newRow["Factory"] = xE_1.Attribute("Factory").Value;
            newRow["Department"] = xE_1.Attribute("Department").Value;
            dt.Rows.Add(newRow);
        }
        ViewState["formsDT"] = dt; // Lưu DataTable vào ViewState
        gvMB.DataSource = dt;
        gvMB.EditIndex = -1;
        gvMB.DataBind();
        string LNO = hfLNO.Value.ToString();
        Training.Out.UCO.OutUCO uco = new Training.Out.UCO.OutUCO();
        string Status = uco.GetOut(LNO);
        string Account = xeTP.Attribute("Account").Value;
        if (Account == Current.Account && Status != "cancel")
        {
            panel1.Visible = true;
            ExpandoObject param1 = new { LNO = hfLNO.Value }.ToExpando();
            Dialog.Open2(Print, "~/CDS/LYV/Plugin/Out/LYV_Out_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param1);
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