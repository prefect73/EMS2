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
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>
var userAttendance = new Map();

<c:forEach items="${userAttendancesUpdated}" var="usrAttend">
	userAttendance.set('${usrAttend.user.id}-${usrAttend.yearName}', {'mJan' : '${usrAttend.mJan}' , 'mFeb' : '${usrAttend.mFeb}', 'mMar' : '${usrAttend.mMar}', 'mApr' : '${usrAttend.mApr}', 'mMay' : '${usrAttend.mMay}', 'mJun' : '${usrAttend.mJun}', 'mJul' : '${usrAttend.mJul}', 'mAug' : '${usrAttend.mAug}', 'mSep' : '${usrAttend.mSep}', 'mOct' : '${usrAttend.mOct}', 'mNov' : '${usrAttend.mNov}', 'mDec' : '${usrAttend.mDec}' });
</c:forEach>

	var wPakAllocSize = '<c:out value="${fn:length(workPackage.workPackageUserAllocations)}"/>';
	$( document ).ready(function() {
		  if ($('#empListForWorkPackageTable > tbody > tr').length == 0 || wPakAllocSize == 0 ){
		   addFirstRow();
		  }
		  poulateAvailableHours();
		     $( ".userCombo,.yearCombo" ).change(function() {
		      poulateAvailableHours();
		     });
		  
		 });
	
	function poulateAvailableHours(){
		$( ".userCombo" ).each(function( index , element) {
			
			var yearNameVal = $(element).parent().prev().find('select').val();
		console.log(yearNameVal);	
			var trObj = $(element).parent().parent();
		
		
			///zzz selected value
			var usAtt = userAttendance.get($( element ).val()+"-"+yearNameVal);
			console.log(usAtt);
			console.log(usAtt.mJan);
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
			
			
			});
	}
	
