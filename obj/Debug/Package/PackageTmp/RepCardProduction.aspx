<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" CodeBehind="RepCardProduction.aspx.cs" Inherits="eCerpac_NIS.RepCardProduction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link rel="stylesheet" type="text/css" href="css/daterangepicker.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <script type="text/javascript" src="scripts/jquery.min.js"></script>
    <script type="text/javascript" src="scripts/moment.min.js"></script>


   
<script type="text/javascript" src="scripts/daterangepicker.min.js"></script>

    <!-- Bootstrap CSS (you can also use your own Bootstrap version) -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />

<!-- Bootstrap Datepicker CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet" />

<!-- jQuery (required for Bootstrap Datepicker) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Bootstrap Datepicker JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>


    <style>
    .my-notify-error {
        color: #f44336; /* Red for errors */
        font-weight: bold;
        padding: 10px;
        background-color: #ffe5e5; /* Light red background */
        border: 1px solid #f44336;
        border-radius: 5px;
        margin-top: 10px;
    }

    .my-notify-warning {
        color: #ff9800; /* Orange for warnings */
        font-weight: bold;
        padding: 10px;
        background-color: #fff3e0; /* Light orange background */
        border: 1px solid #ff9800;
        border-radius: 5px;
        margin-top: 10px;
    }

