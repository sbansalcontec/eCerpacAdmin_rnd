<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" CodeBehind="frmCheckSheetReports.aspx.cs" Inherits="eCerpac_NIS.frmCheckSheetReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <script type="text/javascript" src="http://cloud.github.com/downloads/malsup/cycle/jquery.cycle.all.latest.js"></script>

    <style type="text/css">
        .checksheet {
            font-size: 11px;
            font-family: Arial;
        }

        .auto-style1 {
            width: 168px;
        }
.generate-id-view-full-container {
    border:1px solid #ccc;
}
.logout-btn-dashboard-navbar {
    padding:14px;
}
    </style>

    <script type="text/javascript" language="javascript">

        function AlfaNumeric(t) {
            var cod = " ";
            var v = cod
            var w = "";
            if (event.keyCode >= 37 && event.keyCode <= 40) {
            }
            else {
                for (var i = 0; i < t.value.length; i++) {
                    x = t.value.charAt(i);
                    if (v.indexOf(x, 0) == -1)
                        w += x;
                }
                t.value = w;
            }
        }

        function ClearText(t) {
            t.div_main.Visible = false;
        }

        function first_Click() {
            //open new window set the height and width =0,set windows position at bottom
            var a = window.open('', '', 'left =' + screen.width + ',top=' + screen.height + ',width=0,height=0,toolbar=0,scrollbars=1,status=0');

            a.document.write($("P604b8288e65b492695e9f9782b49f6d3_2_oReportDiv").html());
            a.document.close();
            a.focus();
            //call print
            a.print();
            a.close();
            return false;
        }
    </script>
    <script language="javascript">
        function PrintContent() {
            //alert('hi');
            var html = "<html>";
            html += document.getElementById("DivCheckSheet").innerHTML;
            html += "</html>";

            var printWin = window.open('', '', 'location=no,width=10,height=10,left=50,top=50,toolbar=no,scrollbars=no,status=0,titlebar=no');

            printWin.document.write(html);
            printWin.document.close();
            printWin.focus();
            printWin.print();
            printWin.close();
        }


    </script>




    <div id="DetailPage" runat="server" align="center" class="bcolour">
        <center>
            <table style="width: 100%">
                <tr>

                    <td colspan="4" style="height: 5px">
                         <div class="generate-id-heading green-background">Check Sheet&nbsp; Report</div>
                    </td>
                </tr>
                <tr style="height:50px;">
                    <td></td>
                </tr>
                <tr  >
                    <td  style="height: 32px">
                        <asp:Label ID="LblCerpac" runat="server" Text="eCerpac No:"></asp:Label></td>
                    <td></td>
                    <td  style="height: 32px">
                        <input id="txtCerpacNo" tabindex="3" maxlength="15" runat="server" type="text" onkeyup="AlfaNumeric(this)" onchange="ClearText(this)"
                            style="width: 200px" class="textbox2" />
                    </td>

                    <td >
                        <asp:Button ID="btn_generate_report" runat="server" class="generate-id-heading green-background"
                            Text="Generate Check Sheet"
                            OnClick="btn_generate_report_Click" TabIndex="6" />


                    </td>
                    <td></td>

                </tr>
                <tr>
                    <td colspan="4">  <asp:Label ID="lblloginmsg" runat="server" Text="Label"></asp:Label></td>
                    
                </tr>
            </table>
        </center>
    </div>
    <div id="div_main" runat="server" style="font-size: large; border-bottom-width: 1px; border-bottom-color: black;">
        <div id="DivCheckSheet" align="left">

            <table align="center" style="width: 100%; font-size: 13px;">
                <tr>
                    <td class="style11" colspan="6" style="height: auto">
                        <h2 style="text-align: center">
                            <strong style="font-size: 25px">eCerpac Green Card Data Check Sheet</strong></h2>
                    </td>
                </tr>

                <tr>
                    <td class="width:7%;" colspan="6">
                        <hr style="height: 2px; background-color: #000000;" />
                        <strong></strong></td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <strong><em>Personal Details:</em></strong></td>
                </tr>

                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:01&nbsp;&nbsp;Title </td>
                    <td class="auto-style3">
                        <asp:Label ID="lblTile" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style10">:06&nbsp;&nbsp;Sex</td>
                    <td class="auto-style5">
                        <asp:Label ID="lblSex" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:02&nbsp;&nbsp;Fore Name</td>
                    <td class="style10" colspan="4">
                        <asp:Label ID="lblForeName" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:03&nbsp;&nbsp;Middle Name</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblMiddleName" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:04&nbsp;&nbsp;Sur Name</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblSurName" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:05&nbsp;&nbsp;Place of Issue</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblPlaceofIssue" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <hr style="height: 2px; background-color: #000000;" />
                        <strong></strong></td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <strong><em>eCerpac Details:</em></strong></td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:07&nbsp;&nbsp;CERPAC No/ FRN </td>
                    <td class="auto-style3">
                        <asp:Label ID="lblCerpacNo" runat="server" ToolTip=" .style5"></asp:Label>
                        &nbsp;/&nbsp;
                        <asp:Label ID="lblFileNo" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style10">:12&nbsp;&nbsp;Issue No</td>
                    <td class="auto-style5">
                        <asp:Label ID="lblIssueNo" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:08&nbsp;&nbsp;Date of Receipt</td>
                    <td class="auto-style3">
                        <asp:Label ID="lblDateofReceipt" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td class="auto-style10">&nbsp;</td>
                    <td class="auto-style5">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:09&nbsp;&nbsp;Date of Expiration</td>
                    <td class="auto-style3" colspan="4">
                        <asp:Label ID="lblDateofExpiry" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:10&nbsp;&nbsp;Code</td>
                    <td class="auto-style3" colspan="4">
                        <asp:Label ID="lblCode" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:11&nbsp;&nbsp;File No</td>
                    <td class="auto-style3" colspan="4">

                        <asp:Label ID="lblFileN" runat="server" ToolTip=" .style5"></asp:Label>

                    </td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <hr style="height: 2px; background-color: #000000;" />
                        <strong></strong></td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <strong><em>Passport Details:</em></strong></td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:13&nbsp;&nbsp;Passport No</td>
                    <td class="auto-style3">
                        <asp:Label ID="lblPassportNo" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style10">:18&nbsp;&nbsp;Date of Birth</td>
                    <td class="auto-style5">
                        <asp:Label ID="lblDateofBirth" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:14&nbsp;&nbsp;Nationality</td>
                    <td class="auto-style3">
                        <asp:Label ID="lblNationality" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style10">:19&nbsp;&nbsp;Place of Birth</td>
                    <td class="auto-style5">
                        <asp:Label ID="lblPlaceofBirth" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:15&nbsp;&nbsp;Date of Issue/Expiry</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblDateofIssueP" runat="server" ToolTip=" .style5"></asp:Label>
                        <asp:Label ID="lblOr" runat="server" ToolTip=" .style5">/</asp:Label>
                        <asp:Label ID="lblDateofExpiryP" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:16&nbsp;&nbsp;Place of Issue</td>
                    <td class="auto-style3" colspan="4">
                        <asp:Label ID="lblPlaceofIssueP" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:17&nbsp;&nbsp;Issued By</td>
                    <td class="auto-style3" colspan="4">
                        <asp:Label ID="lblIssuedByP" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <hr style="height: 2px; background-color: #000000;" />
                        <strong></strong></td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <em>
                            <strong>Address Details:</strong></em></td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:20&nbsp;&nbsp;Nigeria Address1: </td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblNigeriaAdd1" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:21&nbsp;&nbsp;Nigeria Address2</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblNigeriaAdd2" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:22&nbsp;&nbsp;Nigeria Tel No</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblNigeriaTelNo" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:23&nbsp;&nbsp;Abroad Address1:</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblAbroadAdd1" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:24&nbsp;&nbsp;Abroad Address2:</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblAbroadAdd2" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:25&nbsp;&nbsp;Abroad Tel No</td>
                    <td class="style7" colspan="4">
                        <asp:Label ID="lblAbroadTelNo" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <hr style="height: 2px; background-color: #000000;" />
                        <strong></strong></td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <em><strong>Company Details:</strong></em></td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:26&nbsp;&nbsp;Company </td>
                    <td class="auto-style3" colspan="4">
                        <asp:Label ID="lblCompanyName" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:27&nbsp;&nbsp;Address1</td>
                    <td class="auto-style3" colspan="4">
                        <asp:Label ID="lblCompanyAdd1" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:28&nbsp;&nbsp;Address2</td>
                    <td class="auto-style3" colspan="4">
                        <asp:Label ID="lblCompanyAdd2" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:29&nbsp;&nbsp;Desgination</td>
                    <td class="auto-style3" colspan="4">
                        <asp:Label ID="lblDesgination" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:30&nbsp;&nbsp;Date of Employement</td>
                    <td class="auto-style3">
                        <asp:Label ID="lblDateofemployement" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style10">:32&nbsp;&nbsp;Fax No</td>
                    <td class="auto-style5">
                        <asp:Label ID="lblFaxNo" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style11" style="width: 186px">:31&nbsp;&nbsp;Tel No</td>
                    <td class="auto-style3">
                        <asp:Label ID="lblTelNo" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td class="auto-style10">:33&nbsp;&nbsp;E-mail</td>
                    <td class="auto-style5">
                        <asp:Label ID="lblEmail" runat="server" ToolTip=" .style5"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">
                        <hr style="height: 2px; background-color: #000000;" />
                        <strong></strong></td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="6">I confirm that all details entered have been verified to be accurate.</td>
                </tr>
                <tr>
                    <td class="width:7%;" colspan="3" style="font-style: italic; font: bold;">
                        <em><strong>Data Entry Operator</strong></em></td>
                    <td class="width:7%;" colspan="3" style="font-style: italic; font: bold;">
                        <em><strong>Print Supervisor</strong></em></td>
                </tr>
            </table>

            <table align="center" style="width: 100%; font-size: 13px;">
                <tr>
                    <td colspan="5">
                        <br />
                        Signature: _________________________</td>
                    <td colspan="8">
                        <br />
                        Signature:_______________________</td>
                </tr>
                <tr>
                    <td colspan="5">Date: &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblGetDate" runat="server"></asp:Label>
                    </td>
                    <td colspan="8">Date:</td>
                </tr>
                <tr>
                    <td>
                        <img class="auto-style13" src="eImage_files/CheckBox.jpg" /></td>
                    <td>Rejcted (State Reason)</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>

            <table align="center" style="width: 100%; font-size: 12px;">
                <tr>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:01</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:02</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:03</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:04</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:05</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:06</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:07</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:08</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:09</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:10</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:11</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:12</td>
                </tr>
                <tr>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:13</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:14</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:15</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:16</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:17</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:18</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:19</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:20</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:21</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:22</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:23</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:24</td>
                </tr>
                <tr>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:25</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:26</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:27</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:28</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:29</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:30</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:31</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:32</td>
                    <td>
                        <img src="eImage_files/Box1.jpg" />:33</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>

            </table>

        </div>


        <div id="Div1" runat="server" align="left" style="display: block">
            <table cellpadding="2" cellspacing="5" class="bcolour" style="text-align: center; width: 100%;">
                <tr>
                    <td colspan="4">
                        <div style="text-align: center;">

                            <asp:Button ID="btnPrint" runat="server" class="generate-id-heading green-background"
                                Text="Print Check Sheet" OnClientClick="PrintContent()"
                                TabIndex="6" Visible="true" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
