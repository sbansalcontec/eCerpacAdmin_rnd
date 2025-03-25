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
            padding: 8px 40px;
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
            padding: 4px 2px;
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
            margin-right: 4px;
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
        .totalCount {
            position:absolute;
            left:20px;
            bottom:20px;
            font-size:18px;
            color:#000;
            font-weight:bold;
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
                            <div id="AASMessage" class="totalCount"></div>
                            <div id="backButton"></div>
                            <div style="margin-top: 110px; padding:0px 10px 10px; height:300px" id="tableView"></div>
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
                                         <select id="periodSelect">
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
                                    <button style="display:none" id="getDataAS">Submit</button>
                                    <!--<button id="printbtnAS">Print</button>-->
                                </div>
                                </div>
                            </div>
                        </div>
        
                    <div class="tabcontent" id="tabEMS">
                        <div class="chart-item" style="width: 99.6%; height: 487px; position: relative;">
                            <h2>Operational</h2>
                            <div id="chart_EMS"></div>
                            <div id="EMSMessage" class="totalCount"></div>
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
                                         <select id="periodSelectOP">
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
                                    <button style="display:none" id="getDataOP">Submit</button>
                                    <!--<button id="printbtnEM">Print</button>-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tabcontent" id="tabFD">
                        <div class="chart-item" style="width: 99.6%; height: 487px; position: relative;">
                            <h2>Business Operations</h2>
                            <div id="chart_FD"></div>
                            <div id="FDMessage" class="totalCount"></div>
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
                                         <select id="periodSelectFD">
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
                                    <button style="display:none" id="getDataFD">Submit</button>
                                    <!--<button id="printbtnFD">Print</button>-->
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
        
        dateFromAS.addEventListener('input', function () {
            const selectedFromDate = new Date(dateFromAS.value);
            const today = new Date();

            // Format the today date
            today.setHours(0, 0, 0, 0);  // Remove time part for comparison
            const formattedToday = today.toISOString().split('T')[0];

            // If 'from' date is today or in the past
            if (selectedFromDate < today) {
                // Set 'to' date to be active till today
                dateToAS.setAttribute('max', formattedToday); // Max date = today
                dateToAS.setAttribute('min', dateFromAS.value); // Min date = 'from' date
            } else if (selectedFromDate.toISOString().split('T')[0] === formattedToday) {
                // If 'from' date is today
                dateToAS.setAttribute('max', formattedToday); // Max date = today
                dateToAS.setAttribute('min', formattedToday); // Min date = today
            } else {
                // If 'from' date is in the future, set 'to' date to the next day
                selectedFromDate.setDate(selectedFromDate.getDate() + 1); // Add one day
                const formattedNextDay = selectedFromDate.toISOString().split('T')[0];
                dateToAS.setAttribute('min', formattedNextDay); // Restrict 'to' date to next day
                dateToAS.setAttribute('max', formattedToday); // Max date = today
            }
        });

        const dateFromEM = document.getElementById('byDateFromEM');
        const dateToEM = document.getElementById('byDateToEM');
        blockPastDates(dateFromEM, 1);
        blockPastDates(dateToEM, 1);
        dateFromEM.addEventListener('input', function () {
            const selectedFromDate = new Date(dateFromEM.value);
            const today = new Date();

            // Format the today date
            today.setHours(0, 0, 0, 0);  // Remove time part for comparison
            const formattedToday = today.toISOString().split('T')[0];

            // If 'from' date is today or in the past
            if (selectedFromDate < today) {
                // Set 'to' date to be active till today
                dateToEM.setAttribute('max', formattedToday); // Max date = today
                dateToEM.setAttribute('min', dateFromEM.value); // Min date = 'from' date
            } else if (selectedFromDate.toISOString().split('T')[0] === formattedToday) {
                // If 'from' date is today
                dateToEM.setAttribute('max', formattedToday); // Max date = today
                dateToEM.setAttribute('min', formattedToday); // Min date = today
            } else {
                // If 'from' date is in the future, set 'to' date to the next day
                selectedFromDate.setDate(selectedFromDate.getDate() + 1); // Add one day
                const formattedNextDay = selectedFromDate.toISOString().split('T')[0];
                dateToEM.setAttribute('min', formattedNextDay); // Restrict 'to' date to next day
                dateToEM.setAttribute('max', formattedToday); // Max date = today
            }
        });


        const dateFromFD = document.getElementById('byDateFromFD');
        const dateToFD = document.getElementById('byDateToFD');
        blockPastDates(dateFromFD, 1);
        blockPastDates(dateToFD, 1);

        dateFromFD.addEventListener('input', function () {
            const selectedFromDate = new Date(dateFromFD.value);
            const today = new Date();

            // Format the today date
            today.setHours(0, 0, 0, 0);  // Remove time part for comparison
            const formattedToday = today.toISOString().split('T')[0];
            // If 'from' date is today or in the past
            if (selectedFromDate < today) {
                // Set 'to' date to be active till today
                dateToFD.setAttribute('max', formattedToday); // Max date = today
                dateToFD.setAttribute('min', dateFromFD.value); // Min date = 'from' date
            } else if (selectedFromDate.toISOString().split('T')[0] === formattedToday) {
                // If 'from' date is today
                dateToFD.setAttribute('max', formattedToday); // Max date = today
                dateToFD.setAttribute('min', formattedToday); // Min date = today
            } else {
                // If 'from' date is in the future, set 'to' date to the next day
                selectedFromDate.setDate(selectedFromDate.getDate() + 1); // Add one day
                const formattedNextDay = selectedFromDate.toISOString().split('T')[0];
                dateToFD.setAttribute('min', formattedNextDay); // Restrict 'to' date to next day
                dateToFD.setAttribute('max', formattedToday); // Max date = today
            }
        });
        
        

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
        //google.charts.setOnLoadCallback(applicantChart);
        google.charts.setOnLoadCallback(customedrawChart);
        google.charts.setOnLoadCallback(operadrawChart);
        google.charts.setOnLoadCallback(drawFDChart);



        // With Hard Code data on google chart ---------------- Start----------------------
        var cLevel = 0;
        var dLevels = [
            [
                ['Category', 'Value'],
                ['Application Approved', 200],
                ['Application Rejected', 50],
                ['Application Corrected', 30],
                ['Application In Process', 20]
            ],
            [
                ['Category', 'Value'],
                ['AR', 50],
                ['AO', 30],
                ['AO/AB', 30],
                ['CR', 20]
            ],
            [
                ['Category', 'Value'],
                ['Asia', 20],
                ['Africa', 50],
                ['Europe', 30],
                ['North America', 30],
                ['Oceania', 60],
                ['South America', 10]
            ],
            [
                ['Category', 'Value'],
                ['Abia', 10],
                ['Adamawa', 20],
                ['Akwa Ibom', 10],
                ['Anambra', 20],
                ['Bauchi', 10],
                ['Bayelsa', 10]
            ],
            [
                ['S No.', 'eCERPAC No', 'eCERPAC Type', 'eCERPAC Expiry', 'Full Name', 'Passport No.', 'Passport Expiry', 'Nationality', 'Main/Dependent', 'Status'],
                [1, 'NG123456789', 'Type A', '2026-12-31', 'John Doe', 'A12345678', '2029-06-30', 'Nigerian', 'Main', 'Active'],
                [2, 'NG987654321', 'Type B', '2025-09-15', 'Mary Smith', 'B98765432', '2030-11-20', 'Nigerian', 'Dependent', 'Active'],
                [3, 'NG234567890', 'Type C', '2027-01-25', 'Chike Obi', 'C23456789', '2028-03-15', 'Nigerian', 'Main', 'Inactive'],
                [4, 'NG567890123', 'Type A', '2026-04-10', 'Ngozi Okonjo', 'D23456701', '2031-07-22', 'Nigerian', 'Main', 'Active'],
                [5, 'NG112233445', 'Type B', '2024-11-05', 'Adebayo Adewale', 'E34567890', '2027-12-11', 'Nigerian', 'Dependent', 'Active'],
                [6, 'NG223344556', 'Type A', '2026-08-12', 'Ifeoma Anozie', 'F45678901', '2029-05-15', 'Nigerian', 'Main', 'Active'],
                [7, 'NG334455667', 'Type C', '2027-02-05', 'Emeka Uzoma', 'G56789012', '2028-11-25', 'Nigerian', 'Main', 'Inactive'],
                [8, 'NG445566778', 'Type B', '2025-06-30', 'Chinonso Okafor', 'H67890123', '2030-09-11', 'Nigerian', 'Dependent', 'Active'],
                [9, 'NG556677889', 'Type A', '2026-10-01', 'Oluwaseun Balogun', 'I78901234', '2032-02-28', 'Nigerian', 'Main', 'Active'],
                [10, 'NG667788990', 'Type C', '2027-03-14', 'Grace Nwachukwu', 'J89012345', '2029-08-18', 'Nigerian', 'Dependent', 'Inactive'],
                [11, 'NG778899001', 'Type B', '2025-04-20', 'David Nnaji', 'K90123456', '2029-12-15', 'Nigerian', 'Main', 'Active'],
                [12, 'NG889900112', 'Type A', '2026-11-12', 'Fatimah Aliyu', 'L01234567', '2030-06-17', 'Nigerian', 'Main', 'Inactive'],
                [13, 'NG990011223', 'Type C', '2027-07-22', 'Mohammed Bello', 'M12345678', '2028-10-19', 'Nigerian', 'Dependent', 'Active'],
                [14, 'NG101112233', 'Type B', '2025-10-05', 'Amina Yusuf', 'N23456789', '2031-01-25', 'Nigerian', 'Main', 'Inactive'],
                [15, 'NG112233445', 'Type A', '2026-01-15', 'Kehinde Adedeji', 'O34567890', '2029-09-10', 'Nigerian', 'Main', 'Active'],
                [16, 'NG223344556', 'Type C', '2027-09-30', 'Rita Egbe', 'P45678901', '2028-05-12', 'Nigerian', 'Dependent', 'Active'],
                [17, 'NG334455667', 'Type A', '2026-03-28', 'Seyi Olanrewaju', 'Q56789012', '2030-08-14', 'Nigerian', 'Main', 'Inactive'],
                [18, 'NG445566778', 'Type B', '2025-01-19', 'Durojaiye Olorunfemi', 'R67890123', '2032-04-27', 'Nigerian', 'Main', 'Active'],
                [19, 'NG556677889', 'Type C', '2027-08-04', 'Oluwafemi Adeyemi', 'S78901234', '2028-12-09', 'Nigerian', 'Dependent', 'Active'],
                [20, 'NG667788990', 'Type A', '2026-05-23', 'Ayodele Akintoye', 'T89012345', '2031-09-30', 'Nigerian', 'Main', 'Active']
            ]
        ];

        var data, chart, options;
        var selectListenerAS;

        function customedrawChart() {
            document.getElementById('tableView').innerHTML = '';
            data = google.visualization.arrayToDataTable(dLevels[cLevel]);
            var chartTitle = 'Application Status';
            switch (cLevel) {
                case 1:
                    chartTitle = 'Categories'
                    break;
                case 2:
                    chartTitle = 'Geographical Regions'
                    break;
                case 3:
                    chartTitle = 'Expat state wise distribution'
                    break;
                default:
                    break;
            }
            if (cLevel === dLevels.length - 1) {
                cdisplayTable();
            } else {
                options = {
                    title: chartTitle,
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
                    'width': 700,
                    is3D: true,
                    curveType: 'function',
                };


                chart = new google.visualization.PieChart(document.getElementById('chart_AAS'));
                chart.draw(data, options);
                selectListenerAS = google.visualization.events.addListener(chart, 'select', function () {
                    var selection = chart.getSelection();
                    if (selection.length > 0) {
                        // Drill down to the next level if available
                        if (cLevel < dLevels.length - 1) {
                            cLevel++;
                            customedrawChart(); // Redraw the chart with the next level
                            cshowBackButton();
                            document.getElementById('printBtn').style.display = "block"
                            document.getElementById('printSelect').style.display = "none"
                        } else {
                            // If last level, show the table view
                            document.getElementById('printBtn').style.display = "none"
                            document.getElementById('printSelect').style.display = "block"
                            cdisplayTable();
                        }
                    }
                });
            }
        }

        function cshowBackButton() {
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
            backButton.onclick = cdrillUp; // Link back button to drillUp function
            // Clear previous back button before adding new one
            document.getElementById('backButton').innerHTML = '';
            document.getElementById('backButton').appendChild(backButton);
        }

        function cdrillUp(e) {
            e.preventDefault();
            if (cLevel > 0) {
                cLevel--; // Go back to the previous level
                customedrawChart(); // Redraw the chart with the previous level

                // Show the back button again if drilling down is possible
                if (cLevel > 0 && cLevel < dLevels.length - 1) {
                    cshowBackButton();
                    document.getElementById('tableView').style.display = 'none';
                    document.getElementById('chart_AAS').style.display = 'block';
                    // document.getElementById('printBtn').style.display = "block";
                    // document.getElementById('printSelect').style.display = "none"
                } else {
                    // Optionally hide back button if no further drill-down levels exist
                    // document.getElementById('printBtn').style.display = "none"
                    // document.getElementById('printSelect').style.display = "block"
                    document.getElementById('backButton').innerHTML = '';
                }
            }
        }

        function cdisplayTable() {
            var table = new google.visualization.Table(document.getElementById('tableView'));
            var tableData = google.visualization.arrayToDataTable(dLevels[cLevel]);
            var options = {
                showRowNumber: false, // Display row numbers
                width: '750', // Set the table width
                height: '100%', // Set the table height
                cssClassNames: {
                    headerRow: 'tableHeader', // Style the header row
                    tableCell: 'tableCell', // Style table cells
                },
            };
            table.draw(tableData, options);
            // Hide the pie chart and show the table
            document.getElementById('chart_AAS').style.display = 'none';
            document.getElementById('tableView').style.display = 'block';
        }

        // With Hard Code data on Google chart ---------------- End-----------------------

        let currentLevel = 0;
        let dataLevels = [];
        function callAPI(startDate, endDate, type, successCallback) {
            $.ajax({
                type: "GET",
                url: "http://192.168.5.202:8083/api/eCerpacReports/CGDashboard",
                data: { startDate: startDate, endDate: endDate, type: type },
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

        function callAPIForTable(startDate, endDate, applicationStatus, category, continent, successCallback) {
            $.ajax({
                type: "GET",
                url: "http://192.168.5.202:8083/api/eCerpacReports/CGDashboardDetailed",
                data: { startDate: startDate, endDate: endDate, status: applicationStatus, category: category, continent: continent },
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
            callDataOnSelectedRange();
        };

        // Function to handle date calculation based on selection
        function getStartAndEndDate(selectedOption) {
            const today = new Date();

            const formatDate = (date) => {
                const year = date.getFullYear();
                const month = (date.getMonth() + 1).toString().padStart(2, '0');
                const day = date.getDate().toString().padStart(2, '0');
                return `${year}-${month}-${day}`;
            };

            let startDate = formatDate(new Date());
            let endDate;

            if (selectedOption) {
                switch (selectedOption) {
                    case '1 Month':
                        endDate = new Date(today.setMonth(today.getMonth() - 1));
                        break;
                    case '1 Day':
                        endDate = new Date(today.setDate(today.getDate() - 1));
                        break;
                    case '1 Week':
                        endDate = new Date(today.setDate(today.getDate() - 7));
                        break;
                    case '3 Months':
                        endDate = new Date(today.setMonth(today.getMonth() - 3));
                        break;
                    case '6 Months':
                        endDate = new Date(today.setMonth(today.getMonth() - 6));
                        break;
                    case '1 Year':
                        endDate = new Date(today.setFullYear(today.getFullYear() - 1));
                        break;
                    default:
                        endDate = today;
                }
            }

            return {
                startDate: startDate,
                endDate: formatDate(endDate),
            };
        }

        const startDateInput = document.getElementById('byDateFromAS')
        const endDateInput = document.getElementById('byDateToAS');


        // Function to retrieve selected date range and trigger the API call
        function getSelectedRange() {
            const selectedOption = document.querySelector('input[name="toggleg1"]:checked').id;
            let startDate, endDate, type;

            if (selectedOption === 'bywhen') {
                // Get predefined period range
                const period = document.getElementById('periodSelect').value;
                const { startDate: sd, endDate: ed } = getStartAndEndDate(period);
                startDate = sd;
                endDate = ed;
            } else if (selectedOption === 'bydr') {
                // Get custom date range
                startDate = document.getElementById('byDateFromAS').value;
                endDate = document.getElementById('byDateToAS').value;
            }
            return [startDate, endDate];
        }

        function callDataOnSelectedRange() {
            const [startDate, endDate] = getSelectedRange();
            if (startDate && endDate) {
                //callAPI(endDate, startDate, 0, function (response) {
                //    dataLevels.push(response.data);
                //    drawApplicantChart(response.data);  // Your function to handle the response
                //});
            }
        }

        // Event listener to trigger API when the date range changes

        document.getElementById('periodSelect').addEventListener('change', callDataOnSelectedRange);
        document.getElementById('bydr').addEventListener('change', resetDates)
        function resetDates() {
            if (startDateInput.value && endDateInput.value) {
                startDateInput.value = null
                endDateInput.value = null;
            }
        }
        function checkStartAndEndDate() {
            
            const button = document.getElementById('getDataAS');
            if (startDateInput.value && endDateInput.value) {
                button.style.display = 'block'; // Show submit button
                button.addEventListener('click', getDataAsRange);
            } else {
                button.style.display = 'none'; // Hide submit button
            }
        }

        startDateInput.addEventListener('input', checkStartAndEndDate);
        endDateInput.addEventListener('input', checkStartAndEndDate);

        function getDataAsRange(event) {
            event.preventDefault();
            const [startDate, endDate] = getSelectedRange();
            if (startDate && endDate) {
                callAPI(endDate, startDate, 0, function (response) {
                    currentLevel++;
                    dataLevels.push(response.data);
                    if (currentLevel === 1) {
                        drawApplicantCategoryChart(response.data);  // Your function to handle the response
                    }
                    showBackButton(); // Show the back button
                });
            }
        }
        
        function drawApplicantChart(dataValues) {
            //let totalSubmitted = 0;
            let totalApproved = 0;
            let totalRejected = 0;
            let totalCorrected = 0;
            let totalInProcess = 0;

            for (var i = 0; i < dataValues.length; i++) {
                // Ensure that the values are numbers (use 0 if missing or invalid)
                //totalSubmitted += parseFloat(dataValues[i]['Application Submitted']) || 0;
                totalApproved += parseFloat(dataValues[i]['ApplicationApproved']) || 0;
                totalRejected += parseFloat(dataValues[i]['Rejected']) || 0;
                totalCorrected += parseFloat(dataValues[i]['Corrected']) || 0;
                totalInProcess += parseFloat(dataValues[i]['ApplicationWIP']) || 0;
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
                'width': 700,
                is3D: true, 
                curveType: 'function',
            };

            // Create a new DataTable to store the chart data
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Category');
            data.addColumn('number', 'Count');
            // Add rows to the DataTable based on the summed totals
            //data.addRow(['Applications Submitted', totalSubmitted]);
            data.addRow(['Applications Approved', totalApproved]);
            data.addRow(['Applications Rejected', totalRejected]);
            data.addRow(['Applications Corrected', totalCorrected]);
            data.addRow(['Applications In Process', totalInProcess]);

            // Instantiate and draw our chart, passing in some options
            var chart = new google.visualization.PieChart(document.getElementById('chart_AAS'));
            chart.draw(data, options);
            // Update the custom message inside the #AASMessage div
            var messageDiv = document.getElementById('AASMessage');
            messageDiv.innerHTML = 'Total Applications Submitted: ' + (totalApproved + totalRejected + totalCorrected + totalInProcess);
            google.visualization.events.addListener(chart, 'select', function () {
               
                var selection = chart.getSelection();
                if (selection.length > 0) {

                    var selectedItem = selection[0];
                    var selectedRow = selectedItem.row;
                    var category = data.getValue(selectedRow, 0);
                    var count = data.getValue(selectedRow, 1);
                    if (currentLevel === 0) {
                        const [startDate, endDate] = getSelectedRange();
                        if (startDate && endDate) {
                            callAPI(endDate, startDate, 0, function (response) {
                                currentLevel++;
                                dataLevels.push(response.data);
                                drawApplicantCategoryChart(response.data);  // Your function to handle the response
                                showBackButton(); // Show the back button
                            });
                        }
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
                'width': 700,
                is3D: true,
                curveType: 'function',
            };

            // Create a new DataTable to store the chart data
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Category');
            data.addColumn('number', 'Value');

            for (var i = 0; i < dataValues.length; i++) {
                // Get the category and its corresponding value
                var category = dataValues[i].CategoryType;
                var val = parseFloat(dataValues[i].VAL) || 0;  // Ensure the value is a number, default to 0 if missing

                // Add a new row to the DataTable
                data.addRow([category, val]);
            }


            // Instantiate and draw our chart, passing in some options
            var chart = new google.visualization.PieChart(document.getElementById('chart_AAS'));
            chart.draw(data, options);
            google.visualization.events.addListener(chart, 'select', function () {
                const selection = chart.getSelection();
                if (selection.length > 0) {
                    const [startDate, endDate] = getSelectedRange();
                    if (startDate && endDate) {
                        callAPI(endDate, startDate, 1, function (response) {
                            currentLevel++;
                            dataLevels.push(response.data);
                            drawApplicantCategoryDetailsChart(response.data, category);  // Your function to handle the response
                            showBackButton(); // Show the back button
                        });
                    }
                }
            });
        }


        function drawApplicantCategoryDetailsChart(dataValues, recCateg) {
            var options = {
                title: 'Geographical Regions',
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
                'width': 700,
                is3D: true,
                curveType: 'function',
            };

            // Create a new DataTable to store the chart data
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Continent');
            data.addColumn('number', 'Value');
            
            for (var i = 0; i < dataValues.length; i++) {
                // Get the category and its corresponding value
                var continent = dataValues[i].Continent;
                var val = parseFloat(dataValues[i].VAL) || 0;  // Ensure the value is a number, default to 0 if missing

                // Add a new row to the DataTable
                if (recCateg === dataValues[i].CategoryType) {
                    data.addRow([continent, val]);
                }
            }

            // Instantiate and draw our chart, passing in some options
            var chart = new google.visualization.PieChart(document.getElementById('chart_AAS'));
            chart.draw(data, options);
            google.visualization.events.addListener(chart, 'select', function () {
                const selection = chart.getSelection();
                if (selection.length > 0) {
                    var selectedItem = selection[0];
                    var selectedRow = selectedItem.row;
                    var category = data.getValue(selectedRow, 0);
                    var count = data.getValue(selectedRow, 1);
                    const [startDate, endDate] = getSelectedRange();
                    if (startDate && endDate) {
                        //callAPIForTable(endDate, startDate, '', recCateg, "Asia" , function (response) {
                        //    currentLevel++;
                        //    dataLevels.push(response.data);
                        //    drawApplicantGridData(response.data);  // Your function to handle the response
                        //    showBackButton(); // Show the back button
                        //});
                    }
                }
            });
        }


        function drawApplicantGridData() {
            
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

        function drillUp(e) {
            e.preventDefault();
            if (currentLevel > 0) {
                currentLevel--; // Go back to the previous level
                const previousData = dataLevels[currentLevel];
                if (currentLevel === 0) {
                    //drawApplicantChart(previousData);  // Redraw the initial level chart
                } else {
                    //drawApplicantCategoryChart(previousData);  // Redraw the category-level chart
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
        var operadataLevels = [];
        function callCommonAPI(startDate, endDate, APIurl, successCallback) {
            $.ajax({
                type: "GET",
                url: APIurl,
                data: { startDate: startDate, endDate: endDate },
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

        // Function to handle date calculation based on selection
        function getStartAndEndDateOP(selectedOption) {
            const today = new Date();

            const formatDate = (date) => {
                const year = date.getFullYear();
                const month = (date.getMonth() + 1).toString().padStart(2, '0');
                const day = date.getDate().toString().padStart(2, '0');
                return `${year}-${month}-${day}`;
            };

            let startDate = formatDate(new Date());
            let endDate;

            if (selectedOption) {
                switch (selectedOption) {
                    case '1 Month':
                        endDate = new Date(today.setMonth(today.getMonth() - 1));
                        break;
                    case '1 Day':
                        endDate = new Date(today.setDate(today.getDate() - 1));
                        break;
                    case '1 Week':
                        endDate = new Date(today.setDate(today.getDate() - 7));
                        break;
                    case '3 Months':
                        endDate = new Date(today.setMonth(today.getMonth() - 3));
                        break;
                    case '6 Months':
                        endDate = new Date(today.setMonth(today.getMonth() - 6));
                        break;
                    case '1 Year':
                        endDate = new Date(today.setFullYear(today.getFullYear() - 1));
                        break;
                    default:
                        endDate = today;
                }
            }

            return {
                startDate: startDate,
                endDate: formatDate(endDate),
            };
        }

        const startDateInputOP = document.getElementById('byDateFromEM')
        const endDateInputOP = document.getElementById('byDateToEM');


        // Function to retrieve selected date range and trigger the API call
        function getSelectedRangeOP() {
            const selectedOption = document.querySelector('input[name="toggleg2"]:checked').id;
            let startDate, endDate;

            if (selectedOption === 'bywhen-op') {
                // Get predefined period range
                const period = document.getElementById('periodSelectOP').value;
                const { startDate: sd, endDate: ed } = getStartAndEndDateOP(period);
                startDate = sd;
                endDate = ed;
            } else if (selectedOption === 'bydr-op') {
                // Get custom date range
                startDate = document.getElementById('byDateFromEM').value;
                endDate = document.getElementById('byDateToEM').value;
            }
            return [startDate, endDate];
        }

        function callDataOnSelectedRangeOP() {
            const [startDate, endDate] = getSelectedRangeOP();
            if (startDate && endDate) {
                callCommonAPI(endDate, startDate, 'http://192.168.5.202:8083/api/eCerpacReports/CGDashboardArDr', function (response) {
                    operadataLevels.push(response.data);
                    operadrawFirstChart(response.data);  // Your function to handle the response
                });
            }
        }

        // Event listener to trigger API when the date range changes

        document.getElementById('periodSelectOP').addEventListener('change', callDataOnSelectedRangeOP);
        document.getElementById('bydr-op').addEventListener('change', resetDatesOP)
        function resetDatesOP() {
            if (startDateInputOP.value && endDateInput.value) {
                startDateInputOP.value = null
                endDateInputOP.value = null;
            }
        }
        function checkStartAndEndDateOP() {
            const button = document.getElementById('getDataOP');
            if (startDateInputOP.value && endDateInputOP.value) {
                button.style.display = 'block'; // Show submit button
                button.addEventListener('click', getDataAsRangeOP);
            } else {
                button.style.display = 'none'; // Hide submit button
            }
        }

        startDateInputOP.addEventListener('input', checkStartAndEndDateOP);
        endDateInputOP.addEventListener('input', checkStartAndEndDateOP);

        function getDataAsRangeOP(event) {
            event.preventDefault();
            getSelectedRangeOP();
        }

        function operadrawChart() {
            callDataOnSelectedRangeOP();
        }

        function operadrawFirstChart(dataValues) {
            var options = {
                title: 'Port Of Ingress/Egress',
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
                'width': 700,
                is3D: true,
                curveType: 'function',
            };
            // Create a new DataTable to store the chart data
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Category');
            data.addColumn('number', 'Count');
            let totalIngress = 0;
            let totalEgress = 0;
            dataValues.forEach(item => {
                data.addRow([item.Module, item.Count]);
                // Update total counts
                totalIngress += item.A_Count;
                totalEgress += item.D_Count;
            });
            var operachart = new google.visualization.PieChart(document.getElementById('chart_EMS'));
            operachart.draw(data, options);
            // Update the custom message inside the #EMSMessage div
            var messageDiv = document.getElementById('EMSMessage');
            messageDiv.innerHTML = 'Total Ingress: ' + totalIngress + ',Total Egress: ' + totalEgress;
            google.visualization.events.addListener(operachart, 'select', function () {
                var selection = operachart.getSelection();
                if (selection.length > 0) {
                    if (operacurrentLevel === 0) {
                        const [startDate, endDate] = getSelectedRangeOP();
                        if (startDate && endDate) {
                            callCommonAPI(endDate, startDate, 'http://192.168.5.202:8083/api/eCerpacReports/CGDashboardInOut', function (response) {
                                operacurrentLevel++;
                                operadataLevels.push(response.data);
                                operadrawSecondChart(response.data);
                                operashowBackButton();
                            });
                        }
                    }
                }
            });
        }

        function operadrawSecondChart(dataValues) {
            var options = {
                title: 'Ingress/Egress',
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
                'width': 700,
                is3D: true,
                curveType: 'function',
            };
            // Create a new DataTable to store the chart data
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Month');
            data.addColumn('number', 'Ingress');
            data.addColumn('number', 'Egress');
            console.log(dataValues)
            // Populate the data table with the values from dataValues
            dataValues.forEach(item => {
                // Add a row for each month, with corresponding ingress and egress values
                data.addRow([item.MonthName, item.A_Count, item.D_Count]);
            });
            var operachart = new google.visualization.LineChart(document.getElementById('chart_EMS'));
            operachart.draw(data, options);
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

        function operadrillUp(e) {
            e.preventDefault();
            if (operacurrentLevel > 0) {
                operacurrentLevel--; // Go back to the previous level
                operadrawChart(); // Redraw the chart with the previous level

                // Show the back button again if drilling down is possible
                if (operacurrentLevel > 0 && operacurrentLevel < operadataLevels.length - 1) {
                    operashowBackButton();
                    //document.getElementById('operaTableView').style.display = 'none';
                    document.getElementById('chart_EMS').style.display = 'block';
                } else {
                    // Optionally hide back button if no further drill-down levels exist
                    document.getElementById('operabackButton').innerHTML = '';
                }
            }
        }


        // ---------------------------------------------------------------- End

        //Business Operations google chart------------------------------- Start



        var businesscurrentLevel = 0;
        var businessdataLevels = [];
        

        // Function to handle date calculation based on selection
        function getStartAndEndDateFD(selectedOption) {
            const today = new Date();

            const formatDate = (date) => {
                const year = date.getFullYear();
                const month = (date.getMonth() + 1).toString().padStart(2, '0');
                const day = date.getDate().toString().padStart(2, '0');
                return `${year}-${month}-${day}`;
            };

            let startDate = formatDate(new Date());
            let endDate;

            if (selectedOption) {
                switch (selectedOption) {
                    case '1 Month':
                        endDate = new Date(today.setMonth(today.getMonth() - 1));
                        break;
                    case '1 Day':
                        endDate = new Date(today.setDate(today.getDate() - 1));
                        break;
                    case '1 Week':
                        endDate = new Date(today.setDate(today.getDate() - 7));
                        break;
                    case '3 Months':
                        endDate = new Date(today.setMonth(today.getMonth() - 3));
                        break;
                    case '6 Months':
                        endDate = new Date(today.setMonth(today.getMonth() - 6));
                        break;
                    case '1 Year':
                        endDate = new Date(today.setFullYear(today.getFullYear() - 1));
                        break;
                    default:
                        endDate = today;
                }
            }

            return {
                startDate: startDate,
                endDate: formatDate(endDate),
            };
        }

        const startDateInputFD = document.getElementById('byDateFromFD')
        const endDateInputFD = document.getElementById('byDateToFD');


        // Function to retrieve selected date range and trigger the API call
        function getSelectedRangeFD() {
            const selectedOption = document.querySelector('input[name="toggleg3"]:checked').id;
            let startDate, endDate;

            if (selectedOption === 'bywhen-fd') {
                // Get predefined period range
                const period = document.getElementById('periodSelectFD').value;
                const { startDate: sd, endDate: ed } = getStartAndEndDateFD(period);
                startDate = sd;
                endDate = ed;
            } else if (selectedOption === 'bydr-fd') {
                // Get custom date range
                startDate = document.getElementById('byDateFromFD').value;
                endDate = document.getElementById('byDateToFD').value;
            }
            return [startDate, endDate];
        }

        function callDataOnSelectedRangeFD() {
            const [startDate, endDate] = getSelectedRangeFD();
            if (startDate && endDate) {
                callCommonAPI(endDate, startDate, 'http://192.168.5.202:8083/api/eCerpacReports/CGDashboardMonthlyPayment', function (response) {
                    operadataLevels.push(response.data);
                    fddrawFirstChart(response.data);  // Your function to handle the response
                });
            }
        }

        // Event listener to trigger API when the date range changes

        document.getElementById('periodSelectFD').addEventListener('change', callDataOnSelectedRangeFD);
        document.getElementById('bydr-fd').addEventListener('change', resetDatesFD)
        function resetDatesFD() {
            if (startDateInputFD.value && endDateInputFD.value) {
                startDateInputFD.value = null
                endDateInputFD.value = null;
            }
        }
        function checkStartAndEndDateFD() {
            const button = document.getElementById('getDataFD');
            if (startDateInputFD.value && endDateInputFD.value) {
                button.style.display = 'block'; // Show submit button
                button.addEventListener('click', getDataAsRangeFD);
            } else {
                button.style.display = 'none'; // Hide submit button
            }
        }

        startDateInputFD.addEventListener('input', checkStartAndEndDateFD);
        endDateInputFD.addEventListener('input', checkStartAndEndDateFD);

        function getDataAsRangeFD(event) {
            event.preventDefault();
            getSelectedRangeFD();
        }

        function drawFDChart() {
            callDataOnSelectedRangeFD();
        }

        function fddrawFirstChart(dataValues) {
            var options = {
                title: 'Monthly Payment Recieved ',
                vAxis: { title: 'Payments in $' },
                hAxis: { title: 'Months' },
                seriesType: 'bars',
                colors: ['green'],
                backgroundColor: '#eaf5e5',
                legend: { position: 'left' },
                chartArea: {
                    width: '75%',
                    height: '60%',
                    top: 100,
                    left: 150
                },
                'height': 400,
                'width': 700,
                is3D: true,
                curveType: 'function',
            };
            // Create a new DataTable to store the chart data
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Month');
            data.addColumn('number', 'Count');
            data.addColumn('number', 'Total Amount');
            // Initialize the total count variable
            let totalAmount = 0;
            dataValues.forEach(item => {
                // Add a row for each month with Count and Total_Amount
                data.addRow([item.Month, item.Count, item.Total_Amount]);
                totalAmount += item.Total_Amount;
            });
            var operachart = new google.visualization.ComboChart(document.getElementById('chart_FD'));
            operachart.draw(data, options);
            var messageDiv = document.getElementById('FDMessage');
            messageDiv.innerHTML = 'Total Payment Recieved: $' + totalAmount;
            google.visualization.events.addListener(operachart, 'select', function () {
                var selection = operachart.getSelection();
                if (selection.length > 0) {
                    if (operacurrentLevel === 0) {
                        const [startDate, endDate] = getSelectedRangeFD();
                        if (startDate && endDate) {
                            callCommonAPI(endDate, startDate, 'http://192.168.5.202:8083/api/eCerpacReports/CGDashboardWorkstatus', function (response) {
                                businesscurrentLevel++;
                                operadataLevels.push(response.data);
                                fddrawSecondChart(response.data);
                                fdshowBackButton();
                            });
                        }
                    }
                }
            });
        }

        function fddrawSecondChart(dataValues) {
            var options = {
                title: 'Comptroller Name',
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
                'width': 700,
                is3D: true,
                curveType: 'function',
            };
            // Create a new DataTable to store the chart data
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'User');
            data.addColumn('number', 'Count');
            console.log(dataValues)
            // Populate the data table with the values from dataValues
            dataValues.forEach(item => {
                data.addRow([item.UserName, item.count]); // Add a row for each user and their count
            });
            var operachart = new google.visualization.PieChart(document.getElementById('chart_FD'));
            operachart.draw(data, options);
        }
        

        function fdshowBackButton() {
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
            backButton.onclick = fddrillUp; // Link back button to drillUp function
            // Clear previous back button before adding new one
            document.getElementById('businessbackButton').innerHTML = '';
            document.getElementById('businessbackButton').appendChild(backButton);
        }

        function fddrillUp(e) {
            e.preventDefault();
            if (businesscurrentLevel > 0) {
                businesscurrentLevel--; // Go back to the previous level
                drawFDChart(); // Redraw the chart with the previous level

                // Show the back button again if drilling down is possible
                if (businesscurrentLevel > 0 && businesscurrentLevel < businessdataLevels.length - 1) {
                    fdshowBackButton();
                    document.getElementById('chart_FD').style.display = 'block';
                } else {
                    // Optionally hide back button if no further drill-down levels exist
                    document.getElementById('businessbackButton').innerHTML = '';
                }
            }
        }

        


        // ---------------------------------------------------------------- End
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
   </asp:Content>
