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
</head>

<body>
	<form:form method="POST" modelAttribute="project"
		class="form-horizontal">
		<div class="generic-container">
			<%@include file="authheader.jsp"%>
			<div class="row">
				<div class="form-group col-md-12" style="margin-top: 2%;">
					<label class="col-md-2 control-lable" for="projectName"><spring:message code="project.label.projectName" /></label>
					<div class="col-md-3">
						<form:select name="projectNamesDropDown" id="projectNamesDropDown"
							path="projectName" items="${projectsList}" multiple="false"
							itemValue="id" itemLabel="projectName"
							class="form-control input-sm" />
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
			<!-- <div class="well col-md-2">
				<td>
					 <a id="searchByProjectNameBtn"
						class="btn btn-success custom-width">Search
					</a>
			   </td>
			</div> -->
		</div>
	</form:form>
	<script>
	/* Formatting function for row details - modify as you need */
	function format ( d ) {
	    // `d` is the original data object for the row
	    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
	        '<tr>'+
	            '<td>Employee Name:</td>'+
	            '<td>'+d.name+'</td>'+
	        '</tr>'+
	        '<tr>'+
	            '<td>Extension number:</td>'+
	            '<td>'+d.extn+'</td>'+
	        '</tr>'+
	        '<tr>'+
	            '<td>Extra info:</td>'+
	            '<td>And any further details here (images etc)...</td>'+
	        '</tr>'+
	    '</table>';
	}
	
	
		$(document).ready(function() {
			$('#projectReportTable').DataTable({
			});
			// Add event listener for opening and closing details
		    $('#projectReportTable tbody').on('click', 'td.details-control', function () {
		        var tr = $(this).closest('tr');
		        var row = table.row( tr );
		 
		        if ( row.child.isShown() ) {
		            // This row is already open - close it
		            row.child.hide();
		            tr.removeClass('shown');
		        }
		        else {
		            // Open this row
		            row.child( format(row.data()) ).show();
		            tr.addClass('shown');
		        }
		    } );
		});
		$('#projectNamesDropDown').change(
				function(e) {
					var projectNamesDropDownSelectedValue = $(
							'#projectNamesDropDown :selected').val();
					console.log("pr" + projectNamesDropDownSelectedValue);
					$('#searchByProjectNameBtn').attr(
							'href',
							'/EMS/Project/projectReport-'
									+ projectNamesDropDownSelectedValue);
				});
	</script>
	<div id="projectReportTableWrapper" style="padding: 2%;">
		<table id="projectReportTable"
			class="table table-striped table-bordered dt-responsive nowrap"
			cellspacing="0" width="100%">
			<thead>
				<tr>
					<th>WorkPackage Name</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${workPackagesByProjectID}" var="workPackage"
					varStatus="status">
					<tr>
						<td>${workPackage.workPackageName}</td>
						
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>