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
	 
	/* function getCalendarValues(emMonth, selector) {
		 var daysSum = 0;
		 var tempCSV = "";
		 var effectiveDaysCSV = "";
		 $(selector).each(function(){
		     var th = $(this);
		     
		  if(!th.val())
		   th.val('0.00');
		  tempCSV += "," + th.val();
		  effectiveDaysCSV = tempCSV.substring(1, tempCSV.length);
		  //daysSum += parseFloat(th.val() > 4 ? 1 : th.val() > 0 && th.val() <= 4 ? 0.5 : 0  );
		  daysSum += parseFloat(th.val()/8);
		 });
		 $(emMonth).removeAttr( "disabled");
		 $(emMonth).val(daysSum);  
		 $(emMonth).next().val(effectiveDaysCSV); 
		 //$('#workPackageUserAllocations[0].emJan').val('31');		
		 return daysSum;
	} */
	
	 function daysInMonth(month,year) {
		    return new Date(year, month, 0).getDate();
		} 
	 
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
											clickedWorkPackageCalendarAchorId = $(this);
											//$(this).attr("disabled", "disabled");
											

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
																defaultDate: d,
																firstDay : 1,
																close : false,
																showButtonPanel : true,
																autoClose : false,
																closeText : "Ok",
																onClose : function(
																		dateText,
																		inst) {
																	console.log("Closed");
																	//getCalendarValues("#" + $(this).attr('id'),'.workPackageCalendarTextBox');
																}
															});
											/* $(this)
											.parent()
											.parent()
											.next()
											.find('div')
											.datepicker("show"); */
											$(document).off('mousedown', $.datepicker._checkExternalClick);
											
											var i = 1;
											var selectedProjectName = $(this).parent().parent().parent().parent().attr('id');
											var selectedWorkPackageName = $(this).text();
											
											effectiveDays = eval("effectiveDaysMap_" + $('#monthNamesDropDown').val()).get(
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
											
											var daysInSelectedMonth = daysInMonth(parseInt($('#monthNamesDropDown').val() + 1), $('#yearNamesDropDown').val());
											console.log("daysInSelectedMonth " + daysInSelectedMonth);
											splittedCsv = effectiveDays.split(',');
											$(".ui-datepicker-calendar .ui-state-default")
													.each(
															function(i) {
																$(".ui-datepicker-prev, .ui-datepicker-next").remove();
															//	console.log("dm " + daysInMonth(parseInt($('#monthNamesDropDown').val() + 1), $('#yearNamesDropDown').val()));
																if(daysInSelectedMonth > i) {
																	$(this).html($(this).html()
																						+ "<input class=\"form-control input-sm workPackageCalendarTextBox\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "]." + $("#monthNamesDropDown").val() + "." + i + "\" value=\""+ splittedCsv[i] +"\" />");
																}
															});
											$(this).parent().parent().next()
													.find('div').attr("disabled", "disabled");

										});
						$(document)
						.on("click", "[id$=submitButton]",
							function(){
							var j = 1;
							var totalDaysSum = 0;
							var tempCSV = "";
							var effectiveDaysCSV = "";
							var calendarTextBox = "";
							var submitButtonId = $(this);
							console.log("submit clicked");
							$(this).parent().find(".ui-datepicker-calendar .ui-state-default")
							.each(
									function(j) {
										calendarTextBox = $(this);
										//totalDaysSum += parseFloat(splittedCsv[j]);
										totalDaysSum += parseFloat($(this).find("input").val());
										console.log("text box value" + j + ": " + $(this).find("input").val());
										tempCSV += "," + $(this).find("input").val();
										
										//console.log("next id " + $(this).parent().parent().parent().parent().parent().parent().parent().next().next().attr("id"));
							});
							effectiveDaysCSV = tempCSV.substring(1, tempCSV.length);
							console.log("effectiveDaysCSV " + effectiveDaysCSV + " totalDaysSum " + totalDaysSum);
							
							 
							/* //setting id and name attributes for em hidden input fields
							.parent().parent().parent().parent().parent().parent().next().next().attr("id", "em" + monthsNamesToIntegers[$('#monthNamesDropDown').val()]);
							calendarTextBox.parent().parent().parent().parent().parent().parent().next().next().attr("name", "em" + monthsNamesToIntegers[$('#monthNamesDropDown').val()]);
							
							//setting id and name attributes for eem hidden input fields
							calendarTextBox.parent().parent().parent().parent().parent().parent().next().next().next().attr("id", "eem" + monthsNamesToIntegers[$('#monthNamesDropDown').val()]);
							calendarTextBox.parent().parent().parent().parent().parent().parent().next().next().next().attr("name", "eem" + monthsNamesToIntegers[$('#monthNamesDropDown').val()]);
							 
							//setting derived values for em and eem hidden input fields
							//calendarTextBox.parent().parent().parent().parent().parent().parent().next().next().val(totalDaysSum);
							//calendarTextBox.parent().parent().parent().parent().parent().parent().next().next().next().val(effectiveDaysCSV);
							*/
							 
							$('.hidden-fields').each(function() {
								if($(this).attr('id') === "em" + monthsNamesToIntegers[$('#monthNamesDropDown').val()])		
									$(this).val(totalDaysSum.toFixed(2));
								if($(this).attr('id') === "eem" + monthsNamesToIntegers[$('#monthNamesDropDown').val()])		
									$(this).val(effectiveDaysCSV);
							});
							
							//calendarTextBox.parent().parent().parent().parent().parent().parent().next().next().next().after("<input type=\"hidden\" id=\"eemJan\" name=\"eemJan\" value=\"${workPackageUserAllocation.eemJan}\"/>");
							
							//$(this).attr('href','/EMS/TimeReport/timeRecording-' + $('#yearNamesDropDown').val() + '-' + $('#monthNamesDropDown').val() + '-' + totalDaysSum + '-' + effectiveDaysCSV);
							
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
			
			<div class="well lead col-md-5">
				<spring:message code="timeRecording.enter.your.time" />
			</div>
			<div class="well col-md-2">
				<input type="submit" id="updateBtn"
					value="<spring:message code="button.update"/>"
					class="btn btn-primary btn-sm" />
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
					<a id="searchByYearBtn" class="btn btn-success custom-width"><spring:message
							code="button.search" /> </a>
				</div>
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
											<a class="btn btn-primary btn-sm"
												id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />-submitButton">
												Persist Workpackage Allocation </a> 
											<%-- <input type="hidden"
												id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />-workPackageCalendarTotalDaysSum" />
											<input type="hidden"
												id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />-workPackageCalendarUpdatedCSV" />
										 	 --%>
										 	 
										 	<input type="hidden" class="hidden-fields"
												id="totalPlannedDays" name="totalPlannedDays" value="${workPackageUserAllocation.totalPlannedDays}"/>
											
											<input type="hidden" class="hidden-fields"
												id="mJan" name="mJan" value="${workPackageUserAllocation.mJan}"/>
										 	<input type="hidden" class="hidden-fields"
												id="mFeb" name="mFeb" value="${workPackageUserAllocation.mFeb}"/>
											<input type="hidden" class="hidden-fields"
												id="mMar" name="mMar" value="${workPackageUserAllocation.mMar}"/>
										 	<input type="hidden" class="hidden-fields"
												id="mApr" name="mApr" value="${workPackageUserAllocation.mApr}"/>
											<input type="hidden" class="hidden-fields"
												id="mMay" name="mMay" value="${workPackageUserAllocation.mMay}"/>
										 	<input type="hidden" class="hidden-fields"
												id="mJun" name="mJun" value="${workPackageUserAllocation.mJun}"/>
											<input type="hidden" class="hidden-fields"
												id="mJul" name="mJul" value="${workPackageUserAllocation.mJul}"/>
										 	<input type="hidden" class="hidden-fields"
												id="mAug" name="mAug" value="${workPackageUserAllocation.mAug}"/>
											<input type="hidden" class="hidden-fields"
												id="mSep" name="mSep" value="${workPackageUserAllocation.mSep}"/>
										 	<input type="hidden" class="hidden-fields"
												id="mOct" name="mOct" value="${workPackageUserAllocation.mOct}"/>
											<input type="hidden" class="hidden-fields"
												id="mNov" name="mNov" value="${workPackageUserAllocation.mNov}"/>
										 	<input type="hidden" class="hidden-fields"
												id="mDec" name="mDec" value="${workPackageUserAllocation.mDec}"/>
											
											<input type="hidden" class="hidden-fields"
												id="emJan" name="emJan" value="${workPackageUserAllocation.emJan}"/>
										 	<input type="hidden" class="hidden-fields"
												id="emFeb" name="emFeb" value="${workPackageUserAllocation.emFeb}"/>
											<input type="hidden" class="hidden-fields"
												id="emMar" name="emMar" value="${workPackageUserAllocation.emMar}"/>
										 	<input type="hidden" class="hidden-fields"
												id="emApr" name="emApr" value="${workPackageUserAllocation.emApr}"/>
											<input type="hidden" class="hidden-fields"
												id="emMay" name="emMay" value="${workPackageUserAllocation.emMay}"/>
										 	<input type="hidden" class="hidden-fields"
												id="emJun" name="emJun" value="${workPackageUserAllocation.emJun}"/>
											<input type="hidden" class="hidden-fields"
												id="emJul" name="emJul" value="${workPackageUserAllocation.emJul}"/>
										 	<input type="hidden" class="hidden-fields"
												id="emAug" name="emAug" value="${workPackageUserAllocation.emAug}"/>
											<input type="hidden" class="hidden-fields"
												id="emSep" name="emSep" value="${workPackageUserAllocation.emSep}"/>
										 	<input type="hidden" class="hidden-fields"
												id="emOct" name="emOct" value="${workPackageUserAllocation.emOct}"/>
											<input type="hidden" class="hidden-fields"
												id="emNov" name="emNov" value="${workPackageUserAllocation.emNov}"/>
										 	<input type="hidden" class="hidden-fields"
												id="emDec" name="emDec" value="${workPackageUserAllocation.emDec}"/>
											
											<input type="hidden" class="hidden-fields"
												id="eemJan" name="eemJan" value="${workPackageUserAllocation.eemJan}"/>
										 	<input type="hidden" class="hidden-fields"
												id="eemFeb" name="eemFeb" value="${workPackageUserAllocation.eemFeb}"/>
											<input type="hidden" class="hidden-fields"
												id="eemMar" name="eemMar" value="${workPackageUserAllocation.eemMar}"/>
										 	<input type="hidden" class="hidden-fields"
												id="eemApr" name="eemApr" value="${workPackageUserAllocation.eemApr}"/>
											<input type="hidden" class="hidden-fields"
												id="eemMay" name="eemMay" value="${workPackageUserAllocation.eemMay}"/>
										 	<input type="hidden" class="hidden-fields"
												id="eemJun" name="eemJun" value="${workPackageUserAllocation.eemJun}"/>
											<input type="hidden" class="hidden-fields"
												id="eemJul" name="eemJul" value="${workPackageUserAllocation.eemJul}"/>
										 	<input type="hidden" class="hidden-fields"
												id="eemAug" name="eemAug" value="${workPackageUserAllocation.eemAug}"/>
											<input type="hidden" class="hidden-fields"
												id="eemSep" name="eemSep" value="${workPackageUserAllocation.eemSep}"/>
										 	<input type="hidden" class="hidden-fields"
												id="eemOct" name="eemOct" value="${workPackageUserAllocation.eemOct}"/>
											<input type="hidden" class="hidden-fields"
												id="eemNov" name="eemNov" value="${workPackageUserAllocation.eemNov}"/>
										 	<input type="hidden" class="hidden-fields"
												id="eemDec" name="eemDec" value="${workPackageUserAllocation.eemDec}"/>
											
											
											<input type="hidden" class="hidden-fields"
												id="yearName" name="yearName" value="${workPackageUserAllocation.yearName}"/>
										 	
										 	<input type="hidden"
													class="hidden-fields"
													name="user"
													value="${workPackageUserAllocation.user.id}" />
										 	
										 	<input type="hidden"
													class="hidden-fields"
													name="workPackage"
													value="${workPackageUserAllocation.workPackage.id}" />
										 	<%-- 
											<input type="hidden"
												id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />-workPackageCalendarTotalDaysSum" />
											<input type="hidden"
												id="<c:url value='${workPackageUserAllocation.workPackage.project.projectName}' />-<c:url value='${workPackageUserAllocation.workPackage.workPackageName}' />-workPackageCalendarUpdatedCSV" />
										 	--%>
										 	<!-- 	
										 	<input type="hidden" id="emMay" name="emMay" value="3" /> 
										 	<input type="hidden" id="eemMay" name="eemMay"
												value="2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" />
										 	-->
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</form:form>
		<!-- <button id="submitWorkPackageUpdatedHours" class="btn btn-primary btn-sm">Update</button> -->
	</div>

</body>
</html>
