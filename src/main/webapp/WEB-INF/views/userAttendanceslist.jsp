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
<title><spring:message code="userAttendanceslist.title" /></title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script>
	$(document).ready(function() {
		$('#userAttendancesTable').DataTable();
	});
</script>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">
				<span class="lead"><spring:message
						code="userAttendanceslist.title" /></span>
				<sec:authorize access="hasRole('ADMIN')">
					<a class="btn btn-primary floatRight"
						href="<c:url value='/UserAttendance/newuserAttendance' />"><spring:message
							code="userAttendanceslist.addNewEmployeeAttendance" /></a>
				</sec:authorize>
			</div>
			<div id="userAttendancesTableWrapper" style="padding: 2%;">
				<table id="userAttendancesTable"
					class="table table-striped table-bordered dt-responsive nowrap"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th><spring:message
									code="workPackageUserAllocation.label.employeeName" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.jan" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.feb" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.mar" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.apr" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.may" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.jun" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.jul" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.aug" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.sep" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.oct" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.nov" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.dec" /></th>
							<th><spring:message
									code="workPackageUserAllocation.label.year" /></th>
							<th width="100"></th>
							<sec:authorize access="hasRole('ADMIN')">
								<th width="100"></th>
							</sec:authorize>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userAttendances}" var="userAttendance">
							<tr>
								<td>${userAttendance.user.firstName}</td>
								<td>${userAttendance.mJan}</td>
								<td>${userAttendance.mFeb}</td>
								<td>${userAttendance.mMar}</td>
								<td>${userAttendance.mApr}</td>
								<td>${userAttendance.mMay}</td>
								<td>${userAttendance.mJun}</td>
								<td>${userAttendance.mJul}</td>
								<td>${userAttendance.mAug}</td>
								<td>${userAttendance.mSep}</td>
								<td>${userAttendance.mOct}</td>
								<td>${userAttendance.mNov}</td>
								<td>${userAttendance.mDec}</td>
								<td>${userAttendance.yearName}</td>

								<td><a
									href="<c:url value='/UserAttendance/edit-userAttendance-${userAttendance.id}' />"
									class="btn btn-success "><spring:message code="button.edit" /></a></td>
								<sec:authorize access="hasRole('ADMIN')">
									<td><a
										href="<c:url value='/UserAttendance/delete-userAttendance-${userAttendance.id}' />"
										class="btn btn-danger "><spring:message code="button.delete" /></a></td>
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
