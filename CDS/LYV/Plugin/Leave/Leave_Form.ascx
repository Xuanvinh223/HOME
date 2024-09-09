<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leave_Form.ascx.cs" Inherits="CDS_LYV_Plugin_Leave_LYV_Leave_Form" %>
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

    .Info {
        border-collapse: collapse; /* Đặt border-collapse thành collapse */
        border-left: 1px solid gray;
    }

        .Info td {
            padding-top: 8px;
            padding-bottom: 8px; /* Thêm padding để làm đẹp */
            padding-left: 5px;
        }

    .HisGrid th {
        position: sticky;
        top: 10%;
        background-color: #507CD1;
        color: white;
        z-index: 2;
    }

    .HisGrid td {
        border: 1px solid #ddd;
        padding: 8px;
    }

    .employee_name_btable {
        position: sticky;
        top: 0;
        background-color: #4188d5;
        color: white;
        z-index: 2;
        text-align: left;
        padding: 5px 10px;
    }

    .ddYear {
        Width: 11rem;
    }

    .FormChild tr {
        display: flex;
        justify-content: space-around;
    }

    .info_end_tr input {
        width: 3rem
    }

    .enabledPanel {
        border: 1px solid #4CAF50; /* Màu khung khi enabled */
        background-color: #E8F5E9; /* Màu nền khi enabled */
        padding: 10px; /* Khoảng cách giữa nội dung và khung */
        border-radius: 10px; /* Bo tròn góc khi enabled */
    }

    .disabledPanel {
        border: 1px solid #BDBDBD; /* Màu khung khi disabled */
        background-color: #F5F5F5; /* Màu nền khi disabled */
        padding: 10px; /* Khoảng cách giữa nội dung và khung */
        border-radius: 10px; /* Bo tròn góc khi disabled */
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

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <asp:Panel ID="panel1" runat="server" CssClass="panel1">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="Print" CssClass="btnFunc" Visible="false">
                <asp:ImageButton ID="Print" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_Click" />
                <asp:Label ID="lbPrint" runat="server" Text="Print" AssociatedControlID="Print" />
            </asp:Panel>
            <asp:Panel ID="pDisable" runat="server" DefaultButton="Disable" CssClass="btnFunc" Visible="false">
                <asp:ImageButton ID="Disable" runat="server" ImageUrl="../General/Images/cancel.png" OnClick="Disable_Click" />
                <asp:Label ID="lbDisable" runat="server" Text="Disable" AssociatedControlID="Disable" />
            </asp:Panel>
            <asp:Label ID="lDisable" runat="server" Text="Disable" Visible="false" Style="color: red; text-align: right; font-weight: bold; font-size: x-large;" Width="90%"></asp:Label>
            <asp:HiddenField ID="hfLYV" runat="server" />
            <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        </asp:Panel>
        <div style="margin-bottom: 30px; display: flex; justify-content: space-around; width: 100%">
            <table class="Form">
                <tr>
                    <td><b>Đơn vị<br />
                        單位</b></td>
                    <td>
                        <asp:TextBox ID="DepartmentID" runat="server" MaxLength="50" Enabled="false" />
                        <asp:ImageButton ID="SearchDep" runat="server" ImageUrl="../General/Images/select.png" OnClick="SearchDep_Click" Width="6%" /><br />
                    </td>
                    <td colspan="2"></td>
                </tr>
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
                    <td><b>Số thẻ người xin nghỉ<br />
                        請假人工號</b></td>
                    <td>
                        <asp:TextBox ID="LeaverID" runat="server" MaxLength="20" AutoPostBack="true" OnTextChanged="LeaverID_TextChanged" />
                        <asp:ImageButton ID="SearchLeaver" runat="server" ImageUrl="../General/Images/select.png" OnClick="SearchLeaver_Click" Width="6%" />
                    </td>
                    <td><b>Họ và tên<br />
                        姓名</b></td>
                    <td>
                        <asp:TextBox ID="LeaverName" runat="server" MaxLength="50" Enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="padding: 0px">
                        <asp:Panel ID="Leaver" runat="server" Visible="false">
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="NV_Ma_Search" runat="server" placeholder="Search ID" AutoPostBack="true" OnTextChanged="NV_Search_TextChanged" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NV_Ten_Search" runat="server" placeholder="Search Name" AutoPostBack="true" OnTextChanged="NV_Search_TextChanged" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:GridView ID="gvLeaver" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="gvLeaver_PageIndexChanging" CssClass="FormGrid" Width="100%"
                                            CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvLeaver_SelectedIndexChanged" AutoPostBack="true" EnableViewState="true"
                                            OnRowDataBound="gvLeaver_RowDataBound">
                                            <AlternatingRowStyle BackColor="White" />
                                            <Columns>
                                                <asp:BoundField DataField="NV_Ma" HeaderText="ID" />
                                                <asp:BoundField DataField="NV_Ten" HeaderText="Name" />
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
                    <td><b>Số thẻ người thay thế<br />
                        代理人工號</b></td>
                    <td>
                        <asp:TextBox ID="DeputyID" runat="server" MaxLength="20" AutoPostBack="true" OnTextChanged="DeputyID_TextChanged" />
                        <asp:ImageButton ID="SearchDeputy" runat="server" ImageUrl="../General/Images/select.png" OnClick="SearchDeputy_Click" Width="6%" />
                    </td>
                    <td><b>Họ và tên<br />
                        姓名</b></td>
                    <td>
                        <asp:TextBox ID="DeputyName" runat="server" MaxLength="50" Enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="padding: 0px">
                        <asp:Panel ID="Deputy" runat="server" Visible="false">
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="NV_Ma_Search1" runat="server" placeholder="Search ID" AutoPostBack="true" OnTextChanged="NV_Search1_TextChanged" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NV_Ten_Search1" runat="server" placeholder="Search Name" AutoPostBack="true" OnTextChanged="NV_Search1_TextChanged" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:GridView ID="gvDeputy" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="gvDeputy_PageIndexChanging" CssClass="FormGrid" Width="100%"
                                            CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvDeputy_SelectedIndexChanged" AutoPostBack="true" EnableViewState="true"
                                            OnRowDataBound="gvDeputy_RowDataBound">
                                            <AlternatingRowStyle BackColor="White" />
                                            <Columns>
                                                <asp:BoundField DataField="NV_Ma" HeaderText="ID" />
                                                <asp:BoundField DataField="NV_Ten" HeaderText="Name" />
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
                    <td><b>Loại phép đề nghị<br />
                        申請假別</b></td>
                    <td colspan="3">
                        <asp:DropDownList ID="Type" runat="server" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="Type_SelectedIndexChanged">
                            <asp:ListItem Enabled="true" Text="---Vui lòng chọn｜請選擇---" Value="Default"></asp:ListItem>
                            <asp:ListItem Text="Phép năm｜年假｜P" Value="P"></asp:ListItem>
                            <asp:ListItem Text="Việc riêng｜事假｜RO" Value="RO"></asp:ListItem>
                            <asp:ListItem Text="Nghỉ không hưởng lương｜無薪休假｜No1" Value="No1"></asp:ListItem>
                            <asp:ListItem Text="Phép ngừng việc | 停工有協助假 | Pt" Value="Pt"></asp:ListItem>
                            <asp:ListItem Text="Phép nghỉ ngừng việc｜停工有協助假｜Pt2" Value="Pt2"></asp:ListItem>
                            <asp:ListItem Text="Cưới｜婚假 / Tang｜喪假｜R1" Value="R1"></asp:ListItem>
                            <asp:ListItem Text="Con ốm｜小孩生病｜CO" Value="CO"></asp:ListItem>
                            <asp:ListItem Text="Ốm｜病假｜OM" Value="OM"></asp:ListItem>
                            <asp:ListItem Text="Khám thai｜產檢｜KThai" Value="KThai"></asp:ListItem>
                            <asp:ListItem Text="Dân quân｜自衛民兵｜Dq" Value="Dq"></asp:ListItem>
                            <asp:ListItem Text="Quân sự｜軍事假｜QS" Value="QS"></asp:ListItem>
                            <asp:ListItem Text="Dưởng sức｜健康恢復｜Ds" Value="Ds"></asp:ListItem>
                            <asp:ListItem Text="Kế hoạch hóa gia đình｜生育計劃｜KHHGD" Value="KHHGD"></asp:ListItem>
                            <asp:ListItem Text="Sẩy thai｜流產假｜ST" Value="ST"></asp:ListItem>
                            <asp:ListItem Text="Thai sản｜產假｜TS" Value="TS"></asp:ListItem>
                            <asp:ListItem Text="Nam nghỉ phép khi có vợ sinh con｜陪產假｜TS1" Value="TS1"></asp:ListItem>
                            <asp:ListItem Text="Tai nạn lao động｜工傷｜TNLD" Value="TNLD"></asp:ListItem>
                            <asp:ListItem Text="Phép hỗ trợ｜協助假｜Po" Value="Po"></asp:ListItem>
                            <asp:ListItem Text="Phép ca đêm｜夜班停工有薪休假｜Pđ" Value="Pđ"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: right"><b>
                        <asp:Label ID="LBNotify" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </b></td>
                </tr>
                <tr>
                    <td><b>Thời gian nghỉ<br />
                        總請假時間</b></td>
                    <td>
                        <asp:TextBox ID="TotalDay" runat="server" MaxLength="20" Enabled="false" Width="30px" Text="0" /><b>Ngày｜天</b>
                        <asp:TextBox ID="TotalHour" runat="server" MaxLength="20" Enabled="false" Width="30px" Text="0" /><b>Giờ｜小時</b>
                        <asp:TextBox ID="LeaveDays" runat="server" MaxLength="20" Style="display: none;" Width="30px" Text="0" />
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td><b>Ngày bắt đầu<br />
                        開始日期</b></td>
                    <td>
                        <asp:TextBox ID="StartDate" TextMode="Date" runat="server" OnTextChanged="Date_TextChanged" AutoPostBack="true"></asp:TextBox>
                    </td>
                    <td><b>Thời gian<br />
                        時間 </b></td>
                    <td>
                        <asp:TextBox ID="StartTime" TextMode="Time" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td><b>Ngày Kết thúc<br />
                        結束日期</b></td>
                    <td>
                        <asp:TextBox ID="EndDate" TextMode="Date" runat="server" OnTextChanged="Date_TextChanged" AutoPostBack="true"></asp:TextBox>
                    </td>
                    <td><b>Thời gian<br />
                        時間 </b></td>
                    <td>
                        <asp:TextBox ID="EndTime" TextMode="Time" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td><b>Ghi rõ lý do<br />
                        請假事由</b></td>
                    <td colspan="3">
                        <asp:TextBox ID="Reason" TextMode="MultiLine" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td><b>Ghi Chú<br />
                        備註</b></td>
                    <td colspan="3">
                        <asp:TextBox ID="Remark" TextMode="MultiLine" runat="server" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr style="justify-content: center">
                    <td colspan="5">
                        <table class="FormChild">
                            <tr>
                                <td style="text-align: center; padding-bottom: 8px;"><b>Cty Duyệt<br />
                                    廠休</b><br />
                                    <asp:TextBox ID="FactoryClosed" runat="server" MaxLength="20" Enabled="false" Width="35%" /></td>
                                <td style="text-align: center;"><b>No1<br />
                                    無薪假</b><br />
                                    <asp:TextBox ID="Leave_No1" runat="server" MaxLength="20" Enabled="false" Width="35%" /></td>
                                <td style="text-align: center;"><b>Ốm<br />
                                    病假</b><br />
                                    <asp:TextBox ID="Leave_Om" runat="server" MaxLength="20" Enabled="false" Width="35%" /></td>
                                <td style="text-align: center;"><b>Con Ốm<br />
                                    小孩生病假	</b>
                                    <br />
                                    <asp:TextBox ID="Leave_ConOm" runat="server" MaxLength="20" Enabled="false" Width="35%" /></td>
                                <td style="text-align: center;"><b>Ro<br />
                                    事假</b><br />
                                    <asp:TextBox ID="Leave_Ro" runat="server" MaxLength="20" Enabled="false" Width="35%" /></td>
                            </tr>
                            <tr style="justify-content: center">
                                <td colspan="5" style="text-align: center; padding-top: 8px;">
                                    <asp:Panel ID="His" runat="server" DefaultButton="SearchHis" Enabled="false" CssClass="disabledPanel">
                                        <asp:ImageButton ID="SearchHis" runat="server" ImageUrl="../General/Images/select.png" OnClick="SearchHis_Click" />
                                        <asp:Label ID="Label1" runat="server" Text="請假紀錄" AssociatedControlID="SearchHis" />
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table class="Info">
                <tr>
                    <td style="text-align: right;"><b>Năm &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>年份</b></td>
                    <td>
                        <asp:DropDownList ID="Year" runat="server" CssClass="ddYear" AutoPostBack="True" OnSelectedIndexChanged="Year_SelectedIndexChanged"></asp:DropDownList>
                    </td>
                </tr>
                <tr>

                    <td style="text-align: right;"><b>Mã NV &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>工號</b></td>
                    <td>
                        <asp:TextBox ID="ID" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Tên NV &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>姓名</b></td>
                    <td>
                        <asp:TextBox ID="Name" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Ngày Vào &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>到職日期</b></td>
                    <td>
                        <asp:TextBox ID="OnBoardDate" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Phép Năm Năm Trước &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>去年年假天數</b></td>
                    <td>
                        <asp:TextBox ID="LastYD" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Phép Năm Năm Nay &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>今年年假天數</b></td>
                    <td>
                        <asp:TextBox ID="ThisYD" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Số Ngày Phép Trên 5 Năm &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>資歷五年以上</b></td>
                    <td>
                        <asp:TextBox ID="Year5" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Số Ngày Nặng Nhọc (ĐH) &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>毒害</b></td>
                    <td>
                        <asp:TextBox ID="DH" runat="server" Enabled="false" CssClass="auto-style5"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Số Tháng NNĐH &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>毒害作業月數</b></td>
                    <td>
                        <asp:TextBox ID="NNDH" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Sổ Ngày Đã Nghỉ &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>已休年假天數</b></td>
                    <td>
                        <asp:TextBox ID="LeaveYD" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Tổng Đã Nghỉ Thực Tế &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>已休年假總計</b></td>
                    <td>
                        <asp:TextBox ID="TotalYD" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: center;">
                        <span style="vertical-align: middle;">◄</span>
                        <hr style="vertical-align: middle; width: 80%; display: inline-block; height: 2px; background-color: black;" />
                        <span style="vertical-align: middle;">►</span>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>Sổ Ngày Còn Lại &nbsp;｜</b></td>
                    <td style="text-align: left;"><b>年假天數結算</b></td>
                    <td>
                        <asp:TextBox ID="Total" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;"><b>
                        <asp:Label ID="Label_LeaveM" runat="server" Text="Số Ngày Nghỉ Phép Tháng &nbsp;｜"></asp:Label></b></td>
                    <td style="text-align: left;"><b>
                        <asp:Label ID="Label_LeaveM1" runat="server" Text="月休假天數"></asp:Label></b></td>
                    <td>
                        <asp:TextBox ID="LeaveM" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr class="info_end_tr">
                    <td colspan="4" style="text-align: center">
                        <b>Việc Riêng｜事假&nbsp;</b>
                        <asp:TextBox ID="LeaveM_RO" runat="server" Enabled="false"></asp:TextBox>
                        <b>&nbsp;&nbsp; Ốm｜病假&nbsp;	</b>
                        <asp:TextBox ID="LeaveM_OM" runat="server" Enabled="false"></asp:TextBox>
                        <b>&nbsp;&nbsp; Con Ốm｜孩子生病	</b>
                        <asp:TextBox ID="LeaveM_CO" runat="server" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div style="display: none">
            <asp:Label ID="flowflag" runat="server" Text="N"></asp:Label>
            <asp:Label ID="Documents" runat="server" Text="N"></asp:Label>
            <asp:Label ID="DHMonth" runat="server" Text=""></asp:Label>
            <asp:Label ID="YDLeave" runat="server" Text=""></asp:Label>
            <asp:Label ID="Lock" runat="server" Text=""></asp:Label>
        </div>
        <asp:Panel ID="PHis" runat="server" Visible="false">
            <table class="Record" id="Record" style="text-align: center; width: 100%">
                <tr>
                    <td>
                        <div style="height: 300px; overflow: auto">
                            <div class="employee_name_btable">
                                <asp:Label ID="HisName" runat="server" Text="Employee - Name"></asp:Label>
                            </div>
                            <asp:GridView ID="gvHis" runat="server" AutoGenerateColumns="False" CssClass="HisGrid" Width="100%" CellPadding="4" ForeColor="#333333" GridLines="None" Height="300px">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField DataField="NV_Ma" HeaderText="工號" />
                                    <asp:BoundField DataField="NP_TuNgay" HeaderText="請假日期" />
                                    <asp:BoundField DataField="NP_DenNgay" HeaderText="結束日期" />
                                    <asp:BoundField DataField="DV_Ma" HeaderText="部門" />
                                    <asp:BoundField DataField="NP_Ma" HeaderText="假別" />
                                    <asp:BoundField DataField="NP_CONGTYDUYET" HeaderText="NP_CONGTYDUYET" Visible="false" />
                                    <asp:BoundField DataField="NP_GhiChu" HeaderText="備註" />
                                    <asp:BoundField DataField="NP_NGAYNHAPPHEP" HeaderText="建立日期" />
                                    <asp:BoundField DataField="NP_NGAYNHAPSUA" HeaderText="修改日期" />
                                    <asp:BoundField DataField="SN_CHUNHAT" HeaderText="SN_CHUNHAT" Visible="false" />
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
                        </div>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <script type="text/javascript">
            function pageLoad() {
                flatpickr('#<%= StartDate.ClientID %>', {
                    dateFormat: "Y-m-d"
                });

                flatpickr('#<%= EndDate.ClientID %>', {
                    dateFormat: "Y-m-d"
                });

                flatpickr('#<%= StartTime.ClientID %>', {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                    time_24hr: true
                });

                flatpickr('#<%= EndTime.ClientID %>', {
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