</style>


    <style type="text/css">
        .emov-dash-icon-cover1 {
            background: rgba(234,246,232, 1) 0% 0% no-repeat padding-box;
            border-radius: 5px;
            padding: 1px;
            border: 0px;
        }

        .emov-a-header-input {
            background: rgba(255, 255, 255, 1) 0% 0% no-repeat padding-box;
            border: 1px solid rgba(233, 233, 240, 1);
            border-radius: 4px;
            padding: 10px 14px;
            margin-left: 10px;
            outline: none;
        }

        .emov-a-header-action-group {
            flex-direction: column;
            align-items: flex-start;
        }


        .emov-t-actions-group {
            margin-bottom: 20px;
        }
    </style>

    <script>
        $(document).ready(function () {
            // Initialize the From Datepicker
            $('#fromDate').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            }).on('changeDate', function (e) {
                // Set the To Datepicker minDate to the selected From date
                $('#toDate').datepicker('setStartDate', e.date);
            });

            // Initialize the To Datepicker
            $('#toDate').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            });

            // Submit button logic
            $('#btnSubmit').click(function () {
                var fromDate = $('#fromDateInput').val();
                var toDate = $('#toDateInput').val();

                if (fromDate && toDate) {
                    $('#result').html('From Date: ' + fromDate + '<br/>To Date: ' + toDate);
                } else {
                    $('#result').html('Please select both From and To dates.');
                }
            });
        });
    </script>


    <%-- JQuery Date Fun  --%>
    <script type="text/javascript">
        $(function () {

            var start = moment().subtract(29, 'days');
            var end = moment();

            function cb(start, end) {
                //$('#txtSearch span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                $('#txtSearch span').html(start.format('DD/MM/YYYY') + ' - ' + end.format('DD/MM/YYYY'));
            }

            $('#txtSearch').daterangepicker({
                startDate: start,
                endDate: end,
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                }
            }, cb);

            cb(start, end);

        });

    </script>
    <%--  Vildate Date fun--%>
    <script type="text/Jscript"> 
        function getDtRange() {
            $("#hfProduct").val($("#txtSearch").text());
            // alert('Hi 2 ' + $("#hfProduct").val());
        }
    </script>

    <%--  Printer  fun--%>
    <script type="text/javascript">
        function PrintContent() {
            var html = "<html>";
            html += document.getElementById("DivPrint").innerHTML;
            html += "</html>";

            var printWin = window.open('', '', 'location=no,width=10,height=10,left=50,top=50,toolbar=no,scrollbars=no,status=0,titlebar=no');

            printWin.document.write(html);
            printWin.document.close();
            printWin.focus();
            printWin.print();
            printWin.close();
        }


        function PrintContentSummary() {
            var html = "<html>";
            html += document.getElementById("DivPrintSummary").innerHTML;
            html += "</html>";

            var printWin = window.open('', '', 'location=no,width=10,height=10,left=50,top=50,toolbar=no,scrollbars=no,status=0,titlebar=no');

            printWin.document.write(html);
            printWin.document.close();
            printWin.focus();
            printWin.print();
            printWin.close();
        }

    </script>
    <%--  Convert html to PDF  fun--%>
    <%-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
    <script>
        function getPDF() {

            var HTML_Width = $(".canvas_div_pdf").width();
            var HTML_Height = $(".canvas_div_pdf").height();
            var top_left_margin = 15;
            var PDF_Width = HTML_Width + (top_left_margin * 2);
            var PDF_Height = (PDF_Width * 1.5) + (top_left_margin * 2);
            var canvas_image_width = HTML_Width;
            var canvas_image_height = HTML_Height;

            var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;


            html2canvas($(".canvas_div_pdf")[0], { allowTaint: true }).then(function (canvas) {
                canvas.getContext('2d');

                console.log(canvas.height + "  " + canvas.width);


                var imgData = canvas.toDataURL("image/jpeg", 1.0);
                var pdf = new jsPDF('p', 'pt', [PDF_Width, PDF_Height]);
                pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin, canvas_image_width, canvas_image_height);


                for (var i = 1; i <= totalPDFPages; i++) {
                    pdf.addPage(PDF_Width, PDF_Height);
                    pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height * i) + (top_left_margin * 4), canvas_image_width, canvas_image_height);
                }
                var n = Date.now();
                pdf.save("Bank_Report_" + n + ".pdf");
            });
        };
    </script>



    <div>
        <asp:Panel ID="pnlMain" runat="server" Style="display: block">

            <div id="div_main" runat="server" class="emov-page-main emov-page-main-no-top-padding">

                <!-- Header Menu-->
                <div class="emov-a-rc-header emov-a-rc-header-seun">
                    <!-- Page Title-->
                    <div class="emov-header-page-title emov-header-page-title-table-vigo" id="emov-application-title">
                        <table style="width:100%;">
                         <tr>
     <td colspan="3" style="height: 5px">
         <div style="text-align: center;">
             <div class="generate-id-heading green-background">Card Production Report</div>

         </div>
     </td>
 </tr></table>
                        <%--<h3 style="font-size: 25px;" class="emov-applications-title">Card Production Report</h3>--%>
                        <!-- Total Count-->
                        <%-- <div class="emov-a-header-counter">
                            <p>
                                <asp:Label ID="lbl_total" runat="server"></asp:Label>
                                Total
                            </p>
                        </div>--%>
                    </div>

                   

                    <div class="emov-a-header-action-group">
                        <div class="emov-t-actions-group" style="display: block;">
                            <table id="btnOpt" runat="server" class="emov-dash-icon-cover1" style="width: 100%; display: block">
                                <tr style="display:none;">
                                    <td>
                                        <button id="" class="emov-dash-icon-cover1" width="100%" style="margin-right: 5px;"><i class="fa fa-filter" aria-hidden="true"></i>FILTER BY :</button></td>

                                    <td>

                                    </td>
                                    <td>
                                        <asp:DropDownList class="emov-dash-icon-cover1" Width="100%" ID="ddlMonth" Style="margin-right: 5px; background-color: #f8f8f8; padding: 5px 5px 5px 15px; border: 1px solid #f8f8f8;" runat="server"></asp:DropDownList></td>
                                    <td>
                                        <asp:DropDownList class="emov-dash-icon-cover1" Width="100%" ID="ddlYear" Style="margin-right: 5px; background-color: #f8f8f8; padding: 5px 5px 5px 15px; border: 1px solid #f8f8f8;" runat="server"></asp:DropDownList></td>
                                    <td style="width: 250px;"></td>

                                     <td><div id="txtSearch" class="emov-a-header-input"  style="font-size:small; font-weight:lighter;"   ><i class="fa fa-calendar"></i>&nbsp;     <span></span> <i class="fa fa-caret-down"></i>    </div>
                                         <asp:HiddenField runat="server" ID="hfProduct" ClientIDMode="Static" />
                                     </td>
                                    <%-- <td>
     <button id="btnDownload" type="button" runat="server" width="100%" class="emov-dash-icon-cover1" style="margin-right: 5px;" onclick="getPDF()"><i class="fa fa-download" aria-hidden="true"></i>DOWNLOAD </button>
 </td>--%>
                                    <%-- <td >
     <button id="btnExcel" type="button" runat="server" width="100%" class="emov-dash-icon-cover1" style="margin-right: 5px;" onclick="ExportDivDataToExcel()" onserverclick="btnExcel_Click"><i class="fa fa-file-excel-o" aria-hidden="true"></i>Excel File </button>
 </td>--%>
                                    <td>
                                        <button id="btnSearch" type="button" runat="server" width="100%" class="emov-dash-icon-cover1" style="margin-right: 5px;" onmousemove="getDtRange()" onserverclick="BtnSearchOpt"><i class="fa fa-search" aria-hidden="true"></i>SEARCH </button>
                                    </td>
                                    <td>
                                        <button id="btnPrint" type="button" runat="server" width="100%" class="emov-dash-icon-cover1" style="margin-right: 5px;" onserverclick="BtnPrinter"><i class="fa fa-print" aria-hidden="true"></i>PRINTER </button>
                                    </td>

                                </tr>

                                <tr>
                                    <td>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                   
                                    <td colspan="4">
                                     <div class="col-md-6">
     <label for="fromDate" style="font-size:12px;">From Date</label>
     <div class="input-group date" id="fromDate">
         <input type="text" class="form-control" id="fromDateInput" placeholder="Select From Date" runat="server"/>
         <span class="input-group-addon">
             <i class="glyphicon glyphicon-calendar"></i>
         </span>
     </div>
 </div>

 <div class="col-md-6">
     <label for="toDate"  style="font-size:12px;">To Date</label>
     <div class="input-group date" id="toDate">
         <input type="text" class="form-control" id="toDateInput" placeholder="Select To Date" runat="server"/>
         <span class="input-group-addon">
             <i class="glyphicon glyphicon-calendar"></i>
         </span>
     </div>
 </div>
                                        </td>
                                    <td style="vertical-align: bottom;">
                                         <asp:Button ID="btn_generate" runat="server" Text="Generate Report" class="generate-id-heading green-background"  OnClick="btn_generate_Click"/>

                                       <button id="btn_Print" type="button" runat="server" width="100%" class="emov-dash-icon-cover1" style="margin-right: 5px;vertical-align:bottom;" onserverclick="BtnPrinter" visible="false">
    <i class="fa fa-print" aria-hidden="true" style="font-size: 32px;"></i> <!-- Increase font size -->
