<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<c:choose>
	<c:when test="${edit}">
		<title>Update Work Package</title>
	</c:when>
	<c:otherwise>
		<title>Add Work Package</title>
	</c:otherwise>
</c:choose>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
<form:form method="POST" modelAttribute="workpackage"
			class="form-horizontal">
		<c:choose>
				<c:when test="${edit}">
					<div class="well lead col-md-5">Update Work package</div>
					<div class="well col-md-2">
						<input type="submit" value="Update" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/Workpackage/workpackageslist' />">Cancel</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="well lead col-md-5">Add Work package</div>
					<div class="well col-md-2">
						<input type="submit" value="Add" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/Workpackage/workpackageslist' />">Cancel</a>
					</div>
				</c:otherwise>
			</c:choose>
		
			<form:input type="hidden" path="id" id="id" />

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="workpackageNumber">Work
						Package Number</label>
					<div class="col-md-3">
						<form:input type="text" path="workpackageNumber"
							id="workpackageNumber" class="form-control input-sm"
							disabled="true" />
						<div class="has-error">
							<form:errors path="workpackageNumber" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="workpackageName">Work
						Package Name</label>
					<div class="col-md-3">
						<form:input type="text" path="workpackageName"
							id="workpackageName" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="workpackageName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>


			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="project">Project
						Name</label>
					<div class="col-md-3">
						<form:select path="project" items="${projectslist}"
							multiple="false" itemValue="id" itemLabel="projectName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="project" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="offeredCost">Offered
						Cost</label>
					<div class="col-md-3">
						<form:input type="text" path="offeredCost" id="offeredCost"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="offeredCost" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="totalCost">Total
						Cost</label>
					<div class="col-md-3">
						<form:input type="text" path="totalCost" id="totalCost"
							class="form-control input-sm" disabled="true" />
						<div class="has-error">
							<form:errors path="totalCost" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-actions floatRight">
					<c:choose>
						<c:when test="${edit}">
							<input type="submit" value="Update"
								class="btn btn-primary btn-sm" /> or <a
								href="<c:url value='/Workpackage/workpackageslist' />">Cancel</a>
						</c:when>
						<c:otherwise>
							<input type="submit" value="Add" class="btn btn-primary btn-sm" /> or <a
								href="<c:url value='/Workpackage/workpackageslist' />">Cancel</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>
