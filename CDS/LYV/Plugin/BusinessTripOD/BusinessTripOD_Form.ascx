<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BusinessTripOD_Form.ascx.cs" Inherits="WKF_BusinessTripOD_Form" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>

<link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
<script src="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>

<link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/BusinessTripOD/style.css" type="text/css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
    <ContentTemplate>
        <asp:Panel ID="panel1" runat="server" CssClass="panel1">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="Print" CssClass="btnFunc" Visible="false">
                <asp:ImageButton ID="Print" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_Click" />
                <asp:Label ID="lbPrint" runat="server" Text="In 人" AssociatedControlID="Print" />
            </asp:Panel>
            <asp:HiddenField ID="hfLYV" runat="server" />
            <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        </asp:Panel>
        <div class="container">
            <!-- Department Search Panel -->
            <asp:Panel ID="Dep" runat="server" Visible="false">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <asp:TextBox ID="DV_MA_Search" runat="server" placeholder="Search Department ID" AutoPostBack="true" OnTextChanged="DV_Search_TextChanged" CssClass="form-control" />
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="DV_TEN_Search" runat="server" placeholder="Search Department Name" AutoPostBack="true" OnTextChanged="DV_Search_TextChanged" CssClass="form-control" />
                    </div>
                </div>
                <asp:GridView ID="gvDep" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="gvDep_PageIndexChanging" CssClass="table table-bordered table-striped table-hover text-center" Width="100%"
                    CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvDep_SelectedIndexChanged" AutoPostBack="true" OnRowDataBound="gvDep_RowDataBound">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="DV_MA" HeaderText="Department ID" />
                        <asp:BoundField DataField="DV_TEN" HeaderText="Department Name" />
                    </Columns>
                </asp:GridView>
            </asp:Panel>
            <!-- Form Fields -->
            <div class="row mb-3">
                <!-- Số thẻ -->
                <div class="col-md-4">
                    <label for="Name_ID" class="form-label">
                        <b>
                            <label class="text-danger">* </label>
                            Số thẻ 工號</b></label>
                    <asp:TextBox ID="Name_ID" runat="server" MaxLength="20" CssClass="form-control" AutoPostBack="true" OnTextChanged="Name_ID_TextChanged" />
                </div>
                <!-- Họ tên -->
                <div class="col-md-4">
                    <label for="Name" class="form-label">
                        <b>
                            <label class="text-danger">* </label>
                            Họ tên 姓名</b></label>
                    <asp:TextBox ID="Name" runat="server" MaxLength="20" CssClass="form-control" AutoPostBack="true" OnTextChanged="Name_ID_TextChanged" Enabled="false" />
                </div>
                <!-- Đơn vị -->
                <div class="col-md-4">
                    <label for="Name_DepID" class="form-label"><b>Đơn vị 部門</b></label>
                    <div class="input-group">
                        <asp:TextBox ID="Name_DepID" runat="server" MaxLength="50" CssClass="form-control" Enabled="false" />
                        <span class="input-group-text">
                            <asp:ImageButton ID="SearchDep" runat="server" ImageUrl="../General/Images/select.png" OnClick="SearchDep_Click" CssClass="btn btn-outline-secondary" />
                        </span>
                    </div>
                </div>
            </div>

            <div class="row mb-3">
                <!-- Số thẻ người thay thế -->
                <div class="col-md-4">
                    <label for="Agent_ID" class="form-label">
                        <b>
                            <label class="text-danger">* </label>
                            Số thẻ người thay thế 工號</b>
                    </label>
                    <asp:TextBox ID="Agent_ID" runat="server" MaxLength="20" AutoPostBack="true" OnTextChanged="Agent_ID_TextChanged" CssClass="form-control" />
                </div>

                <!-- Họ tên người thay thế -->
                <div class="col-md-4">
                    <label for="Agent" class="form-label">
                        <b>
                            <label class="text-danger">* </label>
                            Họ tên người thay thế 職務代理人</b>
                    </label>
                    <asp:TextBox ID="Agent" runat="server" MaxLength="50" Enabled="false" CssClass="form-control" />
                </div>

                <!-- Tài liệu kèm theo -->
                <div class="col-md-4">
                    <label for="documents" class="form-label">
                        <b>Tài liệu kèm theo 檢附有關文件</b>
                    </label>
                    <asp:TextBox ID="documents" runat="server" MaxLength="20" AutoPostBack="true" CssClass="form-control" />
                </div>
            </div>

            <!-- Lý do đi -->
            <div class="row mb-4">
                <label for="Purpose" class="form-label">
                    <b>
                        <label class="text-danger">* </label>
                        Lý do đi 事由</b></label>
                <asp:TextBox ID="Purpose" runat="server" CssClass="form-control" Enabled="false" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
            </div>

            <div class="row mb-4">
                <label for="FLocation" class="form-label">
                    <b>
                        <label class="text-danger">* </label>
                        Địa điểm công tác 地點
                    </b>
                </label>
                <asp:TextBox ID="FLocation" runat="server" Enabled="false" TextMode="MultiLine" CssClass="form-control" Rows="4" MaxLength="500"></asp:TextBox>
            </div>

            <div class="row mb-4">
                <div class="col-md-3">
                    <b>
                        <label class="text-danger">* </label>
                        Thời gian đi 時間</b>
                    <asp:TextBox ID="Time" runat="server" TextMode="DateTime" CssClass="form-control" AutoPostBack="true" OnTextChanged="Time_TextChanged"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <b>
                        <label class="text-danger">* </label>
                        Giờ đi 出發時間</b>
                    <asp:TextBox ID="STime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <b>
                        <label class="text-danger">* </label>
                        Giờ về 回程時間</b>
                    <asp:TextBox ID="ETime" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <b>Ngày đi 天數</b>
                    <asp:TextBox ID="Days" runat="server" ReadOnly="true" CssClass="form-control" Text="1"></asp:TextBox>
                </div>
            </div>

            <div class="row mb-4">
                <label for="Journey" class="form-label">
                    <b>
                        <label class="text-danger">* </label>
                        Hành trình 行程
                    </b>
                </label>
                <asp:TextBox ID="Journey" runat="server" Enabled="false" TextMode="MultiLine" CssClass="form-control" Rows="4" MaxLength="500"></asp:TextBox>
            </div>

            <div class="row mb-3">
                <!-- Phương tiện di chuyển -->
                <div class="col-md-6">
                    <label for="TransportType" class="form-label">
                        <b>
                            <label class="text-danger">* </label>
                            Đi bằng phương tiện 擬乘交 通工具</b></label>
                    <asp:DropDownList ID="TransportType" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="TransportTypeSelect">
                        <asp:ListItem Text="---please select---" Value=""></asp:ListItem>
                        <asp:ListItem Text="Xe hơi 汽車" Value="Xe hơi"></asp:ListItem>
                        <asp:ListItem Text="Máy bay 飛機" Value="Máy bay"></asp:ListItem>
                        <asp:ListItem Text="Thuyền 船舶" Value="Thuyền"></asp:ListItem>
                        <asp:ListItem Text="Xe buýt 公車" Value="Xe buýt"></asp:ListItem>
                        <asp:ListItem Text="Phương tiện khác 其他" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <!-- Phương tiện khác -->
                <div class="col-md-6">
                    <label for="ptkhac" class="form-label"><b>Mô tả phương tiện khác 其他</b></label>
                    <asp:TextBox ID="ptkhac" runat="server" CssClass="form-control" MaxLength="20" AutoPostBack="true" Enabled="false" />
                </div>
            </div>

            <!-- Xe công ty -->
            <div class="row mb-3">
                <label for="ApplyCar" class="form-label"><b>Xe công ty 公司派車</b></label>
                <asp:CheckBox ID="ApplyCar" runat="server" CssClass="form-check-box" />
            </div>

            <!-- Ghi chú nếu đi máy bay hoặc thuyền -->
            <div class="row mb-3">
                <label for="Remark" class="form-label"><b>Ghi rõ nguyên nhân đi máy bay, thuyền</b></label>
                <asp:TextBox ID="Remark" runat="server" CssClass="form-control" Enabled="false" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
            </div>
        </div>

        <script type="text/javascript">
            function pageLoad() {
                flatpickr('#<%= Time.ClientID %>', {
                    dateFormat: "Y-m-d"
                });
                flatpickr('#<%= STime.ClientID %>', {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                    time_24hr: true
                });

                flatpickr('#<%= ETime.ClientID %>', {
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
