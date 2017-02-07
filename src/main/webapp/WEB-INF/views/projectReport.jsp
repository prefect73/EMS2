<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="ISO-8859-15"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
<title><spring:message code="projectReport.title" /></title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script>
var projects = [];

<c:forEach items="${projectsList}" var="pr">
projects.push({projectId : '${pr.id}', yearName : '${pr.yearName}', projectName : '${pr.projectName}'});
</c:forEach>
function format () {
	return '<table id="workPackageDetailsTable" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%"><tr><td><spring:message code="projectReport.label.totalDays" /></td><c:forEach items="${workPackageHoursForAllUsers}" var="employeeNames"><td>${employeeNames.user.firstName}(<spring:message code="generic.currencySymbol" />${employeeNames.user.perDayCost})</td></c:forEach></tr><tr><td id="totalWorkPackageHoursColumn"></td><c:forEach items="${workPackageHoursForAllUsers}" var="workPackageUserAllocation"><td class="totalWorkPackageUserHoursColumn">${workPackageUserAllocation.mJan +workPackageUserAllocation.mFeb + workPackageUserAllocation.mMar + workPackageUserAllocation.mApr + workPackageUserAllocation.mMay + workPackageUserAllocation.mJun + workPackageUserAllocation.mJul + workPackageUserAllocation.mAug +workPackageUserAllocation.mSep + workPackageUserAllocation.mOct + workPackageUserAllocation.mNov + workPackageUserAllocation.mDec}</td></c:forEach></tr></table>';
}
var  selectedSelects = JSON.parse(localStorage.getItem("selectOptions"));
function projectsByYear(){
		$('#projectNamesDropDown').find('option').remove();
		 $('#projectNamesDropDown').append('<option class="form-control input-sm" value="NONE">--------------------------Wählen--------------------------</option>');
		$('#projectNamesDropDown').find('option:selected').removeAttr('selected');
		$.each(projects, function(key,value) {
			console.log(selectedSelects.yearNamesDropDown == value.yearName);
			console.log(selectedSelects.yearNamesDropDown);
			console.log(value.yearName);
			selectedSelects = JSON.parse(localStorage.getItem("selectOptions"));
			if(selectedSelects.yearNamesDropDown == value.yearName ){
		     $('#projectNamesDropDown').append($("<option class=\"form-control input-sm\" ></option>").attr('data-year-name',value.yearName).attr("value",value.projectId).text(value.projectName));
			}
		});	
}
function makeSelectsSelected(){
	var selectOptions;
	   if(localStorage.getItem("selectOptions")) {
	       selectOptions = JSON.parse(localStorage.getItem("selectOptions"));
	       Object.keys(selectOptions).forEach(function(select) {
	         $("select[name="+select+"]").val(selectOptions[select]);
	       });
	  } else {
	     selectOptions = {};
	  }
	  $("select").change(function() {
	       var $this =  $(this),
	           selectName = $this.attr("name");
	      selectOptions[selectName] = $this.val();
	      localStorage.setItem("selectOptions", JSON.stringify(selectOptions));
	      console.log(JSON.stringify(selectOptions));
	    });
}

