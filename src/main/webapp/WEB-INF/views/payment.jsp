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
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

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
							href="<c:url value='/Payment/paymentslist' />"><spring:message
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
							href="<c:url value='/Payment/paymentslist' />"><spring:message
								code="button.cancel" /></a>
					</div>
				</c:otherwise>
			</c:choose>


			<form:input type="hidden" path="id" id="id" />

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="paymentName"><spring:message
							code="payment.label.paymentName" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="paymentName" id="paymentName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="paymentName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="workPackage.id"><spring:message
							code="payment.label.workPackage" /> </label>
					<div class="col-md-3">
						<%-- 	<form:input type="text" path="workPackage.id" id="workPackage"
							class="form-control input-sm" />
					 --%>
						<form:select path="workPackage.id" items="${workPackagesList}"
							id="workPackages" multiple="false" itemValue="id"
							itemLabel="workPackageName" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="workPackage.id" class="help-inline" />
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
					<label class="col-md-2 control-lable" for="balance"><spring:message
							code="payment.label.balance" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="balance" id="balance"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="balance" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<%-- 			<c:choose>
				<c:when test="${edit}">
					<title><spring:message code="payment.update.title" /></title>
					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="yearName"><spring:message
									code="payment.label.yearName" /></label>
							<div class="col-md-3">
								<select class="form-control input-sm" id="yearName"
									name="yearName">
								</select>
								<div class="has-error">
									<form:errors path="yearName" class="help-inline" />
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="yearName"><spring:message
									code="payment.label.yearName" /></label>
							<div class="col-md-3">
								<form:input type="text" path="yearName" id="yearName"
							class="form-control input-sm" />
								<select class="form-control input-sm" id="yearName"
									name="yearName">
								</select>
								<div class="has-error">
									<form:errors path="yearName" class="help-inline" />
								</div>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
 			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="users"><spring:message
							code="payment.label.paymentLeads" /> </label>
					<div class="col-md-3">
						<form:select path="users" items="${paymentleadslist}"
							id="projLeads" multiple="true" itemValue="id"
							itemLabel="firstName" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="users" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="offeredCost"> <spring:message
							code="payment.label.offeredCost" /> <spring:message
							code="generic.inCurrency" />
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
					<label class="col-md-2 control-lable" for="totalCost"> <spring:message
							code="payment.label.totalCost" /> <spring:message
							code="generic.inCurrency" />
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
						<spring:message code="payment.label.effectiveCost" /> <spring:message
							code="generic.inCurrency" />
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
			--%>
		</form:form>
	</div>
</body>
</html>