<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DialogMasterPage.master" CodeFile="LYN_BusinessTripReport_Modal.aspx.cs" Inherits="WKF_BusinessTripReport_Modal" %>

<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Fast" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .FormNum span {
            margin: 8px;
        }
    </style>
    <p>
        <b>單號 Số: </b>
        <asp:Label ID="lbLNO" runat="server" CssClass="FormNum"></asp:Label>
        <br />註銷原因: 
        <asp:TextBox ID="CancelReason" runat="server" TextMode="MultiLine" Width="97%" Height="80" MaxLength="500"></asp:TextBox>
    </p>

</asp:Content>
