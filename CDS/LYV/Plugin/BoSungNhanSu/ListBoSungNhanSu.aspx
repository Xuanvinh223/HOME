<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/DefaultMasterPage.master" CodeFile="ListBoSungNhanSu.aspx.cs" Inherits="LYV_ListBoSungNhanSu" %>

<%@ Import Namespace="Ede.Uof.Utility.Page.Common" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Ede" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
            <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
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
            <asp:Label ID="Title" runat="server" CssClass="ttl" Text="人員增補申請單報告 | Báo cáo đề nghị bổ sung nhân sự" Width="100%" BackColor="#1585cf" ForeColor="White" Font-Bold="True" Font-Size="X-Large" Height="50px" /><br />
            <table style="width: 100%" class="FormQuery">
                <tr>
                    <td>
                        <asp:RadioButtonList ID="rbNoiNhan" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Khu A" Value="Khu A" Selected="true"></asp:ListItem>
                            <asp:ListItem Text="Khu Hành Chính" Value="Khu hành chính"></asp:ListItem>
                        </asp:RadioButtonList>

                    </td>
                    <td><b>STT | 單號</b>
                        <asp:TextBox ID="tbLYV" runat="server" /></td>
                    <td>
                        <b>Số No | 編號 </b>
                        <asp:TextBox ID="tbMaPhieu" runat="server" />
                    </td>
                    <td Style="width: 300px">
                        <b>Ngày nộp đơn (申請日期) </b>
                        <asp:TextBox ID="userdate_start" runat="server" TextMode="Date" />
                        <b>~</b>
                        <asp:TextBox ID="userdate_end" runat="server" TextMode="Date" />
                    </td>
                    <td >
                        <b>Lý do bổ sung NS | 招募原因</b>
                        <asp:DropDownList ID="DrLyDoBS" runat="server" AutoPostBack="true" Style="width: 200px">
                            <asp:ListItem Enabled="true" Text="Toàn Bộ (所有類型)" Value=""></asp:ListItem>
                            <asp:ListItem Text="Bù nghỉ việc 代替辞职人員" Value="Bù nghỉ việc 代替辞职人員"></asp:ListItem>
                            <asp:ListItem Text="Mở rộng sản xuất 擴大生產" Value="Mở rộng sản xuất 擴大生產"></asp:ListItem>     
                            <asp:ListItem Text="Khác 其他" Value="Khác 其他"></asp:ListItem>    
                        </asp:DropDownList>
                    </td>
                    <td>
                        <b>Status</b>
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
                        OnPageIndexChanging="gvList_PageIndexChanging"
                        OnBeforeExport="gvList_BeforeExport" AutoGenerateCheckBoxColumn="True" CustomDropDownListPage="False" DataKeyOnClientWithCheckBox="False" DefaultSortDirection="Ascending" SelectedRowColor="" UnSelectedRowColor=""
                        >
                            <EnhancePagerSettings FirstAltImageUrl="" FirstImageUrl="" LastAltImage="" LastImageUrl="" NextIAltImageUrl="" NextImageUrl="" PageInfoCssClass="" PageNumberCssClass="" PageNumberCurrentCssClass="" PageRedirectCssClass="" PreviousAltImageUrl="" PreviousImageUrl="" ShowHeaderPager="True" />
                        <exportexcelsettings allowexporttoexcel="true" exporttype="DataSource" />
                        <EmptyDataRowStyle ForeColor="Red" />
                        <Columns>     
                            <asp:TemplateField HeaderText="Số STT">
                                <EditItemTemplate>
                                    <asp:TextBox ID="LNO" runat="server" Text='<%# Bind("LNO") %>'></asp:TextBox>
                                    <asp:HiddenField ID="hTASK_ID" runat="server" Value='<%# Bind("TASK_ID") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnLNO" runat="server" Text='<%# Bind("LNO") %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SỐ NO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MaPhieu") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("MaPhieu") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Nơi gởi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NoiGui") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("NoiGui") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SL Biên chế Nam">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SLBienChe_Nam") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("SLBienChe_Nam") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SL biên chế Nữ">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("SLBienChe_Nu") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("SLBienChe_Nu") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" SL thực tế nam">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("SLThucTe_Nam") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("SLThucTe_Nam") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" SL thực tế nữ">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("SLThucTe_Nu") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("SLThucTe_Nu") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Số người đề nghị">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("SLDeNghi") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("SLDeNghi") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Trình độ VH">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("TrinhDoVH") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("TrinhDoVH") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Thời gian ">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("ThoiGianBS") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("ThoiGianBS") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Nguyên nhân bổ sung">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("LyDoBS") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("LyDoBS") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ghi chú">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("GhiChu") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("GhiChu") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                               <asp:TemplateField HeaderText="UserID">
                                   <EditItemTemplate>
                                       <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("userid") %>'></asp:TextBox>
                                   </EditItemTemplate>
                                   <ItemTemplate>
                                       <asp:Label ID="Label12" runat="server" Text='<%# Bind("userid") %>'></asp:Label>
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
