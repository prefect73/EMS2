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
<title><spring:message code="monthlyReport.title" /></title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script>
	$(document).ready(function() {
		$(".availableDays").each(function() {
			var value = parseInt($(this).html());
			var tdIndex = $(this).index();
			//.eq(rowIndex).find('td').eq(columnIndex)
			var currentTr = $(this).closest('tr');
			var prevTr = currentTr.prev();
			var prevTdValue = prevTr.find('td').eq(tdIndex).html();
			var prevPrevTr = currentTr.prev().prev();
			var prevPrevTdValue = prevPrevTr.find('td').eq(tdIndex).html();
			if (parseInt(value) < parseInt('0.00')) {
				//$(this).html(value.setFixed(2));
				$(this).css('color', 'white');
				$(this).css('background-color', 'red');
			} else if(parseInt(value) == parseInt('0.00') && !prevTr.find('td').eq(tdIndex).is(':empty') ){
				//$(this).html(value.setFixed(2));
				$(this).css('color', 'white');
				$(this).css('background-color', 'green');
				
			}
		})
		
		if($("#defaultLanguage").val() == 'german'){
			$('#monthlyReportTable').DataTable({
		        "language": {
		            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
		        }
		    });
			
		} else if ($("#defaultLanguage").val() == 'english'){
			$('#monthlyReportTable').DataTable();
			
		} else {
			$('#monthlyReportTable').DataTable({
		        "language": {
		            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
		        }
		    });
			
		}
	});
</script>
<style type="text/css">
td.highlight {
	font-weight: bold;
	color: red;
}
</style>
</head>

<body>
	<div class="generic-container">
		<input type="hidden" id="defaultLanguage" value='${defaultLanguage}' />
		<%@include file="authheader.jsp"%>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">
				<span class="lead"><spring:message code="monthlyReport.title" /></span>
				<%-- <sec:authorize access="hasRole('ADMIN')">
					<a class="btn btn-primary floatRight"
						href="<c:url value='/WorkPackage/newworkPackage' />">Add New
						Work Package</a>
				</sec:authorize> --%>
			</div>
			<div id="monthlyReportTableWrapper" style="padding: 2%; min-height:75%; max-height:75%; overflow-y:scroll;">
				<table id="monthlyReportTable"
					class="table table-striped table-bordered dt-responsive nowrap" style="font-size:100%;"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th><spring:message
									code="monthlyReport.label.yearName" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.jan" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.feb" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.mar" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.apr" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.may" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.jun" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.jul" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.aug" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.sep" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.oct" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.nov" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<th><spring:message
									code="workPackageUserAllocation.label.dec" /><br /><span style="font-size: 0.6em;"><spring:message code="generic.inDays" /></span></th>
							<%-- <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
								<th width="100"></th>
							</sec:authorize>
							<sec:authorize access="hasRole('ADMIN')">
								<th width="100"></th>
							</sec:authorize> --%>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${monthlyAttendances}" var="monthlyAttendance"
							varStatus="status">
							<tr>
								<td rowspan="3">${monthlyAttendance.user.firstName}</td>
								<td><spring:message code="monthlyReport.possibleDays" /></td>
								<td>${monthlyAttendance.yearName}</td>
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
							<%-- </c:forEach>
						<c:forEach items="${workPackageUserAllocations}" var="monthlyAttendance">
						 --%>
							<tr>
								<td><spring:message code="monthlyReport.plannedDays" /></td>
								<td>${monthlyAttendance.yearName}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mJan}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mFeb}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mMar}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mApr}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mMay}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mJun}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mJul}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mAug}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mSep}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mOct}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mNov}</td>
								<td>${workPackageUserAllocationsBySum[status.index].mDec}</td>
								
							</tr>
							<%-- </c:forEach>
						<c:forEach items="${monthlyAttendances}" var="monthlyAttendance">
						 --%>
							<tr>
								<td><spring:message code="monthlyReport.availableDays" /></td>
								<td class="availableDays">${monthlyAttendance.yearName}</td>
								<td class="availableDays">${monthlyAttendance.mJan - workPackageUserAllocationsBySum[status.index].mJan}</td>
								<td class="availableDays">${monthlyAttendance.mFeb - workPackageUserAllocationsBySum[status.index].mFeb}</td>
								<td class="availableDays">${monthlyAttendance.mMar - workPackageUserAllocationsBySum[status.index].mMar}</td>
								<td class="availableDays">${monthlyAttendance.mApr - workPackageUserAllocationsBySum[status.index].mApr}</td>
								<td class="availableDays">${monthlyAttendance.mMay - workPackageUserAllocationsBySum[status.index].mMay}</td>
								<td class="availableDays">${monthlyAttendance.mJun - workPackageUserAllocationsBySum[status.index].mJun}</td>
								<td class="availableDays">${monthlyAttendance.mJul - workPackageUserAllocationsBySum[status.index].mJul}</td>
								<td class="availableDays">${monthlyAttendance.mAug - workPackageUserAllocationsBySum[status.index].mAug}</td>
								<td class="availableDays">${monthlyAttendance.mSep - workPackageUserAllocationsBySum[status.index].mSep}</td>
								<td class="availableDays">${monthlyAttendance.mOct - workPackageUserAllocationsBySum[status.index].mOct}</td>
								<td class="availableDays">${monthlyAttendance.mNov - workPackageUserAllocationsBySum[status.index].mNov}</td>
								<td class="availableDays">${monthlyAttendance.mDec - workPackageUserAllocationsBySum[status.index].mDec}</td>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
