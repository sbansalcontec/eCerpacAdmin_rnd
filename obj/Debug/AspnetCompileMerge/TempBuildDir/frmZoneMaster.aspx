<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" CodeBehind="frmZoneMaster.aspx.cs" Inherits="eCerpac_NIS.frmZoneMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <script language="javascript" type="text/javascript" src="../JS/validation.js"></script>
    <script type="text/javascript">
        function validateEmail() {

            var PrimaryEmail = (document.getElementById('<%=txtEmailID.ClientID%>'))
            if (PrimaryEmail.value.length == 0) {
                alert("Please enter email");
                PrimaryEmail.focus();
                return false;
            }
            else {

                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

                if (!filter.test(PrimaryEmail.value)) {
                    alert('Please provide a valid email address');
                    PrimaryEmail.focus();
                    PrimaryEmail.value = '';
                    return false;
                }
                else {
                    return true;
                }
            }
        }
    </script>

    <center>
        <asp:UpdatePanel ID="FrmCountryMasterUpdatePanel" runat="server">
            <ContentTemplate>

                <table cellpadding="2" cellspacing="10" style="width: 95%" id="combox">

                    <tr>
                        <td colspan="3" style="height: 5px">

                            <div style="text-align: center">
                                <font class="b12">

                                    <div class="generate-id-heading green-background">ZONE MASTER</div>

                                </font>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 18px" align="center">
                            <asp:Label ID="lblstatus" runat="server" Visible="false" BorderStyle="Solid" BorderWidth="1px" Width="500px" Font-Size="Medium"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">


                            <table border="0" width="680px">
                                <tr class="t11">
                                    <td colspan="4" align="center" style="height: 10px;"></td>
                                </tr>
                                <tr class="t11">
                                    <td colspan="4" align="center"></td>
                                </tr>
                                <tr class="b11">
                                    <td align="left" style="width: 100px;">Zone Code 
                                    </td>
                                    <td align="left" style="width: 200px;">
                                        <asp:TextBox ID="txtZoneCode" runat="server" CssClass="textbox2" ValidationGroup="a"
                                            MaxLength="4" onkeyup="OnlyNumber(this);" onblur="checkzero(this);" AutoComplete="Off" TabIndex="1"
                                            ToolTip="EnterZoneCode"></asp:TextBox>
                                        <span style="color: Red; text-align: center; font-size: medium;">*</span>
                                        <asp:RequiredFieldValidator ID="rfvZonecode" runat="server" ControlToValidate="txtZonecode"
                                            Display="None" ErrorMessage="Enter Zone Code" ValidationGroup="a"
                                            SetFocusOnError="True" ForeColor="#9EC550"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" style="width: 100px;">Zone&nbsp; Desc 
                                    </td>
                                    <td align="left" style="width: 200px;">
                                        <asp:TextBox ID="txtZoneDesc" runat="server" CssClass="textbox2" ValidationGroup="a"
                                            MaxLength="40" onkeyup="AlfaNum3(this);" onblur="checkonlySpace(this);"
                                            AutoComplete="Off" TabIndex="5" ToolTip="Enter Zone Desc"></asp:TextBox>
                                        <span style="color: Red; text-align: center; font-size: medium;">*</span>
                                        <asp:RequiredFieldValidator ID="rfvZoneDesc" runat="server" ControlToValidate="txtZoneDesc"
                                            Display="None" ErrorMessage="Enter Description" ValidationGroup="a"
                                            SetFocusOnError="True" ForeColor="#9EC550"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr class="b11">
                                    <td colspan="4" align="left" style="height: 15px">&nbsp;</td>
                                </tr>
                                <tr class="b11">
                                    <td align="left" style="width: 100px;">Zonal Officer </td>
                                    <td align="left" style="width: 200px;">


                                        <asp:TextBox ID="txtboxZonalOfficer" AutoComplete="Off" TabIndex="2" runat="server" Height="16px" CssClass="textbox2"
                                            Width="132px"></asp:TextBox>
                                        <span style="color: Red; text-align: center; font-size: medium;">*</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtboxZonalOfficer"
                                            Display="None" ErrorMessage="Enter Zonal officer Name" ValidationGroup="a"
                                            SetFocusOnError="True" ForeColor="#9EC550"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" style="width: 150px;">Address </td>
                                    <td align="left" style="width: 200px;">
                                        <asp:TextBox ID="TxtboxAddress" runat="server" AutoComplete="Off" TabIndex="6" CssClass="MultiLine_Textbox" TextMode="MultiLine"></asp:TextBox>
                                        <span style="color: Red; text-align: center; font-size: medium;">*</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtboxAddress"
                                            Display="None" ErrorMessage="Enter Address" ValidationGroup="a"
                                            SetFocusOnError="True" ForeColor="#9EC550"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr class="b11">
                                    <td align="left" style="width: 100px;"></td>
                                    <td align="left" style="width: 200px;">&nbsp;</td>
                                    <td align="left" style="width: 100px;">&nbsp;</td>
                                    <td align="left" style="width: 200px;">&nbsp;</td>
                                </tr>
                                <tr class="b11">
                                    <td colspan="4" align="left" style="height: 5px">&nbsp;</td>
                                </tr>
                                <tr class="b11">
                                    <td align="left" style="width: 100;">&nbsp;Zone Name </td>
                                    <td align="left" style="width: 200;">
                                        <asp:TextBox ID="txtZoneFullName" runat="server" CssClass="textbox2"
                                            OnTextChanged="txtZoneFullName_TextChanged" AutoComplete="Off" TabIndex="3"
                                            ToolTip="Enter Zone Full Name"></asp:TextBox>
                                        <span style="color: Red; text-align: center; font-size: medium;">*</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtZoneFullName"
                                            Display="None" ErrorMessage="Enter Zonal Head" ValidationGroup="a"
                                            SetFocusOnError="True" ForeColor="#9EC550"></asp:RequiredFieldValidator>

                                    </td>
                                    <td align="left" style="width: 100;">E mail ID </td>
                                    <td align="left" style="width: 100;">
                                        <asp:TextBox ID="txtEmailID" runat="server" Width="135px" AutoComplete="Off" TabIndex="7" CssClass="textbox2" onblur="validateEmail();"></asp:TextBox>
                                        <span style="color: Red; text-align: center; font-size: medium;">*</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmailID"
                                            Display="None" ErrorMessage="Enter Email " ValidationGroup="a"
                                            SetFocusOnError="True" ForeColor="#9EC550"></asp:RequiredFieldValidator>
                                    </td>

                        </td>
                    </tr>
                    <tr class="b11">
                        <td colspan="4" align="left" style="height: 10px;"></td>
                    </tr>
                    <tr class="b11">
                        <td style="width: 100;">Mobile No.</td>
                        <td>
                            <asp:TextBox ID="txtMobileNo" runat="server" CssClass="textbox2" AutoComplete="Off" TabIndex="4" onkeyup="return OnlyNumber(this);" MaxLength="10"></asp:TextBox>
                            <span style="color: Red; text-align: center; font-size: medium;">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtMobileNo"
                                Display="None" ErrorMessage="Enter Mobile Number" ValidationGroup="a"
                                SetFocusOnError="True" ForeColor="#9EC550"></asp:RequiredFieldValidator>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr class="b11">
                        <td colspan="4" align="left" style="height: 10px;"></td>
                    </tr>
                    <tr class="b11">
                        <td></td>
                        <td align="center" >
                            <asp:Button ID="btnSave" runat="server" class="generate-id-heading green-background" Text="Save" Width="100%"
                                ValidationGroup="a" OnClick="btnSave_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnUpdate" runat="server" class="generate-id-heading green-background" Text="Update" Width="100%"
                                ValidationGroup="a" OnClick="btnUpdate_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnCancel" runat="server" class="generate-id-heading green-background" Text="Cancel" Width="100%"
                                OnClick="btnCancel_Click" />
                        </td>
                    </tr>
                    <tr class="b11">
                        <td colspan="4" align="left" style="height: 10px;"></td>
                    </tr>
                    <tr class="b11">
                        <td align="center" colspan="4">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                                ShowMessageBox="True" ShowSummary="False" ValidationGroup="a"
                                ForeColor="#9EC550" />
                        </td>
                    </tr>
                    <tr class="b11">
                        <td align="left" colspan="4" style="height: 20px;">&nbsp;</td>
                    </tr>
                    <tr class="b11">
                        <td colspan="4" style="height: 10px">&nbsp;</td>
                    </tr>
                </table>

                </td>
           </tr>
           </table>
     
            </ContentTemplate>
        </asp:UpdatePanel>
    </center>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
