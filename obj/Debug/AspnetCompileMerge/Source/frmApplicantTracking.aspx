<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" CodeBehind="frmApplicantTracking.aspx.cs" Inherits="eCerpac_NIS.frmApplicantTracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Div" runat="server" align="left" style="width: 100%">
        <center>
            <font class="b12">
                <div class="generate-id-heading green-background">Application Tracking </div>
            </font>
        </center>


        <asp:Label ID="lblloginmsg" runat="server" Text="Label" Visible="false"></asp:Label>


    </div>

    <div id="DivHead" runat="server" align="left" style="width: 100%">


        <table cellpadding="2" cellspacing="1" class="Grid_Item_Alternaterow" style="width: 100%">

            <tr>
                <td style="width: 10%; height: 26px;"></td>
                <td style="width: 20%; height: 26px;"></td>
                <td style="width: 20%; height: 26px;"></td>
                <td style="width: 10%; height: 26px;"></td>
                <td style="width: 20%;"></td>
                <td style="width: 10%;"></td>
            </tr>
            <tr>
               

              

                <td  colspan="3"  >
                    <asp:TextBox ID="txtSerach" runat="server"  Placeholder="Please enter eCERPAC number/ Form number"  Width="350px" class="textbox2" onkeyup="return AlfaNum1(this)"></asp:TextBox>
                </td>
                <td >
                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search " class="generate-id-heading green-background" />
                </td>
                <td style="width: 30%">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>

        </table>
    </div>

    <div id="DivDetails" runat="server" align="left">


        <table>
            <tr>
                <td colspan="6" style="height:15px;"></td>
            </tr>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td style="width: 168px">Form No.</td>
                <td style="width: 300px">
                    <asp:Label ID="lblFRMNo" runat="server" Text=""></asp:Label>
                </td>
                <td style="width: 41px">&nbsp;</td>
                <td>&nbsp;</td>
                <td></td>
            </tr>

            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td style="width: 168px">eCerpac No.</td>
                <td style="width: 300px">
                    <asp:Label ID="lblCerpacNo" runat="server" Text="Label"></asp:Label>
                </td>
                <td style="width: 41px">&nbsp;</td>
                <td rowspan="7" align="right">
                    <asp:Image ID="ImgPhoto" runat="server" ImageUrl="~/eImage_files/default_logo.gif" Style="margin-left: 5px; margin-top: 1px; border-width: 0px; z-index: 1; border: 1px solid #006600; height: 175px; width: 150px; border-radius: 5%; background-blend-mode: lighten; box-shadow: 0 0 25px var(--border-color, #);" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="width: 16px; height: 26px;"></td>
                <td style="width: 168px; height: 26px;">eCerpac Expiry Date</td>
                <td style="height: 26px; width: 300px">
                    <asp:Label ID="lblCerpacExpDt" runat="server" Text="Label"></asp:Label>
                </td>
                <td style="width: 41px; height: 26px;"></td>
                <td style="height: 26px"></td>
            </tr>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td style="width: 168px">Applicant Name</td>
                <td colspan="2">
                    <asp:Label ID="lblTitle" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="lblForeName" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="lblMiddleName" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="lblSurName" runat="server" Text="Label"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td style="width: 168px">Sex</td>
                <td style="width: 300px">
                    <asp:Label ID="lblSex" runat="server" Text="Label"></asp:Label>
                </td>
                <td style="width: 41px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>

            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td style="width: 168px">Company Name</td>
                <td colspan="2">
                    <asp:Label ID="lblCompanyName" runat="server" Text="Label"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td style="width: 168px">Designation</td>
                <td style="width: 300px">
                    <asp:Label ID="lblDesignation" runat="server" Text="Label"></asp:Label>
                </td>
                <td style="width: 41px">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td style="width: 168px">Passport No.</td>
                <td style="width: 300px">
                    <asp:Label ID="lblPassportNo" runat="server" Text="Label"></asp:Label>
                </td>
                <td style="width: 41px">&nbsp;</td>
                <td>&nbsp;</td>

            </tr>
            <tr>
                <td style="width: 16px; height: 26px;"></td>
                <td colspan="4" rowspan="6">
                    <table align="left" style="width: 100%"   >
                        <tr class="Grid_Item_Alternaterow" style="display:none;">
                            <td colspan="6" >&nbsp;&nbsp;<asp:Label ID="lblZoneName" runat="server" Style="font-size: x-large" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr class="generate-id-heading green-background">
                            <td style="width: 10%">&nbsp;&nbsp;SerialNo.</td>
                            <td style="width: 30%">Activity</td>

                            <td style="width: 15%">Status</td>
                            <td style="width: 15%">User</td>
                            <td style="width: 15%">Date </td>
                            <td style="width: 15%">Time </td>

                        </tr>
                        <tr class="Grid_Item_Alternaterow" style="display: none;">
                            <td style="width: 347px">
                                <asp:Label ID="lblSr1" runat="server" Text="Label" /></td>
                            <td>Data Capture</td>

                            <td>
                                <asp:Label ID="lblStatusV" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblVerify" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblVerifyDt" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblVerifyTime" runat="server" Text="Label"></asp:Label>
                            </td>

                        </tr>
                        <tr class="Grid_Item_Alternaterow">
                            <td style="width: 347px">
                                <asp:Label ID="lblSr2" runat="server" Text="Label" /></td>
                            <td>Authorization Level 1</td>

                            <td>
                                <asp:Label ID="lblStatusA" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblAuthBy" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblAuthDt" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblAuthTime" runat="server" Text="Label"></asp:Label>
                            </td>

                        </tr>
                        <tr id="AuthContecOfficer" runat="server" class="Grid_Item_Alternaterow">
                            <td style="width: 347px">
                                <asp:Label ID="lblSr3" runat="server" Text="Label" /></td>
                            <td>Authorization Level 2 </td>
                            <td>
                                <asp:Label ID="lblStatusAC" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblContecBy" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblContecDt" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblContecT" runat="server" Text="Label"></asp:Label>
                            </td>

                        </tr>
                        <tr class="Grid_Item_Alternaterow">
                            <td style="width: 347px">
                                <asp:Label ID="lblSr4" runat="server" Text="Label" /></td>
                            <td>Card Digital </td>

                            <td>
                                <asp:Label ID="lblStatusP" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblProdBy" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblProdOn" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblProdTime" runat="server" Text="Label"></asp:Label>
                            </td>

                        </tr>

                        <tr class="Grid_Item_Alternaterow" style="display: none;">
                            <td style="width: 347px">
                                <asp:Label ID="lblSr5" runat="server" Text="Label"></asp:Label></td>
                            <td>Quality</td>

                            <td>
                                <asp:Label ID="lblStatusQ" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblQualityBy" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblQualityOn" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblQualTime" runat="server" Text="Label"></asp:Label>
                            </td>

                        </tr>
                        <tr class="Grid_Item_Alternaterow">
                            <td colspan="6" style="text-align: center;">
                                <asp:Label ID="lblRejectDetails" runat="server" ForeColor="Black" Style="font-size: large; text-align: center;" Text="Label"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td></td>
            </tr>
            <td style="height: 25px"></td>
            <td></td>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td style="width: 16px">&nbsp;</td>
                <td></td>
            </tr>


            <tr>
                <td style="width: 16px; height: 25px;"></td>
                <td style="width: 168px; height: 25px;"></td>
                <td style="width: 300px; height: 25px;"></td>
                <td style="width: 41px; height: 25px;"></td>
                <td style="height: 25px"></td>
                <td style="height: 25px"></td>
            </tr>
        </table>
    </div>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
