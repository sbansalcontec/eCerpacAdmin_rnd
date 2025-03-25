<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="frmAuthorizationProcess01.aspx.cs" Inherits="eCerpac_NIS.frmAuthorizationProcess01" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tooltip.js/1.3.1/tooltip.js.map" type="text/javascript"></script>
    <link rel="stylesheet" href="http://localhost:63262/code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />


    <!-- Select Order Details All Checkbox -->

    <style type="text/css">
        .a {
            display: none;
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
    </style>

    <style type="text/css">
        .zoom {
            transition: transform .2s;
            width: 800px;
            height: 800px;
        }

            .zoom:hover {
                background: rgba(255, 255, 255, 1) 70% 70% no-repeat padding-box;
                border: 1px solid Green;
                border-radius: 2px;
                padding: 2px 2px;
                margin-left: 5px;
                outline: none;
                position: absolute;
                -ms-transform: scale(1.5); /* IE 9 */
                -webkit-transform: scale(1.5); /* Safari 3-8 */
                transform: scale(5.1);
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

        .GridBaseStyle tr:nth-child(even),
        #ContentPlaceHolder1_DivPersonalDetails table tr:nth-child(even),
        #ContentPlaceHolder1_DevPassportDetails table tr:nth-child(even),
        #ContentPlaceHolder1_DivCompanyDetails table tr:nth-child(even),
        #ContentPlaceHolder1_DivEdDetails table tr:nth-child(even),
        #ContentPlaceHolder1_gdEImage tr:nth-child(even) {
            background: #f4f4f4;
        }
        #ContentPlaceHolder1_gdEImage tr:nth-child(even),
        .applicationDetail table tr:nth-child(even){
            background:#f4f4f4;
        }

        #ContentPlaceHolder1_DivPersonalDetails table tr:last-child,
        #ContentPlaceHolder1_DevPassportDetails table tr:last-child,
        #ContentPlaceHolder1_DivCompanyDetails table tr:last-child {
            background: none;
        }
        .Grid_Item {
            background:#f4f4f4 !important;
        }


        .Grid_Item_Alternaterow {
         background:#eaf5e5  !important;
        }
        .GridBaseStyle tr td a {
            color: #007c45;
        }

        .GridBaseStyle tr td span {
            color: #000;
        }

        .newDashboard {
            margin-bottom: 10px;
        }

        #ContentPlaceHolder1_gdPImage tr th,
        #ContentPlaceHolder1_gdPImage tr td,
        #ContentPlaceHolder1_gdAImage tr th,
        #ContentPlaceHolder1_gdAImage tr td,
        #ContentPlaceHolder1_gdQrgImage tr th,
        #ContentPlaceHolder1_gdQrgImage tr td,
        #ContentPlaceHolder1_gdEImage tr th,
        #ContentPlaceHolder1_gdEImage tr td {
            padding: 8px;
        }
        #ContentPlaceHolder1_gdEImage tr td,
        .applicationDetail table tr td,
        #ContentPlaceHolder1_gdPImage tr th,
        #ContentPlaceHolder1_gdPImage tr th{
            padding:8px;
        }

        #ContentPlaceHolder1_DivPersonalDetails table tr td,
        .applicationDetail{
            width:240px;
            display:flex;
            align-items:center;
        }
        .applicationDetail tr td{
            text-align:left;
        }
        #ContentPlaceHolder1_DivPersonalDetails table tr td,
        #ContentPlaceHolder1_DevPassportDetails table tr td,
        #ContentPlaceHolder1_DivCompanyDetails table tr td,
        #ContentPlaceHolder1_DivEdDetails table tr td {
            border-bottom: 1px solid #ccc;
            padding: 5px;
            font-size: 16px;
        }
        #ContentPlaceHolder1_DivEdDetails table tr td {
            border: 1px solid #ccc;
            padding: 5px;
            font-size: 16px;
            width: 50%;
        }

        #ContentPlaceHolder1_DivPersonalDetails table tr:last-child td:first-child {
            border: none;
        }


        #ContentPlaceHolder1_gdPImage tr th:first-child,
        #ContentPlaceHolder1_gdPImage tr td:first-child,
         
        
         #ContentPlaceHolder1_DivPersonalDetails table tr td:first-child,
         #ContentPlaceHolder1_DevPassportDetails table tr td:first-child,
         #ContentPlaceHolder1_DivCompanyDetails table tr td:first-child,
         #ContentPlaceHolder1_DivEdDetails table tr td:first-child{
             
            width:25%;
         }
         
         #ContentPlaceHolder1_DevPassportDetails table tr td:last-child,
         #ContentPlaceHolder1_DivCompanyDetails table tr td:last-child,
         #ContentPlaceHolder1_DivEdDetails table tr td:last-child{
    
           width:75%;
         }
        .applicationDetail table tr td {
            border:1px solid #ccc;
        }
        #ContentPlaceHolder1_DivPersonalDetails table tr th,
        #ContentPlaceHolder1_gdQrgImage tr th,
        #ContentPlaceHolder1_gdQrgImage tr th,
        #ContentPlaceHolder1_gdEImage tr th{
            font-size:16px;
        }
         #ContentPlaceHolder1_DivPersonalDetails table tr:last-child td:first-child{
             border:none;
         }
        #ContentPlaceHolder1_gdAImage tr th:first-child,
        #ContentPlaceHolder1_gdAImage tr td:first-child,
        #ContentPlaceHolder1_gdQrgImage tr th:first-child,
        #ContentPlaceHolder1_gdQrgImage tr td:first-child,
        #ContentPlaceHolder1_gdEImage tr td:first-child,
        #ContentPlaceHolder1_gdEImage tr th:first-child {
            width: 50px;
            text-align: center;
            font-weight: bold;
        }
        #ContentPlaceHolder1_gdEImage tr th:first-child,
        #ContentPlaceHolder1_gdPImage tr th:first-child,
        #ContentPlaceHolder1_gdPImage tr td:first-child{
            width:50px !important;
            text-align:center;
            font-weight:bold;
        }

        #ContentPlaceHolder1_DivCompanyDetails table tr.Grid_Item td:first-child,
        #ContentPlaceHolder1_DivCompanyDetails table tr.Grid_Item td:first-child,
        #ContentPlaceHolder1_DivEdDetails table tr.Grid_Item td:first-child,
        #ContentPlaceHolder1_DivEdDetails table tr.Grid_Item_Alternaterow td:first-child {
            width: 50px;
        }
        #ContentPlaceHolder1_DivEdDetails table tr.Grid_Item_Alternaterow td:first-child,
        #ContentPlaceHolder1_gdPImage table tr.Grid_Item td:first-child{
            width:50px;
        }

        #ContentPlaceHolder1_gdPImage tr th:last-child,
        #ContentPlaceHolder1_gdPImage tr td:last-child,
        #ContentPlaceHolder1_gdAImage tr th:last-child,
        #ContentPlaceHolder1_gdAImage tr td:last-child,
        #ContentPlaceHolder1_gdQrgImage tr th:last-child,
        #ContentPlaceHolder1_gdQrgImage tr td:last-child
        #ContentPlaceHolder1_DivCompanyDetails tr td:last-child,
        #ContentPlaceHolder1_DivEdDetails tr td:last-child,
        #ContentPlaceHolder1_gdEImage tr td:last-child,
        #ContentPlaceHolder1_gdEImage tr th:last-child {
            width: 200px;
        }

        #ContentPlaceHolder1_gdPImage tr th:last-child,
        #ContentPlaceHolder1_gdPImage tr td:last-child,

        #ContentPlaceHolder1_gdPImage tr th:nth-child(2),
        #ContentPlaceHolder1_gdPImage tr td:nth-child(2){
            width:55%;
        }

        #ContentPlaceHolder1_DevPassportDetails table tr th:nth-child(2),
        #ContentPlaceHolder1_DevPassportDetails table tr td:nth-child(2) {
            width:60%;
        }

        #ContentPlaceHolder1_gdEImage table tr th:nth-child(2),
        #ContentPlaceHolder1_gdEImage table tr td:nth-child(2) {
            width:70%;
        }
        

        #ContentPlaceHolder1_gdAImage tr th:last-child,
        #ContentPlaceHolder1_gdAImage tr td:last-child,
        #ContentPlaceHolder1_gdQrgImage tr th:last-child,
        #ContentPlaceHolder1_gdQrgImage tr td:last-child,
        #ContentPlaceHolder1_gdEImage tr th:last-child,
        #ContentPlaceHolder1_gdEImage tr td:last-child {
            display: flex;
            justify-content: center;
            border-left: none;
            border-right: none;
            border-bottom: none;
            align-items: center;
            width: 90%;
        }

        .writeComment {
            text-align: center;
            margin-bottom: 10px;
        
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

            .writeComment textarea {
                width: 300px;
                padding: 10px;
                border-radius: 10px;
                background: #f4f4f4;
                border: 1px solid #007c45;
            }
    </style>


    <style type="text/css">
        .yes {
            border: 2px solid white;
            box-shadow: 0 0 0 1px #392;
            appearance: none;
            border-radius: 50%;
            width: 5px;
            height: 5px;
            background-color: #fff;
            transition: all ease-in 0.1s;
        }

            .yes:checked {
                background-color: #392;
            }



        .no {
            border: 2px solid white;
            box-shadow: 0 0 0 1px #932;
            appearance: none;
            border-radius: 50%;
            width: 5px;
            height: 5px;
            background-color: #fff;
            transition: all ease-in 0.1s;
        }

            .no:checked {
                background-color: #932;
            }
    </style>

    <style type="text/css">
        .cright textarea {
            width: 550px;
            padding: 10px;
            border-radius: 5px;
            background: #f4f4f4;
            height: 80px;
            border: 1px solid #007c45;
        }

        .fs16 {
            font-size: 16px;
        }

        .imgBoxShadow {
            border: 1px solid #006600;
            border-radius: 5%;
            padding: 5px;
            box-shadow: 0 0 10px #a6b6ae;
        }

        .applicationCtrl {
            display: flex;
            justify-content: space-between;
            background: url('../eImage_files/logo.png') center center no-repeat;
        }
    </style>
    <div>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
                <div class="modal">
                    <div class="center">
                        <div id="coverScreen" class="LockOn"></div>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>

        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridViewAuth" />
            </Triggers>
            <ContentTemplate>

                <span>
                    <div id="lblmsg" runat="server" class="my-notify-error" visible="false"></div>
                    <asp:Label ID="lblloginmsg" runat="server" Text="Label"></asp:Label>
                </span>

                <asp:Panel ID="pnlMain" runat="server" Style="display: block">

                    <div align="center" class="bcolour" id="auth_contain" runat="server" style="1px solid #ccc">
                        <table cellpadding="2" cellspacing="10" style="width: 95%">
                            <tr>
                                <td colspan="3" style="height: 5px">
                                    <div class="PageNameHeadingCSS" style="text-align: center">
                                        <font class="b12">

                                            <div class="generate-id-heading green-background">Authorization Process </div>

                                        </font>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td align="center"></td>
                            </tr>

                            <tr>
                                <td align="center">
                                    <table class="t11">
                                        <tr>
                                            <td align="left" style="height: 16px; width: 65%;">
                                                <%--  <strong>CERPAC No </strong><span style="font-size: 12px;"><strong>(Secured Sold Form No. in case of new case)</strong></span>--%>
                                                <span style="color: red; text-align: justify; font-size: medium;">
                                                    <asp:TextBox ID="TextAppId" runat="server" AutoComplete="Off" Placeholder="Please enter eCERPAC number/ Form number" Text="" ValidationGroup="a1" Width="350px" CssClass="textbox2"
                                                        Height="20px"></asp:TextBox>&nbsp;*</span>

                                            </td>
                                            <td align="left" style="height: 16px; width: 100%">
                                                <asp:Button ID="Go" runat="server" Text="Search" class="generate-id-heading green-background" ValidateRequestMode="Disabled" ValidationGroup="a1" OnClick="Go_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="20px">
                                                <asp:RequiredFieldValidator ID="rfvAppId" runat="server" ControlToValidate="TextAppId" Display="Dynamic"
                                                    ErrorMessage="Please enter eCERPAC number/ Form number" ValidationGroup="a1" SetFocusOnError="True" ForeColor="red"></asp:RequiredFieldValidator>


                                            </td>

                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 16px;" colspan="3">


                                                <asp:GridView ID="GridViewAuth" PagerStyle-CssClass="pgr"
                                                    runat="server" Width="100%" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" CellSpacing="1" CssClass="GridBaseStyle" DataKeyNames="cerpac_no"
                                                    OnPageIndexChanging="GridViewAuth_PageIndexChanging" OnRowDataBound="GridViewAuth_RowDataBound" OnRowCommand="GridViewAuth_RowCommand" OnSelectedIndexChanged="GridViewAuth_SelectedIndexChanged">
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

                                                        <asp:TemplateField HeaderText="Status" SortExpression="CompanyName">
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
                </asp:Panel>

                <!-- Dispaly Details -->
                <asp:Panel ID="pnldisplay" runat="server" Style="display: none; padding: 10px">
                    <div style="padding: 10px">
                        <div id="DivAuthDetails" runat="server" align="center" class="bcolour" style="text-align: center; border: 1px solid Gray; padding: 10px; border-radius: 10px; display: block; margin-bottom: 10px">
                            <div style="text-align: center; display: flex; flex-direction: row; justify-content: space-between" class="generate-id-heading green-background">
                                <span>Applicant Name : Raj Ali</span>
                                <span>Application Number :
                                    <asp:Label ID="lblCerpacNo1" runat="server" CssClass="b99"></asp:Label></span>
                            </div>
                            <div style="padding: 10px 10px 0px; display: flex; justify-content: center;">
                                <asp:UpdatePanel runat="server" ID="UpdatePic" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Image runat="server" ID="ImgPhoto" ImageUrl="~/eImage_files/default_logo.gif" Style="border: 1px solid #006600; height: 175px; width: 150px; border-radius: 5%; padding: 5px; box-shadow: 0 0 10px #a6b6ae;" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>

                        </div>

                        <div id="DivPersonalDetails" runat="server" align="left" class="bcolour" style="text-align: center; border: 1px solid Gray; padding: 10px; border-radius: 10px; display: block; margin-bottom: 10px">
                            <div style="text-align: center;" class="generate-id-heading green-background">Personal Details </div>
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>

                                    <td align="left" class="b55">Title : </td>
                                    <td align="left">
                                        <asp:Label ID="lblTitle" runat="server" CssClass="b99"></asp:Label></td>
                                    <td>
                                        <input id="GtxtTitle" type="radio" class="yes" runat="server" value="Y" name="TL">Yes                                    
                                        <input id="RtxtTitle" type="radio" class="no" runat="server" value="N" name="TL">No</td>

                                </tr>
                                <tr>

                                    <td align="left" class="b55">First Name : </td>
                                    <td align="left">
                                        <asp:Label ID="lblFristName" runat="server" CssClass="b99"></asp:Label>
                                    </td>

                                    <th>
                                        <input id="GtxtFirstName" type="radio" class="yes" runat="server" value="Y" name="FN"></th>
                                    <th>
                                        <input id="RtxtFirstName" type="radio" class="no" runat="server" value="N" name="FN"></th>

                                </tr>
                                <tr>

                                    <td align="left" class="b55">Last Name : </td>
                                    <td align="left">
                                        <asp:Label ID="lblLastName" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtLastName" type="radio" class="yes" runat="server" value="Y" name="LN"></th>
                                    <th>
                                        <input id="RtxtLastName" type="radio" class="no" runat="server" value="N" name="LN"></th>

                                </tr>
                                <tr>

                                    <td align="left" class="b55">Date of Birth :</td>
                                    <td align="left">
                                        <asp:Label ID="lblDOB" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtDOB" type="radio" class="yes" runat="server" value="Y" name="DB"></th>
                                    <th>
                                        <input id="RtxtDOB" type="radio" class="no" runat="server" value="N" name="DB"></th>

                                </tr>
                                <tr>

                                    <td align="left" class="b55">Sex : </td>
                                    <td align="left">
                                        <asp:Label ID="lblSex" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtSex" type="radio" class="yes" runat="server" value="Y" name="SX"></th>
                                    <th>
                                        <input id="RtxtSex" type="radio" class="no" runat="server" value="N" name="SX"></th>

                                </tr>
                                <tr>

                                    <td align="left" class="b55">Nationality : </td>
                                    <td align="left">
                                        <asp:Label ID="lblNationality" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtNationality" type="radio" class="yes" runat="server" value="Y" name="PN"></th>
                                    <th>
                                        <input id="RtxtNationality" type="radio" class="no" runat="server" value="N" name="PN"></th>

                                </tr>
                                <tr>
                                    <td align="left" class="b55">Place of Birth : </td>
                                    <td align="left">
                                        <asp:Label ID="lblPOB" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtPOB" type="radio" class="yes" runat="server" value="Y" name="PB"></th>
                                    <th>
                                        <input id="RtxtPOB" type="radio" class="no" runat="server" value="N" name="PB"></th>

                                </tr>
                                <tr>
                                    <td align="left" class="b55">E-mail ID : </td>
                                    <td align="left">
                                        <asp:Label ID="lblemailId" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtEmailID" type="radio" class="yes" runat="server" value="Y" name="EM"></th>
                                    <th>
                                        <input id="RtxtEmailID" type="radio" class="no" runat="server" value="N" name="EM"></th>

                                </tr>
                                <tr>
                                    <td align="left" class="b55">Contact No :</td>
                                    <td align="left">
                                        <asp:Label ID="lblContactNo" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtContactNo" type="radio" class="yes" runat="server" value="Y" name="CN"></th>
                                    <th>
                                        <input id="RtxtContactNo" type="radio" class="no" runat="server" value="N" name="CN"></th>

                                </tr>
                                <tr>
                                    <td align="left" class="b55">Address 1 :</td>
                                    <td align="left">
                                        <asp:Label ID="lblAddress1" runat="server" CssClass="b99"></asp:Label></td>


                                    <th>
                                        <input id="GtxtAddress1" type="radio" class="yes" runat="server" value="Y" name="AD11"></th>
                                    <th>
                                        <input id="RtxtAddress1" type="radio" class="no" runat="server" value="N" name="AD11"></th>

                                </tr>
                                <tr>
                                    <td align="left" style="width: 150px;" class="b55">Address 2 :</td>
                                    <td align="left" style="width: 190px;">
                                        <asp:Label ID="lblAddress2" runat="server" CssClass="b99"></asp:Label></td>


                                    <th>
                                        <input id="GtxtAddress2" type="radio" class="yes" runat="server" value="Y" name="AD22"></th>
                                    <th>
                                        <input id="RtxtAddress2" type="radio" class="no" runat="server" value="N" name="AD22"></th>

                                </tr>

                                <tr>
                                    <td align="left" colspan="4" style="padding: 0px">

                                        <asp:GridView ID="gdPImage" runat="server" Width="100%" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:BoundField DataField="SLNo" HeaderText="Sl No." />
                                                <asp:BoundField DataField="DocName" HeaderText="Document Name" />
                                                <asp:TemplateField HeaderText="Document Image">
                                                    <ItemTemplate>
                                                        <asp:Image ID="ReceiptImage" runat="server" Height="150px" Width="150px" class="gridImages" CssClass="zoom imgBoxShadow"
                                                            ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Doc_Image")) %>'></asp:Image>

                                                        <div id="tooltip" style="display: none;">
                                                            <table>
                                                                <tr>
                                                                    <%--Image to Show on Hover--%>
                                                                    <td>
                                                                        <asp:Image ID="imgUserName" Width="150px" Height="120px" ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Doc_Image")) %>' runat="server" /></td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <input id="rdAD1Y" type="radio" class="yes" runat="server" value="1" name="PN">

                                                        <input id="rdAD1N" type="radio" class="no" runat="server" value="-1" name="PN">
                                                    </ItemTemplate>
                                                </asp:TemplateField>



                                            </Columns>

                                            <HeaderStyle CssClass="generate-id-heading green-background" />
                                            <PagerStyle CssClass="pgr"></PagerStyle>
                                            <RowStyle CssClass="Grid_Item" />
                                            <AlternatingRowStyle CssClass="Grid_Item_Alternaterow" />
                                            <SelectedRowStyle CssClass="Grid_Selected" />
                                            <FooterStyle CssClass="generate-id-heading green-background" />
                                        </asp:GridView>

                                    </td>
                                </tr>

                            </table>

                        </div>

                        <div id="DevPassportDetails" runat="server" align="left" class="bcolour" style="text-align: center; border: 1px solid Gray; padding: 10px; border-radius: 10px; display: block; margin-bottom: 10px">
                            <div class="generate-id-heading green-background">Passport Details </div>
                            <table cellpadding="0" cellspacing="0" width="100%">

                                <tr>
                                    <td align="left" class="b55">Passport No. :</td>
                                    <td align="left">
                                        <asp:Label ID="lblPassportNo" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtPassportNo" type="radio" class="yes" runat="server" value="Y" name="PPN"></th>
                                    <th>
                                        <input id="RtxtPassportNo" type="radio" class="no" runat="server" value="N" name="PPN"></th>

                                </tr>

                                <tr>
                                    <td align="left" class="b55">Place of Issue : </td>
                                    <td align="left">
                                        <asp:Label ID="lblPlaceOfIssue" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtPlaceOfIssue" type="radio" class="yes" runat="server" value="Y" name="PPI"></th>
                                    <th>
                                        <input id="RtxtPlaceOfIssue" type="radio" class="no" runat="server" value="N" name="PPI"></th>

                                </tr>

                                <tr>
                                    <td align="left" class="b55">Passport Issued By : </td>
                                    <td align="left">
                                        <asp:Label ID="lblPassportIssuedBy" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtPassportIssuedBy" type="radio" class="yes" runat="server" value="Y" name="PPB"></th>
                                    <th>
                                        <input id="RtxtPassportIssuedBy" type="radio" class="no" runat="server" value="N" name="PPB"></th>

                                </tr>

                                <tr>
                                    <td align="left" class="b55">Date of Issue : </td>
                                    <td align="left">
                                        <asp:Label ID="lblPassportIssueDate" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtPassportIssueDate" type="radio" class="yes" runat="server" value="Y" name="PDI"></th>
                                    <th>
                                        <input id="RtxtPassportIssueDate" type="radio" class="no" runat="server" value="N" name="PDI"></th>

                                </tr>

                                <tr>
                                    <td align="left" class="b55">Date of Expiry :</td>
                                    <td align="left">
                                        <asp:Label ID="lblPassportExpiryDate" runat="server" CssClass="b99"></asp:Label></td>

                                    <th>
                                        <input id="GtxtPassportExpiryDate" type="radio" class="yes" runat="server" value="Y" name="PDE"></th>
                                    <th>
                                        <input id="RtxtPassportExpiryDate" type="radio" class="no" runat="server" value="N" name="PDE"></th>

                                </tr>


                                <tr>
                                    <td align="left" colspan="3" style="padding: 0px">

                                        <asp:GridView ID="gdAImage" runat="server" Width="100%" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:BoundField DataField="SLNo" HeaderText="Sl No." />
                                                <asp:BoundField DataField="DocName" HeaderText="Document Name" />
                                                <asp:TemplateField HeaderText="Document Image">
                                                    <ItemTemplate>
                                                        <asp:Image ID="ReceiptImage" runat="server" Height="150px" Width="150px" class="gridImages" CssClass="zoom imgBoxShadow"
                                                            ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Doc_Image")) %>'></asp:Image>

                                                        <div id="tooltip" style="display: none;">
                                                            <table>
                                                                <tr>
                                                                    <%--Image to Show on Hover--%>
                                                                    <td>
                                                                        <asp:Image ID="ImgPassport" Width="150px" Height="120px" ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Doc_Image")) %>' runat="server" /></td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <input id="rdAD2Y" type="radio" class="yes" runat="server" value="1" name="LN">

                                                        <input id="rdAD2N" type="radio" class="no" runat="server" value="-1" name="LN">
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                            </Columns>
                                            <HeaderStyle CssClass="generate-id-heading green-background" />

                                            <PagerStyle CssClass="pgr"></PagerStyle>
                                            <RowStyle CssClass="Grid_Item" />
                                            <AlternatingRowStyle CssClass="Grid_Item_Alternaterow" />
                                            <SelectedRowStyle CssClass="Grid_Selected" />
                                            <FooterStyle CssClass="generate-id-heading green-background" />
                                        </asp:GridView>

                                    </td>
                                </tr>

                            </table>
                        </div>

                        <div id="DivCompanyDetails" runat="server" align="left" class="bcolour" style="display: block; margin-bottom: 10px; text-align: center; border: 1px solid Gray; padding: 10px; border-radius: 10px">
                            <div class="generate-id-heading green-background" style="text-align: center;">Company Details </div>
                            <table cellpadding="0" cellspacing="0" width="100%">

                                <tr>
                                    <td align="left" class="b55">Company RC No. :</td>
                                    <td align="left">
                                        <asp:Label ID="lblCompanyRC" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtCompanyRC" type="radio" class="yes" runat="server" value="Y" name="CRC"></th>
                                    <th>
                                        <input id="RtxtCompanyRC" type="radio" class="no" runat="server" value="N" name="CRC"></th>
                                </tr>
                                <tr>
                                    <td align="left" class="b55">Company Name :</td>
                                    <td align="left">
                                        <asp:Label ID="lblCompanyName" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtCompanyName" type="radio" class="yes" runat="server" value="Y" name="CCN"></th>
                                    <th>
                                        <input id="RtxtCompanyName" type="radio" class="no" runat="server" value="N" name="CCN"></th>
                                </tr>

                                <tr>
                                    <td align="left" class="b55">Company Address 1 :</td>
                                    <td align="left" style="width: 190px;">
                                        <asp:Label ID="lblComAddress1" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtComAddress1" type="radio" class="yes" runat="server" value="Y" name="CCA1"></th>
                                    <th>
                                        <input id="RtxtComAddress1" type="radio" class="no" runat="server" value="N" name="CCA1"></th>
                                </tr>

                                <tr>
                                    <td align="left" class="b55">Company Address 2 :</td>
                                    <td align="left">
                                        <asp:Label ID="lblComAddress2" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtComAddress2" type="radio" class="yes" runat="server" value="Y" name="CCA2"></th>
                                    <th>
                                        <input id="RtxtComAddress2" type="radio" class="no" runat="server" value="N" name="CCA2"></th>
                                </tr>

                                <tr>
                                    <td align="left" class="b55">Designation :</td>
                                    <td align="left">
                                        <asp:Label ID="lblDesignation" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtDesignation" type="radio" class="yes" runat="server" value="Y" name="CDES"></th>
                                    <th>
                                        <input id="RtxtDesignation" type="radio" class="no" runat="server" value="N" name="CDES"></th>
                                </tr>

                                <tr>

                                    <td align="left" class="b55">Company Telephone No. :</td>
                                    <td align="left">
                                        <asp:Label ID="lblComTelephone" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtComTelephone" type="radio" class="yes" runat="server" value="Y" name="CCT"></th>
                                    <th>
                                        <input id="RtxtComTelephone" type="radio" class="no" runat="server" value="N" name="CCT"></th>
                                </tr>

                                <tr>
                                    <td align="left" class="b55">Company Fax Number :</td>
                                    <td align="left">
                                        <asp:Label ID="lblComFaxNo" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtComFaxNo" type="radio" class="yes" runat="server" value="Y" name="CCF"></th>
                                    <th>
                                        <input id="RtxtComFaxNo" type="radio" class="no" runat="server" value="N" name="CCF"></th>
                                </tr>

                                <tr>
                                    <td align="left" class="b55">Date of Employment :</td>
                                    <td align="left">
                                        <asp:Label ID="lblEmploymentDt" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtEmploymentDt" type="radio" class="yes" runat="server" value="Y" name="CDE"></th>
                                    <th>
                                        <input id="RtxtEmploymentDt" type="radio" class="no" runat="server" value="N" name="CDE"></th>
                                </tr>


                                <tr>
                                    <td align="left" colspan="4" style="padding: 0px">

                                        <asp:GridView ID="gdQrgImage" runat="server" Width="100%" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:BoundField DataField="SLNo" HeaderText="Sl No." />
                                                <asp:BoundField DataField="DocName" HeaderText="Document Name" />
                                                <asp:TemplateField HeaderText="Document Image">
                                                    <ItemTemplate>
                                                        <asp:Image ID="ReceiptImage" runat="server" Height="150px" Width="150px" class="gridImages" CssClass="zoom imgBoxShadow"
                                                            ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Doc_Image")) %>'></asp:Image>

                                                        <div id="tooltip" style="display: none;">
                                                            <table>
                                                                <tr>
                                                                    <%--Image to Show on Hover--%>
                                                                    <td>
                                                                        <asp:Image ID="ImgComPassport" Width="150px" Height="120px" ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Doc_Image")) %>' runat="server" /></td>
                                                                </tr>
                                                            </table>
                                                        </div>


                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <input id="rdAD3Y" type="radio" class="yes" runat="server" value="1" name="QN">

                                                        <input id="rdAD3N" type="radio" class="no" runat="server" value="-1" name="QN">
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>

                                            <HeaderStyle CssClass="generate-id-heading green-background" />
                                            <PagerStyle CssClass="pgr"></PagerStyle>
                                            <RowStyle CssClass="Grid_Item" />
                                            <AlternatingRowStyle CssClass="Grid_Item_Alternaterow" />
                                            <SelectedRowStyle CssClass="Grid_Selected" />
                                            <FooterStyle CssClass="generate-id-heading green-background" />
                                        </asp:GridView>


                                    </td>
                                </tr>




                            </table>
                        </div>

                        <div id="DivEdDetails" runat="server" align="left" class="bcolour" style="text-align: center; border: 1px solid Gray; padding: 10px; border-radius: 10px; display: block; margin-bottom: 10px">
                            <div class="generate-id-heading green-background">Education Details </div>
                            <table cellpadding="0" cellspacing="0" width="100%">

                                <tr>
                                    <td align="left" class="b55">Highest Degree Earned : </td>
                                    <td align="left">
                                        <asp:Label ID="lblDegree" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtDegree" type="radio" class="yes" runat="server" value="Y" name="EHD"></th>
                                    <th>
                                        <input id="RtxtDegree" type="radio" class="no" runat="server" value="N" name="EHD"></th>
                                </tr>

                                <tr>
                                    <td align="left" class="b55">Institution Name :</td>
                                    <td align="left">
                                        <asp:Label ID="lblInstitutionName" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtInstitutionName" type="radio" class="yes" runat="server" value="Y" name="EIN"></th>
                                    <th>
                                        <input id="RtxtInstitutionName" type="radio" class="no" runat="server" value="N" name="EIN"></th>
                                </tr>

                                <tr>
                                    <td align="left" class="b55">Year of Graduation :</td>
                                    <td align="left">
                                        <asp:Label ID="lblYearGraduation" runat="server" CssClass="b99"></asp:Label></td>
                                    <th>
                                        <input id="GtxtYearGraduation" type="radio" class="yes" runat="server" value="Y" name="EYG"></th>
                                    <th>
                                        <input id="RtxtYearGraduation" type="radio" class="no" runat="server" value="N" name="EYG"></th>
                                </tr>


                                <tr>
                                    <td align="left" colspan="4" style="padding: 0px">

                                        <asp:GridView ID="gdEImage" runat="server" Width="100%" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:BoundField DataField="SLNo" HeaderText="Sl No." />
                                                <asp:BoundField DataField="DocName" HeaderText="Document Name" />
                                                <asp:TemplateField HeaderText="Document Image">
                                                    <ItemTemplate>
                                                        <asp:Image ID="ReceiptImage" runat="server" Height="150px" Width="150px" class="gridImages" CssClass="zoom imgBoxShadow"
                                                            ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Doc_Image")) %>'></asp:Image>

                                                        <div id="tooltip" style="display: none;">
                                                            <table>
                                                                <tr>
                                                                    <%--Image to Show on Hover--%>
                                                                    <td>
                                                                        <asp:Image ID="ImgPassport" Width="150px" Height="120px" ImageUrl='<%# "data:image/jpg;base64," + Convert.ToBase64String((byte[])Eval("Doc_Image")) %>' runat="server" /></td>
                                                                </tr>
                                                            </table>
                                                        </div>


                                                    </ItemTemplate>


                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <input id="rdAD4Y" type="radio" class="yes" runat="server" value="1" name="EN">

                                                        <input id="rdAD4N" type="radio" class="no" runat="server" value="-1" name="EN">
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                            </Columns>

                                            <HeaderStyle CssClass="generate-id-heading green-background" />

                                            <PagerStyle CssClass="pgr"></PagerStyle>

                                            <RowStyle CssClass="Grid_Item" />
                                            <AlternatingRowStyle CssClass="Grid_Item_Alternaterow" />
                                            <SelectedRowStyle CssClass="Grid_Selected" />
                                            <FooterStyle CssClass="generate-id-heading green-background" />
                                        </asp:GridView>

                                    </td>
                                </tr>
                                <%--  --%>
                            </table>

                        </div>

                        <div id="Div1" runat="server" align="left" style="display: block; margin-bottom: 10px">
                            <table cellpadding="2" cellspacing="5" class="bcolour" style="text-align: center; width: 100%; border: 1px solid Gray; padding: 10px; border-radius: 10px;">
                                <tr>
                                    <td colspan="4">
                                        <div class="writeComment" style="text-align: center; margin-bottom: 10px">
                                            <textarea placeholder="Write Comment here..." id="txtcomment" runat="server"></textarea>
                                        </div>
                                        <div style="text-align: center;">
                                            <asp:Button ID="btnBack" class="generate-id-heading green-background" runat="server" Text="Back" OnClick="btnBack_Click" />
                                            <asp:Button ID="btnVerify" class="generate-id-heading green-background" runat="server" Text="Data Verification" OnClick="btnVerify_Click1" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>

                    </div>


                </asp:Panel>

                <!-- Dispaly Alert -->
                <asp:Panel ID="pnlmsg" runat="server" Style="display: none;">

                    <center>
                        <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                            <p style="color: #006600" runat="server"><strong>Applicant Authorized Successfully</strong></p>
                        </div>
                    </center>
                </asp:Panel>

                <!-- Dispaly unCheck Date and Document details -->
                <asp:Panel ID="pnlunCheckData" runat="server" Style="display: none;">

                    <center>
                        <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                            <p style="color: #006600" runat="server"><strong>Need to validate uncheck data and document details !</strong></p>
                            <span>
                                <asp:Label ID="lblCheckStatus" runat="server" Text=""></asp:Label></span>
                            <br />
                            <span>
                                <asp:Label ID="lblCheckDoc" runat="server" Text=""></asp:Label></span>
                            <div style="text-align: center;">
                                <asp:Button ID="btnBackUnCheckData" class="generate-id-heading green-background" runat="server" Text="Back" OnClick="btnBackUnCheckData_Click" />
                            </div>
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

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
