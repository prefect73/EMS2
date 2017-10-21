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
		<title><spring:message code="user.update.title"/></title>
	</c:when>
	<c:otherwise>
		<title><spring:message code="user.add.title"/></title>
	</c:otherwise>
</c:choose>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="<c:url value='/static/js/number-parser.js' />"></script>
<script>
    $(document).ready(
        function() {
            // convert all numbers to German
            $('.localeNumber').each(function (index, value) {
                var rawValue = $(this).val();
                var parsedValue = parseToGermanNumber(rawValue);
                $(this).val(parsedValue);
            });
        });
</script>
</head>
<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="user" class="form-horizontal">
			<c:choose>
				<c:when test="${edit}">
					<div class="well lead col-md-5"><spring:message code="user.update.title"/></div>
					<div class="well col-md-2">
						<input type="submit" value="<spring:message code="button.update"/>" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/list' />"><spring:message code="button.cancel"/></a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="well lead col-md-5"><spring:message code="user.add.title"/></div>
					<div class="well col-md-2">
						<input type="submit" value="<spring:message code="button.add"/>" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/list' />"><spring:message code="button.cancel"/></a>
					</div>
				</c:otherwise>
			</c:choose>
			<form:input type="hidden" path="id" id="id" />

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="firstName"><spring:message code="user.label.firstName"/>
						</label>
					<div class="col-md-3">
						<form:input type="text" path="firstName" id="firstName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="firstName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="lastName"><spring:message code="user.label.lastName"/>
						</label>
					<div class="col-md-3">
						<form:input type="text" path="lastName" id="lastName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="lastName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="ssoId"><spring:message code="user.label.ssoId"/></label>
					<div class="col-md-3">
						<c:choose>
							<c:when test="${edit}">
								<form:input type="text" path="ssoId" id="ssoId"
									class="form-control input-sm" readonly="true" />
							</c:when>
							<c:otherwise>
								<form:input type="text" path="ssoId" id="ssoId"
									class="form-control input-sm" />
								<div class="has-error">
									<form:errors path="ssoId" class="help-inline" />
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="password"><spring:message code="user.label.password"/></label>
					<div class="col-md-3">
						<form:input type="password" path="password" id="password"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="password" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="email"><spring:message code="user.label.email"/></label>
					<div class="col-md-3">
						<form:input type="text" path="email" id="email"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="email" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="perDayCost">
					<spring:message code="user.label.perDayCost"/>
					<spring:message code="generic.inCurrency" />
					</label>
					
					<div class="col-md-3">
						<form:input type="text" path="perDayCost" id="perDayCost"
							class="form-control input-sm localeNumber"/>
						<div class="has-error">
							<form:errors path="perDayCost" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="userProfiles"><spring:message code="user.label.roles"/></label>
					<div class="col-md-3">
						<form:select path="userProfiles" items="${roles}" multiple="true"
							itemValue="id" itemLabel="type" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="userProfiles" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>