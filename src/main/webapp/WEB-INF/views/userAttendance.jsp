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
		<title><spring:message code="userAttendance.update.title"/></title>
	</c:when>
	<c:otherwise>
		<title><spring:message code="userAttendance.add.title"/></title>
	</c:otherwise>
</c:choose>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="userAttendance"
			class="form-horizontal">
			<c:choose>
				<c:when test="${edit}">
					<div class="well lead col-md-5"><spring:message code="userAttendance.update.title"/></div>
					<div class="well col-md-3">
						<input type="submit" value="<spring:message code="button.update"/>" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/UserAttendance/userAttendanceslist' />"><spring:message code="button.cancel"/></a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="well lead col-md-5"><spring:message code="userAttendance.add.title"/></div>
					<div class="well col-md-3">
						<input type="submit" value="<spring:message code="button.add"/>" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/UserAttendance/userAttendanceslist' />"><spring:message code="button.cancel"/></a>
					</div>
				</c:otherwise>
			</c:choose>

			<form:input type="hidden" path="id" id="id" />
			<c:choose>
				<c:when test="${edit}">
					<div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-2 control-lable" for="user"><spring:message code="userAttendance.label.employeeName"/>
						</label>
					<div class="col-md-2">
					
					<select readonly="true" class="form-control input-sm"  name="user">

							<c:forEach items="${employeeslist}" var="usr">
								<option class="form-control input-sm" value="${usr.id}"
									${usr.id == userAttendance.user.id  ? 'selected' : ''}>${usr.firstName}</option>
							</c:forEach>
							</select>
						<div class="has-error">
							<form:errors path="user" class="help-inline" />
						</div>
					</div>
					<label class="col-md-2 control-lable" for="yearName"><spring:message code="userAttendance.label.year"/></label>
					<div class="col-md-2">
						<form:input type="text" path="yearName" id="yearName"
							class="form-control input-sm" readonly="true" />
						<div class="has-error">
							<form:errors path="yearName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
				</c:when>
				<c:otherwise>
					<div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-2 control-lable" for="user"><spring:message code="userAttendance.label.employeeName"/>
						</label>
					<div class="col-md-2">
						<form:select path="user" items="${employeeslist}" multiple="false"
							itemValue="id" itemLabel="firstName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="user" class="help-inline" />
						</div>
					</div>
					<label class="col-md-2 control-lable" for="yearName"><spring:message code="userAttendance.label.year"/></label>
					<div class="col-md-2">
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
				</c:otherwise>
			</c:choose>
			<div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-2 control-lable" for="mJan"><spring:message code="userAttendance.label.jan"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mJan" id="mJan"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJan" class="help-inline" />
						</div>
					</div>
					<label class="col-md-2 control-lable" for="mFeb"><spring:message code="userAttendance.label.feb"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mFeb" id="mFeb"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mFeb" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-3 control-lable" for="mFeb"><spring:message code="userAttendance.label.feb"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mFeb" id="mFeb"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mFeb" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>
			<div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-2 control-lable" for="mMar"><spring:message code="userAttendance.label.mar"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mMar" id="mMar"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mMar" class="help-inline" />
						</div>
					</div>
					<label class="col-md-2 control-lable" for="mApr"><spring:message code="userAttendance.label.apr"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mApr" id="mApr"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mApr" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-3 control-lable" for="mApr"><spring:message code="userAttendance.label.apr"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mApr" id="mApr"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mApr" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>
			<div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-2 control-lable" for="mMay"><spring:message code="userAttendance.label.may"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mMay" id="mMay"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mMay" class="help-inline" />
						</div>
					</div>
					<label class="col-md-2 control-lable" for="mJun"><spring:message code="userAttendance.label.jun"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mJun" id="mJun"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJun" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-3 control-lable" for="mJun"><spring:message code="userAttendance.label.jun"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mJun" id="mJun"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJun" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>
			<div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-2 control-lable" for="mJul"><spring:message code="userAttendance.label.jul"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mJul" id="mJul"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJul" class="help-inline" />
						</div>
					</div>
					<label class="col-md-2 control-lable" for="mAug"><spring:message code="userAttendance.label.aug"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mAug" id="mAug"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mAug" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-3 control-lable" for="mAug"><spring:message code="userAttendance.label.aug"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mAug" id="mAug"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mAug" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>
			<div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-2 control-lable" for="mSep"><spring:message code="userAttendance.label.sep"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mSep" id="mSep"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mSep" class="help-inline" />
						</div>
					</div>
					<label class="col-md-2 control-lable" for="mOct"><spring:message code="userAttendance.label.oct"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mOct" id="mOct"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mOct" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-3 control-lable" for="mOct"><spring:message code="userAttendance.label.oct"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mOct" id="mOct"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mOct" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>
			<div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-2 control-lable" for="mNov"><spring:message code="userAttendance.label.nov"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mNov" id="mNov"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mNov" class="help-inline" />
						</div>
					</div>
					<label class="col-md-2 control-lable" for="mDec"><spring:message code="userAttendance.label.dec"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mDec" id="mDec"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJan" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="form-group col-md-10">
					<label class="col-md-3 control-lable" for="mDec"><spring:message code="userAttendance.label.dec"/><span style="font-size: 0.8em;"><spring:message code="generic.inDays" /></span></label>
					<div class="col-md-2">
						<form:input type="text" path="mDec" id="mDec"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJan" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>
		</form:form>
	</div>
</body>
</html>
