<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DefaultMasterPage.master" CodeFile="LYN_Leave_ListHR.aspx.cs" Inherits="WKF_Leave_ListHR" %>

<%@ Import Namespace="Ede.Uof.Utility.Page.Common" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
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
            <asp:Label ID="Title" runat="server" CssClass="ttl" Text="請假申請單查詢 Báo cáo đơn xin nghỉ phép" Width="100%" BackColor="#1585cf" ForeColor="White" Font-Bold="True" Font-Size="X-Large" Height="50px" />
            <br />
            <table style="width: 100%" class="FormQuery">
                <tr>
                    <td>
                        <b>Hiển thị 顯示資料</b>
                        <br />
                        <asp:DropDownList ID="qD_STEP_DESC" runat="server" OnSelectedIndexChanged="D_STEP_DESC_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Enabled="true" Text="所有申請單" Value="ALL"></asp:ListItem>
                            <asp:ListItem Text="人事審核" Value="人事"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <b>Đơn vị 單位</b><br />
                        <asp:TextBox ID="qDV_MA_" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <b>Số 單號</b><br />
                        <asp:TextBox ID="qLNO" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <b>Số thẻ nghỉ 請假人</b><br />
                        <asp:TextBox ID="qLeaverID" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <b>Thời gian nghỉ 請假日期</b><br />
                        <asp:TextBox ID="qStartDate" TextMode="Date" runat="server"></asp:TextBox>
                        <b>~ </b>
                        <asp:TextBox ID="qEndDate" TextMode="Date" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Panel ID="pDocuments" runat="server">
                            <b>Yêu cầu đính kèm 需提供證明</b><br />
                            <asp:CheckBox ID="qDocuments" runat="server"></asp:CheckBox>
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:Panel ID="pflowflag" runat="server">
                            <b>Trạng thái 已結案</b><br />
                            <asp:DropDownList ID="qflowflag" runat="server">
                                <asp:ListItem Text="Hoàn thành|已結案" Value="Z"></asp:ListItem>
                                <asp:ListItem Text="Vô hiệu hóa|禁用" Value="X"></asp:ListItem>
                                <asp:ListItem Text="Khác|其他" Value="NP"></asp:ListItem>
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
                <asp:HiddenField ID="hfSiteName" runat="server" />
                <asp:Panel ID="pApprove" runat="server" DefaultButton="Approve" CssClass="btnFunc" Visible="false">
                    <asp:ImageButton ID="Approve" runat="server" ImageUrl="../General/Images/Approve.png" OnClick="Approve_Click" />
                    <asp:Label ID="lbApprove" runat="server" Text="Approve" AssociatedControlID="Approve" />
                </asp:Panel>
                <asp:Panel ID="pOnOK" runat="server" DefaultButton="OnOK" CssClass="btnFunc" Visible="false">
                    <asp:ImageButton ID="OnOK" runat="server" ImageUrl="../General/Images/ok.png" OnClick="OnOK_Click" />
                    <asp:Label ID="lbOnOK" runat="server" Text="已提供證明文件" AssociatedControlID="OnOK" />
                </asp:Panel>
                <asp:Panel ID="pOnNO" runat="server" DefaultButton="OnNO" CssClass="btnFunc" Visible="false">
                    <asp:ImageButton ID="OnNO" runat="server" ImageUrl="../General/Images/no.png" OnClick="OnNO_Click" />
                    <asp:Label ID="lbOnNO" runat="server" Text="需提供證明文件" AssociatedControlID="OnNO" />
                </asp:Panel>
            </asp:Panel>
            <Ede:Grid ID="gvLeave" runat="server" CssClass="gdLeave" PageSize="10" AllowPaging="True" DataKeyNames="LNO" AutoGenerateColumns="False" AutoGenerateCheckBoxColumn="True" CustomDropDownListPage="False" DataKeyOnClientWithCheckBox="True" DefaultSortDirection="Ascending" EmptyDataText="No data found" EnhancePager="True" KeepSelectedRows="False" SelectedRowColor="229, 245, 159" UnSelectedRowColor="238, 238, 238" ShowHeaderWhenEmpty="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnBeforeExport="gvLeave_BeforeExport" OnRowDataBound="gvLeave_RowDataBound" OnPageIndexChanging="gvLeave_PageIndexChanging" OnSelectedIndexChanging="gvLeave_SelectedIndexChanging" OnSorting="gvLeave_Sorting" AllowSorting="True" Width="100%">
                <enhancepagersettings showheaderpager="false"></enhancepagersettings>
                <exportexcelsettings allowexporttoexcel="true" exporttype="DataSource" />
                <columns>
                    <asp:TemplateField HeaderText="Số&lt;br/&gt;單號" SortExpression="LNO">
                        <edititemtemplate>
                            <asp:TextBox ID="LNO" runat="server" Text='<%# Bind("LNO") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:LinkButton ID="btnLNO" runat="server" Text='<%# Bind("LNO") %>'></asp:LinkButton>
                            <asp:HiddenField ID="hTASK_ID" runat="server" Value='<%# Bind("TASK_ID") %>' />
                            <asp:HiddenField ID="hATTACH_ID" runat="server" Value='<%# Bind("ATTACH_ID") %>' />
                            <asp:HiddenField ID="hDocuments" runat="server" Value='<%# Bind("Documents") %>' />
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Người điền đơn&lt;br/&gt;填單人">
                        <edititemtemplate>
                            <asp:TextBox ID="USERID" runat="server" Text='<%# Bind("USERID") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbUSERID" runat="server" Text='<%# Bind("USERID") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tên người điền đơn&lt;br/&gt;申請人姓名">
                        <edititemtemplate>
                            <asp:TextBox ID="USERNAME" runat="server" Text='<%# Bind("USERNAME") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbUSERNAME" runat="server" Text='<%# Bind("USERNAME") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Đơn vị điều động&lt;br/&gt;調動單位">
                        <edititemtemplate>
                            <asp:TextBox ID="DV_MA_" runat="server" Text='<%# Bind("DV_MA_") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbDV_MA_" runat="server" Text='<%# Bind("DV_MA_") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Đơn vị tính lương&lt;br/&gt;計薪單位" SortExpression="DepartmentID">
                        <edititemtemplate>
                            <asp:TextBox ID="DepartmentID" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbDepartmentID" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Người xin nghỉ&lt;br/&gt;請假人工號" SortExpression="LeaverID">
                        <edititemtemplate>
                            <asp:TextBox ID="LeaverID" runat="server" Text='<%# Bind("LeaverID") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbLeaverID" runat="server" Text='<%# Bind("LeaverID") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Họ và tên&lt;br/&gt;請假人姓名">
                        <edititemtemplate>
                            <asp:TextBox ID="LeaverName" runat="server" Text='<%# Bind("LeaverName") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbLeaverName" runat="server" Text='<%# Bind("LeaverName") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Loại phép đề nghị&lt;br/&gt;申請假別" SortExpression="Type">
                        <edititemtemplate>
                            <asp:TextBox ID="Type" runat="server" Text='<%# Bind("Type") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbType" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ngày&lt;br/&gt;總請假天數">
                        <edititemtemplate>
                            <asp:TextBox ID="TotalDay" runat="server" Text='<%# Bind("TotalDay") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbTotalDay" runat="server" Text='<%# Bind("TotalDay") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ngày bắt đầu&lt;br/&gt;請假日期">
                        <edititemtemplate>
                            <asp:TextBox ID="StartDate" runat="server" Text='<%# Bind("StartDate") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbStartDate" runat="server" Text='<%# Bind("StartDate") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ngày kết thúc&lt;br/&gt;結束日期">
                        <edititemtemplate>
                            <asp:TextBox ID="EndDate" runat="server" Text='<%# Bind("EndDate") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbEndDate" runat="server" Text='<%# Bind("EndDate") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sổ tháng NNĐH&lt;br/&gt;毒害作業月數">
                        <edititemtemplate>
                            <asp:TextBox ID="DHMonth" runat="server" Text='<%# Bind("DHMonth") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbDHMonth" runat="server" Text='<%# Bind("DHMonth") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Đã nghỉ thực tế&lt;br/&gt;總年假天數">
                        <edititemtemplate>
                            <asp:TextBox ID="YDLeave" runat="server" Text='<%# Bind("YDLeave") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbYDLeave" runat="server" Text='<%# Bind("YDLeave") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sổ ngày còn lại&lt;br/&gt;年假結算">
                        <edititemtemplate>
                            <asp:TextBox ID="Total" runat="server" Text='<%# Bind("Total") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbTotal" runat="server" Text='<%# Bind("Total") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ghi rõ lý do&lt;br/&gt;事由">
                        <edititemtemplate>
                            <asp:TextBox ID="Reason" runat="server" Text='<%# Bind("Reason") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbReason" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ghi chú&lt;br/&gt;備註">
                        <edititemtemplate>
                            <asp:TextBox ID="Remark" runat="server" Text='<%# Bind("Remark") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbRemark" runat="server" Text='<%# Bind("Remark") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ngày gửi đơn&lt;br/&gt;申請時間">
                        <edititemtemplate>
                            <asp:TextBox ID="USERDATE" runat="server" Text='<%# Bind("USERDATE") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbUSERDATE" runat="server" Text='<%# Bind("USERDATE") %>'></asp:Label>
                        </itemtemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Người phê duyệt hiện tại&lt;br/&gt;目前審核人">
                        <edititemtemplate>
                            <asp:TextBox ID="D_STEP_DESC" runat="server" Text='<%# Bind("D_STEP_DESC") %>'></asp:TextBox>
                        </edititemtemplate>
                        <itemtemplate>
                            <asp:Label ID="lbD_STEP_DESC" runat="server" Text='<%# Bind("D_STEP_DESC") %>'></asp:Label>
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
             <%--   function pageLoad() {
                    flatpickr('#<%= qStartDate.ClientID %>', {
                        dateFormat: "Y-m-d"
                    });

                    flatpickr('#<%= qEndDate.ClientID %>', {
                        dateFormat: "Y-m-d"
                    });
                }--%>
            </script>
        </contenttemplate>
    </asp:UpdatePanel>
</asp:Content>
