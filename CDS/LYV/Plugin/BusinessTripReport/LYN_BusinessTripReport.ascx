<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LYN_BusinessTripReport.ascx.cs" Inherits="WKF_BusinessTripReport" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
        <script src="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>
        <style type="text/css">
            .FormGrid td, .FormGrid th {
                border: 1px solid #ddd;
                padding: 8px;
            }

            .FormQuery td, .FormGrid th {
                padding: 5px;
                text-align: center;
                vertical-align: middle;
                background-color: #e8fdff;
            }

            .btn {
                border: 1px solid #4CAF50; /* Màu khung khi enabled */
                padding: 8px; /* Khoảng cách giữa nội dung và khung */
                border-radius: 10px; /* Bo tròn góc khi enabled */
                width: max-content;
            }

                .btn:hover {
                    background-color: #d8ff78;
                }

            .tbNew th {
                position: sticky;
                top: 10%;
                background-color: #507CD1;
                color: white;
                z-index: 2;
            }

            .tbNew td {
                border: 1px solid #ddd;
                padding: 8px;
            }

            .Grid {
                font-size: 13px;
            }

            .GridHeader td, .GridHeader th {
                padding: 2px;
                text-align: center;
                vertical-align: middle;
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
        </style>
        <asp:Panel ID="panel1" runat="server" CssClass="panel1">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="Print" CssClass="btnFunc" Visible="false">
                <asp:ImageButton ID="Print" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_Click" />
                <asp:Label ID="lbPrint" runat="server" Text="Print" AssociatedControlID="Print" />
            </asp:Panel>
                <asp:Panel ID="pApprove" runat="server" DefaultButton="Approve" CssClass="btnFunc" Visible="false">
                    <asp:ImageButton ID="Approve" runat="server" ImageUrl="../General/Images/Approve.png" OnClick="Approve_Click" />
                    <asp:Label ID="lbApprove" runat="server" Text="Confirm" AssociatedControlID="Approve" />
                </asp:Panel>
            <asp:Panel ID="pDisable" runat="server" DefaultButton="Disable" CssClass="btnFunc" Visible="false">
                <asp:ImageButton ID="Disable" runat="server" ImageUrl="../General/Images/cancel.png" OnClick="Disable_Click" />
                <asp:Label ID="lbDisable" runat="server" Text="註銷 Cancel" AssociatedControlID="Disable" />
            </asp:Panel>
            <asp:Label ID="lTitle" runat="server" Text="" Visible="false" style="text-align: right; font-weight: bold;font-size: x-large;" Width="90%"></asp:Label>
            <asp:HiddenField ID="hfLNO" runat="server" />
            <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        </asp:Panel>
        <asp:Panel ID="pnQuery" runat="server">
            <table style="width: 100%" class="FormQuery">
                <tr>
                    <td>
                        <b>Số phiếu單號</b><br />
                        <asp:TextBox ID="qLNO" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <b>Họ tên姓名</b><br />
                        <asp:TextBox ID="qName" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <b>Số thẻ工號</b><br />
                        <asp:TextBox ID="qName_ID" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <b>Đi từ開始時間</b><br />
                        <asp:TextBox ID="qBTime1" TextMode="Date" runat="server"></asp:TextBox>
                        <b>~ </b>
                        <asp:TextBox ID="qBTime2" TextMode="Date" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <b>Chuyên gia | 專家</b><br />
                        <asp:CheckBox ID="qexpert" runat="server"></asp:CheckBox>
                    </td>
                    <td>
                        <asp:Panel ID="pQuery" runat="server" DefaultButton="Query" CssClass="btn">
                            <asp:ImageButton ID="Query" runat="server" ImageUrl="../General/Images/select.png" OnClick="Query_Click" />
                            <asp:Label ID="lbQuery" runat="server" Text="Query" AssociatedControlID="Query" />
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:Panel ID="pClear" runat="server" DefaultButton="Clear" CssClass="btn">
                            <asp:ImageButton ID="Clear" runat="server" ImageUrl="../General/Images/undo.png" OnClick="Clear_Click" />
                            <asp:Label ID="lbClear" runat="server" Text="Clear" AssociatedControlID="Clear" />
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <table style="width: 100%">
            <tr>
                <td>
                    <Ede:Grid ID="gvBT" runat="server" CssClass="FormGrid" PageSize="20" AllowPaging="True" DataKeyNames="LNO" AutoGenerateColumns="False" AutoGenerateCheckBoxColumn="True" CustomDropDownListPage="False" DataKeyOnClientWithCheckBox="True" DefaultSortDirection="Ascending" EmptyDataText="No data found" EnhancePager="True" KeepSelectedRows="False" SelectedRowColor="229, 245, 159" UnSelectedRowColor="238, 238, 238" ShowHeaderWhenEmpty="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="gvBT_RowDataBound" OnPageIndexChanging="gvBT_PageIndexChanging" OnSelectedIndexChanging="gvBT_SelectedIndexChanging" AllowSorting="True" Width="100%">
                        <EnhancePagerSettings ShowHeaderPager="false"></EnhancePagerSettings>

                        <ExportExcelSettings AllowExportToExcel="False"></ExportExcelSettings>
                        <Columns>
                            <asp:TemplateField HeaderText="Số phiếu單號">
                                <EditItemTemplate>
                                    <asp:TextBox ID="LNO" runat="server" Text='<%# Bind("LNO") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnLNO" runat="server" Text='<%# Bind("LNO") %>'></asp:LinkButton>
                                    <asp:HiddenField ID="hTASK_ID" runat="server" Value='<%# Bind("TASK_ID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Số NO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="MaPhieu" runat="server" Text='<%# Bind("MaPhieu") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbMaPhieu" runat="server" Text='<%# Bind("MaPhieu") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Họ tên姓名">
                                <EditItemTemplate>
                                    <asp:TextBox ID="Name" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Số thẻ工號">
                                <EditItemTemplate>
                                    <asp:TextBox ID="Name_ID" runat="server" Text='<%# Bind("Name_ID") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbName_ID" runat="server" Text='<%# Bind("Name_ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Lý do đi ｜出差事由">
                                <EditItemTemplate>
                                    <asp:TextBox ID="Purpose" runat="server" Text='<%# Bind("Purpose") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbPurpose" runat="server" Text='<%# Bind("Purpose") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Địa điểm công tác出差地點">
                                <EditItemTemplate>
                                    <asp:TextBox ID="FLocation" runat="server" Text='<%# Bind("FLocation") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbFLocation" runat="server" Text='<%# Bind("FLocation") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Đi từ開始時間">
                                <EditItemTemplate>
                                    <asp:TextBox ID="BTime" runat="server" Text='<%# Bind("BTime") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbBTime" runat="server" Text='<%# Bind("BTime") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Đến結束時間">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ETime" runat="server" Text='<%# Bind("ETime") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbETime" runat="server" Text='<%# Bind("ETime") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="USERID申請工號">
                                <EditItemTemplate>
                                    <asp:TextBox ID="USERID" runat="server" Text='<%# Bind("USERID") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbUSERID" runat="server" Text='<%# Bind("USERID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="USERDATE申請日期">
                                <EditItemTemplate>
                                    <asp:TextBox ID="USERDATE" runat="server" Text='<%# Bind("USERDATE") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbUSERDATE" runat="server" Text='<%# Bind("USERDATE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div style="margin: 30px 0; text-align: center;">
                                <asp:Label ID="lbEmptyMsg" runat="server" Text="🗅 No matched data!"></asp:Label>
                            </div>
                        </EmptyDataTemplate>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    </Ede:Grid>
                    <div class="GridPager" style="color: #2461BF; padding-right: 10px">
                        <asp:Label ID="lblPageInfo" runat="server" Text="PageSize: " />
                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                            <asp:ListItem Text="10" Value="10" />
                            <asp:ListItem Text="20" Value="20" />
                            <asp:ListItem Text="30" Value="30" />
                            <asp:ListItem Text="40" Value="40" />
                            <asp:ListItem Text="50" Value="50" />
                        </asp:DropDownList>
                    </div>
                </td>
            </tr>
        </table>
        <script type="text/javascript">
            function pageLoad() {
                flatpickr('#<%= qBTime1.ClientID %>', {
                    dateFormat: "Y-m-d"
                });

                flatpickr('#<%= qBTime2.ClientID %>', {
                    dateFormat: "Y-m-d"
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
