<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DefaultMasterPage.master" CodeFile="LYN_BusinessTripOD_List.aspx.cs" Inherits="WKF_BusinessTripOD_List" %>

<%@ Import Namespace="Ede.Uof.Utility.Page.Common" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
            <link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
            <script src="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>
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
            <asp:Label ID="Title" runat="server" CssClass="ttl" Text="出差申請單查詢｜Báo cáo đề nghị đi công tác" Width="100%" BackColor="#1585cf" ForeColor="White" Font-Bold="True" Font-Size="X-Large" Height="50px" />
            <br />
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
            <asp:HiddenField ID="hfSiteName" runat="server" />
            <Ede:Grid ID="gvBT" runat="server" CssClass="gvBT" PageSize="10" AllowPaging="True" DataKeyNames="LNO" AutoGenerateColumns="False" CustomDropDownListPage="False" DefaultSortDirection="Ascending" EmptyDataText="No data found" EnhancePager="True" KeepSelectedRows="false" SelectedRowColor="229, 245, 159" UnSelectedRowColor="238, 238, 238" ShowHeaderWhenEmpty="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnBeforeExport="gvBT_BeforeExport" OnRowDataBound="gvBT_RowDataBound" OnPageIndexChanging="gvBT_PageIndexChanging" AllowSorting="True" Width="100%" AutoGenerateCheckBoxColumn="False">
                <enhancepagersettings showheaderpager="false"></enhancepagersettings>

                <exportexcelsettings allowexporttoexcel="true" exporttype="DataSource" />
                <columns>
                    <asp:TemplateField HeaderText="Số phiếu單號">
                        <edititemtemplate>
                            <asp:TextBox ID="LNO" runat="server" Text='<%# Bind("LNO") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:LinkButton ID="btnLNO" runat="server" Text='<%# Bind("LNO") %>'></asp:LinkButton>
                            <asp:HiddenField ID="hTASK_ID" runat="server" Value='<%# Bind("TASK_ID") %>' />
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Số NO">
                        <edititemtemplate>
                            <asp:TextBox ID="MaPhieu" runat="server" Text='<%# Bind("MaPhieu") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbMaPhieu" runat="server" Text='<%# Bind("MaPhieu") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Họ tên姓名">
                        <edititemtemplate>
                            <asp:TextBox ID="Name" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Số thẻ工號">
                        <edititemtemplate>
                            <asp:TextBox ID="Name_ID" runat="server" Text='<%# Bind("Name_ID") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbName_ID" runat="server" Text='<%# Bind("Name_ID") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Lý do đi ｜出差事由">
                        <edititemtemplate>
                            <asp:TextBox ID="Purpose" runat="server" Text='<%# Bind("Purpose") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbPurpose" runat="server" Text='<%# Bind("Purpose") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Địa điểm công tác出差地點">
                        <edititemtemplate>
                            <asp:TextBox ID="FLocation" runat="server" Text='<%# Bind("FLocation") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbFLocation" runat="server" Text='<%# Bind("FLocation") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thời gian đi時間">
                        <edititemtemplate>
                            <asp:TextBox ID="Time" runat="server" Text='<%# Bind("Time") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbTime" runat="server" Text='<%# Bind("Time") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="USERID申請工號">
                        <edititemtemplate>
                            <asp:TextBox ID="USERID" runat="server" Text='<%# Bind("USERID") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbUSERID" runat="server" Text='<%# Bind("USERID") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="USERDATE申請日期">
                        <edititemtemplate>
                            <asp:TextBox ID="USERDATE" runat="server" Text='<%# Bind("USERDATE") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbUSERDATE" runat="server" Text='<%# Bind("USERDATE") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="flowflag">
                        <edititemtemplate>
                            <asp:TextBox ID="flowflag" runat="server" Text='<%# Bind("flowflag") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbflowflag" runat="server" Text='<%# Bind("flowflag") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                </columns>
                <emptydatatemplate>
                    <div style="margin: 30px 0; text-align: center;">
                        <asp:Label ID="lbEmptyMsg" runat="server" Text="🗅 No matched data!"></asp:Label>
                    </div>
                </emptydatatemplate>
                <footerstyle backcolor="#507CD1" font-bold="True" forecolor="White" />
                <headerstyle backcolor="#507CD1" font-bold="True" forecolor="White" />
                <pagerstyle backcolor="#2461BF" forecolor="White" horizontalalign="Center" />
            </Ede:Grid>
            <div class="GridPager" style="color:#2461BF; padding-right:10px">
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
                    flatpickr('#<%= qBTime1.ClientID %>', {
                        dateFormat: "Y-m-d"
                    });

                    flatpickr('#<%= qBTime2.ClientID %>', {
                        dateFormat: "Y-m-d"
                    });
                }
            </script>
        </contenttemplate>
    </asp:UpdatePanel>
</asp:Content>
