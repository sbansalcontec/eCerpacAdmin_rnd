<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" CodeBehind="CerpacFee.aspx.cs" Inherits="eCerpac_NIS.CerpacFee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="generate-id-heading green-background">CERPAC Fees</div>
    <div style="font-size: 15px;">
        <br />
        <table width="560" cellpadding="5">
            <tbody>
                <tr align="left" class="generate-id-heading green-background">
                    <th width="41" align="center" align="center">S/N</th>
                    <th width="60" class="style1" align="center">Category </th>
                    <th width="50" class="style2" align="center">Form Issued </th>
                    <th width="80" class="style3" align="center">CERPAC 1 YR </th>
                    <th width="50" class="style4" align="center">CERPAC 2 YR </th>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#d4e3e5';" onmouseout="this.style.backgroundColor='';">
                    <td align="center">1 </td>
                    <td width="60" class="style1" align="center">MISSIONARY
                    </td>
                    <td width="50" class="style2" align="center">CR </td>
                    <td width="50" class="style3" align="center">$400</td>
                    <td width="100" class="style4" align="center">$800</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#d4e3e5';" onmouseout="this.style.backgroundColor='';">
                    <td align="center">2 </td>
                    <td width="60" class="style1" align="center">STUDENTS
                    </td>
                    <td width="50" class="style2" align="center">CR </td>
                    <td width="50" class="style3" align="center">$400</td>
                    <td width="100" class="style4" align="center">$800</td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#d4e3e5';" onmouseout="this.style.backgroundColor='';">
                    <td align="center">3 </td>
                    <td width="60" class="style1" align="center">NON&nbsp; AFRICAN NATIONALS
                    </td>
                    <td width="50" class="style2" align="center">AO </td>
                    <td width="50" class="style3" align="center">$700</td>
                    <td width="100" class="style4" align="center">$1400 </td>
                </tr>
                <tr onmouseover="this.style.backgroundColor='#d4e3e5';" onmouseout="this.style.backgroundColor='';">
                    <td align="center">4</td>
                    <td width="60" class="style1" align="center">OTHERS</td>
                    <td width="50" class="style2" align="center">AO </td>
                    <td width="50" class="style3" align="center">$700</td>
                    <td width="100" class="style4" align="center">$1400 </td>
                </tr>
            </tbody>
        </table>
        <br />
    </div>
</asp:Content>

