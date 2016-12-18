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
		<form:form method="POST" modelAttribute="workPackage"
			class="form-horizontal">
			<c:choose>
				<c:when test="${edit}">
					<div class="well lead col-md-5">Update Work package</div>
					<div class="well col-md-2">
						<input type="submit" value="Update" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/WorkPackage/workPackageslist' />">Cancel</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="well lead col-md-5">Add Work package</div>
					<div class="well col-md-2">
						<input type="submit" value="Add" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/WorkPackage/workPackageslist' />">Cancel</a>
					</div>
				</c:otherwise>
			</c:choose>

			<form:input type="hidden" path="id" id="id" />

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="workPackageNumber">Work
						Package Number</label>
					<div class="col-md-3">
						<form:input type="text" path="workPackageNumber"
							id="workPackageNumber" class="form-control input-sm"
							disabled="true" />
						<div class="has-error">
							<form:errors path="workPackageNumber" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="workPackageName">Work
						Package Name</label>
					<div class="col-md-3">
						<form:input type="text" path="workPackageName"
							id="workPackageName" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="workPackageName" class="help-inline" />
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
			<%-- <div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="users">Employee
						Name</label>
					<div class="col-md-3">
						<form:select path="users" items="${employeeslist}" multiple="true"
							itemValue="id" itemLabel="firstName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="users" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>

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
				<div class="form-group col-md-12">
					<div id="empListForWorkPackageTableWrapper" style="padding: 2%;">
						<table id="empListForWorkPackageTable"
							class="table table-striped table-bordered dt-responsive nowrap"
							cellspacing="0" width="100%">
							<thead>
								<tr>
									<th>Employee Name</th>
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
									<th>Year</th>
									<!-- <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
									<th width="100"></th>
								</sec:authorize>
								<sec:authorize access="hasRole('ADMIN')">
									<th width="100"></th>
								</sec:authorize> -->
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${edit}">
										<c:forEach items="${workPackage.workPackageUserAllocations}"
											var="workPackageUserAllocation" varStatus="status">
											<tr>
												<td>${workPackageUserAllocation.user.firstName}</td>
												<td>${workPackageUserAllocation.user.mJan}</td>
												<td>${workPackageUserAllocation.user.mFeb}</td>
												<td>${workPackageUserAllocation.user.mMar}</td>
												<td>${workPackageUserAllocation.user.mApr}</td>
												<td>${workPackageUserAllocation.user.mMay}</td>
												<td>${workPackageUserAllocation.user.mJun}</td>
												<td>${workPackageUserAllocation.user.mJul}</td>
												<td>${workPackageUserAllocation.user.mAug}</td>
												<td>${workPackageUserAllocation.user.mSep}</td>
												<td>${workPackageUserAllocation.user.mOct}</td>
												<td>${workPackageUserAllocation.user.mNov}</td>
												<td>${workPackageUserAllocation.user.mDec}</td>
												<td>${workPackageUserAllocation.user.yearName}</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<c:forEach items="${workPackage.workPackageUserAllocations}"
												var="workPackageUserAllocation" varStatus="status">
												<tr>
												
													<td align="center">${status.count}</td>
													<td><input type="text"
														name="workPackageUserAllocations[${status.index}].firstname"
														value="${workPackageUserAllocation.user.firstname}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mJan"
														value="${workPackageUserAllocation.mJan}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mFeb"
														value="${workPackageUserAllocation.mFeb}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mMar"
														value="${workPackageUserAllocation.mMar}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mApr"
														value="${workPackageUserAllocation.mApr}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mMay"
														value="${workPackageUserAllocation.mMay}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mJun"
														value="${workPackageUserAllocation.mJun}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mJul"
														value="${workPackageUserAllocation.mJul}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mAug"
														value="${workPackageUserAllocation.mAug}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mSep"
														value="${workPackageUserAllocation.mSep}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mOct"
														value="${workPackageUserAllocation.mOct}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mNov"
														value="${workPackageUserAllocation.mNov}" /></td>
													<td><input
														name="workPackageUserAllocations[${status.index}].mDec"
														value="${workPackageUserAllocation.mDec}" /></td>

												</tr>
											</c:forEach>
											
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="form-actions floatRight">
					<c:choose>
						<c:when test="${edit}">
							<input type="submit" value="Update"
								class="btn btn-primary btn-sm" /> or <a
								href="<c:url value='/WorkPackage/workPackageslist' />">Cancel</a>
						</c:when>
						<c:otherwise>
							<input type="submit" value="Add" class="btn btn-primary btn-sm" /> or <a
								href="<c:url value='/WorkPackage/workPackageslist' />">Cancel</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div> --%>
		</form:form>
	</div>
</body>
</html>
