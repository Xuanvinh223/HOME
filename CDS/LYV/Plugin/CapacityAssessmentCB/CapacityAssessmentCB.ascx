<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CapacityAssessmentCB.ascx.cs" Inherits="WKF_CapacityAssessmentCB" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>


<link href="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.css" type="text/css" rel="stylesheet" />
<script src="<%=Request.ApplicationPath %>/CDS/LYV/Plugin/General/css/node_modules/flatpickr/dist/flatpickr.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <style type="text/css">
            .FormQuery {
                border: 1px solid #ddd;
            }

                .FormQuery th {
                    border-left: 1px solid #ddd;
                }

                .FormQuery td, .FormQuery th {
                    padding: 5px;
                    color: #2461BF;
                    vertical-align: middle;
                }

            .tbDG {
                border-collapse: collapse;
            }

                .tbDG th, .tbDG td {
                    vertical-align: middle;
                    border: 1px solid #dddddd;
                    padding: 5px;
                    color: black;
                }

            .radio {
                width: 100%;
                text-align: left;
            }

                .radio th, .radio td {
                    width: 20%;
                    vertical-align: top;
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

            .bg-red {
                background-color: red;
            }
        </style>

        <asp:Panel ID="panel1" runat="server" CssClass="panel1">
            <asp:Panel ID="pPrint" runat="server" DefaultButton="Print" CssClass="btnFunc" Visible="false">
                <asp:ImageButton ID="Print" runat="server" ImageUrl="../General/Images/print.png" OnClick="Print_Click" />
                <asp:Label ID="lbPrint" runat="server" Text="Print" AssociatedControlID="Print" />
            </asp:Panel>
            <asp:HiddenField ID="hfCNO" runat="server" />
            <asp:HiddenField ID="hfTASK_RESULT" runat="server" />
        </asp:Panel>
        <table style="width: 100%">
            <tr>
                <td>
                    <b>SỐ THẺ｜工號: </b>
                    <asp:TextBox ID="ID" runat="server" AutoPostBack="true" OnTextChanged="ID_TextChanged"></asp:TextBox>
                  

                </td>
                <td>
                    <b>HỌ VÀ TÊN｜姓名: </b>
                    <asp:TextBox ID="Name" runat="server" Width="50%" Enabled="false"></asp:TextBox>
                </td>
                <td>
                    <b>ĐƠN VỊ｜單位: </b>
                    <asp:TextBox ID="Dep" runat="server" Width="50%" Enabled="false"></asp:TextBox>
                </td>
            </tr>
        </table>
        <asp:Panel ID="pnDG" runat="server">
            <table style="width: 100%; margin-top: 5vh" class="tbDG">
                <tr>
                    <th colspan="2" style="width: 60%;"><b>Hạng mục và nội dung đánh giá </br>專項及考核內容</b></th>
                    <th style="width: 5%;"" ><b>Điểm tiêu chuẩn </br>標準分 </b></th>
                    <th ><b>Đánh giá 1 </br> 評核1 </b></th>
                    <th><b>Đánh giá 2 </br> 評核2</b></th>
                    <th><b>Điểm bình quân </br> 平均分</b></th>
                </tr>
                <tr>
                    <th rowspan="5" style="width: 30%;">
                        <b>Năng lực giải quyết vấn đề 15%</br>
                           解決問題的能力15%
                        </b>
                    </th>
                    <td>
                        <b>Gặp phải vấn đề chủ động suy nghĩ, tận dụng kiến thức hoặc thu thập các tài liệu trong quá trình làm để so sánh, phân tích, nhanh chóng và dứt khoát giải quyết vấn đề một cách chính xác.</br>
                           遇到問題能主動思考，利用其知識或運用所收集之資料做比較分析，迅速正確而果斷解決問題.
                        </b>
                    </td>
                    <td>
                        <b>12～15</br>分điểm</b>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox  Width="100%" TextMode="Number" Height="50" ID="GQ1" runat="server" AutoPostBack="true" OnTextChanged="GQ_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="GQ2" runat="server" AutoPostBack="true" OnTextChanged="GQ_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Enabled="false" Width="100%" Height="50" MaxLength="500" ID="GQ3" runat="server" Text=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Gặp phải vấn đề chủ động suy nghĩ, phần lớn có thể giải quyết vấn đề và đưa ra quyết định chính xác.</br>
                            遇到問題能主動思考,絕大多數能正確決策及解決問題.
                        </b>
                    </td>
                    <td>
                        <b>9～12</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Gặp phải vấn đề vẫn cố gắng suy nghĩ và tìm ra phương pháp giải quyết, có thể ra quyết định thực hiện, miễn cưỡng giải quyết vấn đề.</br>
                            遇到問題尚能努力思考並尋求解決方案,都能下決定執行,勉強解決問題.
                        </b>
                    </td>
                    <td>
                        <b>6～9</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Gặp phải vấn đề thiếu sự chủ động suy nghĩ, đối với việc giải quyết vấn đề là khó khăn.</br>
                            遇到問題,欠缺主動思考,對問題的解決會有困難
                        </b>
                    </td>
                    <td>
                        <b>3～6</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Gặp phải vấn đề, không thể chủ động suy nghĩ, không có năng lực tìm ra cách giải quyết.</br>
                            遇到問題,不能主動思考,無尋求解決方案的能力,
                        </b>
                    </td>
                    <td>
                        <b>0～3</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <th rowspan="5">
                        <b>Năng lực sáng tạo và học hỏi 15%.</br>
                            創新與學習能力15%
                        </b>
                    </th>
                    <td>
                        <b>Can đảm đưa ra ý tưởng mới mang tính đột phá để thay đổi hiện trạng, đồng thời mang lại kết quả vượt trội.</br>
                            勇於自我突破且能以新的構想來改變現狀成效卓著.
                        </b>
                    </td>
                    <td>
                        <b>12～15</br>分điểm</b>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="ST1" runat="server"  AutoPostBack="true" OnTextChanged="GQ_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50"  ID="ST2" runat="server"  AutoPostBack="true" OnTextChanged="GQ_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Enabled="false" Width="100%" Height="50" MaxLength="500" ID="ST3" runat="server" Text=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Đưa ra ý tưởng mới để cải thiện công hiện hiệ tại và có được hiệu quả.</br>
                            提出新的構想來改善現行工作且有成效。
                        </b>
                    </td>
                    <td>
                        <b>9～12</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Thỉnh thoảng đưa ra ý tưởng mới để cải thiện công việc hiện tại. </br>
                            偶爾提出新的構想來改善現行工作。
                        </b>
                    </td>
                    <td>
                        <b>6～9</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Tư tưởng bảo thủ, không thể tự cải thiện bản thân để thích ứng với yêu cầu của thời thế.</br>
                            墨守成規,無法因時勢所需自我突破，做必要之改善.
                        </b>
                    </td>
                    <td>
                        <b>3～6</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Không có ý tưởng mới, phương án mới, ngược lại chống lại sự thay đổi công việc hiện tại.</br>
                            沒有新的構想、新方案，反而對現狀工作抗拒改變
                        </b>
                    </td>
                    <td>
                        <b>0～3</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <th rowspan="5">
                        <b>Kỹ năng giao tiếp 15%.</br>
                            溝通與協調15%
                        </b>
                    </th>
                    <td>
                        <b>Giỏi về kỹ năng giao tiếp và phối hợp, đồng thời nhận được sự phối hợp nhiệt tình của đối phương, tạo bầu không khí hài hòa trong công việc.</br> 
                            溝通協調能力強,並能取得對方的充分配合，形成和諧的工作氣氛
                        </b>
                    </td>
                    <td>
                        <b>12～15</br>分điểm</b>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="GT1" runat="server" AutoPostBack="true" OnTextChanged="GQ_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50"  ID="GT2" runat="server" AutoPostBack="true" OnTextChanged="GQ_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Enabled="false" Width="100%" Height="50" MaxLength="500" ID="GT3" runat="server" Text=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Kỹ năng giao tiếp và phối hợp tốt, để đối phương hiểu rõ vấn đề, tự nguyện phối hợp và tạo bầu không khí hài hòa trong công việc.</br>
                            溝通協調能力強,能讓對方清楚狀況,願意配合,氣氛和諧.
                        </b>
                    </td>
                    <td>
                        <b>9～12</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Chưa giỏi về kỹ năng giao tiếp và phối hợp, dẫn đến, dẫn đến  mức độ phối hợp kém, thỉnh thoảng có va chạm nhỏ, không khí làm việc không được hài hòa.</br>
                            溝通協調能力尚且不足，致對方配合程度差，偶有小摩擦，氣氛尚和諧.
                        </b>
                    </td>
                    <td>
                        <b>6～9</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Chưa giỏi về kỹ năng giao tiếp và phối hợp, làm cho mức độ phối hợp của hai bên chưa tốt.</br>
                            溝通協調能力不足，使雙方配合度不足.
                        </b>
                    </td>
                    <td>
                        <b>3～6</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Kỹ năng giao tiếp và phối hợp kém, làm cho mức độ phối hợp của hai bên không tốt, không khí làm việc không được hài hòa.</br>
                            溝通協調能力差，使雙方的配合度差，工作氣氛不和諧.
                        </b>
                    </td>
                    <td>
                        <b>0～3</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <th rowspan="5">
                        <b>Thái độ hợp tác 20%</br>
                            被管理能力20%
                        </b>
                    </th>
                    <td>
                        <b>Chấp hành tốt với sự quản lý của cấp trên, đồng thời tương tác tốt với cấp trên, bổ sung cho nhau những ưu và khuyết điểm, thái độ tiếp nhận được cấp trên ghi nhận.</br>
                            非常好地服從管理,並與上級有良好互動,優勢互補,被管理的態度得到上級充分認同.
                        </b>
                    </td>
                    <td>
                        <b>16～20</br>
                           分điểm</b>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="HT1" runat="server" AutoPostBack="true" OnTextChanged="HT_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="HT2" runat="server" AutoPostBack="true" OnTextChanged="HT_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Enabled="false" Width="100%" Height="50" MaxLength="500" ID="HT3" runat="server" Text=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Có thể chấp hành với sự quản lý của cấp trên, biểu đạt ý kiến chính xác và có lễ phép, đồng thời tôn trọng cấp trên.</br>
                            能很好服從管理,有禮正確表達意見,並尊重上級.
                        </b>
                    </td>
                    <td>
                        <b>12～16</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Cho dù có ý kiến cá nhân cũng có thể phối hợp hiệu quả sự quản lý của cấp trên.</br> 
                            即使有個人意見,也能有效服從管理,但會心存抱怨.
                        </b>
                    </td>
                    <td>
                        <b>8～10</br>
                         分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Có thể miễn cưỡng tuân theo cấp trên, thỉnh thoảng cũng vô lễ và tranh luận với cấp trên.</br>
                            能勉強服從上級管理,偶爾也會與上級無禮爭辯.
                        </b>
                    </td>
                    <td>
                        <b>4～8</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Tự cho mình là đúng, trong công việc thường hay vô lễ với cấp trên.</br>
                            自以為是,工作中經常無禮頂撞上級.
                        </b>
                    </td>
                    <td>
                        <b>0～4</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <th rowspan="5">
                        <b>Kỹ năng công việc 10%.</br>
                            工作技能10%
                        </b>
                    </th>
                    <td>
                        <b>Kỹ năng chuyên môn rất phong phú, có thể hoàn thành tốt trách nhiệm của bản thân.</br>
                            具有極豐富的專業技能，能充分完成本身職責.
                        </b>
                    </td>
                    <td>
                        <b>8～10</br>
                           分điểm</b>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="CV1" runat="server" AutoPostBack="true" OnTextChanged="CV_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="CV2" runat="server" AutoPostBack="true" OnTextChanged="CV_TextChanged" ></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Enabled="false" Width="100%" Height="50" MaxLength="500" ID="CV3" runat="server" Text=""></asp:TextBox>
 
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Kỹ năng chuyên môn tương đối tốt, đủ để giải quyết công việc của bản thân.</br>
                            有相當的專業技能，足以應付本身工作.
                        </b>
                    </td>
                    <td>
                        <b>6～8</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Kỹ năng chuyên môn bình thường, nhưng không có trở ngại đối với việc hoàn thành nhiệm vụ.</br> 
                            專業技能一般，但對完成任務尚無障礙.
                        </b>
                    </td>
                    <td>
                        <b>4～6</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Mức độ về kỹ năng chuyên môn chưa đủ, thường hay hỏi người khác khi thực hiện nhiệm vụ.</br>
                            技能程度稍感不足，執行職務常需請教他人.
                        </b>
                    </td>
                    <td>
                        <b>2～4</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Đối với những công việc cần có kỹ năng chuyên môn nhưng lại không biết, khó khăn khi hoàn thành công việc hàng ngày.</br>
                            對工作必需技能不熟悉，日常工作難以完成.
                        </b>
                    </td>
                    <td>
                        <b>0～2</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <th rowspan="5">
                        <b>Trách nhiệm 15%.</br>
                           責任心15%
                        </b>
                    </th>
                    <td>
                        <b>Tuân thủ theo các nguyên tắc về an toàn lao động</br>
                            遵守勞動安全原則
                        </b>
                    </td>
                    <td>
                        <b>12～15</br>
                           分điểm</b>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox  Width="100%" TextMode="Number" Height="50" ID="TN1" runat="server" AutoPostBack="true" OnTextChanged="GQ_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="TN2" runat="server" AutoPostBack="true" OnTextChanged="GQ_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Enabled="false" Width="100%" Height="50" MaxLength="500" ID="TN3" runat="server" Text=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Cố gắng trong công việc, hoàn thành khá tốt công việc được giao.</br>
                            工作努力，能較好完成分內工作.
                        </b>
                    </td>
                    <td>
                        <b>9～12</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Có tinh thần trách nhiệm, có thể chủ động làm việc.</br>
                            有責任心，能自動自發.
                        </b>
                    </td>
                    <td>
                        <b>6～9</br>分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Công việc được giao cần có người đôn đốc mới hoàn thành.</br>
                            交付工作需要督促方能完成
                        </b>
                    </td>
                    <td>
                        <b>3～6</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Làm qua loa, thái độ ngạo mạn, không có trách nhiệm, làm việc bất cẩn.</br>
                            敷衍了事,態度傲慢，無責任心，做事粗心大意
                        </b>
                    </td>
                    <td>
                        <b>0～3</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <th rowspan="5">
                        <b>Ý thức về chi phí 10%</br>
                            成本意識10%
                        </b>
                    </th>
                    <td>
                        <b>Ý thức cao về chi phí, tích cực tiết kiệm, phòng ngừa lãng phí.</br>
                            成本意識強烈，能積極節省，避免浪費
                        </b>
                    </td>
                    <td>
                        <b>8～10</br>
                           分điểm</b>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox  Width="100%" TextMode="Number" Height="50" ID="CP1" runat="server" AutoPostBack="true" OnTextChanged="CV_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Width="100%" TextMode="Number" Height="50" ID="CP2" runat="server" AutoPostBack="true" OnTextChanged="CV_TextChanged"></asp:TextBox>
                    </td>
                    <td rowspan="5">
                        <asp:TextBox Enabled="false" Width="100%" Height="50" MaxLength="500" ID="CP3" runat="server" Text=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Rất có ý thức về chi phí và có thể tiết kiệm.</br>
                            具備成本意識，並能節約
                        </b>
                    </td>
                    <td>
                        <b>6～8</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Có ý thức về chi phí, có thể tiết kiệm.</br>
                            尚有成本意識，尚能節約
                        </b>
                    </td>
                    <td>
                        <b>4～6</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Thiếu ý thức về chi phí, lãng phí.</br>
                            缺乏成本意識，梢有浪費
                        </b>
                    </td>
                    <td>
                        <b>2～4</br>
                           分điểm</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Không có ý thức về chi phí, thường hay lãng phí.</br>
                            無成本意識，經常浪費
                        </b>
                    </td>
                    <td>
                        <b>0～2</br>
                           分điểm</b>
                    </td>
                </tr>

                <tr style="height:100px;">
                    <th colspan="2" ></th>
                    <td>
                        <b>Tổng điểm</br>
                            總得分</b>
                    </td>
                    <td><asp:Label ID="TC1" runat="server" Text="0"></asp:Label></td>
                    <td><asp:Label ID="TC2" runat="server" Text="0"></asp:Label></td>
                    <td><asp:Label ID="TC3" runat="server" Text="0"></asp:Label></td>    
                </tr>
            </table>
        </asp:Panel>

        <script>
            function showMessage(message) {
                toastr.error(message, 'Lỗi', {
                    timeOut: 3000, // Hiển thị trong 5 giây
                    extendedTimeOut: 3000, // Thêm 3 giây nếu di chuột qua
                    closeButton: true, // Hiển thị nút đóng
                    progressBar: true
                });
                //success, warning, info, error
            }
         </script>
        <asp:Label ID="lblHasNoAuthority" runat="server" Text="無填寫權限" ForeColor="Red" Visible="False" meta:resourcekey="lblHasNoAuthorityResource1"></asp:Label>
        <asp:Label ID="lblToolTipMsg" runat="server" Text="不允許修改(唯讀)" Visible="False" meta:resourcekey="lblToolTipMsgResource1"></asp:Label>
        <asp:Label ID="lblModifier" runat="server" Visible="False" meta:resourcekey="lblModifierResource1"></asp:Label>
        <asp:Label ID="lblMsgSigner" runat="server" Text="填寫者" Visible="False" meta:resourcekey="lblMsgSignerResource1"></asp:Label>
        <asp:Label ID="lblAuthorityMsg" runat="server" Text="具填寫權限人員" Visible="False" meta:resourcekey="lblAuthorityMsgResource1"></asp:Label>
    </ContentTemplate>
</asp:UpdatePanel>
