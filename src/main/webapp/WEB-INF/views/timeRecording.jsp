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
		<title><spring:message code="workPackage.update.title" /></title>
	</c:when>
	<c:otherwise>
		<title><spring:message code="workPackage.add.title" /></title>
	</c:otherwise>
</c:choose>

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<!-- <script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script> 
<script type="text/javascript" src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script> 
 -->
<link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css" />
<link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>

<style type="text/css">
.collapse {
        position: inherit;
    }

.ui-state-disabled, .ui-widget-content .ui-state-disabled,
	.ui-widget-header .ui-state-disabled {
	opacity: 1.35;
}

.ui-datepicker {
	width: 42%;
	position: relative !important;
	top: -92% !important;
	left: 30% !important;
	z-index: 1000;
}

.ui-datepicker-year {
	display: none;
}

button.ui-datepicker-current {
	display: none;
}
</style>
<script>
	var allocatedDaysMap = new Map();
	<c:forEach items="${workPackageUserAllocations}" var="workPackageUserAllocation">
	allocatedDaysMap
			.set(
					'${workPackageUserAllocation.user.id}-${workPackageUserAllocation.yearName}',
					{
						'mJan' : '${workPackageUserAllocation.mJan}',
						'mFeb' : '${workPackageUserAllocation.mFeb}',
						'mMar' : '${workPackageUserAllocation.mMar}',
						'mApr' : '${workPackageUserAllocation.mApr}',
						'mMay' : '${workPackageUserAllocation.mMay}',
						'mJun' : '${workPackageUserAllocation.mJun}',
						'mJul' : '${workPackageUserAllocation.mJul}',
						'mAug' : '${workPackageUserAllocation.mAug}',
						'mSep' : '${workPackageUserAllocation.mSep}',
						'mOct' : '${workPackageUserAllocation.mOct}',
						'mNov' : '${workPackageUserAllocation.mNov}',
						'mDec' : '${workPackageUserAllocation.mDec}'
					});
	</c:forEach>

	console.log(allocatedDaysMap);
	function yearDropdownFill(startYear, endYear) {
		for (i = startYear; i <= endYear; i++) {
			$('#yearNamesDropDown').append($('<option />').val(i).html(i));
		}
	}

	function makeCurrentYearSelected() {
		var d = new Date();
		var currentYear = d.getFullYear();
		console.log("sy " + <c:out value="${selectedYear}"/>);
		if (<c:out value="${selectedYear}"/> == currentYear) {
			$('#yearNamesDropDown option[value=' + currentYear + ']').attr(
					'selected', 'selected');
		} else {
			$(
					'#yearNamesDropDown option[value='
							+ <c:out value="${selectedYear}"/> + ']').attr(
					'selected', 'selected');
		}
	}

	function makeCurrentMonthSelected() {
		var d = new Date();
		var currentMonth = d.getMonth();
		$('#monthNamesDropDown option[value=' + currentMonth + ']').attr(
				'selected', 'selected');

	}

	/* function makeCurrentWeekSelected() {
		var date = new Date;
		var currenWeek = Math.ceil(date.getDate() / 7);
		//$('#yearNamesDropDown')).val(currentYear);	
		$('#weekNamesDropDown option[value=' + currentWeek + ']').attr(
				'selected', 'selected');

	}
	 */
	$(document).ready(
			function() {
				var startYear = '<c:out value="${yearNameStart}"/>';
				var endYear = '<c:out value="${yearNameEnd}"/>';
				yearDropdownFill(startYear, endYear);
				makeCurrentYearSelected();
				makeCurrentMonthSelected();
				//makeCurrentWeekSelected();

				$('#yearNamesDropDown').change(
						function() {
							var yearNamesDropDownSelectedValue = $(
									"#yearNamesDropDown").val();
							$("#searchByYearBtn").attr(
									'href',
									'/EMS/TimeRecordingReport/timeRecording-'
											+ yearNamesDropDownSelectedValue);
						});
				//$(".workPackageCalendar").datepicker();
				//$( document ).on( "click", "[class=workPackageCalendarDiv]", function() {
					 $("#workPackageCalendar").datepicker();
				//});
				
				   /*  $('#workPackageCalendar').datetimepicker({
		                inline: true,
		                sideBySide: true
		            }); */
		        
			});
	
	 
</script>
</head>
<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="workPackageUserAllocations"
			class="form-horizontal">
			<input type="hidden" id="selectedYear" value='${selectedYear}' />


			<div class="well lead col-md-12">
				<spring:message code="project.update.title" />
			</div>
			<div class="row">
				<div class="form-group col-md-5">
					<label class="col-md-2 control-lable" for="yearName"><spring:message
							code="timeRecording.label.yearName" /> </label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="yearNamesDropDown"
							name="yearNamesDropDown">
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-5">
					<label class="col-md-2 control-lable" for="monthName"><spring:message
							code="timeRecording.label.monthName" /> </label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="monthNamesDropDown"
							name="monthNamesDropDown">
							<option value="0"><spring:message
									code="timeRecording.label.month.january" /></option>
							<option value="1"><spring:message
									code="timeRecording.label.month.february" /></option>
							<option value="2"><spring:message
									code="timeRecording.label.month.march" /></option>
							<option value="3"><spring:message
									code="timeRecording.label.month.april" /></option>
							<option value="4"><spring:message
									code="timeRecording.label.month.may" /></option>
							<option value="5"><spring:message
									code="timeRecording.label.month.june" /></option>
							<option value="6"><spring:message
									code="timeRecording.label.month.july" /></option>
							<option value="7"><spring:message
									code="timeRecording.label.month.august" /></option>
							<option value="8"><spring:message
									code="timeRecording.label.month.september" /></option>
							<option value="9"><spring:message
									code="timeRecording.label.month.october" /></option>
							<option value="10"><spring:message
									code="timeRecording.label.month.november" /></option>
							<option value="11"><spring:message
									code="timeRecording.label.month.december" /></option>
						</select>

					</div>
				</div>

				<div class="col-md-2">
					<a id="searchByYearBtn" class="btn btn-success custom-width"><spring:message
							code="button.search" /> </a>
				</div>

			</div>

			<div class="row">
				<div class="form-group col-md-12" style="width: 93%; left: 5%;">
					<div class="panel-group" id="accordion">
						<c:forEach items="${workPackageUserAllocations}"
							var="workPackageUserAllocation">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion"
											href="<c:url value='#${workPackageUserAllocation.workPackage.project.projectName}' />">
											${workPackageUserAllocation.workPackage.project.projectName}</a>
									</h4>
								</div>
								<div
									id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />"
									class="panel-collapse collapse">
									<div class="panel-body">
										<!-- workpackages accordion -->
										<div class="panel-heading">
											<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion" class="workPackageCalendarDiv"
													href="<c:url value='#${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />">
													${workPackageUserAllocation.workPackage.workPackageName}</a>
											</h4>
										</div>
										<div
											id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />"
											class="panel-collapse collapse">
											<div class="panel-body workPackageCalendar">
											<%-- 	<table id="empListForWorkPackageTable"
													class="table table-striped table-bordered dt-responsive nowrap"
													cellspacing="0" width="100%">
													<thead>
														<tr>
															<th><spring:message
																	code="workPackageUserAllocation.label.year" /></th>
															<th><spring:message
																	code="workPackageUserAllocation.label.employeeName" /></th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td></td>
															<td></td>
														</tr>
													</tbody>
												</table> --%>
												
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</form:form>
		<div id="workPackageCalendar">
		</div>
	</div>

</body>
</html>
