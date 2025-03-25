<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="True" EnableEventValidation="false" CodeBehind="frmConfirmListAO.aspx.cs" Inherits="eCerpac_NIS.frmConfirmListAO" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .a {
            display: none;
        }

        .radreason {
            font-size: 9pt;
            font-weight: bold;
        }

        .modalBackground {
            background-color: Gray;
            filter: alpha(opacity=80);
            opacity: 0.8;
            z-index: 10000;
        }

        .information-box, .confirmation-box, .error-box, .warning-box {
            padding: 0.833em 0.833em 0.833em 3em; /* 10/12 36/12 */
            margin-bottom: 0.833em; /* 20/12 */
        }

        .confirmation-box {
            background: #99FF99 url('../Images/icons/confirmation.png') no-repeat 0.833em center;
            border: 2px solid #b7cbb6;
            color: #006600;
            width: 55%;
            font-size: 18px;
        }

        .warning-box {
            background: #fdf7e4 url('../Images/icons/warning.png') no-repeat 0.833em center;
            border: 1px solid #e5d9b2;
            color: #b28a0b;
            width: 55%;
        }

        .auto-style1 {
            height: 41px;
        }

        .generate-id-container, .generate-id-view-full-container {
            padding: 0px;
        }

        .generate-id-view-full-container {
            border: 1px solid #ccc;
        }

        .logout-btn-dashboard-navbar {
            padding: 14px;
        }

        .GridBaseStyle tr th, .GridBaseStyle tr td {
            padding: 2px;
        }

        .GridBaseStyle tr:nth-child(even) {
            background: #fffdfd;
        }

        .GridBaseStyle tr td a {
            color: #fff;
            padding: 3px 7px;
            background: #007c45;
            border-radius: 5px;
            text-decoration: none;
        }

        .dash-table {
            text-align: center;
            border: 1px solid Gray;
            padding: 10px;
            border-radius: 10px;
            display: block;
            margin-bottom: 10px;
            margin-top: 10px
        }

        .GridBaseStyle tr td span {
            color: #000;
        }

        .newDashboard {
            margin-bottom: 10px;
        }

        .common-ctrl {
            text-align: center;
            border: 1px solid Gray;
            padding: 10px;
            border-radius: 10px;
            display: block;
            margin-bottom: 10px;
        }

        .profile-pic {
            border: 1px solid #006600;
            height: 175px;
            width: 150px;
            border-radius: 5%;
            padding: 5px;
            box-shadow: 0 0 10px #a6b6ae;
            margin-top: 10px;
        }

            .profile-pic img {
                width: 100%;
                height: 100%;
            }

        .common-ctrl table tr:nth-child(even) {
            background: #f4f4f4;
        }

        .common-ctrl .cttable tr td:first-child {
            width: 15%;
        }

        .common-ctrl .cttable tr td:last-child {
            width: 75%;
        }

        .common-ctrl table tr th,
        .common-ctrl tr td {
            padding: 8px;
            text-align: left;
        }

        .common-ctrl tr td {
            border-bottom: 1px solid #ccc;
        }

        .common-ctrl tr th {
            background: #007c45;
            color: #fff;
        }

            .common-ctrl tr th:first-child {
                border-top-left-radius: 10px;
            }

            .common-ctrl tr th:last-child {
                border-top-right-radius: 10px;
            }

        .btnSection {
            padding: 10px;
        }

        .printBtn {
            position: absolute;
            top: 2px;
            right: 5px;
            height: 30px;
            width: 30px;
        }

            .printBtn img {
                width: 100%;
                height: 100%;
            }

        .writeComment {
            display: flex;
            flex-direction: row;
            gap: 10px;
        }

        .cleft {
            width: 26%;
            margin-top: 10px;
        }

            .cleft table {
                border: 1px solid #ccc;
            }

        .cright {
            text-align: left;
            margin-bottom: 10px;
            margin-top: 10px;
            width: 72%;
            gap: 5px;
            display: flex;
        }

            .cright label {
                font-size: 16px;
            }

            .cright textarea {
                width: 550px;
                padding: 10px;
                border-radius: 5px;
                background: #f4f4f4;
                height: 80px;
                border: 1px solid #007c45;
            }

        .applicationCtrl {
            display: flex;
            justify-content: space-between;
            padding-bottom: 10px;
        }

        .applicationDetail {
            width: 575px;
            display: flex;
            align-items: center;
            margin-top: 8px;
        }

            .applicationDetail table tr td {
                border: 1px solid #ccc;
            }

                .applicationDetail table tr td:first-child {
                    width: 30%;
                }

        .btn-left-margin {
            margin-left: -180px;
        }

        .common-ctrl table.lcomment tr th:nth-child(2),
        .common-ctrl table.lcomment tr td:nth-child(2) {
            width: 25%;
        }
    </style>

    <script>
        // Function to update character count
        function updateCharCount() {
            var textarea = document.getElementById('<%= txtcomment.ClientID %>');
            var maxLength = 70;
            var currentLength = textarea.value.length;
            var charCount = document.getElementById('charCount');

            if (currentLength > maxLength) {
                textarea.value = textarea.value.substring(0, maxLength);
                currentLength = maxLength;
            }

            charCount.textContent = 'Characters remaining: ' + (maxLength - currentLength);
        }
