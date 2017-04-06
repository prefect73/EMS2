<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="ISO-8859-15"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
<title><spring:message code="workPackageslist.title" /></title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script>
$(document).ready(function() {
	if(localStorage.getItem("selectOptions" != null)){
		localStorage.removeItem("selectOptions");
	}
	
	if($("#defaultLanguage").val() == 'german'){
		$('#workPackagesTable').DataTable({
	        "language": {
	            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
	        }
	    });
		
	} else if ($("#defaultLanguage").val() == 'english'){
		$('#workPackagesTable').DataTable();
		
	} else {
		$('#workPackagesTable').DataTable({
	        "language": {
	            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
	        }
	    });
		
	}
	
});
</script>
</head>

<body>
	<div class="generic-container">
	<input type="hidden" id="defaultLanguage" value='${defaultLanguage}' />
		<%@include file="authheader.jsp"%>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">
				<span class="lead">List of Work Packages </span>
				<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
					<a class="btn btn-primary floatRight"
						href="<c:url value='/WorkPackage/newworkPackage' />"><spring:message code="workPackageslist.addNewWorkPackage" /></a>
				</sec:authorize>
			</div>
			<div id="workPackagesTableWrapper" style="padding: 2%;">
				<table id="workPackagesTable"
					class="table table-striped table-bordered dt-responsive nowrap"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th><spring:message code="project.label.projectName" /></th>
							<%-- <th><spring:message code="workPackage.label.workPackageNumber" /></th> --%>
							<th><spring:message code="workPackage.label.workPackageName" /></th>
							<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
							<th><spring:message code="workPackage.label.offeredCost" /></th>
							<th><spring:message code="workPackage.label.calculatedCost" /></th>
							<th><spring:message code="workPackage.label.totalCost" /></th>
							<th><spring:message code="workPackage.label.effectiveCost" /></th>
							<th><spring:message code="workPackage.label.workDoneInPercent" /></th>
							<th><spring:message code="workPackage.label.status" /></th>
							</sec:authorize>
							<%-- <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')"> --%>
								<th width="100"></th>
							<%-- </sec:authorize> --%>
							<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
								<th width="100"></th>
							</sec:authorize>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${workPackages}" var="workPackage">
							<tr>
								<td>${workPackage.project.projectName}</td>
								<%-- <td>${workPackage.workPackageNumber}</td> --%>
								<td>${workPackage.workPackageName}</td>
								<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
								<td><spring:message code="generic.currencySymbol" />${workPackage.offeredCost}</td>
								<td><spring:message code="generic.currencySymbol" />${workPackage.calculatedCost}</td>
								<td><spring:message code="generic.currencySymbol" />${workPackage.totalCost}</td>
								<td><spring:message code="generic.currencySymbol" />${workPackage.effectiveCost}</td>
								<td>${workPackage.workDoneInPercent}</td>
								<td>${workPackage.status}</td>
								</sec:authorize>
								<%-- <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')"> --%>
									<td><a
										href="<c:url value='/WorkPackage/edit-workPackage-${workPackage.id}' />"
										class="btn btn-success "><spring:message code="button.edit" /></a></td>
								<%-- </sec:authorize> --%>
								<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
									<td><a
										href="<c:url value='/WorkPackage/delete-workPackage-${workPackage.id}' />"
										class="btn btn-danger "><spring:message code="button.delete" /></a></td>
								</sec:authorize>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
