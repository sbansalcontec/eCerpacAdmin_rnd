<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPage.Master" AutoEventWireup="true" CodeBehind="frmContollerDashboard.aspx.cs" Inherits="eCerpac_NIS.frmContollerDashboard" %>
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
          padding: 8px;
          transition: 0.3s;
          font-size: 16px;
          border-radius: 5px;
          color: #008000;
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
          right: 10px;
          display: flex;
          flex-direction: row;
          gap:10px;
      }

      .period div{
          display: flex;
          align-items: center;
          gap: 10px;
          justify-content: flex-end;
      }
      .date-range{
          display: flex;
          align-items: center;
          gap: 10px;
      }

      .dateRange select,
      .dateRange input[type="date"]{
          border: none;
          border: 1px solid #ccc;
          padding: 10px;
          border-radius: 5px;
      }
      .dateRange select,
      .dateRange input[type="date"] {
          outline: none;
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
  </style>
    <script>
  function openTab(evt, tabName) {
    // Hide all tab contents
    var tabcontent = document.getElementsByClassName("tabcontent");
    for (var i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Remove "active" class from all tab buttons
    var tablinks = document.getElementsByClassName("tablinks");
    for (var i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the selected tab content
    document.getElementById(tabName).style.display = "block";

    // Add "active" class to the clicked tab button
    evt.currentTarget.className += " active";
}

// Set default tab to be open
document.addEventListener("DOMContentLoaded", function () {
    document.getElementsByClassName("tablinks")[0].click();
});
    </script>

    
 <div class="grid-section">
     
     <div class="tab">
         <button class="tablinks" onclick="openTab(event, 'tabAAS')">eCERPAC Application</button>
         <button class="tablinks" onclick="openTab(event, 'tabEMS')">Operational</button>
         <button class="tablinks" onclick="openTab(event, 'tabFD')">Business Operations</button>
     </div>
       
     <div class="tabcontent" id="tabAAS">
         <div class="chart-item" style="width: 100%; height: 487px; position: relative;">
             <h2>Application Status</h2>
             <div id="chart_AAS"></div>
             <div id="backButton"></div>
             <div style="margin-top: 110px;" id="tableView"></div>
             <div class="dateRange">
                 <div class="period">
                     <div>
                     <input type="radio"/><span>Transaction By Period : </span>
                     <select>
                         <option>Select</option>
                         <option>1 Day</option>
                         <option>1 Week</option>
                         <option>1 Month</option>
                         <option>3 Months</option>
                         <option>6 Months</option>
                         <option>1 Year</option>
                     </select>
                     </div>
                 </div>
                 <div class="date-range">
                     <input type="radio"/><span>Transaction By Date : </span>
                     <label>From</label>
                     <input type="date" />
                     <label>To</label>
                     <input type="date" />
                     <select>
                         <option>Download</option>
                         <option>XLS</option>
                         <option>CSV</option>
                         <option>PDF</option>
                     </select>
                 </div>
             </div>
         </div>
     </div>
     <div class="tabcontent" id="tabEMS">
         <div class="chart-item" style="width: 100%; height: 487px; position: relative;">
             <h2>Operational</h2>
             <div id="chart_EMS"></div>
             <div id="operabackButton"></div>
             <div style="margin-top: 110px;" id="operaTableView"></div>
             <div class="dateRange">
                 <div class="period">
                     <div>
                     <input type="radio"/><span>Transaction By Period : </span>
                     <select>
                         <option>Select</option>
                         <option>1 Day</option>
                         <option>1 Week</option>
                         <option>1 Month</option>
                         <option>3 Months</option>
                         <option>6 Months</option>
                         <option>1 Year</option>
                     </select>
                     </div>
                 </div>
                 <div class="date-range">
                     <input type="radio"/><span>Transaction By Date : </span>
                     <label>From</label>
                     <input type="date" />
                     <label>To</label>
                     <input type="date" />
                     <select>
                         <option>Download</option>
                         <option>XLS</option>
                         <option>CSV</option>
                         <option>PDF</option>
                     </select>
                 </div>
             </div>
         </div>
     </div>
     <div class="tabcontent" id="tabFD">
         <div class="chart-item" style="width: 100%; height: 487px; position: relative;">
             <h2>Business Operations</h2>
             <div id="chart_FD"></div>
             <div id="businessbackButton"></div>
             <div style="margin-top: 110px;" id="businesstableView"></div>
             <div class="dateRange">
                 <div class="period">
                     <div>
                     <input type="radio"/><span>Transaction By Period : </span>
                     <select>
                         <option>Select</option>
                         <option>1 Day</option>
                         <option>1 Week</option>
                         <option>1 Month</option>
                         <option>3 Months</option>
                         <option>6 Months</option>
                         <option>1 Year</option>
                     </select>
                     </div>
                 </div>
                 <div class="date-range">
                     <input type="radio"/><span>Transaction By Date : </span>
                     <label>From</label>
                     <input type="date" />
                     <label>To</label>
                     <input type="date" />
                     <select>
                         <option>Download</option>
                         <option>XLS</option>
                         <option>CSV</option>
                         <option>PDF</option>
                     </select>
                 </div>
             </div>
         </div>
     </div>
 </div>
       

     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script>

     // Logic for tabs ---------------------------------------------------------- Start
     function openTab(evt, tabName) {
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


     window.onload = function () {
         google.charts.load('current', {
             packages: ['corechart', 'line', 'table']
         });
         google.charts.setOnLoadCallback(drawChart);
         google.charts.setOnLoadCallback(operadrawChart);
         google.charts.setOnLoadCallback(drawFDChart);
     };

     var currentLevel = 0;
     var dataLevels = [
         [
             ['Category', 'Value'],
             ['Application Submitted', 600],
             ['Approved(eCERPAC Issued)', 500],
             ['Rejected', 300],
             ['Corrected', 200]
         ],
         [
             ['Category', 'Value'],
             ['AR', 400],
             ['AO', 300],
             ['AO/AB', 300],
             ['CR', 200]
         ],
         [
             ['Category', 'Value'],
             ['Asia', 150],
             ['Africa', 250],
             ['Europe', 120],
             ['North America', 180],
             ['Oceania', 80],
             ['South America', 190]
         ],
         [
             ['Category', 'Value'],
             ['Abia', 150],
             ['Adamawa', 250],
             ['Akwa Ibom', 120],
             ['Anambra', 180],
             ['Bauchi', 80],
             ['Bayelsa', 190]
         ],
         [
             ['S No.', 'eCERPAC ID', 'Full Name', 'Passport No.', 'Expiry Date', 'Status'],
             ['1', 'ABCHG143', 'Somya Pandit', '12345678', '03/15/2024', 'In Nigeria - Abuja'],
             ['2', 'ABCHG623', 'Rana Nnaji', '34245678', '04/15/2024', 'Out of Country'],
             ['3', 'ABCHG163', 'Burna Nnaji', '98745678', '05/15/2024', 'In Nigeria - Bauchi']
         ]
     ];

     var data, chart, options;

     function drawChart() {
         document.getElementById('tableView').innerHTML = '';
         data = google.visualization.arrayToDataTable(dataLevels[currentLevel]);
         var chartTitle = 'Application Status';
         switch (currentLevel) {
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
         if (currentLevel === dataLevels.length - 1) {
             displayTable();
         } else {
             options = {
                 title: chartTitle,
                 pieSliceText: 'percentage',
                 backgroundColor: '#F4F4F4',
                 legend: { position: 'left' },
                 'height': 444,
                 'width': 1275,
                 is3D: true,
             };


             chart = new google.visualization.PieChart(document.getElementById('chart_AAS'));
             chart.draw(data, options);
             google.visualization.events.removeListener(chart, 'select');
             google.visualization.events.addListener(chart, 'select', function () {
                 var selection = chart.getSelection();
                 if (selection.length > 0) {
                     // Drill down to the next level if available
                     if (currentLevel < dataLevels.length - 1) {
                         currentLevel++;
                         drawChart(); // Redraw the chart with the next level
                         showBackButton();
                     } else {
                         // If last level, show the table view
                         displayTable();
                     }
                 }
             });
         }
     }

     function showBackButton() {
         var backButton = document.createElement('button');
         backButton.innerHTML = 'Back';
         backButton.style.position = 'absolute';
         backButton.style.top = '50px';
         backButton.style.left = '10px';
         backButton.style.background = '#007C45';
         backButton.style.color = '#fff';
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
             drawChart(); // Redraw the chart with the previous level

             // Show the back button again if drilling down is possible
             if (currentLevel > 0 && currentLevel < dataLevels.length - 1) {
                 showBackButton();
                 document.getElementById('tableView').style.display = 'none';
                 document.getElementById('chart_AAS').style.display = 'block';
             } else {
                 // Optionally hide back button if no further drill-down levels exist
                 document.getElementById('backButton').innerHTML = '';
             }
         }
     }

     function displayTable() {
         var table = new google.visualization.Table(document.getElementById('tableView'));
         var tableData = google.visualization.arrayToDataTable(dataLevels[currentLevel]);
         var options = {
             showRowNumber: false, // Display row numbers
             width: '1275', // Set the table width
             height: '100%', // Set the table height
             cssClassNames: {
                 headerRow: 'tableHeader', // Style the header row
                 tableCell: 'tableCell', // Style table cells
             }
         };
         table.draw(tableData, options);
         // Hide the pie chart and show the table
         document.getElementById('chart_AAS').style.display = 'none';
         document.getElementById('tableView').style.display = 'block';
     }
     // ---------------------------------------------------------------- End

     //Operational google chart ------------------------------------------------- Start


     var operacurrentLevel = 0;
     var operadataLevels = [
         [
             ['Category', 'Value'],
             ['Airports', 11],
             ['Borders', 10],
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

     function operadrawChart() {
         document.getElementById('operaTableView').innerHTML = '';
         operadata = google.visualization.arrayToDataTable(operadataLevels[operacurrentLevel]);
         var operachartTitle = 'Status';
         operachart = new google.visualization.PieChart(document.getElementById('chart_EMS'));
         switch (operacurrentLevel) {
             case 1:
                 operachartTitle = 'In/Out'
                 operachart = new google.visualization.LineChart(document.getElementById('chart_EMS'));
                 break;
             case 2:
                 operachartTitle = 'Valid/Not Valid'
                 operachart = new google.visualization.PieChart(document.getElementById('chart_EMS'));
                 break;
         }
         if (operacurrentLevel === operadataLevels.length - 1) {
             operadisplayTable();
         } else {
             options = {
                 title: operachartTitle,
                 pieSliceText: 'percentage',
                 curveType: 'function',
                 backgroundColor: '#F4F4F4',
                 legend: { position: 'left' },
                 'height': 444,
                 'width': 1275,
                 is3D: true,
             };
             operachart.draw(operadata, options);
             google.visualization.events.removeListener(operachart, 'click');
             google.visualization.events.addListener(operachart, 'click', function () {

                 var selection = operachart.getSelection();
                 if (selection.length > 0) {

                     // Drill down to the next level if available
                     if (operacurrentLevel < operadataLevels.length - 1) {
                         operacurrentLevel++;
                         operadrawChart(); // Redraw the chart with the next level
                         operashowBackButton();
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
         backButton.style.top = '50px';
         backButton.style.left = '10px';
         backButton.style.background = '#007C45';
         backButton.style.color = '#fff';
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
             showRowNumber: false, // Display row numbers
             backgroundColor: '#F4F4F4',
             height: '100%',
             'width': 1275,
             cssClassNames: {
                 headerRow: 'tableHeader', // Style the header row
                 tableCell: 'tableCell', // Style table cells
             }
         };
         table.draw(tableData, options);
         // Hide the pie chart and show the table
         document.getElementById('chart_EMS').style.display = 'none';
         document.getElementById('operaTableView').style.display = 'block';
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
             ['S No.', 'eCERPAC ID', 'Full Name', 'Passport No.', 'Expiry Date', 'Status'],
             ['1', 'ABCHG143', 'Somya Pandit', '12345678', '03/15/2024', 'In Nigeria - Abuja'],
             ['2', 'ABCHG623', 'Rana Nnaji', '34245678', '04/15/2024', 'Out of Country'],
             ['3', 'ABCHG163', 'Burna Nnaji', '98745678', '05/15/2024', 'In Nigeria - Bauchi']
         ]
     ];

     var businessdata, businesschart, businessoptions;

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
         }
         if (businesscurrentLevel === businessdataLevels.length - 1) {
             businessdisplayTable();
         } else {
             options = {
                 title: businesschartTitle,
                 vAxis: { title: 'Payments' },
                 hAxis: { title: 'Months' },
                 seriesType: 'bars',
                 colors: ['green'], // Custom colors for each category
                 backgroundColor: '#F4F4F4',
                 'height': 444,
                 'width': 1275,
                 legend: { position: 'left' },
             };
             businesschart.draw(businessdata, options);
             google.visualization.events.removeListener(businesschart, 'click');
             google.visualization.events.addListener(businesschart, 'click', function () {

                 var selection = businesschart.getSelection();
                 if (selection.length > 0) {

                     // Drill down to the next level if available
                     if (businesscurrentLevel < businessdataLevels.length - 1) {
                         businesscurrentLevel++;
                         drawFDChart(); // Redraw the chart with the next level
                         businessshowBackButton();
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
         backButton.style.top = '50px';
         backButton.style.left = '10px';
         backButton.style.background = '#007C45';
         backButton.style.color = '#fff';
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
             backgroundColor: '#F4F4F4',
             height: '100%',
             'width': 1275,
             cssClassNames: {
                 headerRow: 'tableHeader', // Style the header row
                 tableCell: 'tableCell', // Style table cells
             }
         };
         table.draw(tableData, options);
         // Hide the pie chart and show the table
         document.getElementById('chart_FD').style.display = 'none';
         document.getElementById('businesstableView').style.display = 'block';
     }


     // ---------------------------------------------------------------- End

 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

</asp:Content>
