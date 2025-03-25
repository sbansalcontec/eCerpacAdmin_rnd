<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" MasterPageFile="~/Master/MasterPage.Master"  Inherits="eCerpac_NIS.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .grid-section{
            width: 100%;
        }
        .chart-items{
            display: flex;
        }
        .generate-id-container {
            border-bottom: 2px solid #3BB42E;
        }
        .chart-item {
            border-left: 2px solid #3BB42E;
            border-right: 2px solid #3BB42E;
        }
        .tab {
            overflow: hidden;
            margin-bottom: 20px;
        }
        .tab button {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 8px 50px;
            transition: 0.3s;
            font-size: 18px;
            border-radius: 5px;
            color: #007C45;
            margin-right: 10px;
            border: 1px solid #007C45;
        }
        .tab button:hover {
            background-color: #007C45;
            color: #fff;
        }
        .tab button.active {
            background-color: #007C45;
            color: #fff;
        }
        .chart-item h2{
            margin: 0px;
            padding: 10px;
            background-color: #3BB42E;
            color: #fff;
            font-size: 20px;
        }
       
        .tabcontent {
            display: none;
        }
        .dateRange{
            position: absolute;
            top:50px;
            right: 5px;
            display: flex;
            flex-direction: row;
            gap:50px;
        }

        .dateRange select,
        .dateRange input[type="date"]{
            border: none;
            border: 1px solid #000;
            padding: 5px 2px;
            border-radius: 5px;
            outline: none;
        }

        .period{
            display: flex;
            align-items: center;
            gap: 10px;
            flex-direction: row;
        }
        .period div{
            padding: 5px;
            border: 1px solid #000;
            border-radius: 5px;
            background:#fff;
        }
        .period div span{
            padding-left: 5px;
        }
        .date-range{
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .date-range button{
            outline: none;
            cursor: pointer;
            padding: 5px;
            transition: 0.3s;
            font-size: 15px;
            border-radius: 5px;
            margin-right: 10px;
            border: 1px solid #007C45;
            background-color: #007C45;
            color: #fff;
        }
        
        .tableHeader{
            background: #007c45;
            border: 1px solid #007c45;
            color: #fff;
        }
        .tableHeader th{
            background-image: none !important;
            padding: 5px !important;
        }
        .tableHeader,
        .tableCell {
            text-align: left;
        }
        .tableHeader th:first-child,
        .tableCell:first-child,
        .tableHeader th:last-child,
        .tableCell:last-child {
            text-align: center;
        }
        .generate-id-container {
            padding:0px;
        }
    </style>
                <div class="grid-section">
                    <div class="tab">
                        <button class="tablinks" onclick="openTab(event, 'tabAAS')">eCERPAC Application</button>
                        <button class="tablinks" onclick="openTab(event, 'tabEMS')">Operational</button>
                        <button class="tablinks" onclick="openTab(event, 'tabFD')">Business Operations</button>
                    </div>

                    <div class="tabcontent" id="tabAAS">
                        <div class="chart-item" style="width: 99.6%; height: 487px; position: relative;">
                            <h2>Application Status</h2>
                         
                            <div id="chart_AAS"></div>
                            <div id="backButton"></div>
                            <div style="margin-top: 110px;" id="tableView"></div>
                            <div class="dateRange">
                                <div class="period">
                                    <div>
                                        <input type="radio" name="toggleg1" id="bywhen" checked/><span>Transaction By Period</span>
                                    </div>
                                    <div>
                                        <input type="radio" name="toggleg1" id="bydr"/><span>Transaction By Date</span>
                                    </div>
                                </div>
                                <div class="date-range">
                                    <div id="byPeriod" style="display: none;">
                                         <select>
                                            <option>1 Month</option>
                                            <option>1 Day</option>
                                            <option>1 Week</option>
                                            <option>3 Months</option>
                                            <option>6 Months</option>
                                            <option>1 Year</option>
                                        </select>
                                    </div>
                                    <div id="bydate" style="display: none;">
                                        <label>From</label>
                                        <input id="byDateFromAS" type="date" />
                                        <label>To</label>
                                        <input id="byDateToAS" type="date" />
                                    </div>
                                    <select style="display:none">
                                        <option>Download</option>
                                        <option>XLS</option>
                                        <option>CSV</option>
                                        <option>PDF</option>
                                    </select>
                                    <button id="printbtnAS">Print</button>
                                </div>
                                </div>
                            </div>
                        </div>
        
                    <div class="tabcontent" id="tabEMS">
                        <div class="chart-item" style="width: 99.6%; height: 487px; position: relative;">
                            <h2>Operational</h2>
                            <div id="chart_EMS"></div>
                            <div id="operabackButton"></div>
                            <div style="margin-top: 110px;" id="operaTableView"></div>
                            <div class="dateRange">
                                <div class="period">
                                    <div>
                                        <input type="radio" name="toggleg2" id="bywhen-op" checked/><span>Transaction By Period</span>
                                    </div>
                                    <div>
                                        <input type="radio" name="toggleg2" id="bydr-op"/><span>Transaction By Date</span>
                                    </div>
                                </div>
                                <div class="date-range">
                                    <div id="byPeriod-op" style="display: none;">
                                         <select>
                                            <option>1 Month</option>
                                            <option>1 Day</option>
                                            <option>1 Week</option>
                                            <option>3 Months</option>
                                            <option>6 Months</option>
                                            <option>1 Year</option>
                                        </select>
                                    </div>
                                    <div id="bydate-op" style="display: none;">
                                        <label>From</label>
                                        <input id="byDateFromEM" type="date" />
                                        <label>To</label>
                                        <input id="byDateToEM" type="date" />
                                    </div>
                                    <select id="downloadEM" style="display:none">
                                        <option>Download</option>
                                        <option>XLS</option>
                                        <option>CSV</option>
                                        <option>PDF</option>
                                    </select>
                                    <button id="printbtnEM">Print</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tabcontent" id="tabFD">
                        <div class="chart-item" style="width: 99.6%; height: 487px; position: relative;">
                            <h2>Business Operations</h2>
                            <div id="chart_FD"></div>
                            <div id="businessbackButton"></div>
                            <div style="margin-top: 110px;" id="businesstableView"></div>
                            <div class="dateRange">
                                <div class="period">
                                    <div>
                                        <input type="radio" name="toggleg3" id="bywhen-fd" checked/><span>Transaction By Period</span>
                                     </div>
                                     <div>
                                        <input type="radio" name="toggleg3" id="bydr-fd"/><span>Transaction By Date</span>
                                    </div>
                                </div>
                                <div class="date-range">
                                    <div id="byPeriod-fd" style="display: none;">
                                         <select>
                                            <option>1 Month</option>
                                            <option>1 Day</option>
                                            <option>1 Week</option>
                                            <option>3 Months</option>
                                            <option>6 Months</option>
                                            <option>1 Year</option>
                                        </select>
                                    </div>
                                    <div id="bydate-fd" style="display: none;">
                                        <label>From</label>
                                        <input id="byDateFromFD" type="date" />
                                        <label>To</label>
                                        <input id="byDateToFD" type="date" />
                                    </div>
                                    <select id="downloadFD" style="display:none">
                                        <option>Download</option>
                                        <option>XLS</option>
                                        <option>CSV</option>
                                        <option>PDF</option>
                                    </select>
                                    <button id="printbtnFD">Print</button>
                                </div>
                            </div>
                        </div>
                    </div>
    </div>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Logic for tabs ---------------------------------------------------------- Start
        function openTab(evt, tabName) {
            evt.preventDefault();
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
        }

        function blockPastDates(dateInput, yearsBack) {
            // Get today's date
            const today = new Date();

            // Calculate the date N years ago
            today.setFullYear(today.getFullYear() - yearsBack);

            // Format the date to YYYY-MM-DD (required format for 'min' attribute)
            const formattedDate = today.toISOString().split('T')[0];

            // Set the 'min' attribute on the date input to block the previous N years
            dateInput.setAttribute('min', formattedDate);
        }

        const dateFromAS = document.getElementById('byDateFromAS');
        const dateToAS = document.getElementById('byDateToAS');
        blockPastDates(dateFromAS, 1);
        blockPastDates(dateToAS, 1);
        const dateFromEM = document.getElementById('byDateFromEM');
        const dateToEM = document.getElementById('byDateToEM');
        blockPastDates(dateFromEM, 1);
        blockPastDates(dateToEM, 1);
        const dateFromFD = document.getElementById('byDateFromFD');
        const dateToFD = document.getElementById('byDateToFD');
        blockPastDates(dateFromFD, 1);
        blockPastDates(dateToFD, 1);
        
        

        function handleRadioButtons(radioButton1, radioButton2, itemToShow, itemToHide) {
            // Event listener for the first radio button
            radioButton1.addEventListener('click', function () {
                itemToShow.style.display = 'block';
                itemToHide.style.display = 'none';
            });

            // Event listener for the second radio button
            radioButton2.addEventListener('click', function () {
                itemToHide.style.display = 'block';
                itemToShow.style.display = 'none';
            });

            // Initialize the display based on the checked state of the radio buttons
            if (radioButton1.checked) {
                itemToShow.style.display = 'block';
                itemToHide.style.display = 'none';
            }
        }

        // First set of radio buttons and corresponding elements
        const radio1 = document.getElementById('bywhen');
        const radio2 = document.getElementById('bydr');
        const itemByPeriod = document.getElementById('byPeriod');
        const itemByDate = document.getElementById('bydate');

        handleRadioButtons(radio1, radio2, itemByPeriod, itemByDate);

        // Second set of radio buttons and corresponding elements
        const radioop1 = document.getElementById('bywhen-op');
        const radioop2 = document.getElementById('bydr-op');
        const itemByPeriodop = document.getElementById('byPeriod-op');
        const itemByDateop = document.getElementById('bydate-op');

        handleRadioButtons(radioop1, radioop2, itemByPeriodop, itemByDateop);

        // Third set of radio buttons and corresponding elements
        const radiofd1 = document.getElementById('bywhen-fd');
        const radiofd2 = document.getElementById('bydr-fd');
        const itemByPeriodfd = document.getElementById('byPeriod-fd');
        const itemByDatefd = document.getElementById('bydate-fd');

        handleRadioButtons(radiofd1, radiofd2, itemByPeriodfd, itemByDatefd);

        // Open the default tab
        document.getElementsByClassName("tablinks")[0].click();
      

        // Open for default tab/eCERPAC Application 

        google.charts.load('current', {
            packages: ['corechart', 'line', 'table']
        });
        google.charts.setOnLoadCallback(applicantChart);
        google.charts.setOnLoadCallback(operadrawChart);
        google.charts.setOnLoadCallback(drawFDChart);

        

        let currentLevel = 0;
        let dataLevels = [];
            function callAPI(flag, successCallback) {
                $.ajax({
                    type: "GET",
                    url: "http://192.168.5.202:8083/api/Applicant/CGDashboard",
                    data: { flag: flag },
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        successCallback(response);
                    },
                    error: function () {
                        console.error("Error in fetching data.");
                    },
                    404: function () {
                        console.error('Error: API endpoint not found');
                    },
                    complete: function () {
                        console.log('API Call Completed');
                    }
                });
            }

            function applicantChart() {
                callAPI("eCerpacLevelCount", function (response) {
                    dataLevels.push(response);
                    drawApplicantChart(response);  // Your function to handle the response
                });
            };

            function drawApplicantChart(dataValues) {
                let totalSubmitted = 0;
                let totalApproved = 0;
                let totalRejected = 0;
                let totalCorrected = 0;

                for (var i = 0; i < dataValues.length; i++) {
                    // Ensure that the values are numbers (use 0 if missing or invalid)
                    totalSubmitted += parseFloat(dataValues[i].applicationSubmitted) || 0;
                    totalApproved += parseFloat(dataValues[i].applicationApproved) || 0;
                    totalRejected += parseFloat(dataValues[i].applicationRejected) || 0;
                    totalCorrected += parseFloat(dataValues[i].applicationCorrected) || 0;
                }

                var options = {
                    title: 'Application Status',
                    pieSliceText: 'value',
                    backgroundColor: '#eaf5e5',
                    legend: { position: 'left' },
                    chartArea: {
                        width: '80%',
                        height: '70%',
                        top: 100, 
                        left: 50
                    },
                    'height': 400,
                    'width': 770,
                    is3D: true, 
                    curveType: 'function',
                };

                // Create a new DataTable to store the chart data
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Category');
                data.addColumn('number', 'Count');
                // Add rows to the DataTable based on the summed totals
                data.addRow(['Applications Submitted', totalSubmitted]);
                data.addRow(['Applications Approved', totalApproved]);
                data.addRow(['Applications Rejected', totalRejected]);
                data.addRow(['Applications Corrected', totalCorrected]);

                // Instantiate and draw our chart, passing in some options
                var chart = new google.visualization.PieChart(document.getElementById('chart_AAS'));
                chart.draw(data, options);
                google.visualization.events.addListener(chart, 'select', function () {
                    var selection = chart.getSelection();
                    if (selection.length > 0) {
                        if (currentLevel === 0) {
                            callAPI("eCerpacCategory", function (response) {
                                currentLevel++;
                                dataLevels.push(response); // Save data for the current level
                                drawApplicantCategoryChart(response);  // Draw the chart for the next level
                                showBackButton(); // Show the back button
                            });
                        }
                    }
                });
        }

        function drawApplicantCategoryChart(dataValues) {

            var options = {
                title: 'Category',
                pieSliceText: 'value',
                backgroundColor: '#eaf5e5',
                legend: { position: 'left' },
                chartArea: {
                    width: '80%',
                    height: '70%',
                    top: 100,
                    left: 50
                },
                'height': 400,
                'width': 770,
                is3D: true,
                curveType: 'function',
            };

            // Create a new DataTable to store the chart data
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Category');
            data.addColumn('number', 'Value');
            for (var i = 0; i < dataValues.length; i++) {
                // Get the category and its corresponding value
                var category = dataValues[i].category;
                var val = parseFloat(dataValues[i].val) || 0;  // Ensure the value is a number, default to 0 if missing

                // Add a new row to the DataTable
                data.addRow([category, val]);
            }

            // Instantiate and draw our chart, passing in some options
            var chart = new google.visualization.PieChart(document.getElementById('chart_AAS'));
            chart.draw(data, options);
            google.visualization.events.addListener(chart, 'select', function () {
                const selection = chart.getSelection();
                if (selection.length > 0) {
                    // Drill down further based on the category
                    callAPI("eCerpacCategoryDetails", function (response) {
                        currentLevel++;
                        dataLevels.push(response); // Save data for the current level
                        drawApplicantCategoryDetailsChart(response); // Draw the next level chart
                        showBackButton(); // Show the back button
                    });
                }
            });
        }



        function showBackButton() {
            var backButton = document.createElement('button');
            backButton.innerHTML = 'Back';
            backButton.style.position = 'absolute';
            backButton.style.top = '9px';
            backButton.style.right = '10px';
            backButton.style.background = '#fff';
            backButton.style.color = '#007C45';
            backButton.style.padding = '5px';
            backButton.style.borderRadius = '5px';
            backButton.style.cursor = 'pointer';
            backButton.style.border = 'none';
            backButton.onclick = drillUp; // Link back button to drillUp function
            // Clear previous back button before adding new one
            document.getElementById('backButton').innerHTML = '';
            document.getElementById('backButton').appendChild(backButton);
        }

        function drillUp() {
            if (currentLevel > 0) {
                currentLevel--; // Go back to the previous level
                const previousData = dataLevels[currentLevel];
                if (currentLevel === 0) {
                    drawApplicantChart(previousData);  // Redraw the initial level chart
                } else {
                    drawApplicantCategoryChart(previousData);  // Redraw the category-level chart
                }

                // Hide the back button if we've reached the top level
                if (currentLevel === 0) {
                    document.getElementById('backButton').innerHTML = '';
                }
            }
        }

        
        // ---------------------------------------------------------------- End



        //Operational google chart ------------------------------------------------- Start


        var operacurrentLevel = 0;
        var operadataLevels = [
            [
                ['Category', 'Value'],
                ['Airport', 11],
                ['Land Border', 10],
                ['Sea', 20]
            ],
            [
                ['Months', 'IN', 'OUT'],
                ['Jan', 300, 400],
                ['Feb', 330, 430],
                ['Mar', 340, 440],
                ['Apr', 320, 420],
                ['May', 300, 400],
                ['Jun', 340, 440],
                ['Jul', 360, 360],
                ['Aug', 380, 480],
                ['Sep', 400, 400],
                ['Oct', 410, 410],
                ['Nov', 405, 505],
                ['Dec', 300, 500],
            ],
            [
                ['Category', 'Value'],
                ['Valid', 400],
                ['Not Valid', 300]
            ],
            [
                ['S No.', 'eCERPAC ID', 'Full Name', 'Passport No.', 'Expiry Date', 'Status'],
                ['1', 'ABCHG143', 'Somya Pandit', '12345678', '03/15/2024', 'In Nigeria - Abuja'],
                ['2', 'ABCHG623', 'Rana Nnaji', '34245678', '04/15/2024', 'Out of Country'],
                ['3', 'ABCHG163', 'Burna Nnaji', '98745678', '05/15/2024', 'In Nigeria - Bauchi']
            ]
        ];

        var operadata, operachart, operaoptions;
        var selectListenerOP;
        function operadrawChart() {
            document.getElementById('operaTableView').innerHTML = '';
            operadata = google.visualization.arrayToDataTable(operadataLevels[operacurrentLevel]);
            var operachartTitle = 'Status';
            operachart = new google.visualization.PieChart(document.getElementById('chart_EMS'));
            let legendPos = 'left'
            switch (operacurrentLevel) {
                case 1:
                    operachartTitle = 'In/Out'
                    legendPos = 'bottom'
                    operachart = new google.visualization.LineChart(document.getElementById('chart_EMS'));
                    break;
                case 2:
                    operachartTitle = 'Over Stay'
                    legendPos = 'left'
                    operachart = new google.visualization.PieChart(document.getElementById('chart_EMS'));
                    break;
            }
            if (operacurrentLevel === operadataLevels.length - 1) {
                operadisplayTable();
            } else {
                options = {
                    title: operachartTitle,
                    backgroundColor: '#eaf5e5',
                    legend: { position: legendPos },
                    chartArea: {
                        width: '80%',
                        height: '70%',
                        top: 100,
                        left: 50
                    },
                    'height': 400,
                    'width': 770,
                     is3D: true,
                    curveType: 'function',
                };
                operachart.draw(operadata, options);
                selectListenerOP && google.visualization.events.removeListener(selectListenerOP);
                selectListenerOP = google.visualization.events.addListener(operachart, 'click', function () {

                    var selection = operachart.getSelection();
                    if (selection.length > 0) {

                        // Drill down to the next level if available
                        if (operacurrentLevel < operadataLevels.length - 1) {
                            operacurrentLevel++;
                            operadrawChart(); // Redraw the chart with the next level
                            operashowBackButton();
                            document.getElementById('downloadEM').style.display = 'none';
                        } else {
                            // If last level, show the table view
                            operadisplayTable();
                        }
                    }
                });
            }
        }

        function operashowBackButton() {
            var backButton = document.createElement('button');
            backButton.innerHTML = 'Back';
            backButton.style.position = 'absolute';
            backButton.style.top = '9px';
            backButton.style.right = '10px';
            backButton.style.background = '#fff';
            backButton.style.color = '#007C45';
            backButton.style.padding = '5px';
            backButton.style.borderRadius = '5px';
            backButton.style.cursor = 'pointer';
            backButton.style.border = 'none';
            backButton.onclick = operadrillUp; // Link back button to drillUp function
            // Clear previous back button before adding new one
            document.getElementById('operabackButton').innerHTML = '';
            document.getElementById('operabackButton').appendChild(backButton);
        }

        function operadrillUp() {
            if (operacurrentLevel > 0) {
                operacurrentLevel--; // Go back to the previous level
                operadrawChart(); // Redraw the chart with the previous level

                // Show the back button again if drilling down is possible
                if (operacurrentLevel > 0 && operacurrentLevel < operadataLevels.length - 1) {
                    operashowBackButton();
                    document.getElementById('operaTableView').style.display = 'none';
                    document.getElementById('chart_EMS').style.display = 'block';
                } else {
                    // Optionally hide back button if no further drill-down levels exist
                    document.getElementById('operabackButton').innerHTML = '';
                }
            }
        }

        function operadisplayTable() {
            var table = new google.visualization.Table(document.getElementById('operaTableView'));
            var tableData = google.visualization.arrayToDataTable(operadataLevels[operacurrentLevel]);
            var options = {
                showRowNumber: false, // Display row fnumbers
                backgroundColor: '#eaf5e5',
                height: '100%',
                'width': 770,
                cssClassNames: {
                    headerRow: 'tableHeader', // Style the header row
                    tableCell: 'tableCell', // Style table cells
                }
            };
            table.draw(tableData, options);
            // Hide the pie chart and show the table
            debugger;
            document.getElementById('chart_EMS').style.display = 'none';
            document.getElementById('operaTableView').style.display = 'block';
            document.getElementById('downloadEM').style.display = 'block';
        }


        // ---------------------------------------------------------------- End

        //Business Operations google chart------------------------------- Start

        var businesscurrentLevel = 0;
        var businessdataLevels = [
            [
                ['Months', 'Payments'],
                ['Jan', 100],
                ['Feb', 200],
                ['Mar', 400],
                ['Apr', 110],
                ['May', 220],
                ['Jun', 420],
                ['Jul', 120],
                ['Aug', 240],
                ['Sep', 440],
                ['Oct', 160],
                ['Nov', 230],
                ['Dec', 420]
            ],
            [
                ['Name', 'No'],
                ['JIBO', 300],
                ['AJOKU', 330],
                ['NIAGWAN', 340],
                ['NWAFOR', 320],
                ['ITOTOH', 300],
                ['ALAJOGUN', 340],
                ['ADEOLA', 360],
                ['CHIROMA', 380],
                ['UMAR', 400],
                ['OBIH', 410],
                ['OLOYEDE', 405],
                ['DANGALADIMA', 300],
            ],
            [
                ['Duration', 'No'],
                ['1 Week', 300],
                ['2 Week', 330],
                ['4 Week', 340],
                ['> 4 Week', 320]
            ],
            [
                ['S No.', 'eCERPAC ID', 'Full Name', 'Passport No.', 'Expiry Date', 'Status'],
                ['1', 'ABCHG143', 'Somya Pandit', '12345678', '03/15/2024', 'In Nigeria - Abuja'],
                ['2', 'ABCHG623', 'Rana Nnaji', '34245678', '04/15/2024', 'Out of Country'],
                ['3', 'ABCHG163', 'Burna Nnaji', '98745678', '05/15/2024', 'In Nigeria - Bauchi']
            ]
        ];

        var businessdata, businesschart, businessoptions;
        var selectListenerFD;
        function drawFDChart() {
            document.getElementById('businesstableView').innerHTML = '';
            businessdata = google.visualization.arrayToDataTable(businessdataLevels[businesscurrentLevel]);
            var businesschartTitle = 'Business';
            businesschart = new google.visualization.ComboChart(document.getElementById('chart_FD'));
            switch (businesscurrentLevel) {
                case 1:
                    businesschartTitle = 'Comptroller Name'
                    businesschart = new google.visualization.PieChart(document.getElementById('chart_FD'));
                    break;
                case 2:
                    businesschartTitle = 'Ageing'
                    businesschart = new google.visualization.PieChart(document.getElementById('chart_FD'));
                    break;
            }
            if (businesscurrentLevel === businessdataLevels.length - 1) {
                businessdisplayTable();
            } else {
                options = {
                    title: businesschartTitle,
                    pieSliceText: 'value',
                    vAxis: { title: 'Payments' },
                    hAxis: { title: 'Months' },
                    seriesType: 'bars',
                    colors: ['green', 'red', 'orange','blue'], // Custom colors for each category
                    backgroundColor: '#eaf5e5',
                    'height': 400,
                    'width': 770,
                    legend: { position: 'left' },
                    chartArea: {
                        width: '80%',
                        height: '70%',
                        top: 100,
                        left: 50
                    },
                    is3D: true,
                };
                businesschart.draw(businessdata, options);
                selectListenerFD && google.visualization.events.removeListener(selectListenerFD);
                selectListenerFD = google.visualization.events.addListener(businesschart, 'click', function () {

                    var selection = businesschart.getSelection();
                    if (selection.length > 0) {

                        // Drill down to the next level if available
                        if (businesscurrentLevel < businessdataLevels.length - 1) {
                            businesscurrentLevel++;
                            drawFDChart(); // Redraw the chart with the next level
                            businessshowBackButton();
                            document.getElementById('downloadFD').style.display = 'none';
                        } else {
                            // If last level, show the table view
                            businessdisplayTable();
                        }
                    }
                });
            }
        }

        function businessshowBackButton() {
            var backButton = document.createElement('button');
            backButton.innerHTML = 'Back';
            backButton.style.position = 'absolute';
            backButton.style.top = '9px';
            backButton.style.right = '10px';
            backButton.style.background = '#fff';
            backButton.style.color = '#007C45';
            backButton.style.padding = '5px';
            backButton.style.borderRadius = '5px';
            backButton.style.cursor = 'pointer';
            backButton.style.border = 'none';
            backButton.onclick = businessdrillUp; // Link back button to drillUp function
            // Clear previous back button before adding new one
            document.getElementById('businessbackButton').innerHTML = '';
            document.getElementById('businessbackButton').appendChild(backButton);
        }

        function businessdrillUp() {
            if (businesscurrentLevel > 0) {
                businesscurrentLevel--; // Go back to the previous level
                drawFDChart(); // Redraw the chart with the previous level

                // Show the back button again if drilling down is possible
                if (businesscurrentLevel > 0 && businesscurrentLevel < businessdataLevels.length - 1) {
                    businessshowBackButton();
                    document.getElementById('businesstableView').style.display = 'none';
                    document.getElementById('chart_FD').style.display = 'block';
                } else {
                    // Optionally hide back button if no further drill-down levels exist
                    document.getElementById('businessbackButton').innerHTML = '';
                }
            }
        }

        function businessdisplayTable() {
            var table = new google.visualization.Table(document.getElementById('businesstableView'));
            var tableData = google.visualization.arrayToDataTable(businessdataLevels[businesscurrentLevel]);
            var options = {
                showRowNumber: false, // Display row numbers
                backgroundColor: '#eaf5e5',
                height: '100%',
                'width': 770,
                cssClassNames: {
                    headerRow: 'tableHeader', // Style the header row
                    tableCell: 'tableCell', // Style table cells
                }
            };
            table.draw(tableData, options);
            // Hide the pie chart and show the table
            document.getElementById('chart_FD').style.display = 'none';
            document.getElementById('businesstableView').style.display = 'block';
            document.getElementById('downloadFD').style.display = 'block';
        }


        // ---------------------------------------------------------------- End
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
   </asp:Content>
