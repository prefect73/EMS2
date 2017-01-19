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
<title><spring:message code="projectslist.title" /></title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script>
	$(document).ready(function() {
		
		if($("#defaultLanguage").val() == 'german'){
			$('#projectsTable').DataTable({
		        "language": {
		            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
		        }
		    });
			
		} else if ($("#defaultLanguage").val() == 'english'){
			$('#projectsTable').DataTable();
			
		} else {
			$('#projectsTable').DataTable({
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
				<span class="lead"><spring:message code="projectslist.title" />
				</span>
				<sec:authorize access="hasRole('ADMIN')">
					<a class="btn btn-primary floatRight"
						href="<c:url value='/Project/newproject' />"><spring:message
							code="projectslist.addNewProject" /></a>
				</sec:authorize>
			</div>
			<div id="projectsTableWrapper" style="padding: 2%;">
				<table id="projectsTable"
					class="table table-striped table-bordered dt-responsive nowrap"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th><spring:message code="project.label.projectNumber" />
							</th>
							<th><spring:message code="project.label.projectName" />
							</th>
							<th><spring:message code="project.label.customerName" />
							</th>
							<%-- <th><spring:message code="project.label.yearName" /> 
							</th>--%>
							<sec:authorize access="hasRole('ADMIN')">
							<th><spring:message code="project.label.offeredCost" />
							</th>
							<th><spring:message code="project.label.totalCost" /></th>
							</sec:authorize>
							<%-- <th><spring:message code="project.label.effectiveCost" /></th> --%>
							<sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
								<th width="100"></th>
							</sec:authorize>
							<sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
								<th width="100"></th>
							</sec:authorize>
							<sec:authorize access="hasRole('ADMIN')">
								<th width="100"></th>
							</sec:authorize>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${projects}" var="project">
							<tr>
								<td>${project.projectNumber}</td>
								<td>${project.projectName}</td>
								<td>${project.customerName}</td>
								<%-- <td>${project.yearName}</td> --%>
								<sec:authorize access="hasRole('ADMIN')">
								<td><spring:message code="generic.currencySymbol" />${project.offeredCost}</td>
								<td><spring:message code="generic.currencySymbol" />${project.totalCost}</td>
								</sec:authorize>
								<%-- <td><spring:message code="generic.currencySymbol" />${project.effectiveCost}</td> --%>
								<sec:authorize access="hasRole('ADMIN')">
									<td><a class="btn btn-primary floatRight"
										href="<c:url value='/WorkPackage/newworkPackage?projectId=${project.id}' />"><spring:message code="workPackageslist.addNewWorkPackage" /></a>
										</td>
								</sec:authorize>
								<sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
									<td><a
										href="<c:url value='/Project/edit-project-${project.projectNumber}' />"
										class="btn btn-success "><spring:message code="button.edit" /></a></td>
								</sec:authorize>
								<sec:authorize access="hasRole('ADMIN')">
									<td><a
										href="<c:url value='/Project/delete-project-${project.projectNumber}' />"
										class="btn btn-danger"><spring:message code="button.delete" /></a></td>
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