</button>

                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>




                </div>



                <!-- Data Grid Design-->
                <div class="emov-a-rc-table-cover">

                    <div id="div_Report" runat="server">
                        <!-- table within data grid-->
                        <div>
                            <table style="width:100%;">
                        <tr>
    <td align="center">
        <span>
            <div id="lblmsg" runat="server" class="my-notify-error" visible="false" style="width:30%;"></div>
        </span>

    </td>
</tr></table></div>
                        <div id="R1" align="center" style="overflow-x: scroll; background-color: white; height: 350px;display:none;" runat="server">

                            <div id="DivReport" style="width: 100%;">


                                <div class="canvas_div_pdf">

                                  <asp:Panel ID="pnlDetails" runat="server" Visible="true">
    <!-- Report Header-->
    <table style="width: 100%; border-collapse: collapse;" align="center">
        <tr>
            <td align="center" colspan="8" style="height: 50px;"></td>
        </tr>
        <tr>
            <td align="center" colspan="8">
                <img src="eImage_files/Login 50x50.jpg" style="margin-top: 0%;" />
            </td>
        </tr>
        <tr>
            <td align="center" colspan="8" class="h2label" style="padding: 10px;">
                <h6 style="margin: 0;">eCERPAC RESIDENT PERMIT</h6>
                <h4 style="margin: 5px 0;">NIGERIA IMMIGRATION SERVICE (NIS)</h4>
               <%-- <h6 style="margin: 0;">RESIDENT PERMIT</h6>--%>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="8" style="height: 15px;"></td>
        </tr>
        <tr>
            <td align="center" colspan="8" class="h2label" style="font-size: 18px; font-weight: bold;">PRODUCTION REPORT</td>
        </tr>
        <tr>
            <td align="center" colspan="8">&nbsp;</td>
        </tr>
    </table>

    <!-- Report Details-->
    <% 
        if (objDs.Rows.Count > 0)
        { 
    %>
    <table class="emov-a-table-data" border="1" cellspacing="1" rules="all" style="width: 140%; background-color: white; border-collapse: collapse;">
        <thead>
            <tr class="emov-a-table-heading" style="background-color: #f1f1f1; color: #333;">
                <th align="center" style="padding: 10px;text-align:center;">Sl.No.</th>
                <th align="center" style="padding: 10px; width:200px;text-align:center;">Name</th>
                <th align="center" style="padding: 10px; width:115px;text-align:center;">eCERPAC No</th>
                <th align="center" style="padding: 10px;width:115px;text-align:center;">Expiry Date</th>
                <th align="center" style="padding: 10px;width:115px;text-align:center;">Passport No.</th>
                <th align="center" style="padding: 10px;width:115px;text-align:center;">Nationality</th>
                <th align="center" style="padding: 10px;width:150px;text-align:center;">Company Name</th>
                <th align="center" style="padding: 10px;width:115px;text-align:center;">Designation</th>
                <th align="center" style="padding: 10px;width:115px;text-align:center;">Issued On</th>
            </tr>
        </thead>

        <tbody>
                <%  int c = 1;
              int St = 0;
              decimal Sc = 0, Ss = 0;
              for (int i = 0; i < objDs.Rows.Count; i++)
              {
                  if (i >= 0)
                  {

          %>
          <tr class="Grid_Item_Alternaterow">
              <td align="center" valign="middle">
                  <%=Convert.ToString(i+1)%>
              </td>
              <td align="center" valign="middle">
                  <%=Convert.ToString(objDs.Rows[i]["Name"])%>
              </td>
              <td align="center" valign="middle">
                  <%=Convert.ToString(objDs.Rows[i]["cerpac_no"])%>
              </td>
              <td align="center" valign="middle">
                  <%=Convert.ToString(objDs.Rows[i]["cerpac_expiry_date"])%>
              </td>


              <td align="center" valign="middle">
                  <%=Convert.ToString  (objDs.Rows[i]["passport_no"]) %>
              </td>
              <td align="center" valign="middle">
                  <%=Convert.ToString  (objDs.Rows[i]["nationality"]) %>
              </td>
              <td align="center" valign="middle">
                  <%=Convert.ToString  (objDs.Rows[i]["CompanyName"]) %>
              </td>
              <td align="center" valign="middle">
                  <%=Convert.ToString  (objDs.Rows[i]["designation"]) %>
              </td>
              <td align="center" valign="middle">
                  <%=Convert.ToString  (objDs.Rows[i]["ProducedOn"]) %>
              </td>

          </tr>
            <%      


                  }
              }%>
        </tbody>
    </table>
    <% } %>
    <br />
