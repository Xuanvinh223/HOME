<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Acceptance.ascx.cs" Inherits="CDS_LYV_Plugins_Acceptance_Acceptance" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>


<style type="text/css">
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <asp:Panel ID="panel1" runat="server" Style="display: flex; justify-content: flex-start; align-items: center;">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="btnPrint" CssClass="btnFunc" Style="display: flex; flex-direction: column; align-items: center; justify-content: center; border: 1px solid gray; width: 50px; height: 40px; padding: 3px; margin-right: 10px;" Visible="false">
                <asp:ImageButton ID="btnPrint" runat="server" OnClick="Print_Click" ImageUrl="../General/Images/print.png" Style="width: 15px; height: 20px;" />
                <asp:Label ID="lbPrint" runat="server" Text="Print" AssociatedControlID="btnPrint" />
            </asp:Panel>
        </asp:Panel>

        <asp:HiddenField ID="hfLNO" runat="server" />
        <asp:HiddenField ID="hfTASKID" runat="server" />
        <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        <table class="tblTotal">
            <tr>
                <td style="width: 620px">
                    <b>Số phiếu đơn xin đặt mua | 請購單單號</b>
                    <br />
                    <asp:TextBox ID="tbPurchaseRequestNo" AutoPostBack="True" runat="server" MaxLength="20" Style="width: 550px" />
                </td>
                <td style="width: 600px">
                    <b>Số phiếu đơn đặt mua | 採購單單號</b>
                    <br />
                    <asp:TextBox ID="tbZSNO" runat="server" Style="width: 550px" Enabled="false" />
                </td>
            </tr>
            <tr>
                <td style="width: 620px">
                    <b>Số phiếu nhập kho | 入庫單單號</b>
                    <br />
                    <asp:TextBox ID="tbRKNO" runat="server" OnTextChanged="tbRKNO_Changed" AutoPostBack="True" Style="width: 550px; background-color: yellow" />
                </td>
                <td style="width: 600px">
                    <b>Nhà cung ứng | 廠商</b>
                    <br />
                    <asp:TextBox ID="tbZSYWJC" runat="server" Style="width: 550px" Enabled="false" />
                </td>
            </tr>
            <tr>
                <td colspan=" 2">
                    <Ede:Grid ID="gvMaster" runat="server" CssClass="FormGrid" PageSize="20" AllowPaging="True" DataKeyNames="RKNO" AutoGenerateColumns="False" AutoGenerateCheckBoxColumn="True" CustomDropDownListPage="False" DataKeyOnClientWithCheckBox="True" DefaultSortDirection="Ascending" EmptyDataText="No data found" EnhancePager="True" KeepSelectedRows="False" SelectedRowColor="229, 245, 159" UnSelectedRowColor="238, 238, 238" ShowHeaderWhenEmpty="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="gvMaster_OnRowDataBound" OnPageIndexChanging="gvMaster_PageIndexChanging" AllowSorting="True" Width="100%">
                        <EmptyDataRowStyle ForeColor="Red" />
                        <Columns>
                            <asp:BoundField DataField="RKNO" HeaderText="RKNO" Visible="false">
                                <ItemStyle Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Seq" HeaderText="STT (次序)">
                                <ItemStyle Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VWPM" HeaderText="TÊN TÀI SẢN NHÃN HIỆU QUY CÁCH (財產名稱規格) ">
                                <ItemStyle Width="500px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DWBH" HeaderText="Đơn vị (單位) ">
                                <ItemStyle Width="120px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Qty" HeaderText="Số lượng (數量)">
                                <ItemStyle Width="130px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Qty" HeaderText="SỐ LƯỢNG THỰC NHẬP (數量實際) ">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="USPrice" HeaderText="ĐƠN GIÁ USD (單價 美金)">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VNPrice" HeaderText="ĐƠN GIÁ VND (單價)">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="USACC" HeaderText="THÀNH TIỀN USD (金額 美金)">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VNACC" HeaderText="THÀNH TIỀN VND (金額 越盾)">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VNTax_HG" HeaderText="THUẾ NHẬP KHẨU ĐƠN GIÁ (進口稅 單價)">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VNACC_Tax" HeaderText="THUẾ NHẬP KHẨU VND (進口稅 越盾)">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div style="margin: 30px 0; text-align: left;">
                                <asp:Label ID="lbEmptyMsg" runat="server" Text="🗅 No matched data!"></asp:Label>
                            </div>
                        </EmptyDataTemplate>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </Ede:Grid>
                </td>
            </tr>
        </table>

    </ContentTemplate>
</asp:UpdatePanel>

<script>

</script>
<asp:Label ID="lblHasNoAuthority" runat="server" Text="無填寫權限" ForeColor="Red" Visible="False" meta:resourcekey="lblHasNoAuthorityResource1"></asp:Label>
<asp:Label ID="lblToolTipMsg" runat="server" Text="不允許修改(唯讀)" Visible="False" meta:resourcekey="lblToolTipMsgResource1"></asp:Label>
<asp:Label ID="lblModifier" runat="server" Visible="False" meta:resourcekey="lblModifierResource1"></asp:Label>
<asp:Label ID="lblMsgSigner" runat="server" Text="填寫者" Visible="False" meta:resourcekey="lblMsgSignerResource1"></asp:Label>
<asp:Label ID="lblAuthorityMsg" runat="server" Text="具填寫權限人員" Visible="False" meta:resourcekey="lblAuthorityMsgResource1"></asp:Label>