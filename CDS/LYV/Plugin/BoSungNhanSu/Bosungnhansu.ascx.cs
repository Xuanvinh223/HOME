using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
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

public partial class WKF_OptionalFields_Bosungnhansu : WKF_FormManagement_VersionFieldUserControl_VersionFieldUC
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
            if (hfLYV.Value == "")
            {
                 tbUserid.Text = Current.Account;


            }
            else
            {
                if (tbDNChude.Text == "")
                {
                    pDN.Visible = false;
                    lbDNChude.Text = "No matched data!";
                    pPrintDN.Visible = false;
                }
            }
            tbUserid.Enabled = false;
        }
       
    }
    private void InitializeDataTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("listLine", typeof(int));
        dt.Columns.Add("DonVi", typeof(string));
        dt.Columns.Add("TenNV", typeof(string));
        dt.Columns.Add("MaNV", typeof(string));
        dt.Columns.Add("GioiTinh", typeof(string));
        dt.Columns.Add("NgayVaoCT", typeof(string));
        dt.Columns.Add("NgayNghiViec", typeof(string));
        dt.Columns.Add("LyDoNghi", typeof(string));

        // Thêm dòng mẫu với listLine bằng 1
        DataRow newRow = dt.NewRow();
        newRow["listLine"] = 1;
        newRow["DonVi"] = "";
        newRow["TenNV"] = "";
        newRow["MaNV"] = "";
        newRow["GioiTinh"] = "";
        newRow["NgayVaoCT"] = "";
        newRow["NgayNghiViec"] = "";
        newRow["LyDoNghi"] = "";
        dt.Rows.Add(newRow);

        ViewState["formsDT"] = dt; // Lưu DataTable vào ViewState
        gvData.DataSource = dt;
        gvData.DataBind();
        gvData.SetEditRow(0);
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
        gvData.DataSource = dt;
        gvData.DataBind();
    }
    protected void txtMaNVEdit_TextChanged(object sender, EventArgs e)
    {
        // Xử lý sự kiện khi nội dung của TextBox trong cột ID thay đổi
        TextBox txtMaNVEdit = sender as TextBox;
        GridViewRow row = txtMaNVEdit.NamingContainer as GridViewRow;
        int rowIndex = row.RowIndex;
        TextBox txtTenNVEdit = row.FindControl("txtTenNVEdit") as TextBox;
        TextBox txtMaNV = row.FindControl("txtMaNVEdit") as TextBox;
        TextBox txtDonViEdit = row.FindControl("txtDonViEdit") as TextBox;
        TextBox txtGioiTinhEdit = row.FindControl("txtGioiTinhEdit") as TextBox;
        TextBox txtNgayVaoCTEdit = row.FindControl("txtNgayVaoCTEdit") as TextBox;
        TextBox txtNgayNghiViecEdit = row.FindControl("txtNgayNghiViecEdit") as TextBox;
        TextBox txtLyDoNghiEdit = row.FindControl("txtLyDoNghiEdit") as TextBox;

        // Lấy giá trị mới từ TextBox
        string newIDValue = txtMaNVEdit.Text;
        if (newIDValue != "")
        {
            LYV.BoSungNhanSu.UCO.BoSungNhanSuUCO uco = new LYV.BoSungNhanSu.UCO.BoSungNhanSuUCO();
            string data = uco.GetEmployee(newIDValue);
            string TenNV = data.Split(";")[0];
            string DonVi = data.Split(";")[1];
            string GioiTinh = data.Split(";")[2];
            string NgayvaoCT = data.Split(";")[3];
            string NgayThoiViec = data.Split(";")[4];
            string LyDoNghi = data.Split(";")[5];

            if (data == "")
            {             
                txtTenNVEdit.Text = "";
                txtMaNV.Text = "";
                txtDonViEdit.Text = "";
                txtGioiTinhEdit.Text = "";
                txtNgayVaoCTEdit.Text = "";
                txtNgayNghiViecEdit.Text = "";
                txtLyDoNghiEdit.Text = ""; 
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertMessage", "alert('There is no information of user " + newIDValue + "')", true);
            }
            else
            {
                txtTenNVEdit.Text = TenNV;
                txtDonViEdit.Text = DonVi;
                txtGioiTinhEdit.Text = GioiTinh;
                txtNgayVaoCTEdit.Text = NgayvaoCT;
                txtNgayNghiViecEdit.Text = NgayThoiViec;
                txtLyDoNghiEdit.Text = LyDoNghi;
            }
        }
        else
        {
            txtTenNVEdit.Text = "";        
            txtDonViEdit.Text = "";
            txtGioiTinhEdit.Text = "";
            txtNgayVaoCTEdit.Text = "";
            txtNgayNghiViecEdit.Text = "";
            txtLyDoNghiEdit.Text = "";
        }
    }

    protected void gvData_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvData.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void gvData_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        DataTable dt = ViewState["formsDT"] as DataTable;

        GridViewRow row = gvData.Rows[e.RowIndex];
        int listLine = Convert.ToInt32((row.FindControl("lblListLine") as Label).Text);
        TextBox txtDonVi = row.FindControl("txtDonViEdit") as TextBox;
        TextBox txtMaNV = row.FindControl("txtMaNVEdit") as TextBox;
        TextBox txtTenNV = row.FindControl("txtTenNVEdit") as TextBox;
        TextBox txtGioiTinh = row.FindControl("txtGioiTinhEdit") as TextBox;
        TextBox txtNgayVaoCT = row.FindControl("txtNgayVaoCTEdit") as TextBox;
        TextBox txtNgayNghiViec  = row.FindControl("txtNgayNghiViecEdit") as TextBox;
        TextBox txtLyDoNghi = row.FindControl("txtLyDoNghiEdit") as TextBox;


        DataRow updatedRow = dt.Rows.Cast<DataRow>().FirstOrDefault(r => (int)r["listLine"] == listLine);
        if (updatedRow != null)
        {
            updatedRow["TenNV"] = txtTenNV.Text;
            updatedRow["MaNV"] = txtMaNV.Text;
            updatedRow["DonVi"] = txtDonVi.Text;
            updatedRow["GioiTinh"] = txtGioiTinh.Text;
            updatedRow["NgayVaoCT"] = txtNgayVaoCT.Text;
            updatedRow["NgayNghiViec"] = txtNgayNghiViec.Text;
            updatedRow["LyDoNghi"] = txtLyDoNghi.Text;
        }
        ViewState["formsDT"] = dt;
        gvData.EditIndex = -1;
        BindGrid();
    }
    protected void gvData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvData.EditIndex = -1;
        BindGrid();
    }
    protected void gvData_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DataTable dt = ViewState["formsDT"] as DataTable;

        // Xóa dòng đã chọn
        dt.Rows.RemoveAt(e.RowIndex);
        ViewState["formsDT"] = dt;
        BindGrid();
    }
    protected void gvData_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView row = (DataRowView)e.Row.DataItem;
            if (hfLYV.Value.ToString() == "")
            {
                gvData.Columns[gvData.Columns.Count - 1].Visible = true;
            }
            else
            {
                gvData.Columns[gvData.Columns.Count - 1].Visible = false;
            }
        }
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
        if (gvData.EditIndex >= 0) gvData.UpdateRow(gvData.EditIndex, false);
        BindGrid();
        if (nextListLine > 1) gvData.SetEditRow(nextListLine - 1);
    }


    public void Print_Click(object sender, EventArgs e)
    {
        ExpandoObject param = new { LYV = hfLYV.Value, Namerpt = "BoSungNhanSu" }.ToExpando();
        Dialog.Open2(btnPrint, "~/CDS/LYV/Plugin/BoSungNhanSu/BoSungNhanSu_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
    }
    public void Print_ClickDN(object sender, EventArgs e)
    {
        ExpandoObject param = new { LYV = hfLYV.Value, Namerpt = "BSNS_DeNghi" }.ToExpando();
        Dialog.Open2(btnPrintDN, "~/CDS/LYV/Plugin/BoSungNhanSu/BoSungNhanSu_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
    }
    public void Print_ClickDS(object sender, EventArgs e)
    {
        ExpandoObject param = new { LYV = hfLYV.Value, Namerpt = "BSNSDSThoiViec" }.ToExpando();
        Dialog.Open2(btnPrintDS, "~/CDS/LYV/Plugin/BoSungNhanSu/BoSungNhanSu_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
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
            XElement xE = new XElement("BosungnhansuPlugin");
            xE.Add(new XAttribute("MaPhieu", tbMaphieu.Text));
            xE.Add(new XAttribute("NoiGui", tbNoigui.Text));
            xE.Add(new XAttribute("SLBienChe_Nam", tbSLBienChe_Nam.Text));
            xE.Add(new XAttribute("SLBienChe_Nu", tbSLBienChe_Nu.Text));
            xE.Add(new XAttribute("SLThucTe_Nam", tbSLThucTe_Nam.Text));
            xE.Add(new XAttribute("SLThucTe_Nu", tbSLThucTe_Nu.Text));
            xE.Add(new XAttribute("SLDeNghi", tbSLDeNghi.Text));
            xE.Add(new XAttribute("TrinhDoVH", tbTrinhDoVH.Text));
            xE.Add(new XAttribute("ThoiGianBS", tbThoiGianBS.Text));
            xE.Add(new XAttribute("LyDoBS", ddlLyDoBS.SelectedValue));
            xE.Add(new XAttribute("GhiChu", tbGhiChu.Text));

            xE.Add(new XAttribute("DNChude", tbDNChude.Text));
            xE.Add(new XAttribute("DNNoidung", tbDNNoidung.Text));

            xE.Add(new XAttribute("UserID", tbUserid.Text));

            DataTable dt = ViewState["formsDT"] as DataTable;
            if (gvData.EditIndex >= 0) gvData.UpdateRow(gvData.EditIndex, false);
            int k = 0;
            for (int i = 0; i < gvData.Rows.Count; i++)
            {
                if (dt.Rows[i]["DonVi"].ToString() != "" || dt.Rows[i]["MaNV"].ToString() != "" || dt.Rows[i]["TenNV"].ToString() != "" || dt.Rows[i]["GioiTinh"].ToString() != "" || dt.Rows[i]["NgayVaoCT"].ToString() != "" || dt.Rows[i]["NgayNghiViec"].ToString() != "" || dt.Rows[i]["LyDoNghi"].ToString() != "")
                {
                    XElement xE1 = new XElement("LYV_BSBN_" + k.ToString());
                    xE1.Add(new XAttribute("DonVi", dt.Rows[i]["DonVi"].ToString()));
                    xE1.Add(new XAttribute("MaNV", dt.Rows[i]["MaNV"].ToString()));
                    xE1.Add(new XAttribute("TenNV", dt.Rows[i]["TenNV"].ToString()));
                    xE1.Add(new XAttribute("GioiTinh", dt.Rows[i]["GioiTinh"].ToString()));
                    xE1.Add(new XAttribute("NgayVaoCT", dt.Rows[i]["NgayVaoCT"].ToString()));
                    xE1.Add(new XAttribute("NgayNghiViec", dt.Rows[i]["NgayNghiViec"].ToString()));
                    xE1.Add(new XAttribute("LyDoNghi", dt.Rows[i]["LyDoNghi"].ToString()));
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
        btnAdd.Visible = Enabled;
        pTable.Enabled = Enabled;
      
    }
    private void SetCustomField(XElement xeTP)
    {

        tbUserid.Text = xeTP.Attribute("UserID").Value;
        tbMaphieu.Text = xeTP.Attribute("MaPhieu").Value;
        tbNoigui.Text = xeTP.Attribute("NoiGui").Value;
        tbSLBienChe_Nam.Text = xeTP.Attribute("SLBienChe_Nam").Value;
        tbSLBienChe_Nu.Text = xeTP.Attribute("SLBienChe_Nu").Value;
        tbSLThucTe_Nam.Text = xeTP.Attribute("SLThucTe_Nam").Value;
        tbSLThucTe_Nu.Text = xeTP.Attribute("SLThucTe_Nu").Value;
        tbSLDeNghi.Text = xeTP.Attribute("SLDeNghi").Value;
        tbTrinhDoVH.Text = xeTP.Attribute("TrinhDoVH").Value;
        tbThoiGianBS.Text = xeTP.Attribute("ThoiGianBS").Value;
        tbDNNoidung.Text = xeTP.Attribute("DNNoidung").Value;
        tbDNChude.Text = xeTP.Attribute("DNChude").Value;
        tbGhiChu.Text = xeTP.Attribute("GhiChu").Value;
        if (xeTP.Attribute("LyDoBS").Value == "")
        {
            ddlLyDoBS.SelectedValue = "Default";
        }
        else
        {
            ddlLyDoBS.SelectedValue = xeTP.Attribute("LyDoBS").Value;
        }

        int count = Convert.ToInt32(xeTP.Attribute("Person").Value);
        DataTable dt = new DataTable();
        dt.Columns.Add("listLine", typeof(int));
        dt.Columns.Add("DonVi", typeof(string));
        dt.Columns.Add("TenNV", typeof(string));
        dt.Columns.Add("MaNV", typeof(string));
        dt.Columns.Add("GioiTinh", typeof(string));
        dt.Columns.Add("NgayVaoCT", typeof(string));
        dt.Columns.Add("NgayNghiViec", typeof(string));
        dt.Columns.Add("LyDoNghi", typeof(string));

        for (int i = 0; i < count; i++)
        {
            XElement xE_1 = xeTP.Element("LYV_BSBN_" + i.ToString());
            DataRow newRow = dt.NewRow();
            newRow["listLine"] = i + 1;
            newRow["DonVi"] = xE_1.Attribute("DonVi").Value;
            newRow["TenNV"] = xE_1.Attribute("TenNV").Value;
            newRow["MaNV"] = xE_1.Attribute("MaNV").Value;
            newRow["GioiTinh"] = xE_1.Attribute("GioiTinh").Value;
            newRow["NgayVaoCT"] = xE_1.Attribute("NgayVaoCT").Value;
            newRow["NgayNghiViec"] = xE_1.Attribute("NgayNghiViec").Value;
            newRow["LyDoNghi"] = xE_1.Attribute("LyDoNghi").Value;
            dt.Rows.Add(newRow);
        }
        ViewState["formsDT"] = dt; // Lưu DataTable vào ViewState
        gvData.DataSource = dt;
        gvData.EditIndex = -1;
        gvData.DataBind();
        if (hfTASK_RESULT.Value.ToString() == "Adopt")
        {
            pPrint.Visible = true;
            pPrintDN.Visible = true;
            if (count <= 0) 
            {
                pPrintDS.Visible = false;
            }
            else
            {
                pPrintDS.Visible = true;
            }
        }
           
        else
        {
            pPrint.Visible = false;
            pPrintDN.Visible = false;
            pPrintDS.Visible = false;

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
                    hfLYV.Value = base.taskObj.FormNumber;
                    hfTASKID.Value = base.taskObj.TaskId;
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