</asp:Panel>


                                </div>
                            </div>
                        </div>


                        <!-- table within data grid-->
                    </div>
                </div>

            </div>
        </asp:Panel>

        <!-- Message Div -->
        <div class="my-notify-error" runat="server" id="lblloginmsg" style="margin-top: 1%; width: 100%; text-align: left; display: none;"></div>



        <!-- Printing Div -->

        <div id="DivPrint" style="width: 800px; display: none;">

            <asp:Panel ID="pnlPrntDetails" runat="server">
                <!-- Reoirt Header-->
                <table style="width: 100%;" align="center">
                    <tr>
                        <td align="center" colspan="8" style="height: 50px;"></td>
                    </tr>
                    <tr>
                        <td align="center" colspan="8">
                            <img src="eImage_files/Login 50x50.jpg" style="margin-top: -15%;" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="8" class="h2label">
                            <h6>eCERPAC</h6>
                            <h4>NIGERIA IMMIGRATION SERVICE (NIS)</h4>
                            <h6>RESIDENT PERMIT</h6>
                        </td>
                        <tr>
                            <td align="center" colspan="8" style="height: 15px;"></td>
                        </tr>
                    <tr>
                        <!--changes -->
                        <td align="center" colspan="8" class="h2label">PRODUCTION REPORT</td>
                    </tr>


                    <tr>
                        <td align="center" colspan="8">&nbsp;</td>
                    </tr>

                </table>

                <!-- Report Details-->
                <% 
                    if (objDsRep.Rows.Count > 0)
                    { %>
                <!--changes -->
                <table class="emov-a-table-data" border="1" cellspacing="1" rules="all" style="width: 100%; clip: rect(auto, auto, auto, auto);">
                    <tr class="emov-a-table-heading">
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Sl.No.</th>
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Name</th>
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">eCERPAC No</th>
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Expiry Date</th>
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Passport No.</th>
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Nationality</th>
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Company Nmae</th>
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Designation</th>
                        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Issued ON</th>

                    </tr>

                    <%  int c = 1;
                        int St = 0;
                        decimal Sc = 0, Ss = 0;
                        for (int i = 0; i < objDsRep.Rows.Count; i++)
                        {
                            if (i >= 0)
                            {
                    %>

                    <tr class="Grid_Item_Alternaterow">
                        <td align="center" valign="middle">
                            <%=Convert.ToString(i+1)%>
                        </td>
                        <td align="center" valign="middle">
                            <%=Convert.ToString(objDsRep.Rows[i]["Name"])%>
                        </td>
                        <td align="center" valign="middle">
                            <%=Convert.ToString(objDsRep.Rows[i]["cerpac_no"])%>
                        </td>
                        <td align="center" valign="middle">
                            <%=Convert.ToString(objDsRep.Rows[i]["cerpac_expiry_date"])%>
                        </td>


                        <td align="center" valign="middle">
                            <%=Convert.ToString  (objDsRep.Rows[i]["passport_no"]) %>
                        </td>
                        <td align="center" valign="middle">
                            <%=Convert.ToString  (objDsRep.Rows[i]["nationality"]) %>
                        </td>
                        <td align="center" valign="middle">
                            <%=Convert.ToString  (objDsRep.Rows[i]["CompanyName"]) %>
                        </td>
                        <td align="center" valign="middle">
                            <%=Convert.ToString  (objDsRep.Rows[i]["designation"]) %>
                        </td>
                        <td align="center" valign="middle">
                            <%=Convert.ToString  (objDsRep.Rows[i]["ProducedOn"]) %>
                        </td>

                    </tr>
                    <%      


                            }
                        }%>
                </table>
                <% }     %>
                <br />
            </asp:Panel>

        </div>

        <asp:HiddenField ID="HdnValue" runat="server" />

    </div>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