</script>
    <script type="text/javascript">


        function printrefusal() {
            var prtContent = document.getElementById('Div_ContentPlaceHolder');
            var WinPrint = window.open('', '', 'letf=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }


    </script>

    <asp:Panel ID="pnlMain" runat="server" Style="display: block">
        <center>
            <div align="center" class="bcolour" id="div_main" runat="server">
                <table cellpadding="2" cellspacing="10" style="width: 100%" id="combox">
                    <tr>
                        <td colspan="3" style="height: 5px">
                            <div class="generate-id-heading green-background">Financial Queue </div>

                        </td>
                    </tr>

                    <tr>
                        <td align="center">
                            <asp:Label ID="lblmsg" runat="server" Text="" Font-Size="Small" Width="420px"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lblloginmsg" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="center">
                            <div class="dash-table">
                                <table class="t11" width="100%">
                                    <tr>
                                        <td align="left" style="height: 16px; width: 75%;">
                                            <span style="color: red; text-align: start; font-size: medium;">
                                                <asp:TextBox ID="TextAppId" runat="server" AutoComplete="Off" Placeholder="Please enter eCERPAC number/ Form number" Text="" ValidationGroup="a1" Width="350px" CssClass="textbox2"
                                                    Height="20px"></asp:TextBox>&nbsp;*</span>                                    </td>
                                        <td align="left" style="height: 16px; width: 100%">

                                            <asp:Button ID="Go" runat="server" Text="Search" class="generate-id-heading green-background" ValidationGroup="a1"
                                                OnClick="Go_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="20px">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextAppId" Display="Dynamic"
                                                ErrorMessage="Please enter eCERPAC number/ Form number" ValidationGroup="a1" SetFocusOnError="True" ForeColor="red"></asp:RequiredFieldValidator>


                                        </td>

                                    </tr>

                                    <tr>
                                        <td align="left" style="height: 16px;" colspan="3">
                                            <div>
                                                <asp:GridView ID="GridViewCntcAuthAO" runat="server" Width="100%"
                                                    AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" CellSpacing="1" CssClass="GridBaseStyle" DataKeyNames="cerpac_no"
                                                    OnPageIndexChanging="GridViewCntcAuthAO_PageIndexChanging" OnRowDataBound="GridViewCntcAuthAO_RowDataBound" OnRowCommand="GridViewCntcAuthAO_RowCommand">
                                                    <Columns>

                                                        <asp:TemplateField HeaderText="S.No">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSerialNo" runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="false" Width="5%" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="false" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton runat="server" ID="lblName" Text="Name" OnClick="lnkNormal_Click" CommandArgument="Name" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblName" runat="server" ToolTip='<%# Bind("Name") %>' Text='<%# Bind("Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="true" Width="30%" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="true" />
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Cerpac No." SortExpression="cerpac_no" Visible="false">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton runat="server" ID="lblCerpacNo" Text="Cerpac No." OnClick="lnkNormal_Click" CommandArgument="cerpac_no" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCerpacNo" runat="server" Text='<%# Bind("cerpac_no") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="false" Width="10%" />
                                                            <ItemStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="false" />
                                                        </asp:TemplateField>


                                                        <asp:TemplateField HeaderText="Form No." SortExpression="FORMNO">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton runat="server" ID="lblFORMNO" Text="Form No." OnClick="lnkNormal_Click" CommandArgument="FORMNO" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFORMNO" runat="server" Text='<%# Bind("FORMNO") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" Width="10%" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" />
                                                        </asp:TemplateField>


                                                        <asp:TemplateField HeaderText="Company Name" SortExpression="CompanyName">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton runat="server" ID="lblCompanyName" Text="Company Name" OnClick="lnkNormal_Click" CommandArgument="CompanyName" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCompanyName" runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="true" Width="40%" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="true" />
                                                        </asp:TemplateField>

                                                          <asp:TemplateField HeaderText="Datetime" SortExpression="CreatedOn">
      <HeaderTemplate>
          <asp:LinkButton runat="server" ID="lblDate" Text="Date" OnClick="lnkNormal_Click" CommandArgument="CreatedOn" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
      </HeaderTemplate>
      <ItemTemplate>
          <asp:Label ID="lblDate" runat="server" Text='<%# Bind("CreatedOn") %>'></asp:Label>
      </ItemTemplate>
      <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" Width="10%" />
      <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" />
  </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                                            <HeaderTemplate>
                                                                <asp:LinkButton runat="server" ID="lblStatus" Text="Status" OnClick="lnkNormal_Click" CommandArgument="Status" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" Width="10%" />
                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" />
                                                        </asp:TemplateField>

                                                         <asp:TemplateField HeaderText="Assign to me">
      <ItemTemplate>


          <%--<asp:ImageButton ID="imgBtnAssign" runat="server" ImageUrl="~/eImage_files/Task_not_assigned.jpg" OnClientClick='viewDetails(<%# Eval("FORMNO") %>); ' Width="25px" ToolTip="Assign to me" />--%>

                                                                         <asp:ImageButton ID="imgBtnAssign" runat="server"
ImageUrl="~/eImage_files/Task_not_assigned.jpg"
Width="25px" ToolTip="Assign to me"
CommandName="Assign"
CommandArgument='<%# Eval("cerpac_no") %>' 
CausesValidation="False" />
      </ItemTemplate>
  </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle CssClass="generate-id-heading green-background" />
                                                    <PagerStyle CssClass="generate-id-heading green-background" />
                                                    <RowStyle CssClass="emov-a-table-data" HorizontalAlign="Center"/>
                                                    <EditRowStyle CssClass="emov-a-table-data" />
                                                    <EmptyDataTemplate>
                                                        <div style="text-align: center;">
                                                            No records found.
   
                                                   
                                                       
                                                        </div>
                                                    </EmptyDataTemplate>
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="3" style="height: 25px;">
                                            <strong>
                                                <asp:Label runat="server" CssClass="information-box" align="left" Font-Size="Medium" Text="Sorting of New and Renewal applications can be done on any column."></asp:Label></strong>

                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </td>
                    </tr>

                </table>
            </div>
        </center>
    </asp:Panel>
    <asp:Panel ID="pnlDetails" runat="server" Style="display: none;">
        <center>
            <div id="Div_ContentPlaceHolder" align="center" class="bcolour" style="padding: 10px">
                <div class="common-ctrl">
                    <div style="text-align: center; display: flex; flex-direction: row; justify-content: space-evenly; position: relative;" class="generate-id-heading green-background">
                        <span class="fs16">Applicant Name :
                           
                            <asp:Label ID="HlblTitle" runat="server" CssClass="b99"></asp:Label>
                            <asp:Label ID="HlblFristName" runat="server" CssClass="b99"></asp:Label>
                            <asp:Label ID="HlblLastName" runat="server" CssClass="b99"></asp:Label></span>
                        <span class="fs16">Application Number :
                       
                            <asp:Label ID="lblCerpacNo1" runat="server" CssClass="b99"></asp:Label></span>
                        <div class="printBtn">
                            <img src="eImage_files/printicon.png" onclick="printrefusal();" />
                        </div>
                    </div>
                    <div class="applicationCtrl">
                        <div class="applicationDetail">
                            <table cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td>Date of Submission : </td>
                                    <td>
                                        <asp:Label ID="lblSubmissionDate" runat="server" CssClass="b99"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Mode of Payment :</td>
                                    <td>
                                        <asp:Label ID="lblPaymentMode" runat="server" CssClass="b99"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Applicant Type :</td>
                                    <td>
                                        <asp:Label ID="lblApplicantType" runat="server" CssClass="b99" Text="Primary"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Category :</td>
                                    <td>
                                        <asp:Label ID="lblCategory" runat="server" CssClass="b99" Text="Primary"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>eCERPAC Issue Date :</td>
                                    <td>
                                        <asp:Label ID="lblCIssueDate" runat="server" CssClass="b99" Text="Primary"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>eCERPAC Expiry Date :</td>
                                    <td>
                                        <asp:Label ID="lblCExpiryDate" runat="server" CssClass="b99" Text="Primary"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                        <asp:Image class="profile-pic" runat="server" ID="ImgPhoto" ImageUrl="~/Images/Logo/default_logo.gif" />
                    </div>

                    <div class="common-ctrl">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>Details</th>
                                    <th>Applicant Details</th>
                                    <th>Bank Details</th>
                                    <th>Match</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Form No.</td>
                                    <td>
                                        <asp:Label ID="lblCerpacNo2" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblFormNo" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <img id="ImgForm" runat="server" src="../eImage_files/no.png" alt="Yes" /></td>
                                </tr>
                                <tr>
                                    <td>Name</td>
                                    <td>
                                        <asp:Label ID="lblDBName" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblBKName" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <img id="ImgName" runat="server" src="../eImage_files/no.png" alt="No" /></td>
                                </tr>
                                <tr>
                                    <td>Nationality</td>
                                    <td>
                                        <asp:Label ID="lblDBNationality" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblBKNationality" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <img id="ImgNationality" runat="server" src="../eImage_files/no.png" alt="Yes" /></td>
                                </tr>
                                <tr>
                                    <td>Passport No.</td>
                                    <td>
                                        <asp:Label ID="lblDBPassportNo" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblBKPassportNo" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <img id="ImgPassport" runat="server" src="../eImage_files/no.png" alt="Yes" /></td>
                                </tr>
                                <tr>
                                    <td>Company</td>
                                    <td>
                                        <asp:Label ID="lblDBCompany" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblBKCompany" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <img id="ImgCompany" runat="server" src="../eImage_files/no.png" alt="Yes" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="generate-id-heading green-background" style="text-align: left; margin-bottom: 10px;">Comments & Approval</div>
                <div class="common-ctrl">
                    <table id="tbl_comments" runat="server" class="cttable lcomment" cellpadding="0" cellspacing="0" width="100%" style="text-align: center;">
                        <thead>
                            <tr>
                                <th>Level</th>
                                <th>Name</th>
                                <th>Comment</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>

                            <tr style="display: none;">
                                <td>L1</td>
                                <td>
                                    <asp:Label ID="lblName" runat="server" CssClass="b99"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lblCommet" runat="server" CssClass="b99"></asp:Label></td>
                            </tr>

                        </tbody>
                    </table>

                    <table id="tblComments" runat="server" class="table"></table>

                    <div class="writeComment">
                        <div class="cleft">
                            <asp:DropDownList class="emov-dash-icon-cover1" Width="100%" ID="commentList" Style="margin-right: 5px; background-color: #f8f8f8; padding: 5px 5px 5px 15px; border: 1px solid #f8f8f8;" runat="server">
                                <%--<asp:ListItem Text="Select" Value="" />--%>
                                <asp:ListItem Text="Bank Data Verified" Value="A" />
                                <asp:ListItem Text="Bank Data not Verified" Value="P" />
                                <%--<asp:ListItem Text="Bank Data Partially Verified" Value="N" />--%>
                            </asp:DropDownList>
                        </div>
                        <div class="cright">
                            <textarea placeholder="Please Enter Your Comments..." id="txtcomment" maxlength="70" validationgroup="a2" runat="server" onkeyup="updateCharCount()" onkeydown="updateCharCount()" onpaste="updateCharCount()" oninput="updateCharCount()"></textarea>
                            <span style="color: red; text-align: justify; font-size: medium;">*</span>
                            <br />
                            <span id="charCount">Characters remaining: 70</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtcomment" Display="Dynamic"
                                ErrorMessage="Please Enter Your Comments..." ValidationGroup="a2" SetFocusOnError="True" ForeColor="red"></asp:RequiredFieldValidator>

                        </div>
                    </div>
                    <div class="btnSection">
                        <asp:Button ID="btnVerify" runat="server" class="generate-id-heading green-background btn-left-margin" Text="Submit" ValidationGroup="a2" OnClick="btnVerify_Click" />
                    </div>
                </div>

            </div>




        </center>
    </asp:Panel>

    <!-- Dispaly Alert -->
    <asp:Panel ID="pnlmsg" runat="server" Style="display: none;">

        <center>
            <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                <p style="color: #006600" runat="server"><strong>Applicant Bank Data Verified Successfully</strong></p>
            </div>
        </center>
    </asp:Panel>



    <!-- Dispaly Alert Yes / No -->
    <asp:Panel ID="pnlVConfirm" runat="server" Style="display: none;">

        <center>
            <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                <p style="color: #006600" runat="server"><strong>Are you sure you want to authorize?</strong></p>
                <asp:Button ID="btnVYes" runat="server" class="generate-id-heading green-background" OnClick="btnVYes_Click" Text="Yes" />
                <asp:Button ID="btnVNo" runat="server" Style="background: #ff0200; border: 1px solid #007c45; border-radius: 5.2px; color: #fff; box-shadow: 0 4px 4px 0 #00000014; cursor: pointer; font-size: 1.042vw !important; font-weight: 600; padding: 8px 24px;" Text="No" OnClick="btnVNo_Click" />
            </div>

        </center>
    </asp:Panel>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
