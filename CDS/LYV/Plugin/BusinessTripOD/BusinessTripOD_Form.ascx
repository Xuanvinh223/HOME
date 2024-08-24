﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BusinessTripOD_Form.ascx.cs" Inherits="WKF_BusinessTripOD_Form" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>

<link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
<script src="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>

<style type="text/css">
    .FormGrid td, .FormGrid th {
        border: 1px solid #ddd;
        padding: 8px;
    }

    .Form {
        border-collapse: collapse; /* Đặt border-collapse thành collapse */
    }

        .Form td {
            padding-top: 8px;
            padding-bottom: 8px; /* Thêm padding để làm đẹp */
        }

    .panel1 {
        width: 100%;
        display: flex;
    }

    .btnFunc {
        border: 1px solid #0E2D5F; /* Màu khung khi enabled */
        background-color: paleturquoise;
        margin-block: 8px;
        margin-right: 30px;
        border-radius: 10px; /* Bo tròn góc khi enabled */
        padding: 10px;
        width: max-content;
    }

        .btnFunc:hover {
            background-color: aqua;
        }

    .radio {
        width: 60%;
        text-align: left;
    }

        .radio th, .radio td {
            width: 20%;
            vertical-align: top;
        }
</style>

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
    <ContentTemplate>
        <asp:Panel ID="panel1" runat="server" CssClass="panel1">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="Print" CssClass="btnFunc" Visible="false">
                <asp:ImageButton ID="Print" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_Click" />
                <asp:Label ID="lbPrint" runat="server" Text="Print" AssociatedControlID="Print" />
            </asp:Panel>
            <asp:HiddenField ID="hfLYV" runat="server" />
            <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        </asp:Panel>
        <table class="Form" style="width: 100%">
            <tr>
                <td colspan="4" style="padding: 0px">
                    <asp:Panel ID="Dep" runat="server" Visible="false">
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:TextBox ID="DV_MA_Search" runat="server" placeholder="Search Department ID" AutoPostBack="true" OnTextChanged="DV_Search_TextChanged" />
                                </td>
                                <td>
                                    <asp:TextBox ID="DV_TEN_Search" runat="server" placeholder="Search Department Name" AutoPostBack="true" OnTextChanged="DV_Search_TextChanged" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:GridView ID="gvDep" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="gvDep_PageIndexChanging" CssClass="FormGrid" Width="100%"
                                        CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvDep_SelectedIndexChanged" AutoPostBack="true"
                                        OnRowDataBound="gvDep_RowDataBound">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundField DataField="DV_MA" HeaderText="Department ID" />
                                            <asp:BoundField DataField="DV_TEN" HeaderText="Department Name" />
                                        </Columns>
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <label style="color: red;">* </label>
                    <b>Họ tên</b></td>
                <td>
                    <asp:TextBox ID="Name" runat="server" MaxLength="50" Enabled="false" Width="90%" />
                </td>
                <td>
                    <label style="color: red;">* </label>
                    <b>Số thẻ</b></td>
                <td>
                    <asp:TextBox ID="Name_ID" runat="server" MaxLength="20" AutoPostBack="true" OnTextChanged="Name_ID_TextChanged" Width="60%" />
                </td>
                <td>
                    <label style="color: red;">* </label>
                    <b>Đơn vị</b></td>
                <td>
                    <asp:TextBox ID="Name_DepID" runat="server" MaxLength="50" Enabled="false" Width="60%" />
                    <asp:ImageButton ID="SearchDep" runat="server" ImageUrl="../General/Images/select.png" OnClick="SearchDep_Click" Width="3%" /><br />
                </td>
            </tr>
            <tr>
                <td>
                    <label style="color: red;">* </label>
                    <b>Họ tên người thay thế</b></td>
                <td>
                    <asp:TextBox ID="Agent" runat="server" MaxLength="50" Enabled="false" Width="90%" />
                </td>
                <td>
                    <label style="color: red;">* </label>
                    <b>Số thẻ người thay thế</b></td>
                <td>
                    <asp:TextBox ID="Agent_ID" runat="server" MaxLength="20" AutoPostBack="true" OnTextChanged="Agent_ID_TextChanged" Width="60%" />
                </td>
                <td><b>Tài liệu kèm theo</b></td>
                <td>
                    <asp:TextBox ID="documents" runat="server" MaxLength="20" AutoPostBack="true" Width="60%" />
                </td>
            </tr>
            <tr>
                <td>
                    <label style="color: red;">* </label>
                    <b>Lý do đi</b></td>
                <td colspan="3">
                    <asp:TextBox ID="Purpose" runat="server" Enabled="false" TextMode="MultiLine" Width="146.5%" Height="100" MaxLength="500"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label style="color: red;">* </label>
                    <b>Địa điểm công tác</b></td>
                <td colspan="3">
                    <asp:TextBox ID="FLocation" runat="server" Enabled="false" TextMode="MultiLine" Width="146.5%" Height="100" MaxLength="500"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td><b>Thời gian đi<br />
                    時間</b></td>
                <td>
                    <asp:TextBox ID="Time" TextMode="DateTime" runat="server" Width="60%" OnTextChanged="Time_TextChanged" AutoPostBack="true"></asp:TextBox>
                </td>
                <td colspan="2">
                    <b>Giờ đi 出發時間</b><asp:TextBox ID="STime" TextMode="Time" runat="server"></asp:TextBox>
                    <b>Giờ về 回程時間</b><asp:TextBox ID="ETime" TextMode="Time" runat="server"></asp:TextBox>
                </td>
                <td><b>Ngày đi<br />
                    天數</b></td>
                <td>
                    <asp:TextBox ID="Days" runat="server" Text="1" ReadOnly="true" Width="20%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label style="color: red;">* </label>
                    <b>Hành trình</b></td>
                <td colspan="3">
                    <asp:TextBox ID="Journey" runat="server" Enabled="false" TextMode="MultiLine" Width="146.5%" Height="100" MaxLength="500"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label style="color: red;">* </label>
                    <b>Đi bằng phương tiện</b></td>
                <td>
                    <asp:DropDownList Visible="false" ID="AnTransportType" runat="server" Width="60%" OnTextChanged="TransportTypeSelect" AutoPostBack="true">
                    </asp:DropDownList>
                    <asp:DropDownList ID="TransportType" runat="server" Width="90%" OnTextChanged="TransportTypeSelect" AutoPostBack="true">
                        <asp:ListItem Enabled="true" Text="---please select---" Value="Default"></asp:ListItem>
                        <asp:ListItem Text="Xe hơi" Value="Xe hơi"></asp:ListItem>
                        <asp:ListItem Text="Máy bay" Value="Máy bay"></asp:ListItem>
                        <asp:ListItem Text="Thuyền" Value="Thuyền"></asp:ListItem>
                        <asp:ListItem Text="Xe buýt" Value="Xe buýt"></asp:ListItem>
                        <asp:ListItem Text="Phương tiện khác" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="ptkhac" Visible="false" runat="server" MaxLength="20" AutoPostBack="true" Width="60%" />
                </td>
            </tr>
            <tr>
                <td><b>Xe công ty</b></td>
                <td>
                    <asp:CheckBox ID="ApplyCar" runat="server" Checked="false" />
                </td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <asp:Panel ID="pTN" runat="server" Visible="true">
                    <td><b>Ghi rõ nguyên nhân đi máy bay,<br />
                        thuyền (Đi xe lửa, xe hơi không
                        <br />
                        cần ghi chú)</b></td>
                    <td colspan="3">
                        <asp:TextBox ID="Remark" runat="server" Enabled="false" TextMode="MultiLine" Width="100%" Height="100" MaxLength="500"></asp:TextBox>
                    </td>
                </asp:Panel>
            </tr>
        </table>
        <script type="text/javascript">
            function pageLoad() {
                flatpickr('#<%= Time.ClientID %>', {
                    dateFormat: "Y-m-d"
                });
                flatpickr('#<%= STime.ClientID %>', {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                    time_24hr: true
                });

                flatpickr('#<%= ETime.ClientID %>', {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                    time_24hr: true
                });
            }
        </script>
        <asp:Label ID="lblHasNoAuthority" runat="server" Text="無填寫權限" ForeColor="Red" Visible="False" meta:resourcekey="lblHasNoAuthorityResource1"></asp:Label>
        <asp:Label ID="lblToolTipMsg" runat="server" Text="不允許修改(唯讀)" Visible="False" meta:resourcekey="lblToolTipMsgResource1"></asp:Label>
        <asp:Label ID="lblModifier" runat="server" Visible="False" meta:resourcekey="lblModifierResource1"></asp:Label>
        <asp:Label ID="lblMsgSigner" runat="server" Text="填寫者" Visible="False" meta:resourcekey="lblMsgSignerResource1"></asp:Label>
        <asp:Label ID="lblAuthorityMsg" runat="server" Text="具填寫權限人員" Visible="False" meta:resourcekey="lblAuthorityMsgResource1"></asp:Label>
    </ContentTemplate>
</asp:UpdatePanel>
