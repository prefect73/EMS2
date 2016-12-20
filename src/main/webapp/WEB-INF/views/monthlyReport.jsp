<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Work Packages List</title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script>
	$(document).ready(function() {
		$('#monthlyReportTable').DataTable();
	});
</script>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">
				<span class="lead">Monthly Report </span>
				<%-- <sec:authorize access="hasRole('ADMIN')">
					<a class="btn btn-primary floatRight"
						href="<c:url value='/WorkPackage/newworkPackage' />">Add New
						Work Package</a>
				</sec:authorize> --%>
			</div>
			<div id="monthlyReportTableWrapper" style="padding: 2%;">
				<table id="monthlyReportTable"
					class="table table-striped table-bordered dt-responsive nowrap"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th>Jan</th>
							<th>Feb</th>
							<th>Mar</th>
							<th>Apr</th>
							<th>May</th>
							<th>Jun</th>
							<th>Jul</th>
							<th>Aug</th>
							<th>Sep</th>
							<th>Oct</th>
							<th>Nov</th>
							<th>Dec</th>
							<%-- <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
								<th width="100"></th>
							</sec:authorize>
							<sec:authorize access="hasRole('ADMIN')">
								<th width="100"></th>
							</sec:authorize> --%>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${monthlyAttendances}" var="employee">
							<tr>
								<td>${employee.user.firstName}</td>
								<td>
									<tr>Possible Days</tr>
									<tr>Planned Days</tr>
									<tr>Available Days</tr>
								</td>
								<c:forEach items="${monthlyAttendances}" var="monthlyAttendance">
									<tr>
										<td>${monthlyAttendance.mJan}</td>
										<td>${monthlyAttendance.mFeb}</td>
										<td>${monthlyAttendance.mMar}</td>
										<td>${monthlyAttendance.mApr}</td>
										<td>${monthlyAttendance.mMay}</td>
										<td>${monthlyAttendance.mJun}</td>
										<td>${monthlyAttendance.mJul}</td>
										<td>${monthlyAttendance.mAug}</td>
										<td>${monthlyAttendance.mSep}</td>
										<td>${monthlyAttendance.mOct}</td>
										<td>${monthlyAttendance.mNov}</td>
										<td>${monthlyAttendance.mDec}</td>
									</tr>
								</c:forEach>
								<c:forEach items="${monthlyAttendances}" var="monthlyAttendance">
									<tr>
										<td>${monthlyAttendance.mJan}</td>
										<td>${monthlyAttendance.mFeb}</td>
										<td>${monthlyAttendance.mMar}</td>
										<td>${monthlyAttendance.mApr}</td>
										<td>${monthlyAttendance.mMay}</td>
										<td>${monthlyAttendance.mJun}</td>
										<td>${monthlyAttendance.mJul}</td>
										<td>${monthlyAttendance.mAug}</td>
										<td>${monthlyAttendance.mSep}</td>
										<td>${monthlyAttendance.mOct}</td>
										<td>${monthlyAttendance.mNov}</td>
										<td>${monthlyAttendance.mDec}</td>
									</tr>
								</c:forEach>
								<c:forEach items="${monthlyAttendances}" var="monthlyAttendance">
									<tr>
										<td>${monthlyAttendance.mJan}</td>
										<td>${monthlyAttendance.mFeb}</td>
										<td>${monthlyAttendance.mMar}</td>
										<td>${monthlyAttendance.mApr}</td>
										<td>${monthlyAttendance.mMay}</td>
										<td>${monthlyAttendance.mJun}</td>
										<td>${monthlyAttendance.mJul}</td>
										<td>${monthlyAttendance.mAug}</td>
										<td>${monthlyAttendance.mSep}</td>
										<td>${monthlyAttendance.mOct}</td>
										<td>${monthlyAttendance.mNov}</td>
										<td>${monthlyAttendance.mDec}</td>
									</tr>
								</c:forEach>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
