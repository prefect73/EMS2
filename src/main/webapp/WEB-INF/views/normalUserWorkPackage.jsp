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
.ui-state-disabled, .ui-widget-content .ui-state-disabled, .ui-widget-header .ui-state-disabled {
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
<script type="text/javascript">

var userAttendance = new Map();

<c:forEach items="${userAttendancesUpdated}" var="usrAttend">
	userAttendance.set('${usrAttend.user.id}-${usrAttend.yearName}', {'mJan' : '${usrAttend.mJan}' , 'mFeb' : '${usrAttend.mFeb}', 'mMar' : '${usrAttend.mMar}', 'mApr' : '${usrAttend.mApr}', 'mMay' : '${usrAttend.mMay}', 'mJun' : '${usrAttend.mJun}', 'mJul' : '${usrAttend.mJul}', 'mAug' : '${usrAttend.mAug}', 'mSep' : '${usrAttend.mSep}', 'mOct' : '${usrAttend.mOct}', 'mNov' : '${usrAttend.mNov}', 'mDec' : '${usrAttend.mDec}' });
</c:forEach>
var startYear = '<c:out value="${yearNameStart}"/>';
var endYear = '<c:out value="${yearNameEnd}"/>';

	var wPakAllocSize = '<c:out value="${fn:length(workPackage.workPackageUserAllocations)}"/>';
	var editView = '<c:out value="${edit}"/>';
	var globalYearName = "";
	
	$( document ).ready(function() {
		var projectNamesDropDownSelectedValue = $('#selectedProjectNumber').val();
		$('#projectNamesDropDown').change(function(e) {
			disableWorkPackageDropDownAndButton();
			disableUpdateButton();
			if($('#projectNamesDropDown :selected').val()) {
		    	projectNamesDropDownSelectedValue = $('#projectNamesDropDown :selected').val();
		    }
			if($('#projectNamesDropDown :selected').val() == "NONE") {
				disableProjectButton();
			} else if($('#projectNamesDropDown :selected').val() != "NONE") {
				enableProjectButton();
			}
		    console.log("pr" + projectNamesDropDownSelectedValue);
		    $('#searchWorkPackagesByProjectNameBtn').attr('href','/EMS/WorkPackage/edit-normal-user-workPackage-' + projectNamesDropDownSelectedValue + '-0');        
		});
		
		var workPackageNamesDropDownSelectedValue = $('#selectedWorkPackageNumber').val();
		$('#workPackageNamesDropDown').change(function(e) {
			disableUpdateButton();
		    if($('#workPackageNamesDropDown :selected').val()) {
		    	workPackageNamesDropDownSelectedValue = $('#workPackageNamesDropDown :selected').val();
		    }
		    if($('#workPackageNamesDropDown :selected').val() == "NONE") {
				disableWorkPackageButton();
			} else if($('#workPackageNamesDropDown :selected').val() != "NONE") {
				enableWorkPackageButton();
			}
		    console.log("wpkg " + workPackageNamesDropDownSelectedValue);
		    $('#searchByProjectNameAndWorkPackageBtn').attr('href','/EMS/WorkPackage/edit-normal-user-workPackage-' + projectNamesDropDownSelectedValue + '-' + workPackageNamesDropDownSelectedValue);        
		});

		$('input').on('keypress', function (event) {
		    var regex = new RegExp("^[^,]+$");
		    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
		    if (!regex.test(key)) {
		       event.preventDefault();
		       return false;
		    }
		});
		  if ($('#empListForWorkPackageTable > tbody > tr').length == 0 || wPakAllocSize == 0 ){
		   addFirstRow();
		  }
		  disabledFieldsForNormalUser();
		  poulateAvailableHours();
		  validateAllocatedAndEffectiveHours();
		  validateAttendanceAndAllocatedHours();
		  validateTotalPlannedDaysWithTotalAllocatedDays();
		  effectiveDistributionPopups();
		     $( ".userCombo,.yearCombo,.allocatedDays,.effectiveDays" ).change(function() {
		      poulateAvailableHours();
		      validateAllocatedAndEffectiveHours();
			  validateAttendanceAndAllocatedHours();
			  validateTotalPlannedDaysWithTotalAllocatedDays();
			  /* effectiveDistributionPopups(); */
		     });
		     $( ".userCombo,.yearCombo,.allocatedDays,.effectiveDays" ).blur(function() {
			      //poulateAvailableHours();
			      validateAllocatedAndEffectiveHours();
				  validateAttendanceAndAllocatedHours();
				  validateTotalPlannedDaysWithTotalAllocatedDays();
				  /* effectiveDistributionPopups(); */
			     });
		     
		 });
	
	function disableUpdateButton() {
		  $('#updateBtn').attr('disabled', 'disabled');
	}
	
	function disableWorkPackageDropDownAndButton() {
		$('#searchByProjectNameAndWorkPackageBtn').attr('disabled', 'disabled');
		$('#workPackageNamesDropDown').find('option').remove();
		$('#workPackageNamesDropDown').append('<option class="form-control input-sm" value="NONE">--------------------------W�hlen--------------------------</option>');
		$('#workPackageNamesDropDown').find('option:selected').removeAttr('selected');
		$('#workPackageNamesDropDown').attr('disabled', 'disabled');
	}
	
	function disableProjectButton() {
		$('#searchWorkPackagesByProjectNameBtn').attr('disabled', 'disabled');
	}
	
	function enableProjectButton() {
		$('#searchWorkPackagesByProjectNameBtn').removeAttr('disabled');
	}
	
	function disableWorkPackageButton() {
		$('#searchByProjectNameAndWorkPackageBtn').attr('disabled', 'disabled');
	}
	
	function enableWorkPackageButton() {
		$('#searchByProjectNameAndWorkPackageBtn').removeAttr('disabled');
	}
 	
	function disabledFieldsForNormalUser(){
		var normalUserView = '<c:out value="${normalUserView}"/>';
		if(normalUserView){
			$( ".allocatedDays" ).attr('readonly','true');
			$( "[id$=totalPlannedDays]" ).attr('readonly','true');
			
		}else{
			$( "[id$=totalPlannedDays]" ).removeAttr('readonly');
			$( ".allocatedDays" ).removeAttr('readonly');
		}
	}
	
	function validateTotalPlannedDaysWithTotalAllocatedDays(){
		  $( ".allocatedDays" ).each(function(index,element) {
		   var totalPlannedDaysField = $(element).closest('tr').find('td:eq(2)').find('input');
		   var totalPlannedDaysVal = $(element).closest('tr').find('td:eq(2)').find('input').val();
		   var allocatedDaysSumTds = $(element).closest('tr').find('td').not(':eq(0),:eq(1),:eq(2),:eq(15)');
		   var allocatedDaysSum = 0;
		   allocatedDaysSumTds.each(function() {     
		    allocatedDaysSum += isNaN(parseFloat($(this).find('input:eq(1)').val())) ? parseFloat('0.00') : parseFloat( $(this).find('input:eq(1)').val()) ;                     
		      });
		   
		   
		   if(!(parseFloat(totalPlannedDaysVal) == 0) && parseFloat(totalPlannedDaysVal) == parseFloat(allocatedDaysSum) ){
		    $(element).closest('tr').find('td:eq(2)').find('input').css('backgroundColor','green');
		    $(element).closest('tr').find('td:eq(2)').find('input').css('color','white');
		   }else if(!(parseFloat(totalPlannedDaysVal) == 0) && parseFloat(totalPlannedDaysVal) > parseFloat(allocatedDaysSum)){
		    $(element).closest('tr').find('td:eq(2)').find('input').css('backgroundColor','yellow');
		    $(element).closest('tr').find('td:eq(2)').find('input').css('color','black');
		   }else if (!(parseFloat(totalPlannedDaysVal) == 0) && parseFloat(totalPlannedDaysVal) < parseFloat(allocatedDaysSum)){
		    $(element).closest('tr').find('td:eq(2)').find('input').css('backgroundColor','red');
		    $(element).closest('tr').find('td:eq(2)').find('input').css('color','white'); 
		   }
		   
		  });
		 }
	
	function validateAttendanceAndAllocatedHours(){
		$( ".allocatedDays" ).each(function(index,element) {
			if(!(parseFloat($(element).val()) == 0) && (parseFloat($(element).val())) > (parseFloat($(element).closest('td').find('input:eq(0)').val()))){
				$(element).css('backgroundColor','red');
				$(element).css('color','white');
			}else{
				$(element).css('backgroundColor','white');
				$(element).css('color','black');
			}
		});
	}
	
	function validateAllocatedAndEffectiveHours (){
		$( ".effectiveDays" ).each(function(index,element) {
			if((!(parseFloat($(element).val()) == 0) && parseFloat($(element).val())) > (parseFloat($(element).closest('td').find('input:eq(1)').val()))){
				$(element).css('backgroundColor','red');
				$(element).css('color','white');
			}else{
				$(element).css('backgroundColor','white');
				$(element).css('color','black');
			}
		});
	}
	function getCalendarValues(emMonth, selector) {
		 
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
	}
	function effectiveDistributionPopups (){
		
		$( document ).on( "click", "[id$=emJan]", function() {
			var d = new Date();
			d.setMonth(0);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());	
			
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mJan');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
			
			var i = 1;
			
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
            var splittedCsv = csvv.split(',');		
            $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
				$(this).html($(this).html() + "<input class=\"form-control input-sm mJan\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemJan" + i + "\" value=\""+ splittedCsv[i] +"\" />");
		    });
            $(this).attr( "disabled", "disabled");
    	});
	    	
		$( document ).on( "click", "[id$=emFeb]", function() {
			
			var d = new Date();
			d.setMonth(1);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mFeb');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mFeb\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemFeb" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
	    });
		
		$( document ).on( "click", "[id$=emMar]", function() {
			//console.log("emMar clicked");
			var d = new Date();
			d.setMonth(2);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mMar');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mMar\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemMar" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
		});
		
		$( document ).on( "click", "[id$=emApr]", function() {
			//console.log("emApr clicked");
			var d = new Date();
			d.setMonth(3);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mApr');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mApr\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemApr" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
		});
		
		$( document ).on( "click", "[id$=emMay]", function() {
			//console.log("emMay clicked");
			var d = new Date();
			d.setMonth(4);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mMay');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mMay\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemMay" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
	    });
		
		$( document ).on( "click", "[id$=emJun]", function() {
			//console.log("emJun clicked");
			var d = new Date();
			d.setMonth(5);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mJun');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mJun\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemJun" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
		});
		
		$( document ).on( "click", "[id$=emJul]", function() {
			//console.log("emJul clicked");
			var d = new Date();
			d.setMonth(6);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mJul');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mJul\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemJul" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
		});
		
		$( document ).on( "click", "[id$=emAug]", function() {
			//console.log("emAug clicked");
			var d = new Date();
			d.setMonth(7);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mAug');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mAug\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemAug" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
		});
		
		$( document ).on( "click", "[id$=emSep]", function() {
			//console.log("emSep clicked");
			var d = new Date();
			d.setMonth(8);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mSep');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mSep\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemSep" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
		});
		
		$( document ).on( "click", "[id$=emOct]", function() {
			//console.log("emOct clicked");
			var d = new Date();
			d.setMonth(9);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mOct');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mOct\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemOct" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
		});
		
		$( document ).on( "click", "[id$=emNov]", function() {
			//console.log("emNov clicked");
			var d = new Date();
			d.setMonth(10);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mNov');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mNov\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemNov" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
		});
		
		$( document ).on( "click", "[id$=emDec]", function() {
			//console.log("emDec clicked");
			var d = new Date();
			d.setMonth(11);
			d.setYear($(this).closest('tr').find('td:eq(0)').find('[name$=yearName]').val());
			$(this).datepicker({ beforeShowDay : function(date){ return [false, ''];},
				monthNames: ['Januar','Februar','M�rz','April','Mai','Juni',
				             'Juli','August','September','Oktober','November','Dezember'],
				             monthNamesShort: ['Jan','Feb','M�r','Apr','Mai','Jun',
				             'Jul','Aug','Sep','Okt','Nov','Dez'],
				             dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				             dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				             dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
				showYear: false,
			 	changeMonth: false, 
			 	changeYear: false,firstDay: 1,
				close: false,
			 	showButtonPanel: true,
			 	defaultDate: d,
				autoClose: false,
			 	onClose: function(dateText, inst) {
     				//console.log('closing');
			//		getCalendarValues('#emJanTextBox','.mJan');
     				getCalendarValues("#" + $(this).attr('id'),'.mDec');
    			}
			}).datepicker("show");$(document).off('mousedown', $.datepicker._checkExternalClick);
            var i = 1;
            var csvv = $(this).next().attr('value') != "" ? $(this).next().attr('value') : '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';
                var splittedCsv = csvv.split(',');		
                $(".ui-datepicker-calendar .ui-state-default").each(function (i) {
    				$(".ui-datepicker-prev, .ui-datepicker-next").remove();
    				$(this).html($(this).html() + "<input class=\"form-control input-sm mDec\" style=\"width:42px;\" type=\"text\" id=\"eDD[" + i + "].eemDec" + i + "\" value=\""+ splittedCsv[i] +"\" />");
    		    });
            $(this).attr( "disabled", "disabled");
	    });
	}

	function poulateAvailableHours(){
		$( ".userCombo" ).each(function( index , element) {			
			yearNameVal = $(element).parent().prev().find('input').val() == undefined || null ? $(element).parent().prev().find('select').val() : $(element).parent().prev().find('input').val();
			////console.log($(element).parent().prev().find('input').val());
			////console.log($(element).parent().prev().find('select').val());
			var trObj = $(element).parent().parent();
			///zzz selected value
			var usAtt = userAttendance.get($( element ).val()+"-"+yearNameVal);
			if(usAtt == null){
				$(trObj).find("[id$=mJanAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mFebAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mMarAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mAprAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mMayAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mJunAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mJulAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mAugAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mSepAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mOctAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mNovAvailableHrs]").val('0.00');
				$(trObj).find("[id$=mDecAvailableHrs]").val('0.00');
				alert('<spring:message code="workPackage.alert.attendanceNotFound"/>' + ' ' + yearNameVal);
				
			}else{
			$(trObj).find("[id$=mJanAvailableHrs]").val(usAtt.mJan);
			$(trObj).find("[id$=mFebAvailableHrs]").val(usAtt.mFeb);
			$(trObj).find("[id$=mMarAvailableHrs]").val(usAtt.mMar);
			$(trObj).find("[id$=mAprAvailableHrs]").val(usAtt.mApr);
			$(trObj).find("[id$=mMayAvailableHrs]").val(usAtt.mMay);
			$(trObj).find("[id$=mJunAvailableHrs]").val(usAtt.mJun);
			$(trObj).find("[id$=mJulAvailableHrs]").val(usAtt.mJul);
			$(trObj).find("[id$=mAugAvailableHrs]").val(usAtt.mAug);
			$(trObj).find("[id$=mSepAvailableHrs]").val(usAtt.mSep);
			$(trObj).find("[id$=mOctAvailableHrs]").val(usAtt.mOct);
			$(trObj).find("[id$=mNovAvailableHrs]").val(usAtt.mNov);
			$(trObj).find("[id$=mDecAvailableHrs]").val(usAtt.mDec);
			}
			
			});
	}
	
	
	function addFirstRow(){
		var index = wPakAllocSize;
		//var yearNameTD ='<td><select class="form-control input-sm yearCombo" style="width:55px;" name="workPackageUserAllocations['+index+'].yearName" ><option class="form-control input-sm" value="2017">2017</option><option class="form-control input-sm" value="2018">2018</option><option class="form-control input-sm" value="2019">2019</option><option class="form-control input-sm" value="2020">2020</option></select></td>';
		var yearNameTDStart ='<td><select class="form-control input-sm yearCombo" style="width:72px;" name="workPackageUserAllocations['+index+'].yearName" >';
		var yearNameTdEnd = '</select></td>';
		var optionsAsString = "";
			for (i = startYear; i <= endYear; i++){
			    optionsAsString += '<option value="'+i+'">'+i+'</option>';
			}
		var yearNameTD = yearNameTDStart + optionsAsString + yearNameTdEnd ;
		var userTD ='<td><select class="form-control input-sm userCombo" name="workPackageUserAllocations['+index+'].user"><c:forEach items="${employeeslist}" var="emp"><option class="form-control input-sm" value="${emp.id}">${emp.firstName}</option> </c:forEach> </select></td>';
		var totalPlannedDaysTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].totalPlannedDays" /></td>';
		var mJanTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJanAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mJan" />&nbsp;<input id="workPackageUserAllocations'+index+'emJan" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emJan" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemJan" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemJan" value="" /></td>';
		var mFebTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mFebAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mFeb" />&nbsp;<input id="workPackageUserAllocations'+index+'emFeb" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emFeb" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemFeb" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemFeb"  value="" /></td>';
		var mMarTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mMarAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mMar" />&nbsp;<input id="workPackageUserAllocations'+index+'emMar" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emMar" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemMar" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemMar" value="" /></td>';
		var mAprTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mAprAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mApr" />&nbsp;<input id="workPackageUserAllocations'+index+'emApr" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emApr" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemApr" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemApr" value="" /></td>';
		var mMayTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mMayAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mMay" />&nbsp;<input id="workPackageUserAllocations'+index+'emMay" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emMay" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemMay" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemMay" value="" /></td>';
		var mJunTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJunAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mJun" />&nbsp;<input id="workPackageUserAllocations'+index+'emJun" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emJun" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemJun" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemJun" value="" /></td>';
		var mJulTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJulAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mJul" />&nbsp;<input id="workPackageUserAllocations'+index+'emJul" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emJul" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemJul" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemJul" value="" /></td>';
		var mAugTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mAugAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mAug" />&nbsp;<input id="workPackageUserAllocations'+index+'emAug" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emAug" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemAug" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemAug" value="" /></td>';
		var mSepTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mSepAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mSep" />&nbsp;<input id="workPackageUserAllocations'+index+'emSep" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emSep" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemSep" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemSep" value="" /></td>';
		var mOctTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mOctAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mOct" />&nbsp;<input id="workPackageUserAllocations'+index+'emOct" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emOct" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemOct" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemOct" value="" /></td>';
		var mNovTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mNovAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mNov" />&nbsp;<input id="workPackageUserAllocations'+index+'emNov" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emNov" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemNov" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemNov" value="" /></td>';
		var mDecTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mDecAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mDec" />&nbsp;<input id="workPackageUserAllocations'+index+'emDec" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emDec" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemDec" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemDec" value="" /></td>';
		
		var formHtml = yearNameTD +userTD +totalPlannedDaysTD +mJanTD +mFebTD +mMarTD +mAprTD +mMayTD +mJunTD +mJulTD +mAugTD +mSepTD +mOctTD +mNovTD +mDecTD;
		var formTR = $('<tr></tr>');
		formTR.append(formHtml);
		//add Button

		var addBTN = $('<input class="btn btn-primary btn-sm" type="button" name="add" id="add" value="<spring:message code="button.add"/>" onclick="addNewWPUallocRow(this);"/>');
		
		
		var btnTD = $('<td></td>').append($('<button/>', { 'type': 'button', 'class':'btn btn-danger btn-sm' ,   'text':'<spring:message code="button.delete"/>' , 'onclick' : 'deleteWpUsrAlloc(0,$(this).parent())' })).append('&nbsp;').append(addBTN);
		formTR.append(btnTD);
		
		;
		//add button
		$('#empListForWorkPackageTable tr:last').after( formTR);
		wPakAllocSize++;
		 poulateAvailableHours();
		 validateAllocatedAndEffectiveHours();
		  validateAttendanceAndAllocatedHours();
		  validateTotalPlannedDaysWithTotalAllocatedDays();
		  /* effectiveDistributionPopups(); */
	     $( ".userCombo,.yearCombo,.allocatedDays,.effectiveDays" ).change(function() {
	      poulateAvailableHours();
	      validateAllocatedAndEffectiveHours();
		  validateAttendanceAndAllocatedHours();
		  validateTotalPlannedDaysWithTotalAllocatedDays();
		  /* effectiveDistributionPopups(); */
	     });
	     $( ".userCombo,.yearCombo,.allocatedDays,.effectiveDays" ).blur(function() {
		      //poulateAvailableHours();
		      validateAllocatedAndEffectiveHours();
			  validateAttendanceAndAllocatedHours();
			  validateTotalPlannedDaysWithTotalAllocatedDays();
			  /* effectiveDistributionPopups(); */
		     });
	}

		function addNewWPUallocRow(element) {
			var index = wPakAllocSize;
			//var yearNameTD ='<td><select class="form-control input-sm yearCombo" style="width:55px;" name="workPackageUserAllocations['+index+'].yearName" ><option class="form-control input-sm" value="2017">2017</option><option class="form-control input-sm" value="2018">2018</option><option class="form-control input-sm" value="2019">2019</option><option class="form-control input-sm" value="2020">2020</option></select></td>';
			var yearNameTDStart ='<td><select class="form-control input-sm yearCombo" style="width:72px;" name="workPackageUserAllocations['+index+'].yearName" >';
			var yearNameTdEnd = '</select></td>';
			var optionsAsString = '';
				for (i = startYear; i <= endYear; i++){
				    optionsAsString += '<option value="'+i+'">'+i+'</option>';
				}
			
			var yearNameTD = yearNameTDStart + optionsAsString + yearNameTdEnd ;
			
			var userTD ='<td><select class="form-control input-sm userCombo" name="workPackageUserAllocations['+index+'].user"><c:forEach items="${employeeslist}" var="emp"><option class="form-control input-sm" value="${emp.id}">${emp.firstName}</option> </c:forEach> </select></td>';
			var totalPlannedDaysTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].totalPlannedDays" /></td>';
			var mJanTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJanAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mJan" />&nbsp;<input id="workPackageUserAllocations'+index+'emJan" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emJan" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemJan" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemJan" value="" /></td>';
			var mFebTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mFebAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mFeb" />&nbsp;<input id="workPackageUserAllocations'+index+'emFeb" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emFeb" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemFeb" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemFeb"  value="" /></td>';
			var mMarTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mMarAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mMar" />&nbsp;<input id="workPackageUserAllocations'+index+'emMar" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emMar" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemMar" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemMar" value="" /></td>';
			var mAprTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mAprAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mApr" />&nbsp;<input id="workPackageUserAllocations'+index+'emApr" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emApr" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemApr" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemApr" value="" /></td>';
			var mMayTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mMayAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mMay" />&nbsp;<input id="workPackageUserAllocations'+index+'emMay" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emMay" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemMay" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemMay" value="" /></td>';
			var mJunTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJunAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mJun" />&nbsp;<input id="workPackageUserAllocations'+index+'emJun" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emJun" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemJun" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemJun" value="" /></td>';
			var mJulTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJulAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mJul" />&nbsp;<input id="workPackageUserAllocations'+index+'emJul" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emJul" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemJul" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemJul" value="" /></td>';
			var mAugTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mAugAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mAug" />&nbsp;<input id="workPackageUserAllocations'+index+'emAug" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emAug" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemAug" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemAug" value="" /></td>';
			var mSepTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mSepAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mSep" />&nbsp;<input id="workPackageUserAllocations'+index+'emSep" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emSep" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemSep" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemSep" value="" /></td>';
			var mOctTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mOctAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mOct" />&nbsp;<input id="workPackageUserAllocations'+index+'emOct" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emOct" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemOct" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemOct" value="" /></td>';
			var mNovTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mNovAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mNov" />&nbsp;<input id="workPackageUserAllocations'+index+'emNov" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emNov" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemNov" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemNov" value="" /></td>';
			var mDecTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mDecAvailableHrs" />&nbsp;<input class="form-control input-sm allocatedDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].mDec" />&nbsp;<input id="workPackageUserAllocations'+index+'emDec" class="form-control input-sm effectiveDays" value="0.00" style="width:55px;" name="workPackageUserAllocations['+index+'].emDec" />&nbsp;<input type="hidden" id="workPackageUserAllocations['+index+'].eemDec" class="form-control input-sm effectiveDaysDistribution" style="width:55px;" name="workPackageUserAllocations['+index+'].eemDec" value="" /></td>';
			
			
			var formHtml = yearNameTD+ userTD +totalPlannedDaysTD +mJanTD +mFebTD +mMarTD +mAprTD +mMayTD +mJunTD +mJulTD +mAugTD +mSepTD +mOctTD +mNovTD +mDecTD ;
			var formTR = $('<tr></tr>');
			formTR.append(formHtml);
			//add Button
			var addBTN = $(element).clone();
			$(element).remove();
			
			var btnTD = $('<td></td>').append($('<button/>', { 'type': 'button', 'class':'btn btn-danger btn-sm' ,   'text':'<spring:message code="button.delete"/>' , 'onclick' : 'deleteWpUsrAlloc(0,$(this).parent())' })).append('&nbsp;').append(addBTN);
			formTR.append(btnTD);
			
			;
			//add button
			$('#empListForWorkPackageTable tr:last').after( formTR);
			wPakAllocSize++;
			 poulateAvailableHours();
			 validateAllocatedAndEffectiveHours();
			  validateAttendanceAndAllocatedHours();
			  validateTotalPlannedDaysWithTotalAllocatedDays();
			  /* effectiveDistributionPopups(); */
		     $( ".userCombo,.yearCombo,.allocatedDays,.effectiveDays" ).change(function() {
		      poulateAvailableHours();
		      validateAllocatedAndEffectiveHours();
			  validateAttendanceAndAllocatedHours();
			  validateTotalPlannedDaysWithTotalAllocatedDays();
			  /* effectiveDistributionPopups(); */
		     });
		     $( ".userCombo,.yearCombo,.allocatedDays,.effectiveDays" ).blur(function() {
			      //poulateAvailableHours();
			      validateAllocatedAndEffectiveHours();
				  validateAttendanceAndAllocatedHours();
				  validateTotalPlannedDaysWithTotalAllocatedDays();
				  /* effectiveDistributionPopups(); */
			     });
		}


	function deleteWpUsrAlloc(id, currentTr){
		if(currentTr.parent().is(':last-child')){
			var addBTN = $('<input class="btn btn-primary btn-sm" type="button" name="add" id="add" value="<spring:message code="button.add"/>" onclick="addNewWPUallocRow(this);"/>');
			$( "#empListForWorkPackageTable tr:nth-last-child(2)" ).find('td:last').append(addBTN);
		}
		currentTr.parent().remove();
		wPakAllocSize--;
		if (wPakAllocSize == 0){
			addFirstRow();
			
		}
	}
	

