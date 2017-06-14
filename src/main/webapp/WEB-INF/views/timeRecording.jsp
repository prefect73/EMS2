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
<title><spring:message code="timeRecording.enter.your.time" /></title>

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css" rel="stylesheet"  />
<%-- <script src="<c:url value='/static/js/jquery-1.11.1.min.js' />"></script>
<script src="<c:url value='/static/js/jquery-ui.min.js' />"></script>
<script src="<c:url value='/static/js/bootstrap.min.js' />"></script>
<link href="<c:url value='/static/css/jquery-ui.css' />" rel="stylesheet"  /> --%>
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
	var splittedCsv = "";
	var effectiveDays = "";
	var clickedWorkPackageCalendarAchorId = "";
	var monthsNamesToIntegers = {
		    '0' : 'Jan',
		    '1' : 'Feb',
		    '2' : 'Mar',
		    '3' : 'Apr',
		    '4' : 'May',
		    '5' : 'Jun',
		    '6' : 'Jul',
		    '7' : 'Aug',
		    '8' : 'Sep',
		    '9' : 'Oct',
		    '10' : 'Nov',
		    '11' : 'Dec',
		}

	<c:forEach items="${projects}" var="project">
		<c:forEach items="${project.workPackages}" var="workPackage">
			<c:forEach items="${workPackage.workPackageUserAllocations}" var="workPackageUserAllocation">
	loggedInUserId = '${workPackageUserAllocation.user.id}';

	
	effectiveDaysMap_0.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "0", '${workPackageUserAllocation.eemJan}');
	effectiveDaysMap_1.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "1", '${workPackageUserAllocation.eemFeb}');
	effectiveDaysMap_2.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "2", '${workPackageUserAllocation.eemMar}');
	effectiveDaysMap_3.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "3", '${workPackageUserAllocation.eemApr}');
	effectiveDaysMap_4.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "4", '${workPackageUserAllocation.eemMay}');
	effectiveDaysMap_5.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "5", '${workPackageUserAllocation.eemJun}');
	effectiveDaysMap_6.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "6", '${workPackageUserAllocation.eemJul}');
	effectiveDaysMap_7.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "7", '${workPackageUserAllocation.eemAug}');
	effectiveDaysMap_8.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "8", '${workPackageUserAllocation.eemSep}');
	effectiveDaysMap_9.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "9", '${workPackageUserAllocation.eemOct}');
	effectiveDaysMap_10.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "10", '${workPackageUserAllocation.eemNov}');
	effectiveDaysMap_11.set('${workPackageUserAllocation.user.id}-${workPackageUserAllocation.workPackage.project.id}-${workPackageUserAllocation.workPackage.id}-${workPackageUserAllocation.yearName}-'
			+ "11", '${workPackageUserAllocation.eemDec}');

	</c:forEach>
	</c:forEach>
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
		if (<c:out value="${selectedMonth}"/> == currentMonth) {
			$('#monthNamesDropDown option[value=' + currentMonth + ']').attr(
					'selected', 'selected');
		} else {
			$(
					'#monthNamesDropDown option[value='
							+ <c:out value="${selectedMonth}"/> + ']').attr(
					'selected', 'selected');
		}
	}

	function daysInMonth(month, year) {
		return new Date(year, month, 0).getDate();
	}

	function makeShowAllWorkPackagesBooleanSelected() {
		if ($('#showAllWorkPackagesBoolean').val() == 0) {
			$('#showAllWorkPackages').prop('checked', false);
			$('#showAllWorkPackages').val(0);
		} else if ($('#showAllWorkPackagesBoolean').val() == 1) {
			$('#showAllWorkPackages').prop('checked', true);
			$('#showAllWorkPackages').val(1);
		}
	}

	$(document)
			.ready(
					function() {
						var startYear = '<c:out value="${yearNameStart}"/>';
						var endYear = '<c:out value="${yearNameEnd}"/>';
						yearDropdownFill(startYear, endYear);
						makeCurrentYearSelected();
						makeCurrentMonthSelected();
						makeShowAllWorkPackagesBooleanSelected();
						//makeCurrentWeekSelected();

						$('#yearNamesDropDown')
								.change(
										function() {
											var yearNamesDropDownSelectedValue = $(
													"#yearNamesDropDown").val();
											var monthNamesDropDownSelectedValue = $(
													"#monthNamesDropDown")
													.val();
											var showAllWorkPackagesSelectedValue = $(
													"#showAllWorkPackages")
													.val();

											$("#searchByYearBtn")
													.attr(
															'href',
															'/EMS/TimeRecordingReport/timeRecording-'
																	+ yearNamesDropDownSelectedValue
																	+ '-'
																	+ monthNamesDropDownSelectedValue
																	+ '-'
																	+ showAllWorkPackagesSelectedValue);
										});

						$('#monthNamesDropDown')
								.change(
										function() {
											var yearNamesDropDownSelectedValue = $(
													"#yearNamesDropDown").val();
											var monthNamesDropDownSelectedValue = $(
													"#monthNamesDropDown")
													.val();
											var showAllWorkPackagesSelectedValue = $(
													"#showAllWorkPackages")
													.val();

											$("#searchByYearBtn")
													.attr(
															'href',
															'/EMS/TimeRecordingReport/timeRecording-'
																	+ yearNamesDropDownSelectedValue
																	+ '-'
																	+ monthNamesDropDownSelectedValue
																	+ '-'
																	+ showAllWorkPackagesSelectedValue);
										});

						$('#showAllWorkPackages')
								.change(
										function() {
											var yearNamesDropDownSelectedValue = $(
													"#yearNamesDropDown").val();
											var monthNamesDropDownSelectedValue = $(
													"#monthNamesDropDown")
													.val();

											if ($(this).is(':checked')) {
												$(this).val(1);
												var showAllWorkPackagesSelectedValue = $(
														"#showAllWorkPackages")
														.val();
												$("#searchByYearBtn")
														.attr(
																'href',
																'/EMS/TimeRecordingReport/timeRecording-'
																		+ yearNamesDropDownSelectedValue
																		+ '-'
																		+ monthNamesDropDownSelectedValue
																		+ '-'
																		+ showAllWorkPackagesSelectedValue);
											} else {
												$(this).val(0);
												var showAllWorkPackagesSelectedValue = $(
														"#showAllWorkPackages")
														.val();
												$("#searchByYearBtn")
														.attr(
																'href',
																'/EMS/TimeRecordingReport/timeRecording-'
																		+ yearNamesDropDownSelectedValue
																		+ '-'
																		+ monthNamesDropDownSelectedValue
																		+ '-'
																		+ showAllWorkPackagesSelectedValue);
											}
										});

						$(document)
								.on(
										"click",
										"[id$=workPackageCalendarAnchor]",
										function() {
											clickedWorkPackageCalendarAchorId = $(this);
											if (clickedWorkPackageCalendarAchorId
													.attr('opened') != 'true') {
												clickedWorkPackageCalendarAchorId
														.attr('opened', 'true');
												var d = new Date();
												d.setMonth($(
														"#monthNamesDropDown")
														.val());
												d.setYear($(
														"#yearNamesDropDown")
														.val());
												clickedWorkPackageCalendarAchorId
														.parent()
														.parent()
														.next()
														.find('div')
														.datepicker(
																{
																	beforeShowDay : function(
																			date) {
																		return [
																				false,
																				'' ];
																	},
																	monthNames : [
																			'Januar',
																			'Februar',
																			'März',
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
																			'Mär',
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
																	defaultDate : d,
																	firstDay : 1,
																	close : false,
																	showButtonPanel : true,
																	autoClose : false,
																	onClose : function(
																			dateText,
																			inst) {
																		//	console.log("Closed");
																	}
																});
												var i = 1;
												var selectedProjectName = clickedWorkPackageCalendarAchorId
														.parent().parent()
														.parent().parent()
														.parent().prev().find(
																'h4').find('a')
														.text().replace(
																/^\s+|\s+$/g,
																'');
												var selectedWorkPackageName = clickedWorkPackageCalendarAchorId
														.text();

												var selectedProjectId = clickedWorkPackageCalendarAchorId
														.parent().parent()
														.parent().parent()
														.parent().prev().find(
																'h4').find('a')
														.attr('data-proj-id');
												var selectedWorkPackageId = clickedWorkPackageCalendarAchorId
														.attr('data-wpkg-id');
												console
														.log("selectedWorkPackageId "
																+ selectedWorkPackageId);
												console
												.log("selectedProjectId "
														+ selectedProjectId);
												
												var generatedDefaultZeroValues = 0;
												var daysInSelectedMonth = daysInMonth(
														parseInt($('#monthNamesDropDown')
																.val()) + 1,
														$('#yearNamesDropDown')
																.val());
												
												for(var i = 1; i < daysInSelectedMonth; i++) {
													generatedDefaultZeroValues += ",0";
												}
												
												effectiveDays = eval(
														"effectiveDaysMap_"
																+ $(
																		'#monthNamesDropDown')
																		.val())
														.get(
																loggedInUserId
																		+ "-"
																		+ selectedProjectId
																		+ '-'
																		+ selectedWorkPackageId
																		+ '-'
																		+ $(
																				"#yearNamesDropDown")
																				.val()
																		+ "-"
																		+ $(
																				'#monthNamesDropDown')
																				.val()) != "" ? eval(
														"effectiveDaysMap_"
																+ $(
																		'#monthNamesDropDown')
																		.val())
														.get(
																loggedInUserId
																		+ "-"
																		+ selectedProjectId
																		+ '-'
																		+ selectedWorkPackageId
																		+ '-'
																		+ $(
																				"#yearNamesDropDown")
																				.val()
																		+ "-"
																		+ $(
																				'#monthNamesDropDown')
																				.val())
														: generatedDefaultZeroValues;

												
												splittedCsv = effectiveDays
														.split(',');
												var calendarOnceOpened = clickedWorkPackageCalendarAchorId
														.parent().parent()
														.next().find('a')
														.next().val();
												if (calendarOnceOpened != 'y') {
													clickedWorkPackageCalendarAchorId
															.parent()
															.parent()
															.next()
															.find(
																	".ui-datepicker-calendar .ui-state-default")
															.each(
																	function(i) {
																		$(
																				".ui-datepicker-prev, .ui-datepicker-next")
																				.remove();
																		if (daysInSelectedMonth > i) {
																			$(
																					this)
																					.html(
																							$(
																									this)
																									.html()
																									+ "<input class=\"form-control input-sm workPackageCalendarTextBox\" style=\"width:42px;\" type=\"text\" id=\"eDD["
																									+ i
																									+ "]."
																									+ $(
																											"#monthNamesDropDown")
																											.val()
																									+ "."
																									+ i
																									+ "\" value=\""
																									+ splittedCsv[i]
																									+ "\" />");
																		}
																	});
												}
												clickedWorkPackageCalendarAchorId
														.parent().parent()
														.next().find('a')
														.next().val("y");
											}
										});

						$(document)
								.on(
										"click",
										"[id$=submitButton]",
										function() {
											var j = 1;
											var totalDaysSum = 0;
											var tempCSV = "";
											var effectiveDaysCSV = "";
											var calendarTextBox = "";
											var submitButtonId = $(this);
											$(this)
													.parent()
													.find(
															".ui-datepicker-calendar .ui-state-default")
													.each(
															function(j) {
																calendarTextBox = $(this);
																//totalDaysSum += parseFloat(splittedCsv[j]);
																totalDaysSum += parseFloat($(
																		this)
																		.find(
																				"input")
																		.val());
																tempCSV += ","
																		+ $(
																				this)
																				.find(
																						"input")
																				.val();

															});
											effectiveDaysCSV = tempCSV
													.substring(1,
															tempCSV.length);

											$('.hidden-fields')
													.each(
															function(i) {

																//for loop 
																if ($(this)
																		.attr(
																				'name') === "em"
																		+ monthsNamesToIntegers[$(
																				'#monthNamesDropDown')
																				.val()])
																	$(this)
																			.val(
																					totalDaysSum
																							.toFixed(2));
																if ($(this)
																		.attr(
																				'name') === "eem"
																		+ monthsNamesToIntegers[$(
																				'#monthNamesDropDown')
																				.val()])
																	$(this)
																			.val(
																					effectiveDaysCSV);
															});
											
											$(this).parent().parent().parent().submit();

										});
					});
</script>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<%-- <form:form method="POST" modelAttribute="workP"
			class="form-horizontal"> --%> 
			
			<form:input type="hidden" path="projects" class="form-control input-sm" />
			
			<input type="hidden" id="selectedYear" value='${selectedYear}' />
			<input type="hidden" id="selectedMonth" value='${selectedMonth}' />
			<input type="hidden" id="userId" value='${userId}' />
			<input type="hidden" id="showAllWorkPackagesBoolean" value='${showAll}' />
			
			
			<div class="well lead col-md-5">
				<spring:message code="timeRecording.enter.your.time" />
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-label"><spring:message
							code="timeRecording.label.yearName" /> </label>
					<div class="col-md-3">
						<select class="form-control input-sm" id="yearNamesDropDown"
							name="yearNamesDropDown">
						</select>
					</div>
					<div class="col-md-2">
						<input id="showAllWorkPackages" name ="showAllWorkPackages" type="checkbox" value=""  />
					<label  for="showAllWorkPackages"><spring:message
							code="timeRecording.label.showAllWorkPackages" /> </label>
					</div>
					
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-label" for="monthName"><spring:message
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
				<div class="col-md-2">
					<a id="searchByYearBtn" class="btn btn-success custom-width"><spring:message code="button.search" /> </a>
				</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12" style="width: 93%; left: 5%; font-size:100%;">
					<div class="panel-group" id="accordion" >
						<c:forEach items="${projects}" var="project" varStatus="status">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion"
											href="<c:url value='#${project.id}' />"
											data-proj-id="<c:url value='${project.id}' />">
											${project.projectName}</a>
									</h4>
								</div>
								<div
									id="<c:url value='${project.id}' />"
									class="panel-collapse collapse">
									<div class="panel-body">
										<!-- workpackages accordion -->
										<c:forEach items="${project.workPackages}"  var="workPackage">
										<c:choose>
												<c:when test="${showAll == 0}">
												<c:choose>
												<c:when test="${workPackage.status != 'Abgeschlossen' }">
										<form:form id="<c:url value='${userId}' />-<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-wpuaForm" method="POST" modelAttribute="workPackageUserAllocation" class="form-horizontal"> 
												
										<div class="panel-heading">
											<h4 class="panel-title" style="border: 1px Solid lightgray; padding:1%;">
												<a data-toggle="collapse"  
													data-parent="#<c:url value='${workPackage.project.id}' />"
													data-wpkg-id="<c:url value='${workPackage.id}' />"
													id="<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-workPackageCalendarAnchor"
													href="<c:url value='#${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-workPackageCalendar">${workPackage.workPackageName}</a>
											</h4>
										</div>
										<div
											id="<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-workPackageCalendar"
											class="panel-collapse collapse">
											<div class="panel-body">
												<a class="btn btn-primary btn-sm" style="margin-left:63.5%; margin-bottom:1%;"
													id="<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-submitButton">
													<spring:message code="button.update"/> </a> 
												</div>
										 	 
										 	<input type="hidden"
												id="<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-calendarOnceOpened" />
										 	
										 	<c:forEach items="${workPackage.workPackageUserAllocations}"  var="workPackageUserAllocation">
										 	
											 	<input type="hidden" class="hidden-fields"  name="totalPlannedDays" value="${workPackageUserAllocation.totalPlannedDays}"/>
												<input type="hidden" class="hidden-fields"  name="mJan" value="${workPackageUserAllocation.mJan}"/>
												<input type="hidden" class="hidden-fields"  name="mFeb" value="${workPackageUserAllocation.mFeb}"/>
												<input type="hidden" class="hidden-fields"  name="mMar" value="${workPackageUserAllocation.mMar}"/>
												<input type="hidden" class="hidden-fields"  name="mApr" value="${workPackageUserAllocation.mApr}"/>
												<input type="hidden" class="hidden-fields"  name="mMay" value="${workPackageUserAllocation.mMay}"/>
												<input type="hidden" class="hidden-fields"  name="mJun" value="${workPackageUserAllocation.mJun}"/>
												<input type="hidden" class="hidden-fields"  name="mJul" value="${workPackageUserAllocation.mJul}"/>
												<input type="hidden" class="hidden-fields"  name="mAug" value="${workPackageUserAllocation.mAug}"/>
												<input type="hidden" class="hidden-fields"  name="mSep" value="${workPackageUserAllocation.mSep}"/>
												<input type="hidden" class="hidden-fields"  name="mOct" value="${workPackageUserAllocation.mOct}"/>
												<input type="hidden" class="hidden-fields"  name="mNov" value="${workPackageUserAllocation.mNov}"/>
												<input type="hidden" class="hidden-fields"  name="mDec" value="${workPackageUserAllocation.mDec}"/>
												<input type="hidden" class="hidden-fields"  name="emJan" value="${workPackageUserAllocation.emJan}"/>
												<input type="hidden" class="hidden-fields"  name="emFeb" value="${workPackageUserAllocation.emFeb}"/>
												<input type="hidden" class="hidden-fields"  name="emMar" value="${workPackageUserAllocation.emMar}"/>
												<input type="hidden" class="hidden-fields"  name="emApr" value="${workPackageUserAllocation.emApr}"/>
												<input type="hidden" class="hidden-fields"  name="emMay" value="${workPackageUserAllocation.emMay}"/>
												<input type="hidden" class="hidden-fields"  name="emJun" value="${workPackageUserAllocation.emJun}"/>
												<input type="hidden" class="hidden-fields"  name="emJul" value="${workPackageUserAllocation.emJul}"/>
												<input type="hidden" class="hidden-fields"  name="emAug" value="${workPackageUserAllocation.emAug}"/>
												<input type="hidden" class="hidden-fields"  name="emSep" value="${workPackageUserAllocation.emSep}"/>
												<input type="hidden" class="hidden-fields"  name="emOct" value="${workPackageUserAllocation.emOct}"/>
												<input type="hidden" class="hidden-fields"  name="emNov" value="${workPackageUserAllocation.emNov}"/>
												<input type="hidden" class="hidden-fields"  name="emDec" value="${workPackageUserAllocation.emDec}"/>
												<input type="hidden" class="hidden-fields"  name="eemJan" value="${workPackageUserAllocation.eemJan}"/> 
												<input type="hidden" class="hidden-fields"  name="eemFeb" value="${workPackageUserAllocation.eemFeb}"/> 
												<input type="hidden" class="hidden-fields"  name="eemMar" value="${workPackageUserAllocation.eemMar}"/> 
												<input type="hidden" class="hidden-fields"  name="eemApr" value="${workPackageUserAllocation.eemApr}"/> 
												<input type="hidden" class="hidden-fields"  name="eemMay" value="${workPackageUserAllocation.eemMay}"/> 
												<input type="hidden" class="hidden-fields"  name="eemJun" value="${workPackageUserAllocation.eemJun}"/> 
												<input type="hidden" class="hidden-fields"  name="eemJul" value="${workPackageUserAllocation.eemJul}"/> 
												<input type="hidden" class="hidden-fields"  name="eemAug" value="${workPackageUserAllocation.eemAug}"/> 
												<input type="hidden" class="hidden-fields"  name="eemSep" value="${workPackageUserAllocation.eemSep}"/> 
												<input type="hidden" class="hidden-fields"  name="eemOct" value="${workPackageUserAllocation.eemOct}"/> 
												<input type="hidden" class="hidden-fields"  name="eemNov" value="${workPackageUserAllocation.eemNov}"/> 
												<input type="hidden" class="hidden-fields"  name="eemDec" value="${workPackageUserAllocation.eemDec}"/> 											
												<input type="hidden" class="hidden-fields"  name="yearName" value="${workPackageUserAllocation.yearName}"/>
												<input type="hidden" class="hidden-fields" name="user" value="${workPackageUserAllocation.user.id}" />
												<input type="hidden" class="hidden-fields" name="workPackage" value="${workPackageUserAllocation.workPackage.id}" />
											</c:forEach>		
										 	
										</div>
									  	</form:form> 
									 	</c:when>
										</c:choose>
										</c:when>
										</c:choose>
										<c:choose>
												<c:when test="${showAll == 1}">
										<form:form id="<c:url value='${userId}' />-<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-wpuaForm" method="POST" modelAttribute="workPackageUserAllocation" class="form-horizontal"> 
										<div class="panel-heading">
											<h4 class="panel-title" style="border: 1px Solid lightgray; padding:1%;">
												<a data-toggle="collapse"  
													data-parent="#<c:url value='${workPackage.project.id}' />"
													data-wpkg-id="<c:url value='${workPackage.id}' />"
													id="<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-workPackageCalendarAnchor"
													href="<c:url value='#${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-workPackageCalendar">${workPackage.workPackageName}</a>
											</h4>
										</div>
										<div
											id="<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-workPackageCalendar"
											class="panel-collapse collapse">
											<div class="panel-body">
												<a class="btn btn-primary btn-sm" style="margin-left:63.5%; margin-bottom:1%;"
													id="<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-submitButton">
													<spring:message code="button.update"/></a>
												</div>
											
											<input type="hidden"
												id="<c:url value='${workPackage.project.id}' />-<c:url value='${workPackage.id}' />-calendarOnceOpened" />
										 	
										 	<c:forEach items="${workPackage.workPackageUserAllocations}"  var="workPackageUserAllocation">
										 	
											 	<input type="hidden" class="hidden-fields"  name="totalPlannedDays" value="${workPackageUserAllocation.totalPlannedDays}"/>
												<input type="hidden" class="hidden-fields"  name="mJan" value="${workPackageUserAllocation.mJan}"/>
												<input type="hidden" class="hidden-fields"  name="mFeb" value="${workPackageUserAllocation.mFeb}"/>
												<input type="hidden" class="hidden-fields"  name="mMar" value="${workPackageUserAllocation.mMar}"/>
												<input type="hidden" class="hidden-fields"  name="mApr" value="${workPackageUserAllocation.mApr}"/>
												<input type="hidden" class="hidden-fields"  name="mMay" value="${workPackageUserAllocation.mMay}"/>
												<input type="hidden" class="hidden-fields"  name="mJun" value="${workPackageUserAllocation.mJun}"/>
												<input type="hidden" class="hidden-fields"  name="mJul" value="${workPackageUserAllocation.mJul}"/>
												<input type="hidden" class="hidden-fields"  name="mAug" value="${workPackageUserAllocation.mAug}"/>
												<input type="hidden" class="hidden-fields"  name="mSep" value="${workPackageUserAllocation.mSep}"/>
												<input type="hidden" class="hidden-fields"  name="mOct" value="${workPackageUserAllocation.mOct}"/>
												<input type="hidden" class="hidden-fields"  name="mNov" value="${workPackageUserAllocation.mNov}"/>
												<input type="hidden" class="hidden-fields"  name="mDec" value="${workPackageUserAllocation.mDec}"/>
												<input type="hidden" class="hidden-fields"  name="emJan" value="${workPackageUserAllocation.emJan}"/>
												<input type="hidden" class="hidden-fields"  name="emFeb" value="${workPackageUserAllocation.emFeb}"/>
												<input type="hidden" class="hidden-fields"  name="emMar" value="${workPackageUserAllocation.emMar}"/>
												<input type="hidden" class="hidden-fields"  name="emApr" value="${workPackageUserAllocation.emApr}"/>
												<input type="hidden" class="hidden-fields"  name="emMay" value="${workPackageUserAllocation.emMay}"/>
												<input type="hidden" class="hidden-fields"  name="emJun" value="${workPackageUserAllocation.emJun}"/>
												<input type="hidden" class="hidden-fields"  name="emJul" value="${workPackageUserAllocation.emJul}"/>
												<input type="hidden" class="hidden-fields"  name="emAug" value="${workPackageUserAllocation.emAug}"/>
												<input type="hidden" class="hidden-fields"  name="emSep" value="${workPackageUserAllocation.emSep}"/>
												<input type="hidden" class="hidden-fields"  name="emOct" value="${workPackageUserAllocation.emOct}"/>
												<input type="hidden" class="hidden-fields"  name="emNov" value="${workPackageUserAllocation.emNov}"/>
												<input type="hidden" class="hidden-fields"  name="emDec" value="${workPackageUserAllocation.emDec}"/>
												<input type="hidden" class="hidden-fields"  name="eemJan" value="${workPackageUserAllocation.eemJan}"/> 
												<input type="hidden" class="hidden-fields"  name="eemFeb" value="${workPackageUserAllocation.eemFeb}"/> 
												<input type="hidden" class="hidden-fields"  name="eemMar" value="${workPackageUserAllocation.eemMar}"/> 
												<input type="hidden" class="hidden-fields"  name="eemApr" value="${workPackageUserAllocation.eemApr}"/> 
												<input type="hidden" class="hidden-fields"  name="eemMay" value="${workPackageUserAllocation.eemMay}"/> 
												<input type="hidden" class="hidden-fields"  name="eemJun" value="${workPackageUserAllocation.eemJun}"/> 
												<input type="hidden" class="hidden-fields"  name="eemJul" value="${workPackageUserAllocation.eemJul}"/> 
												<input type="hidden" class="hidden-fields"  name="eemAug" value="${workPackageUserAllocation.eemAug}"/> 
												<input type="hidden" class="hidden-fields"  name="eemSep" value="${workPackageUserAllocation.eemSep}"/> 
												<input type="hidden" class="hidden-fields"  name="eemOct" value="${workPackageUserAllocation.eemOct}"/> 
												<input type="hidden" class="hidden-fields"  name="eemNov" value="${workPackageUserAllocation.eemNov}"/> 
												<input type="hidden" class="hidden-fields"  name="eemDec" value="${workPackageUserAllocation.eemDec}"/> 											
												<input type="hidden" class="hidden-fields"  name="yearName" value="${workPackageUserAllocation.yearName}"/>
												<input type="hidden" class="hidden-fields" name="user" value="${workPackageUserAllocation.user.id}" />
												<input type="hidden" class="hidden-fields" name="workPackage" value="${workPackageUserAllocation.workPackage.id}" />
													
										 	</c:forEach>		
										</div>
										</form:form>
										</c:when>
										</c:choose>
										</c:forEach>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		<%-- </form:form> --%>
		<!-- <button id="submitWorkPackageUpdatedHours" class="btn btn-primary btn-sm">Update</button> -->
	</div>

</body>
</html>

