using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using Ede.Uof.WKF.Design;
using Ede.Uof.EIP.Organization.Util;
using Ede.Uof.EIP.SystemInfo;
using System.Xml.Linq;
using DocumentFormat.OpenXml.Spreadsheet;
using Ede.Uof.Utility.Page.Common;
using System.Dynamic;

public partial class WKF_Supplier : WKF_FormManagement_VersionFieldUserControl_VersionFieldUC
{

    #region ==============公開方法及屬性==============
    //表單設計時
    //如果為False時,表示是在表單設計時
    private bool m_ShowGetValueButton = true;


    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SetField(m_versionField);
        }
    }

    public void Print_Click(object sender, EventArgs e)
    {
        ExpandoObject param = new { LYV = hfLYV.Value }.ToExpando();
        Dialog.Open2(btnPrint, "~/CDS/LYV/Plugin/Supplier/Supplier_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
    }

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


    public override string FieldValue
    {
        get
        {
            XElement TPElement = new XElement("Supplier");
            TPElement.Add(new XAttribute("Type", Type.SelectedValue.ToString()));
            TPElement.Add(new XAttribute("SupplierID", SupplierID.Text));
            TPElement.Add(new XAttribute("SupplierName", SupplierName.Text));
            TPElement.Add(new XAttribute("CompanyAddress", CompanyAddress.Text));
            TPElement.Add(new XAttribute("FactoryAddress", FactoryAddress.Text));
            TPElement.Add(new XAttribute("Product", Product.Text));
            TPElement.Add(new XAttribute("Established", Established.Text));
            TPElement.Add(new XAttribute("License", License.Text));
            TPElement.Add(new XAttribute("PersonInCharge", PersonInCharge.Text));
            TPElement.Add(new XAttribute("ContactPerson", ContactPerson.Text));
            TPElement.Add(new XAttribute("Tel", Tel.Text));
            TPElement.Add(new XAttribute("Fax", Fax.Text));
            TPElement.Add(new XAttribute("Email", Email.Text));
            TPElement.Add(new XAttribute("Designated", Designated.Checked ? 1 : 0));
            TPElement.Add(new XAttribute("Cooperated", Cooperated.Checked ? 1 : 0));
            TPElement.Add(new XAttribute("C_Qualified", C_Qualified.SelectedValue));
            TPElement.Add(new XAttribute("New", New.Checked ? 1 : 0));
            TPElement.Add(new XAttribute("N_Qualified", N_Qualified.SelectedValue));
            TPElement.Add(new XAttribute("Price", Price.SelectedValue));
            TPElement.Add(new XAttribute("Effective", Effective.SelectedValue));
            TPElement.Add(new XAttribute("Remark", Remark.Text));
            return TPElement.ToString();

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
        Type.Enabled = Enabled;
        SupplierID.Enabled = Enabled;
        SupplierName.Enabled = Enabled;
        CompanyAddress.Enabled = Enabled;
        FactoryAddress.Enabled = Enabled;
        Product.Enabled = Enabled;
        Established.Enabled = Enabled;
        License.Enabled = Enabled;
        PersonInCharge.Enabled = Enabled;
        ContactPerson.Enabled = Enabled;
        Tel.Enabled = Enabled;
        Fax.Enabled = Enabled;
        Email.Enabled = Enabled;
        Designated.Enabled = Enabled;
        Cooperated.Enabled = Enabled;
        C_Qualified.Enabled = Enabled;
        New.Enabled = Enabled;
        N_Qualified.Enabled = Enabled;
        Price.Enabled = Enabled;
        Effective.Enabled = Enabled;
        Remark.Enabled = Enabled;
    }


    private void SetCustomField(XElement xeTP)
    {
        Type.SelectedValue = xeTP.Attribute("Type").Value;
        SupplierID.Text = xeTP.Attribute("SupplierID").Value;
        SupplierName.Text = xeTP.Attribute("SupplierName").Value;
        CompanyAddress.Text = xeTP.Attribute("CompanyAddress").Value;
        FactoryAddress.Text = xeTP.Attribute("FactoryAddress").Value;
        Product.Text = xeTP.Attribute("Product").Value;
        Established.Text = xeTP.Attribute("Established").Value;
        License.Text = xeTP.Attribute("License").Value;
        PersonInCharge.Text = xeTP.Attribute("PersonInCharge").Value;
        ContactPerson.Text = xeTP.Attribute("ContactPerson").Value;
        Tel.Text = xeTP.Attribute("Tel").Value;
        Fax.Text = xeTP.Attribute("Fax").Value;
        Email.Text = xeTP.Attribute("Email").Value;
        Designated.Checked = xeTP.Attribute("Designated").Value == "1" ? true : false;
        Cooperated.Checked = xeTP.Attribute("Cooperated").Value == "1" ? true : false;
        C_Qualified.SelectedValue= xeTP.Attribute("C_Qualified").Value;
        New.Checked = xeTP.Attribute("New").Value == "1" ? true : false;
        N_Qualified.SelectedValue = xeTP.Attribute("N_Qualified").Value;
        Price.SelectedValue = xeTP.Attribute("Price").Value;
        Effective.SelectedValue = xeTP.Attribute("Effective").Value;
        Remark.Text = xeTP.Attribute("Remark").Value;

        if (hfTASK_RESULT.Value.ToString() == "Adopt")
        {
            ExpandoObject param = new { LYV = hfLYV.Value }.ToExpando();
            Dialog.Open2(btnPrint, "~/CDS/LYV/Plugin/Supplier/Supplier_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
            pPrint.Visible = true;
        }
        else
        {
            pPrint.Visible = false;
        }
    }

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