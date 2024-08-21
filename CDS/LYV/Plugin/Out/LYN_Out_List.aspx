<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DefaultMasterPage.master" CodeFile="LYN_Out_List.aspx.cs" Inherits="WKF_Out_List" %>

<%@ Import Namespace="Ede.Uof.Utility.Page.Common" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <link href="<%=Request.ApplicationPath %>/CDS/LYN/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
            <script src="<%=Request.ApplicationPath %>/CDS/LYN/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>
            <style type="text/css">
                .FormQuery td, .FormQuery th {
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

                .btnFunc {
                    border: 1px solid #0E2D5F; /* Màu khung khi enabled */
                    background-color: paleturquoise;
                    margin-block: 8px;
                    margin-left: 30px;
                    border-radius: 10px; /* Bo tròn góc khi enabled */
                    padding: 5px;
                    width: max-content;
                }

                    .btnFunc:hover {
                        background-color: aqua;
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
                    background-color: aliceblue;
                    display: flex;
                }
            </style>
            <asp:Label ID="Title" runat="server" CssClass="ttl" Text="外出統計表 Bảng thống kê ra vào cổng" Width="100%" BackColor="#1585cf" ForeColor="White" Font-Bold="True" Font-Size="X-Large" Height="50px" />
            <br />
            <table style="width: 100%" class="FormQuery">
                <tr>
                    <td>
                        <b>億春統計報表 | 其他 </b>
                        <br />
                        <asp:DropDownList ID="qD_STEP_DESC" runat="server" OnSelectedIndexChanged="D_STEP_DESC_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Text="外出統計表 Bảng thống kê ra vào cổng" Value="ALL"></asp:ListItem>
                            <asp:ListItem Text="外出單註銷 Bảng hủy ra vào cổng" Value="Cancel"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Panel ID="pLNO" runat="server">
                            <b>申請單號</b><br />
                            <asp:TextBox ID="qLNO" runat="server"></asp:TextBox>
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:Panel ID="pOutID" runat="server">
                            <b>工號</b><br />
                            <asp:TextBox ID="qOutID" runat="server" Width="40%"></asp:TextBox>
                        </asp:Panel>
                    </td>
                    <td>
                        <b>出廠日期</b><br />
                        <asp:TextBox ID="qLeaveTime" TextMode="Date" runat="server" Width="40%"></asp:TextBox>
                        <b>~ </b>
                        <asp:TextBox ID="qReturnTime" TextMode="Date" runat="server" Width="40%"></asp:TextBox>
                    </td>
                    <td>
                        <b>開單日期</b><br />
                        <asp:TextBox ID="qUserDate1" TextMode="Date" runat="server" Width="40%"></asp:TextBox>
                        <b>~ </b>
                        <asp:TextBox ID="qUserDate2" TextMode="Date" runat="server" Width="40%"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Panel ID="pOutCheck" runat="server">
                            <b>外出掃描</b><br />
                            <asp:CheckBox ID="qOutCheck" runat="server"></asp:CheckBox>
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:Panel ID="pType" runat="server">
                            <b>外出類別</b><br />
                            <asp:DropDownList ID="qType" runat="server">
                                <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                <asp:ListItem Text="A.人員外出-單位主管以下(Cap duoi chu quan don vi)" Value="A.人員外出-單位主管以下(Cap duoi chu quan don vi)"></asp:ListItem>
                                <asp:ListItem Text="B.人員外出-單位主管以上(Cap tren chủ quan don vi)" Value="B.人員外出-單位主管以上(Cap tren chủ quan don vi)"></asp:ListItem>
                                <asp:ListItem Text="C.物品外出-其他類(Vat pham Khac)" Value="C.物品外出-其他類(Vat pham Khac)"></asp:ListItem>
                                <asp:ListItem Text="D.物品外出-資產類(Vat pham tai san)" Value="D.物品外出-資產類(Vat pham tai san)"></asp:ListItem>
                            </asp:DropDownList>
                        </asp:Panel>
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
            <asp:Panel ID="panel1" runat="server" CssClass="panel1">
                <asp:HiddenField ID="hfLNO" runat="server" />
                <asp:Panel ID="pOnNO" runat="server" DefaultButton="OnNO" CssClass="btnFunc" Visible="false">
                    <asp:ImageButton ID="OnNO" runat="server" ImageUrl="../General/Images/no.png" OnClick="OnNO_Click" />
                    <asp:Label ID="lbOnNO" runat="server" Text="註銷" AssociatedControlID="OnNO" />
                </asp:Panel>
            </asp:Panel>
            <Ede:Grid ID="gvOut" runat="server" CssClass="gdOut" AllowPaging="True" DataKeyNames="LNO" AutoGenerateColumns="False" CustomDropDownListPage="False" DefaultSortDirection="Ascending" EmptyDataText="No data found" EnhancePager="True" KeepSelectedRows="True" SelectedRowColor="229, 245, 159" UnSelectedRowColor="238, 238, 238" ShowHeaderWhenEmpty="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnBeforeExport="gvOut_BeforeExport" OnRowDataBound="gvOut_RowDataBound" OnPageIndexChanging="gvOut_PageIndexChanging" AllowSorting="True" Width="100%" AutoGenerateCheckBoxColumn="False" OnSelectedIndexChanged="gvOut_SelectedIndexChanged">
                <EnhancePagerSettings ShowHeaderPager="false"></EnhancePagerSettings>

                <ExportExcelSettings AllowExportToExcel="true" ExportType="DataSource" />
                <Columns>
                    <asp:TemplateField HeaderText="狀態" Visible="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="Status" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="註銷原因" Visible="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="CancelReason" runat="server" Text='<%# Bind("CancelReason") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbCancelReason" runat="server" Text='<%# Bind("CancelReason") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="單號">
                        <EditItemTemplate>
                            <asp:TextBox ID="LNO" runat="server" Text='<%# Bind("LNO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnLNO" runat="server" Text='<%# Bind("LNO") %>'></asp:LinkButton>
                            <asp:HiddenField ID="hTASK_ID" runat="server" Value='<%# Bind("TASK_ID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="申請單位">
                        <EditItemTemplate>
                            <asp:TextBox ID="Department" runat="server" Text='<%# Bind("Department") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbDepartment" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="外出人數">
                        <EditItemTemplate>
                            <asp:TextBox ID="People" runat="server" Text='<%# Bind("People") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbPeople" runat="server" Text='<%# Bind("People") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="出廠時間">
                        <EditItemTemplate>
                            <asp:TextBox ID="LeaveTime" runat="server" Text='<%# Bind("LeaveTime") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbLeaveTime" runat="server" Text='<%# Bind("LeaveTime") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="進廠時間">
                        <EditItemTemplate>
                            <asp:TextBox ID="ReturnTime" runat="server" Text='<%# Bind("ReturnTime") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbReturnTime" runat="server" Text='<%# Bind("ReturnTime") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="外出類別">
                        <EditItemTemplate>
                            <asp:TextBox ID="Type" runat="server" Text='<%# Bind("Type") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbType" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="物品種類">
                        <EditItemTemplate>
                            <asp:TextBox ID="Category" runat="server" Text='<%# Bind("Category") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbCategory" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="物品名稱及數量">
                        <EditItemTemplate>
                            <asp:TextBox ID="Item" runat="server" Text='<%# Bind("Item") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbItem" runat="server" Text='<%# Bind("Item") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="外出原因">
                        <EditItemTemplate>
                            <asp:TextBox ID="Reason" runat="server" Text='<%# Bind("Reason") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbReason" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="申請人">
                        <EditItemTemplate>
                            <asp:TextBox ID="UserID" runat="server" Text='<%# Bind("UserID") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbUserID" runat="server" Text='<%# Bind("UserID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="申請日期">
                        <EditItemTemplate>
                            <asp:TextBox ID="UserDate" runat="server" Text='<%# Bind("UserDate") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbUserDate" runat="server" Text='<%# Bind("UserDate") %>'></asp:Label>
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
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
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
            <script type="text/javascript">
                function pageLoad() {
                    flatpickr('#<%= qLeaveTime.ClientID %>', {
                        dateFormat: "Y-m-d"
                    });

                    flatpickr('#<%= qReturnTime.ClientID %>', {
                        dateFormat: "Y-m-d"
                    });
                    flatpickr('#<%= qUserDate1.ClientID %>', {
                        dateFormat: "Y-m-d"
                    });

                    flatpickr('#<%= qUserDate2.ClientID %>', {
                        dateFormat: "Y-m-d"
                    });
                }
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
