<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Project Record Entry</title>
	<link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body>
 	<div class="generic-container">
		<%@include file="authheader.jsp" %>

		<div class="well lead">Project Record Entry</div>
	 	<form:form method="POST" modelAttribute="project" class="form-horizontal">
			<form:input type="hidden" path="id" id="id"/>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="projectNumber">Project Number</label>
					<div class="col-md-7">
						<form:input type="text" path="projectNumber" id="projectNumber" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="projectNumber" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="projectName">Project Name</label>
					<div class="col-md-7">
						<form:input type="text" path="projectName" id="projectName" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="projectName" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
	
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="customerName">Customer Name</label>
					<div class="col-md-7">
						<form:input type="text" path="customerName" id="customerName" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="customerName" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			  
			<%-- <div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="users">Project Lead(s)</label>
					<div class="col-md-7">
						<form:select path="users" items="${users.firstName}" multiple="true" itemValue="users.firstName" itemLabel="users.firstName" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="users" class="help-inline"/>
						</div>
					</div>
				</div>
			</div> --%>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="offeredCost">Offered Cost</label>
					<div class="col-md-7">
						<form:input type="text" path="offeredCost" id="offeredCost" class="form-control input-sm"/>
						<div class="has-error">
							<form:errors path="offeredCost" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="totalCost">Total Cost</label>
					<div class="col-md-7">
						<form:input type="text" path="totalCost" id="totalCost" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="totalCost" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			<!-- 
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="userProfiles">Roles</label>
					<div class="col-md-7">
						<form:select path="userProfiles" items="${roles}" multiple="true" itemValue="id" itemLabel="type" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="userProfiles" class="help-inline"/>
						</div>
					</div>
				</div>
			</div>
			-->
	
			<div class="row">
				<div class="form-actions floatRight">
					<c:choose>
						<c:when test="${edit}">
							<input type="submit" value="Update" class="btn btn-primary btn-sm"/> or <a href="<c:url value='/projectslist' />">Cancel</a>
						</c:when>
						<c:otherwise>
							<input type="submit" value="Register" class="btn btn-primary btn-sm"/> or <a href="<c:url value='/projectslist' />">Cancel</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>
