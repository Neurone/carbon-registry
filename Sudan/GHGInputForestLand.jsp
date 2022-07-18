<%@page import="com.sudan.model.ghg.afolu.land.*"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>GHG Inventory</title>
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
<script src="global_assets/js/plugins/forms/selects/select2.min.js"></script>
<script src="global_assets/js/plugins/forms/styling/uniform.min.js"></script>
<script src="global_assets/js/plugins/extensions/jquery_ui/interactions.min.js"></script>

<script src="assets/js/app.js"></script>

<script src="global_assets/js/demo_pages/form_select2.js"></script>
<script src="global_assets/js/demo_pages/form_layouts.js"></script>
<!-- /theme JS files -->

</head>
<jsp:include page="Menu.jsp" />
<jsp:include page="common.jsp" />
<%
String selectedYear = (String)request.getAttribute("selectedYear");

if(request.getAttribute("ghgMapping") !=null){
	session.setAttribute("ghgMapping", request.getAttribute("ghgMapping"));
}

if(request.getAttribute("years") !=null){
	session.setAttribute("years", request.getAttribute("years"));
}

List<GHGInputForestLand> existingGHGInputForest = null;

if(request.getAttribute("existingGHGInputForest")!=null){
	existingGHGInputForest = (List<GHGInputForestLand>)request.getAttribute("existingGHGInputForest");
	
	
}
String fromApprovalDashboard = request.getParameter("fromApprovalDashboard"); 
%>

<body>
	<!-- Page content -->

	<!-- Main content -->
<div class="content-wrapper">
	
	<!-- Content area -->
<div class="content">

	<!-- 2 columns form -->
<div class="card border-pink">
	<div class="card-header bg-pink-600">
		<h5 class="card-title text-uppercase text-center">GHG Inventory - Forest Land</h5>
	</div>

	<div class="card-body">
	<form action="saveGHGInputForestLand" method="post" onsubmit="return setValues();" class="form-horizontal bordered-row" id="ghgInputForm" data-parsley-validate="">
                    <input type="hidden" name = "fourEyesStatus" id = "fourEyesStatus" value="">
                   <input type="hidden" name = "ghgInput.dataId" id = "dataId">
<div class="card-body font-size-lg">
    <div class="form-group row">
<label class="col-lg-2 col-form-label text-right">Inventory Year</label>
    <div class="col-lg-4">
  	<select name="ghgInput.year" required onchange="getData();" data-placeholder="--Select--" class="form-control select" id="yearId"  data-fouc>
  	<c:if test = "${selectedYear eq null }">
   <option></option>
   </c:if>
   							<option value="${selectedYear}">${selectedYear}</option>
   							<c:forEach var="listValue" items="${years}">
							<c:if test = "${listValue ne selectedYear }">
							<option value="${listValue}">${listValue}</option>
							</c:if>
							</c:forEach>
    </select>
    </div>
    <label class="col-lg-2 col-form-label text-right">Sector</label>
   <div class="col-lg-4">
     <select name="ghgInput.sector" id="sector" class="form-control select">
     <option value="${ghgMapping.sector}">${ghgMapping.sector}</option>
     </select>
   </div>
   </div>
   <div class="form-group row">
   <label class="col-lg-2 col-form-label text-right">Category</label>
   <div class="col-lg-4">
   <select name="ghgInput.category" id="category" class="form-control select">
    <option value="${ghgMapping.category}">${ghgMapping.category}</option>
     </select>
   </div>
   <label class="col-lg-2 col-form-label text-right">Sub Sector</label>
   <div class="col-lg-4">
   <select name="ghgInput.subSector" id="subSector" class="form-control select">
   <option value="${ghgMapping.subSector}">${ghgMapping.subSector}</option>
     </select>
   </div>
  </div>
  <div class="form-group row">
   <label class="col-lg-2 col-form-label text-right">Calculation Approach</label>
   <div class="col-lg-4">
   <select name="ghgInput.calcApproach" required data-placeholder="--Select--" class="form-control select" id="calcApproach">
      <option></option>
	  <option value="Tier I">Tier I</option>
	  <option value="Tier II">Tier II</option>
	</select> 
   </div>
  </div>
  <hr>            
                
