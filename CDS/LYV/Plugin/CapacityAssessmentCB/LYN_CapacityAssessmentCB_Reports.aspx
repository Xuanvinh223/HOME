<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DialogMasterPage.master" CodeFile="LYN_CapacityAssessmentCB_Reports.aspx.cs" Inherits="WKF_CapacityAssessmentCB_Reports" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>   
            <asp:HiddenField ID="hfCNO" runat="server" />
            <table id="tblDetail" runat="server" cellspacing="1" style="width: 100%">
                <tr>
                    <td>
                        <CR:CrystalReportViewer ID="crvQA" runat="server" AutoDataBind="true" ShowAllPageIds="false" DisplayToolbar="True" ></CR:CrystalReportViewer>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
