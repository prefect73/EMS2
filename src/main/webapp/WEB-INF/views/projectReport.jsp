<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Project Report</title>
	<link href="<c:url value='/static/css/bootstrap.css' />"
		rel="stylesheet"></link>
	<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>

<body>
	<form:form method="POST" modelAttribute="project" class="form-horizontal">
		<div class="generic-container">
			<%@include file="authheader.jsp"%>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="projectName">Project
						Name</label>
					<div class="col-md-3">
						<form:select name="projectNamesDropDown" id="projectNamesDropDown" path="projectName"
							items="${projectsList}" multiple="false" itemValue="id"
							itemLabel="projectName" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="well col-md-2">
				<td>
					 <a id="searchByProjectNameBtn"
						class="btn btn-success custom-width">Search
					</a>
			   </td>
			</div>
		</div>
	</form:form>
	<script>
    $('#projectNamesDropDown').change(function(e) {
        var projectNamesDropDownSelectedValue = $('#projectNamesDropDown :selected').val(); 
        console.log("pr" + projectNamesDropDownSelectedValue);
        $('#searchByProjectNameBtn').attr('href','/EMS/Project/projectReport-' + projectNamesDropDownSelectedValue);
       /* $.ajax({
            url: "getSelectedProjectName",
            type: "POST",
            data: "projectNamesDropDownSelectedValue="+ projectNamesDropDownSelectedValue, 
            success: function(result){
               console.log("result: " + result);
            }
        });  */
    });
	</script>
			<div id="projectReportTableWrapper" style="padding: 2%;">
				<table id="projectReportTable"
					class="table table-striped table-bordered dt-responsive nowrap"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th></th>
							<th>Total</th>
							<c:forEach items="${workPackageUserAllocationsBySum}" var="employeeNames">
								<th>${employeeNames.user.firstName}</th>
							</c:forEach>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${workPackagesByProjectID}" var="workPackage" varStatus="status">
							<tr>
								<td rowspan="2">${workPackage.workPackageName}</td>
								<td>${workPackageTotalHours[status.index].mJan + workPackageTotalHours[status.index].mFeb + workPackageTotalHours[status.index].mMar + workPackageTotalHours[status.index].mApr + 
								 		workPackageTotalHours[status.index].mMay + workPackageTotalHours[status.index].mJun + workPackageTotalHours[status.index].mJul + workPackageTotalHours[status.index].mAug + 
								 		workPackageTotalHours[status.index].mSep + workPackageTotalHours[status.index].mOct + workPackageTotalHours[status.index].mNov + workPackageTotalHours[status.index].mDec}
								</td>
								<c:forEach items="${workPackageHoursForAllUsers}" var="workPackageUserAllocation">
								<%-- 	<td>${workPackageUserAllocation.totalYearHours}</td>
								 --%>
								 	<td>${workPackageUserAllocation.mJan + workPackageUserAllocation.mFeb + workPackageUserAllocation.mMar + workPackageUserAllocation.mApr + 
								 		workPackageUserAllocation.mMay + workPackageUserAllocation.mJun + workPackageUserAllocation.mJul + workPackageUserAllocation.mAug + 
								 		workPackageUserAllocation.mSep + workPackageUserAllocation.mOct + workPackageUserAllocation.mNov + workPackageUserAllocation.mDec}
								 	</td>
								 </c:forEach>
							</tr>
						 	<tr>
						 		<td>Total</td>
								<c:forEach items="${workPackageHoursForAllUsers}" var="workPackageUserAllocation">
									<td>${workPackageUserAllocation.mJan + workPackageUserAllocation.mFeb + workPackageUserAllocation.mMar + workPackageUserAllocation.mApr + 
								 		workPackageUserAllocation.mMay + workPackageUserAllocation.mJun + workPackageUserAllocation.mJul + workPackageUserAllocation.mAug + 
								 	workPackageUserAllocation.mSep + workPackageUserAllocation.mOct + workPackageUserAllocation.mNov + workPackageUserAllocation.mDec}
								 	</td>
								</c:forEach>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
</body>
</html>