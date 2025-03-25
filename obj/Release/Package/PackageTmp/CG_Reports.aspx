<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" CodeBehind="CG_Reports.aspx.cs" Inherits="eCerpac_NIS.CG_Reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .grid-section{
            width: 100%;
        }
        .chart-items{
            display: flex;
        }
        .chart-item {
            border: 1px solid #ccc;
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
        .search-data{
            display: flex;
            gap: 10px;
            justify-content: center;
            margin: 10px 0px;
        }

        .search-data button{
            outline: none;
            cursor: pointer;
            padding: 8px 50px;
            transition: 0.3s;
            font-size: 15px;
            border-radius: 5px;
            margin-right: 10px;
            border: 1px solid #007C45;
            background-color: #007C45;
            color: #fff;
        }
        .search-data input[type="text"]{
            border: none;
            border: 1px solid #000;
            padding: 8px;
            border-radius: 5px;
            outline: none;
            width:500px;
        }
        .reports-table{
            margin-left: 5px;
            margin-right: 5px;
            border: 1px solid Gray;
            background: #eaf5e5;
        }
        .reports-table table{
            width: 100%;
        }
        .reports-table table th,
        .reports-table table td{
            padding: 5px;
        }
        .reports-table table tr:hover{
            background-color: #d6e9f8;
        }
        .reports-table table tr:nth-child(even){
            background-color: #f4f4f4;
        }
        .tableHeader,
        .reports-table table tr th{
            background: #007c45;
            border: 1px solid #007c45;
            color: #fff;
        }
        .reports-table table tr th,
        .reports-table table tr td {
            text-align: left;
        }

        .reports-table table tr td{
             border: 1px solid #ccc;
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
                        <button class="tablinks" onclick="openTab(event, 'reportA')">Report A</button>
                        <button class="tablinks" onclick="openTab(event, 'reportB')">Report B</button>
                    </div>

                    <div class="tabcontent" id="reportA">
                        <div class="chart-item" style="width: 100%; height: 487px; position: relative;">
                            <h2>Report A</h2>
                            <div class="search-data">
                                <input placeholder="Enter Cerpec No." type="text"/>
                                <button>Search</button>
                            </div>
                            <div class="reports-table">
                                <table cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>Applicant Type</th>
                                            <th>Designation</th>
                                            <th>Cerpec Start Date</th>
                                            <th>Cerec End Date</th>
                                            <th>Passport No.</th>
                                            <th>Nationality</th>
                                            <th>Category Type</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Ravi</td>
                                            <td>Kumar</td>
                                            <td>Normal</td>
                                            <td>Manager</td>
                                            <td>04/03/35</td>
                                            <td>05/03/35</td>
                                            <td>12345678</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Simran</td>
                                            <td>Singh</td>
                                            <td>Normal</td>
                                            <td>Engineer</td>
                                            <td>01/01/36</td>
                                            <td>02/01/36</td>
                                            <td>23456789</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Amit</td>
                                            <td>Sharma</td>
                                            <td>Normal</td>
                                            <td>Developer</td>
                                            <td>10/02/35</td>
                                            <td>11/02/35</td>
                                            <td>34567890</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Priya</td>
                                            <td>Mehta</td>
                                            <td>Normal</td>
                                            <td>Designer</td>
                                            <td>05/03/35</td>
                                            <td>06/03/35</td>
                                            <td>45678901</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Ankit</td>
                                            <td>Verma</td>
                                            <td>Normal</td>
                                            <td>Consultant</td>
                                            <td>15/04/35</td>
                                            <td>16/04/35</td>
                                            <td>56789012</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Ritu</td>
                                            <td>Patel</td>
                                            <td>Normal</td>
                                            <td>HR</td>
                                            <td>12/05/35</td>
                                            <td>13/05/35</td>
                                            <td>67890123</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Vikram</td>
                                            <td>Gupta</td>
                                            <td>Normal</td>
                                            <td>Manager</td>
                                            <td>20/06/35</td>
                                            <td>21/06/35</td>
                                            <td>78901234</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Neha</td>
                                            <td>Yadav</td>
                                            <td>Normal</td>
                                            <td>Developer</td>
                                            <td>07/07/35</td>
                                            <td>08/07/35</td>
                                            <td>89012345</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Rohit</td>
                                            <td>Choudhary</td>
                                            <td>Normal</td>
                                            <td>Consultant</td>
                                            <td>23/08/35</td>
                                            <td>24/08/35</td>
                                            <td>90123456</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>
                                        <tr>
                                            <td>Sanya</td>
                                            <td>Joshi</td>
                                            <td>Normal</td>
                                            <td>Engineer</td>
                                            <td>02/09/35</td>
                                            <td>03/09/35</td>
                                            <td>01234567</td>
                                            <td>Indian</td>
                                            <td>Normal</td>
                                        </tr>                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="tabcontent" id="reportB">
                        <div class="chart-item" style="width: 100%; height: 487px; position: relative;">
                            <h2>Report B</h2>
                             <div class="search-data">
                                 <input placeholder="Enter Cerpec No." type="text"/>
                                 <button>Search</button>
                             </div>
                            <div class="reports-table">
                                <table cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>S No.</th>
                                            <th>Name</th>
                                            <th>Company</th>
                                            <th>Designation</th>
                                            <th>Cerpec No</th>
                                            <th>Designation</th>
                                            <th>Expiry Date</th>
                                            <th>Remarks</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Ravi Kumar</td>
                                            <td>ABC Ltd.</td>
                                            <td>Manager</td>
                                            <td>123456</td>
                                            <td>Manager</td>
                                            <td>12/12/2025</td>
                                            <td>On duty</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Simran Singh</td>
                                            <td>XYZ Pvt. Ltd.</td>
                                            <td>Engineer</td>
                                            <td>234567</td>
                                            <td>Engineer</td>
                                            <td>20/05/2026</td>
                                            <td>Pending approval</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Amit Sharma</td>
                                            <td>Tech Solutions</td>
                                            <td>Developer</td>
                                            <td>345678</td>
                                            <td>Developer</td>
                                            <td>15/11/2025</td>
                                            <td>On leave</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Priya Mehta</td>
                                            <td>DesignCo</td>
                                            <td>Designer</td>
                                            <td>456789</td>
                                            <td>Designer</td>
                                            <td>30/06/2024</td>
                                            <td>Work in progress</td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>Ankit Verma</td>
                                            <td>Consulting Inc.</td>
                                            <td>Consultant</td>
                                            <td>567890</td>
                                            <td>Consultant</td>
                                            <td>05/08/2026</td>
                                            <td>Completed</td>
                                        </tr>
                                        <tr>
                                            <td>6</td>
                                            <td>Ritu Patel</td>
                                            <td>HR Solutions</td>
                                            <td>HR Manager</td>
                                            <td>678901</td>
                                            <td>HR Manager</td>
                                            <td>01/09/2024</td>
                                            <td>On training</td>
                                        </tr>
                                        <tr>
                                            <td>7</td>
                                            <td>Vikram Gupta</td>
                                            <td>Global Enterprises</td>
                                            <td>Manager</td>
                                            <td>789012</td>
                                            <td>Manager</td>
                                            <td>18/12/2026</td>
                                            <td>Pending review</td>
                                        </tr>
                                        <tr>
                                            <td>8</td>
                                            <td>Neha Yadav</td>
                                            <td>DevWorks</td>
                                            <td>Software Engineer</td>
                                            <td>890123</td>
                                            <td>Software Engineer</td>
                                            <td>10/07/2025</td>
                                            <td>Performance review</td>
                                        </tr>
                                        <tr>
                                            <td>9</td>
                                            <td>Rohit Choudhary</td>
                                            <td>Consulting Group</td>
                                            <td>Consultant</td>
                                            <td>901234</td>
                                            <td>Consultant</td>
                                            <td>25/03/2026</td>
                                            <td>On-site</td>
                                        </tr>
                                        <tr>
                                            <td>10</td>
                                            <td>Sanya Joshi</td>
                                            <td>Tech Innovators</td>
                                            <td>Engineer</td>
                                            <td>012345</td>
                                            <td>Engineer</td>
                                            <td>12/01/2027</td>
                                            <td>On project</td>
                                        </tr> 
                                    </tbody>                                   
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
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
        const radioA1 = document.getElementById('bywhenA');
        const radioA2 = document.getElementById('bydrA');
        const itemByPeriodA = document.getElementById('byPeriodA');
        const itemByDateA = document.getElementById('bydateA');

        handleRadioButtons(radioA1, radioA2, itemByPeriodA, itemByDateA);

        // Second set of radio buttons and corresponding elements
        const radioB1 = document.getElementById('bywhenB');
        const radioB2 = document.getElementById('bydrB');
        const itemByPeriodB = document.getElementById('byPeriodB');
        const itemByDateB = document.getElementById('bydateB');

        handleRadioButtons(radioB1, radioB2, itemByPeriodB, itemByDateB);

        // Open the default tab
        document.getElementsByClassName("tablinks")[0].click();

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

        const dateFromA = document.getElementById('fromA');
        const dateToA = document.getElementById('toA');
        blockPastDates(dateFromA, 1);
        blockPastDates(dateToA, 1);
        const dateFromB = document.getElementById('fromB');
        const dateToB = document.getElementById('toB');
        blockPastDates(dateFromB, 1);
        blockPastDates(dateToB, 1);
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
