<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LYV_Out.ascx.cs" Inherits="LYV_Out" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
        <script src="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>
        <style type="text/css">
            .FormGrid td, .FormGrid th {
                padding: 8px;
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

        <asp:Panel ID="panel1" runat="server" CssClass="panel1" Visible="false">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="Print" CssClass="btnFunc">
                <asp:ImageButton ID="Print" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_Click" />
                <asp:Label ID="lbPrint" runat="server" Text="Print" AssociatedControlID="Print" />
            </asp:Panel>
            <asp:Panel ID="pDisable" runat="server" DefaultButton="Disable" CssClass="btnFunc">
                <asp:ImageButton ID="Disable" runat="server" ImageUrl="../General/Images/cancel.png" OnClick="Disable_Click" />
                <asp:Label ID="lbDisable" runat="server" Text="註銷 Cancel" AssociatedControlID="Disable" />
            </asp:Panel>
            <asp:HiddenField ID="hfLNO" runat="server" />
            <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        </asp:Panel>
        <asp:Panel ID="pTable" runat="server">
            <table style="width: 75%" class="FormGrid">
                <tr>
                    <td colspan="4">
                        <Ede:Grid ID="gvMB" runat="server" AutoGenerateColumns="False" DataKeyNames="listLine" OnRowEditing="gvMB_RowEditing" OnRowUpdating="gvMB_RowUpdating" OnRowCancelingEdit="gvMB_RowCancelingEdit" OnRowDeleting="gvMB_RowDeleting" OnRowDataBound="gvMB_RowDataBound" EmptyDataText="No data found" AutoGenerateCheckBoxColumn="False" ShowHeaderWhenEmpty="True" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="STT&lt;br/&gt;序號">
                                    <ItemTemplate>
                                        <asp:Label ID="lbllistLine" runat="server" Text='<%# Bind("listLine") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Họ tên&lt;br/&gt;姓名">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNameEdit" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Số thẻ&lt;br/&gt;工號">
                                    <ItemTemplate>
                                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtIDEdit" runat="server" Text='<%# Bind("ID") %>' OnTextChanged="txtIDEdit_TextChanged" AutoPostBack="true"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Phân khu&lt;br/&gt;廠區">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFactory" runat="server" Text='<%# Eval("Factory") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFactoryEdit" runat="server" Text='<%# Bind("Factory") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Đơn vị&lt;br/&gt;單位">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDepartmentEdit" runat="server" Text='<%# Bind("Department") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ButtonType="Button" />
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
                        <asp:Button ID="btnAdd" runat="server" Text="Add New Person" OnClick="btnAdd_Click" Style="margin-top: 8px" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right"><b>Giờ ra｜出廠時間</b></td>
                    <td>
                        <asp:TextBox ID="LeaveTime" TextMode="DateTime" runat="server" Width="60%"></asp:TextBox></td>
                    <td style="text-align: right"><b>Giờ vào｜進廠時間</b></td>
                    <td>
                        <asp:TextBox ID="ReturnTime" TextMode="DateTime" runat="server" Width="60%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="text-align: right"><b>Hình thức ra cổng｜外出類別</b></td>
                    <td colspan="3">
                        <asp:DropDownList ID="Type" runat="server" Width="97%" AutoPostBack="true" OnSelectedIndexChanged="Type_SelectedIndexChanged">
                            <asp:ListItem Enabled="true" Text="---Vui lòng chọn｜請選擇---" Value="Default"></asp:ListItem>
                            <asp:ListItem Text="A.人員外出-單位主管以下(Người ̣đi ra-Cấp dưới chủ quản đơn vị)" Value="A.人員外出-單位主管以下(Cap duoi chu quan don vi)"></asp:ListItem>
                            <asp:ListItem Text="B.人員外出-單位主管以上(Người ̣đi ra-Cấp trên chủ quản đơn vị)" Value="B.人員外出-單位主管以上(Cap tren chu quan don vi)"></asp:ListItem>
                            <asp:ListItem Text="C.物品外出-其他類(Vật phẩm khác)" Value="C.物品外出-其他類(Vat pham Khac)"></asp:ListItem>
                            <asp:ListItem Text="D.物品外出-資產類(Vật phẩm tài sản)" Value="D.物品外出-資產類(Vat pham tai san)"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <asp:Panel ID="pCD" runat="server" Visible="false">
                    <tr>
                        <td style="text-align: right"><b>Loại vật phẩm ra cổng｜物品種類</b></td>
                        <td colspan="3">
                            <asp:TextBox ID="Category" runat="server" ReadOnly="true" Width="97%"></asp:TextBox>
                            <asp:ImageButton ID="SearchCategory" runat="server" ImageUrl="../General/Images/select.png" OnClick="SearchCategory_Click" Width="2%" />
                            <br />
                            <asp:Panel ID="pCategory" runat="server" Visible="false">
                                <asp:CheckBoxList ID="cbCategory" runat="server" RepeatColumns="2" OnSelectedIndexChanged="CategoryList_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="Giày (鞋類)" Value="Giay (鞋類)"></asp:ListItem>
                                    <asp:ListItem Text="Gia công (加工類)" Value="Gia cong (加工類)"></asp:ListItem>
                                    <asp:ListItem Text="Vật tư (材料類)" Value="Vat tu (材料類)"></asp:ListItem>
                                    <asp:ListItem Text="Linh kiện máy móc thiết bị (機器設備、零件)" Value="Linh kien may moc thiet bi (機器設備、零件)"></asp:ListItem>
                                    <asp:ListItem Text="Phế phẩm (廢品)" Value="Phe pham (廢品)"></asp:ListItem>
                                    <asp:ListItem Text="Vt cao su (橡膠料)" Value="Vt cao su (橡膠料)"></asp:ListItem>
                                    <asp:ListItem Text="Thực phẩm (食品)" Value="Thuc pham (食品)"></asp:ListItem>
                                    <asp:ListItem Text="Khuôn in (印刷網版)" Value="Khuon in (印刷網版)"></asp:ListItem>
                                    <asp:ListItem Text="Xuất hàng (出貨)" Value="Xuat hang (出貨)"></asp:ListItem>
                                    <asp:ListItem Text="Keo và mực (膠藥水、油墨)" Value="Keo va muc (膠藥水、油墨)"></asp:ListItem>
                                    <asp:ListItem Text="Dao Chặt (斬刀)" Value="Dao Chặt (斬刀)"></asp:ListItem>
                                    <asp:ListItem Text="rác(垃圾)" Value="rac(垃圾)"></asp:ListItem>
                                    <asp:ListItem Text="các loại nước thải(抽汙油水)" Value="cac loai nuoc thai(抽汙油水)"></asp:ListItem>
                                    <asp:ListItem Text="vật liệu khai thác(開發中心確認材料)" Value="vat lieu khai thac(開發中心確認材料)"></asp:ListItem>
                                    <asp:ListItem Text="Khác (其它)" Value="Khac (其它)"></asp:ListItem>
                                </asp:CheckBoxList>
                                <asp:Button ID="btnOK" runat="server" Text="OK" OnClick="btnOK_Click" />
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right"><b>Tên vật phẩm và số lượng<br />
                            ｜物品名稱及數量</b></td>
                        <td colspan="3">
                            <asp:TextBox ID="Item" runat="server" TextMode="MultiLine" Width="97%" Height="80" MaxLength="500"></asp:TextBox>
                        </td>
                    </tr>
                </asp:Panel>
                <tr>
                    <td style="text-align: right"><b>Lý do ra｜外出原因</b></td>
                    <td colspan="3">
                        <asp:TextBox ID="Reason" runat="server" TextMode="MultiLine" Width="97%" Height="80" MaxLength="500"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <script type="text/javascript">
           function pageLoad() {
                flatpickr('#<%= LeaveTime.ClientID %>', {
                    dateFormat: "Y-m-d H:i", // "H" là để hiển thị giờ và "i" là để hiển thị phút
                    enableTime: true, // Bật chế độ hiển thị giờ và phút
                    time_24hr: true // Sử dụng định dạng 24 giờ
                });

                flatpickr('#<%= ReturnTime.ClientID %>', {
                    dateFormat: "Y-m-d H:i", // "H" là để hiển thị giờ và "i" là để hiển thị phút
                    enableTime: true, // Bật chế độ hiển thị giờ và phút
                    time_24hr: true // Sử dụng định dạng 24 giờ
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
