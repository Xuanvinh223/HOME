<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DefaultMasterPage.master" CodeFile="ListAcceptanceFA.aspx.cs" Inherits="LYN_ListAcceptanceFA" %>

<%@ Import Namespace="Ede.Uof.Utility.Page.Common" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
             <link href="<%=Request.ApplicationPath %>/CDS/LYN/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
             <script src="<%=Request.ApplicationPath %>/CDS/LYN/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>
            <style type="text/css">
                .FormQuery td, .FormGrid th { 
                    padding : 5px;   
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
            <asp:Label ID="Title" runat="server" CssClass="ttl" Text="固定資產驗收單查詢｜Báo cáo đề phiếu nghiệm thu Tài sản cố định" Width="100%" BackColor="#1585cf" ForeColor="White" Font-Bold="True" Font-Size="X-Large" Height="50px" /><br />
            <table style="width: 100%" class="FormQuery">
                <tr >
                    <td><b>Số phiếu nghiệm thu (驗收單號)</b>
                        <asp:TextBox ID="tbLNO" runat="server" /></td>
                    <td>
                        <b>Số phiếu nhập kho (入庫單號) </b>
                        <asp:TextBox ID="tbRKNO" runat="server" />
                    </td>
                    <td Style="width: 300px">
                        <b>Ngày nộp đơn (申請日期) </b>
                        <asp:TextBox ID="userdate_start" runat="server" TextMode="Date" />
                        <b>~</b>
                        <asp:TextBox ID="userdate_end" runat="server" TextMode="Date" />
                    </td>
                    <td >
                        <b>Hình thức phiếu nghiệm thu (驗收單類型) </b>
                        <asp:DropDownList ID="DrListType" runat="server" AutoPostBack="true" Style="width: 300px">
                            <asp:ListItem Enabled="true" Text="Toàn Bộ (所有類型)" Value=""></asp:ListItem>
                            <asp:ListItem Text="Tài sản cố định (一般固定資產)" Value="Tài sản cố định (一般固定資產)"></asp:ListItem>
                            <asp:ListItem Text="Tài sản cố định là thiết bị thông tin (資訊設備類固定資產)" Value="Tài sản cố định là thiết bị thông tin (資訊設備類固定資產)"></asp:ListItem>
                            <asp:ListItem Text="Máy móc(Công cụ)機器(工製具)" Value="Máy móc(Công cụ)機器(工製具)"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <b>Trạng thái ký duyệt (簽署狀態)</b>
                        <asp:DropDownList ID="Drflowflag" runat="server" AutoPostBack="true" Style="width: 150px">
                            <asp:ListItem Enabled="true" Text="Toàn Bộ (所有類型)" Value=""></asp:ListItem>
                            <asp:ListItem Text="Hoàn thành|已結案" Value="Z"></asp:ListItem>
                            <asp:ListItem Text="Vô hiệu hóa|禁用" Value="X"></asp:ListItem>
                            <asp:ListItem Text="Khác|其他" Value="P"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: right">
                        <asp:Panel ID="pQuery" runat="server" DefaultButton="Query" CssClass="btn">
                            <asp:ImageButton ID="Query" runat="server" ImageUrl="../General/Images/select.png" OnClick="btnQuery_OnClick" />
                            <asp:Label ID="lbQuery" runat="server" Text="Query" AssociatedControlID="Query" />
                        </asp:Panel>
                    </td>
                    <td style="text-align: center">
                        <asp:Panel ID="pClear" runat="server" DefaultButton="Clear" CssClass="btn">
                            <asp:ImageButton ID="Clear" runat="server" ImageUrl="../General/Images/undo.png" OnClick="btClear_OnClick" />
                            <asp:Label ID="lbClear" runat="server" Text="Clear" AssociatedControlID="Clear" />
                        </asp:Panel>
                    </td>
                </tr>

            </table>
             <table>
                 <tr>
                     <td>
                        <Ede:Grid ID="gvList" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="15" Width="100%" CssClass="FormGrid"
                        CellPadding="3" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"   
                        EnhancePager="True" AllowSorting="True" KeepSelectedRows="True"  
                        DataKeyNames="LNO"   EmptyDataText="No matched data!" ShowHeaderWhenEmpty="True" 
                        OnRowDataBound="gvList_OnRowDataBound"
                        OnPageIndexChanging="gvList_PageIndexChanging" OnSorting="gvList_Sorting"
                        OnBeforeExport="gvList_BeforeExport" AutoGenerateCheckBoxColumn="True" CustomDropDownListPage="False" DataKeyOnClientWithCheckBox="False" DefaultSortDirection="Ascending" SelectedRowColor="" UnSelectedRowColor=""
                        >
                            <EnhancePagerSettings FirstAltImageUrl="" FirstImageUrl="" LastAltImage="" LastImageUrl="" NextIAltImageUrl="" NextImageUrl="" PageInfoCssClass="" PageNumberCssClass="" PageNumberCurrentCssClass="" PageRedirectCssClass="" PreviousAltImageUrl="" PreviousImageUrl="" ShowHeaderPager="True" />
                        <exportexcelsettings allowexporttoexcel="true" exporttype="DataSource" />
                        <EmptyDataRowStyle ForeColor="Red" />
                        <Columns>     
                            <asp:TemplateField HeaderText="Số phiếu nghiệm thu (驗收單單號)" SortExpression="LNO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="LNO" runat="server" Text='<%# Bind("LNO") %>'></asp:TextBox>
                                    <asp:HiddenField ID="hTASK_ID" runat="server" Value='<%# Bind("TASK_ID") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnLNO" runat="server" Text='<%# Bind("LNO") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Hình thức nghiệm thu (驗收單類型 )">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ListType") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ListType") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Số phiếu đơn xin đặt mua (請購單單號 )">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PurchaseRequestNo") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("PurchaseRequestNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ngày nghiệm thu (驗收日期 )">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("AcceptanceDate") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("AcceptanceDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Số phiếu nhập kho (入庫單單號)">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("RKNO") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("RKNO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" Đơn vị đề nghị (申請單位)">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Department") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" Người đề nghị (申請人)">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Applicant") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("Applicant") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Thuyết minh nội dung vấn đề nghiệm thu (驗收事項內容說明)">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã số tài sản (資產編號)">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("PropertyNumbers") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("PropertyNumbers") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Người dùng (使用者 )">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("UserID") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("UserID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Đã cập nhật (更新日期 )">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("UserDate") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("UserDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
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
                <script type="text/javascript">
               
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
