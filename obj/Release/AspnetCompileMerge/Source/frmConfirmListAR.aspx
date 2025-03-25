<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="frmConfirmListAR.aspx.cs" Inherits="eCerpac_NIS.frmConfirmListAR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
        #ContentPlaceHolder1_gdEImage tr:nth-child(even),
        .applicationDetail table tr:nth-child(even) {
            background: #f4f4f4;
        }

        .Grid_Item {
            background: #f4f4f4 !important;
        }

        .Grid_Item_Alternaterow {
            background: #eaf5e5 !important;
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

        #ContentPlaceHolder1_gdAImage tr th,
        #ContentPlaceHolder1_gdAImage tr td,
        #ContentPlaceHolder1_gdQrgImage tr th,
        #ContentPlaceHolder1_gdQrgImage tr td,
        #ContentPlaceHolder1_gdEImage tr th,
        #ContentPlaceHolder1_gdEImage tr td,
        .applicationDetail table tr td,
        #ContentPlaceHolder1_gdPImage tr th,
        #ContentPlaceHolder1_gdPImage tr th {
            padding: 8px;
        }

        .applicationDetail {
            width: 355px;
            display: flex;
            align-items: center;
            margin-top: 8px;
        }

            .applicationDetail tr td {
                text-align: left;
            }

            .applicationDetail table tr td:first-child {
                width: 48%;
            }

        #ContentPlaceHolder1_DivPersonalDetails table tr td,
        #ContentPlaceHolder1_DevPassportDetails table tr td,
        #ContentPlaceHolder1_DivCompanyDetails table tr td,
        #ContentPlaceHolder1_DivEdDetails table tr td {
            border-bottom: 1px solid #ccc;
            padding: 5px;
            font-size: 16px;
        }

            #ContentPlaceHolder1_DivPersonalDetails table tr td:nth-last-child(2),
            #ContentPlaceHolder1_DevPassportDetails table tr td:nth-last-child(2),
            #ContentPlaceHolder1_DivCompanyDetails table tr td:nth-last-child(2),
            #ContentPlaceHolder1_DivEdDetails table tr td:nth-last-child(2) {
                text-align: left;
            }

            #ContentPlaceHolder1_DivPersonalDetails table tr td:first-child,
            #ContentPlaceHolder1_DevPassportDetails table tr td:first-child,
            #ContentPlaceHolder1_DivCompanyDetails table tr td:first-child,
            #ContentPlaceHolder1_DivEdDetails table tr td:first-child {
                width: 25%;
            }

            #ContentPlaceHolder1_DivPersonalDetails table tr td:last-child,
            #ContentPlaceHolder1_DevPassportDetails table tr td:last-child,
            #ContentPlaceHolder1_DivCompanyDetails table tr td:last-child,
            #ContentPlaceHolder1_DivEdDetails table tr td:last-child {
                width: 75%;
            }

        .applicationDetail table tr td {
            border: 1px solid #ccc;
        }

        #ContentPlaceHolder1_DivPersonalDetails table tr th,
        #ContentPlaceHolder1_gdQrgImage tr th,
        #ContentPlaceHolder1_gdQrgImage tr th,
        #ContentPlaceHolder1_gdEImage tr th {
            font-size: 16px;
        }

        #ContentPlaceHolder1_DivPersonalDetails table tr:last-child td:first-child {
            border: none;
        }

        #ContentPlaceHolder1_gdAImage tr th:first-child,
        #ContentPlaceHolder1_gdAImage tr td:first-child,
        #ContentPlaceHolder1_gdQrgImage tr th:first-child,
        #ContentPlaceHolder1_gdQrgImage tr td:first-child,
        #ContentPlaceHolder1_gdEImage tr th:first-child,
        #ContentPlaceHolder1_gdEImage tr td:first-child,
        #ContentPlaceHolder1_gdPImage tr th:first-child,
        #ContentPlaceHolder1_gdPImage tr td:first-child {
            width: 50px !important;
            text-align: center;
            font-weight: bold;
        }

        #ContentPlaceHolder1_DivCompanyDetails table tr.Grid_Item td:first-child,
        #ContentPlaceHolder1_DivEdDetails table tr.Grid_Item td:first-child,
        #ContentPlaceHolder1_DivEdDetails table tr.Grid_Item_Alternaterow td:first-child,
        #ContentPlaceHolder1_gdPImage table tr.Grid_Item td:first-child {
            width: 50px;
        }

        #ContentPlaceHolder1_gdAImage tr th:last-child,
        #ContentPlaceHolder1_gdAImage tr td:last-child,
        #ContentPlaceHolder1_gdQrgImage tr th:last-child,
        #ContentPlaceHolder1_gdQrgImage tr td:last-child
        #ContentPlaceHolder1_DivCompanyDetails tr th:last-child,
        #ContentPlaceHolder1_DivEdDetails tr td:last-child,
        #ContentPlaceHolder1_gdEImage tr th:last-child,
        #ContentPlaceHolder1_gdEImage tr td:last-child {
            width: 200px;
        }

        #ContentPlaceHolder1_gdPImage tr th:nth-child(2),
        #ContentPlaceHolder1_gdPImage tr td:nth-child(2) {
            width: 55%;
        }

        #ContentPlaceHolder1_DevPassportDetails table tr th:nth-child(2),
        #ContentPlaceHolder1_DevPassportDetails table tr td:nth-child(2) {
            width: 60%;
        }

        #ContentPlaceHolder1_gdEImage table tr th:nth-child(2),
        #ContentPlaceHolder1_gdEImage table tr td:nth-child(2) {
            width: 55%;
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
            background: url('../eImage_files/logo.png') 370px center no-repeat;
        }

        .back-btn {
            background: #fff;
            color: #000;
            cursor: pointer;
            border-radius: 5.2px;
            padding: 8px 24px;
            font-weight: bold;
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
    <asp:Panel ID="pnlMain" runat="server" Style="display: block">
        <center>
            <div align="center" class="bcolour" id="div_main" runat="server">
                <table cellpadding="2" cellspacing="10" style="width: 95%" id="combox">
                    <tr>
                        <td colspan="3" style="height: 5px">
                            <div class="generate-id-heading green-background">Gratis Queue </div>
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
                                                OnPageIndexChanging="GridViewCntcAuthAO_PageIndexChanging" OnRowDataBound="GridViewCntcAuthAO_RowDataBound" OnRowCommand="GridViewCntcAuthAO_RowCommand" OnSelectedIndexChanged="GridViewCntcAuthAO_SelectedIndexChanged">
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
                                                        <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="true" Width="35%" />
                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="true" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Datetime" SortExpression="CreatedOn">
      <HeaderTemplate>
          <asp:LinkButton runat="server" ID="lblDate" Text="Date" OnClick="lnkNormal_Click" CommandArgument="CreatedOn" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
      </HeaderTemplate>
      <ItemTemplate>
          <asp:Label ID="Label3" runat="server" Text='<%# Bind("CreatedOn") %>'></asp:Label>
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


        <asp:ImageButton ID="imgBtnAssign" runat="server" ImageUrl="~/eImage_files/Task_not_assigned.jpg" OnClientClick='viewDetails(<%# Eval("FORMNO") %>); ' Width="25px" ToolTip="Assign to me" />
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

                        </td>
                    </tr>

                </table>
            </div>
        </center>
    </asp:Panel>


    <!-- Dispaly Details -->
    <asp:Panel ID="pnldisplay" runat="server" Style="display: none; padding: 10px">
        <div style="padding: 10px">
            <div id="DivAuthDetails" runat="server" align="center" class="bcolour" style="text-align: center; border: 1px solid Gray; padding: 10px; border-radius: 10px; display: block; margin-bottom: 10px">
                <div style="text-align: center; display: flex; flex-direction: row; justify-content: space-between" class="generate-id-heading green-background">
                    <span class="fs16">Applicant Name :
                      
                        <asp:Label ID="HlblTitle" runat="server" CssClass="b99"></asp:Label>
                        <asp:Label ID="HlblFristName" runat="server" CssClass="b99"></asp:Label>
                        <asp:Label ID="HlblLastName" runat="server" CssClass="b99"></asp:Label></span>
                    <span class="fs16">Application Number :
                      
                        <asp:Label ID="lblCerpacNo1" runat="server" CssClass="b99"></asp:Label></span>
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
                                    <asp:Label ID="lblPaymentMode" runat="server" CssClass="b99" Text="Offline"></asp:Label></td>
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
                    <asp:UpdatePanel runat="server" ID="UpdatePic" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Image runat="server" ID="ImgPhoto" ImageUrl="~/eImage_files/default_logo.gif" Style="border: 1px solid #006600; height: 175px; width: 150px; border-radius: 5%; padding: 5px; margin-top: 10px; box-shadow: 0 0 10px #a6b6ae;" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <%---<table id="tbl12" cellpadding="0" cellspacing="0" border="0" width="100%" runat="server">
               <tr class="b11">
                   <td align="center" style="width: 10%; vertical-align: middle; text-align: center; background-repeat: no-repeat;">

                       <asp:UpdatePanel runat="server" ID="UpdatePic" UpdateMode="Conditional">
                           <ContentTemplate>
                               <center>
                                   <div id="DivPic" style="position: relative; width: 50%;">

                                       <asp:Image runat="server" ID="ImgPhoto" ImageUrl="~/eImage_files/default_logo.gif" Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1; border: 1px solid #006600; height: 175px; width: 150px; border-radius: 5%; background-blend-mode: lighten; box-shadow: 0 0 25px var(--border-color, #);" />
                                       
                                   </div>
                               </center>
                           </ContentTemplate>

                       </asp:UpdatePanel>
                   </td>

               </tr>

               <tr>
                   <td align="center" style="width: 10%; vertical-align: middle; text-align: center; background-repeat: no-repeat;">eCERPAC No. :     
                       <asp:Label ID="lblCerpacNo1" runat="server" CssClass="b99"></asp:Label>

                   </td>
               </tr>

           </table> ---%>
            </div>

            <div id="DivPersonalDetails" runat="server" align="left" class="bcolour" style="text-align: center; border: 1px solid Gray; padding: 10px; border-radius: 10px; display: block; margin-bottom: 10px">
                <div style="text-align: left;" class="generate-id-heading green-background">Personal Details </div>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" class="b55">Title : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblTitle" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>

                        <td align="left" class="b55">First Name : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblFristName" runat="server" CssClass="b99"></asp:Label>
                        </td>

                    </tr>
                    <tr>

                        <td align="left" class="b55">Last Name : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblLastName" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>

                        <td align="left" class="b55">Date of Birth :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblDOB" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>

                        <td align="left" class="b55">Sex : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblSex" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>

                        <td align="left" class="b55">Nationality : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblNationality" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>
                        <td align="left" class="b55">Place of Birth : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblPOB" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>
                        <td align="left" class="b55">E-mail ID : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblemailId" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>
                        <td align="left" class="b55">Contact No :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblContactNo" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>
                        <td align="left" class="b55">Address 1 :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblAddress1" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>
                        <td align="left" class="b55">Address 2 :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblAddress2" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" colspan="2" style="padding: 0px">


                            <asp:GridView ID="gdPImage" runat="server" Width="100%" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="SLNo" HeaderText="Sl No." />

                                    <asp:TemplateField HeaderText="Document Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocName" runat="server" Text='<%# Bind("DocName") %>'></asp:Label>
                                        </ItemTemplate>

                                    </asp:TemplateField>

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
                                    <asp:TemplateField HeaderText="Check">
                                        <ItemTemplate>
                                            <input id="rdAD1Y" type="radio" class="yes" runat="server" value="1" name="PN">Yes
                                          
                                            <input id="rdAD1N" type="radio" class="no" runat="server" value="-1" name="PN">No
                                       
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
                <div style="text-align: left;" class="generate-id-heading green-background">Passport Details </div>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" class="b55">Passport No. :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblPassportNo" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Place of Issue : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblPlaceOfIssue" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Passport Issued By : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblPassportIssuedBy" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Date of Issue : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblPassportIssueDate" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Date of Expiry :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblPassportExpiryDate" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" colspan="2" style="padding: 0px">


                            <asp:GridView ID="gdAImage" runat="server" Width="100%" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="SLNo" HeaderText="Sl No." />

                                    <asp:TemplateField HeaderText="Document Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocName" runat="server" Text='<%# Bind("DocName") %>'></asp:Label>
                                        </ItemTemplate>

                                    </asp:TemplateField>
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
                                    <asp:TemplateField HeaderText="Check">
                                        <ItemTemplate>
                                            <input id="rdAD2Y" type="radio" class="yes" runat="server" value="1" name="LN">Yes 
                                          
                                            <input id="rdAD2N" type="radio" class="no" runat="server" value="-1" name="LN">No
                                       
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

            <div id="DivCompanyDetails" runat="server" align="left" class="bcolour" style="text-align: center; border: 1px solid Gray; padding: 10px; border-radius: 10px; display: block; margin-bottom: 10px">
                <div style="text-align: left" class="generate-id-heading green-background">Company Details </div>
                <table cellpadding="0" cellspacing="0" width="100%">

                    <tr>
                        <td align="left" class="b55">Company RC No. :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblCompanyRC" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>
                    <tr>
                        <td align="left" class="b55">Company Name :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblCompanyName" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Company Address 1 :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblComAddress1" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Company Address 2 :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblComAddress2" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Designation :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblDesignation" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>

                        <td align="left" class="b55">Company Telephone No. :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblComTelephone" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Company Fax Number :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblComFaxNo" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Date of Employment :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblEmploymentDt" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" colspan="2" style="padding: 0px">
                            <asp:GridView ID="gdQrgImage" runat="server" Width="100%" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="SLNo" HeaderText="Sl No." />
                                    <asp:TemplateField HeaderText="Document Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocName" runat="server" Text='<%# Bind("DocName") %>'></asp:Label>
                                        </ItemTemplate>

                                    </asp:TemplateField>
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
                                    <asp:TemplateField HeaderText="Check">
                                        <ItemTemplate>
                                            <input id="rdAD3Y" type="radio" class="yes" runat="server" value="1" name="QN">Yes
                                          
                                            <input id="rdAD3N" type="radio" class="no" runat="server" value="-1" name="QN">No
                                       
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
                <div style="text-align: left" class="generate-id-heading green-background">Education Details </div>
                <table cellpadding="0" cellspacing="0" width="100%">

                    <tr>
                        <td align="left" class="b55">Highest Degree Earned : </td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblDegree" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Institution Name :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblInstitutionName" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>

                    <tr>
                        <td align="left" class="b55">Year of Graduation :</td>
                        <td align="left" class="b55">
                            <asp:Label ID="lblYearGraduation" runat="server" CssClass="b99"></asp:Label></td>

                    </tr>


                    <tr>
                        <td align="left" colspan="2" style="padding: 0px">

                            <asp:GridView ID="gdEImage" runat="server" Width="100%" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="SLNo" HeaderText="Sl No." />
                                    <asp:TemplateField HeaderText="Document Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocName" runat="server" Text='<%# Bind("DocName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
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
                                    <asp:TemplateField HeaderText="Check">
                                        <ItemTemplate>
                                            <input id="rdAD4Y" type="radio" class="yes" runat="server" value="1" name="EN">Yes
                                          
                                            <input id="rdAD4N" type="radio" class="no" runat="server" value="-1" name="EN">No
                                       
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

            <div id="Div1" runat="server" align="left" class="bcolour" style="border: 1px solid Gray; padding: 10px; border-radius: 10px; display: block; margin-bottom: 10px">
                <div class="generate-id-heading green-background" style="text-align: left; margin-bottom: 10px;">Comments & Verification</div>
                <div class="common-ctrl">
                    <table class="cttable" cellpadding="0" cellspacing="0" width="100%">
                        <tbody style="display: none;">
                            <tr>
                                <td>Level :</td>
                                <td>L1</td>
                            </tr>
                            <tr>
                                <td>Name :</td>
                                <td>
                                    <asp:Label ID="lblNameL1" runat="server" CssClass="b99"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Comment :</td>
                                <td>
                                    <asp:Label ID="lblCommetL1" runat="server" CssClass="b99"></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>

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
                                    <asp:Label ID="Label1" runat="server" CssClass="b99"></asp:Label></td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" CssClass="b99"></asp:Label></td>
                            </tr>
                            <tr style="display: none;">
                                <td>L2</td>
                                <td>
                                    <asp:Label ID="lblNameL2" runat="server" CssClass="b99"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lblCommetL2" runat="server" CssClass="b99"></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>


                <div class="writeComment">
                    <div class="cleft">
                        <asp:DropDownList class="emov-dash-icon-cover1" Width="100%" ID="commentList" Style="margin-right: 5px; background-color: #f8f8f8; padding: 5px 5px 5px 15px; border: 1px solid #f8f8f8;" runat="server">
                            <%--<asp:ListItem Text="Select" Value="" />--%>
                            <asp:ListItem Text="Document Verified" Value="A" />
                            <asp:ListItem Text="Document not Verified" Value="P" />
                            <%--<asp:ListItem Text="Document partially verified" Value="N" />--%>
                        </asp:DropDownList>
                    </div>
                    <div class="cright">
                        <textarea placeholder="Please Enter Your Comments..." maxlength="70" id="txtcomment" validationgroup="a2" runat="server" onkeyup="updateCharCount()" onkeydown="updateCharCount()" onpaste="updateCharCount()" oninput="updateCharCount()"></textarea>
                        <span style="color: red; text-align: justify; font-size: medium;">*</span>
                        <br />
                        <span id="charCount">Characters remaining: 70</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtcomment" Display="Dynamic"
                            ErrorMessage="Please Enter Your Comments..." ValidationGroup="a2" SetFocusOnError="True" ForeColor="red"></asp:RequiredFieldValidator>

                    </div>
                </div>
                <div style="text-align: center;">
                    <asp:Button ID="btnBack" class="generate-id-heading green-background" runat="server" Text="Back" OnClick="btnBack_Click" />
                    <asp:Button ID="btnVerify" class="generate-id-heading green-background" runat="server" ValidationGroup="a2" Text="Submit" OnClick="btnVerify_Click" />
                </div>
            </div>

        </div>




    </asp:Panel>

    <!-- Dispaly Alert -->
    <asp:Panel ID="pnlmsg" runat="server" Style="display: none;">

        <center>
            <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                <p style="color: #006600" runat="server"><strong>Applicant Documents Verified Successfully</strong></p>
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
