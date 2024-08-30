<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Bosungnhansu.ascx.cs" Inherits="WKF_OptionalFields_Bosungnhansu" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>

<link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
<script src="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>

<style type="text/css">
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"  >
    <ContentTemplate>
        <asp:Panel ID="panel1" runat="server" Style="display: flex; justify-content: flex-start; align-items: center;">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="btnPrint" CssClass="btnFunc" Style="display: flex; flex-direction: column; align-items: center; justify-content: center; border: 1px solid gray; width: 80px; height: 40px; padding: 3px; margin-right: 10px;" Visible="false">
                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_Click" Style="width: 15px; height: 20px;" />
                <asp:Label ID="lbPrint" runat="server" Text="In BSNS " AssociatedControlID="btnPrint" />
            </asp:Panel>
             <asp:Panel ID="pPrintDN" runat="server" DefaultButton="btnPrintDN" CssClass="btnFunc" Style="display: flex; flex-direction: column; align-items: center; justify-content: center; border: 1px solid gray; width: 80px; height: 40px; padding: 3px; margin-right: 10px;" Visible="false">
                 <asp:ImageButton ID="btnPrintDN" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_ClickDN" Style="width: 15px; height: 20px;" />
                 <asp:Label ID="Label1" runat="server" Text="In ĐN" AssociatedControlID="btnPrintDN" />
             </asp:Panel>
             <asp:Panel ID="pPrintDS" runat="server" DefaultButton="btnPrintDS" CssClass="btnFunc" Style="display: flex; flex-direction: column; align-items: center; justify-content: center; border: 1px solid gray; width: 80px; height: 40px; padding: 3px; margin-right: 10px;" Visible="false">
                 <asp:ImageButton ID="btnPrintDS" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_ClickDS" Style="width: 15px; height: 20px;" />
                 <asp:Label ID="Label2" runat="server" Text="In DS" AssociatedControlID="btnPrintDS" />
             </asp:Panel>
        </asp:Panel>

        <asp:HiddenField ID="hfLYV" runat="server" />
        <asp:HiddenField ID="hfTASKID" runat="server" />
        <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        <asp:Panel ID="pTable" runat="server">
            <table class="tblTotal" width="100%">
                <tr>
                    <td style="width: 60%; border: 1px solid gray;">
                        <b style="color: dodgerblue">ĐỀ NGHỊ BỔ SUNG NHÂN SỰ 人員增補申請單</b><br />
                        <asp:Panel runat="server" Style="width: 100%; padding: 10px">
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                        <b>SỐ NO | 編號</b><br />
                                        <asp:TextBox ID="tbMaphieu" AutoPostBack="True" runat="server" MaxLength="30" />
                                    </td>
                                    <td>
                                        <b>Người đề nghị｜申請人</b><br />
                                        <asp:TextBox ID="tbUserid" AutoPostBack="True" runat="server" MaxLength="20" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b>Nơi gởi | 寫單者</b><br />
                                        <asp:TextBox ID="tbNoigui" AutoPostBack="True" runat="server" MaxLength="100" Width="500" />
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <b>Số lượng biên chế | 編制数量</b><br />
                                        <i>Nam | 男</i>
                                        <asp:TextBox ID="tbSLBienChe_Nam" TextMode="Number" AutoPostBack="True" runat="server" MaxLength="20" />
                                        <i>Người | 人　</i>
                                    </td>
                                    <td>
                                        <b></b>
                                        <br />
                                        <i>Nữ | 女</i>
                                        <asp:TextBox ID="tbSLBienChe_Nu" TextMode="Number" AutoPostBack="True" runat="server" MaxLength="20" />
                                        <i>Người | 人　</i>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>Số người thực tế | 實際人數</b><br />
                                        <i>Nam | 男</i>
                                        <asp:TextBox ID="tbSLThucTe_Nam" TextMode="Number" AutoPostBack="True" runat="server" MaxLength="20" />
                                        <i>Người | 人　</i>
                                    </td>
                                    <td>
                                        <b></b>
                                        <br />
                                        <i>Nữ | 女</i>
                                        <asp:TextBox ID="tbSLThucTe_Nu" TextMode="Number" AutoPostBack="True" runat="server" MaxLength="20" />
                                        <i>Người | 人　</i>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>Số người đề nghị | 申請人數</b><br />
                                        <asp:TextBox ID="tbSLDeNghi" TextMode="Number" AutoPostBack="True" runat="server" MaxLength="20" />
                                    </td>
                                    <td>
                                        <b>Trình độ VH | 文化程度</b><br />
                                        <asp:TextBox ID="tbTrinhDoVH" TextMode="MultiLine" AutoPostBack="True" runat="server" MaxLength="200" Style="width: 100%" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b>Thời gian | 時間</b><br />
                                        <asp:TextBox ID="tbThoiGianBS" TextMode="Date" AutoPostBack="True" runat="server" Style="width: 50%" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b>Nguyên nhân bổ sung | 招募原因</b><br />
                                        <asp:DropDownList ID="ddlLyDoBS" runat="server" Width="100%" AutoPostBack="true">
                                            <asp:ListItem Enabled="true" Text="---Vui lòng chọn｜請選擇---" Value="Default"></asp:ListItem>
                                            <asp:ListItem Text="Bù nghỉ việc 代替辞职人員" Value="Bù nghỉ việc 代替辞职人員"></asp:ListItem>
                                            <asp:ListItem Text="Mở rộng sản xuất 擴大生產" Value="Mở rộng sản xuất 擴大生產"></asp:ListItem>
                                            <asp:ListItem Text="Khác 其他" Value="Khác 其他"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b>Ghi chú | 備注</b><br />
                                        <asp:TextBox ID="tbGhiChu" TextMode="MultiLine" AutoPostBack="True" runat="server" MaxLength="1000" Style="width: 100%; height: 50px" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                    <td style="width: 40%; border: 1px solid gray;">
                        <b style="color: dodgerblue">PHIẾU ĐỀ NGHỊ 簽呈</b><br />
                        <asp:Label ID="lbDNChude" runat="server" MaxLength="500" Style="width: 100%" Text=""></asp:Label>
                        <asp:Panel id ="pDN"  runat="server" Style="width: 100%; padding: 10px">
                            <center><b style="font-size: 20px">PHIẾU ĐỀ NGHỊ</b></center>
                            <center><b style="font-size: 20px">簽呈</b></center>
                            <b>Chủ đề | 主旨</b><br />
                            <asp:TextBox ID="tbDNChude" TextMode="MultiLine" AutoPostBack="True" runat="server" MaxLength="500" Style="width: 100%" />
                            <b>Nội dung | 內容</b><br />
                            <asp:TextBox ID="tbDNNoidung" TextMode="MultiLine" AutoPostBack="True" runat="server" MaxLength="1000" Style="width: 100%; height: 250px" />
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="border: 1px solid gray;">
                        <asp:Panel runat="server" Style="width: 100%; padding: 10px">
                            <b style="color: dodgerblue">DANH SÁCH NGHỈ VIỆC 離職名單</b><br />
                            <Ede:Grid ID="gvData" runat="server" AutoGenerateColumns="False" DataKeyNames="listLine" OnRowEditing="gvData_RowEditing" OnRowUpdating="gvData_RowUpdating" OnRowCancelingEdit="gvData_RowCancelingEdit" OnRowDeleting="gvData_RowDeleting" OnRowDataBound="gvData_RowDataBound" EmptyDataText="No data found" AutoGenerateCheckBoxColumn="False" ShowHeaderWhenEmpty="True" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="STT&lt;br/&gt;序號">
                                        <ItemTemplate>
                                            <asp:Label ID="lbllistLine" runat="server" Text='<%# Bind("listLine") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Đơn Vị&lt;br/&gt;單位">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDonVi" runat="server" Text='<%# Eval("DonVi") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox TextMode="MultiLine" ID="txtDonViEdit" runat="server" Text='<%# Bind("DonVi") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Họ tên&lt;br/&gt;姓名">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTenNV" runat="server" Text='<%# Eval("TenNV") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox TextMode="MultiLine" ID="txtTenNVEdit" runat="server" Text='<%# Bind("TenNV") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Số thẻ&lt;br/&gt;工號">
                                        <ItemTemplate>
                                            <asp:Label ID="lblMaNV" runat="server" Text='<%# Eval("MaNV") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMaNVEdit" runat="server" Text='<%# Bind("MaNV") %>' OnTextChanged="txtMaNVEdit_TextChanged" AutoPostBack="true" Width="70px"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Giới Tính&lt;br/&gt;性別">
                                        <ItemTemplate>
                                            <asp:Label ID="lblGioiTinh" runat="server" Text='<%# Eval("GioiTinh") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtGioiTinhEdit" runat="server" Text='<%# Bind("GioiTinh") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Ngày vào công ty&lt;br/&gt;進廠日期">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNgayVaoCT" runat="server" Text='<%# Eval("NgayVaoCT") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtNgayVaoCTEdit"  runat="server" Text='<%# Bind("NgayVaoCT") %>' Width="120px"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Ngày nghỉ việc &lt;br/&gt;離職日期">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNgayNghiViec" runat="server" Text='<%# Eval("NgayNghiViec") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtNgayNghiViecEdit"  runat="server" Text='<%# Bind("NgayNghiViec") %>' Width="120px"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Lý do nghỉ ty&lt;br/&gt;離職原因">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLyDoNghi" runat="server" Text='<%# Eval("LyDoNghi") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox TextMode="MultiLine" ID="txtLyDoNghiEdit" runat="server" Text='<%# Bind("LyDoNghi") %>'></asp:TextBox>
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
                        </asp:Panel>
                    </td>

                </tr>
            </table>
        </asp:Panel>

    </ContentTemplate>