</script>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="workPackage"
			class="form-horizontal">
			<c:choose>
				<c:when test="${edit && projectAndWorkPackageSelected}">
					<div class="well lead col-md-5">
						<spring:message code="workPackage.update.title" />
					</div>
					<div class="well col-md-2">
						<input type="submit" id="updateBtn"
							value="<spring:message code="button.update"/>"
							class="btn btn-primary btn-sm" /> <%-- or <a
							href="<c:url value='/WorkPackage/workPackageslist' />"><spring:message
								code="button.cancel" /></a> --%>
					</div>
				</c:when>
				<c:when test="${edit && !projectAndWorkPackageSelected}">
					<div class="well lead col-md-5">
						<spring:message code="workPackage.update.title" />
					</div>
					<div class="well col-md-2">
						<input disabled type="submit" id="updateBtn"
							value="<spring:message code="button.update"/>"
							class="btn btn-primary btn-sm" /> <%-- or <a
							href="<c:url value='/WorkPackage/workPackageslist' />"><spring:message
								code="button.cancel" /></a> --%>
					</div>
				</c:when>
				
				<c:otherwise>
					<div class="well lead col-md-5">
						<spring:message code="workPackage.add.title" />
					</div>
					<div class="well col-md-2">
						<input type="submit" value="<spring:message code="button.add"/>"
							class="btn btn-primary btn-sm" /> or <a
							href="<c:url value='/WorkPackage/workPackageslist' />"><spring:message
								code="button.cancel" /></a>
					</div>
				</c:otherwise>
			</c:choose>

			<form:input type="hidden" path="id" id="id" />
			
			<input type="hidden" id="selectedProjectNumber" value='${selectedProjectNumber}' />
	
			<input type="hidden" id="selectedWorkPackageNumber" value='${selectedWorkPackageNumber}' />
	
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

			<c:choose>
				<c:when test="${edit && normalUserView}">
					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="project"><spring:message
									code="workPackage.label.projectName" /> </label>
							<div class="col-md-3">
								<%-- <form:input readonly="true"  type="text" path="project.projectName"
							id="project" class="form-control input-sm" /> --%>
								<select class="form-control input-sm"
									name="project" id="projectNamesDropDown">
									<option value="NONE">--------------------------<spring:message code="generic.select.default.option" />--------------------------</option>
									<c:forEach items="${projectsListByUser}" var="proj">
							<%-- 			<option class="form-control input-sm" value="${proj.id}"
											${proj.id == workPackage.project.id  ? 'selected' : ''}>${proj.projectName}</option>
							 --%>		<option class="form-control input-sm" value="${proj.id}"
											${proj.id == selectedProjectNumber  ? 'selected' : ''}>${proj.projectName}</option>
							 	
							 	</c:forEach>
								</select>
								<div class="has-error">
									<form:errors path="project" class="help-inline" />
								</div>
							</div>
							<div class="col-md-3">
								<a id="searchWorkPackagesByProjectNameBtn"
									class="btn btn-success btn-sm "><spring:message code="button.search.workPackages" />
								</a>
							</div>
						</div>
					</div>
					<c:choose>
						<c:when test="${edit && !projectAndWorkPackageSelected && !projectSelected}">
							<div class="row">
								<div class="form-group col-md-12">
									<label class="col-md-2 control-lable" for="workPackageName"><spring:message
											code="workPackage.label.workPackageName" /> </label>
									<div class="col-md-3">
									<form:input  type="hidden" path="workPackageName"
										id="workPackageName" class="form-control input-sm" />
										<select disabled class="form-control input-sm"
											name="workPackageNumber" id="workPackageNamesDropDown">
											<option value="NONE">--------------------------<spring:message code="generic.select.default.option" />--------------------------</option>
											<c:forEach items="${workPackagesListByUser}" var="work">
												<option class="form-control input-sm" value="${work.id}"
													${work.id == workPackage.id  ? 'selected' : ''}>${work.workPackageName}</option>
											</c:forEach>
										</select>
										<div class="has-error">
											<form:errors path="workPackageName" class="help-inline" />
										</div>
									</div>
									<div class="col-md-3">
										<a disabled id="searchByProjectNameAndWorkPackageBtn"
											class="btn btn-success btn-sm "><spring:message code="button.search.workPackages.allocations" />
										</a>
									</div>
								</div>
							</div>
						</c:when>
						<c:when test="${edit && !projectAndWorkPackageSelected && projectSelected || edit && projectAndWorkPackageSelected && !projectSelected}">
							<div class="row">
								<div class="form-group col-md-12">
									<label class="col-md-2 control-lable" for="workPackageName"><spring:message
											code="workPackage.label.workPackageName" /> </label>
									<div class="col-md-3">
										<form:input  type="hidden" path="workPackageName"
										id="workPackageName" class="form-control input-sm" />
										<select class="form-control input-sm"
											name="workPackageNumber" id="workPackageNamesDropDown">
											<option value="NONE">--------------------------<spring:message code="generic.select.default.option" />--------------------------</option>
											<c:forEach items="${workPackagesListByUser}" var="work">
												<option class="form-control input-sm" value="${work.id}"
													${work.id == workPackage.id  ? 'selected' : ''}>${work.workPackageName}</option>
											</c:forEach>
										</select>
										<div class="has-error">
											<form:errors path="workPackageName" class="help-inline" />
										</div>
									</div>
									<div class="col-md-3">
										<a id="searchByProjectNameAndWorkPackageBtn"
											class="btn btn-success btn-sm "><spring:message code="button.search.workPackages.allocations" />
										</a>
									</div>
								</div>
							</div>
						</c:when>
					</c:choose>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="workPackageName"><spring:message
									code="workPackage.label.workPackageName" /> </label>
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
							<label class="col-md-2 control-lable" for="project"><spring:message
									code="workPackage.label.projectName" /> </label>
							<div class="col-md-3">

								<select class="form-control input-sm"
									name="project" id="projectNamesDropDown">
									<option value="NONE">--------------------------<spring:message code="generic.select.default.option" />--------------------------</option>
									<c:forEach items="${projectsListByUser}" var="proj">
										<option class="form-control input-sm" value="${proj.id}"
											${proj.id == workPackage.project.id  ? 'selected' : ''}>${proj.projectName}</option>
									</c:forEach>
								</select>
								<div class="has-error">
									<form:errors path="project" class="help-inline" />
								</div>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>

			<sec:authorize access="hasRole('ADMIN')">
				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-2 control-lable" for="offeredCost"><spring:message
								code="workPackage.label.offeredCost" /> <spring:message
								code="generic.inCurrency" /> </label>
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
						<label class="col-md-2 control-lable" for="totalCost"><spring:message
								code="workPackage.label.totalCost" /> <spring:message
								code="generic.inCurrency" /> </label>
						<div class="col-md-3">
							<form:input type="text" path="totalCost" id="totalCost"
								class="form-control input-sm" readonly="true" />

							<div class="has-error">
								<form:errors path="totalCost" class="help-inline" />
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-2 control-lable" for="effectiveCost">
							<spring:message code="project.label.effectiveCost" /> <spring:message
								code="generic.inCurrency" />
						</label>
						<div class="col-md-3">
							<form:input type="text" path="effectiveCost" id="effectiveCost"
								class="form-control input-sm" readonly="true" />
							<div class="has-error">
								<form:errors path="effectiveCost" class="help-inline" />
							</div>
						</div>
					</div>
				</div>
			</sec:authorize>
			<c:choose>
				<c:when test="${projectAndWorkPackageSelected}">
					<div class="row">
						<div class="form-group col-md-12">
							<div id="empListForWorkPackageTableWrapper">
								<c:choose>
									<c:when test="${edit}">
										<div class="well lead col-md-6">
											<spring:message
												code="workPackage.label.updateEmployeesForThisWorkPackage" />
										</div>
										<%-- <div class="well col-md-2">
						<input type="submit" value="Update" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/WorkPackage/workPackageslist' />">Cancel</a>
					</div> --%>
									</c:when>
									<c:otherwise>
										<div class="well lead col-md-6">
											<spring:message
												code="workPackage.label.addEmployeesForThisWorkPackage" />
										</div>
										<%-- <div class="well col-md-2">
						<input type="submit" value="Add" class="btn btn-primary btn-sm" />
						or <a href="<c:url value='/WorkPackage/workPackageslist' />">Cancel</a>
					</div> --%>
									</c:otherwise>
								</c:choose>
								<table id="empListForWorkPackageTable"
									class="table table-striped table-bordered dt-responsive nowrap"
									cellspacing="0" width="100%">
									<thead>
										<tr>
											<th><spring:message
													code="workPackageUserAllocation.label.year" /></th>
											<th><spring:message
													code="workPackageUserAllocation.label.employeeName" /></th>
											<th><spring:message
													code="workPackageUserAllocation.label.totalPlannedDays" /><br />
												<span style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.jan" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.feb" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.mar" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.apr" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.may" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.jun" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.jul" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.aug" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.sep" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.oct" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.nov" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<th><spring:message
													code="workPackageUserAllocation.label.dec" /><br /> <span
												style="font-size: 0.6em;"><spring:message
														code="generic.inDays" /></span></th>
											<sec:authorize access="hasRole('ADMIN')">
												<th>&nbsp;</th>
											</sec:authorize>
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
														<td><input readonly="readonly"
															class="form-control input-sm" style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].yearName"
															value="${workPackageUserAllocation.yearName}" /></td>
														<td><input type="hidden"
															value="${workPackageUserAllocation.id}"
															name="workPackageUserAllocations[${status.index}].id" />
															<select disabled="disabled"
															class="form-control input-sm userCombo"
															name="workPackageUserAllocations[${status.index}].user">

																<c:forEach items="${employeeslist}" var="emp">

																	<option class="form-control input-sm" value="${emp.id}"
																		${emp.id == workPackageUserAllocation.user.id  ? 'selected' : ''}>${emp.firstName}</option>
																</c:forEach>
														</select>
														<input type="hidden"
															class="form-control input-sm userCombo" style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].user"
															value="${workPackageUserAllocation.user.id}" />
														</td>

														<td><input class="form-control input-sm"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].totalPlannedDays"
															id="workPackageUserAllocations[${status.index}].totalPlannedDays"
															value="${workPackageUserAllocation.totalPlannedDays}" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mJanAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mJan"
															value="${workPackageUserAllocation.mJan}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emJan"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emJan"
															value="${workPackageUserAllocation.emJan}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemJan"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemJan}"
															name="workPackageUserAllocations[${status.index}].eemJan" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mFebAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mFeb"
															value="${workPackageUserAllocation.mFeb}" />&nbsp;<input
															id="workPackageUserAllocation${status.index}emFeb"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emFeb"
															value="${workPackageUserAllocation.emFeb}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemFeb"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemFeb}"
															name="workPackageUserAllocations[${status.index}].eemFeb" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mMarAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mMar"
															value="${workPackageUserAllocation.mMar}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emMar"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emMar"
															value="${workPackageUserAllocation.emMar}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].emMar"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemMar}"
															name="workPackageUserAllocations[${status.index}].eemMar" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mAprAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mApr"
															value="${workPackageUserAllocation.mApr}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emApr"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emApr"
															value="${workPackageUserAllocation.emApr}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemApr"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemApr}"
															name="workPackageUserAllocations[${status.index}].eemApr" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mMayAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mMay"
															value="${workPackageUserAllocation.mMay}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emMay"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emMay"
															value="${workPackageUserAllocation.emMay}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].emMay"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemMay}"
															name="workPackageUserAllocations[${status.index}].eemMay" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mJunAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mJun"
															value="${workPackageUserAllocation.mJun}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emJun"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emJun"
															value="${workPackageUserAllocation.emJun}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemJun"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemJun}"
															name="workPackageUserAllocations[${status.index}].eemJun" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mJulAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mJul"
															value="${workPackageUserAllocation.mJul}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emJul"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emJul"
															value="${workPackageUserAllocation.emJul}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemJul"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemJul}"
															name="workPackageUserAllocations[${status.index}].eemJul" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mAugAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mAug"
															value="${workPackageUserAllocation.mAug}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emAug"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emAug"
															value="${workPackageUserAllocation.emAug}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemAug"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemAug}"
															name="workPackageUserAllocations[${status.index}].eemAug" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mSepAvailableHrs" />&nbsp;<input
															class="form-control input-sm  allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mSep"
															value="${workPackageUserAllocation.mSep}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emSep"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emSep"
															value="${workPackageUserAllocation.emSep}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemSep"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemSep}"
															name="workPackageUserAllocations[${status.index}].eemSep" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mOctAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mOct"
															value="${workPackageUserAllocation.mOct}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emOct"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emOct"
															value="${workPackageUserAllocation.emOct}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemOct"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemOct}"
															name="workPackageUserAllocations[${status.index}].eemOct" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mNovAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mNov"
															value="${workPackageUserAllocation.mNov}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emNov"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emNov"
															value="${workPackageUserAllocation.emNov}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemNov"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemNov}"
															name="workPackageUserAllocations[${status.index}].eemNov" /></td>
														<td><input class="form-control input-sm"
															style="width: 55px;" disabled
															id="workPackageUserAllocations[${status.index}].mDecAvailableHrs" />&nbsp;<input
															class="form-control input-sm allocatedDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].mDec"
															value="${workPackageUserAllocation.mDec}" />&nbsp;<input
															id="workPackageUserAllocations${status.index}emDec"
															class="form-control input-sm effectiveDays"
															style="width: 55px;"
															name="workPackageUserAllocations[${status.index}].emDec"
															value="${workPackageUserAllocation.emDec}" />&nbsp;<input
															type="hidden"
															id="workPackageUserAllocations[${status.index}].eemDec"
															class="form-control input-sm effectiveDaysDistribution"
															style="width: 55px;"
															value="${workPackageUserAllocation.eemDec}"
															name="workPackageUserAllocations[${status.index}].eemDec" /></td>
														<sec:authorize access="hasRole('ADMIN')">
															<td>
																<button type="button" class="btn btn-danger btn-sm"
																	onclick="deleteWpUsrAlloc(${workPackageUserAllocation.id},$(this).parent())">
																	<spring:message code="button.delete" />
																</button>&nbsp; <c:if
																	test="${fn:length(workPackage.workPackageUserAllocations) == status.count}">

																	<input class="btn btn-primary btn-sm" type="button"
																		name="add" id="add"
																		value="<spring:message code="button.add"/>"
																		onclick="addNewWPUallocRow(this);"
																		class="tr_clone_add" />

																</c:if>
															</td>
														</sec:authorize>
														<%-- </tr>
											</c:forEach>
											 --%>
													</tr>
												</c:forEach>
											</c:when>
											<%-- </c:otherwise> --%>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>
			<div id="effectiveDaysDialog"
				style="display: none; font-size: 12px !important;">
				<!-- <table>
					<tr>
						<td></td>
						<td></td>
						<td style="text-align: center;"><label>1</label><input
							title="1" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>2</label><input
							title="2" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>3</label><input
							title="3" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>4</label><input
							title="4" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>5</label><input
							title="5" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
					</tr>
					<tr>
						<td style="text-align: center;"><label>6</label><input
							title="6" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>7</label><input
							title="7" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>8</label><input
							title="8" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>9</label><input
							title="9" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>10</label><input
							title="10" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>11</label><input
							title="11" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>12</label><input
							title="12" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
					</tr>
					<tr>
						<td style="text-align: center;"><label>13</label><input
							title="13" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>14</label><input
							title="14" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>15</label><input
							title="15" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>16</label><input
							title="16" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>17</label><input
							title="17" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>18</label><input
							title="18" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>19</label><input
							title="19" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
					</tr>
					<tr>
						<td style="text-align: center;"><label>20</label><input
							title="20" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>21</label><input
							title="21" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>22</label><input
							title="22" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>23</label><input
							title="23" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>24</label><input
							title="24" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>25</label><input
							title="25" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>26</label><input
							title="26" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
					</tr>
					<tr>
						<td style="text-align: center;"><label>27</label><input
							title="27" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>28</label><input
							title="28" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>29</label><input
							title="29" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>30</label><input
							title="30" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td style="text-align: center;"><label>31</label><input
							title="31" class="calendarTextBoxes" type="text"
							style="width: 42px;" class="form-control input-sm"></td>
						<td></td>
						<td></td>
					</tr>
				</table> -->
			</div>
		</form:form>
	</div>

</body>
</html>
