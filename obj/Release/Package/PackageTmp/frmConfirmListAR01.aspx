<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="frmConfirmListAR01.aspx.cs" Inherits="eCerpac_NIS.frmConfirmListAR01" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


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

    <strong></strong>
    <asp:Panel ID="pnlMain" runat="server" Style="display: block">

        <center>
            <div align="center" class="bcolour" id="div_main" runat="server">
                <table cellpadding="2" cellspacing="10" style="width: 95%">
                    <tr>
                        <td colspan="3" style="height: 5px">
                            <div class="PageNameHeadingCSS" style="text-align: center">
                                <font class="b12">

                                    <div class="generate-id-heading green-background">Eligibility Process  (AR category) </div>

                                </font>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td align="center">
                            <span>
                                <asp:Label ID="lblmsg" runat="server" Text="" Font-Size="Small" Width="420px"></asp:Label>
                                <asp:Label ID="lblloginmsg" runat="server" Text="Label"></asp:Label>
                            </span>

                        </td>
                    </tr>
                </table>
                <table cellpadding="5" border="0" cellspacing="5" style="width: 95%">
                    <tr>
                        <td align="left" style="height: 16px; width: 58%;">
                            <span style="color: red; text-align: start; font-size: medium;">
                                <asp:TextBox ID="TextAppId" runat="server" AutoComplete="Off" Placeholder="Please enter eCERPAC number/ Form number" Text="" ValidationGroup="a1" Width="350px" CssClass="textbox2"
                                    Height="20px"></asp:TextBox>&nbsp;*</span>

                        </td>
                        <td align="left" style="height: 16px; width: 100%">

                            <asp:Button ID="Go" runat="server" Text="Search" class="generate-id-heading green-background" ValidationGroup="a1"
                                OnClick="Go_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td height="20px" colspan="2">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextAppId" Display="Dynamic"
                                ErrorMessage="Please enter eCERPAC number/ Form number" ValidationGroup="a1" SetFocusOnError="True" ForeColor="red"></asp:RequiredFieldValidator>


                        </td>

                    </tr>
                    <tr>
                        <td colspan="2">
                            <table>

                                <tr>
                                    <td align="left">

                                        <asp:GridView ID="GridViewAuth" PagerStyle-CssClass="pgr" runat="server" Width="100%"
                                            AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" CellSpacing="1" CssClass="GridBaseStyle" DataKeyNames="cerpac_no"
                                            OnPageIndexChanging="GridViewAuth_PageIndexChanging" OnRowDataBound="GridViewAuth_RowDataBound" OnRowCommand="GridViewAuth_RowCommand" OnSelectedIndexChanged="GridViewAuth_SelectedIndexChanged">

                                            <Columns>


                                                <asp:TemplateField HeaderText="Name" SortExpression="Name" HeaderStyle-Width="25%">
                                                    <HeaderTemplate>
                                                        <asp:LinkButton runat="server" ID="lblName" Text="Name" OnClick="lnkNormal_Click" CommandArgument="Name" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="server" ToolTip='<%# Bind("Name") %>' Text='<%# Bind("Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="false"  />
                                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="false" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Cerpac No." SortExpression="cerpac_no"  HeaderStyle-Width="10%">
                                                    <HeaderTemplate>
                                                        <asp:LinkButton runat="server" ID="lblCerpacNo" Text="Cerpac No." OnClick="lnkNormal_Click" CommandArgument="cerpac_no" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCerpacNo" runat="server" Text='<%# Bind("cerpac_no") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="false"  />
                                                    <ItemStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="false" />
                                                </asp:TemplateField>


                                                <asp:TemplateField HeaderText="Form No." SortExpression="FORMNO" HeaderStyle-Width="10%">
                                                    <HeaderTemplate>
                                                        <asp:LinkButton runat="server" ID="lblFORMNO" Text="Form No." OnClick="lnkNormal_Click" CommandArgument="FORMNO" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFORMNO" runat="server" Text='<%# Bind("FORMNO") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" />
                                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" />
                                                </asp:TemplateField>


                                                <asp:TemplateField HeaderText="Company Name" SortExpression="Company" HeaderStyle-Width="250px">
                                                    <HeaderTemplate>
                                                        <asp:LinkButton runat="server" ID="lblCompanyName" Text="Company Name" OnClick="lnkNormal_Click" CommandArgument="Company" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCompanyName" runat="server" Text='<%# Bind("Company") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False"  />
                                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Nationality" SortExpression="Nationality"  HeaderStyle-Width="15%">
                                                    <HeaderTemplate>
                                                        <asp:LinkButton runat="server" ID="lblNationality" Text="Nationality" OnClick="lnkNormal_Click" CommandArgument="Nationality" ForeColor="white" Font-Underline="False" ToolTip="Sort" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNationality" runat="server" Text='<%# Bind("Nationality") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Wrap="False"  />
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


                            </table>
                            &nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>

                </table>
            </div>
        </center>
    </asp:Panel>

    <!-- Dispaly Details -->
    <asp:Panel ID="pnlDetails" runat="server" Style="display: none;">
        <cente>
            <div id="Div_ContentPlaceHolder" align="center" class="bcolour">
                <table cellpadding="2" cellspacing="5" class="bcolour" style="width: 98%" id="combox">
                    <tr>
                        <td colspan="3" style="height: 5px">
                            <div class="generate-id-heading green-background">Eligibility Process </div>

                        </td>
                    </tr>
                    <tr class="t11">
                        <td align="center" colspan="2">
                            <asp:Label ID="reviewmsg" runat="server" ForeColor="#990000"></asp:Label>
                            <asp:Label ID="msg" runat="server" ForeColor="#339933"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <center>
                                <table id="tbl1" cellpadding="5" cellspacing="2" border="0" width="750px">
                                    <tr class="b11">
                                        <td align="center" style="width: 10%; vertical-align: middle; text-align: center; background-repeat: no-repeat;">
                                            <asp:Image runat="server" ID="ImgPhoto" Width="100px" Height="120px" ImageUrl="~/eImage_files/default_logo.gif"
                                                Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1; border: 1px solid #006600; height: 175px; width: 150px; border-radius: 5%; background-blend-mode: lighten; box-shadow: 0 0 25px var(--border-color, #);" />
                                        </td>
                                    </tr>
                                </table>


                                <div id="authtable" runat="server">
                                    <table cellpadding="5" cellspacing="2" border="0" width="750px" id="detailtable" runat="server">
                                        <tr class="b77">
                                            <td colspan="4" align="left" class="t55">
                                                <strong>Passport Details</strong>
                                            </td>
                                        </tr>
                                        <tr class="t11">
                                            <td colspan="4" align="center" style="height: 2px;">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">Passport No.
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtPassportNo" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">Nationality
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtNationality" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">Passport Issue By
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtPassportType" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">Date Of Issue
                                            </td>
                                            <td align="left" style="width: 190px">
                                                <asp:Label ID="TxtDateOfIssue" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">Date of Expiry
                                            </td>
                                            <td align="left" style="width: 150px;">
                                                <asp:Label ID="txtdoe" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">Place of Issue
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtPlaceOfIssue" runat="server" CssClass="b99"></asp:Label>
                                            </td>

                                        </tr>
                                        <tr class="t11">
                                            <td colspan="4" align="center" style="height: 2px;">&nbsp;
                                            </td>
                                        </tr>
                                        <tr class="b77">
                                            <td colspan="4" align="left" class="t55">
                                                <strong>Personal Details</strong>
                                            </td>
                                        </tr>
                                        <tr class="t11">
                                            <td colspan="4" align="center" style="height: 2px;">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">First Name
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtFirstName" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">Last Name
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtLastName" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">Middle Name
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtMiddleName" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">Sex
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtSex" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">Email Id
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtemailprsn" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">Contact Number
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtcntcnoprsn" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="t11">
                                            <td colspan="4" align="center" style="height: 2px;">&nbsp;
                                            </td>
                                        </tr>
                                        <tr class="b77">
                                            <td colspan="4" align="left" class="t55">
                                                <strong>eCerpac Details</strong>
                                            </td>
                                        </tr>
                                        <tr class="t11">
                                            <td colspan="4" align="center" style="height: 2px;">&nbsp;
                                            </td>
                                        </tr>

                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">eCerpac Number
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtCerpacNo" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">eCerpac Issue Date
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtIssueDate" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">eCerpac Expiry Date
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="TxtExpDate" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">eCerpac File No.
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtfileno" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="t11">
                                            <td colspan="4" align="center" style="height: 2px;">&nbsp;
                                            </td>
                                        </tr>
                                        <tr class="b77">
                                            <td colspan="4" align="left" class="t55">
                                                <strong>Company Details</strong>
                                            </td>
                                        </tr>
                                        <tr class="t11">
                                            <td colspan="4" align="center" style="height: 2px;">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>

                                            <td align="left" style="width: 150px;" class="b55">Company Name
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtcompname" runat="server" CssClass="b99"></asp:Label>
                                            </td>

                                            <td align="left" style="width: 150px; display: none" class="b55">Company Id
                                            </td>
                                            <td align="left" style="width: 190px; display: none;">
                                                <asp:Label ID="txtcompid" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">Company Address 1
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtcompadd1" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">Company Address 2
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtcompadd2" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">Designation
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtdesig" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                            <td align="left" style="width: 150px;" class="b55">Company Telephone No.
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtphno" runat="server" CssClass="b99"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="width: 150px;" class="b55">Company Fax No.
                                            </td>
                                            <td align="left" style="width: 190px;">
                                                <asp:Label ID="txtfaxno" runat="server" CssClass="b99"></asp:Label>
                                            </td>

                                        </tr>





                                        <tr class="b11">
                                            <td colspan="4" align="left" style="height: 20px;"></td>
                                        </tr>
                                        <tr class="b11">

                                            <td align="center" colspan="4">
                                                <asp:Button ID="btnverify" runat="server" class="generate-id-heading green-background" Text="Confirm" Width="140px" OnClick="btnverify_Click" OnClientClick="change()" />
                                                <asp:Button ID="BtnDefer" runat="server" Text="Defer" Width="149px" class="generate-id-heading green-background" OnClick="BtnDefer_Click" />
                                                <asp:Button ID="btnDenycompletely" Text="Deny Completely" runat="server" class="generate-id-heading green-background" OnClick="btnDenycompletely_Click" />

                                            </td>

                                        </tr>
                                        <tr>
                                            <td height="25px"></td>
                                        </tr>
                                    </table>

                                </div>
                                <div id="DivEdDetails" runat="server" align="left" style="display: none;">
                                    <table cellpadding="2" cellspacing="5" class="bcolour" style="text-align: center; width: 100%; border: 2px solid Gray; padding: 10px; border-radius: 25px;">
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
                        </td>
                    </tr>
                </table>
            </div>
        </cente>

    </asp:Panel>

    <!-- Dispaly Alert -->
    <asp:Panel ID="pnlmsg" runat="server" Style="display: none;">

        <center>
            <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                <p style="color: #006600" runat="server"><strong>Applicant Verified Sucessfully</strong></p>
            </div>
        </center>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