</asp:UpdatePanel>

 <script type="text/javascript">
     function pageLoad() {
         flatpickr('#<%= tbThoiGianBS.ClientID %>', {
             dateFormat: "Y-m-d", // "H" là để hiển thị giờ và "i" là để hiển thị phút
             enableTime: false, // Bật chế độ hiển thị giờ và phút
             time_24hr: true // Sử dụng định dạng 24 giờ
         });

       
     }
 </script>
<asp:Label ID="lblHasNoAuthority" runat="server" Text="無填寫權限" ForeColor="Red" Visible="False" meta:resourcekey="lblHasNoAuthorityResource1"></asp:Label>
<asp:Label ID="lblToolTipMsg" runat="server" Text="不允許修改(唯讀)" Visible="False" meta:resourcekey="lblToolTipMsgResource1"></asp:Label>
<asp:Label ID="lblModifier" runat="server" Visible="False" meta:resourcekey="lblModifierResource1"></asp:Label>
<asp:Label ID="lblMsgSigner" runat="server" Text="填寫者" Visible="False" meta:resourcekey="lblMsgSignerResource1"></asp:Label>
<asp:Label ID="lblAuthorityMsg" runat="server" Text="具填寫權限人員" Visible="False" meta:resourcekey="lblAuthorityMsgResource1"></asp:Label>