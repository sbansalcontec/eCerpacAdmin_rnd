<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" CodeBehind="DefaultContec.aspx.cs" Inherits="eCerpac_NIS.DefaultContec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="generate-id-heading green-background">Login Activities</div>
    <div style="font-size: 15px;">
        <ol class="sponsor-id-list" start="1">
            <%--<li>
            <p>Your account was last accessed on Monday, December 23, 2024, at 7:00 PM. The login was recorded using the IP address 192.168.5.59.</p>
        </li>--%>
            <li>
                <p>It is strongly recommended that you change your password immediately to secure your account. Additionally, consider enabling two-factor authentication to enhance your account's security.</p>
            </li>
            <li>
                <p>If you experience any difficulties or have concerns, please contact our support team for assistance. Your security is our top priority.</p>
            </li>
        </ol>
        <div style="width: 270px; height: 370px; display: none;" runat="server" id="divmsg">


            <asp:Label ID="lbllastlogin" runat="server" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>
