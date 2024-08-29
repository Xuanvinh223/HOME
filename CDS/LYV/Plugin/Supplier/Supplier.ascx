<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Supplier.ascx.cs" Inherits="WKF_Supplier" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>
<head>
    <style>
        :root {
            --sky-primary: #95B8E7;
        }

        .form-tick-input[type=radio] {
            border-color: var(--sky-primary);
        }

        .textbox {
            margin-top: 5px;
        }

        .form-input {
            padding: 2px !important;
            width: 100% !important;
            border-radius: 2px;
            outline: none;
        }

        .textbox {
            border-color: black;
        }

        .form-tick-input[type=radio] {
            border-color: var(--sky-primary);
        }

        .form-item {
            display: flex;
            align-items: center;
            width: 100%;
            margin-bottom: 20px;
        }

            .form-item .form-item-head {
                flex: 1;
            }

            .form-item input, select, textarea {
                flex: 5;
            }

        input[type=checkbox] {
            width: 20px;
            height: 20px;
        }

        input[type=radio] {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }

        .mb-5 {
            margin-bottom: 5px;
        }
    </style>
</head>

<asp:Panel ID="panel1" runat="server" Style="display: flex; justify-content: flex-start; align-items: center;">
    <asp:Panel ID="pPrint" Visible="false" runat="server" DefaultButton="btnPrint" CssClass="btnFunc" Style="display: flex; flex-direction: column; align-items: center; justify-content: center; border: 1px solid gray; width: 50px; height: 40px; padding: 3px; margin-right: 10px;">
        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_Click" Style="width: 15px; height: 20px;" />
        <asp:Label ID="lbPrint" runat="server" Text="Print" AssociatedControlID="btnPrint" />
    </asp:Panel>
</asp:Panel>
<asp:HiddenField ID="hfLYV" runat="server" />
<asp:HiddenField ID="hfTASKID" runat="server" />
<asp:HiddenField ID="hfTASK_RESULT" runat="server" />

<div>
    <div class="form-item ">
        <b class="form-item-head">Loại｜公司類型</b>
        <asp:DropDownList
            ID="Type" runat="server">
            <asp:ListItem Style="width: 70%;" Text="---Vui lòng chọn｜請選擇---" Value="default" Selected="True" />
            <asp:ListItem Text="量產供應商" Value="量產供應商" />
            <asp:ListItem Text="總務供應商" Value="總務供應商" />
            <asp:ListItem Text="原物料供應商" Value="原物料供應商" />
            <asp:ListItem Text="工具供应商" Value="工具供应商" />
        </asp:DropDownList>
    </div>
    <div class="form-item">
        <b class="form-item-head">Mã số công ty｜公司代號	</b>
        <asp:TextBox ID="SupplierID" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Tên công ty｜公司名稱</b>
        <asp:TextBox ID="SupplierName" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Địa chỉ công ty｜公司地址</b>

        <asp:TextBox ID="CompanyAddress" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Địa chỉ nhà máy｜工廠地址	</b>

        <asp:TextBox ID="FactoryAddress" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Sản phẩm chủ yếu｜主要產品	</b>
        <asp:TextBox ID="Product" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Thời gian thành lập｜創業時間		</b>

        <asp:TextBox ID="Established" type="date" CssClass="textbox form-input" runat="server"></asp:TextBox>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Giấy đăng ký kinh doanh｜營業執照	</b>

        <asp:TextBox ID="License" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Người phụ trách｜負責人	</b>

        <asp:TextBox ID="PersonInCharge" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Người liên lạc｜連絡人	</b>

        <asp:TextBox ID="ContactPerson" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div>
        <div class="form-item">
            <b class="form-item-head">Điện thoại｜電話</b>

            <asp:TextBox ID="Tel" runat="server" CssClass="textbox form-input"></asp:TextBox>
        </div>
        <div class="form-item">
            <b class="form-item-head">Fax｜傳真</b>
            <asp:TextBox ID="Fax" runat="server" CssClass="textbox form-input"></asp:TextBox>
        </div>
    </div>
    <div class="form-item ">
        <b class="form-item-head">E-mail｜電子信箱	</b>

        <asp:TextBox ID="Email" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
    <div>
        <div class="mb-5">
            <asp:CheckBox ID="Designated" runat="server" />
            <span>Nhà cung ứng do khách hàng chỉ định 被客戶指定的供應商</span>
        </div>
        <div class=" form-tick mb-5">
            <div style="margin-bottom: 5px;">
                <asp:CheckBox ID="Cooperated" CssClass="isOldSup" runat="server" />
                <span>Nhà cung ứng cũ 舊供應商</span>
            </div>
            <div style="margin-left: 20px; margin-bottom: 10px;">
                <h5>1. Tình hình chất lượng và khả năng sản xuất trước đây 以往產製能力及品質狀況
                </h5>
                <div>
                    <asp:RadioButtonList ID="C_Qualified" runat="server">
                        <asp:ListItem Text="Đạt 合格" Value="1" />
                        <asp:ListItem Text="Không đạt 不合格" Value="0" />
                    </asp:RadioButtonList>
                </div>
                <div>
                </div>
            </div>
        </div>
        <div class="form-tick mb-5">
            <div style="margin-bottom: 5px;">
                <asp:CheckBox ID="New" CssClass="isNewSup" runat="server" />
                <span>Nhà cung ứng mới 新供應商</span>
            </div>
            <div style="margin-left: 20px; margin-bottom: 10px">
                <h5>1. Có cung cấp bằng chứng để chứng minh khả năng nhận thầu của máy móc thiết bị hiện có hoặc/ và Đã cung cấp hàng mẫu và được QC kiểm nghiệm đạt theo bản vẽ hoặc mẫu chuẩn, có lưu hồ sơ