function yearDropdownFill(startYear, endYear){
	for (i = startYear; i <= endYear; i++){
	    $('#yearNamesDropDown').append($('<option />').val(i).html(i));
	}
}
$(document).ready(function() {
	var startYear = '<c:out value="${yearNameStart}"/>';
	var endYear = '<c:out value="${yearNameEnd}"/>';
	yearDropdownFill(startYear, endYear);
	projectsByYear();
	makeSelectsSelected();
	
	if(parseInt($("#totalCost").val()) >  parseInt($("#offeredCost").val())){
		$("#totalCost").css({ 'color': 'red'});
	}
	if(parseInt($("#effectiveCost").val()) > parseInt($("#offeredCost").val())){
		$("#effectiveCost").css({ 'color': 'red'});
	}
	$('#yearNamesDropDown').change(function(e) {
		projectsByYear();
	});

	var projectNamesDropDownSelectedValue = $('#selectedProjectNumber').val();
	$('#projectNamesDropDown').change(function(e) {
        if($('#projectNamesDropDown :selected').val()) {
        	projectNamesDropDownSelectedValue = $('#projectNamesDropDown :selected').val();
        }
        console.log("pr" + projectNamesDropDownSelectedValue);
        $('#searchByProjectNameBtn').attr('href','/EMS/Project/projectReport-' + projectNamesDropDownSelectedValue + '- ');        
    });
	
	
    var table = "";
    var workPackageDetailsTable = "";
    if($("#defaultLanguage").val() == 'german'){
    	table = $('#projectReportTable').DataTable({
	        "language": {
	            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
	        }
	    });
		
	} else if ($("#defaultLanguage").val() == 'english'){
		table = $('#projectReportTable').DataTable();
		
	} else {
		table = $('#projectReportTable').DataTable({
	        "language": {
	            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
	        }
	    });
		
	}
    
    
    if($("#defaultLanguage").val() == 'german'){
    	workPackageDetailsTable = $('#workPackageDetailsTable').DataTable({
	        "language": {
	            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
	        }
	    });
		
	} else if ($("#defaultLanguage").val() == 'english'){
		workPackageDetailsTable = $('#workPackageDetailsTable').DataTable();
		
	} else {
		workPackageDetailsTable = $('#workPackageDetailsTable').DataTable({
	        "language": {
	            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
	        }
	    });
		
	}
    
    
    if($('#workPackageHoursForAllUsers').val()) {
    	var currentURL = window.location.href;
    	var parts = currentURL.split('-');
    	var workPackage = parts.pop();
    	
    	
        var tr = $('#' + workPackage).closest('tr');
        var row = table.row( tr );
        row.child( format(row.data()) ).show();
    }
    
    $('.searchByWorkPackageNameBtn').on('click', function() {
    	var selectedWorkPackageName = $(this).text();
    	console.log("wpkg: " + selectedWorkPackageName);
    	var tr = $(this).closest('tr');
        var row = table.row( tr );
        $(this).attr('href','/EMS/Project/projectReport-' + projectNamesDropDownSelectedValue + '-' + selectedWorkPackageName);
    } );
    
    $("#totalWorkPackageHoursColumn").html(function() {
        var sum = 0;
        $(".totalWorkPackageUserHoursColumn").each(function() {
            sum += parseInt($(this).html());
        });
        return sum.toFixed(2);
    });
});
</script>
</head>

