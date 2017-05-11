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
<script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<!-- <script type="text/javascript"
        src="http://jquery-ui.googlecode.com/svn/tags/latest/ui/minified/i18n/jquery-ui-i18n.min.js">
</script> -->
<%-- <script src="<c:url value='/static/lib/year-select.js' />"></script> --%>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css" />
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>

<style type="text/css">
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
	function yearDropdownFill(startYear, endYear) {
		for (i = startYear; i <= endYear; i++) {
			$('#yearNamesDropDown').append($('<option />').val(i).html(i));
		}
	}
	
	function makeCurrentYearSelected() {
		var d = new Date();
		var currentYear = d.getFullYear();
		//$('#yearNamesDropDown')).val(currentYear);	
		$('#yearNamesDropDown option[value=' + currentYear + ']').attr('selected','selected');
	}
	
	function makeCurrentMonthSelected() {
		var d = new Date();
		var currentMonth = d.getMonth();
		//$('#yearNamesDropDown')).val(currentYear);	
		$('#monthNamesDropDown option[value=' + currentMonth + ']').attr('selected','selected');
	
	}
	
	function makeCurrentWeekSelected() {
		var date = new Date;
	    var currenWeek = Math.ceil(date.getDate() / 7);
		//$('#yearNamesDropDown')).val(currentYear);	
		$('#weekNamesDropDown option[value=' + currentWeek + ']').attr('selected','selected');
	
	}
	
	$(document).ready(
			function() {
				var startYear = '<c:out value="${yearNameStart}"/>';
				var endYear = '<c:out value="${yearNameEnd}"/>';
				yearDropdownFill(startYear, endYear);
				makeCurrentYearSelected();
				makeCurrentMonthSelected();
				makeCurrentWeekSelected();

				$('.searchByWorkPackageNameBtn').on(
						'click',
						function() {
							var selectedWorkPackageName = $(this).text();
							console.log("wpkg: " + selectedWorkPackageName);
							var tr = $(this).closest('tr');
							var row = table.row(tr);
							$(this).attr(
									'href',
									'/EMS/TimeRecordingReport/timeRecording-'
											+ yearNamesDropDownSelectedValue);
						});

				var projectNamesDropDownSelectedValue = $('#selectedProjectNumber').val();
				$('#projectNamesDropDown').change(
						function(e) {
							if ($('#projectNamesDropDown :selected').val()) {
								projectNamesDropDownSelectedValue = $(
										'#projectNamesDropDown :selected')
										.val();
							}
							console.log("pr"
									+ projectNamesDropDownSelectedValue);
							$('#searchByProjectNameBtn').attr(
									'href',
									'/EMS/Project/projectReport-'
											+ projectNamesDropDownSelectedValue
											+ '- ');
						});

			});
</script>
</head>
<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="workPackageUserAllocations"
			class="form-horizontal">
			<%-- <form:input type="hidden" path="id" id="id" /> --%>

			<%-- <div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="workPackageNumber"><spring:message
							code="workPackage.label.workPackageNumber" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="workPackageNumber"
							id="workPackageNumber" class="form-control input-sm"
							readonly="true" />
						<div class="has-error">
							<form:errors path="workPackageNumber" class="help-inline" />
						</div>
					</div>
				</div>
			</div> --%>

			<input type="hidden" id="selectedYear"
				value='${selectedYear}' />

			<div class="row">
				<div class="form-group col-md-12" style="margin-top: 2%;">
					<label class="col-md-2 control-lable" for="yearName"><spring:message
							code="timeRecording.label.yearName" /> </label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="yearNamesDropDown"
							name="yearNamesDropDown">
						</select>
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12" style="margin-top: 2%;">
					<label class="col-md-2 control-lable" for="monthName"><spring:message
							code="timeRecording.label.monthName" /> </label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="monthNamesDropDown"
							name="monthNamesDropDown">
							<option value="1"><spring:message code="timeRecording.label.month.january" /></option>
							<option value="2"><spring:message code="timeRecording.label.month.february" /></option>
							<option value="3"><spring:message code="timeRecording.label.month.march" /></option>
							<option value="4"><spring:message code="timeRecording.label.month.april" /></option>
							<option value="5"><spring:message code="timeRecording.label.month.may" /></option>
							<option value="6"><spring:message code="timeRecording.label.month.june" /></option>
							<option value="7"><spring:message code="timeRecording.label.month.july" /></option>
							<option value="8"><spring:message code="timeRecording.label.month.august" /></option>
							<option value="9"><spring:message code="timeRecording.label.month.september" /></option>
							<option value="10"><spring:message code="timeRecording.label.month.october" /></option>
							<option value="11"><spring:message code="timeRecording.label.month.november" /></option>
							<option value="12"><spring:message code="timeRecording.label.month.december" /></option>
						</select>
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12" style="margin-top: 2%;">
					<label class="col-md-2 control-lable" for="weekName"><spring:message
							code="timeRecording.label.weekName" /> </label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="weekNamesDropDown"
							name="weekDropDown">
							<option value="1">Week 1</option>
							<option value="2">Week 2</option>
							<option value="3">Week 3</option>
							<option value="4">Week 4</option>
						</select>
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-3">
				<a id="searchByYearBtn" class="btn btn-success custom-width"><spring:message
						code="button.search" /> </a>
			</div>

		{{workPackageUserAllocations[0].yearName}}

		</form:form>
	</div>

</body>
</html>
