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
	var wPakAllocSize = '<c:out value="${fn:length(workPackage.workPackageUserAllocations)}"/>';
	$( document ).ready(function() {
		  if ($('#empListForWorkPackageTable > tbody > tr').length == 0 || wPakAllocSize == 0 ){
		   addFirstRow();
		   
		  }
		  
		 });
function addFirstRow(){
	var index = wPakAllocSize;
	
	var userTD ='<td><select class="form-control input-sm" name="workPackageUserAllocations['+index+'].user"><c:forEach items="${employeeslist}" var="emp"><option class="form-control input-sm" value="${emp.id}">${emp.firstName}</option> </c:forEach> </select></td>';	
	var mJanTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJan" /></td>';
	var mFebTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mFeb" /></td>';
	var mMarTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mMar" /></td>';
	var mAprTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mApr" /></td>';
	var mMayTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mMay" /></td>';
	var mJunTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJun" /></td>';
	var mJulTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJul" /></td>';
	var mAugTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mAug" /></td>';
	var mSepTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mSep" /></td>';
	var mOctTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mOct" /></td>';
	var mNovTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mNov" /></td>';
	var mDecTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mDec" /></td>';
	var yearNameTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].yearName" /></td>';
	
	
	var formHtml = userTD +mJanTD +mFebTD +mMarTD +mAprTD +mMayTD +mJunTD +mJulTD +mAugTD +mSepTD +mOctTD +mNovTD +mDecTD +yearNameTD;
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
}

	function addNewWPUallocRow(element) {
		/* var tr = $(this).closest('.tr_clone_last').clone();

		$(".tr_clone_add").remove();
		tr.insertAfter(".tr_clone_last");
		$(".tr_clone_last").first().removeAttr("class");
		$("input.tr_clone_add").on('click', addHandler); */
		
		 var index = wPakAllocSize;
		
		var userTD ='<td><select class="form-control input-sm" name="workPackageUserAllocations['+index+'].user"><c:forEach items="${employeeslist}" var="emp"><option class="form-control input-sm" value="${emp.id}">${emp.firstName}</option> </c:forEach> </select></td>';	
		var mJanTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJan" /></td>';
		var mFebTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mFeb" /></td>';
		var mMarTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mMar" /></td>';
		var mAprTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mApr" /></td>';
		var mMayTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mMay" /></td>';
		var mJunTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJun" /></td>';
		var mJulTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mJul" /></td>';
		var mAugTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mAug" /></td>';
		var mSepTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mSep" /></td>';
		var mOctTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mOct" /></td>';
		var mNovTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mNov" /></td>';
		var mDecTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].mDec" /></td>';
		var yearNameTD ='<td><input class="form-control input-sm" style="width:55px;" name="workPackageUserAllocations['+index+'].yearName" /></td>';
		
		
		var formHtml = userTD +mJanTD +mFebTD +mMarTD +mAprTD +mMayTD +mJunTD +mJulTD +mAugTD +mSepTD +mOctTD +mNovTD +mDecTD +yearNameTD;
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

			<div class="row">
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
			</div>

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
							code="workPackage.label.offeredCost" /> </label>
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
							code="workPackage.label.totalCost" /> </label>
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
					<div id="empListForWorkPackageTableWrapper" >
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
											code="workPackageUserAllocation.label.employeeName" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.jan" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.feb" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.mar" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.apr" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.may" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.jun" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.jul" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.aug" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.sep" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.oct" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.nov" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.dec" /></th>
									<th><spring:message
											code="workPackageUserAllocation.label.year" /></th>
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

												<td><form:input type="hidden"
														path="workPackageUserAllocations[${status.index}].id" />
													<select class="form-control input-sm"
													name="workPackageUserAllocations[${status.index}].user">

														<c:forEach items="${employeeslist}" var="emp">

															<option class="form-control input-sm" value="${emp.id}"
																${emp.id == workPackageUserAllocation.user.id  ? 'selected' : ''}>${emp.firstName}</option>
														</c:forEach>
												</select></td>

												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mJan"
													value="${workPackageUserAllocation.mJan}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mFeb"
													value="${workPackageUserAllocation.mFeb}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mMar"
													value="${workPackageUserAllocation.mMar}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mApr"
													value="${workPackageUserAllocation.mApr}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mMay"
													value="${workPackageUserAllocation.mMay}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mJun"
													value="${workPackageUserAllocation.mJun}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mJul"
													value="${workPackageUserAllocation.mJul}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mAug"
													value="${workPackageUserAllocation.mAug}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mSep"
													value="${workPackageUserAllocation.mSep}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mOct"
													value="${workPackageUserAllocation.mOct}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mNov"
													value="${workPackageUserAllocation.mNov}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].mDec"
													value="${workPackageUserAllocation.mDec}" /></td>
												<td><input class="form-control input-sm"
													style="width: 55px;"
													name="workPackageUserAllocations[${status.index}].yearName"
													value="${workPackageUserAllocation.yearName}" /></td>
												<td>
													<button type="button" class="btn btn-danger btn-sm"
														onclick="deleteWpUsrAlloc(${workPackageUserAllocation.id},$(this).parent())"><spring:message code="button.delete"/></button>&nbsp;
													<c:if
														test="${fn:length(workPackage.workPackageUserAllocations) == status.count}">

														<input class="btn btn-primary btn-sm" type="button"
															name="add" value="<spring:message code="button.add"/>" onclick="addNewWPUallocRow(this);"
															class="tr_clone_add" />

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
