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
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css" />
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
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
	var loggedInUserId = "";
	var effectiveDaysMap_0 = new Map();
	var effectiveDaysMap_1 = new Map();
	var effectiveDaysMap_2 = new Map();
	var effectiveDaysMap_3 = new Map();
	var effectiveDaysMap_4 = new Map();
	var effectiveDaysMap_5 = new Map();
	var effectiveDaysMap_6 = new Map();
	var effectiveDaysMap_7 = new Map();
	var effectiveDaysMap_8 = new Map();
	var effectiveDaysMap_9 = new Map();
	var effectiveDaysMap_10 = new Map();
	var effectiveDaysMap_11 = new Map();
	

	<c:forEach items="${workPackageUserAllocations}" var="workPackageUserAllocation">
	
	loggedInUserId = '${workPackageUserAllocation.user.id}';

	effectiveDaysMap_0.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "0", '${workPackageUserAllocation.eemJan}');
	effectiveDaysMap_1.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "1", '${workPackageUserAllocation.eemFeb}');
	effectiveDaysMap_2.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "2", '${workPackageUserAllocation.eemMar}');
	effectiveDaysMap_3.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "3", '${workPackageUserAllocation.eemApr}');
	effectiveDaysMap_4.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "4", '${workPackageUserAllocation.eemMay}');
	effectiveDaysMap_5.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "5", '${workPackageUserAllocation.eemJun}');
	effectiveDaysMap_6.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "6", '${workPackageUserAllocation.eemJul}');
	effectiveDaysMap_7.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "7", '${workPackageUserAllocation.eemAug}');
	effectiveDaysMap_8.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "8", '${workPackageUserAllocation.eemSep}');
	effectiveDaysMap_9.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "9", '${workPackageUserAllocation.eemOct}');
	effectiveDaysMap_10.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "10", '${workPackageUserAllocation.eemNov}');
	effectiveDaysMap_11.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.projectName}-${workPackageUserAllocation.workPackage.workPackageName}-${workPackageUserAllocation.yearName}-'
					+ "11", '${workPackageUserAllocation.eemDec}');

	</c:forEach>

	function yearDropdownFill(startYear, endYear) {
		for (i = startYear; i <= endYear; i++) {
			$('#yearNamesDropDown').append($('<option />').val(i).html(i));
		}
	}

	function makeCurrentYearSelected() {
		var d = new Date();
		var currentYear = d.getFullYear();
		if (<c:out value="${selectedYear}"/> == currentYear) {
			$('#yearNamesDropDown option[value=' + currentYear + ']').attr('selected', 'selected');
		} else {
			$('#yearNamesDropDown option[value='+ <c:out value="${selectedYear}"/> + ']').attr('selected', 'selected');
		}
	}

	function makeCurrentMonthSelected() {
		var d = new Date();
		var currentMonth = d.getMonth();
		if (<c:out value="${selectedMonth}"/> == currentMonth) {
			$('#monthNamesDropDown option[value=' + currentMonth + ']').attr('selected', 'selected');
		}
		else {
			$('#monthNamesDropDown option[value='+ <c:out value="${selectedMonth}"/> + ']').attr('selected', 'selected');
		}
	}

	/* function makeCurrentWeekSelected() {
		var date = new Date;
		var currenWeek = Math.ceil(date.getDate() / 7);
		//$('#yearNamesDropDown')).val(currentYear);	
		$('#weekNamesDropDown option[value=' + currentWeek + ']').attr(
				'selected', 'selected');

	}
	 */
	$(document)
			.ready(
					function() {
						var startYear = '<c:out value="${yearNameStart}"/>';
						var endYear = '<c:out value="${yearNameEnd}"/>';
						yearDropdownFill(startYear, endYear);
						makeCurrentYearSelected();
						makeCurrentMonthSelected();
						//makeCurrentWeekSelected();

						$('#yearNamesDropDown')
								.change(
										function() {
											var yearNamesDropDownSelectedValue = $("#yearNamesDropDown").val();
											var monthNamesDropDownSelectedValue = $("#monthNamesDropDown").val();
											
											$("#searchByYearBtn")
													.attr(
															'href',
															'/EMS/TimeRecordingReport/timeRecording-'
																	+ yearNamesDropDownSelectedValue + '-' + monthNamesDropDownSelectedValue);
										});
						
						$('#monthNamesDropDown')
						.change(
								function() {
									var yearNamesDropDownSelectedValue = $("#yearNamesDropDown").val();
									var monthNamesDropDownSelectedValue = $("#monthNamesDropDown").val();
									
									$("#searchByYearBtn")
											.attr(
													'href',
													'/EMS/TimeRecordingReport/timeRecording-'
															+ yearNamesDropDownSelectedValue + '-' + monthNamesDropDownSelectedValue);
								});

						$(document)
								.on(
										"click",
										"[id$=workPackageCalendarAnchor]",
										function() {
											var d = new Date();
											d.setMonth($("#monthNamesDropDown")
													.val());
											d.setYear($("#yearNamesDropDown")
													.val());
											$(this)
													.parent()
													.parent()
													.next()
													.find('div')
													.datepicker(
															{
																beforeShowDay : function(date) {return [false,'' ];},
																monthNames : [
																		'Januar',
																		'Februar',
																		'M�rz',
																		'April',
																		'Mai',
																		'Juni',
																		'Juli',
																		'August',
																		'September',
																		'Oktober',
																		'November',
																		'Dezember' ],
																monthNamesShort : [
																		'Jan',
																		'Feb',
																		'M�r',
																		'Apr',
																		'Mai',
																		'Jun',
																		'Jul',
																		'Aug',
																		'Sep',
																		'Okt',
																		'Nov',
																		'Dez' ],
																dayNames : [
																		'Sonntag',
																		'Montag',
																		'Dienstag',
																		'Mittwoch',
																		'Donnerstag',
																		'Freitag',
																		'Samstag' ],
																dayNamesShort : [
																		'So',
																		'Mo',
																		'Di',
																		'Mi',
																		'Do',
																		'Fr',
																		'Sa' ],
																dayNamesMin : [
																		'So',
																		'Mo',
																		'Di',
																		'Mi',
																		'Do',
																		'Fr',
																		'Sa' ],
																showYear : false,
																changeMonth : false,
																changeYear : false,
																defaultDate: d,
																firstDay : 1,
																close : false,
																showButtonPanel : true,
																autoClose : false,
																onClose : function(
																		dateText,
																		inst) {
																	getCalendarValues("#" + $(this).attr('id'),'.mJan');
																}
															}).datepicker("show");
											$(document).off('mousedown', $.datepicker._checkExternalClick);
											var i = 1;
											//var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
											var selectedProjectName = $(this).parent().parent().parent().parent().attr('id');
											var selectedWorkPackageName = $(this).text();
											
											var effectiveDays = eval("effectiveDaysMap_" + $('#monthNamesDropDown').val()).get(
															loggedInUserId
															+ "-"
															+ selectedProjectName
															+ '-'
															+ selectedWorkPackageName
															+ '-'
															+ $("#yearNamesDropDown").val()
															+ "-" 
															+ $('#monthNamesDropDown').val())
															!= "" ?
																	eval("effectiveDaysMap_" + $('#monthNamesDropDown').val()).get(
																			loggedInUserId
																			+ "-"
																			+ selectedProjectName
																			+ '-'
																			+ selectedWorkPackageName
																			+ '-'
																			+ $("#yearNamesDropDown").val()
																			+ "-" 
																			+ $('#monthNamesDropDown').val()) : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
											
											var splittedCsv = effectiveDays.split(',');
											$(".ui-datepicker-calendar .ui-state-default")
													.each(
															function(i) {
																$(".ui-datepicker-prev, .ui-datepicker-next").remove();
																$(this).html($(this).html()
																						+ "<input class=\"form-control input-sm mFeb\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemFeb" + i + "\" value=\""+ splittedCsv[i] +"\" />");
															});
											$(this).parent().parent().next()
													.find('div').attr("disabled", "disabled");

										});

					});
</script>
</head>
<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="workPackageUserAllocations"
			class="form-horizontal">
			
			<input type="hidden" id="selectedYear" value='${selectedYear}' />
			<input type="hidden" id="selectedMonth" value='${selectedMonth}' />
			
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
												<a data-toggle="collapse"
													data-parent="#<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />"
													id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />-workPackageCalendarAnchor"
													href="<c:url value='#${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />-workPackageCalendar">${workPackageUserAllocation.workPackage.workPackageName}</a>
											</h4>
										</div>
										<div
											id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />-workPackageCalendar"
											class="panel-collapse collapse">
											<div class="panel-body"></div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</form:form>
	</div>

</body>
</html>
