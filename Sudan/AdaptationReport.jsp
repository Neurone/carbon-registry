<%@page import="com.sudan.service.reports.*"%>
<%@page import="com.sudan.model.adaptation.AdaptationOutputCount"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<%DateFormat formatter1 = new SimpleDateFormat("dd/MM/yyyy"); %>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Adaptation Tracking Report (Generated on <%= formatter1.format(new Date())%>)</title>
	<!-- Global stylesheets -->
	<link rel="shortcut icon" href="global_assets/images/ssudan.png">
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="global_assets/css/icons/icomoon/styles.min.css" rel="stylesheet" type="text/css">
	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="assets/css/bootstrap_limitless.min.css" rel="stylesheet" type="text/css">
	<link href="assets/css/layout.min.css" rel="stylesheet" type="text/css">
	<link href="assets/css/components.min.css" rel="stylesheet" type="text/css">
	<link href="assets/css/colors.min.css" rel="stylesheet" type="text/css">
	<!-- /global stylesheets -->

	<!-- Core JS files -->
	<script src="global_assets/js/main/jquery.min.js"></script>
	<script src="global_assets/js/main/bootstrap.bundle.min.js"></script>
	<script src="global_assets/js/plugins/loaders/blockui.min.js"></script>
	<!-- /core JS files -->

	<!-- Theme JS files -->
	<script src="global_assets/js/plugins/extensions/jquery_ui/interactions.min.js"></script>
	<script src="global_assets/js/plugins/extensions/jquery_ui/touch.min.js"></script>

	<script src="assets/js/app.js"></script>
	<script src="global_assets/js/plugins/forms/selects/select2.min.js"></script>
	<script src="global_assets/js/demo_pages/form_select2.js"></script>
	<script src="global_assets/js/demo_pages/components_collapsible.js"></script>
	<script src="global_assets/js/plugins/tables/datatables/datatables.min.js"></script>
	<script src="global_assets/js/demo_pages/form_layouts.js"></script>
	<script src="global_assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script src="global_assets/js/demo_pages/form_multiselect.js"></script>
	
	<script src="global_assets/js/plugins/tables/datatables/extensions/jszip/jszip.min.js"></script>
	<script src="global_assets/js/plugins/tables/datatables/extensions/pdfmake/pdfmake.min.js"></script>
	<script src="global_assets/js/plugins/tables/datatables/extensions/pdfmake/vfs_fonts.min.js"></script>
	<script src="global_assets/js/plugins/tables/datatables/extensions/buttons.min.js"></script>
	
	<script src="global_assets/js/demo_pages/Report2.js"></script>
<!-- /theme JS files -->

</head>

<jsp:include page="Menu.jsp" />
<%
Date date = new Date();

Map<String, Integer> countMap = null;
AdaptationOutputCount adaptationOutputCount = null;
if(request.getAttribute("adaptationOutputCount") !=null){
	adaptationOutputCount = (AdaptationOutputCount)request.getAttribute("adaptationOutputCount");
	countMap = adaptationOutputCount.getCountMap();
	if(countMap.isEmpty()){
		%>
		<script>
		alert("No Data Available");
		</script>
<%		
	}	
}
List<String> categoryList = null; 
if(request.getAttribute("selectedCategory") !=null){
	String categories = (String)request.getAttribute("selectedCategory");
	categoryList = Arrays.asList(categories.split("\\s*,\\s*"));
}
%>

<body>
	<!-- Page content -->

	<!-- Main content -->
<div class="content-wrapper">
	
	<!-- Content area -->
<div class="content">

<form action="getAdaptationOutput" method="post" class="form-horizontal bordered-row" data-parsley-validate="">
	<!-- 2 columns form -->
<div class="card border-pink">
	<div class="card-header bg-pink-600">
		<h5 class="card-title text-center">Adaptation Tracking Report</h5>
	</div>
	<div class="card-body">
	  			<div class="card">
	  			    <div class="card-body">
				<div class="form-group row">
					<div class="col-lg-12">
					<div class="row">
					<label class="col-lg-2 col-form-label text-left font-size-lg"><b>Select Category</b></label>
						<div class="col-md-6">
							<select class="form-control multiselect-select-all-filtering" multiple="multiple" data-fouc name="categories" required id ="category" data-focu>
						  	  	<option value="Agriculture">Agriculture, Livestock, and Fisheries</option>
							  	<option value="Forestry">Ecosystems, Environment and Biodiversity Conservation</option>
							  	<option value="Water">Water</option>
							  	<option value="Energy">Energy</option>
							  	<option value="Health">Health</option>
							  	<option value="Disaster">Disaster Risk Reduction</option>
							  	<option value="Human">Human Settlements</option>
							  	<option value="Tourism">Tourism and Recreation</option>
							  	<option value="Infrastructure">Industry and Infrastructure</option>
						   </select>
    						
						</div>
							
						<div class="col-md-2">
								<button class="btn bg-pink-600">Get Report</button>
							</div>
					</div>
					</div>
				</div>
					
					</div></div>

          
