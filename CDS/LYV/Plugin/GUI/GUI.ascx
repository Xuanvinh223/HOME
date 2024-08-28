﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GUI.ascx.cs" Inherits="WKF_BusinessTrip_Form" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>
<link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/BusinessTrip/style.css" type="text/css" rel="stylesheet" />
<link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
<script src="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<style>
    .bg{
        color: red;
    }
    </style>

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
    <ContentTemplate>
        <asp:Panel ID="panel1" runat="server" CssClass="panel1">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="Print" CssClass="btnFunc" Visible="false">
                <asp:ImageButton ID="Print" runat="server" ImageUrl="../General/Images/print.png" />
                <asp:Label ID="lbPrint" runat="server" Text="Print" AssociatedControlID="Print" />
            </asp:Panel>
            <asp:HiddenField ID="hfLYV" runat="server" />
            <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        </asp:Panel>
        <form class="form-horizontal">
            <div class="container ">
                <div class="row mb-3">
                    <!-- Số thẻ -->
                    <div class="col-md-4">
                        <label for="Name_ID" class="form-label"><b>
                            <label class="text-danger">* </label>
                            Số thẻ 工號</b></label>
                        <asp:TextBox ID="Name_ID" runat="server" MaxLength="20" CssClass="form-control" AutoPostBack="true" />
                    </div>

                    <!-- Họ tên -->
                    <div class="col-md-4">
                        <label for="Name" class="form-label"><b>Họ tên 姓名</b></label>
                        <asp:TextBox ID="Name" runat="server" MaxLength="50" CssClass="form-control" Enabled="false" />
                    </div>

                    <!-- Đơn vị -->
                    <div class="col-md-4">
                        <label for="Name_DepID" class="form-label"><b>Đơn vị 部門 </b></label>
                        <div class="input-group">
                            <asp:TextBox ID="Name_DepID" runat="server" MaxLength="50" CssClass="form-control" Enabled="false" />
                            <span class="input-group-text">
                                <asp:ImageButton ID="SearchDep" runat="server" ImageUrl="../General/Images/select.png"  CssClass="btn btn-outline-secondary" />
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row mb-3">

                    <!-- Số thẻ người thay thế -->
                    <div class="col-md-4">
                        <label for="Agent_ID" class="form-label"><b>
                            <label class="text-danger">* </label>
                            Số thẻ người thay thế 工號</b></label>
                        <asp:TextBox ID="Agent_ID" runat="server" MaxLength="20" CssClass="form-control" AutoPostBack="true"/>
                    </div>

                    <!-- Họ tên người thay thế -->
                    <div class="col-md-4">
                        <label for="Agent" class="form-label"><b>Họ tên người thay thế 職務代理人</b></label>
                        <asp:TextBox ID="Agent" runat="server" MaxLength="50" CssClass="form-control" Enabled="false" />
                    </div>

                    <!-- Tài liệu kèm theo -->
                    <div class="col-md-4">
                        <label for="documents" class="form-label"><b>Tài liệu kèm theo 檢附有關文件</b></label>
                        <asp:TextBox ID="documents" runat="server" MaxLength="20" CssClass="form-control" AutoPostBack="true" />
                    </div>
                </div>

                <!-- Lý do đi -->
                <div class="row mb-4">
                    <label for="Purpose" class="form-label"><b>
                        <label class="text-danger">* </label>
                        Lý do đi 出差事由</b></label>
                    <asp:TextBox ID="Purpose" runat="server" CssClass="form-control" Enabled="false" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
                </div>

                <!-- Địa điểm công tác -->
                <div class="row mb-4">
                    <label for="FLocation" class="form-label"><b>
                        <label class="text-danger">* </label>
                        Địa điểm công tác 出差地點</b></label>
                    <asp:TextBox ID="FLocation" runat="server" CssClass="form-control" Enabled="false" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
                </div>

                <!-- Thời gian bắt đầu và kết thúc -->
                <div class="row mb-4">
                    <!-- Thời gian bắt đầu -->
                    <div class="col-md-4">
                        <label for="BTime" class="form-label"><b>
                            <label class="text-danger">* </label>
                            Bắt đầu 自</b></label>
                        <asp:TextBox ID="BTime" runat="server" CssClass="form-control" TextMode="DateTime" AutoPostBack="true" />
                    </div>

                    <!-- Thời gian kết thúc -->
                    <div class="col-md-4">
                        <label for="ETime" class="form-label"><b>
                            <label class="text-danger">* </label>
                            Kết thúc 至</b></label>
                        <asp:TextBox ID="ETime" runat="server" CssClass="form-control" TextMode="DateTime" AutoPostBack="true" />
                    </div>

                    <!-- Số ngày -->
                    <div class="col-md-4">
                        <label for="Days" class="form-label"><b>Số ngày 共</b></label>
                        <asp:TextBox ID="Days" runat="server" CssClass="form-control" Text="1" ReadOnly="true" />
                    </div>
                </div>

                <!-- Hành trình -->
                <div class="row mb-4">
                    <label for="Journey" class="form-label"><b>
                        <label class="text-danger">* </label>
                        Hành trình 行程</b></label>
                    <asp:TextBox ID="Journey" runat="server" CssClass="form-control" Enabled="false" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
                </div>

                <div class="row mb-3">
                    <!-- Phương tiện di chuyển -->
                    <div class="col-md-6">
                        <label for="TransportType" class="form-label"><b>
                            <label class="text-danger">* </label>
                            Đi bằng phương tiện 擬乘交通工具</b></label>
                        <asp:DropDownList ID="TransportType" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="TransportTypeSelect">
                            <asp:ListItem Text="---please select---" Value=""></asp:ListItem>
                            <asp:ListItem Text="Xe hơi 汽車" Value="Xe hơi"></asp:ListItem>
                            <asp:ListItem Text="Máy bay 飛機" Value="Máy bay"></asp:ListItem>
                            <asp:ListItem Text="Thuyền 船舶" Value="Thuyền"></asp:ListItem>
                            <asp:ListItem Text="Xe buýt 公車" Value="Xe buýt"></asp:ListItem>
                            <asp:ListItem Text="Phương tiện khác" Value="5"></asp:ListItem>
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
                    <label for="Remark" class="form-label"><b>Ghi rõ nguyên nhân đi máy bay, thuyền 搭乘飛機 、船舶原因請詳細詿明</b></label>
                    <asp:TextBox ID="Remark" runat="server" CssClass="form-control" Enabled="false" TextMode="MultiLine" Rows="3" MaxLength="500"></asp:TextBox>
                </div>
            </div>
        </form>
        <script type="text/javascript">
            function pageLoad() {
                flatpickr('#<%= BTime.ClientID %>', {
                    dateFormat: "H:i d-m-Y", // "H" là để hiển thị giờ và "i" là để hiển thị phút
                    enableTime: true, // Bật chế độ hiển thị giờ và phút
                    time_24hr: true,
                    onChange: function (rawdate, altdate, FPOBJ) {
                        FPOBJ.close();
                    }
                });

                flatpickr('#<%= ETime.ClientID %>', {
                    dateFormat: "H:i d-m-Y", // "H" là để hiển thị giờ và "i" là để hiển thị phút
                    enableTime: true, // Bật chế độ hiển thị giờ và phút
                    time_24hr: true,
                    onChange: function (rawdate, altdate, FPOBJ) {
                        FPOBJ.close();
                    }
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
