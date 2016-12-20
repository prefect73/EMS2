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
		<title>Update User Attendance</title>
	</c:when>
	<c:otherwise>
		<title>Add User Attendance</title>
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
					<div class="well lead col-md-5">Update User Attendance</div>
					<div class="well col-md-2">
						<input type="submit" value="Update" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/UserAttendance/userAttendanceslist' />">Cancel</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="well lead col-md-5">Add User Attendance</div>
					<div class="well col-md-2">
						<input type="submit" value="Add" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/UserAttendance/userAttendanceslist' />">Cancel</a>
					</div>
				</c:otherwise>
			</c:choose>
		
			<form:input type="hidden" path="id" id="id" />
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="user">Employee
						Name</label>
					<div class="col-md-3">
						<form:select path="user" items="${employeeslist}"
							multiple="false" itemValue="id" itemLabel="firstName"
							class="form-control input-sm"  />
						<div class="has-error">
							<form:errors path="user" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="user.firstName">Employee Name</label>
					<div class="col-md-3">
						<form:input type="text" path="user.firstName" id="user.firstName"
							class="form-control input-sm" disabled="true" />
						<div class="has-error">
							<form:errors path="user.firstName" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mJan">January</label>
					<div class="col-md-3">
						<form:input type="text" path="mJan" id="mJan"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJan" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mFeb">February</label>
					<div class="col-md-3">
						<form:input type="text" path="mFeb" id="mFeb"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mFeb" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mMar">March</label>
					<div class="col-md-3">
						<form:input type="text" path="mMar" id="mMar"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mMar" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mApr">April</label>
					<div class="col-md-3">
						<form:input type="text" path="mApr" id="mApr"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mApr" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mMay">May</label>
					<div class="col-md-3">
						<form:input type="text" path="mMay" id="mMay"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mMay" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mJun">June</label>
					<div class="col-md-3">
						<form:input type="text" path="mJun" id="mJun"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJun" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mJul">July</label>
					<div class="col-md-3">
						<form:input type="text" path="mJul" id="mJul"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJul" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mAug">August</label>
					<div class="col-md-3">
						<form:input type="text" path="mAug" id="mAug"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mAug" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mSep">September</label>
					<div class="col-md-3">
						<form:input type="text" path="mSep" id="mSep"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mSep" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mOct">October</label>
					<div class="col-md-3">
						<form:input type="text" path="mOct" id="mOct"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mOct" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mNov">November</label>
					<div class="col-md-3">
						<form:input type="text" path="mNov" id="mNov"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mNov" class="help-inline" />
						</div>
					</div>
				</div>
			</div><div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="mDec">December</label>
					<div class="col-md-3">
						<form:input type="text" path="mDec" id="mDec"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="mJan" class="help-inline" />
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
								href="<c:url value='/UserAttendance/userAttendanceslist' />">Cancel</a>
						</c:when>
						<c:otherwise>
							<input type="submit" value="Add" class="btn btn-primary btn-sm" /> or <a
								href="<c:url value='/UserAttendance/userAttendanceslist' />">Cancel</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="yearName">Year</label>
					<div class="col-md-3">
						<form:input type="text" path="yearName"
							id="yearName" class="form-control input-sm"
							disabled="false" />
						<div class="has-error">
							<form:errors path="yearName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>