<div class="form-group">
      				<div class="card">
                    <div class="card-body">
      <h6 class="card-title">Forest Data</h6>
					<div class="table-responsive">
						<table id="ghgTable1" class="table table-bordered table-striped">
                            <thead>
                            <tr class="bg-pink-600">
								<th>Forest Category</th>
                                <th>Area (Ha)</th>
                                <th>GHG Emissions (tCO<sub>2</sub>)</th>
								<th>Reference</th>

                                </tr>
                            </thead>
                            <tbody>
                            <c:choose>
							<c:when test = "${empty existingGHGInputForest}">
                            <tr>
                                <td>Forest land Remaining Forest land</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
								<td contenteditable='true'></td>
                                </tr>
                                <tr>
                                <td>Cropland converted to Forest Land</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
								<td contenteditable='true'></td>
                                </tr>
                                <tr>
                                <td>Grassland converted to Forest Land</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
								<td contenteditable='true'></td>
                                </tr>
                                <tr>
                                <td>Wetlands converted to Forest Land</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
								<td contenteditable='true'></td>
                                </tr>
                                <tr>
                                <td>Settlements converted to Forest Land</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
								<td contenteditable='true'></td>
                                </tr>
                                <tr>
                                <td>Other Land converted to Forest Land</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true"></td>
								<td contenteditable='true'></td>
                                </tr>
                                </c:when>
                                <c:otherwise>
								<c:forEach var="output" varStatus="loop" items="${existingGHGInputForest}">
                                 <tr>
							    <td>${output.getLandcategory()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${output.getArea()}</td>
                                <td contenteditable='true' class ="input-mask-trigger" data-inputmask="'alias': 'decimal', 'autoGroup': true" im-insert="true">${output.getEmissions()}</td>
								<td contenteditable='true'>${output.getReference()}</td>
								</tr>
								</c:forEach>
                                </c:otherwise>
							</c:choose>	
                            </tbody>
                           </table> 
						</div><br>
						<span class="text-danger-700 font-size-sm">*Please refer to the calculation sheet attached in the User Manual for estimating GHG emissions</span>                       
                        	
						</div></div></div>
				
	     <div class="form-group">
                <span class="col-sm-3 control-label">Remarks</span>
<div class="col-sm-12">
<textarea class="form-control" id="remarks" name="remarks">${existingGHGInputForest[0].getRemarks()}</textarea>
     </div>
</div>

<div id = "commentButton" style="display: none">
<div class="form-group">
<span class="col-sm-3 control-label">Approver Comments</span>
<div class="col-sm-12">
<textarea class="form-control" id="approverRemarks" name="approverRemarks"> </textarea>
</div>
</div>
</div>



<div class="bg-default content-box text-center pad20A mrg25T">
    <button  id = "submitButton"  class="btn bg-pink-600">Save/Submit</button>
</div>

<div class="row">
<div class="col-md-3">
</div>
          
<div class="col-md-5">
<div class="form-group ">
<b><span class="col-sm-6 control-label" style="float:left"></span></b>
<div class="col-sm-6">
<div id = "approvalButton" style="display: none">
<button id = "Approved" onclick="setStatus(this.id);" class="btn bg-pink-600">Approve</button>
</div>
</div>
</div>
</div>
 

<div class="col-md-4">
<div class="form-group">
<div class="col-sm-6">
<div id = "rejectionButton" style="display: none">
<button id = "Rejected" onclick="setStatus(this.id);"  class="btn bg-pink-600">Reject</button>
</div> 
</div>
</div>
</div></div></div></form></div></div></div></div></body>

<script>

function setValues(){
    var table = document.getElementById('ghgTable1');
    var rowLength = table.rows.length;
    
    for (i = 1; i < rowLength; i++){
       var cells = table.rows.item(i).cells;
       var cellLength = cells.length;
      
       var x = i-1;
       for(var j = 0; j < cellLength; j++){
           var cell = cells.item(j);
           var cellVal = cell.innerHTML;
    
           var name ;
           if(j==0 ){
        	   name = "gHGInputForestLandList["+x+"].landcategory";
           }
           if(j==1){
        	   name = "gHGInputForestLandList["+x+"].area";
           }
           if(j==2){
        	   name = "gHGInputForestLandList["+x+"].emissions";
           }
           if(j==3){
         	  name = "gHGInputForestLandList["+x+"].reference";
            }
           
           createHiddenField(name,cellVal);
          
        }
	 }
	return true;
}

function createHiddenField(name, value){
	if(document.getElementsByName(name).length != 0) { //already exist
		
	}else{
		var input = document.createElement("input");
		input.setAttribute("type", "hidden");
		input.setAttribute("name", name);
		input.setAttribute("id", name);
		input.setAttribute("value", value); 
		document.getElementById("ghgInputForm").appendChild(input);
	}
	
}

function getData(){
	var sector = document.getElementById("sector").value;
	var subSector = document.getElementById("subSector").value;
	var category = document.getElementById("category").value;
	var subCategory = document.getElementById("subSector").value;
	var year = document.getElementById("yearId").value;
	
	var url = '/getGHGInputForestExisting?sector=' + sector + '&subSector='+subSector  + '&category='+category + '&subCategory='+subCategory + '&year='+year + '&status=ANY';
	window.location.href = url;

}
var fromApproval = "<%=fromApprovalDashboard%>";
handleButtonsGHG2(fromApproval);


function setStatus(id){
	document.getElementById('fourEyesStatus').value = id;
	<% if(existingGHGInputForest!=null && !existingGHGInputForest.isEmpty()) { %>
	document.getElementById('dataId').value = "<%=existingGHGInputForest.get(0).getDataId()%>";
	<% } %>
}

<% if(existingGHGInputForest!=null && !existingGHGInputForest.isEmpty()) {
	%>
		document.getElementById('fourEyesStatus').value = 'Pending_Update';
		document.getElementById('calcApproach').value = "<%=existingGHGInputForest.get(0).getCalcApproach()%>";
	<%
		} else {
	%>
		document.getElementById('fourEyesStatus').value = 'Pending_Insert';
	<%
		}
	%>
</script>                   
<script src="global_assets/input-mask.js"></script>
   <script src="global_assets/js/input-mask.js"></script>
</html>
