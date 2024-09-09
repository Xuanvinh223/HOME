<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DialogMasterPage.master" CodeFile="Acceptance_Reports.aspx.cs" Inherits="LYV_Acceptance_Reports" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hfLYV" runat="server" />
    <table id="tblDetail" runat="server" cellspacing="1" style="width: 100%">
        <tr>
            <td>
                <CR:CrystalReportViewer ID="crvLeave" runat="server" AutoDataBind="true" ShowAllPageIds="false" DisplayToolbar="False"></CR:CrystalReportViewer>
            </td>
        </tr>
    </table>
</asp:Content>
