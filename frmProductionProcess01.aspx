<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="True" EnableEventValidation="false" CodeBehind="frmProductionProcess01.aspx.cs" Inherits="eCerpac_NIS.frmProductionProcess01" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--Converted Div as image and send Mail --%>

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
    <script type="text/javascript">
        function ConvertToImage(btnExport) {
            html2canvas($('[id*=DivPrintCard]')[0], {
                onrendered: function (canvas) {
                    var base64 = canvas.toDataURL();
                    $("[id*=hfImageData]").val(base64);
                    __doPostBack(btnExport.name, "");
                }
            });
            return false;
        }
    </script>

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

    <asp:Panel ID="pnlMain" runat="server" Style="display: block">

        <center>
            <table cellpadding="2" cellspacing="10" style="width: 95%" id="combox">
                <tr>
                    <td colspan="3" style="height: 5px">
                        <div class="PageNameHeadingCSS" style="text-align: center">


                            <div class="generate-id-heading green-background" style="text-align: center;">Digital Card</div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td height="15">
                        <asp:Label ID="lblloginmsg" runat="server" Text="Label"></asp:Label>
                        <asp:Label ID="lblmsg" runat="server" CssClass="information-box abc" Text="" Font-Size="Small"></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td>
                        <table class="t11" style="width: 100%;">
                            <tr>
                                <td align="left" style="height: 16px; width: 58%;">
                                    <span style="color: red; text-align: start; font-size: medium;">
                                        <asp:TextBox ID="TextAppId" runat="server" AutoComplete="Off" Placeholder="Please enter eCERPAC number/ Form number" Text="" ValidationGroup="a1" Width="350px" CssClass="textbox2"
                                            Height="20px"></asp:TextBox  >&nbsp;*</span>                                    

                                </td>
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

                        </table>
                        <table class="t11" style="width: 100%;">
                            <tr>
                                <td valign="top" align="center" style="width: 100%; text-align: left;">


                                    <div id="div_grd" runat="server">
                                        <asp:GridView ID="grd_display_data" runat="server" AutoGenerateColumns="false" class="generate-id-heading green-background"
                                            AllowPaging="true" PageSize="5" CssClass="GridBaseStyle"
                                            PagerStyle-CssClass="pgr" CellSpacing="1" CellPadding="7" Width="100%"
                                            OnPageIndexChanging="grd_display_data_PageIndexChanging" OnRowDataBound="grd_display_data_RowDataBound" OnRowCommand="grd_display_data_RowCommand" OnSelectedIndexChanged="grd_display_data_SelectedIndexChanged">
                                            <AlternatingRowStyle CssClass="Grid_Item_Alternaterow" />
                                            <Columns>


                                                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>

                                                <asp:BoundField DataField="MiddleName" HeaderText="Middle Name" SortExpression="MiddleName" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" Visible="false">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>

                                                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>

                                                <asp:BoundField DataField="CompanyName" Visible="false" HeaderText="Company Name" SortExpression="Company" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>

                                                <asp:BoundField DataField="Nationality" HeaderText="Nationality" SortExpression="Nationality" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>

                                                <asp:BoundField DataField="RequisitionNo" HeaderText="Req No." SortExpression="RequisitionNo" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" Visible="false">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>

                                                <asp:BoundField DataField="Cerpac_No" HeaderText="eCerpac No." SortExpression="Cerpac_No" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>

                                                <asp:BoundField DataField="FormNo" HeaderText="Form No." SortExpression="FormNo" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>


                                                <asp:BoundField DataField="PassportNo" HeaderText="Passport No." SortExpression="PassportNo" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" Visible="false">

                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>

                                                <asp:BoundField DataField="StrVisaNo" HeaderText="Str Visa No." SortExpression="StrVisaNo" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" Visible="false">



                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>



                                            </Columns>

                                            <HeaderStyle CssClass="generate-id-heading green-background" />

                                            <PagerStyle CssClass="pgr"></PagerStyle>

                                            <RowStyle CssClass="Grid_Item" />
                                            <AlternatingRowStyle CssClass="Grid_Item_Alternaterow" />
                                            <SelectedRowStyle CssClass="Grid_Selected" />
                                            <FooterStyle CssClass="generate-id-heading green-background" />
                                        </asp:GridView>

                                    </div>

                                </td>

                            </tr>

                        </table>

                    </td>
                </tr>
            </table>

        </center>
    </asp:Panel>
    <asp:Panel ID="pnldisplay" runat="server" Style="display: block">

        <center>
            <table cellpadding="5" cellspacing="2" border="0" width="750px" id="detailtable" runat="server">

                <tr class="b11">
                    <td align="center" style="width: 10%; vertical-align: middle; text-align: center; background-repeat: no-repeat;"
                        colspan="4">
                        <asp:Image runat="server" ID="ImgPhoto" Width="100px" Height="120px" ImageUrl="~/eImage_files/default_logo.gif"
                            Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1; border: 1px solid #006600; height: 175px; width: 150px; border-radius: 5%; background-blend-mode: lighten; box-shadow: 0 0 25px var(--border-color, #);" />

                    </td>
                </tr>

                <tr class="b77">
                    <td colspan="4" align="left" class="t55">
                        <strong>Passport Details</strong>
                    </td>
                </tr>

                <tr class="t11">
                    <td colspan="4" align="center" style="height: 2px;"></td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">Passport No.
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtPassportNo" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Nationality
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtNationality" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">Passport Issue By
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtPassportType" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Date Of Issue
                    </td>
                    <td align="left" style="width: 190px">
                        <asp:Label ID="TxtDateOfIssue" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">Date of Expiry
                    </td>
                    <td align="left" style="width: 150px;">
                        <asp:Label ID="txtdoe" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Place of Issue
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtPlaceOfIssue" runat="server" class="b99"></asp:Label>
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
                        <asp:Label ID="TxtFirstName" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Last Name
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtLastName" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">Middle Name
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtMiddleName" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Sex
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtSex" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">Email Id
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtemailprsn" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Contact Number
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtcntcnoprsn" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr class="t11">
                    <td colspan="4" align="center" style="height: 2px;">&nbsp;
                    </td>
                </tr>
                <tr class="b77">
                    <td colspan="4" align="left" class="t55">
                        <strong>eCERPAC Details</strong>
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
                        <asp:Label ID="TxtCerpacNo" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">eCerpac Issue Date
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtIssueDate" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">eCerpac Expiry Date
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="TxtExpDate" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">eCerpac File No.
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtfileno" runat="server" class="b99"></asp:Label>
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
                    <td align="left" style="width: 150px;" class="b55">Company Code
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtcompid" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Company Name
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtcompname" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">Company Address 1
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtcompadd1" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Company Address 2
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtcompadd2" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">Designation
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtdesig" runat="server" class="b99"></asp:Label>
                    </td>
                    <td align="left" style="width: 150px;" class="b55">Company Telephone No.
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtphno" runat="server" class="b99"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 150px;" class="b55">Company Fax No.
                    </td>
                    <td align="left" style="width: 190px;">
                        <asp:Label ID="txtfaxno" runat="server" class="b99"></asp:Label>
                    </td>

                </tr>

                <tr class="b11">
                    <td colspan="4" align="left" style="height: 20px;"></td>
                </tr>
                <tr class="b11">
                    <td align="center" colspan="4">
                        <asp:Button ID="btnCardGen" runat="server" class="generate-id-heading green-background"
                            Text="Generate Digital Card" OnClick="btnCardGen_Click" />

                        <asp:Button ID="btn_back" runat="server" class="generate-id-heading green-background"
                            Text="Back" OnClick="btn_back_Click" />

                    </td>
                </tr>
                <tr>
                    <td height="25px"></td>
                </tr>

            </table>




        </center>
    </asp:Panel>
    <asp:Panel ID="pnlCard" runat="server" Style="display: block">
        <center>
            <div align="center">
                <table cellpadding="2" cellspacing="10" style="width: 95%">
                    <tr>

                        <td style="height: 5px">
                            <div class="PageNameHeadingCSS" style="text-align: center">
                                <div class="generate-id-heading green-background" style="width: 90%;">eCerpac Card</div>
                            </div>
                        </td>
                    </tr>


                    <tr>
                        <td align="center" colspan="5">
                            <div id="DivPrintCard">
                                <div id="Accordion1" style="font-size: 12px;" tabindex="0">
                                    <div class="AccordionPanel">

                                        <div class="AccordionPanelContent">

                                            <center>
                                                <table id="tbl1" cellpadding="5" cellspacing="2" border="0" width="750px"
                                                    style="height: 355px">

                                                    <tr>
                                                        <td align="right" style="width: 10%; vertical-align: middle; text-align: center;">
                                                            <center>
                                                                <div style="background-image: url('eImage_files/fCard.png'); height: 350px; width: 564px; border: 0px solid black; background-repeat: no-repeat;" align="right">

                                                                    <div id="container" style="position: relative;">
                                                                        <asp:Image ID="Image1" runat="server" Style="position: absolute; border: 0px solid #006600; height: 175px; width: 150px; top: 90px; left: 50px; border-radius: 5%; background-blend-mode: lighten; box-shadow: 0 0 25px var(--border-color, #);" />

                                                                    </div>

                                                                    <table style="width: 53%;">
                                                                        <br />
                                                                        <br />
                                                                        <br />

                                                                        <tr>
                                                                            <td>
                                                                                <br />
                                                                                <br />
                                                                            </td>
                                                                            <td>
                                                                                <br />
                                                                                <br />
                                                                            </td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left; color: darkgreen;">Name
                                                                            </td>

                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left; animation-name: blink; animation-duration: .5s; border-width: thin;">
                                                                                <asp:Label ID="lbl_name" runat="server" Text="PIA ANGELA" Font-Bold="true" Width="300px"></asp:Label>
                                                                                <br />
                                                                            </td>



                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left; color: darkgreen;">Company
                                                                            </td>

                                                                        </tr>
                                                                        <tr>

                                                                            <td style="width: 128px"></td>

                                                                            <td style="text-align: left">

                                                                                <asp:Label ID="txt_comps" runat="server" Text="" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px">&nbsp;</td>
                                                                            <td style="text-align: left; color: darkgreen;">Designation
                                                                            </td>

                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="lbl_desig" runat="server" Font-Bold="true" Text="56982145"></asp:Label>

                                                                            </td>



                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px;">&nbsp;
                                      
                                                                            </td>
                                                                            <td style="text-align: left; color: darkgreen;">Passport No.
                                                                            </td>

                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left; animation-name: blink; animation-duration: .5s;">
                                                                                <asp:Label ID="lbl_passport" runat="server" Font-Bold="true" Text="745698213"> </asp:Label>
                                                                                <br />
                                                                            </td>



                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left; color: darkgreen;">Nationality
                                                                            </td>

                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="lbl_nationality" runat="server" Font-Bold="true" Text="UTOPIA"></asp:Label>

                                                                            </td>



                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left; color: darkgreen;">eCerpac No.
                                                                            </td>

                                                                        </tr>

                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="lbl_cerpac_no" runat="server" Font-Bold="true" Text=""></asp:Label>
                                                                            </td>



                                                                        </tr>


                                                                    </table>

                                                                </div>
                                                            </center>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </center>
                                        </div>
                                    </div>
                                    <div class="AccordionPanel">


                                        <div class="AccordionPanelContent">


                                            <center>
                                                <table id="Table1" cellpadding="5" cellspacing="2" border="0" width="750px"
                                                    style="height: 355px">
                                                    <tr class="b11">
                                                        <td align="right" style="width: 10%; vertical-align: middle; text-align: center;">

                                                            <center>
                                                                <div style="background-image: url('eImage_files/bCard.png'); height: 350px; width: 564px; border: 0px solid black; background-repeat: no-repeat;" align="right">
                                                                    <br />
                                                                    <br />
                                                                    <br />
                                                                    <br />
                                                                    <br />



                                                                    <table style="width: 53%;">


                                                                        <tr>

                                                                            <td align="center" colspan="2" class="auto-style1">

                                                                                <div>
                                                                                    <asp:Image ID="img_QRCode" runat="server" Visible="false" Height="150px" Width="150px" />
                                                                                </div>

                                                                            </td>
                                                                        </tr>
                                                                        <tr align="center" colspan="2" class="auto-style1">

                                                                            <td colspan="2">
                                                                                <asp:Image ID="img_sign" runat="server" Height="37px" Width="174px" /></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td style="text-align: left; color: darkgreen;">Date Of Expiry</td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="lbl_expiry_date" runat="server" Font-Bold="true" Text=""></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left"></td>
                                                                        </tr>
                                                                        <tr style="display: none;">
                                                                            <td style="width: 128px" align="left">Date Of Issue</td>
                                                                            <td style="text-align: left" align="left">
                                                                                <asp:Label ID="lbl_date_of_issue" runat="server" Font-Bold="true" Text=""></asp:Label>
                                                                            </td>

                                                                        </tr>

                                                                        <tr style="display: none;">
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left"></td>



                                                                        </tr>

                                                                        <tr style="display: none;">
                                                                            <td style="width: 128px" align="left">Place Of Issue</td>
                                                                            <td style="text-align: left" align="left">
                                                                                <asp:Label ID="lbl_place_of_issue" runat="server" Text=""></asp:Label>

                                                                                <asp:Label ID="lbl_dob" runat="server" Visible="false" Text=""></asp:Label>
                                                                            </td>

                                                                        </tr>


                                                                        <tr>
                                                                            <td style="width: 128px"></td>
                                                                            <td style="text-align: left"></td>

                                                                            <asp:Label ID="lbl_cerpac_file_no" runat="server" Visible="false" Text=""></asp:Label>


                                                                        </tr>
                                                                    </table>

                                                                </div>
                                                            </center>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </center>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="5">
                            <center>
                                <div id="Divbtn">

                                    <asp:Button ID="btnApprove" runat="server" class="generate-id-heading green-background" Text="Proceed & Send Digital Card" OnClientClick="return ConvertToImage(this)" OnClick="btnApprove_Click" />
                                    <asp:Button ID="btnBack1" runat="server" class="generate-id-heading green-background" Text="Back" OnClientClick="return ConvertToImage(this)" OnClick="btnBack1_Click" />

                                </div>
                            </center>
                            <asp:HiddenField ID="hfImageData" runat="server" />
                        </td>
                    </tr>

                </table>
            </div>

        </center>
    </asp:Panel>

    <!-- Dispaly Alert -->
    <asp:Panel ID="pnlmsg" runat="server" Style="display: none;">

        <center>
            <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
                <p style="color: #006600" runat="server"><strong>eCERPAC Card Verified and Send Sucessfully</strong></p>
            </div>
        </center>
    </asp:Panel>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
