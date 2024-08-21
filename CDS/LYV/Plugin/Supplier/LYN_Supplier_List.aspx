<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DefaultMasterPage.master" CodeFile="LYN_Supplier_List.aspx.cs" Inherits="WKF_Supplier_List" %>

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
            <asp:Label ID="Title" runat="server" CssClass="ttl" Text="供應商資料表查詢｜Báo cáo bảng tư liệu nhà cung ứng" Width="100%" BackColor="#1585cf" ForeColor="White" Font-Bold="True" Font-Size="X-Large" Height="50px" />
            <br />
            <table style="width: 100%" class="FormQuery">
                <tr>
                    <td style="width: 10%">
                        <b>類型</b><br />
                        <asp:DropDownList
                            ID="qType" runat="server">
                            <asp:ListItem Style="width: 80%;" Text="ALL" Value="ALL" Selected="True" />
                            <asp:ListItem Text="量產供應商" Value="量產供應商" />
                            <asp:ListItem Text="總務供應商" Value="總務供應商" />
                            <asp:ListItem Text="原物料供應商" Value="原物料供應商" />
                            <asp:ListItem Text="工具供应商" Value="工具供应商" />
                        </asp:DropDownList>
                    </td>
                    <td style="width: 10%">
                        <b>公司代號</b><br />
                        <asp:TextBox ID="qSupplierID" runat="server" Width="80%"></asp:TextBox>
                    </td>
                    <td style="width: 15%">
                        <b>公司名稱</b><br />
                        <asp:TextBox ID="qSupplierName" runat="server" Width="100%"></asp:TextBox>
                    </td>
                    <td style="width: 5%">
                        <asp:Panel ID="pQuery" runat="server" DefaultButton="Query" CssClass="btn">
                            <asp:ImageButton ID="Query" runat="server" ImageUrl="../General/Images/select.png" OnClick="Query_Click" />
                            <asp:Label ID="lbQuery" runat="server" Text="Query" AssociatedControlID="Query" />
                        </asp:Panel>
                    </td>
                    <td style="width: 5%">
                        <asp:Panel ID="pClear" runat="server" DefaultButton="Clear" CssClass="btn">
                            <asp:ImageButton ID="Clear" runat="server" ImageUrl="../General/Images/undo.png" OnClick="Clear_Click" />
                            <asp:Label ID="lbClear" runat="server" Text="Clear" AssociatedControlID="Clear" />
                        </asp:Panel>
                    </td>
                    <td style="width: 70%"></td>
                </tr>
            </table>
            <asp:HiddenField ID="hfSiteName" runat="server" />
            <Ede:Grid ID="gvSUP" runat="server" CssClass="gvSUP" PageSize="10" AllowPaging="True" DataKeyNames="LNO" AutoGenerateColumns="False" CustomDropDownListPage="False" DefaultSortDirection="Ascending" EmptyDataText="No data found" EnhancePager="True" KeepSelectedRows="false" SelectedRowColor="229, 245, 159" UnSelectedRowColor="238, 238, 238" ShowHeaderWhenEmpty="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnBeforeExport="gvSUP_BeforeExport" OnRowDataBound="gvSUP_RowDataBound" OnPageIndexChanging="gvSUP_PageIndexChanging" AllowSorting="True" Width="100%" AutoGenerateCheckBoxColumn="False">
                <EnhancePagerSettings ShowHeaderPager="false"></EnhancePagerSettings>

                <ExportExcelSettings AllowExportToExcel="true" ExportType="DataSource" />
                <Columns>
                    <asp:TemplateField HeaderText="單號">
                        <EditItemTemplate>
                            <asp:TextBox ID="LNO" runat="server" Text='<%# Bind("LNO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnLNO" runat="server" Text='<%# Bind("LNO") %>'></asp:LinkButton>
                            <asp:HiddenField ID="hTASK_ID" runat="server" Value='<%# Bind("TASK_ID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="公司類型">
                        <EditItemTemplate>
                            <asp:TextBox ID="Type" runat="server" Text='<%# Bind("Type") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbType" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="公司代碼">
                        <EditItemTemplate>
                            <asp:TextBox ID="SupplierID" runat="server" Text='<%# Bind("SupplierID") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbSupplierID" runat="server" Text='<%# Bind("SupplierID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="公司名稱">
                        <EditItemTemplate>
                            <asp:TextBox ID="SupplierName" runat="server" Text='<%# Bind("SupplierName") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbSupplierName" runat="server" Text='<%# Bind("SupplierName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="公司地址">
                        <EditItemTemplate>
                            <asp:TextBox ID="CompanyAddress" runat="server" Text='<%# Bind("CompanyAddress") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbCompanyAddress" runat="server" Text='<%# Bind("CompanyAddress") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="工廠地址">
                        <EditItemTemplate>
                            <asp:TextBox ID="FactoryAddress" runat="server" Text='<%# Bind("FactoryAddress") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbFactoryAddress" runat="server" Text='<%# Bind("FactoryAddress") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="主要產品">
                        <EditItemTemplate>
                            <asp:TextBox ID="Product" runat="server" Text='<%# Bind("Product") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbProduct" runat="server" Text='<%# Bind("Product") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="創業時間">
                        <EditItemTemplate>
                            <asp:TextBox ID="Established" runat="server" Text='<%# Bind("Established") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbEstablished" runat="server" Text='<%# Bind("Established") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="營業執照(若需要)">
                        <EditItemTemplate>
                            <asp:TextBox ID="License" runat="server" Text='<%# Bind("License") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbLicense" runat="server" Text='<%# Bind("License") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="負責人">
                        <EditItemTemplate>
                            <asp:TextBox ID="PersonInCharge" runat="server" Text='<%# Bind("PersonInCharge") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbPersonInCharge" runat="server" Text='<%# Bind("PersonInCharge") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="連絡人">
                        <EditItemTemplate>
                            <asp:TextBox ID="ContactPerson" runat="server" Text='<%# Bind("ContactPerson") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbContactPerson" runat="server" Text='<%# Bind("ContactPerson") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="電話">
                        <EditItemTemplate>
                            <asp:TextBox ID="Tel" runat="server" Text='<%# Bind("Tel") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbTel" runat="server" Text='<%# Bind("Tel") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="傳真">
                        <EditItemTemplate>
                            <asp:TextBox ID="Fax" runat="server" Text='<%# Bind("Fax") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbFax" runat="server" Text='<%# Bind("Fax") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="電子信箱">
                        <EditItemTemplate>
                            <asp:TextBox ID="Email" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lbEmail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
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
                    <asp:TemplateField HeaderText="申請時間">
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
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
