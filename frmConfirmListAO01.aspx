<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="True" EnableEventValidation="false" CodeBehind="frmConfirmListAO01.aspx.cs" Inherits="eCerpac_NIS.frmConfirmListAO01" %>

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
            padding:0px;
        }
        .generate-id-view-full-container {
            border:1px solid #ccc;
        }
        .logout-btn-dashboard-navbar {
            padding:14px;
        }
        .GridBaseStyle tr th, .GridBaseStyle tr td {
            padding:2px;
        }
        .GridBaseStyle tr:nth-child(even){
            background:#fffdfd;
        }
        .GridBaseStyle tr td a {
            color:#007c45;
        }
        .GridBaseStyle tr td span {
            color:#000;
        }
        .newDashboard {
            margin-bottom:10px;
        }
        .common-ctrl{
            text-align: center;
            border: 1px solid Gray;
            padding: 10px;
            border-radius: 10px;
            display: block;
            margin-bottom: 10px;
        }
        .profile-pic{
            border: 1px solid #006600;
            height: 175px;
            width: 150px;
            border-radius: 5%;
            padding: 5px;
            box-shadow: 0 0 10px #a6b6ae;
            margin-top:10px;
        }
        .profile-pic img {
           width:100%;
           height:100%;
        }

        .common-ctrl table tr:nth-child(even){
            background:#f4f4f4;
        }
        .common-ctrl .cttable tr td:first-child {
            width:25%;
        }
        .common-ctrl .cttable tr td:last-child {
            width:75%;
        }

        .common-ctrl table tr th,
        .common-ctrl tr td{
            padding:8px;
            text-align:left;
        }
        .common-ctrl tr td{
            border-bottom:1px solid #ccc;
        }

        .common-ctrl tr th{
            background:#007c45;
            color:#fff;
        }
        .common-ctrl tr th:first-child{
            border-top-left-radius: 10px;
        }
        .common-ctrl tr th:last-child{
            border-top-right-radius: 10px;
        }
        .btnSection{
            padding:10px;
        }
        .printBtn{
            position:absolute;
            top:2px;
            right:5px;
            height:30px;
            width:30px;
        }
        .printBtn img{
            width:100%;
            height:100%;
        }

        .writeComment {
            display:flex;
            flex-direction:row;
            gap:10px;

        }
        .cleft {
            width: 26%;
            margin-top:10px;
         }
        .cleft table{
            border:1px solid #ccc;
        }
        .cright {
            text-align:left;
            margin-bottom:10px;
            margin-top:10px;
            width: 69%;
        }
         .cright label{
             font-size:16px;
         }

        .cright textarea{
            width: 550px;
            padding: 10px;
            border-radius: 5px;
            background: #f4f4f4;
            height:80px;
            border: 1px solid #007c45;
        }
        .applicationCtrl {
            display:flex; 
            justify-content:space-between;
            background:url('../eImage_files/logo.png') center center no-repeat;
            padding-bottom:10px;
        }
        .applicationDetail{
            width: 240px;
            display: flex;
            align-items: center;
        }
        .applicationDetail table tr td {
            border:1px solid #ccc;
        }

    </style>

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
                <table cellpadding="2" cellspacing="10" style="width: 95%" id="combox">
                    <tr>
                        <td colspan="3" style="height: 5px">
                            <div class="generate-id-heading green-background">Eligibility Process (AO/AB and CR Category) </div>

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
                            <table class="t11">
                                <tr>
                                     <td align="left" style="height: 16px; width: 75%;">
                                        <span style="color: red; text-align:start; font-size: medium;">
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
                                                OnPageIndexChanging="GridViewCntcAuthAO_PageIndexChanging" OnRowDataBound="GridViewCntcAuthAO_RowDataBound" OnRowCommand="GridViewCntcAuthAO_RowCommand" OnSelectedIndexChanged="GridViewCntcAuthAO_SelectedIndexChanged">
                                                <Columns>


                                                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                                        <HeaderTemplate>
                                                            <asp:LinkButton runat="server" ID="lblName" Text="Name" OnClick="lnkNormal_Click" CommandArgument="Name" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblName" runat="server" ToolTip='<%# Bind("Name") %>' Text='<%# Bind("Name") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="false" Width="40%" />
                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="false" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Cerpac No." SortExpression="cerpac_no">
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
                                                        <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" Width="30%" />
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


                                                </Columns>
                                                <HeaderStyle CssClass="generate-id-heading green-background" />
                                                <PagerStyle CssClass="generate-id-heading green-background" />
                                                <RowStyle CssClass="emov-a-table-data" />
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

                        </td>
                    </tr>

                </table>
            </div>
        </center>
    </asp:Panel>
    <asp:Panel ID="pnlDetails" runat="server" Style="display: none;">
        <center>
            <div id="Div_ContentPlaceHolder" align="center" class="bcolour" style="padding:10px">
                <div class="common-ctrl">
                    <div style="text-align: center; display:flex; flex-direction:row; justify-content:space-evenly; position:relative;" class="generate-id-heading green-background" >
                        <span class="fs16">Applicant Name : Raj Ali</span>
                        <span class="fs16">Application Number : 123456789</span>
                        <div class="printBtn">
                            <img src="eImage_files/printicon.png" onclick="printrefusal();" />
                        </div>
                    </div>
                    <div class="applicationCtrl">
                        <div class="applicationDetail">
                            <table cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td>Date of Submission : </td>
                                    <td>31-01-2025</td>
                                </tr>
                                <tr>
                                 <td>Mode of Payment :</td>
                                 <td>Online</td>
                               </tr>
                                <tr>
                                  <td>Applicant Type :</td>
                                  <td>Primary</td>
                                </tr>
                                <tr>
                                  <td>Category :</td>
                                  <td>Category</td>
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
                                    <td>eCerpac No.</td>
                                    <td>AQ4467567</td>
                                    <td>AQ4467567</td>
                                    <td><img src="../eImage_files/icon-yes.png" alt="Yes"/></td>
                                </tr>
                                <tr>
                                    <td>Name</td>
                                    <td>Nikhil kumar</td>
                                    <td>Nikhil kumar</td>
                                    <td><img src="../eImage_files/icon-yes.png" alt="No"/></td>
                                </tr>
                                <tr>
                                    <td>Nationality</td>
                                    <td>Nikhil kumar</td>
                                    <td>Nikhil kumar</td>
                                    <td><img src="../eImage_files/icon-yes.png" alt="Yes"/></td>
                                </tr>
                                <tr>
                                    <td>Passport No.</td>
                                    <td>P56656776</td>
                                    <td>P56656776</td>
                                    <td><img src="../eImage_files/icon-yes.png" alt="Yes"/></td>
                                </tr>
                                <tr>
                                    <td>Company</td>
                                    <td>Veeno LTD.</td>
                                    <td>Veeno LTD.</td>
                                    <td><img src="../eImage_files/icon-yes.png" alt="Yes"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="generate-id-heading green-background" style=" text-align:left;margin-bottom:10px;">Comments & Approval</div>
                    <div class="common-ctrl">
                        <table class="cttable" cellpadding="0" cellspacing="0" width="100%">
                            <tbody>
                                <tr>
                                    <td>Level :</td>
                                    <td>L1</td>
                                </tr>
                                <tr>
                                    <td>Name :</td>
                                    <td>Nikhil kumar</td>
                                </tr>
                                <tr>
                                    <td>Comment :</td>
                                    <td>Commented here...</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div class="writeComment">
                            <div class="cleft">
                                <asp:DropDownList class="emov-dash-icon-cover1" Width="100%" ID="commentList" Style="margin-right: 5px; background-color: #f8f8f8; padding: 5px 5px 5px 15px; border: 1px solid #f8f8f8;" runat="server">
                                    <asp:ListItem Text="Select" Value="" />
                                    <asp:ListItem Text="All Ok" Value="All Ok" />
                                    <asp:ListItem Text="Partial Ok" Value="Partial Ok" />
                                    <asp:ListItem Text="Not Ok" Value="Not Ok" />
                                </asp:DropDownList>
                            </div>
                            <div class="cright">
                                <label>Comments</label>
                                <textarea placeholder="Please Enter Your Comments..." id="txtcomment" runat="server"></textarea>
                            </div>
                        </div>
                        <div class="btnSection">
                            <button class="generate-id-heading green-background">Deny</button>
                            <button class="generate-id-heading green-background">Correction</button>
                            <button class="generate-id-heading green-background">Approved</button>
                        </div>
                    </div>
                <table cellpadding="2" cellspacing="2" class="bcolour">

                   
                    <tr class="t11">
                        <td align="center" colspan="3" class="auto-style2">
                            <asp:Label ID="reviewmsg" runat="server" ForeColor="#990000"></asp:Label>
                            <asp:Label ID="msg" runat="server" ForeColor="#339933"></asp:Label>
                        </td>

                    </tr>

                    <tr class="t11">
                        <td align="center" colspan="3">
                            <center>
                                <table id="tbl1" style="width: 750px;" cellpadding="5" cellspacing="2" border="0">
                                    <tr class="b11">
                                        <td align="center" scope="2" style="width: 100%; height: auto; vertical-align: middle; text-align: center; background-repeat: no-repeat;">
                                            <%--<asp:Image runat="server" ID="ImgPhoto" ImageUrl="~/Images/Logo/default_logo.gif"
                                                Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1; border: 1px solid #006600; height: 175px; width: 150px; border-radius: 5%; background-blend-mode: lighten; box-shadow: 0 0 25px var(--border-color, #);" />--%>
                                        </td>
                                    </tr>

                                </table>


                                <table cellpadding="2" cellspacing="2" border="0" with="100%" id="detailtable" runat="server" align="center">
                                    <tr>
                                        <td colspan="2" align="left" style="border-right: 0px dashed #000;" class="t55 mb-lt"><strong>Status:
                                                <asp:Label ID="lblnewrenew" runat="server"></asp:Label>
                                        </strong></td>
                                        <td colspan="2" align="right" class="style1">
                                <img src="eImage_files/printicon.png" height="40" width="40" onclick="printrefusal();" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">Database Details</td>
                                        <td colspan="2" rowspan="6">
                                            <asp:Panel ID="Panel1" runat="server" Height="200px" Width="400px" ScrollBars="Horizontal" BorderStyle="Outset" Direction="LeftToRight">

                                                <asp:DataList ID="DataList1" runat="server" BackColor="Gray" BorderColor="#666666"
                                                    BorderStyle="None" BorderWidth="2px" CellPadding="2" CellSpacing="2"
                                                    Font-Names="Verdana" Font-Size="Small" RepeatColumns="0" RepeatDirection="Horizontal">

                                                    <FooterStyle />

                                                    <HeaderStyle />

                                                    <HeaderTemplate>
                                                    </HeaderTemplate>

                                                    <ItemStyle BackColor="White" ForeColor="Black" BorderWidth="2px" />

                                                    <ItemTemplate>
                                                        <table style="height: 160px;">
                                                            <tr>
                                                                <td><b>Form No:</b> </td>
                                                                <td>
                                                                    <asp:Label ID="lblCName" runat="server" Text='<%# Eval("Formno") %>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td><b>Name:</b></td>
                                                                <td>
                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td><b>Nationality:</b></td>
                                                                <td>
                                                                    <asp:Label ID="lblNationality" runat="server" Text=' <%# Eval("Nationality") %>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td><b>Passport No.:</b></td>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="server" Text=' <%# Eval("PassportNo") %>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td><b>Company:</b></td>
                                                                <td>
                                                                    <asp:Label ID="Label2" runat="server" Text=' <%# Eval("Company") %>'></asp:Label></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>

                                                </asp:DataList>

                                            </asp:Panel>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 150px;">Form No.
                                        </td>
                                        <td align="left" style="width: 190px;" class="b-lt">
                                            <asp:Label ID="lblPeopleCerpac" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 150px;">Name
                                        </td>
                                        <td align="left" style="width: 190px;" class="b-lt">
                                            <asp:Label ID="txtPeoplename" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 150px;">Nationality
                                        </td>
                                        <td align="left" style="width: 190px;" class="b-b b-lt">
                                            <asp:Label ID="lblPeopleNationlaity" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 150px;">Passport No.
                                        </td>
                                        <td align="left" style="width: 190px;" class="b-b b-lt">
                                            <asp:Label ID="lblPeoplePassportNo" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 150px;">Company
                                        </td>
                                        <td align="left" style="width: 190px;" class="b-b b-lt">
                                            <asp:Label ID="txtPeolpeCompany" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" style="height: 2px;">&nbsp;   </td>
                                    </tr>


                                    <tr>
                                        <td colspan="3">
                                            <tr>
                                                <td style ="height:15px"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="left" style="border-right: 0px dashed #000;">
                                                    <strong>eCerpac Details</strong>
                                                </td>
                                                <td colspan="2"></td>

                                            </tr>
                                            <tr>

                                                <td align="left">eCerpac No
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="TxtCerpacNo" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">Date of Purchase
                                                </td>
                                                <td align="left" class="b-ltr">
                                                    <asp:Label ID="lblprchase" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td align="left">Form No.
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="txtfrnno" runat="server" Visible="false"></asp:Label>
                                                    <asp:Label ID="txtfrnnoorig" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">Date of Receipt
                                                </td>
                                                <td align="left" class="b-ltr">
                                                    <asp:Label ID="lblrcpt" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td align="left">Forms Purchased
                                                </td>
                                                <td align="left">&nbsp;&nbsp;&nbsp;
                                                     <asp:Label ID="lblnum" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">Expiry Date
                                                </td>
                                                <td align="left" class="b-rb b-lt">
                                                    <asp:Label ID="lblexp" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </td>
                                    </tr>


                                    <tr>
                                        <td colspan="4">

                                            <!-- till here -->

                                            <tr>
                                                <td colspan="4" align="left">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="left">Reason</td>
                                                <td colspan="3" align="left">
                                                    <asp:RadioButtonList runat="server" ID="radreason" RepeatColumns="3" Font-Bold="true" CssClass="bold" CellSpacing="0" CellPadding="0" Width="100%">
                                                        <asp:ListItem Selected="True" Value="BDMS">Bank Data Missmatch</asp:ListItem>
                                                        <asp:ListItem Value="EDWC">Expiry Date wrongly calculated</asp:ListItem>
                                                        <asp:ListItem Value="OTHS">Others</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>

                                            </tr>

                                            <tr>
                                                <td colspan="4" align="left"></td>
                                            </tr>

                                            <tr>
                                                <td colspan="4" align="center">
                                                    <asp:Button ID="btnVerify" runat="server" class="generate-id-heading green-background" Text="Confirm"
                                                        Width="140px" OnClick="btnVerify_Click" OnClientClick="change()" />

                                                    <asp:Button ID="btnDefer" runat="server" Text="Defer" Width="149px"
                                                        class="generate-id-heading green-background" OnClick="btnDefer_Click" />

                                                    <asp:Button ID="btnDenycompletely" Text="Deny Completely" runat="server" class="generate-id-heading green-background" OnClick="btnDenycompletely_Click" />

                                                </td>


                                            </tr>

                                        </td>
                                    </tr>


                                </table>
                            </center>
                        </td>


                    </tr>


                </table>
            </div>

            <div id="DivEdDetails" runat="server" align="left" style="display: none;">
                <table cellpadding="2" cellspacing="5" class="bcolour" style="text-align: center; width: 100%; border: 0px solid Gray; padding: 10px; border-radius: 25px;">
                    <tr>
                        <td colspan="4">
                            <div style="text-align: center;">
                                <div class="generate-id-heading green-background">Document Details </div>

                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td colspan="2">
                            <center>
                                <div id="DivPassport" style="position: relative;">

                                    <asp:Image runat="server" ID="Image1" ImageUrl="~/eImage_files/SamplePassport.jpeg" Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1;" Width="80%" Height="400px" />

                                </div>
                            </center>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <center>
                                <div id="DivCompanyCRC" style="position: relative;">

                                    <asp:Image runat="server" ID="Image4" ImageUrl="~/eImage_files/SamplePassport.jpeg" Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1;" Width="80%" Height="400px" />

                                </div>
                            </center>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <center>
                                <div id="DivDegree" style="position: relative;">

                                    <asp:Image runat="server" ID="Image2" ImageUrl="~/eImage_files/SampleCR.jpeg" Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1;" Width="80%" Height="400px" />

                                </div>
                            </center>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td colspan="2">
                            <center>
                                <div id="DivCV" style="position: relative;">

                                    <asp:Image runat="server" ID="Image3" ImageUrl="~/eImage_files/SampleCV.jpeg" Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1;" Width="80%" Height="400px" />

                                </div>
                            </center>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>


        </center>
    </asp:Panel>

    <!-- Dispaly Alert -->
    <asp:Panel ID="pnlmsg" runat="server" Style="display: none;">

        <center>
            <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                <p style="color: #006600" runat="server"><strong>Applicant Verified Sucessfully</strong></p>
            </div>
        </center>
    </asp:Panel>



    <!-- Dispaly Alert Yes / No -->
    <asp:Panel ID="pnlVConfirm" runat="server" Style="display: none;">

        <center>
            <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                <p style="color: #006600" runat="server"><strong>Are you sure you want to authorized?</strong></p>
                <asp:Button ID="btnVYes" runat="server" class="generate-id-heading green-background" OnClick="btnVYes_Click" Text="Yes" />
                <asp:Button ID="btnVNo" runat="server" Style="background: #ff0200; border: 1px solid #007c45; border-radius: 5.2px; color: #fff; box-shadow: 0 4px 4px 0 #00000014; cursor: pointer; font-size: 1.042vw !important; font-weight: 600; padding: 8px 24px;" Text="No" OnClick="btnVNo_Click" />
            </div>

        </center>
    </asp:Panel>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