有提供所擁有機械設備承包能力之合格証明檔或/及已提供樣品及經品管依圖面或標準樣品合格且有記錄者
                </h5>
                <div>
                    <asp:RadioButtonList ID="N_Qualified" runat="server">
                        <asp:ListItem Text="Đạt 合格" Value="1" />
                        <asp:ListItem Text="Không đạt 不合格" Value="0" />
                    </asp:RadioButtonList>
                </div>
            </div>
            <div style="margin-left: 20px; margin-bottom: 10px">
                <h5>2. Giá cả 價格
                </h5>
                <div>
                    <asp:RadioButtonList ID="Price" runat="server">
                        <asp:ListItem Text="Đạt 合格，Giá bán 售價 ≦ giá thị trường 市價" Value="1" />
                        <asp:ListItem Text="Không đạt 不合格，Giá bán 售價 > giá thị trường 市價" Value="0" />
                    </asp:RadioButtonList>
                </div>
            </div>
            <div style="margin-left: 20px; margin-bottom: 10px">
                <h5>3. Hiệu quả năng lượng có đạt hay không 能源是否有效果
                </h5>
                <div>
                    <asp:RadioButtonList ID="Effective" runat="server">
                        <asp:ListItem Text="Đạt 合格" Value="1" />
                        <asp:ListItem Text="Không đạt 不合格" Value="0" />
                    </asp:RadioButtonList>
                </div>
            </div>
        </div>
    </div>
    <div class="form-item ">
        <b class="form-item-head">Ý kiến đánh giá  ｜評估意見說明	</b>
        <asp:TextBox ID="Remark" TextMode="MultiLine" Rows="3" runat="server" CssClass="textbox form-input"></asp:TextBox>
    </div>
</div>
<asp:Label ID="lblHasNoAuthority" runat="server" Text="無填寫權限" ForeColor="Red" Visible="False" meta:resourcekey="lblHasNoAuthorityResource1"></asp:Label>
<asp:Label ID="lblToolTipMsg" runat="server" Text="不允許修改(唯讀)" Visible="False" meta:resourcekey="lblToolTipMsgResource1"></asp:Label>
<asp:Label ID="lblModifier" runat="server" Visible="False" meta:resourcekey="lblModifierResource1"></asp:Label>
<asp:Label ID="lblMsgSigner" runat="server" Text="填寫者" Visible="False" meta:resourcekey="lblMsgSignerResource1"></asp:Label>
<asp:Label ID="lblAuthorityMsg" runat="server" Text="具填寫權限人員" Visible="False" meta:resourcekey="lblAuthorityMsgResource1"></asp:Label>


<script type="text/javascript">
    document.querySelector(".isNewSup").addEventListener("change", (e) => {
        if (e.target.checked) {
            e.target.closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item, index) => {
                if (item.defaultValue == "1" && index < 4) {
                    item.checked = true;
                }
            })
            document.querySelector(".isOldSup input").checked = !e.target.checked;
            document.querySelector(".isOldSup").closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item) => {
                item.checked = false;
            })
        } else {
            e.target.closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item) => {
                item.checked = false;
            })
        }
    })
    document.querySelector(".isOldSup").addEventListener("change", (e) => {
        if (e.target.checked) {
            e.target.closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item) => {
                if (item.defaultValue == "1") {
                    item.checked = true;
                }
            })
            document.querySelector(".isNewSup input").checked = !e.target.checked;

            document.querySelector(".isNewSup").closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item) => {
                item.checked = false;
            })
        } else {
            e.target.closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item) => {
                item.checked = false;
            })
        }
    })
    document.querySelector(".isOldSup").closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item) => {
        item.addEventListener("change", (e) => {

            document.querySelector(".isOldSup input").checked = true;

            document.querySelector(".isNewSup input").checked = false

            document.querySelector(".isNewSup").closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item) => {
                item.checked = false;
            })
        })
    })
    document.querySelector(".isNewSup").closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item, index) => {

        item.addEventListener("change", (e) => {

            document.querySelector(".isNewSup input").checked = true;

            document.querySelector(".isOldSup input").checked = false

            document.querySelector(".isOldSup").closest(".form-tick").querySelectorAll("input[type='radio']").forEach((item) => {
                item.checked = false;
            })
        })
    })
</script>
