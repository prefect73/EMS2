<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="ISO-8859-15"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
<c:choose>
	<c:when test="${edit}">
		<title><spring:message code="project.update.title"/></title>
	</c:when>
	<c:otherwise>
		<title><spring:message code="project.add.title"/></title>
	</c:otherwise>
</c:choose>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>

$( document ).ready(function() {
	var selectedLeadsIds = [];
	<c:forEach items="${project.users}" var="usr">
	selectedLeadsIds.push('${usr.id}');
	</c:forEach>
	$("#projLeads > option").each(function() {
	   if($.inArray( this.value, selectedLeadsIds ) > -1 ){
		   $(this).attr( "selected" , "selected" );
	   }
	});	
});

</script>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="project"
			class="form-horizontal">
			<c:choose>
				<c:when test="${edit}">
					<div class="well lead col-md-5"><spring:message code="project.update.title"/></div>
					<div class="well col-md-2">
						<input type="submit" value="<spring:message code="button.update"/>" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/Project/projectslist' />"><spring:message code="button.cancel"/></a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="well lead col-md-5"><spring:message code="project.add.title"/></div>
					<div class="well col-md-2">
						<input type="submit" value="<spring:message code="button.add"/>" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/Project/projectslist' />"><spring:message code="button.cancel"/></a>
					</div>
				</c:otherwise>
			</c:choose>


			<form:input type="hidden" path="id" id="id" />

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="projectNumber"><spring:message code="project.label.projectNumber"/>
						</label>
					<div class="col-md-3">
						<form:input type="text" path="projectNumber" id="projectNumber"
							class="form-control input-sm" readonly="true" />
						<div class="has-error">
							<form:errors path="projectNumber" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="projectName"><spring:message code="project.label.projectName"/>
						</label>
					<div class="col-md-3">
						<form:input type="text" path="projectName" id="projectName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="customerName"><spring:message code="project.label.customerName"/>
						Name</label>
					<div class="col-md-3">
						<form:input type="text" path="customerName" id="customerName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="customerName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="yearName"><spring:message code="project.label.yearName"/></label>
					<div class="col-md-3">
						<%-- <form:input type="text" path="yearName" id="yearName"
							class="form-control input-sm" /> --%>
							<select class="form-control input-sm"  name="yearName">
								<option class="form-control input-sm" value="2017">2017</option>
								<option class="form-control input-sm" value="2018">2018</option>
								<option class="form-control input-sm" value="2019">2019</option>
								<option class="form-control input-sm" value="2020">2020</option>
							</select>
						<div class="has-error">
							<form:errors path="yearName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="users"><spring:message code="project.label.projectLeads"/>
						</label>
					<div class="col-md-3">
						<form:select path="users" items="${projectleadslist}" id="projLeads"
							multiple="true" itemValue="id" itemLabel="firstName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="users" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="offeredCost">
					<spring:message code="project.label.offeredCost"/>
					<spring:message code="generic.inCurrency" />
						</label>
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
					<label class="col-md-2 control-lable" for="totalCost">
					<spring:message code="project.label.totalCost"/>
					<spring:message code="generic.inCurrency" />
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
					<label class="col-md-2 control-lable" for="effectiveCost">
					<spring:message code="project.label.effectiveCost"/>
					<spring:message code="generic.inCurrency" />
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
		</form:form>
	</div>
</body>
</html>