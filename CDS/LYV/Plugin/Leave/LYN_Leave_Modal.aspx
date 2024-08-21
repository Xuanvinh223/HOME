<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DialogMasterPage.master" CodeFile="LYN_Leave_Modal.aspx.cs" Inherits="WKF_Leave_Modal" %>

<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Fast" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .FormNum span {
            margin: 8px;
        }
    </style>
    <p>
        <b>單號 Số:</b>
        <br />
        <asp:Panel ID="ChoosedFormNum" runat="server" CssClass="FormNum"></asp:Panel>
    </p>
</asp:Content>