<body>
	<form:form method="POST" modelAttribute="project"
		class="form-horizontal">
		<div class="generic-container">
			<%@include file="authheader.jsp"%>
			<div class="row">
				<div class="form-group col-md-12" style="margin-top: 2%;">
					<label class="col-md-2 control-lable" for="yearName"><spring:message code="projectReport.label.yearName" />
						</label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="yearNamesDropDown" name="yearNamesDropDown" >
							<%-- <option value="NONE">--------------------------<spring:message code="generic.select.default.option" />--------------------------</option> --%>
							<!-- <option class="form-control input-sm" value="2017">2017</option>
							<option class="form-control input-sm" value="2018">2018</option>
							<option class="form-control input-sm" value="2019">2019</option>
							<option class="form-control input-sm" value="2020">2020</option> -->
							<%-- <c:forEach items="${projectsList}" var="proj">
								<option class="form-control input-sm" value="${proj.id}"
									${proj.id == project.id  ? 'selected' : ''}>${proj.projectName}</option>
							</c:forEach> --%>
						</select>
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
					<%-- <div class="col-md-3">
						<a id="searchByProjectNameBtn"
							class="btn btn-success custom-width"><spring:message code="button.search" /> </a>
					</div> --%>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="projectName"><spring:message code="project.label.projectName" />
						</label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="projectNamesDropDown" name="projectNamesDropDown" >
							<%-- <option value="NONE">--------------------------<spring:message code="generic.select.default.option" />--------------------------</option>
							<c:forEach items="${projectsList}" var="proj">
								<option class="form-control input-sm" value="${proj.id}" data-year-name="${proj.yearName}"
									${proj.id == project.id  ? 'selected' : ''}>${proj.projectName}</option>
							</c:forEach> --%>
						</select>
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
					<div class="col-md-3">
						<a id="searchByProjectNameBtn"
							class="btn btn-success custom-width"><spring:message code="button.search" /> </a>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="offeredCost"><spring:message code="project.label.offeredCost"/><spring:message code="generic.inCurrency" />
						</label>
					<div class="col-md-3">
						<form:input type="text" path="offeredCost" id="offeredCost"
							class="form-control input-sm" readonly="true"/>
						<div class="has-error">
							<form:errors path="offeredCost" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="totalCost"><spring:message code="project.label.totalCost"/><spring:message code="generic.inCurrency" />
						</label>
					<div class="col-md-3">
						<form:input type="text" path="totalCost" id="totalCost"
							class="form-control input-sm" readonly="true" />
						<div class="has-error">
							<form:errors path="totalCost" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="effectiveCost"><spring:message code="project.label.effectiveCost"/><spring:message code="generic.inCurrency" />
						</label>
					<div class="col-md-3">
						<form:input type="text" path="effectiveCost" id="effectiveCost"
							class="form-control input-sm" readonly="true" />
						<div class="has-error">
							<form:errors path="effectiveCost" class="help-inline" />
						</div>
					</div>
				</div>
			</div>


			<%-- <div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="projectName">Project
						Name</label>
					<div class="col-md-3">
						<form:select name="projectNamesDropDown" id="projectNamesDropDown"
							path="projectName" items="${projectsList}" multiple="false"
							itemValue="id" itemLabel="projectName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="well col-md-2">
				<td><a id="searchByProjectNameBtn"
					class="btn btn-success custom-width">Search</a></td>
			</div> --%>
		</div>
	</form:form>

	<input type="hidden" id="workPackageHoursForAllUsers"
		value='${workPackageHoursForAllUsers}' />

	<input type="hidden" id="selectedProjectNumber"
		value='${selectedProjectNumber}' />
	
	<form:form method="POST" modelAttribute="project"
		class="form-horizontal">
		<div id="projectReportTableWrapper" style="padding: 2%;">
			<table id="projectReportTable"
				class="table table-striped table-bordered dt-responsive nowrap"
				cellspacing="0" width="100%">
				<thead>
					<tr>
						<th><spring:message code="workPackage.label.projectName"/></th>
						<th><spring:message code="workPackage.label.workPackageName"/></th>
						<th><spring:message code="workPackage.label.offeredCost"/><spring:message code="generic.inCurrency" /></th>
						<th><spring:message code="workPackage.label.totalCost"/><spring:message code="generic.inCurrency" /></th>
						<th><spring:message code="workPackage.label.effectiveCost"/><spring:message code="generic.inCurrency" /></th>
						<th><spring:message code="workPackage.label.workPackageNumber"/></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${workPackagesByProjectID}" var="workPackage">
						<tr>
							<!-- <td class="details-control"><a
								id="searchByWorkPackageNameBtn"
								class="btn btn-success custom-width">Search</a></td> -->
							<td>${workPackage.workPackage.project.projectName}</td>
							<td>${workPackage.workPackage.workPackageName}</td>
							<td><spring:message code="generic.currencySymbol" />${workPackage.workPackage.offeredCost}</td>
							<td><spring:message code="generic.currencySymbol" />${workPackage.workPackage.totalCost}</td>
							<td><spring:message code="generic.currencySymbol" />${workPackage.workPackage.effectiveCost}</td>
							<td><a
								class="searchByWorkPackageNameBtn btn btn-success custom-width" id="${workPackage.workPackage.workPackageNumber}">${workPackage.workPackage.workPackageNumber}</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<%-- <table id="workPackageDetailsTable" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
		<thead>
		<tr>
		<c:forEach items="${workPackageHoursForAllUsers}" var="employeeNames">
		<td>${employeeNames.user.firstName}</td>
		</c:forEach>
		</tr>
		</thead>
		<tbody>
		<tr>
		<c:forEach items="${workPackageHoursForAllUsers}" var="workPackageUserAllocation">
		<td>${workPackageUserAllocation.mJan +workPackageUserAllocation.mFeb + workPackageUserAllocation.mMar + workPackageUserAllocation.mApr + workPackageUserAllocation.mMay + workPackageUserAllocation.mJun + workPackageUserAllocation.mJul + workPackageUserAllocation.mAug +workPackageUserAllocation.mSep + workPackageUserAllocation.mOct + workPackageUserAllocation.mNov + workPackageUserAllocation.mDec}</td>
		</c:forEach>
		</tr>
		</tbody>
	</table> --%>
	</form:form>
</html>