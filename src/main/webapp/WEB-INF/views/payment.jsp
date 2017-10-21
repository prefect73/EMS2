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
<c:choose>
	<c:when test="${edit}">
		<title><spring:message code="payment.update.title" /></title>
	</c:when>
	<c:otherwise>
		<title><spring:message code="payment.add.title" /></title>
	</c:otherwise>
</c:choose>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$( document ).ready(function() {
	var billedVal = '<c:out value="${payment.billed}"/>';
	console.log("billed " + billedVal);
	if(billedVal == 'Ja'){
		$('#billed option[value=Ja]').attr('selected','selected');
		
	} else if(billedVal == 'Nein'){
		$('#billed option[value=Nein]').attr('selected','selected');
		
	}  else if(billedVal == 'Yes'){
		$('#billed option[value=Yes]').attr('selected','selected');
		
	} else if(billedVal == 'No'){
		$('#billed option[value=No]').attr('selected','selected');
		
	}
	
});
</script>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="payment"
			class="form-horizontal">
			<c:choose>
				<c:when test="${edit}">
					<div class="well lead col-md-5">
						<spring:message code="payment.update.title" />
					</div>
					<div class="well col-md-2">
						<input type="submit"
							value="<spring:message code="button.update"/>"
							class="btn btn-primary btn-sm" /> or <a
							href="<c:url value='/WorkPackage/edit-workPackage-${payment.workPackage.id}' />"><spring:message
								code="button.cancel" /></a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="well lead col-md-5">
						<spring:message code="payment.add.title" />
					</div>
					<div class="well col-md-2">
						<input type="submit" value="<spring:message code="button.add"/>"
							class="btn btn-primary btn-sm" /> or <a
							href="<c:url value='/WorkPackage/edit-workPackage-${payment.workPackage.id}' />"><spring:message
								code="button.cancel" /></a>
					</div>
				</c:otherwise>
			</c:choose>


			<form:input type="hidden" path="id" id="id" />
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="project"><spring:message
							code="payment.label.project" /> </label>
					<div class="col-md-3">
						<input type="text" id="project" readonly="readonly" value="${payment.workPackage.project.projectName} "  class="form-control input-sm" />
						<%-- <div class="has-error">
							<form:errors path="project" class="help-inline" />
						</div> --%>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="workPackage"><spring:message
							code="payment.label.workPackage" /> </label>
					<div class="col-md-3">
						<%-- 	<form:input type="text" path="workPackage.id" id="workPackage"
							class="form-control input-sm" />
					 --%>
						<%-- <form:select path="workPackage.id" items="${workPackagesList}"
							id="workPackages" multiple="false" itemValue="id"
							itemLabel="workPackageName" class="form-control input-sm" /> --%>
							<select class="form-control input-sm" name="workPackage" id="workPackage">

							<c:forEach items="${workPackagesList}" var="work">
								<option class="form-control input-sm" value="${work.id}"
									${work.id == payment.workPackage.id  ? 'selected' : ''}>${work.workPackageName}</option>
							</c:forEach>
						</select>
							
						<div class="has-error">
							<form:errors path="workPackage" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="billed"><spring:message
							code="payment.label.billed" /> </label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="billed" name="billed">
							<option class="form-control input-sm" value="<spring:message
							code="generic.select.option.no" />"><spring:message
							code="generic.select.option.no" /></option>
							<option class="form-control input-sm" value="<spring:message
							code="generic.select.option.yes" />"><spring:message
							code="generic.select.option.yes" /></option>

						</select>
						<div class="has-error">
							<form:errors path="billed" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="time"><spring:message
							code="payment.label.time" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="time" id="time"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="time" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="amount"><spring:message
							code="payment.label.amount" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="amount" id="amount"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="amount" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="remarks"><spring:message
							code="payment.label.remarks" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="remarks" id="remarks"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="remarks" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="finishedIn"><spring:message
							code="payment.label.finishedIn" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="finishedIn" id="finishedIn"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="finishedIn" class="help-inline" />
						</div>
					</div>
				</div>
			</div>


		</form:form>
	</div>
</body>
</html>