<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="True" CodeBehind="frmChangePassword.aspx.cs" Inherits="eCerpac_NIS.frmChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style type="text/css">
        /*START Error msg. have this class*/
        .errormsg {
            Color: #333333;
            background-color: #E9ACAC;
            border: Solid 1px;
            border-color: Red;
        }

        /*START Success msg. have this class*/
        .successmsg {
            Color: #333333;
            background-color: #a5f4b2;
            border: Solid 1px;
            border-color: #00ff2a;
            /*background-color:Green;*/
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
    </style>
    <script language="javascript" type="text/javascript">
        function validatePassword() {
            var password = (document.getElementById('<%=txtNewPassword.ClientID%>'));
            if (password.value.length == 0) {
                password.style.borderColor = 'red';
                //alert("Please enter password");
                password.focus();
                return false;
            }
            else {

                if (password.value.length < 4) {
                    //alert('4');
                    alert("Password must contain at least 4 characters!");
                    password.focus();
                    password.value = '';
                    return false;
                }
                var loginid = document.getElementById('<%=txtLoginId.ClientID%>');
                if (password.value == loginid.value) {
                    alert("Password must be different from user loginiD ");
                    password.focus();
                    password.value = '';
                    return false;
                }
                var pwd = document.getElementById('<%=txtOldPassword.ClientID%>');
                if (password.value == pwd.value) {
                    alert("New password must be different from old password ");
                    password.focus();
                    password.value = '';
                    return false;
                }
                re = /^\w+$/;
                if (!re.test(password.value)) {
                    //alert('2');
                    alert("Password must contain only letters, numbers and underscores!");
                    password.focus();
                    password.value = '';
                    return false;
                }
                re = /^.*[a-zA-Z]+.*$/;
                if (!re.test(password.value)) {
                    //alert('7');
                    alert("password must contain at least one letter !");
                    password.focus();
                    password.value = '';
                    return false;
                }

                return true;
            }
        }
        function AlfaNumeric(t) {
            var cod = " ";
            var v = cod
            var w = "";
            for (var i = 0; i < t.value.length; i++) {
                x = t.value.charAt(i);

                if (v.indexOf(x, 0) == -1)
                    w += x;
            }
            t.value = w;
        }

        function checkonlySpace(t) {
            var val = t.value.replace(/^\s+|\s+$/, '');
            // alert(t.value.length);
            if (val.length == 0) {
                t.value = '';
                //t.focus();
            }
        }


        function checkzero(t) {
            var val = t.value;
            if (parseInt(val) == 0) {
                t.value = '';
            }
        }




    </script>

      
    <asp:Panel ID="pnlMain" runat="server" Style="display: block">

        <center>
           <asp:Label ID="lblloginmsg" runat="server" Text="Label" Width="600px" Visible="true" Height="20px"></asp:Label>
            <table cellpadding="2" cellspacing="10" style="width: 95%" id="combox">

                <tr>
                    <td colspan="3" style="height: 5px">
                        <div style="text-align: center;">
                            <div class="generate-id-heading green-background">Change Password</div>

                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                       
                    </td>
                </tr>

                <tr>
                    <td align="center" colspan="2">
                        <table style="font-style: normal" width="75%">
                            <tr align="center" valign="top">
                                <td style="height: 208px">

                                    <table style="font-style: normal" width="100%">

                                        <tr>
                                            <td colspan="4" style="height: 5px"></td>
                                        </tr>

                                        <tr class="t11">
                                            <td align="left" style="width: 237px;" class="b11">Login Id</td>
                                            <td align="left" style="width: 237px;">
                                                <asp:TextBox ID="txtLoginId" Autocomplete="off" runat="server"
                                                    MaxLength="20" Width="200px" CssClass="textbox2" Enabled="False">
                                                </asp:TextBox>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td colspan="4" style="height: 5px"></td>
                                        </tr>

                                        <tr class="t11">
                                            <td align="left"  style="width: 237px" class="b11">Old Password</td>
                                            <td align="left" style="width: 237px">
                                                <asp:TextBox ID="txtOldPassword" Autocomplete="off" runat="server" CssClass="textbox2"
                                                    TextMode="Password" MaxLength="20"
                                                    onkeyup="checkzero(this); AlfaNumeric(this);" Width="200px">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorOldPassword" runat="server"
                                                    ControlToValidate="txtOldPassword" ErrorMessage="Fill Old Password"
                                                    SetFocusOnError="True" ValidationGroup="Update" Width="1px"
                                                    ForeColor="Red">
                                                    *</asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" style="height: 5px"></td>
                                        </tr>
                                        <tr class="t11">
                                            <td align="left"  style="width: 237px; height: 21px;" class="b11">New Password</td>
                                            <td align="left" style="width: 237px; height: 21px;">
                                                <asp:TextBox ID="txtNewPassword" Autocomplete="off" runat="server" CssClass="textbox2" TextMode="Password" MaxLength="20" onblur="validatePassword();" onkeyup="checkzero(this); AlfaNumeric(this);" Width="200px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNewPassword" runat="server"
                                                    ControlToValidate="txtNewPassword" ErrorMessage="Fill New Password"
                                                    SetFocusOnError="True" ValidationGroup="Update" Width="1px"
                                                    ForeColor="Red">
                                                    *</asp:RequiredFieldValidator></td>
                                        </tr>

                                        <tr>
                                            <td colspan="4" style="height: 5px"></td>
                                        </tr>

                                        <tr class="t11">
                                            <td align="left"  style="width: 84px" class="b11">Confirm Password</td>
                                            <td align="left" style="width: 237px">
                                                <asp:TextBox ID="txtConfirmpassword" Autocomplete="off" runat="server" MaxLength="20" onkeyup="checkzero(this); AlfaNumeric(this);" Width="200px" CssClass="textbox2" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorConfirmPassword" runat="server"
                                                    ControlToValidate="txtConfirmpassword" ErrorMessage="Fill Confirm Password"
                                                    SetFocusOnError="True" ValidationGroup="Update" Width="1px"
                                                    ForeColor="Red">
                                                    *</asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="CompareValidator" runat="server"
                                                    ControlToCompare="txtnewpassword" ControlToValidate="txtConfirmpassword"
                                                    ErrorMessage="Confirm password value should match with new password value" SetFocusOnError="True"
                                                    ValidationGroup="Update" Display="Dynamic" ForeColor="RED">
                                                </asp:CompareValidator>
                                            </td>

                                        </tr>


                                    </table>

                                </td>
                            </tr>


                            <tr>

                                <td style="text-align: center; height: 24px;" class="button">
                                    <asp:Button ID="BtnUpdate" runat="server" style=" margin-left: 210px; width:220px" CssClass="generate-id-heading green-background" Text="Update Password" OnClick="BtnUpdate_Click" ValidationGroup="Update" UseSubmitBehavior="true" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 5px">&nbsp;&nbsp;</td>
                            </tr>


                        </table>
                        <asp:Label ID="lblpwdchngmsg" runat="server" CssClass="information-box" Font-Size="Medium" Text="We recommend changing your password every 20 days to ensure the security of login."></asp:Label>
                        <br />
                        <br />
                        <asp:ValidationSummary ID="ValidationSummaryUpdate" runat="server"
                            ShowMessageBox="True" ShowSummary="False" ValidationGroup="Update"
                            ForeColor="#9EC550" />
                    </td>
                </tr>

            </table>

        </center>
    </asp:Panel>

        <asp:Panel ID="pnlmsg" runat="server" Style="display: none;">

        <center>
            <div align="center" class="confirmation-box" height="10px" style="margin-top: 30px;">
               <strong>Password Updated sucessfully.</strong> <br /> <br />
                Your current sesson will be terminated. Please login again with the new password.<br /> <br />
                 <asp:Button ID="btn" runat="server" class="generate-id-heading green-background" OnClick="btn_Click" Text="OK" />
            </div>
        </center>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
