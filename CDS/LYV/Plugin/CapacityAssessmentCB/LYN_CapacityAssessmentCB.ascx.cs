using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Ede.Uof.WKF.Design;
using System.Collections.Generic;
using Ede.Uof.WKF.Utility;
using Ede.Uof.EIP.Organization.Util;
using Ede.Uof.WKF.Design.Data;
using Ede.Uof.WKF.VersionFields;
using System.Xml;
using System.Linq;
using Ede.Uof.EIP.SystemInfo;
using System.Xml.Linq;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Runtime.InteropServices;
using System.ComponentModel;
using System.Text;
using System.Globalization;
using DocumentFormat.OpenXml.Spreadsheet;
using Ede.Uof.Utility.Page.Common;
using System.Dynamic;
using DocumentFormat.OpenXml.Presentation;

public partial class WKF_CapacityAssessmentCB : WKF_FormManagement_VersionFieldUserControl_VersionFieldUC
{

    #region ==============公開方法及屬性==============
    //表單設計時
    //如果為False時,表示是在表單設計時
    private bool m_ShowGetValueButton = true;
    Training.CapacityAssessmentCB.UCO.CapacityAssessmentCBUCO uco = new Training.CapacityAssessmentCB.UCO.CapacityAssessmentCBUCO();

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
            SetField(m_versionField);
        }
        // Đăng ký file JavaScript bên ngoài
        
    }
    protected void ID_TextChanged(object sender, EventArgs e)
    {
        string data = this.uco.GetEmployee(ID.Text);
        string UserName = data.Split(";")[0];
        string UserDep = data.Split(";")[1];
        string Flag = data.Split(";")[2];
        string idSoThe = ID.Text;
       
        if (UserName == "")
        {
            Name.Text = "";
            Dep.Text = "";
            // Gọi hàm JavaScript từ file đã được chèn
            ShowErrorMessage("Số thẻ "+idSoThe+" không tồn tại");
        }
        else if (Flag != "Employee")
        {
            Name.Text = "";
            Dep.Text = "";
            ShowErrorMessage("Nhân viên này đã nghỉ việc | 此員工已離職");
        }
        else
        {
            Name.Text = UserName;
            Dep.Text = UserDep;
        }
    }

    void ShowErrorMessage(string message)
    {
        string script = "showMessage('"+ message + "');";
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "callShowMessage", script, true);
    }

    public void ChangeTotal()
    {
        TC1.Text = Convert.ToString(Convert.ToDouble(GQ1.Text.Replace(".",",") == "" ? "0" : GQ1.Text.Replace(".",",")) + Convert.ToDouble(ST1.Text.Replace(".", ",") == "" ? "0" : ST1.Text.Replace(".", ",")) + Convert.ToDouble(GT1.Text.Replace(".",",") == "" ? "0" : GT1.Text.Replace(".",",")) + Convert.ToDouble(HT1.Text.Replace(".",",") == "" ? "0" : HT1.Text.Replace(".",",")) + Convert.ToDouble(CV1.Text.Replace(".",",") == "" ? "0" : CV1.Text.Replace(".",",")) + Convert.ToDouble(TN1.Text.Replace(".",",") == "" ? "0" : TN1.Text.Replace(".",",")) + Convert.ToDouble(CP1.Text.Replace(".",",") == "" ? "0" : CP1.Text.Replace(".",",")));
        TC2.Text = Convert.ToString(Convert.ToDouble(GQ2.Text.Replace(".", ",") == "" ? "0" : GQ2.Text.Replace(".", ",")) + Convert.ToDouble(ST2.Text.Replace(".", ",") == "" ? "0" : ST2.Text.Replace(".", ",")) + Convert.ToDouble(GT2.Text.Replace(".",",") == "" ? "0" : GT2.Text.Replace(".",",")) + Convert.ToDouble(HT2.Text.Replace(".",",") == "" ? "0" : HT2.Text.Replace(".",",")) + Convert.ToDouble(CV2.Text.Replace(".",",") == "" ? "0" : CV2.Text.Replace(".",",")) + Convert.ToDouble(TN2.Text.Replace(".",",") == "" ? "0" : TN2.Text.Replace(".",",")) + Convert.ToDouble(CP2.Text.Replace(".",",") == "" ? "0" : CP2.Text.Replace(".",",")));
        GQ3.Text = Convert.ToString((Convert.ToDouble(GQ1.Text.Replace(".", ",") == "" ? "0" : GQ1.Text.Replace(".", ",")) + Convert.ToDouble(GQ2.Text.Replace(".", ",") == "" ? "0" : GQ2.Text.Replace(".", ","))) / 2);
        ST3.Text = Convert.ToString((Convert.ToDouble(ST1.Text.Replace(".", ",") == "" ? "0" : ST1.Text.Replace(".", ",")) + Convert.ToDouble(ST2.Text.Replace(".", ",") == "" ? "0" : ST2.Text.Replace(".", ","))) / 2);
        GT3.Text = Convert.ToString((Convert.ToDouble(GT1.Text.Replace(".",",") == "" ? "0" : GT1.Text.Replace(".",",")) + Convert.ToDouble(GT2.Text.Replace(".",",") == "" ? "0" : GT2.Text.Replace(".",","))) / 2);
        HT3.Text = Convert.ToString((Convert.ToDouble(HT1.Text.Replace(".",",") == "" ? "0" : HT1.Text.Replace(".",",")) + Convert.ToDouble(HT2.Text.Replace(".",",") == "" ? "0" : HT2.Text.Replace(".",","))) / 2);
        CV3.Text = Convert.ToString((Convert.ToDouble(CV1.Text.Replace(".",",") == "" ? "0" : CV1.Text.Replace(".",",")) + Convert.ToDouble(CV2.Text.Replace(".",",") == "" ? "0" : CV2.Text.Replace(".",","))) / 2);
        TN3.Text = Convert.ToString((Convert.ToDouble(TN1.Text.Replace(".",",") == "" ? "0" : TN1.Text.Replace(".",",")) + Convert.ToDouble(TN2.Text.Replace(".",",") == "" ? "0" : TN2.Text.Replace(".",","))) / 2);
        CP3.Text = Convert.ToString((Convert.ToDouble(CP1.Text.Replace(".",",") == "" ? "0" : CP1.Text.Replace(".",",")) + Convert.ToDouble(CP2.Text.Replace(".",",") == "" ? "0" : CP2.Text.Replace(".",","))) / 2);
        TC3.Text = Convert.ToString(Convert.ToDouble(GQ3.Text.Replace(".", ",") == "" ? "0" : GQ3.Text.Replace(".", ",")) + Convert.ToDouble(ST3.Text.Replace(".", ",") == "" ? "0" : ST3.Text.Replace(".", ",")) + Convert.ToDouble(GT3.Text.Replace(".", ",") == "" ? "0" : GT3.Text.Replace(".", ",")) + Convert.ToDouble(HT3.Text.Replace(".", ",") == "" ? "0" : HT3.Text.Replace(".", ",")) + Convert.ToDouble(CV3.Text.Replace(".", ",") == "" ? "0" : CV3.Text.Replace(".", ",")) + Convert.ToDouble(TN3.Text.Replace(".", ",") == "" ? "0" : TN3.Text.Replace(".", ",")) + Convert.ToDouble(CP3.Text.Replace(".", ",") == "" ? "0" : CP3.Text.Replace(".", ",")));

    }
    protected void GQ_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        double textBoxValue;
        if (double.TryParse(txt.Text.Replace(".",","), out textBoxValue))
        {
            if (textBoxValue <0 || textBoxValue > 15)
            {
                txt.Text = "";
                ShowErrorMessage("Vui lòng nhập số điểm 0~15 | 請輸入點數0~15");
            }
        }
        else
        {
            txt.Text = "";
            ShowErrorMessage("Nhập sai, điểm trả về 1 | 如果輸入錯誤，分數回傳 1");
        }

        ChangeTotal();
    }

    protected void HT_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        double textBoxValue;
        if (double.TryParse(txt.Text.Replace(".",","), out textBoxValue))
        {
            if (textBoxValue < 0 || textBoxValue > 20)
            {
                txt.Text = "";
                ShowErrorMessage("Vui lòng nhập số điểm 0~20 | 請輸入點數0~20");
            }
        }
        else
        {
            txt.Text = "";
            ShowErrorMessage("Nhập sai, điểm trả về 1 | 如果輸入錯誤，分數回傳 1");
        }
        ChangeTotal();
    }
    protected void CV_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        double textBoxValue;
        if (double.TryParse(txt.Text.Replace(".",","), out textBoxValue))
        {
            if (textBoxValue < 0 || textBoxValue > 10)
            {
                txt.Text = "";
                ShowErrorMessage("Vui lòng nhập số điểm 0~10 | 請輸入點數0~10");
            }
        }
        else
        {
            txt.Text = "";
            ShowErrorMessage("Nhập sai, điểm trả về 1 | 如果輸入錯誤，分數回傳 1");
        }
        ChangeTotal();
    }
    public void Print_Click(object sender, EventArgs e)
    {
        ExpandoObject param = new { CNO = hfCNO.Value }.ToExpando();
        Dialog.Open2(Print, "~/CDS/LYV/Plugin/CapacityAssessmentCB/LYN_CapacityAssessmentCB_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
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
                Training.CapacityAssessmentCB.UCO.CapacityAssessmentCBUCO uco = new Training.CapacityAssessmentCB.UCO.CapacityAssessmentCBUCO();
                string LEV = uco.GetLEV(account, group);
                return LEV;
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
                XElement xE = new XElement("LYN_CapacityAssessment");
                xE.Add(new XAttribute("ID", ID.Text));
                xE.Add(new XAttribute("Name", Name.Text));
                xE.Add(new XAttribute("Dep", Dep.Text));
                xE.Add(new XAttribute("GQ1", GQ1.Text.Replace(",",".")));
                xE.Add(new XAttribute("GQ2", GQ2.Text.Replace(",", ".")));
                xE.Add(new XAttribute("GQ3", GQ3.Text.Replace(",", ".")));
                xE.Add(new XAttribute("ST1", ST1.Text.Replace(",", ".")));
                xE.Add(new XAttribute("ST2", ST2.Text.Replace(",", ".")));
                xE.Add(new XAttribute("ST3", ST3.Text.Replace(",", ".")));
                xE.Add(new XAttribute("GT1", GT1.Text.Replace(",", ".")));
                xE.Add(new XAttribute("GT2", GT2.Text.Replace(",", ".")));
                xE.Add(new XAttribute("GT3", GT3.Text.Replace(",", ".")));
                xE.Add(new XAttribute("HT1", HT1.Text.Replace(",", ".")));
                xE.Add(new XAttribute("HT2", HT2.Text.Replace(",", ".")));
                xE.Add(new XAttribute("HT3", HT3.Text.Replace(",", ".")));
                xE.Add(new XAttribute("CV1", CV1.Text.Replace(",", ".")));
                xE.Add(new XAttribute("CV2", CV2.Text.Replace(",", ".")));
                xE.Add(new XAttribute("CV3", CV3.Text.Replace(",", ".")));
                xE.Add(new XAttribute("TN1", TN1.Text.Replace(",", ".")));
                xE.Add(new XAttribute("TN2", TN2.Text.Replace(",", ".")));
                xE.Add(new XAttribute("TN3", TN3.Text.Replace(",", ".")));
                xE.Add(new XAttribute("CP1", CP1.Text.Replace(",", ".")));
                xE.Add(new XAttribute("CP2", CP2.Text.Replace(",", ".")));
                xE.Add(new XAttribute("CP3", CP3.Text.Replace(",", ".")));
                xE.Add(new XAttribute("TC1", TC1.Text.Replace(",", ".")));
                xE.Add(new XAttribute("TC2", TC2.Text.Replace(",", ".")));
                xE.Add(new XAttribute("TC3", TC3.Text.Replace(",", ".")));
                return xE.ToString();
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
        ID.Enabled = Enabled;
        pnDG.Enabled = Enabled;
    }
    private void SetCustomField(XElement xeTP)
    {
        //< FieldItem fieldId = "C99" ConditionValue = "" realValue = "" >
        //  < TestPlugin Type = "456" />
        //</ FieldItem >
        ID.Text = xeTP.Attribute("ID").Value;
        Name.Text = xeTP.Attribute("Name").Value;
        Dep.Text = xeTP.Attribute("Dep").Value;
        GQ1.Text = xeTP.Attribute("GQ1").Value;
        GQ2.Text = xeTP.Attribute("GQ2").Value;
        GQ3.Text = xeTP.Attribute("GQ3").Value;
        ST1.Text = xeTP.Attribute("ST1").Value;
        ST2.Text = xeTP.Attribute("ST2").Value;
        ST3.Text = xeTP.Attribute("ST3").Value;
        GT1.Text = xeTP.Attribute("GT1").Value;
        GT2.Text = xeTP.Attribute("GT2").Value;
        GT3.Text = xeTP.Attribute("GT3").Value;
        HT1.Text = xeTP.Attribute("HT1").Value;
        HT2.Text = xeTP.Attribute("HT2").Value;
        HT3.Text = xeTP.Attribute("HT3").Value;
        CV1.Text = xeTP.Attribute("CV1").Value;
        CV2.Text = xeTP.Attribute("CV2").Value;
        CV3.Text = xeTP.Attribute("CV3").Value;
        TN1.Text = xeTP.Attribute("TN1").Value;
        TN2.Text = xeTP.Attribute("TN2").Value;
        TN3.Text = xeTP.Attribute("TN3").Value;
        CP1.Text = xeTP.Attribute("CP1").Value;
        CP2.Text = xeTP.Attribute("CP2").Value;
        CP3.Text = xeTP.Attribute("CP3").Value;
        TC1.Text = xeTP.Attribute("TC1").Value;
        TC2.Text = xeTP.Attribute("TC2").Value;
        TC3.Text = xeTP.Attribute("TC3").Value;
        if (hfTASK_RESULT.Value.ToString() == "Adopt")
        {
            ExpandoObject param = new { CNO = hfCNO.Value }.ToExpando();
            Dialog.Open2(Print, "~/CDS/LYV/Plugin/CapacityAssessmentCB/LYN_CapacityAssessmentCB_Reports.aspx", "", 950, 600, Dialog.PostBackType.None, param);
            pPrint.Visible = true;
        }
        else
        {
            pPrint.Visible = false;
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
                if (base.taskObj != null )
                {
                    hfCNO.Value = base.taskObj.FormNumber; 
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

            //    lblHasNoAuthority.ToolTip = lblAuthorityMsg.Text.Replace(".",",") + "：" + strItemName;
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