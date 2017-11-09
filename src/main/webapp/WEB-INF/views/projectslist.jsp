<%@ page language="java" contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
<title><spring:message code="projectslist.title" /></title>
<link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.js"></script>
<script src="<c:url value='/static/js/bootstrap.min.js' />"></script>
<script src="<c:url value='/static/js/number-parser.js' />"></script>
<script src="<c:url value='/static/js/tablesort/tablesort.js' />"></script>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
	integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script type="text/javascript" src="<c:url value='/static/js/projectslist/projectslist.js' />"></script>
</head>
<body>
	<div class="generic-container">
		<input type="hidden" id="defaultLanguage" value='${defaultLanguage}' />
		<%@include file="authheader.jsp"%>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">
				<span class="lead"><spring:message code="projectslist.title" /> </span>
				<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
					<a class="btn btn-primary floatRight" href="<c:url value='/Project/newproject' />"><spring:message code="projectslist.addNewProject" /></a>
				</sec:authorize>
			</div>
			<div id="projectsTableWrapper" style="padding: 2%; padding-top:5px;">
			<div class="row" style="padding-top: 10px;">
                <div class="col-md-3">
                    <div class="panel panel-default" style="margin-bottom: 0px; position: absolute; min-width: 395px;">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-5">
                                    <label class="control-label" for="isFinishedProject"><spring:message code="project.label.finished" /></label>
                                </div>
                                <div class="col-md-1" style="padding-left: 0px;">
                                    <input id=isFinishedProject name="isFinishedProject" type="checkbox" value="" />
                                </div>
                                <div class="col-md-5">
                                    <label class="control-label" for="isUserProject"><spring:message code="project.label.isForLoggedUser" /></label>
                                </div>
                                <div class="col-md-1" style="padding-left: 0px;">
                                    <input id="isUserProject" name="isUserProject" type="checkbox" value="" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
				<div class="row">
					<div class="col-md-offset-9 col-md-3" style="text-align: right;">
						<form class="form-inline">
							<div class="form-group">
								<span>Arbeitspaket-Suche:</span>
								<div class="input-group">
									<input type="text" class="form-control" id="searchWorkPackageText" /> <span class="input-group-addon"> <a
										href="#searchWorkpackage"><i class="fa fa-search"></i></a>
									</span>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- /input-group -->
				<table id="projectsTable" data-selected-project="${selectedProject}" class="table table-striped table-bordered dt-responsive nowrap  table-hover" style="font-size: 100%;">
					<thead>
						<tr>
							<th>isFinishedProject</th>
							<th>isAllocatedToLoggedUser</th>
							<th><spring:message code="project.label.projectName" /></th>
							<th><spring:message code="project.label.customerName" /></th>
							<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
								<th><spring:message code="project.label.offeredCost" /></th>
								<th><spring:message code="project.label.totalCost" /></th>
							</sec:authorize>
							<th><spring:message code="project.label.effectiveCost" /></th>
                            <th><spring:message code="project.label.workDoneInPercent" /></th>
                            <th><spring:message code="project.label.status" /></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${projects}" var="project">
							<tr>
								<td>${project.isWorkPackagesFinished}</td>
								<td>${project.isAllocatedToLoggedUser}</td>
								<td><a role="button" data-toggle="collapse" href="#project${project.id}" aria-expanded="true" aria-controls="project${project.id}"
									onclick="showWorkPackageModal('${project.id}')">${project.projectName}</a></td>
								<td>${project.customerName}</td>
								<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
									<td><span class="localeNumber">${project.offeredCost}</span>&nbsp;<spring:message code="generic.currencySymbol" /></td>
									<td><span class="localeNumber">${project.totalCost}</span>&nbsp;<spring:message code="generic.currencySymbol" /></td>
								</sec:authorize>
								<td><span class="localeNumber">${project.effectiveCost}</span>&nbsp;<spring:message code="generic.currencySymbol" /></td>
                                <td>${project.workDoneInPercent}</td>
                                <td>
                                    <c:if test="${project.isWorkPackagesFinished}">
                                        <i class="fa fa-check-square fa-2x" style="color: green;" aria-hidden="true"></i>
                                    </c:if></td>
								<td style="text-align: center;"><sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
										<a class="btn btn-primary" title="<spring:message code="workPackageslist.addNewWorkPackage"/>"
											href="<c:url value='/WorkPackage/newworkPackage?projectId=${project.id}' />"> <i class="fa fa-plus" aria-hidden="true"></i>
										</a>

									</sec:authorize> <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')">
										<a href="<c:url value='/Project/edit-project-${project.projectNumber}' />" title="<spring:message code="button.edit"/>" class="btn btn-success ">
											<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
										</a>
									</sec:authorize> <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
										<a href="<c:url value='/Project/delete-project-${project.projectNumber}' />" title="<spring:message code="button.delete"/>" class="btn btn-danger">
											<i class="fa fa-trash" aria-hidden="true"></i>
										</a>
									</sec:authorize></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div id="workPackagesListModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="gridSystemModalLabel">
						<span id="modalTitle"></span>
					</h4>
				</div>
				<div id="modalBody" class="modal-body"></div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
	<!-- /.modal -->
	<!-- Small modal -->

	<%-- Confirmation modal --%>
	<div id="confirmationDeleteModal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document" style="width: 376px;">
            <div class="modal-content alert alert-success"><strong><p>Soll das Projekt/Arbeitspaket wirklich gelöscht werden?</p></strong>
                <div class="row">
                    <div class="col-md-6" style="text-align: right;">
                        <a id="closeModalAndReloadBtn" data-dismiss="modal"  href="#"  class="btn btn-sm btn-default" style="margin-left:40px;">Abbrechen</a>
                    </div>
					<div class="col-md-6">
                        <a id="okModalAndReloadBtn" href="#"  class="btn btn-sm btn-default" style="margin-left:40px;">OK</a>
                    </div>
                </div>
			</div>
		</div>
	</div>

</body>
</html>
