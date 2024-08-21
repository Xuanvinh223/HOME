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
using System.Xml;

public partial class WKF_Leave_Modal : Ede.Uof.Utility.Page.BasePage
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
            string LNO = Request["LNO"];
            ViewState["LNO"] = LNO;
            string Account = Request["Account"];
            ViewState["Account"] = Account;

            string[] dsLNO = LNO.Split(",");
            for (int i = 0; i < dsLNO.Length; i++)
            {
                Label label = new Label();
                label.Text = "<span>" + dsLNO[i] + "</span><br />";
                ChoosedFormNum.Controls.Add(label);
            }
                
            string SiteName = Request["SiteName"];
            ViewState["SiteName"] = SiteName;
        }
        ((Master_DialogMasterPage)this.Master).FindControl("MasterPageRadButton2").Visible = false;
        ((Master_DialogMasterPage)this.Master).Button1OnClick += CDS_WebPage_Dialog_Button1OnClick;
    }
    void CDS_WebPage_Dialog_Button1OnClick()
    {
        string[] LNO = ViewState["LNO"].ToString().Split(",");
        string Account = ViewState["Account"].ToString();
        string result = "0";
        string TaskGUID = "";
        string SITE_ID = "";
        string NODE_SEQ = "";
        string ORIGINAL_SIGNER = "";
        UserUCO userUco = new UserUCO();
        EBUser ebuser = userUco.GetEBUser(Current.UserGUID);
        string userGUID = Current.UserGUID;
        //GetToken 
        string tk = getWSToken("Training.WS", "Training.Ws123");

        //return "TaskGUID=" + TaskGUID + "; SITE_ID=" + SITE_ID + "; ORIGINAL_SIGNER=" + ORIGINAL_SIGNER;
        Wkf.Wkf wkf = new Wkf.Wkf();

        if (Account == "LYN20067" || Account == "LYN21048")
        {
            for (int i = 0; i < LNO.Length; i++)
            {
                Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();
                DataTable dt = uco.GetWSSignNextInfo(LNO[i], ViewState["SiteName"].ToString(), Current.UserGUID);

                if (dt.Rows.Count > 0)
                {
                    TaskGUID = dt.Rows[0]["TASK_ID"].ToString();
                    SITE_ID = dt.Rows[0]["SITE_ID"].ToString();
                    NODE_SEQ = dt.Rows[0]["NODE_SEQ"].ToString();
                    ORIGINAL_SIGNER = dt.Rows[0]["ORIGINAL_SIGNER"].ToString();
                }
                result = wkf.SignNext(tk, TaskGUID, SITE_ID, Convert.ToInt32(NODE_SEQ), ORIGINAL_SIGNER);
            }
        }
        else
        {
            for (int i = 0; i < LNO.Length; i++)
            {
                Training.Leave.UCO.LeaveUCO uco = new Training.Leave.UCO.LeaveUCO();
                string Lock = uco.Check_KhoaSo_All(LNO[i]);
                DataTable dt = uco.GetWSSignNextInfo(LNO[i], ViewState["SiteName"].ToString(), Current.UserGUID);

                if (dt.Rows.Count > 0)
                {
                    TaskGUID = dt.Rows[0]["TASK_ID"].ToString();
                    SITE_ID = dt.Rows[0]["SITE_ID"].ToString();
                    NODE_SEQ = dt.Rows[0]["NODE_SEQ"].ToString();
                    ORIGINAL_SIGNER = dt.Rows[0]["ORIGINAL_SIGNER"].ToString();
                }
                if (Lock == "true")
                {
                    string signAction = "Reject";
                    result = wkf.TerminateTask(tk, TaskGUID, ebuser.Account, signAction, "Employee has been locked out of timekeeping");
                }
                else
                {
                    result = wkf.SignNext(tk, TaskGUID, SITE_ID, Convert.ToInt32(NODE_SEQ), ORIGINAL_SIGNER);
                }
            }
        }
        Dialog.SetReturnValue2("OK");
        Dialog.Close(this);
    }
    public static string RSAEncrypt(string publicKey, string crText)
    {
        RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
        byte[] base64PublicKey = Convert.FromBase64String(publicKey);
        rsa.FromXmlString(System.Text.Encoding.UTF8.GetString(base64PublicKey));
        byte[] ctTextArray = Encoding.UTF8.GetBytes(crText);
        byte[] decodeBs = rsa.Encrypt(ctTextArray, false);
        return Convert.ToBase64String(decodeBs);
    }
    public string getWSToken(string account, string password)
    {
        string appName = "LYN_HR";
        /*string publicKey = @"PFJTQUtleVZhbHVlPjxNb2R1bHVzPjB6KzYvQWlaM1VNRU4vWTNhd0luSXBVSjVOU0hlYVNyYS9HeE5pczRabnVQanhMZEVoM2Z5RkdUU2s4UmhtcmIzRkFHWFRwRkJWd0lQM2EyNExHWlNVZ0VOTGtQT3djT3REeDJTWjRxVSsrTUVxdkRQVUhnY1ZvM3BhR1RlNyszMEY3VHBaMmg5c1dEd0dNNzZQVWpZL3pkeHA4ckcyRTVtbHBwTUIzb29waz08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+";*/
        //Server_Main
        string publicKey = @"PFJTQUtleVZhbHVlPjxNb2R1bHVzPnplakRLa3JXVkNBeGxVYmFnZWxyTWFyT3pxSjcvQ2ZLbFk1ZUFCb0dKQms4MjlMSnFqM084emZuOVQ1M3FsUUZkZ00zaU5Xei9sYzQ4RE9ib25DUkNTS1NiT2xjZlNsK2dYVXltUlN6WGNETGhWUlRWM3ZYbFBDdlZqTy9zT0N3TER6QWNCbzlXdHZQZ09OSTJrSk82NDRLc0k5SjFNUWxBRkNXa1JNVC9ORT08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+";
        Auth.Authentication auth = new Auth.Authentication();
        auth.GetToken(appName, account, password);
        string Token = auth.GetToken(appName, RSAEncrypt(publicKey, account), RSAEncrypt(publicKey, password));
        //Console.WriteLine("Token:" + Token);
        return Token;
    }
}