<div class="form-group">
					
      				<div class="card">
      				<div class="card-header header-elements-inline">
						<h6 class="card-title">Adaptation Action Report</h6>
						<div class="header-elements">
							<div class="list-icons">
		                		<a class="list-icons-item" data-action="collapse"></a>
		                	</div>
	                	</div>
					</div>
                    <div class="card-body">
                    <div class="table-responsive">
						<table id="ghgTable" class="table table-bordered datatable-button-html5-columns">
	                    
                            <thead>
                            <tr class="bg-pink-600">
                                <th>Project Id</th>
                                <th>Cause</th>
								<th>Division</th>
								<th>Sector</th>
								<th>Sub-sector</th>
								<th>Project Cost(USD)</th>
								<th>Location</th>
								<th>Implementing Agency</th>
								<th>Executing Agency</th>
								<th>Commissioning Date</th>
								<th>Lifetime(Years)</th>
								<th>Included in NDC</th>
                                <th>Impact Summaries</th>
                            </tr>
                            </thead>
                            <tbody>
                            
                            <c:forEach var="entry" items="${adaptationOutputCount.getAdaptationOutputList()}">                            
                            <tr class="font-size-lg">
                            <c:url value="/getProject" var="url">
								<c:param name="projectId" value="${entry.getProject().getProjectId()}"/>
								</c:url>
								<td>${entry.getProject().getProjectId()}</td>
								<td>${entry.getProject().getCause()}</td>
								<td>${entry.getProject().getDivision()}</td>
								<td>${entry.getProject().getSector()}</td>
								<td>${entry.getProject().getSubSector()}</td>
								<td>${entry.getProject().getCostAmount()}</td>
								<td>${entry.getProject().getLocation()}</td>
								<td>${entry.getProject().getAgency()}</td>
								<td>${entry.getProject().getOtherParty()}</td>
								<td>${entry.getProject().getCommissioningDate()}</td>
								<td>${entry.getProject().getLifetime()}</td>
								<td>${entry.getProject().getNdc()}</td>
								<td>
								<c:forEach var="setValue" items="${entry.getImpactSummaries()}" varStatus="loop">${setValue}
									<%-- <img src="global_assets/images/Adp/${setValue}.png" alt="" height=25 width=25></img> --%>
									</c:forEach>
									</td>
								
							</tr>
                            </c:forEach>
                            </tbody>
                           </table>
                          	</div>
                          	<div class="font-size-xs">Report Generated on (<%=date%>)</div>  
  </div></div>

</div>
	<div class="card">
<div class="card-header header-elements-inline">
						<h6 class="card-title">Adaptation Action Summary</h6>
						<div class="header-elements">
							<div class="list-icons">
		                		<a class="list-icons-item" data-action="collapse"></a>
		                	</div>
	                	</div>
					</div>
					<div class="card-body">
<div id="number_format_chart"></div>
 </div></div>											
</div></div></form></div></div>
</body>
<script>
var selectedCategory = document.getElementById('category');
var category = [""];
</script>
<% if(categoryList !=null) {
	for(String str : categoryList){
	
%>
<script>
category.push("<%=str%>");

</script>
<%
	}
}
%>
<script>
for(var i=0; i < selectedCategory.length; i++){
	if(category.includes(selectedCategory.options[i].value)) {
		selectedCategory.options[i].selected = true;
	}
}
</script>

<script type="text/javascript" src="global_assets/js/loader.js"></script>


<% if (countMap!=null && !countMap.isEmpty()){
	%>
<script type="text/javascript">
 google.charts.load('current', {packages:['corechart']});
  google.charts.setOnLoadCallback(drawChart);
  
  function drawChart() {
	  var data = google.visualization.arrayToDataTable([
          ['Impact Category', 'Number of Projects'],
         
          
          <% for (String category:countMap.keySet()){
           %>
          
         
          ["<%=category%>", <%=countMap.get(category)%>],
         
          <% }
          %>
         
      ]);
	  
    var options = {
            fontName: 'Roboto',
            height: 400,
            fontSize: 12,
            backgroundColor: 'transparent',
            chartArea: {
                left: 'auto',
                width: '75%',
                height: 300
            },
            tooltip: {
                textStyle: {
                    fontName: 'Roboto',
                    fontSize: 13
                }
            },
            vAxis: {
                title: 'Projects by Category',
                titleTextStyle: {
                    fontSize: 13,
                    italic: false,
                    color: '#333'
                },
                textStyle: {
                    color: '#333'
                },
                baselineColor: '#ccc',
                gridlines:{
                    color: '#eee',
                    count: '100%'
                },
                minValue: 0
            },
            hAxis: {
                textStyle: {
                    color: '#333'
                }
            },
            legend: {
                position: 'top',
                alignment: 'center',
                textStyle: {
                    color: '#333'
                }
            },
            series: {
                0: { color: '#2ec7c9' },
                1: { color: '#b6a2de' }
            }
        };
    

          var chart = new google.visualization.ColumnChart(document.getElementById('number_format_chart'));
          chart.draw(data, options);

          document.getElementById('format-select').onchange = function() {
            options['vAxis']['format'] = this.value;
            chart.draw(data, options);
          };
  }
  
</script>
<%
}
%>
</html>