function addFirstRow(){
	var index = wPakAllocSize;
	
	var yearNameTD ='<td><select class="form-control input-sm yearCombo" style="width:55px;" name="workPackageUserAllocations['+index+'].yearName" ><option class="form-control input-sm" value="2017">2017</option><option class="form-control input-sm" value="2018">2018</option><option class="form-control input-sm" value="2019">2019</option><option class="form-control input-sm" value="2020">2020</option></select></td>';
	var userTD ='<td><select class="form-control input-sm userCombo" name="workPackageUserAllocations['+index+'].user"><c:forEach items="${employeeslist}" var="emp"><option class="form-control input-sm" value="${emp.id}">${emp.firstName}</option> </c:forEach> </select></td>';
	var totalPlannedDaysTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].totalPlannedDays" /></td>';
	var mJanTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJanAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJan" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emJan" /></td>';
	var mFebTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mFebAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mFeb" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emFeb" /></td>';
	var mMarTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mMarAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mMar" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emMar" /></td>';
	var mAprTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mAprAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mApr" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emApr" /></td>';
	var mMayTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mMayAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mMay" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emMay" /></td>';
	var mJunTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJunAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJun" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emJun" /></td>';
	var mJulTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJulAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJul" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emJul" /></td>';
	var mAugTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mAugAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mAug" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emAug" /></td>';
	var mSepTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mSepAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mSep" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emSep" /></td>';
	var mOctTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mOctAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mOct" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emOct" /></td>';
	var mNovTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mNovAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mNov" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emNov" /></td>';
	var mDecTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mDecAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mDec" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emDec" /></td>';
	/* var yearNameTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].yearName" /></td>'; */
	
	
	//var formHtml = userTD +mJanTD +mFebTD +mMarTD +mAprTD +mMayTD +mJunTD +mJulTD +mAugTD +mSepTD +mOctTD +mNovTD +mDecTD +yearNameTD;
	var formHtml = yearNameTD +userTD +totalPlannedDaysTD +mJanTD +mFebTD +mMarTD +mAprTD +mMayTD +mJunTD +mJulTD +mAugTD +mSepTD +mOctTD +mNovTD +mDecTD;
	var formTR = $('<tr></tr>');
	formTR.append(formHtml);
	//add Button

	var addBTN = $('<input class="btn btn-primary btn-sm" type="button" name="add" value="<spring:message code="button.add"/>" onclick="addNewWPUallocRow(this);"/>');
	
	
	var btnTD = $('<td></td>').append($('<button/>', { 'type': 'button', 'class':'btn btn-danger btn-sm' ,   'text':'<spring:message code="button.delete"/>' , 'onclick' : 'deleteWpUsrAlloc(0,$(this).parent())' })).append('&nbsp;').append(addBTN);
	formTR.append(btnTD);
	
	;
	//add button
	$('#empListForWorkPackageTable tr:last').after( formTR);
	wPakAllocSize++;
	 poulateAvailableHours();
     $( ".userCombo,.yearCombo" ).change(function() {
      poulateAvailableHours();
     });
}

	function addNewWPUallocRow(element) {
		/* var tr = $(this).closest('.tr_clone_last').clone();

		$(".tr_clone_add").remove();
		tr.insertAfter(".tr_clone_last");
		$(".tr_clone_last").first().removeAttr("class");
		$("input.tr_clone_add").on('click', addHandler); */
		
		 var index = wPakAllocSize;
		 		 
		var yearNameTD ='<td><select class="form-control input-sm yearCombo" style="width:55px;" name="workPackageUserAllocations['+index+'].yearName" ><option class="form-control input-sm" value="2017">2017</option><option class="form-control input-sm" value="2018">2018</option><option class="form-control input-sm" value="2019">2019</option><option class="form-control input-sm" value="2020">2020</option></select></td>';
		var userTD ='<td><select class="form-control input-sm userCombo" name="workPackageUserAllocations['+index+'].user"><c:forEach items="${employeeslist}" var="emp"><option class="form-control input-sm" value="${emp.id}">${emp.firstName}</option> </c:forEach> </select></td>';
		var totalPlannedDaysTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].totalPlannedDays" /></td>';
		var mJanTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJanAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJan" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emJan" /></td>';
		var mFebTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mFebAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mFeb" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emFeb" /></td>';
		var mMarTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mMarAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mMar" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emMar" /></td>';
		var mAprTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mAprAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mApr" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emApr" /></td>';
		var mMayTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mMayAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mMay" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emMay" /></td>';
		var mJunTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJunAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJun" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emJun" /></td>';
		var mJulTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mJulAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJul" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emJul" /></td>';
		var mAugTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mAugAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mAug" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emAug" /></td>';
		var mSepTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mSepAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mSep" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emSep" /></td>';
		var mOctTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mOctAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mOct" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emOct" /></td>';
		var mNovTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mNovAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mNov" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emNov" /></td>';
		var mDecTD ='<td><input class="form-control input-sm" style="width:55px;" disabled id="workPackageUserAllocations['+index+'].mDecAvailableHrs" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mDec" />&nbsp;<input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].emDec" /></td>';

		/* var yearNameTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].yearName" /></td>'; */
		
		
		//var formHtml = userTD +mJanTD +mFebTD +mMarTD +mAprTD +mMayTD +mJunTD +mJulTD +mAugTD +mSepTD +mOctTD +mNovTD +mDecTD +yearNameTD;
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
	     $( ".userCombo,.yearCombo" ).change(function() {
	      poulateAvailableHours();
	     });
	}

	function deleteWpUsrAlloc(id, currentTr){
		if(currentTr.parent().is(':last-child')){
			var addBTN = $('<input class="btn btn-primary btn-sm" type="button" name="add" value="<spring:message code="button.add"/>" onclick="addNewWPUallocRow(this);"/>');
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
				<c:when test="${edit}">
					<div class="well lead col-md-5">
						<spring:message code="workPackage.update.title" />
					</div>
					<div class="well col-md-2">
						<input type="submit"
							value="<spring:message code="button.update"/>"
							class="btn btn-primary btn-sm" /> or <a
							href="<c:url value='/WorkPackage/workPackageslist' />"><spring:message
								code="button.cancel" /></a>
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

						<select class="form-control input-sm" name="project">

							<c:forEach items="${projectslist}" var="proj">
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
							code="workPackage.label.totalCost" />
						<spring:message code="generic.inCurrency" /> </label>
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
											code="workPackageUserAllocation.label.jan" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.feb" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.mar" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.apr" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.may" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.jun" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.jul" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.aug" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.sep" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.oct" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.nov" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									<th><spring:message
											code="workPackageUserAllocation.label.dec" /><br />
									<span style="font-size: 0.6em;"><spring:message
												code="generic.inDays" /></span></th>
									
									<th>&nbsp;</th>
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
												<td><input readonly="readonly" class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].yearName"
													value="${workPackageUserAllocation.yearName}" /></td>
												<td><form:input type="hidden"
														path="workPackageUserAllocations[${status.index}].id" />
														<%--<input readonly="readonly" class="form-control input-sm userCombo"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].user.id"
													value="${workPackageUserAllocation.user.firstName}" />--%>
													 <select  class="form-control input-sm userCombo"
													name="workPackageUserAllocations[${status.index}].user">

														<c:forEach items="${employeeslist}" var="emp">

															<option  class="form-control input-sm" value="${emp.id}"
																${emp.id == workPackageUserAllocation.user.id  ? 'selected' : ''}>${emp.firstName}</option>
														</c:forEach>
												</select> </td>

												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].totalPlannedDays"
													value="${workPackageUserAllocation.totalPlannedDays}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mJanAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mJan"
													value="${workPackageUserAllocation.mJan}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emJan"
													value="${workPackageUserAllocation.emJan}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mFebAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mFeb"
													value="${workPackageUserAllocation.mFeb}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emFeb"
													value="${workPackageUserAllocation.emFeb}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mMarAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mMar"
													value="${workPackageUserAllocation.mMar}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emMar"
													value="${workPackageUserAllocation.emMar}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mAprAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mApr"
													value="${workPackageUserAllocation.mApr}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emApr"
													value="${workPackageUserAllocation.emApr}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mMayAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mMay"
													value="${workPackageUserAllocation.mMay}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emMay"
													value="${workPackageUserAllocation.emMay}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mJunAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mJun"
													value="${workPackageUserAllocation.mJun}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emJun"
													value="${workPackageUserAllocation.emJun}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mJulAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mJul"
													value="${workPackageUserAllocation.mJul}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emJul"
													value="${workPackageUserAllocation.emJul}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mAugAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mAug"
													value="${workPackageUserAllocation.mAug}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emAug"
													value="${workPackageUserAllocation.emAug}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mSepAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mSep"
													value="${workPackageUserAllocation.mSep}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emSep"
													value="${workPackageUserAllocation.emSep}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mOctAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mOct"
													value="${workPackageUserAllocation.mOct}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emOct"
													value="${workPackageUserAllocation.emOct}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mNovAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mNov"
													value="${workPackageUserAllocation.mNov}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emNov"
													value="${workPackageUserAllocation.emNov}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;" disabled
													id="workPackageUserAllocations[${status.index}].mDecAvailableHrs" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mDec"
													value="${workPackageUserAllocation.mDec}" />&nbsp;<input
													class="form-control input-sm" style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].emDec"
													value="${workPackageUserAllocation.emDec}" /></td>
												<td>
													<button type="button" class="btn btn-danger btn-sm"
														onclick="deleteWpUsrAlloc(${workPackageUserAllocation.id},$(this).parent())">
														<spring:message code="button.delete" />
													</button>&nbsp; <c:if
														test="${fn:length(workPackage.workPackageUserAllocations) == status.count}">

														<input class="btn btn-primary btn-sm" type="button"
															name="add" value="<spring:message code="button.add"/>"
															onclick="addNewWPUallocRow(this);" class="tr_clone_add" />

													</c:if>
												</td>
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
		</form:form>
	</div>
</body>
</html>
